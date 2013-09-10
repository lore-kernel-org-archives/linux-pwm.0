Return-Path: <mikedunn@newsguy.com>
Message-ID: <522F325B.4090602@newsguy.com>
Date: Tue, 10 Sep 2013 07:53:15 -0700
From: Mike Dunn <mikedunn@newsguy.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2] pwm: pxa: add device tree support to pwm driver
References: <1378669218-10944-1-git-send-email-mikedunn@newsguy.com> <20130909120845.GB22197@ulmo> <522E0D72.3080805@newsguy.com> <522E14F5.1020909@wwwdotorg.org>
In-Reply-To: <522E14F5.1020909@wwwdotorg.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-ID: <linux-pwm.vger.kernel.org>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chao Xie <chao.xie@marvell.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ian.campbell@citrix.com>

On 09/09/2013 11:35 AM, Stephen Warren wrote:
> On 09/09/2013 12:03 PM, Mike Dunn wrote:
>> On 09/09/2013 05:08 AM, Thierry Reding wrote:
>>> On Sun, Sep 08, 2013 at 12:40:18PM -0700, Mike Dunn wrote:
>>>> This patch adds device tree support to the pxa's pwm driver.  Only an OF match
> 
>>>> diff --git a/Documentation/devicetree/bindings/pwm/pxa-pwm.txt b/Documentation/devicetree/bindings/pwm/pxa-pwm.txt
> 
>>>> +Marvell pwm controller
>>>> +
>>>> +Required properties:
>>>> +- compatible:
>>>> +  for pxa25x, pxa27x, pxa168, pxa910: must be compatible = "marvell,pxa250-pwm";
>>>> +- reg: physical base address and length of the registers used by the pwm channel
>>>
>>> "pwm" -> "PWM". There are a few more occurrences that I haven't
>>> explicitly pointed out.
>>>
>>>> +  NB: One device instance must be created for each pwm that is used, so the
>>>> +  length covers only the register window for one pwm output, not that of the
>>>> +  entire pwm controller.  Currently length is 0x10 for all supported devices.
>>>
>>> I'm not sure I like that very much. It seems a wrong representation of
>>> the hardware for the sake of modifying a smaller number of lines in the
>>> driver.
>>
>> I don't like it either, but this is an existing driver defect that will need to
>> be corrected.  To do so, I will need to to survey all the supported processors
>> to determine how many pwm outputs is posessed by each.  And there may be some
>> confusion in that regard; the driver says "pxa25x" has one, but my pxa255
>> developer's manual makes no mention of a pwm.  The pxa270 I am testing on has
>> four, but the driver says "pxa27x" has two, so currently (using platform_data
>> with existing driver) two devices are instantiated, each with two pwms.  It
>> seems that there are many variations within a single generation of the processor
>> family, so to correctly identify the number of pwms, processor identification
>> will have to be made on a finer granularity than the current "pxa25x", for
>> example.  I'm guessing that the hardware designers had this
>> one-device-instance-per-pwm approach in mind when they made the decision to
>> segregate the register sets of each pwm.  I really hope that this sin can be
>> forgiven :)
> 
> The DT binding is an ABI, so it needs to correctly represent the HW. As
> such, I'd say that if the binding is wrong, we need to fix it even if it
> means a lot of work.
> 
> That said, if each PWM truly is a *completely* independent block, with
> non-overlapping register spaces, there's certainly an argument that it's
> perfectly acceptable to represent each PWM as a separate DT node...


Thanks Stephen.  Yes, each pwm output has its own registers with no common
control registers.  The only commonality is that they all share a clock in the
clock unit.  But this is handled in the clock manager.

Thanks,
Mike
