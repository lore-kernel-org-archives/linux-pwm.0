From: "Tanwar, Rahul" <rahul.tanwar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v4 2/2] Add PWM fan controller driver for LGM SoC
Date: Thu, 23 Jul 2020 12:16:18 +0800
Message-ID: <409ee148-a6a6-327f-e4d7-455f98ef4c66@linux.intel.com>
References: <cover.1593503228.git.rahul.tanwar@linux.intel.com>
 <a74b18b68f26bf902c30a017050cc4ea070da887.1593503228.git.rahul.tanwar@linux.intel.com>
 <20200713191059.zsokzvv3k2hyaxcl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200713191059.zsokzvv3k2hyaxcl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, songjun.Wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, cheol.yong.kim-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, qi-ming.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, rahul.tanwar.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


Hi Uwe,

Thanks for the feedback.

On 14/7/2020 3:10 am, Uwe Kleine-König wrote:
> Hello,
>
> On Tue, Jun 30, 2020 at 03:55:32PM +0800, Rahul Tanwar wrote:
>> Intel Lightning Mountain(LGM) SoC contains a PWM fan controller.
>> This PWM controller does not have any other consumer, it is a
>> dedicated PWM controller for fan attached to the system. Add
>> driver for this PWM fan controller.
>>
>> Signed-off-by: Rahul Tanwar <rahul.tanwar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> ---
>>  drivers/pwm/Kconfig         |  11 ++
>>  drivers/pwm/Makefile        |   1 +
>>  drivers/pwm/pwm-intel-lgm.c | 266 ++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 278 insertions(+)
>>  create mode 100644 drivers/pwm/pwm-intel-lgm.c

[...]

>> +
>> +static int lgm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>> +			 const struct pwm_state *state)
>> +{
>> +	struct lgm_pwm_chip *pc = to_lgm_pwm_chip(chip);
>> +	u32 duty_cycle, val;
>> +	unsigned int period;
>> +
>> +	if (!state->enabled) {
>> +		lgm_pwm_enable(chip, 0);
>> +		return 0;
>> +	}
>> +
>> +	period = min_t(u64, state->period, pc->period);
>> +
>> +	if (state->polarity != PWM_POLARITY_NORMAL ||
>> +	    period < pc->period)
>> +		return -EINVAL;
> This check looks wrong. If you refuse period < pc->period there isn't
> much configuration possible.

I am kind of stuck here. I made this change of adding a check
period < pc->period based on your feedback on v2 patch.
In fact, you had specified this code in v2 review feedback
and i used the same exact code.

How should we handle it when the hardware supports fixed period.
We don't want user to change period and allow just changing
duty_cycle. With that intention, i had first added a strict check
which refused configuration if period != pc->period. Period is
intended to be a read only value.

How do you suggest we handle the fixed period hardware support?
Would you have any reference example of other drivers which also
supports fixed period? Thanks.

[...]
>> +static int lgm_pwm_remove(struct platform_device *pdev)
>> +{
>> +	struct lgm_pwm_chip *pc = platform_get_drvdata(pdev);
>> +	int ret;
>> +
>> +	ret = pwmchip_remove(&pc->chip);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	clk_disable_unprepare(pc->clk);
>> +	reset_control_assert(pc->rst);
> Please swap the two previous lines to match the error patch of .probe.

Again, i had made this change based on your below review feedback
for v1. IMO, reverse of probe makes more sense.

"In .probe() you first release reset and then enable the clock. It's good
style to do it the other way round in .remove()."

Regards,
Rahul
