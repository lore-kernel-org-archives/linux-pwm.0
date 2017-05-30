From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 1/2] gpio: mvebu: fix blink counter register selection
Date: Tue, 30 May 2017 15:06:13 +0200
Message-ID: <8737bmv6ii.fsf@free-electrons.com>
References: <20170530122848.2803-1-richard.genoud@gmail.com>
        <877f0yv6qa.fsf@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:50497 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751582AbdE3NGa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 30 May 2017 09:06:30 -0400
In-Reply-To: <877f0yv6qa.fsf@free-electrons.com> (Gregory CLEMENT's message of
        "Tue, 30 May 2017 15:01:33 +0200")
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Alexandre Courbot <gnurou@gmail.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Ralph Sennhauser <ralph.sennhauser@gmail.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Hi again,
 
 On mar., mai 30 2017, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Hi Richard,
>  
>  On mar., mai 30 2017, Richard Genoud <richard.genoud@gmail.com> wrote:
>
>> The blink counter A was always selected because 0 was forced in the
>> blink select counter register.
>> The variable 'set' was obviously there to be used as the register value,
>> selecting the B counter when id==1 and A counter when id==0.
>>
>> Tested on clearfog-pro (Marvell 88F6828)
>>
>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
>
> Looks good for me:
>
> Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>
> I thinks this one should go to v4.12-rc as it is a fix.
>
> As I modified the same part of the code in my series, I think I will
> have to rebase my series on top of this patch as soon as Linus Walleij
> will have accepted it.

I think we could also add:
Fixes: 757642f9a584 ("gpio: mvebu: Add limited PWM support")

Gregory

>
> Thanks,
>
> Gregory
>
>
>> ---
>>  drivers/gpio/gpio-mvebu.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
>> index 19a92efabbef..cdef2c78cb3b 100644
>> --- a/drivers/gpio/gpio-mvebu.c
>> +++ b/drivers/gpio/gpio-mvebu.c
>> @@ -747,7 +747,7 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
>>  		set = U32_MAX;
>>  	else
>>  		return -EINVAL;
>> -	writel_relaxed(0, mvebu_gpioreg_blink_counter_select(mvchip));
>> +	writel_relaxed(set, mvebu_gpioreg_blink_counter_select(mvchip));
>>  
>>  	mvpwm = devm_kzalloc(dev, sizeof(struct mvebu_pwm), GFP_KERNEL);
>>  	if (!mvpwm)
>
> -- 
> Gregory Clement, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
