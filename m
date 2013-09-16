Return-Path: <swarren@wwwdotorg.org>
Message-ID: <52378E2D.1060002@wwwdotorg.org>
Date: Mon, 16 Sep 2013 17:03:09 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] PWM: PXA: add device tree support to PWM driver
References: <1379091281-23662-1-git-send-email-mikedunn@newsguy.com> <52375FB1.5050700@wwwdotorg.org> <201309170101.06640.marex@denx.de>
In-Reply-To: <201309170101.06640.marex@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-ID: <linux-pwm.vger.kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: Mike Dunn <mikedunn@newsguy.com>, linux-pwm@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Robert Jarzmik <robert.jarzmik@free.fr>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chao Xie <chao.xie@marvell.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ian.campbell@citrix.com>

On 09/16/2013 05:01 PM, Marek Vasut wrote:
> Dear Stephen Warren,
> 
>> On 09/13/2013 10:54 AM, Mike Dunn wrote:
>>> This patch adds device tree support to the PXA's PWM driver.  Only an OF
>>> match table is added; nothing needs to be extracted from the device tree
>>> node.  The existing ID table is reused for the match table data.
>>>
>>> Tested on a Palm Treo 680 (both platform data and DT cases).
>>>
>>> diff --git a/Documentation/devicetree/bindings/pwm/pxa-pwm.txt
>>> b/Documentation/devicetree/bindings/pwm/pxa-pwm.txt
>>>
>>> +- compatible: should be one of:
>>> +  - "marvell,pxa250-pwm"
>>> +  - "marvell,pxa270-pwm"
>>> +  - "marvell,pxa168-pwm"
>>> +  - "marvell,pxa910-pwm"
>>
>> Not just one of, but possible more than one...
>>
>>> diff --git a/arch/arm/boot/dts/pxa27x.dtsi
>>> b/arch/arm/boot/dts/pxa27x.dtsi
>>>
>>> +		pwm0: pwm@40b00000 {
>>> +			compatible = "marvell,pxa270-pwm";
>>
>> I thought the assertion was that pax270 and pxa250 were both compatible?
>> If so, that should be:
>>
>> 		compatible = "marvell,pxa270-pwm", "marvell,pxa250-pwm";
> 
> I see what you mean with the compatible strings ... but if we have this 
> "fallback" compatiblity string, do we also need the table of all chips sporting 
> the IP block in the driver itself?

I would assume the driver can just support "marvell,pxa250-pwm" for now.
