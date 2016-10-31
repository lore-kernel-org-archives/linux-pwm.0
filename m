From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2 03/10] pwm: imx: Rewrite imx_pwm_*_v1 code to
 facilitate switch to atomic pwm operation
Date: Mon, 31 Oct 2016 10:24:57 +0100
Message-ID: <20161031092457.jzoblljbxya4rbxx@pengutronix.de>
References: <1477549785-4972-1-git-send-email-l.majewski@majess.pl>
 <1477549785-4972-4-git-send-email-l.majewski@majess.pl>
 <20161027094005.2da3b7d4@bbrezillon>
 <20161031055904.av45k535c26gjonz@pengutronix.de>
 <20161031090600.6d56c4a4@jawa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161031090600.6d56c4a4@jawa>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@majess.pl>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>, Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>, Philipp Zabel <pza@pengutronix.de>
List-Id: linux-pwm@vger.kernel.org

On Mon, Oct 31, 2016 at 09:06:00AM +0100, Lukasz Majewski wrote:
> Hi Sascha,
> 
> > On Thu, Oct 27, 2016 at 09:40:05AM +0200, Boris Brezillon wrote:
> > > On Thu, 27 Oct 2016 08:29:39 +0200
> > > Lukasz Majewski <l.majewski@majess.pl> wrote:
> > > 
> > > > The code has been rewritten to remove "generic" calls to
> > > > imx_pwm_{enable|disable|config}.
> > > > 
> > > > Such approach would facilitate switch to atomic PWM (a.k.a
> > > > ->apply()) implementation.
> > > > 
> > > > Suggested-by: Stefan Agner <stefan@agner.ch>
> > > > Suggested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > > Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
> > > > ---
> > > > Changes for v2:
> > > > - Add missing clock unprepare for clk_ipg
> > > > - Enable peripheral PWM clock (clk_per)
> > > > ---
> > > >  drivers/pwm/pwm-imx.c | 50
> > > > ++++++++++++++++++++++++++++++++++++++------------ 1 file
> > > > changed, 38 insertions(+), 12 deletions(-)
> > > > 
> > > > diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> > > > index ea3ce79..822eb5a 100644
> > > > --- a/drivers/pwm/pwm-imx.c
> > > > +++ b/drivers/pwm/pwm-imx.c
> > > > @@ -65,8 +65,6 @@ struct imx_chip {
> > > >  static int imx_pwm_config_v1(struct pwm_chip *chip,
> > > >  		struct pwm_device *pwm, int duty_ns, int
> > > > period_ns) {
> > > > -	struct imx_chip *imx = to_imx_chip(chip);
> > > > -
> > > >  	/*
> > > >  	 * The PWM subsystem allows for exact frequencies.
> > > > However,
> > > >  	 * I cannot connect a scope on my device to the PWM line
> > > > and @@ -84,26 +82,56 @@ static int imx_pwm_config_v1(struct
> > > > pwm_chip *chip,
> > > >  	 * both the prescaler (/1 .. /128) and then by CLKSEL
> > > >  	 * (/2 .. /16).
> > > >  	 */
> > > > +	struct imx_chip *imx = to_imx_chip(chip);
> > > >  	u32 max = readl(imx->mmio_base + MX1_PWMP);
> > > >  	u32 p = max * duty_ns / period_ns;
> > > > +	int ret;
> > > > +
> > > > +	ret = clk_prepare_enable(imx->clk_ipg);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > >  	writel(max - p, imx->mmio_base + MX1_PWMS);
> > > >  
> > > > +	clk_disable_unprepare(imx->clk_ipg);
> > > > +
> > > >  	return 0;
> > > >  }
> > > >  
> > > > -static void imx_pwm_set_enable_v1(struct pwm_chip *chip, bool
> > > > enable) +static int imx_pwm_enable_v1(struct pwm_chip *chip,
> > > > struct pwm_device *pwm) {
> > > >  	struct imx_chip *imx = to_imx_chip(chip);
> > > > +	int ret;
> > > >  	u32 val;
> > > >  
> > > > +	ret = clk_prepare_enable(imx->clk_ipg);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ret = clk_prepare_enable(imx->clk_per);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > >  	val = readl(imx->mmio_base + MX1_PWMC);
> > > > +	val |= MX1_PWMC_EN;
> > > > +	writel(val, imx->mmio_base + MX1_PWMC);
> > > >  
> > > > -	if (enable)
> > > > -		val |= MX1_PWMC_EN;
> > > > -	else
> > > > -		val &= ~MX1_PWMC_EN;
> > > > +	clk_disable_unprepare(imx->clk_ipg);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static void imx_pwm_disable_v1(struct pwm_chip *chip, struct
> > > > pwm_device *pwm) +{
> > > > +	struct imx_chip *imx = to_imx_chip(chip);
> > > > +	u32 val;
> > > > +
> > > > +	val = readl(imx->mmio_base + MX1_PWMC);
> > > > +	val &= ~MX1_PWMC_EN;
> > > >  
> > > >  	writel(val, imx->mmio_base + MX1_PWMC);
> > > 
> > > Are you sure you don't need to enable the ipg clk when manipulating
> > > the PWMC register?
> > > If it's not needed here, then it's probably not needed in
> > > imx_pwm_enable_v1() either.
> > 
> > As said, even the commit 7b27c160c68 introducing the register clk did
> > not enable the clock consistently for all register accesses. 
> 
> If I might ask - do you have i.MX hardware with PWMv1? If yes, I would
> be grateful for testing (and provide proper patch), since I don't posses
> one.

PWMv1 is only found on i.MX1. While I indeed have hardware for this I
don't want to spend the time to blow the dust from it and search for a
PWM output pin on that.
BTW. i.MX1 does not have a real ipg clock, the dts file registers the
dummy clock for it. So on PWMv1 hardware the ipg clock is not needed for
sure.


> 
> > Maybe
> > it's best to include the following patch so that we can find a clear
> > culprit 
> 
> If we don't have HW to test the solution - why should we apply this
> patch and introduce regression?

The current state does not handle the ipg clock properly, it's broken
already. So it's probably better to remove the inconsistent code rather
than to keep it and to introduce regressions step by step and in the end
leaving the question "How could this ever have worked"?

> 
> 
> 
> If you can provide (and test) fix for v1 - please prepare patch, so it
> could be added on top of this patch series (as done with pwm polarity
> inversion in this patch series).

As said, PWMv1 does not need the ipg clock.

> >  static int imx_pwm_enable(struct pwm_chip *chip, struct pwm_device
> > *pwm) @@ -293,13 +283,6 @@ static int imx_pwm_probe(struct
> > platform_device *pdev) return PTR_ERR(imx->clk_per);
> >  	}
> >  
> > -	imx->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
> > -	if (IS_ERR(imx->clk_ipg)) {
> > -		dev_err(&pdev->dev, "getting ipg clock failed with
> > %ld\n",
> > -				PTR_ERR(imx->clk_ipg));
> > -		return PTR_ERR(imx->clk_ipg);
> > -	}
> 
> And in that way also v2 would be affected.
> 
> My gut feeling now is that the "community" wants to solve too many
> issues with PWM atomic support rework.

I provided this patch with the assumption that you integrate it in your
series. It facilitates your series because with it you no longer have to
try to keep code working that hasn't worked before already.

> 
> Why cannot we add patches on top of already done work, but require
> large patch series to be rewritten and resend ?

You can, but that only works when the maintainer already has accepted
the patches you depend on, which currently he hasn't. If for some reason
the maintainer doesn't accept the patches you depend on, then you'll
have to rework your series aswell. It might also be simple enough for
the maintainer to merge both series rather than building one upon the
other.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
