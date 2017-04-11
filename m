From: m18063 <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH] drivers: pwm: pwm-atmel: implement suspend/resume
 functions
Date: Tue, 11 Apr 2017 12:41:59 +0300
Message-ID: <012f1ab5-0de4-a392-7b43-41077bf251a5@microchip.com>
References: <1491834020-3194-1-git-send-email-claudiu.beznea@microchip.com>
 <20170410163558.494cf9be@bbrezillon>
 <ba255c5b-ff6e-a6fd-0546-9dde04026f4c@microchip.com>
 <20170411105605.5ea65f75@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:57395 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751564AbdDKJmC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Apr 2017 05:42:02 -0400
In-Reply-To: <20170411105605.5ea65f75@bbrezillon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alexandre.belloni@free-electrons.com, nicolas.ferre@microchip.com



On 11.04.2017 11:56, Boris Brezillon wrote:
> On Tue, 11 Apr 2017 11:22:39 +0300
> m18063 <Claudiu.Beznea@microchip.com> wrote:
> 
>> Hi Boris,
>>
>> On 10.04.2017 17:35, Boris Brezillon wrote:
>>> On Mon, 10 Apr 2017 17:20:20 +0300
>>> Claudiu Beznea <claudiu.beznea@microchip.com> wrote:
>>>   
>>>> Implement suspend and resume power management specific
>>>> function to allow PWM controller to correctly suspend
>>>> and resume.
>>>>
>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>>>> ---
>>>>  drivers/pwm/pwm-atmel.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 81 insertions(+)
>>>>
>>>> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
>>>> index 530d7dc..75177c6 100644
>>>> --- a/drivers/pwm/pwm-atmel.c
>>>> +++ b/drivers/pwm/pwm-atmel.c
>>>> @@ -58,6 +58,8 @@
>>>>  #define PWM_MAX_PRD		0xFFFF
>>>>  #define PRD_MAX_PRES		10
>>>>  
>>>> +#define PWM_MAX_CH_NUM		(4)
>>>> +
>>>>  struct atmel_pwm_registers {
>>>>  	u8 period;
>>>>  	u8 period_upd;
>>>> @@ -65,11 +67,18 @@ struct atmel_pwm_registers {
>>>>  	u8 duty_upd;
>>>>  };
>>>>  
>>>> +struct atmel_pwm_pm_ctx {
>>>> +	u32 cmr;
>>>> +	u32 cdty;
>>>> +	u32 cprd;
>>>> +};
>>>> +
>>>>  struct atmel_pwm_chip {
>>>>  	struct pwm_chip chip;
>>>>  	struct clk *clk;
>>>>  	void __iomem *base;
>>>>  	const struct atmel_pwm_registers *regs;
>>>> +	struct atmel_pwm_pm_ctx ctx[PWM_MAX_CH_NUM];  
>>>
>>> Hm, I'm pretty sure you can rely on the current PWM state and call
>>> atmel_pwm_apply() at resume time instead of doing that. See what I did
>>> here [1].  
>>
>> I agree with the approach you propose but the thing is the atmel_pwm_apply()
>> take care of both, current PWM state and the new state received as argument
>> in order to change only duty factor without disabling the PWM channel (if
>> channel is enabled) and then returns. Changing PWM duty and period and polarity
>> in the same step without disabling + enabling the PWM channel (with atomic
>> approach) may lead to intermediary unwanted output waveforms (the IP doesn't
>> support this for ordinary PWM channels). To take advantage of atmel_pwm_apply()
>> (in the formit is today) in resume() hook might need to first call it to disable
>> channel and then to enable it. Or atmel_pwm_apply() should be changed to also
>> disable + enable the channel when user changes the duty factor at runtime.
> 
> Nope. Just save the state at suspend time, implement ->get_state() and
> use it to retrieve the real PWM state when resuming before restoring
> the state you saved during suspend.
Ok.
> But anyway, as Thierry explained, I'm not sure we should take the
> 're-apply PWM state' action here. It's probably better to leave this
> decision to the PWM user. 
Do you thinks we should proceed with restoring the registers behind
the re-apply as other drivers does at this moment?
> 
