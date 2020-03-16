From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/3] pwm: rcar: Fix late Runtime PM enablement
Date: Mon, 16 Mar 2020 16:57:39 +0100
Message-ID: <20200316155739.3yr4ejpgskgn5ypl@pengutronix.de>
References: <20200316103216.29383-1-geert+renesas@glider.be>
 <20200316103216.29383-2-geert+renesas@glider.be>
 <20200316154008.e4yfe2bdeuju5e4g@pengutronix.de>
 <CAMuHMdURCdwZD+FT3jxFzrZEwaMsZpp6HcD3_CwtFBq8E72vyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60533 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731687AbgCPP5o (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Mar 2020 11:57:44 -0400
Content-Disposition: inline
In-Reply-To: <CAMuHMdURCdwZD+FT3jxFzrZEwaMsZpp6HcD3_CwtFBq8E72vyA@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, kernel@pengutronix.de

Hello Geert,

On Mon, Mar 16, 2020 at 04:42:31PM +0100, Geert Uytterhoeven wrote:
> On Mon, Mar 16, 2020 at 4:40 PM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Mon, Mar 16, 2020 at 11:32:14AM +0100, Geert Uytterhoeven wrote:
> > > Runtime PM should be enabled before calling pwmchip_add(), as PWM users
> > > can appear immediately after the PWM chip has been added.
> > > Likewise, Runtime PM should be disabled after the removal of the PWM
> > > chip.
> > >
> > > Fixes: ed6c1476bf7f16d5 ("pwm: Add support for R-Car PWM Timer")
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > >  drivers/pwm/pwm-rcar.c | 10 +++++++---
> > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
> > > index 2685577b6dd45be7..7ab9eb6616d950cb 100644
> > > --- a/drivers/pwm/pwm-rcar.c
> > > +++ b/drivers/pwm/pwm-rcar.c
> > > @@ -229,24 +229,28 @@ static int rcar_pwm_probe(struct platform_device *pdev)
> > >       rcar_pwm->chip.base = -1;
> > >       rcar_pwm->chip.npwm = 1;
> > >
> > > +     pm_runtime_enable(&pdev->dev);
> > > +
> > >       ret = pwmchip_add(&rcar_pwm->chip);
> > >       if (ret < 0) {
> > >               dev_err(&pdev->dev, "failed to register PWM chip: %d\n", ret);
> > > +             pm_runtime_disable(&pdev->dev);
> > >               return ret;
> > >       }
> > >
> > > -     pm_runtime_enable(&pdev->dev);
> > > -
> >
> > Wouldn't it be wiser to do the pm_runtime_enable in .request, or even in
> > .apply when enabled=true?
> 
> Wouldn't that mean that the device cannot be powered down until the first
> time a PWM is used?

Ah, it seems I got the semantic of pm_runtime_enable() wrong. I confused
it with pm_runtime_get(). Now with that corrected your fix is obviously
right:

Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
