From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] backlight: pwm_bl: Fix GPIO out for unimplemented
 .get_direction()
Date: Mon, 27 Mar 2017 15:27:40 +0100
Message-ID: <20170327142740.kz74sy56zpup5zgu@dell>
References: <1490203285-28324-1-git-send-email-geert+renesas@glider.be>
 <c00f689f-dae6-14d6-55d3-b1b44db19dc1@linaro.org>
 <6960ceea-5e34-3435-eecb-10e18322b15c@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:36187 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753465AbdC0O2B (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Mar 2017 10:28:01 -0400
Received: by mail-lf0-f47.google.com with SMTP id x137so22721684lff.3
        for <linux-pwm@vger.kernel.org>; Mon, 27 Mar 2017 07:27:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <6960ceea-5e34-3435-eecb-10e18322b15c@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Thierry Reding <thierry.reding@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Philipp Zabel <p.zabel@pengutronix.de>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 24 Mar 2017, Daniel Thompson wrote:

> On 24/03/17 16:42, Daniel Thompson wrote:
> > On 22/03/17 17:21, Geert Uytterhoeven wrote:
> > > Commit 7613c922315e308a ("backlight: pwm_bl: Move the checks for initial
> > > power state to a separate function") not just moved some code, but made
> > > slight changes in semantics.
> > > 
> > > If a gpiochip doesn't implement the optional .get_direction() callback,
> > > gpiod_get_direction always returns -EINVAL, which is never equal to
> > > GPIOF_DIR_IN, leading to the GPIO not being configured for output.
> > > 
> > > To avoid this, invert the test and check for not GPIOF_DIR_OUT instead,
> > > like the original code did.
> > > 
> > > This restores the display on r8a7740/armadillo.
> > > 
> > > Fixes: 7613c922315e308a ("backlight: pwm_bl: Move the checks for
> > > initial power state to a separate function")
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > 
> > Acked-by: Daniel Thommpson <daniel.thompson@linaro.org>
> 
> Actually, it would be better if there only one m...
> 
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

You probably don't want to be typing out your Acks manually every
time.  Can you set a key combination in your editor?

> > > ---
> > >  drivers/video/backlight/pwm_bl.c | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/video/backlight/pwm_bl.c
> > > b/drivers/video/backlight/pwm_bl.c
> > > index d7efcb632f7d9dde..002f1ce22bd02032 100644
> > > --- a/drivers/video/backlight/pwm_bl.c
> > > +++ b/drivers/video/backlight/pwm_bl.c
> > > @@ -297,14 +297,15 @@ static int pwm_backlight_probe(struct
> > > platform_device *pdev)
> > >      }
> > > 
> > >      /*
> > > -     * If the GPIO is configured as input, change the direction to
> > > output
> > > -     * and set the GPIO as active.
> > > +     * If the GPIO is not known to be already configured as output, that
> > > +     * is, if gpiod_get_direction returns either GPIOF_DIR_IN or
> > > -EINVAL,
> > > +     * change the direction to output and set the GPIO as active.
> > >       * Do not force the GPIO to active when it was already output as it
> > >       * could cause backlight flickering or we would enable the
> > > backlight too
> > >       * early. Leave the decision of the initial backlight state for
> > > later.
> > >       */
> > >      if (pb->enable_gpio &&
> > > -        gpiod_get_direction(pb->enable_gpio) == GPIOF_DIR_IN)
> > > +        gpiod_get_direction(pb->enable_gpio) != GPIOF_DIR_OUT)
> > >          gpiod_direction_output(pb->enable_gpio, 1);
> > > 
> > >      pb->power_supply = devm_regulator_get(&pdev->dev, "power");
> > > 
> > 
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
