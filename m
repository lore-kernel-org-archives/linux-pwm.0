Return-Path: <mikedunn@newsguy.com>
Message-ID: <5228AC56.6020200@newsguy.com>
Date: Thu, 05 Sep 2013 09:07:50 -0700
From: Mike Dunn <mikedunn@newsguy.com>
MIME-Version: 1.0
Subject: Re: [PATCH] pwm: pxa: add device tree support to pwm driver
References: <1378236233-15637-1-git-send-email-mikedunn@newsguy.com> <201309050011.01808.marex@denx.de> <5228A238.2090202@newsguy.com> <201309051734.40570.marex@denx.de>
In-Reply-To: <201309051734.40570.marex@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-ID: <linux-pwm.vger.kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Thierry Reding <thierry.reding@gmail.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Grant Likely <grant.likely@linaro.org>, Robert Jarzmik <robert.jarzmik@free.fr>

On 09/05/2013 08:34 AM, Marek Vasut wrote:
>>>

[...]


>>> compatbile=marvell,pxa25x-pwm , no ? The lowest CPU with the block.
>>
>> Unless I am missing something, the compatible string does not need to
>> replicate any of the existing platform_device_id names, so wouldn't
>> "marvell,pxa" be better?  Except for register mapping and the number of
>> units present on a particular pxa variant, the peripheral is software
>> compatible across all pxa processors.  Plus there is the problem of the
>> 'x' wildcard in "pxa25x-pwm".
> 
> So use pxa250 ?
> 
> My concern is once marvell comes up with PXA1048576 which will have a different 
> PWM unit, then what will be the name for this new one?


I see.  OK then, pxa250 it is.

Thanks Marek,
Mike
