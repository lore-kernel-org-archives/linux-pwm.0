From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2 03/10] pwm: imx: Rewrite imx_pwm_*_v1 code to
 facilitate switch to atomic pwm operation
Date: Mon, 31 Oct 2016 10:29:37 +0100
Message-ID: <20161031092937.im5epytgorcd5fbm@pengutronix.de>
References: <1477549785-4972-1-git-send-email-l.majewski@majess.pl>
 <1477549785-4972-4-git-send-email-l.majewski@majess.pl>
 <20161027094005.2da3b7d4@bbrezillon>
 <20161031055904.av45k535c26gjonz@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161031055904.av45k535c26gjonz@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>, Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>, Philipp Zabel <pza@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>
List-Id: linux-pwm@vger.kernel.org

On Mon, Oct 31, 2016 at 06:59:04AM +0100, Sascha Hauer wrote:
> On Thu, Oct 27, 2016 at 09:40:05AM +0200, Boris Brezillon wrote:
> > On Thu, 27 Oct 2016 08:29:39 +0200
> > Lukasz Majewski <l.majewski@majess.pl> wrote:
> > 
> > > The code has been rewritten to remove "generic" calls to
> > > imx_pwm_{enable|disable|config}.
> > > 
> > > Such approach would facilitate switch to atomic PWM (a.k.a ->apply())
> > > implementation.
> > > 
> > > Suggested-by: Stefan Agner <stefan@agner.ch>
> > > Suggested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
> > > ---
> > > Changes for v2:
> > > - Add missing clock unprepare for clk_ipg
> > > - Enable peripheral PWM clock (clk_per)
> > > ---
> > >  drivers/pwm/pwm-imx.c | 50 ++++++++++++++++++++++++++++++++++++++------------
> > >  1 file changed, 38 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> > > index ea3ce79..822eb5a 100644
> > > --- a/drivers/pwm/pwm-imx.c
> > > +++ b/drivers/pwm/pwm-imx.c
> > > @@ -65,8 +65,6 @@ struct imx_chip {
> > >  static int imx_pwm_config_v1(struct pwm_chip *chip,
> > >  		struct pwm_device *pwm, int duty_ns, int period_ns)
> > >  {
> > > -	struct imx_chip *imx = to_imx_chip(chip);
> > > -
> > >  	/*
> > >  	 * The PWM subsystem allows for exact frequencies. However,
> > >  	 * I cannot connect a scope on my device to the PWM line and
> > > @@ -84,26 +82,56 @@ static int imx_pwm_config_v1(struct pwm_chip *chip,
> > >  	 * both the prescaler (/1 .. /128) and then by CLKSEL
> > >  	 * (/2 .. /16).
> > >  	 */
> > > +	struct imx_chip *imx = to_imx_chip(chip);
> > >  	u32 max = readl(imx->mmio_base + MX1_PWMP);
> > >  	u32 p = max * duty_ns / period_ns;
> > > +	int ret;
> > > +
> > > +	ret = clk_prepare_enable(imx->clk_ipg);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > >  	writel(max - p, imx->mmio_base + MX1_PWMS);
> > >  
> > > +	clk_disable_unprepare(imx->clk_ipg);
> > > +
> > >  	return 0;
> > >  }
> > >  
> > > -static void imx_pwm_set_enable_v1(struct pwm_chip *chip, bool enable)
> > > +static int imx_pwm_enable_v1(struct pwm_chip *chip, struct pwm_device *pwm)
> > >  {
> > >  	struct imx_chip *imx = to_imx_chip(chip);
> > > +	int ret;
> > >  	u32 val;
> > >  
> > > +	ret = clk_prepare_enable(imx->clk_ipg);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = clk_prepare_enable(imx->clk_per);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > >  	val = readl(imx->mmio_base + MX1_PWMC);
> > > +	val |= MX1_PWMC_EN;
> > > +	writel(val, imx->mmio_base + MX1_PWMC);
> > >  
> > > -	if (enable)
> > > -		val |= MX1_PWMC_EN;
> > > -	else
> > > -		val &= ~MX1_PWMC_EN;
> > > +	clk_disable_unprepare(imx->clk_ipg);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void imx_pwm_disable_v1(struct pwm_chip *chip, struct pwm_device *pwm)
> > > +{
> > > +	struct imx_chip *imx = to_imx_chip(chip);
> > > +	u32 val;
> > > +
> > > +	val = readl(imx->mmio_base + MX1_PWMC);
> > > +	val &= ~MX1_PWMC_EN;
> > >  
> > >  	writel(val, imx->mmio_base + MX1_PWMC);
> > 
> > Are you sure you don't need to enable the ipg clk when manipulating the
> > PWMC register?
> > If it's not needed here, then it's probably not needed in
> > imx_pwm_enable_v1() either.
> 
> As said, even the commit 7b27c160c68 introducing the register clk did not
> enable the clock consistently for all register accesses. Maybe it's best
> to include the following patch so that we can find a clear culprit and
> do not bury the ipg clock changes in larger patches.
> 
> Sascha
> 
> -----------------------------8<-----------------------------------
> 
> From 30b77e83269a58c2cb5ce6de8be647e027030d34 Mon Sep 17 00:00:00 2001
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Date: Mon, 31 Oct 2016 06:45:33 +0100
> Subject: [PATCH] pwm: imx: remove ipg clock
> 
> The use of the ipg clock was introduced with commit 7b27c160c6. In the
> commit message it was claimed that the ipg clock is enabled for register
> accesses. This is true for the ->config() callback, but not for the
> ->set_enable() callback. Given that the ipg clock is not consistently
> enabled for all register accesses we can assume that either it is not
> required at all or that the current code does not work.
> Remove the ipg clock code for now so that it's no longer in the way of
> refactoring the driver.

For reference:

I verified on i.MX53 and i.MX25 that the ipg clock provided to the pwm
driver is not needed when accessing registers. I would have to verify
that on i.MX27 aswell, but I do not have a board handy at the moment.

The current assumption as discussed by Philipp and me is that the ipg
clk is only needed when the pwm output is driven by the ipg clk
(MX3_PWMCR[16:17] = MX3_PWMCR_CLKSRC_IPG)

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
