From: Sean Cross <xobs@kosagi.com>
Subject: Re: [PATCH] pwm: imx: Support very long period lengths
Date: Mon, 28 Apr 2014 20:10:09 +0800
Message-ID: <535E4521.6070102@kosagi.com>
References: <1398675331-10980-1-git-send-email-xobs@kosagi.com> <1398675331-10980-2-git-send-email-xobs@kosagi.com> <20140428092255.GO5858@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail1.g1.pair.com ([66.39.3.162]:39696 "EHLO mail1.g1.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751874AbaD1MKP (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Mon, 28 Apr 2014 08:10:15 -0400
In-Reply-To: <20140428092255.GO5858@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org

On 04/28/14 17:22, Sascha Hauer wrote:
> On Mon, Apr 28, 2014 at 04:55:31PM +0800, Sean Cross wrote:
>> The IMX PWM block supports using both the system clock and a 32 kHz
>> clock for driving PWM events.  For very long period lengths, use the
>> 32 kHz clock instead of the high-speed clock.
>>
>> Signed-off-by: Sean Cross <xobs@kosagi.com>
>> ---
>>   drivers/pwm/pwm-imx.c | 14 +++++++++++---
>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
>> index cc47733..8410455 100644
>> --- a/drivers/pwm/pwm-imx.c
>> +++ b/drivers/pwm/pwm-imx.c
>> @@ -36,9 +36,11 @@
>>   #define MX3_PWMCR_DOZEEN                (1 << 24)
>>   #define MX3_PWMCR_WAITEN                (1 << 23)
>>   #define MX3_PWMCR_DBGEN			(1 << 22)
>> +#define MX3_PWMCR_CLKSRC_IPG_32K  (3 << 16)
>>   #define MX3_PWMCR_CLKSRC_IPG_HIGH (2 << 16)
>>   #define MX3_PWMCR_CLKSRC_IPG      (1 << 16)
>>   #define MX3_PWMCR_EN              (1 << 0)
>> +#define MX3_SLOW_THRESHOLD_NS	100000
>>   
>>   struct imx_chip {
>>   	struct clk	*clk_per;
>> @@ -107,7 +109,13 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
>>   	unsigned long period_cycles, duty_cycles, prescale;
>>   	u32 cr;
>>   
>> -	c = clk_get_rate(imx->clk_per);
>> +	if (duty_ns > MX3_SLOW_THRESHOLD_NS) {
> If anything you have to check the period_cycles, not the duty_cycles.
>
> 100000 seems to be some arbitrary value suitable for some unspecified
> ipg clock rate. I think you should use it when the period_cycles
> register overflows.
In this case, it's for a backlight controller that requires a 100 Hz 
clock.  But you're right, hard-coding the values is a bad idea.

With the prescaler and the period_cycles register, it might not actually 
overflow, but instead the resolution might become too poor to be 
useful.  The prescaler supports dividing by up to 4096, but it gets 
difficult to hit a particular value.

So with my target of a 100 Hz clock, it appears as though no values 
overflow yet I can't use IPG_HIGH.

What is the best way to handle this?
>> +		cr = MX3_PWMCR_CLKSRC_IPG_32K;
>> +		c = 32768;
> How about providing a proper clock instead of hardcoding this?
>
That seems like a lot of work, and I don't see any other PWM devices 
that do this.  If I understand the clock system, I'd have to add the 
following to pwm-imx.c:

     - Each PWM would get three new clocks added to its struct imx_chip 
-- a clk_ipg_mux, a clk_ipg_32k, and a clk_ipg_high
     - The struct imx_chip would also gain a clk_ckil entry for the 
32768 Hz clock
     - These three clocks would need to be created on _probe() and 
destroyed on _remove()
     - clk_ipg_32k would get reparented to ckil (or whatever the 32768 
Hz clock is on that platform)
     - clk_ipg_high would get reparented to imx->clk_per
     - The recalc_rate(), round_rate(), and set_rate() would need to be 
implemented (and calculated) for clk_ipg_32k and clk_ipg_high

Additionally, "ckil" would need to be added to the pwm entry for every 
dts file.

Is it worth it to add that much complexity?  What does it get us to have 
a proper clock?  Or have I overestimated the amount of rework involved?  
I'm happy to do it if you think it's necessary.


Sean
