From: Pascal Roeleven <dev-/1Tg0gxlrOS4ObxHbWkkimZHpeb/A1Y/@public.gmane.org>
Subject: Re: [RFC PATCH 4/4] pwm: sun4i: Delay after writing the period
Date: Wed, 22 Apr 2020 10:40:11 +0200
Message-ID: <fd36eddb87b529498e0429afe3521da7@pascalroeleven.nl>
References: <20200317155906.31288-1-dev@pascalroeleven.nl>
 <20200317155906.31288-5-dev@pascalroeleven.nl>
 <f1d9a17e-df9e-dc12-603d-84e908a04b81@sholland.org>
Reply-To: dev-/1Tg0gxlrOS4ObxHbWkkimZHpeb/A1Y/@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Return-path: <linux-sunxi+bncBDVPTC5KRECBB7MFQD2QKGQEMERTZWI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <f1d9a17e-df9e-dc12-603d-84e908a04b81-RkNLwX/CsU9g9hUCZPvPmw@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Samuel Holland <samuel-RkNLwX/CsU9g9hUCZPvPmw@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Uwe_Kleine-K?= =?UTF-8?Q?=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On 2020-04-22 05:43, Samuel Holland wrote:
> Hello Pascal,
> 
> On 3/17/20 10:59 AM, Pascal Roeleven wrote:
>> When disabling, ensure the period write is complete before continuing.
>> This fixes an issue on some devices when the write isn't complete 
>> before
>> the panel is turned off but the clock gate is still on.
>> 
>> Signed-off-by: Pascal Roeleven <dev-/1Tg0gxlrOS4ObxHbWkkimZHpeb/A1Y/@public.gmane.org>
>> ---
>>  drivers/pwm/pwm-sun4i.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>> 
>> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
>> index a11d00f96..75250fd4c 100644
>> --- a/drivers/pwm/pwm-sun4i.c
>> +++ b/drivers/pwm/pwm-sun4i.c
>> @@ -299,6 +299,10 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, 
>> struct pwm_device *pwm,
>>  	sun4i_pwm_writel(sun4i_pwm, val, PWM_CH_PRD(pwm->hwpwm));
>>  	next_period = jiffies + usecs_to_jiffies(cstate.period / 1000 + 1);
>> 
>> +	/* When disabling, make sure the period register is written first */
>> +	if (!state->enabled && cstate.enabled)
>> +		sun4i_pwm_wait(next_period);
>> +
> 
> It is not visible from the context of this patch, but this call to
> sun4i_pwm_wait() ends up calling msleep() inside a spinlock, which 
> isn't
> allowed. The spinlock should probably be converted to a mutex, 
> considering that
> sun4i_pwm_apply() already sleeps and takes mutexes.
> 
> Regards,
> Samuel
> 

Yes you're right. A different implementation of this patch series is 
being worked on, in which I'll take this into account. Unfortunately I 
have other things to work on at the moment, so it might take a while.

Regards,
Pascal
