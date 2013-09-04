Return-Path: <mikedunn@newsguy.com>
Message-ID: <522754A3.8010602@newsguy.com>
Date: Wed, 04 Sep 2013 08:41:23 -0700
From: Mike Dunn <mikedunn@newsguy.com>
MIME-Version: 1.0
Subject: Re: [PATCH] pwm: pxa: add device tree support to pwm driver
References: <1378236233-15637-1-git-send-email-mikedunn@newsguy.com> <201309040020.55029.marex@denx.de> <5227425E.7030806@newsguy.com> <201309041635.26695.marex@denx.de>
In-Reply-To: <201309041635.26695.marex@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-ID: <linux-pwm.vger.kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Thierry Reding <thierry.reding@gmail.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Grant Likely <grant.likely@linaro.org>, Robert Jarzmik <robert.jarzmik@free.fr>

On 09/04/2013 07:35 AM, Marek Vasut wrote:
> Dear Mike Dunn,
> 
>> On 09/03/2013 03:20 PM, Marek Vasut wrote:
>>
>> [...]
>>
>>>> +#ifdef CONFIG_OF
>>>> +/* use the platform_device id table for OF match table data */
>>>> +static struct of_device_id pwm_of_match[] = {
>>>> +	{ .compatible = "marvell,pxa25x-pwm", .data = &pwm_id_table[0] },
>>>> +	{ .compatible = "marvell,pxa27x-pwm", .data = &pwm_id_table[1] },
>>>> +	{ .compatible = "marvell,pxa168-pwm", .data = &pwm_id_table[2] },
>>>> +	{ .compatible = "marvell,pxa910-pwm", .data = &pwm_id_table[3] },
>>>> +	{ }
>>>> +};
>>>> +MODULE_DEVICE_TABLE(of, pwm_of_match);
>>>
>>> Are PXA2xx and PXA3xx PWM impleemntations not all the same ? If so, why
>>> not just stick with pxa25x-pwm only for all of the CPUs (aka. the lowest
>>> CPU model). Then the table would have but a single entry.
>>
>> I'm just echoing the existing platform_device_id table...
>>
>> static const struct platform_device_id pwm_id_table[] = {
>> 	/*   PWM    has_secondary_pwm? */
>> 	{ "pxa25x-pwm", 0 },
>> 	{ "pxa27x-pwm", HAS_SECONDARY_PWM },
>> 	{ "pxa168-pwm", 0 },
>> 	{ "pxa910-pwm", 0 },
>> 	{ },
>> };
>> MODULE_DEVICE_TABLE(platform, pwm_id_table);
>>
>> ... so that my changes to the driver are minimal.  Yes, apparently the only
>> difference is the existance of a "secondary" pwm for pxa27x.
>>
>> BTW, the pxa27x actually has four pwms, which is why the addition I made to
>> pxa27x.dtsi has two nodes (the driver handles two pwms for each device
>> instance in the pxa27x case).
>>
> 
> What's that "secondary PWM" there? I no longer remember, sorry. 


If pdev->id_entry->driver_data == HAS_SECONDARY_PWM, then pwm_chip->npwm=2 when
pwmchip_add() is called.  Otherwise pwm_chip->npwm=1.  The driver knows that the
second pwm's registers are at a fixed offset from the first.  For compatibility,
the pxa27x maps the registers for the third pwm at a distant offset, and makes
the offset between 3 and 4 the same as between 1 and 2.  Yes, the driver mkes
this unnecessarily complicated.  There should just be one device instance per
pwm, and dispense with the whole driver_data thing.  I guess there's some
history there.


> The question 
> remains still, we can have two entries there (pxa25x and pxa27x) ORR have one 
> entry (pxa25x) + mrvl,has-secondary-pwm entry.


It looks like defining "compatible" properties that mirror the old
platform_device_id names won't fly... wildcards are verboten (see Sergei's
comment).  So your inclination to use one value for the "compatible" property is
correct.  I think the way to go is to forget the whole HAS_SECONDARY_PWM in the
DT case, have one device instance per pwm, and use "compatible=marvell,pwm".
Other suggestions welcome.

Thanks,
Mike
