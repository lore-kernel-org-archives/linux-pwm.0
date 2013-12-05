From: Bo Shen <voice.shen@atmel.com>
Subject: Re: [PATCH v8 1/2] PWM: atmel-pwm: add PWM controller driver
Date: Thu, 5 Dec 2013 09:11:28 +0800
Message-ID: <529FD2C0.6080707@atmel.com>
References: <1384766002-2852-1-git-send-email-voice.shen@atmel.com>
 <20131202105957.GD18060@ulmo.nvidia.com> <529D4B58.9020700@atmel.com>
 <20131203094326.GB21178@ulmo.nvidia.com> <529E9AA2.8020400@atmel.com>
 <20131204100340.GU19943@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131204100340.GU19943@ulmo.nvidia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, nicolas.ferre@atmel.com, linux-kernel@vger.kernel.org, alexandre.belloni@free-electrons.com, Bo Shen <voice.shen@atmel.com>, galak@codeaurora.org, plagnioj@jcrosoft.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hi Thierry,

On 12/04/2013 06:03 PM, Thierry Reding wrote:
> On Wed, Dec 04, 2013 at 10:59:46AM +0800, Bo Shen wrote:
>> Hi Thierry,
>>
>> On 12/03/2013 05:43 PM, Thierry Reding wrote:
>>> On Tue, Dec 03, 2013 at 11:09:12AM +0800, Bo Shen wrote:
>>>> On 12/02/2013 06:59 PM, Thierry Reding wrote:
>>>>> On Mon, Nov 18, 2013 at 05:13:21PM +0800, Bo Shen wrote:
>>> [...]
>>>>>> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
>>> [...]
>>>>>> +	/* Calculate the period cycles */
>>>>>> +	while (div > PWM_MAX_PRD) {
>>>>>> +		div = clk_rate / (1 << pres);
>>>>>> +		div = div * period_ns;
>>>>>> +		/* 1/Hz = 100000000 ns */
>>>>>
>>>>> I don't think that comment is needed.
>>>>
>>>> This is asked to be added.
>>>> And, I think keep it and it won't hurt, what do you think?
>>>
>>> I think it's obvious that you're converting from nanoseconds because of
>>> the _ns prefix in period_ns. But if somebody requested this and everyone
>>> else thinks it's useful, I'm okay with keeping it.
>>>
>>>>>> +	if (test_bit(PWMF_ENABLED, &pwm->flags)) {
>>>>>> +		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV2_CDTYUPD, dty);
>>>>>> +	} else {
>>>>>> +		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV2_CDTY, dty);
>>>>>> +		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV2_CPRD, prd);
>>>>>> +	}
>>>>>> +}
>>>>>
>>>>> Neither version 1 nor version 2 seem to be able to change the period
>>>>> while the channel is enabled. Perhaps that should be checked for in
>>>>> atmel_pwm_config() and an error (-EBUSY) returned?
>>>>
>>>> The period is configured in dt in device tree, or platform data in non
>>>> device tree. Nowhere will update period. So, not code to update period.
>>>> Am I right? If not, please figure out.
>>>
>>> The .config() operation allows the period to be specified. Just because
>>> nobody currently changes it at runtime doesn't mean it can't be done.
>>>
>>> It is also possible that whoever wrote the device tree or platform data
>>> didn't know that the period must be the same for all PWM channels and
>>> therefore might use different values. If you check for this, at least
>>> they'll notice. If you don't check for it, then they may end up having
>>> the period reconfigured behind their backs, which may cause parts of
>>> their setup to behave unexpectedly.
>>
>> Thanks for this information.
>> I will add code for changing period.
>
> Just to clarify: I wouldn't want this code to allow changing the period
> but rather reject incompatible changes to the period with an error code.

So, in this patch, just check it as you suggested in previous email, 
would it be OK?
--->8---
Perhaps that should be checked for in atmel_pwm_config() and an error 
(-EBUSY) returned?
---8<---

> Thierry

Best Regards,
Bo Shen
