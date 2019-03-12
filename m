Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ua1-f68.google.com ([209.85.222.68]:40011 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfCLJuL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 12 Mar 2019 05:50:11 -0400
MIME-Version: 1.0
References: <1552360594-21547-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20190312092302.2x6zf4imlfsevmkr@pengutronix.de>
In-Reply-To: <20190312092302.2x6zf4imlfsevmkr@pengutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 12 Mar 2019 10:49:59 +0100
Message-ID: <CAMuHMdUYqk6nFAd2TQ_xM9q3bHskpd8vZXJ8DiF3tFwJQLc=tg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH] pwm: Avoid deadlock warning when removing PWM device
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Thierry Reding <thierry.reding@gmail.com>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Phong Hoang <phong.hoang.wz@renesas.com>

Hi Uwe,

On Tue, Mar 12, 2019 at 10:23 AM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
> On Tue, Mar 12, 2019 at 12:16:34PM +0900, Yoshihiro Shimoda wrote:
> > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > index 1581f6a..2fdd6611 100644
> > --- a/drivers/pwm/core.c
> > +++ b/drivers/pwm/core.c

> > @@ -368,10 +370,12 @@ int pwmchip_remove(struct pwm_chip *chip)
> >
> >       free_pwms(chip);
> >
> > -     pwmchip_sysfs_unexport(chip);
> > -
> >  out:
> >       mutex_unlock(&pwm_lock);
> > +
> > +     if (!ret)
> > +             pwmchip_sysfs_unexport(chip);
> > +
>
> I wonder if this needs to be done before free_pwms is called. Otherwise
> the pwmchip is already gone and then something is requested via sysfs.

The chip itself is not freed, only the pwms array inside, which is not needed
for matching in pwmchip_sysfs_unexport(), right?

> Also a comment about why it is important not to unexport while holding
> the lock would be great.

Thanks, good idea!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
