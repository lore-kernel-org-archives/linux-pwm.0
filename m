From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2 03/10] pwm: imx: Rewrite imx_pwm_*_v1 code to
 facilitate switch to atomic pwm operation
Date: Wed, 2 Nov 2016 08:36:14 +0100
Message-ID: <20161102073614.qcjfwv63q3dizfp3@pengutronix.de>
References: <1477549785-4972-1-git-send-email-l.majewski@majess.pl>
 <1477549785-4972-4-git-send-email-l.majewski@majess.pl>
 <20161027094005.2da3b7d4@bbrezillon>
 <20161031055904.av45k535c26gjonz@pengutronix.de>
 <20161102081852.7d1f2b70@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:52933 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754092AbcKBHhE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Nov 2016 03:37:04 -0400
Content-Disposition: inline
In-Reply-To: <20161102081852.7d1f2b70@ipc1.ka-ro>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lothar =?iso-8859-15?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>, Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Philipp Zabel <pza@pengutronix.de>

On Wed, Nov 02, 2016 at 08:18:52AM +0100, Lothar Waßmann wrote:
> Hi,
> 
> On Mon, 31 Oct 2016 06:59:04 +0100 Sascha Hauer wrote:
> > As said, even the commit 7b27c160c68 introducing the register clk did not
> > enable the clock consistently for all register accesses. Maybe it's best
> > to include the following patch so that we can find a clear culprit and
> > do not bury the ipg clock changes in larger patches.
> > 
> > Sascha
> > 
> > -----------------------------8<-----------------------------------
> > 
> > From 30b77e83269a58c2cb5ce6de8be647e027030d34 Mon Sep 17 00:00:00 2001
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > Date: Mon, 31 Oct 2016 06:45:33 +0100
> > Subject: [PATCH] pwm: imx: remove ipg clock
> > 
> > The use of the ipg clock was introduced with commit 7b27c160c6. In the
> > commit message it was claimed that the ipg clock is enabled for register
> > accesses. This is true for the ->config() callback, but not for the
> > ->set_enable() callback. Given that the ipg clock is not consistently
> > enabled for all register accesses we can assume that either it is not
> > required at all or that the current code does not work.
> > Remove the ipg clock code for now so that it's no longer in the way of
> > refactoring the driver.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > ---
> >  drivers/pwm/pwm-imx.c | 19 +------------------
> >  1 file changed, 1 insertion(+), 18 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> > index d600fd5..70609ef2 100644
> > --- a/drivers/pwm/pwm-imx.c
> > +++ b/drivers/pwm/pwm-imx.c
> > @@ -49,7 +49,6 @@
> >  
> >  struct imx_chip {
> >  	struct clk	*clk_per;
> > -	struct clk	*clk_ipg;
> >  
> >  	void __iomem	*mmio_base;
> >  
> > @@ -204,17 +203,8 @@ static int imx_pwm_config(struct pwm_chip *chip,
> >  		struct pwm_device *pwm, int duty_ns, int period_ns)
> >  {
> >  	struct imx_chip *imx = to_imx_chip(chip);
> > -	int ret;
> > -
> > -	ret = clk_prepare_enable(imx->clk_ipg);
> > -	if (ret)
> > -		return ret;
> >  
> > -	ret = imx->config(chip, pwm, duty_ns, period_ns);
> > -
> > -	clk_disable_unprepare(imx->clk_ipg);
> > -
> > -	return ret;
> > +	return imx->config(chip, pwm, duty_ns, period_ns);
> >  }
> >  
> >  static int imx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> > @@ -293,13 +283,6 @@ static int imx_pwm_probe(struct platform_device *pdev)
> >  		return PTR_ERR(imx->clk_per);
> >  	}
> >  
> > -	imx->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
> > -	if (IS_ERR(imx->clk_ipg)) {
> > -		dev_err(&pdev->dev, "getting ipg clock failed with %ld\n",
> > -				PTR_ERR(imx->clk_ipg));
> > -		return PTR_ERR(imx->clk_ipg);
> > -	}
> > -
> >  	imx->chip.ops = &imx_pwm_ops;
> >  	imx->chip.dev = &pdev->dev;
> >  	imx->chip.base = -1;
> >
> If the IPG clock is not needed by the driver it should be removed from
> DT as well.

No, it's only the half truth that it's not needed. It would indeed be
needed if the driver used the ipg clock as source for the PWM (PWMCR[17:16] = 0b01).
The driver currently doesn't do this, so it doesn't need the clock. We
should still leave the clocks in the dts files in case we decide to use
that clock later.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
