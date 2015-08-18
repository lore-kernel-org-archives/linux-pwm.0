From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v5 2/2] pwm: Add support for R-Car PWM Timer
Date: Tue, 18 Aug 2015 10:54:43 +0900
Message-ID: <55D29063.7080909@renesas.com>
References: <1434359324-2964-1-git-send-email-yoshihiro.shimoda.uh@renesas.com> <1434359324-2964-3-git-send-email-yoshihiro.shimoda.uh@renesas.com> <20150817141533.GB6891@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:37775 "EHLO
	relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750822AbbHRByx (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 17 Aug 2015 21:54:53 -0400
In-Reply-To: <20150817141533.GB6891@ulmo.nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-pwm@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org

Hi Thierry,

(2015/08/17 23:15), Thierry Reding wrote:
> Sorry for taking an awful long time to get around to this. The driver
> looks generally okay, but I have a few minor comments...

Thank you for the review!

> On Mon, Jun 15, 2015 at 06:08:44PM +0900, Yoshihiro Shimoda wrote:
>> This patch adds support for R-Car SoCs PWM Timer.
> 
> This could be a little more verbose. You could say for example how many
> channels the driver exposes, or mention typical use-cases (if any).

Yes, I will add the following comment.

The PWM timer of R-Car H2 has 7 channels. So, we can use the channels if we
describe device tree nodes.

>> diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
> [...]
>> +static int rcar_pwm_get_clock_division(struct rcar_pwm_chip *rp, int period_ns)
>> +{
>> +	int div;
> 
> Can be unsigned int.

I will fix it.

>> +	unsigned long clk_rate = clk_get_rate(rp->clk);
>> +	unsigned long long max;	/* max cycle / nanoseconds */
>> +
>> +	if (!clk_rate)
> 
> I prefer it when these are explicit: clk_rate == 0. This goes for
> numerical comparisons. For booleans, or NULL pointer comparisons the
> !expression is fine.

I will fix it.

>> +static int rcar_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>> +			   int duty_ns, int period_ns)
>> +{
>> +	struct rcar_pwm_chip *rp = to_rcar_pwm_chip(chip);
>> +	int div = rcar_pwm_get_clock_division(rp, period_ns);
>> +	int ret;
>> +
>> +	if (div < 0)
>> +		return div;
>> +
>> +	/* Let the core driver set pwm->period if disabled and duty_ns == 0 */
>> +	if (!test_bit(PWMF_ENABLED, &pwm->flags) && !duty_ns)
>> +		return 0;
>> +
>> +	rcar_pwm_bit_modify(rp, RCAR_PWMCR_SYNC, RCAR_PWMCR_SYNC, RCAR_PWMCR);
>> +	ret = rcar_pwm_set_counter(rp, div, duty_ns, period_ns);
>> +	rcar_pwm_set_clock_control(rp, div);
>> +	rcar_pwm_bit_modify(rp, RCAR_PWMCR_SYNC, 0, RCAR_PWMCR);
>> +
>> +	return ret;
>> +}
>> +
>> +static int rcar_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
>> +{
>> +	struct rcar_pwm_chip *rp = to_rcar_pwm_chip(chip);
>> +	u32 pwmcnt;
>> +
>> +	/* Don't enable the PWM device if CYC0 or PH0 is 0 */
>> +	pwmcnt = rcar_pwm_read(rp, RCAR_PWMCNT);
>> +	if (!(pwmcnt & RCAR_PWMCNT_CYC0_MASK) ||
>> +	    !(pwmcnt & RCAR_PWMCNT_PH0_MASK))
>> +		return -EINVAL;
> 
> This looks wrong. Any errors in configuration should've been caught by
> the ->config() implementation. Why can't you return -EINVAL on this
> condition in ->config()? ->enable() failing should only be the case if
> truly the PWM can't be enabled, not if it's badly configured.

I would like to avoid a "prohibition setting" when the PWM is enabled.
The datasheet said "setting 0x000 is prohibited" in CYC0 and PH0.
However, the initial value of each field is 0x000.
So, I am thinking this is truly the PWM can't be enabled.
If this driver sets any value to the register in probe() to avoid
"prohibition setting", I can remove the condtion in ->enable().
What do you think?

About the ->config(), it already has such a condition check by rcar_pwm_set_counter():

+	/* Avoid prohibited setting */
+	if (cyc && ph)
+		rcar_pwm_write(rp, cyc | ph, RCAR_PWMCNT);
+
+	return (cyc && ph) ? 0 : -EINVAL;

However it may be unreadable code. So, I will fix it as the followings:

+	/* Avoid prohibited setting */
+	if (cyc != 0 && ph != 0) {
+		rcar_pwm_write(rp, cyc | ph, RCAR_PWMCNT);
+		return 0;
+	} else {
+		return -EINVAL;
+	}

>> +static struct platform_driver rcar_pwm_driver = {
>> +	.probe		= rcar_pwm_probe,
>> +	.remove		= rcar_pwm_remove,
>> +	.driver		= {
>> +		.name	= "pwm-rcar",
>> +		.of_match_table = of_match_ptr(rcar_pwm_of_table),
>> +	}
>> +};
> 
> This doesn't need the artificial padding. A single space around = is
> enough.

I will fix it.

Best regards,
Yoshihiro Shimoda

> Thierry
> 
