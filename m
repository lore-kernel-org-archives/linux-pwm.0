Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ua1-f68.google.com ([209.85.222.68]:40005 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727515AbfCLIis (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 12 Mar 2019 04:38:48 -0400
MIME-Version: 1.0
References: <1552360594-21547-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1552360594-21547-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 12 Mar 2019 09:38:35 +0100
Message-ID: <CAMuHMdU9sCKnyz=qHKDdP1YHM+qGoZrkYAVJwYcJ5O7c=LHTjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH] pwm: Avoid deadlock warning when removing PWM device
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Phong Hoang <phong.hoang.wz@renesas.com>

Hi Shimoda-san,

On Tue, Mar 12, 2019 at 4:17 AM Yoshihiro Shimoda
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
>
> [   87.659974] ======================================================
> [   87.666149] WARNING: possible circular locking dependency detected
> [   87.672327] 5.0.0 #7 Not tainted

[...]

> This warning occurs because pwmchip_remove still keeps pwm_lock
> when removing sysfs. That's why it leads to that conflict.
> Hence, this patch unlocks pwm_lock before removing sysfs.
> Also, pwmchip_sysfs_export() doesn't seem to need the pwm_lock
> held so that to achieve consistance between export and
> unexport this patch also modifies it.
>
> Signed-off-by: Phong Hoang <phong.hoang.wz@renesas.com>
> [shimoda: revise the commit log and code]
> Fixes: 76abbdde2d95 ("pwm: Add sysfs interface")
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Tested-by: Hoan Nguyen An <na-hoan@jinso.co.jp>

Thanks for your patch!

Looks good to me: class_find_device() seems to use its own locking in
the class to protect against concurrent modification.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
