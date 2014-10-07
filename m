From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v8 1/2] pwm: add support for atmel-hlcdc-pwm device
Date: Tue, 7 Oct 2014 11:14:11 +0200
Message-ID: <20141007111411.57448c57@bbrezillon>
References: <1412604423-19329-1-git-send-email-boris.brezillon@free-electrons.com>
	<1412604423-19329-2-git-send-email-boris.brezillon@free-electrons.com>
	<20141007084514.GE24254@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:60614 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753194AbaJGJOO (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Oct 2014 05:14:14 -0400
In-Reply-To: <20141007084514.GE24254@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org

On Tue, 7 Oct 2014 10:45:16 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Mon, Oct 06, 2014 at 04:07:02PM +0200, Boris Brezillon wrote:
> > The HLCDC IP available in some Atmel SoCs (i.e. sam9x5i.e. at91sam9n12,
> > at91sam9x5 family or sama5d3 family) provide a PWM device.
> > 
> > This driver add support for a PWM chip exposing a single PWM device (which
> > will most likely be used to drive a backlight device).
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > Tested-by: Anthony Harivel <anthony.harivel@emtrion.de>
> > Tested-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > Acked-by: Thierry Reding <thierry.reding@gmail.com>
> > ---
> >  drivers/pwm/Kconfig           |   9 ++
> >  drivers/pwm/Makefile          |   1 +
> >  drivers/pwm/pwm-atmel-hlcdc.c | 248 ++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 258 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-atmel-hlcdc.c
> 
> Just noticed a couple more things.
> 
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index b800783..9bb331b 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -50,6 +50,15 @@ config PWM_ATMEL
> >  	  To compile this driver as a module, choose M here: the module
> >  	  will be called pwm-atmel.
> >  
> > +config PWM_ATMEL_HLCDC_PWM
> > +	tristate "Atmel HLCDC PWM support"
> > +	select MFD_ATMEL_HLCDC
> > +	help
> > +	  Generic PWM framework driver for Atmel HLCDC PWM.
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called pwm-atmel.
> 
> This should be "pwm-atmel-hlcdc".

Absolutely, I'll fix that.

> 
> > diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
> [...]
> > +static int atmel_hlcdc_pwm_enable(struct pwm_chip *c, struct pwm_device *pwm)
> > +{
> > +	struct atmel_hlcdc_pwm *chip = to_atmel_hlcdc_pwm(c);
> > +	struct atmel_hlcdc *hlcdc = chip->hlcdc;
> > +	u32 status;
> > +	int ret;
> > +
> > +	regmap_write(hlcdc->regmap, ATMEL_HLCDC_EN, ATMEL_HLCDC_PWM);
> 
> I just noticed that regmap_write() can also fail. But perhaps that's
> only for I2C or the like backends and you can indeed ignore it for MMIO
> backends.

Checking for errors is always a good thing (even if in this case,
there's no reason it should fail).

> 
> > +	do {
> > +		usleep_range(1, 10);
> > +		ret = regmap_read(hlcdc->regmap, ATMEL_HLCDC_SR, &status);
> > +		if (ret)
> > +			return ret;
> > +	} while ((status & ATMEL_HLCDC_PWM) == 0);
> 
> A slightly better loop might be to do the sleep only after you've
> determined that the status bit isn't set. That way you avoid a needless
> sleep if the status bit is immediately set or an error occurs during
> read.
> 
> 	while (true) {
> 		ret = regmap_read(...);
> 		if (ret)
> 			return ret;
> 
> 		if (status & ATMEL_HLCDC_PWM)
> 			break;
> 
> 		usleep_range(1, 10);
> 	}

Absolutely, I'll use this code chunk in place of the previous one.

> 
> > +static int atmel_hlcdc_pwm_remove(struct platform_device *pdev)
> > +{
> > +	struct atmel_hlcdc_pwm *chip = platform_get_drvdata(pdev);
> > +	int ret;
> > +
> > +	ret = pwmchip_remove(&chip->chip);
> > +	if (ret)
> > +		return ret;
> > +
> > +	clk_disable_unprepare(chip->hlcdc->periph_clk);
> 
> You might want to call clk_disable_unprepare() regardless of whether or
> not pwmchip_remove() failed. You could simply leave out the above check
> for ret and instead...

Are you sure of this one, if pwmchip_remove fails, then the PWM chip
might still be used. And if we disable the clock the PWM chip won't work
anymore.

Best Regards,

Boris



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
