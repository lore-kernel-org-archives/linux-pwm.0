Return-Path: <swarren@wwwdotorg.org>
Message-ID: <522F4CF9.3070601@wwwdotorg.org>
Date: Tue, 10 Sep 2013 10:46:49 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
Subject: Re: [RESEND PATCH v2] pwm: pxa: add device tree support to pwm driver
References: <1378751420-19227-1-git-send-email-mikedunn@newsguy.com> <522E3B5B.90406@wwwdotorg.org> <522F40A3.9030701@newsguy.com>
In-Reply-To: <522F40A3.9030701@newsguy.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-ID: <linux-pwm.vger.kernel.org>
To: Mike Dunn <mikedunn@newsguy.com>
Cc: linux-pwm@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chao Xie <chao.xie@marvell.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ian.campbell@citrix.com>

On 09/10/2013 09:54 AM, Mike Dunn wrote:
> On 09/09/2013 02:19 PM, Stephen Warren wrote:
>> On 09/09/2013 12:30 PM, Mike Dunn wrote:
>>> This patch adds device tree support to the pxa's pwm driver.  Only an OF match
>>> table is added; nothing needs to be extracted from the device tree node.  The
>>> existing platform_device id table is reused for the match table data.  Support
>>> for inverted polarity is also added.
>>>
>>> Tested on a Palm Treo 680 (both platform data and DT cases).
>>
>>> diff --git a/Documentation/devicetree/bindings/pwm/pxa-pwm.txt b/Documentation/devicetree/bindings/pwm/pxa-pwm.txt
>>
>>> +Marvell pwm controller
>>
>> s/pwm/PWM/ throughout.
>>
>>> +
>>> +Required properties:
>>> +- compatible:
>>> +  for pxa25x, pxa27x, pxa168, pxa910: must be compatible = "marvell,pxa250-pwm";
>>
>> I think you want a separate compatible value for each HW, to allow for
>> any HW-specific quirks to be enabled later if required. So, you could
>> document "marvell,pxa250-pwm" as the basic compatible value that a
>> driver can bind to, yet also document the other values as being required
>> for the relevant HW?
> 
> IOW...
> - compatible: should be one of:
>   - "marvell,pxa250-pwm"
>   - "marvell,pxa270-pwm"
>   - "marvell,pxa168-pwm"
>   - "marvell,pxa910-pwm"
> 
> Even though the driver makes no functional distinction currently?

Yes (although it's fine to make the driver only look for the first of
those, since you say they're all compatible, and currently the driver
doesn't care about exactly which HW is in use).

>>> +- reg: physical base address and length of the registers used by the pwm channel
>>> +  NB: One device instance must be created for each pwm that is used, so the
>>> +  length covers only the register window for one pwm output, not that of the
>>> +  entire pwm controller.  Currently length is 0x10 for all supported devices.
>>> +- #pwm-cells: should be 3.
>>> +   cell 1: the per-chip index of the PWM to use,
>>
>> That cell shouldn't be needed if you really want to have one DT node per
>> PWM channel.
> 
> Yes, but I was afraid to deviate from the format used by the other PWM
> controllers.  (But in that case, it should at least be documented as "must be
> zero". Thanks.)  If going my owm way is acceptable, I'll define my own
> of_xlate() parser and remove this cell.

I don't think there's any issue with deviating; that's exactly what
#pwm-cells is for.
