Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45508 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfEaHek (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 31 May 2019 03:34:40 -0400
MIME-Version: 1.0
References: <1559211367-25106-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1559211367-25106-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1559211367-25106-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 31 May 2019 09:34:25 +0200
Message-ID: <CAMuHMdXVVOvoZ4S9LC=RD_8r-XJ6tPt512rONjv8QEK0L=akww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH v2 3/4] pwm: sysfs: Add suspend/resume support
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Shimoda-san,

On Thu, May 30, 2019 at 12:21 PM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> According to the Documentation/pwm.txt, all PWM consumers should have
> power management. Since this sysfs interface is one of consumers so that
> this patch adds suspend/resume support.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/pwm/sysfs.c
> +++ b/drivers/pwm/sysfs.c

> @@ -372,10 +373,109 @@ static struct attribute *pwm_chip_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(pwm_chip);
>

You may want to add a comment "takes export->lock on success" here...

> +static struct pwm_export *pwm_class_get_state(struct device *parent,
> +                                             struct pwm_device *pwm,
> +                                             struct pwm_state *state)
> +{
> +       struct device *child;
> +       struct pwm_export *export;
> +
> +       if (!test_bit(PWMF_EXPORTED, &pwm->flags))
> +               return NULL;
> +
> +       child = device_find_child(parent, pwm, pwm_unexport_match);
> +       if (!child)
> +               return NULL;
> +
> +       export = child_to_pwm_export(child);
> +       put_device(child);      /* for device_find_child() */
> +
> +       mutex_lock(&export->lock);
> +       pwm_get_state(pwm, state);
> +
> +       return export;
> +}
> +
> +static int pwm_class_apply_state(struct pwm_export *export,
> +                                struct pwm_device *pwm,
> +                                struct pwm_state *state)
> +{
> +       int ret = pwm_apply_state(pwm, state);
> +

... and "release lock taken in pwm_class_get_state()" here.

> +       mutex_unlock(&export->lock);
> +
> +       return ret;
> +}

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
