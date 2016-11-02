From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v2 03/10] pwm: imx: Rewrite imx_pwm_*_v1 code to
 facilitate switch to atomic pwm operation
Date: Wed, 02 Nov 2016 10:34:45 +0100
Message-ID: <1478079285.3139.8.camel@pengutronix.de>
References: <1477549785-4972-1-git-send-email-l.majewski@majess.pl>
         <1477549785-4972-4-git-send-email-l.majewski@majess.pl>
         <20161027094005.2da3b7d4@bbrezillon>
         <20161031055904.av45k535c26gjonz@pengutronix.de>
         <20161102081852.7d1f2b70@ipc1.ka-ro>
         <20161102073614.qcjfwv63q3dizfp3@pengutronix.de>
         <20161102085620.21195b99@ipc1.ka-ro>
         <20161102080645.vuqebeaoisu5t4sl@pengutronix.de>
         <20161102095129.53dee13c@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161102095129.53dee13c@ipc1.ka-ro>
Sender: linux-kernel-owner@vger.kernel.org
To: Lothar =?ISO-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Boris Brezillon <boris.brezillon@free-electrons.com>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-pwm@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>, Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>, Philipp Zabel <pza@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
List-Id: linux-pwm@vger.kernel.org

Hi Lothar,

Am Mittwoch, den 02.11.2016, 09:51 +0100 schrieb Lothar Waßmann:
> Hi,
> 
> On Wed, 2 Nov 2016 09:06:45 +0100 Sascha Hauer wrote:
> > On Wed, Nov 02, 2016 at 08:56:20AM +0100, Lothar Waßmann wrote:
> > > Hi,
> > > 
> > > On Wed, 2 Nov 2016 08:36:14 +0100 Sascha Hauer wrote:
> > > > On Wed, Nov 02, 2016 at 08:18:52AM +0100, Lothar Waßmann wrote:
> > > > > Hi,
> > > > > 
> > > > > On Mon, 31 Oct 2016 06:59:04 +0100 Sascha Hauer wrote:
> > > > > > As said, even the commit 7b27c160c68 introducing the register clk did not
> > > > > > enable the clock consistently for all register accesses. Maybe it's best
> > > > > > to include the following patch so that we can find a clear culprit and
> > > > > > do not bury the ipg clock changes in larger patches.
> > > > > > 
> > > > > > Sascha
> > > > > > 
> > > > > > -----------------------------8<-----------------------------------
> > > > > > 
> > > > > > From 30b77e83269a58c2cb5ce6de8be647e027030d34 Mon Sep 17 00:00:00 2001
> > > > > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > > > > Date: Mon, 31 Oct 2016 06:45:33 +0100
> > > > > > Subject: [PATCH] pwm: imx: remove ipg clock
> > > > > > 
> > > > > > The use of the ipg clock was introduced with commit 7b27c160c6. In the
> > > > > > commit message it was claimed that the ipg clock is enabled for register
> > > > > > accesses. This is true for the ->config() callback, but not for the
> > > > > > ->set_enable() callback. Given that the ipg clock is not consistently
> > > > > > enabled for all register accesses we can assume that either it is not
> > > > > > required at all or that the current code does not work.
> > > > > > Remove the ipg clock code for now so that it's no longer in the way of
> > > > > > refactoring the driver.
> > > > > > 
> > > > > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > > > > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > > > > > ---
> > > > > >  drivers/pwm/pwm-imx.c | 19 +------------------
> > > > > >  1 file changed, 1 insertion(+), 18 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> > > > > > index d600fd5..70609ef2 100644
> > > > > > --- a/drivers/pwm/pwm-imx.c
> > > > > > +++ b/drivers/pwm/pwm-imx.c
> > > > > > @@ -49,7 +49,6 @@
> > > > > >  
> > > > > >  struct imx_chip {
> > > > > >  	struct clk	*clk_per;
> > > > > > -	struct clk	*clk_ipg;
> > > > > >  
> > > > > >  	void __iomem	*mmio_base;
> > > > > >  
> > > > > > @@ -204,17 +203,8 @@ static int imx_pwm_config(struct pwm_chip *chip,
> > > > > >  		struct pwm_device *pwm, int duty_ns, int period_ns)
> > > > > >  {
> > > > > >  	struct imx_chip *imx = to_imx_chip(chip);
> > > > > > -	int ret;
> > > > > > -
> > > > > > -	ret = clk_prepare_enable(imx->clk_ipg);
> > > > > > -	if (ret)
> > > > > > -		return ret;
> > > > > >  
> > > > > > -	ret = imx->config(chip, pwm, duty_ns, period_ns);
> > > > > > -
> > > > > > -	clk_disable_unprepare(imx->clk_ipg);
> > > > > > -
> > > > > > -	return ret;
> > > > > > +	return imx->config(chip, pwm, duty_ns, period_ns);
> > > > > >  }
> > > > > >  
> > > > > >  static int imx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> > > > > > @@ -293,13 +283,6 @@ static int imx_pwm_probe(struct platform_device *pdev)
> > > > > >  		return PTR_ERR(imx->clk_per);
> > > > > >  	}
> > > > > >  
> > > > > > -	imx->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
> > > > > > -	if (IS_ERR(imx->clk_ipg)) {
> > > > > > -		dev_err(&pdev->dev, "getting ipg clock failed with %ld\n",
> > > > > > -				PTR_ERR(imx->clk_ipg));
> > > > > > -		return PTR_ERR(imx->clk_ipg);
> > > > > > -	}
> > > > > > -
> > > > > >  	imx->chip.ops = &imx_pwm_ops;
> > > > > >  	imx->chip.dev = &pdev->dev;
> > > > > >  	imx->chip.base = -1;
> > > > > >
> > > > > If the IPG clock is not needed by the driver it should be removed from
> > > > > DT as well.
> > > > 
> > > > No, it's only the half truth that it's not needed. It would indeed be
> > > > needed if the driver used the ipg clock as source for the PWM (PWMCR[17:16] = 0b01).
> > > >
> > > That's a different story!
> > > Currently the DT specifies two clocks for the PWM:
> > > 1. register access clock (which we now know is unnecessary)
> > > 2. PWM source clock
> > > In the case mentioned above, the IPG clock has to be specified as the
> > > SECOND clock entry in DT, because otherwise the clock won't be
> > > enabled/disabled as required!
> > 
> > Since the driver gets its clock by name (clk_get(&pdev->dev, "per"/"ipg"))
> > the position in the DT doesn't matter at all.
> > 
> Do you really think so?

Could you elaborate why the position of the clock phandles in the clocks
property is an issue at all?

> The driver does a lookup for a clock named 'ipg' which it doesn't use
> at all with your proposed patcht

With the proposed patch the lookup is removed, too.

It could be added back to the driver if somebody ever has the need to
clock pwm output from the ipg_clk instead of the ipg_clk_highfreq input
to the pwm module.

>  and a lookup for the 'per' clock which
> it enables/disables whenever the PWM output is switched inactive/active.
> Since the clock named 'per' is the second clock in DTB it is moot to
> have the ipg clock in the first position when intending to use it as
> PWM source clock!

Since the clock lookup is by name, the order of the clocks could indeed
be changed, but what is gained from that?

> > The only thing that isn't accurate is that the "ipg" clock in the device
> > tree is not for register access, but itself a clock to be used as PWM
> > source. This is no functional problem though.
> > 
> That only happens to work accidentally, because the IPG clock will never
> be switched off anyway.

The "ipg" clock name here does not describe the global ipg root clock,
and as we just realized doesn't supply the registers. It just happens to
be the name of the "ipg_clk" input to the pwm module, which is used to
generate the pwm output if the CLKSRC field in PWMx_PWMCR[17:16] is set
to 0x1 (ipg_clk).

>  But it is semantically incorrect and should not
> be promoted for others to copy...

I don't agree. If at all, we are missing documented inputs (the 32k
clock).

regards
Philipp
