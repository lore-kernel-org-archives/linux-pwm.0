From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [PATCH v4 2/2] pwm: Add support for R-Car PWM Timer
Date: Mon, 15 Jun 2015 05:48:00 +0000
Message-ID: <SG2PR06MB09195A961FECE276F001493AD8B80@SG2PR06MB0919.apcprd06.prod.outlook.com>
References: <1432205846-4312-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1432205846-4312-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20150612120600.GM19400@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:5324 "EHLO
	relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750751AbbFOFsG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Mon, 15 Jun 2015 01:48:06 -0400
In-Reply-To: <20150612120600.GM19400@ulmo.nvidia.com>
Content-Language: ja-JP
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Thierry,

Thank you for the review!

> Sent: Friday, June 12, 2015 9:06 PM
> 
> On Thu, May 21, 2015 at 07:57:26PM +0900, Yoshihiro Shimoda wrote:
> [...]
> > diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
> [...]
> > +#define to_rcar_pwm_chip(chip)	container_of(chip, struct rcar_pwm_chip, chip)
> 
> For consistency with other drivers I'd like this to be a static inline
> function.

I got it. I will modify this.

> > +
> > +static void rcar_pwm_write(struct rcar_pwm_chip *rp, u32 data, u32 reg)
> > +{
> > +	iowrite32(data, rp->base + reg);
> > +}
> > +
> > +static u32 rcar_pwm_read(struct rcar_pwm_chip *rp, u32 reg)
> > +{
> > +	return ioread32(rp->base + reg);
> > +}
> 
> ioread*() and iowrite*() are to be used for devices that can be on a
> memory-mapped bus or an I/O mapped bus. I suspect that this particular
> IP block doesn't fall into that category, so it should be using the
> regular readl()/writel() instead.

I will use readl()/writel().

> > +static void rcar_pwm_bit_modify(struct rcar_pwm_chip *rp,
> > +				u32 mask, u32 data, u32 reg)
> 
> You should try to fill up lines as much as you can: mask and data should
> still fit on the first line.

I will fix it.

> > +{
> > +	u32 val = rcar_pwm_read(rp, reg);
> > +
> > +	val &= ~mask;
> > +	val |= data & mask;
> > +	rcar_pwm_write(rp, val, reg);
> > +}
> > +
> > +static int rcar_pwn_get_clock_division(struct rcar_pwm_chip *rp,
> 
> Typo: "pwn" -> "pwm"

Oops, I will fix it.

> > +				       int period_ns)
> > +{
> > +	int div;
> 
> Perhaps make this unsigned int?

I will use unsigned int.

> > +	unsigned long clk_rate = clk_get_rate(rp->clk);
> > +	unsigned long long max;	/* max cycle / nanoseconds */
> 
> I think you want to check for clk_rate == 0 here and return an error.
> Otherwise the do_div() call below may try to divide by 0.

I will add a code to aboid dividing by 0.

> > +	for (div = 0; div <= RCAR_PWM_MAX_DIVISION; div++) {
> > +		max = (unsigned long long)NSEC_PER_SEC * RCAR_PWM_MAX_CYCLE *
> > +			(1 << div);
> > +		do_div(max, clk_rate);
> > +		if (period_ns < max)
> > +			break;
> > +	}
> > +
> > +	return div;
> > +}
> > +
> > +static void rcar_pwm_set_clock_control(struct rcar_pwm_chip *rp, int div)
> > +{
> > +	u32 val = rcar_pwm_read(rp, RCAR_PWMCR);
> > +
> > +	if (div > RCAR_PWM_MAX_DIVISION)
> > +		return;
> 
> Shouldn't you return an error here (and propagate it later on) if an
> invalid value is passed in? Or perhaps even avoid calling this function
> with an invalid value in the first place? As it is, you're silently
> ignoring cases where an invalid value is being passed in. That'll leave
> anybody working with this driver completely puzzled when it doesn't
> behave the way they expect it too. And it gives users no indication
> about what went wrong.

I will add a code to return an error here.

> > +
> > +	val &= ~(RCAR_PWMCR_CCMD | RCAR_PWMCR_CC0_MASK);
> > +	if (div & 1)
> > +		val |= RCAR_PWMCR_CCMD;
> > +	div >>= 1;
> > +	val |= div << RCAR_PWMCR_CC0_SHIFT;
> > +	rcar_pwm_write(rp, val, RCAR_PWMCR);
> > +}
> > +
> > +static void rcar_pwm_set_counter(struct rcar_pwm_chip *rp, int div,
> > +				 int duty_ns, int period_ns)
> > +{
> > +	unsigned long long one_cycle, tmp;	/* 0.01 nanoseconds */
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
> > +	if (cyc && ph)
> > +		rcar_pwm_write(rp, cyc | ph, RCAR_PWMCNT);
> 
> So if a period and duty-cycle are passed in that yield the prohibited
> setting the operation will simply be silently ignored?

Yes, to update values of pwm->duty_cycle and ->period by pwm_config(),
this code will be silently ignored.

> > +}
> > +
> > +static int rcar_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> > +{
> > +	struct rcar_pwm_chip *rp = to_rcar_pwm_chip(chip);
> > +
> > +	return clk_prepare_enable(rp->clk);
> > +}
> > +
> > +static void rcar_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
> > +{
> > +	struct rcar_pwm_chip *rp = to_rcar_pwm_chip(chip);
> > +
> > +	clk_disable_unprepare(rp->clk);
> > +}
> > +
> > +static int rcar_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> > +			   int duty_ns, int period_ns)
> > +{
> > +	struct rcar_pwm_chip *rp = to_rcar_pwm_chip(chip);
> > +	int div;
> > +
> > +	div = rcar_pwn_get_clock_division(rp, period_ns);
> 
> The above three lines can be collapsed into a single one.

I will fix this.

> > +
> > +	rcar_pwm_bit_modify(rp, RCAR_PWMCR_SYNC, RCAR_PWMCR_SYNC, RCAR_PWMCR);
> > +	rcar_pwm_set_counter(rp, div, duty_ns, period_ns);
> > +	rcar_pwm_set_clock_control(rp, div);
> > +	rcar_pwm_bit_modify(rp, RCAR_PWMCR_SYNC, 0, RCAR_PWMCR);
> > +
> > +	return 0;
> > +}
> > +
> > +static int rcar_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> > +{
> > +	struct rcar_pwm_chip *rp = to_rcar_pwm_chip(chip);
> > +	u32 pwmcnt;
> > +
> > +	/* Don't enable the PWM device if CYC0 or PH0 is 0 */
> > +	pwmcnt = rcar_pwm_read(rp, RCAR_PWMCNT);
> > +	if (!(pwmcnt & RCAR_PWMCNT_CYC0_MASK) ||
> > +	    !(pwmcnt & RCAR_PWMCNT_PH0_MASK))
> > +		return -EINVAL;
> > +
> > +	rcar_pwm_bit_modify(rp, RCAR_PWMCR_EN0, RCAR_PWMCR_EN0, RCAR_PWMCR);
> > +
> > +	return 0;
> > +}
> > +
> > +static void rcar_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> > +{
> > +	struct rcar_pwm_chip *rp = to_rcar_pwm_chip(chip);
> > +
> > +	rcar_pwm_bit_modify(rp, RCAR_PWMCR_EN0, 0, RCAR_PWMCR);
> > +}
> > +
> > +static const struct pwm_ops rcar_pwm_ops = {
> > +	.request	= rcar_pwm_request,
> > +	.free		= rcar_pwm_free,
> > +	.config		= rcar_pwm_config,
> > +	.enable		= rcar_pwm_enable,
> > +	.disable	= rcar_pwm_disable,
> > +	.owner		= THIS_MODULE,
> > +};
> 
> No need for this padding. Single spaces around = are good enough.

I got it. I will fix it.

> > +
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
> > +	rcar_pwm->chip.base = -1;
> > +	rcar_pwm->chip.npwm = 1;
> > +
> > +	ret = pwmchip_add(&rcar_pwm->chip);
> > +	if (ret < 0) {
> > +		dev_err(&pdev->dev, "failed to register PWM chip\n");
> > +		return ret;
> > +	}
> > +
> > +	dev_info(&pdev->dev, "R-Car PWM Timer registered\n");
> 
> No need to brag about success. Expect that things will go well and let
> users know when they don't. Output error messages, not success messages.

I got it. I will remove this message.

> > +	pm_runtime_enable(&pdev->dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static int rcar_pwm_remove(struct platform_device *pdev)
> > +{
> > +	struct rcar_pwm_chip *rcar_pwm = platform_get_drvdata(pdev);
> > +	int ret;
> > +
> > +	ret = pwmchip_remove(&rcar_pwm->chip);
> > +	if (ret)
> > +		return ret;
> > +
> > +	pm_runtime_disable(&pdev->dev);
> 
> Perhaps you'd still like to disable runtime PM even if the chip can't be
> removed?

Thank you for the point. I will fix this.

> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id rcar_pwm_of_table[] = {
> > +	{ .compatible = "renesas,pwm-rcar", },
> > +	{ },
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, rcar_pwm_of_table);
> 
> No blank line between the above two.

I will remove the blank line.

Best regards,
Yoshihiro Shimoda

> Thierry
