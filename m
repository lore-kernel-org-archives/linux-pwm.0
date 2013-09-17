Return-Path: <mikedunn@newsguy.com>
Message-ID: <5238A5C2.4080902@newsguy.com>
Date: Tue, 17 Sep 2013 11:56:02 -0700
From: Mike Dunn <mikedunn@newsguy.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3] PWM: PXA: add device tree support to PWM driver
References: <1379091281-23662-1-git-send-email-mikedunn@newsguy.com> <52375FB1.5050700@wwwdotorg.org> <5238621D.3050504@newsguy.com> <52388093.2000401@wwwdotorg.org>
In-Reply-To: <52388093.2000401@wwwdotorg.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-ID: <linux-pwm.vger.kernel.org>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-pwm@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chao Xie <chao.xie@marvell.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ian.campbell@citrix.com>

On 09/17/2013 09:17 AM, Stephen Warren wrote:
> On 09/17/2013 08:07 AM, Mike Dunn wrote:
>> On 09/16/2013 12:44 PM, Stephen Warren wrote:
>>> On 09/13/2013 10:54 AM, Mike Dunn wrote:
>>>> This patch adds device tree support to the PXA's PWM driver.  Only an OF match
>>>> table is added; nothing needs to be extracted from the device tree node.  The
>>>> existing ID table is reused for the match table data.
>>>>
>>>> Tested on a Palm Treo 680 (both platform data and DT cases).
>>>
>>>> diff --git a/Documentation/devicetree/bindings/pwm/pxa-pwm.txt b/Documentation/devicetree/bindings/pwm/pxa-pwm.txt
>>>
>>>> +- compatible: should be one of:
>>>> +  - "marvell,pxa250-pwm"
>>>> +  - "marvell,pxa270-pwm"
>>>> +  - "marvell,pxa168-pwm"
>>>> +  - "marvell,pxa910-pwm"
>>>
>>> Not just one of, but possible more than one...
>>
>> So the phrasing should be "compatible: should be among:" ?
> 
> I think I've seen "One or more of".


OK.


> 
> 
>>>> diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
>>>
>>>> +		pwm0: pwm@40b00000 {
>>>> +			compatible = "marvell,pxa270-pwm";
>>>
>>> I thought the assertion was that pax270 and pxa250 were both compatible?
>>> If so, that should be:
>>>
>>> 		compatible = "marvell,pxa270-pwm", "marvell,pxa250-pwm";
>>
>>
>> Indeed.  Currently, they are all the same.  By that logic, shouldn't it be
>>
>> compatible = "marvell,pxa250-pwm", "marvell,pxa270-pwm", "marvell,pxa168-pwm",
>> "marvell,pxa910-pwm";
> 
> compatible should include:
> 
> * The exact HW model (so the driver knows exactly which HW is present in
> order to enable any bug quirks).
> * The "first" HW model this HW is compatible with, since this is what
> the driver will bind to (ignoring the possibility of bug quirks).
> 
> So, you don't need to include all the values, just two in this case.


I think I see...  and hypothetically, if the the driver must know that it is a
pxa270 in order for it to function correctly due to (hypothetical) hardware
differences, then only the first compatible string should appear?

Anyway, thanks again!  I'll resubmit tomorrow.

Mike
