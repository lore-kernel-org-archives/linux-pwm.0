From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [PATCH v6 2/2] pwm: Add support for R-Car PWM Timer
Date: Wed, 19 Aug 2015 11:00:55 +0000
Message-ID: <SG2PR06MB0919160A49BA4FCAF2DA500BD8670@SG2PR06MB0919.apcprd06.prod.outlook.com>
References: <1439957639-4816-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1439957639-4816-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20150819100732.GC26627@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20150819100732.GC26627@ulmo>
Content-Language: ja-JP
Sender: linux-sh-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

Hi Thierry,

> Sent: Wednesday, August 19, 2015 7:08 PM
> 
> On Wed, Aug 19, 2015 at 01:13:59PM +0900, Yoshihiro Shimoda wrote:
> > This patch adds support for R-Car SoCs PWM Timer. The PWM timer of
> > R-Car H2 has 7 channels. So, we can use the channels if we describe
> > device tree nodes.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >  drivers/pwm/Kconfig    |  11 ++
> >  drivers/pwm/Makefile   |   1 +
> >  drivers/pwm/pwm-rcar.c | 265 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 277 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-rcar.c
> 
> Found a couple more things. No need to respin for any of these, I can
> make the changes when applying, but I'd like confirmation on a couple
> of things below.

Thank you!

> > diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
> [...]
> > +static int rcar_pwm_set_counter(struct rcar_pwm_chip *rp, int div, int duty_ns,
> > +				int period_ns)
> > +{
> > +	unsigned long long one_cycle, tmp;	/* 0.01 nanoseconds */
> 
> I'm not quite sure why you need the extra multiplication and division by
> 100 here. Is this for extra accuracy?

Yes, this is for extra accuracy.

> > +	unsigned long clk_rate = clk_get_rate(rp->clk);
> > +	u32 cyc, ph;
> > +
> > +	one_cycle = (unsigned long long)NSEC_PER_SEC * 100ULL * (1 << div);
> > +	do_div(one_cycle, clk_rate);
> > +
> > +	tmp = period_ns * 100ULL;
> > +	do_div(tmp, one_cycle);
> > +	cyc = (tmp << RCAR_PWMCNT_CYC0_SHIFT) & RCAR_PWMCNT_CYC0_MASK;
> > +
> > +	tmp = duty_ns * 100ULL;
> > +	do_div(tmp, one_cycle);
> > +	ph = tmp & RCAR_PWMCNT_PH0_MASK;
> > +
> > +	/* Avoid prohibited setting */
> > +	if (cyc != 0 && ph != 0) {
> > +		rcar_pwm_write(rp, cyc | ph, RCAR_PWMCNT);
> > +		return 0;
> > +	} else {
> > +		return -EINVAL;
> > +	}
> 
> I think the ordering here is unintuitive, better would be:
> 
> 	if (cyc == 0 || ph == 0)
> 		return -EINVAL;
> 
> 	rcar_pwm_write(rp, cyc | ph, RCAR_PWMCNT);
> 
> 	return 0;

Thank you! I think so.

> > +static int rcar_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> > +			   int duty_ns, int period_ns)
> > +{
> > +	struct rcar_pwm_chip *rp = to_rcar_pwm_chip(chip);
> > +	int div = rcar_pwm_get_clock_division(rp, period_ns);
> > +	int ret;
> > +
> > +	if (div < 0)
> > +		return div;
> > +
> > +	/* Let the core driver set pwm->period if disabled and duty_ns == 0 */
> > +	if (!test_bit(PWMF_ENABLED, &pwm->flags) && !duty_ns)
> > +		return 0;
> > +
> > +	rcar_pwm_bit_modify(rp, RCAR_PWMCR_SYNC, RCAR_PWMCR_SYNC, RCAR_PWMCR);
> > +	ret = rcar_pwm_set_counter(rp, div, duty_ns, period_ns);
> > +	rcar_pwm_set_clock_control(rp, div);
> > +	rcar_pwm_bit_modify(rp, RCAR_PWMCR_SYNC, 0, RCAR_PWMCR);
> 
> Just making sure: is it correct to execute the above two lines even if
> ret < 0?

Oops, this driver should not call the rcar_pwm_set_clock_control()
because divider ratio might be changed.
However, this driver should execute rcar_pwm_bit_modify(rp, RCAR_PWMCR_SYNC, 0, RCAR_PWMCR)
to clear the "SYNC" bit.

> > +static int rcar_pwm_probe(struct platform_device *pdev)
> > +{
> > +	struct rcar_pwm_chip *rcar_pwm;
> > +	struct resource *res;
> > +	int ret;
> > +
> > +	rcar_pwm = devm_kzalloc(&pdev->dev, sizeof(*rcar_pwm), GFP_KERNEL);
> > +	if (rcar_pwm == NULL)
> > +		return -ENOMEM;
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	rcar_pwm->base = devm_ioremap_resource(&pdev->dev, res);
> > +	if (IS_ERR(rcar_pwm->base))
> > +		return PTR_ERR(rcar_pwm->base);
> > +
> > +	rcar_pwm->clk = devm_clk_get(&pdev->dev, NULL);
> > +	if (IS_ERR(rcar_pwm->clk)) {
> > +		dev_err(&pdev->dev, "cannot get clock\n");
> > +		return PTR_ERR(rcar_pwm->clk);
> > +	}
> > +
> > +	platform_set_drvdata(pdev, rcar_pwm);
> > +
> > +	rcar_pwm->chip.dev = &pdev->dev;
> > +	rcar_pwm->chip.ops = &rcar_pwm_ops;
> > +	rcar_pwm->chip.of_xlate = of_pwm_xlate_with_flags;
> 
> This seems to be missing a:
> 
> 	rcar_pwm->chip.of_pwm_n_cells = 3;
> 
> ?

Thank you for the point.
I just tested this driver only sysfs interface.
This driver should use of_pwm_simple_xlate and the value is set to 2
because this PWM timer doesn't support polarity.

Best regards,
Yoshihiro Shimoda

> Thierry

