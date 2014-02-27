From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCHv9 Resend 1/4] pwm: Add Freescale FTM PWM driver support
Date: Thu, 27 Feb 2014 05:10:10 +0000
Message-ID: <d4640ae32c1041028dbf5ce0849e6f97@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1392799137-17188-1-git-send-email-Li.Xiubo@freescale.com>
 <1392799137-17188-2-git-send-email-Li.Xiubo@freescale.com>
 <20140226131109.GA29779@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bl2lp0207.outbound.protection.outlook.com ([207.46.163.207]:14833
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750823AbaB0FK2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 27 Feb 2014 00:10:28 -0500
In-Reply-To: <20140226131109.GA29779@ulmo.nvidia.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Huan Wang <Huan.Wang@freescale.com>, Jingchang Lu <jingchang.lu@freescale.com>

Hi Thierry,

Thanks very much, I will fix them all.

:)

--
Best Regards,
Xiubo

> Sorry for taking so long to get back to you. Things have been quite busy
> lately. A few more comments below, but we're getting there.
> 
> On Wed, Feb 19, 2014 at 04:38:54PM +0800, Xiubo Li wrote:
> [...]
> > diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
> [...]
> > +static unsigned long fsl_pwm_calculate_period(struct fsl_pwm_chip *fpc,
> > +					      unsigned long period_ns)
> > +{
> > +	struct clk *cnt_clk[3];
> > +	enum fsl_pwm_clk m0, m1;
> > +	unsigned long fix_rate, ext_rate, cycles;
> > +
> > +	fpc->counter_clk = fpc->sys_clk;
> > +	cycles = fsl_pwm_calculate_period_cycles(fpc, period_ns,
> > +			FSL_PWM_CLK_SYS);
> > +	if (cycles)
> > +		return cycles;
> > +
> > +	cnt_clk[FSL_PWM_CLK_FIX] = devm_clk_get(fpc->chip.dev, "ftm_fix");
> > +	if (IS_ERR(cnt_clk[FSL_PWM_CLK_FIX]))
> > +		return PTR_ERR(cnt_clk[FSL_PWM_CLK_FIX]);
> > +
> > +	cnt_clk[FSL_PWM_CLK_EXT] = devm_clk_get(fpc->chip.dev, "ftm_ext");
> > +	if (IS_ERR(cnt_clk[FSL_PWM_CLK_EXT]))
> > +		return PTR_ERR(cnt_clk[FSL_PWM_CLK_EXT]);
> > +
> > +	fpc->counter_clk_en = devm_clk_get(fpc->chip.dev, "ftm_cnt_clk_en");
> > +	if (IS_ERR(fpc->counter_clk_en))
> > +		return PTR_ERR(fpc->counter_clk_en);
> 
> You shouldn't do this. You're obtaining a reference to each of these
> clocks whenever pwm_config() is called. And devres will only clean those
> up after the driver is unbound. Can't you simply keep a reference to
> these within struct fsl_pwm_chip?
> 
> > +static int fsl_counter_clock_enable(struct fsl_pwm_chip *fpc)
> > +{
> > +	u32 val;
> > +	int ret;
> > +
> > +	if (fpc->counter_clk_enable++)
> 
> This function is always called with the fpc->lock held, so you could
> make this much easier by incrementing the .counter_clk_enable field only
> at the very end of the function. That way...
> 
> > +		return 0;
> > +
> > +	ret = clk_prepare_enable(fpc->counter_clk);
> > +	if (ret) {
> > +		fpc->counter_clk_enable--;
> 
> ... this won't be necessary...
> 
> > +		return ret;
> > +	}
> > +
> > +	ret = clk_prepare_enable(fpc->counter_clk_en);
> > +	if (ret) {
> > +		fpc->counter_clk_enable--;
> 
> ... and neither will this.
> 
> > +static int fsl_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> > +{
> > +	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
> > +	u32 val;
> > +	int ret;
> > +
> > +	val = readl(fpc->base + FTM_OUTMASK);
> > +	val &= ~BIT(pwm->hwpwm);
> > +	writel(val, fpc->base + FTM_OUTMASK);
> > +
> > +	mutex_lock(&fpc->lock);
> 
> I think you want to extend the lock to cover the FTM_OUTMASK register
> access as well because there could be a race between pwm_enable() and
> pwm_disable().
> 
> > +	ret = fsl_counter_clock_enable(fpc);
> > +	mutex_unlock(&fpc->lock);
> > +
> > +	return ret;
> > +}
> 
> Can this function be moved somewhere else so fsl_counter_clock_enable()
> and fsl_counter_clock_disable() are grouped together?
> 
> > +static void fsl_counter_clock_disable(struct fsl_pwm_chip *fpc)
> > +{
> > +	u32 val;
> > +
> > +	if (--fpc->counter_clk_enable)
> > +		return;
> 
> This is going to break. Consider the case where you call pwm_disable()
> on a PWM device and fpc->counter_clk_enable == 1. In that case, this
> will decrement counter_clk_enable to 0 and proceed with the remainder of
> this function.
> 
> Now you call pwm_disable() again. The above will decrement again and
> cause fpc->counter_clk_enable to wrap around to UINT_MAX.
> 
> So I think a more correct implementation would be:
> 
> 	/*
> 	 * already disabled, do nothing (perhaps output warning message
> 	 * to catch unbalanced calls? )
> 	 */
> 	if (fpc->counter_clk_enable == 0)
> 		return;
> 
> 	/* there are still users, so can't disable yet */
> 	if (--fpc->counter_clk_enable > 0)
> 		return;
> 
> 	/* no users left, disable clock */
> 
> > +static void fsl_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> > +{
> > +	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
> > +	u32 val;
> > +
> > +	val = readl(fpc->base + FTM_OUTMASK);
> > +	val |= BIT(pwm->hwpwm);
> > +	writel(val, fpc->base + FTM_OUTMASK);
> > +
> > +	mutex_lock(&fpc->lock);
> 
> This lock should also include the access to FTM_OUTMASK above.
> 
> > +static int fsl_pwm_probe(struct platform_device *pdev)
> > +{
> [...]
> > +	fpc->sys_clk = devm_clk_get(&pdev->dev, "ftm_sys");
> > +	if (IS_ERR(fpc->sys_clk)) {
> > +		dev_err(&pdev->dev,
> > +				"failed to get \"ftm_sys\" clock\n");
> 
> The above easily fits on a single line, no need for the wrapping.
> 
> > +		return PTR_ERR(fpc->sys_clk);
> > +	}
> > +
> > +	ret = clk_prepare_enable(fpc->sys_clk);
> > +	if (ret)
> > +		return ret;
> > +
> > +	writel(0x00, fpc->base + FTM_CNTIN);
> > +	writel(0x00, fpc->base + FTM_OUTINIT);
> > +	writel(0xFF, fpc->base + FTM_OUTMASK);
> > +	clk_disable_unprepare(fpc->sys_clk);
> 
> This looks out of place somehow, perhaps it should be moved off into a
> separate function? fsl_pwm_init() perhaps.
> 
> Thierry
