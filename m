From: Olliver Schinagl <o.schinagl@ultimaker.com>
Subject: Re: [PATCH] pwm: sunxi: wait for the READY bit
Date: Mon, 20 Feb 2017 17:22:55 +0100
Message-ID: <03a0afa1-f9dc-819e-1926-a7b91526fcbd@schinagl.nl>
References: <20170103145732.2108-1-alexandre.belloni@free-electrons.com>
 <73f5fc87-717f-2238-b653-1b117359cbb8@schinagl.nl>
 <20170103164453.wtdi4mxdxogbx4i5@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170103164453.wtdi4mxdxogbx4i5@piout.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Olliver Schinagl <o.schinagl@ultimaker.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hey Alexandre,

Sorry for the very slow reply. We just bought a house so have been 
offline for 6+ weeks!


On 03-01-17 17:44, Alexandre Belloni wrote:
> On 03/01/2017 at 16:56:16 +0100, Olliver Schinagl wrote :
>> Hey Alexandre,
>>
>> I've sent several patches regarding pwm a while ago, sadly you never
>> responded [0]. So I guess this is a follow up from that?
>>
>
> Well, we had the issue and I just had a bit of time to look at it. As I
> remembered you kind of had the same issue, I chose to Cc you.
>
>> I couldn't quickly find the resubmitted version however.
>>
>
> Was there a new version?
I believe there was, but I think this is almost 18 - 24 months ago when 
I started these patches.

Anyhow,

>
>>>  	clk_gate = val & BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
>>> -	if (clk_gate) {
>>> -		val &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
>>> +
>>> +	if (sun4i_pwm->data->has_rdy && (val & PWM_RDY(pwm->hwpwm))) {
>>> +		val |= BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
>>>  		sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
>>> +
>>> +		err = readl_poll_timeout(sun4i_pwm->base + PWM_CTRL_REG, val,
>>> +					 !(val & PWM_RDY(pwm->hwpwm)), 400,
>>> +					 500000);
>>> +		if (err)
>>> +			goto finish;
>>>  	}
>>>
>> What happens on sun4i here? sun4i does not have the RDY flag, but it does
>> need the PWM_CLK_GATING to be active.
>>
>
> Does it actually need it? The datasheet doesn't say anything about it.

I'm fairly certain it does, everything needs the gate enabled to run. 
E.g. no clock gate enabled, the entire IP is unable to do anything.

> I'm actually wondering what happens if the period is written twice in a
> row without waiting. If the latest period is used, maybe we don't
> actually care.

That approach sounds a little hack-ish, (and I have forgot almost all 
context here, so forgive me) but basically you are suggesting to just 
spam the period register until it sticks?

Anyway, as I said, I'm fairly certain also the A10 needs the gate 
enabled to be able to 'eat' the data, so it looks like this would break 
things on A10.

>
>> maybe only the readl_poll_timeout() should be guarded by the has_rdy, where
>> you poll the register as you do now, and in the else just have a 'known safe
>> delay' to emulate the has_rdy behavior? I'm guessing a few clock cycles of
>> the PWM block. I don't think the documentation states how long this
>> could/should be.
>>
>
> My guess is that the IP is waiting for the current period to finish
> before updating the period internally. That would be the sane way to do it but
> maybe I'm an optimist.

Well that does sound logically; i'm guessing in pseudo code the vhdl 
likley looks like this

if (clk > HIGH) {
	if (counter < period) {
		counter++;
	} else {
		counter = 0;
		period = period_reg;
	}
}

where the clock only ticks if the clk_gate is active, otherwise clk 
never toggles from HIGH to LOW.

I'll give some more thought into this ...

Olliver

>
>> With my 'wait before disable' patch [1] I run into the same issue, I think.
>> We do not know how long to wait before the hardware is ready.
>>
>
> Up to 196.8s if I'm right...
>
