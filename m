From: Scott Branden <scott.branden@broadcom.com>
Subject: Re: [PATCH] pwm: bcm-iproc: handle clk_get_rate() return
Date: Fri, 17 Jul 2020 11:24:40 -0700
Message-ID: <6f9b0a94-6289-990b-84b3-80d70e17d3e2@broadcom.com>
References: <20200717170743.25466-1-scott.branden@broadcom.com>
 <94f2aed1-d88d-3ee0-6e57-917f665951f2@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbgGQSYu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Jul 2020 14:24:50 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F01C0619D3
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2020 11:24:50 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id q17so5793234pfu.8
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2020 11:24:50 -0700 (PDT)
In-Reply-To: <94f2aed1-d88d-3ee0-6e57-917f665951f2@broadcom.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Ray Jui <ray.jui@broadcom.com>, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>



On 2020-07-17 10:22 a.m., Ray Jui wrote:
>
> On 7/17/2020 10:07 AM, Scott Branden wrote:
>> From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
>>
>> Handle clk_get_rate() returning <= 0 condition to avoid
>> possible division by zero.
>>
>> Fixes: daa5abc41c80 ("pwm: Add support for Broadcom iProc PWM controller")
>> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>> ---
>>   drivers/pwm/pwm-bcm-iproc.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
>> index 1f829edd8ee7..72a8607b6c8d 100644
>> --- a/drivers/pwm/pwm-bcm-iproc.c
>> +++ b/drivers/pwm/pwm-bcm-iproc.c
>> @@ -86,6 +86,11 @@ static void iproc_pwmc_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>>   	u32 value, prescale;
>>   
>>   	rate = clk_get_rate(ip->clk);
>> +	if (rate == 0) {
>> +		state->period = 0;
>> +		state->duty_cycle = 0;
>> +		return;
>> +	}
I'll move the logic after the polarity and enabled fields are populated.
> Based on the pwm core code, 'get_state' expects the following fields to
> be populated: 'polarity', 'enabled', 'period', and 'duty cycle'.
>
> The above logic will leave 'polarity' and 'enabled' completely
> unpopulated when clock rate is zero.
>
>>   
>>   	value = readl(ip->base + IPROC_PWM_CTRL_OFFSET);
>>   
>>
