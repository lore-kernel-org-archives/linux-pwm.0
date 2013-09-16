Return-Path: <mikedunn@newsguy.com>
Message-ID: <523718D3.4050003@newsguy.com>
Date: Mon, 16 Sep 2013 07:42:27 -0700
From: Mike Dunn <mikedunn@newsguy.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3] PWM: PXA: add device tree support to PWM driver
References: <1379091281-23662-1-git-send-email-mikedunn@newsguy.com> <201309151607.04244.marex@denx.de>
In-Reply-To: <201309151607.04244.marex@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-ID: <linux-pwm.vger.kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: linux-pwm@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Robert Jarzmik <robert.jarzmik@free.fr>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chao Xie <chao.xie@marvell.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>

On 09/15/2013 07:07 AM, Marek Vasut wrote:
> Dear Mike Dunn,
> 
>> This patch adds device tree support to the PXA's PWM driver.  Only an OF
>> match table is added; nothing needs to be extracted from the device tree
>> node.  The existing ID table is reused for the match table data.
>>
>> Tested on a Palm Treo 680 (both platform data and DT cases).
>>
>> Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
>> ---
>> Changle log:
>> v3:
>> - remove support for the polarity flag
>> - remove per-chip pwm index cell; define custom of_xlate()
>>    (now #pwm-cells = <1>)
>> - "compatible" strings for all devices added to OF match table
>> - various stylistic changes recommended by reviewers
>>
>> v2:
>> - of_match_table contains only the "pxa250-pwm" compatible string; require
>> one device instance per pwm
>> - add Documentation/devicetree/bindings/pwm/pxa-pwm.txt
>> - add support for polarity flag in DT and implement set_polarity() method
>>   (the treo 680 inverts the signal between pwm out and backlight)
>> - return -EINVAL instead of -ENODEV if platform data or DT node not found
>> - output dev_info string if platform data missing
>> - expanded CC list of patch
>>
>>  Documentation/devicetree/bindings/pwm/pxa-pwm.txt | 31 ++++++++++++
>>  arch/arm/boot/dts/pxa27x.dtsi                     | 24 +++++++++
>>  drivers/pwm/pwm-pxa.c                             | 62
>> +++++++++++++++++++++++ 3 files changed, 117 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pwm/pxa-pwm.txt
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/pxa-pwm.txt
>> b/Documentation/devicetree/bindings/pwm/pxa-pwm.txt new file mode 100644
>> index 0000000..6fcf90c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pwm/pxa-pwm.txt
>> @@ -0,0 +1,31 @@
>> +Marvell PWM controller
>> +
>> +Required properties:
>> +- compatible: should be one of:
>> +  - "marvell,pxa250-pwm"
>> +  - "marvell,pxa270-pwm"
>> +  - "marvell,pxa168-pwm"
>> +  - "marvell,pxa910-pwm"
> 
> This really is something I dont quite understand. Why should the driver list 
> _every_ _single_ existing CPU that contains such PWM block? Is there any 
> agreement about that? For me, it'd make much more sense to list only the CPUs 
> where the IP block actually changed in some way, so that the differences can be 
> discerned that way.

I believe that this was Stephen's suggestion.

I actually don't object myself.  For the price of a few strings, it
- clearly shows which SoCs the driver supports
- ensures that any future differences are handled cleanly (e.g., if a hw bug in
one is discovered and a work-around is implemented)
- keeps thngs clean if support for another processor which does have pwm hw
differences is added

Especially the third point... otherwise, you have the case of a somewhat
confusing many-to-one mapping of processors to compatible strings.

Thanks,
Mike
