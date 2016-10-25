From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH 1/6] pwm: imx: Rewrite imx_pwm_*_v1 code to facilitate
 switch to atomic pwm operation
Date: Tue, 25 Oct 2016 08:42:56 +0200
Message-ID: <20161025084256.546139cc@bbrezillon>
References: <1477259146-19167-1-git-send-email-l.majewski@majess.pl>
        <1477259146-19167-2-git-send-email-l.majewski@majess.pl>
        <20161025055454.emytytmcg6d23jdd@pengutronix.de>
        <20161025082737.2ecc9fe4@bbrezillon>
        <20161025063259.clbb3ta7qdpej2xq@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from up.free-electrons.com ([163.172.77.33]:33887 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933470AbcJYGnB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Oct 2016 02:43:01 -0400
In-Reply-To: <20161025063259.clbb3ta7qdpej2xq@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Lukasz Majewski <l.majewski@majess.pl>, Thierry Reding <thierry.reding@gmail.com>, Stefan Agner <stefan@agner.ch>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org, kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>

On Tue, 25 Oct 2016 08:32:59 +0200
Sascha Hauer <s.hauer@pengutronix.de> wrote:

> On Tue, Oct 25, 2016 at 08:27:37AM +0200, Boris Brezillon wrote:
> > On Tue, 25 Oct 2016 07:54:54 +0200
> > Sascha Hauer <s.hauer@pengutronix.de> wrote:
> >   
> > > On Sun, Oct 23, 2016 at 11:45:41PM +0200, Lukasz Majewski wrote:  
> > > > The code has been rewritten to remove "generic" calls to
> > > > imx_pwm_{enable|disable|config}.
> > > > 
> > > > Such approach would facilitate switch to atomic PWM (a.k.a ->apply())
> > > > implementation.
> > > > 
> > > > Suggested-by: Stefan Agner <stefan@agner.ch>
> > > > Suggested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > > Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
> > > > ---
> > > >  drivers/pwm/pwm-imx.c | 46 ++++++++++++++++++++++++++++++++++------------
> > > >  1 file changed, 34 insertions(+), 12 deletions(-)
> > > > 
> > > > diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> > > > index c37d223..83e43d5 100644
> > > > --- a/drivers/pwm/pwm-imx.c
> > > > +++ b/drivers/pwm/pwm-imx.c
> > > > @@ -66,8 +66,6 @@ struct imx_chip {
> > > >  static int imx_pwm_config_v1(struct pwm_chip *chip,
> > > >  		struct pwm_device *pwm, int duty_ns, int period_ns)
> > > >  {
> > > > -	struct imx_chip *imx = to_imx_chip(chip);
> > > > -
> > > >  	/*
> > > >  	 * The PWM subsystem allows for exact frequencies. However,
> > > >  	 * I cannot connect a scope on my device to the PWM line and
> > > > @@ -85,26 +83,52 @@ static int imx_pwm_config_v1(struct pwm_chip *chip,
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
> > > > -static void imx_pwm_set_enable_v1(struct pwm_chip *chip, bool enable)
> > > > +static int imx_pwm_enable_v1(struct pwm_chip *chip, struct pwm_device *pwm)
> > > >  {
> > > >  	struct imx_chip *imx = to_imx_chip(chip);
> > > > +	int ret;
> > > >  	u32 val;
> > > >  
> > > > +	ret = clk_prepare_enable(imx->clk_ipg);
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
> > > > +	clk_disable_unprepare(imx->clk_per);    
> > > 
> > > This looks wrong. You start by enabling clk_ipg which is needed for
> > > register access, but then end with disabling clk_per which is needed for
> > > driving the actual PWM output. This function should probably enable
> > > clk_per on entry and enable clk_ipg while accessing registers.  
> > 
> > Oh, I didn't notice there was 2 different clocks here. This probably
> > means you have to enable clk_ipg when manipulating the registers in  
> > ->disable().  
> > 
> > One question, if there's a separate clk for the registers, why don't we
> > leave this clock enabled, and disable it in ->suspend() or ->remove()
> > instead of enabling/disabling it each time we access the registers?  
> 
> Well, if we don't need this clock, then why not save the power and
> disable it?

That's true, especially if enabling the clock is instantaneous (i.e. the
clock driver does not have to wait for the clk to be ready).

> However, I'll have to ask Philipp about this clock. It was introduced in
> 
> commit 7b27c160c68152581c702b9f1fe362338d2a0cad
> Author: Philipp Zabel <p.zabel@pengutronix.de>
> Date:   Mon Jun 25 16:15:20 2012 +0200
> 
> And even back then the additional clock was not enabled for all register
> accesses, so handling this seems broken from the start.
> 
> Sascha
> 
> 
