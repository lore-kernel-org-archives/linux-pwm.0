From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Subject: Re: [PATCH 1/2] pwm: loongson1: Add PWM driver for Loongson1 SoC
Date: Thu, 16 Feb 2017 10:27:15 +0100
Message-ID: <0d0c43f5-1016-4cb5-01f8-9ca82860b8ad@imgtec.com>
References: <20170213152801.GA32019@ubuntu>
 <f27d34d4-b0ac-2fd6-bc75-89a6c913ba3c@imgtec.com>
 <20170215130902.GA32795@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170215130902.GA32795@ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
To: Yang Ling <gnaygnil@gmail.com>
Cc: thierry.reding@gmail.com, keguang.zhang@gmail.com, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-mips@linux-mips.org
List-Id: linux-pwm@vger.kernel.org

Hi Yang,

On 15.02.2017 14:09, Yang Ling wrote:

>>> +	tmp = (unsigned long long)clk_get_rate(pc->clk) * period_ns;
>>> +	do_div(tmp, 1000000000);

NSEC_PER_SEC ?

>>> +	period = tmp;
>>> +
>>> +	tmp = (unsigned long long)period * duty_ns;
>>> +	do_div(tmp, period_ns);
>>> +	duty = period - tmp;
>>> +
>>> +	if (duty >= period)
>>> +		duty = period - 1;
>>> +
>>> +	if (duty >> 24 || period >> 24)
>>> +		return -EINVAL;
>>> +
>>> +	chan->period_ns = period_ns;
>>> +	chan->duty_ns = duty_ns;
>>> +
>>> +	writel(duty, pc->base + PWM_HRC(pwm->hwpwm));
>>> +	writel(period, pc->base + PWM_LRC(pwm->hwpwm));
>>> +	writel(0x00, pc->base + PWM_CNT(pwm->hwpwm));
>>> +
>>
>> PWM_HRC and PWM_LRC names suggest that you're using high/low state
>> counters here rather than duty/period - but with no documentation
>> I'm just guessing here.
>
> Indeed, the high/low state counters is used here.
> Change the name to duty_cnt/period_cnt.
>
>

What I was referring to here is that if you have a high/low value 
counters that you enter then these are not the same as duty/period, in 
simple terms:
high_cnt = duty_cnt
low_cnt = period_cnt - duty_cnt

so please double check that this is what you want to be doing? As the 
names used suggest that this code may be wrong. Or maybe what you're 
doing is correct but the register access macros have misleading names?

Marcin
