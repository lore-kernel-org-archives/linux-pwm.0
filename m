Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ua1-f67.google.com ([209.85.222.67]:39534 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfCMJEp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 13 Mar 2019 05:04:45 -0400
MIME-Version: 1.0
References: <1552465792-25340-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1552465792-25340-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 13 Mar 2019 10:04:32 +0100
Message-ID: <CAMuHMdUZ9eSifsaV9ohpcy-a8cknbGRrBriFWF+Rcv6gmCOdcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH v2] pwm: Fix deadlock warning when removing PWM device
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Phong Hoang <phong.hoang.wz@renesas.com>

Hi Shimoda-san,

On Wed, Mar 13, 2019 at 9:30 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> From: Phong Hoang <phong.hoang.wz@renesas.com>
>
> This patch fixes deadlock warning if removing PWM device
> when CONFIG_PROVE_LOCKING is enabled.
>
> This issue can be reproceduced by the following steps on
> the R-Car H3 Salvator-X board if the backlight is disabled:
>
>  # cd /sys/class/pwm/pwmchip0
>  # echo 0 > export
>  # ls
>  device  export  npwm  power  pwm0  subsystem  uevent  unexport
>  # cd device/driver
>  # ls
>  bind  e6e31000.pwm  uevent  unbind
>  # echo e6e31000.pwm > unbind

[...]

> The sysfs unexport in pwmchip_remove() is completely asymmetric
> to what we do in pwmchip_add_with_polarity() and commit 0733424c9ba9
> ("pwm: Unexport children before chip removal") is a strong indication
> that this was wrong to begin with. We should just move
> pwmchip_sysfs_unexport() where it belongs, which is right after
> pwmchip_sysfs_unexport_children(). In that case, we do not need
> separate functions anymore either.
>
> We also really want to remove sysfs irrespective of whether or not
> the chip will be removed as a result of pwmchip_remove(). We can only
> assume that the driver will be gone after that, so we shouldn't leave
> any dangling sysfs files around.
>
> This warning disappears if we move pwmchip_sysfs_unexport() to
> the top of pwmchip_remove(), right below pwmchip_sysfs_unexport_children().

Drop the "right below..." part, as pwmchip_sysfs_unexport_children() is gone?

> That way it is also outside of the pwm_lock section, which indeed
> doesn't seem to be needed.
>
> Moving the pwmchip_sysfs_export() call outside of that section also
> seems fine and it'd be perfectly symmetric with pwmchip_remove() again.
>
> So, this patch fixes them.
>
> Signed-off-by: Phong Hoang <phong.hoang.wz@renesas.com>
> [shimoda: revise the commit log and code]
> Fixes: 76abbdde2d95 ("pwm: Add sysfs interface")
> Fixes: 0733424c9ba9 ("pwm: Unexport children before chip removal")
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Tested-by: Hoan Nguyen An <na-hoan@jinso.co.jp>
> ---
>  Changes from v1 (https://patchwork.kernel.org/patch/10848567/):
>  - Change the subject from "Avoid" to "Fix".
>  - Merge pwmchip_sysfs_unexport_children()'s code into
>    pwmchip_sysfs_unexport() and move pwmchip_sysfs_unexport() to
>    the top of pwmchip_remove().
>  - Revise the commit log that is reffered from Therry's comments [1]
>    because it seems very clear to me.
>  - Add Fixes tag about the commit 0733424c9ba9.
>  - I got Geert's Reviewed-by on v1 patch, but I'm not sure
>    I can add the Reviewed-by because v2 patch changes a bit.
>    So, I didn't add the Reviewed-by tag.

Thanks for the update!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c

> --- a/drivers/pwm/sysfs.c
> +++ b/drivers/pwm/sysfs.c
> @@ -411,36 +411,24 @@ void pwmchip_sysfs_export(struct pwm_chip *chip)
>  void pwmchip_sysfs_unexport(struct pwm_chip *chip)
>  {
>         struct device *parent;
> +       unsigned int i;
>
>         parent = class_find_device(&pwm_class, NULL, chip,
>                                    pwmchip_sysfs_match);
>         if (parent) {

Perhaps "if (!parent) return", like pwmchip_sysfs_unexport_children()
used to do?

That way the reviewer has less context to store, indentation is
decreased, and the resulting diff may be smaller.

> +               for (i = 0; i < chip->npwm; i++) {
> +                       struct pwm_device *pwm = &chip->pwms[i];
> +
> +                       if (test_bit(PWMF_EXPORTED, &pwm->flags))
> +                               pwm_unexport_child(parent, pwm);
> +               }
> +
>                 /* for class_find_device() */
>                 put_device(parent);
>                 device_unregister(parent);
>         }
>  }
>
> -void pwmchip_sysfs_unexport_children(struct pwm_chip *chip)
> -{
> -       struct device *parent;
> -       unsigned int i;
> -
> -       parent = class_find_device(&pwm_class, NULL, chip,
> -                                  pwmchip_sysfs_match);
> -       if (!parent)
> -               return;
> -
> -       for (i = 0; i < chip->npwm; i++) {
> -               struct pwm_device *pwm = &chip->pwms[i];
> -
> -               if (test_bit(PWMF_EXPORTED, &pwm->flags))
> -                       pwm_unexport_child(parent, pwm);
> -       }
> -
> -       put_device(parent);
> -}

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
