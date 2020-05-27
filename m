From: "Tanwar, Rahul" <rahul.tanwar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v1 2/2] Add PWM driver for LGM
Date: Wed, 27 May 2020 14:28:53 +0800
Message-ID: <3a1f1e83-2d9d-ddbf-e2e6-9c8bab87372b@linux.intel.com>
References: <cover.1590132733.git.rahul.tanwar@linux.intel.com>
 <3c1d2343b034325dbc185ccd23a35b40a62a4e7b.1590132733.git.rahul.tanwar@linux.intel.com>
 <20200522085613.ktb2ruw2virj337v@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200522085613.ktb2ruw2virj337v-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, songjun.Wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, cheol.yong.kim-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, qi-ming.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


Hi Uwe,

Thanks for review.

On 22/5/2020 4:56 pm, Uwe Kleine-König wrote:
> Hello,
>
> On Fri, May 22, 2020 at 03:41:59PM +0800, Rahul Tanwar wrote:
>> Add PWM controller driver for Intel's Lightning Mountain(LGM) SoC.
>>
>> Signed-off-by: Rahul Tanwar <rahul.tanwar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> ---
>>  drivers/pwm/Kconfig         |   9 ++
>>  drivers/pwm/Makefile        |   1 +
>>  drivers/pwm/pwm-intel-lgm.c | 356 ++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 366 insertions(+)
>>  create mode 100644 drivers/pwm/pwm-intel-lgm.c
>>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index eebbc917ac97..a582214f50b2 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -232,6 +232,15 @@ config PWM_IMX_TPM
>>  	  To compile this driver as a module, choose M here: the module
>>  	  will be called pwm-imx-tpm.
>>  
>> +config PWM_INTEL_LGM
>> +	tristate "Intel LGM PWM support"
>> +	depends on X86 || COMPILE_TEST
>> +	help
>> +	  Generic PWM framework driver for LGM SoC.
[...]
>> +};
>> +
>> +static void tach_work(struct work_struct *work)
>> +{
>> +	struct intel_pwm_chip *pc = container_of(work, struct intel_pwm_chip,
>> +						 work.work);
>> +	struct regmap *regmap = pc->regmap;
>> +	u32 fan_tach, fan_dc, val;
>> +	s32 diff;
>> +	static u32 fanspeed_err_cnt, time_window, delta_dc;
>> +
>> +	/*
>> +	 * Fan speed is tracked by reading the active duty cycle of PWM output
>> +	 * from the active duty cycle register. Some variance in the duty cycle
>> +	 * register value is expected. So we set a time window of 30 seconds and
>> +	 * if we detect inaccurate fan speed 6 times within 30 seconds then we
>> +	 * mark it as fan speed problem and fix it by readjusting the duty cycle.
>> +	 */
> I'm a unhappy to have this in the PWM driver. The PWM driver is supposed
> to be generic and I think this belongs into a dedicated driver.

Well noted about all other review concerns. I will rework the driver in v2.
However, i am not very sure about the above point - of having a separate
dedicated driver for tach_work because its logic is tightly coupled with
this driver.

Regards,
Rahul
