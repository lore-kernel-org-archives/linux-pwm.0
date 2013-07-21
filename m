Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v4 13/20] pwm: Add new pwm-samsung driver
Date: Sun, 21 Jul 2013 23:58:04 +0200
Message-ID: <4551618.l5Bs8czD9o@flatron>
In-Reply-To: <51EC3B97.3040107@gmail.com>
References: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com> <1374278673-25615-15-git-send-email-tomasz.figa@gmail.com> <51EC3B97.3040107@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pwm.vger.kernel.org>
To: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>

On Sunday 21 of July 2013 21:50:47 Sylwester Nawrocki wrote:
> On 07/20/2013 02:04 AM, Tomasz Figa wrote:
> > This patch introduces new Samsung PWM driver, which uses Samsung
> > PWM/timer master driver to control shared parts of the hardware.
> > 
> > Signed-off-by: Tomasz Figa<tomasz.figa@gmail.com>
> > ---
> > 
> >   drivers/pwm/Makefile      |   1 +
> >   drivers/pwm/pwm-samsung.c | 606
> >   ++++++++++++++++++++++++++++++++++++++++++++++ 2 files changed, 607
> >   insertions(+)
> >   create mode 100644 drivers/pwm/pwm-samsung.c
> 
> [...]
> 
> > +static const struct samsung_pwm_variant s3c64xx_variant = {
> > +	.bits		= 32,
> > +	.div_base	= 0,
> 
> Initialization to 0 could be omitted, since it is implicit.

Well, I'd prefer keeping this as is, for clarity. It improves code 
readability, because you don't have to look at struct definition to see 
all the fields.

> > +	.has_tint_cstat	= true,
> > +	.tclk_mask	= BIT(7) | BIT(6) | BIT(5),
> > +};
> > +
> > +static const struct samsung_pwm_variant s5p64x0_variant = {
> > +	.bits		= 32,
> > +	.div_base	= 0,
> 
> Ditto.
> 
> > +	.has_tint_cstat	= true,
> > +};
> > +
> > +static const struct samsung_pwm_variant s5p_variant = {
> > +	.bits		= 32,
> > +	.div_base	= 0,
> 
> Ditto.
> 
> > +	.has_tint_cstat	= true,
> > +	.tclk_mask	= BIT(5),
> > +};
> > +
> 
> [...]
> 
> > +static int pwm_samsung_remove(struct platform_device *pdev)
> > +{
> > +	struct samsung_pwm_chip *chip = platform_get_drvdata(pdev);
> > +	int ret;
> > +
> > +	ret = pwmchip_remove(&chip->chip);
> > +	if (ret < 0)
> > +		return ret;
> 
> Since return value of the remove() callback is happily ignored by
> the driver core I think there is no point in returning an error
> here like this. Wouldn't it be more sensible to just call all the
> cleanup functions unconditionally ? At least potentially wrong state
> of the clock could be avoided.

IMHO handling the errors correctly here is more future-proof. Driver core 
might be modified to handle errors in future and this driver will not need 
to be modified.

Best regards,
Tomasz
