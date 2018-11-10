From: Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [RFC 1/4] pwm: sifive: Add DT documentation for SiFive PWM
 Controller.
Date: Fri, 9 Nov 2018 21:38:41 -0800
Message-ID: <e4e80da0-103b-1812-3478-8331e867a914@sifive.com>
References: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
 <1539111085-25502-2-git-send-email-atish.patra@wdc.com>
 <20181010134926.GD21134@ulmo> <25758ab9-eb36-741b-6264-42412b3ddd8e@wdc.com>
 <20181016110142.GC8852@ulmo>
 <6e108e3c-15c1-b13b-ac3e-60c5eb209c7b@sifive.com>
 <20181016220437.GB31973@mithrandir>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181016220437.GB31973@mithrandir>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Atish Patra <atish.patra@wdc.com>, Rob Herring <robh+dt@kernel.org>, mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Wesley Terpstra <wesley@sifive.com>, linus.walleij@linaro.org, palmer@sifive.com, linux-kernel@vger.kernel.org, hch@infradead.org, linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org


On 10/16/18 3:04 PM, Thierry Reding wrote:
> On Tue, Oct 16, 2018 at 10:31:42AM -0700, Paul Walmsley wrote:
>> On 10/16/18 4:01 AM, Thierry Reding wrote:
>>> On Mon, Oct 15, 2018 at 03:57:35PM -0700, Atish Patra wrote:
>>>> On 10/10/18 6:49 AM, Thierry Reding wrote:
>>>>> On Tue, Oct 09, 2018 at 11:51:22AM -0700, Atish Patra wrote:
>>>>>> +Required properties:
>>>>>> +- compatible: should be one of
>>>>>> +	"sifive,fu540-c000-pwm0","sifive,pwm0".
>>>>> What's the '0' in here? A version number?
>>>>>
>>>> I think yes. Since fu540 is the first Linux capable RISC-V core, SiFive Guys
>>>> decided mark it as version 0.
>>>>
>>>> @Wesly: Please correct me if I am wrong.
>>> It seems fairly superfluous to me to have a version number in additon to
>>> the fu540-c000, which already seems to be the core plus some sort of
>>> part number. Do you really expect there to be any changes in the SoC
>>> that would require a different compatible string at this point? If the
>>> SoC has taped out, how will you ever get a different version of the PWM
>>> IP in it?
>>>
>>> I would expect any improvements or changes to the PWM IP to show up in a
>>> different SoC generation, at which point it would be something like
>>> "sifive,fu640-c000" maybe, or perhaps "sifive,fu540-d000", or whatever
>>> the numbering is.
>>
>> The "0" suffix refers to a revision number for the underlying PWM IP block.
>>
>> It's certainly important to keep that version number on the "sifive,pwm0"
>> compatible string that doesn't have the chip name associated with it.
> Isn't the hardware identified by "sifive,pwm0" and "sifive,fu540-c000"
> effectively identical? 


The intention was that the "sifive,pwm0" compatible string specifies a
register interface and programming model that the IP block exposes to
the software, rather than a particular underlying hardware
implementation.  That is in contrast to a string like
"sifive,fu540-c000-pwm" which might activate particular workarounds or
quirks that are specific to the integration of the IP block on a given SoC.


The idea is that, for this and similar open-source hardware IP blocks,
the driver code can just match on a generic "sifive,pwm0" compatible
string.  The SoC DT data would include both the SoC-specific
"sifive,fu540-c000-pwm0" and the common interface "sifive,pwm0".  But
the driver would only need the SoC-specific compatible string if the SoC
wound up needing some SoC-specific quirks.


In the past, some folks have had a problem with that idea, since for
closed-source IP blocks, it's been difficult to determine what changes
went into a specific version of the IP block.  Thus folks generating
data for later SoCs usually specify a compatible string for another,
older, SoC that seems to have the desired behavior.  But since this
particular IP block has open-source RTL, and contains a "sifive,pwmX"
version string in the RTL itself:


https://github.com/sifive/sifive-blocks/blob/master/src/main/scala/devices/pwm/PWM.scala#L74


... it's straightforward to see what interface the hardware exposes to
the software for a given compatible string.


> Is there a need to have two compatible strings
> that refer to the exact same hardware?


There's no intention that "sifive,pwm0" and "sifive,fu540-c000-pwm0"
refer to the same hardware; just the same software interface and
programming model.  Even now, it's usually pretty unlikely that two
different SoCs that refer to (say) "nvidia,tegra20-pwm" contain the same
hardware, since differences in synthesis, place and route, ECOs, and
integration change the actual realization of the hardware.  Some folks
interpreted that compatible string reuse as implying the same "hardware"
is in use on both SoCs, but we're really just identifying a software
interface.


>> As to whether there could ever be a FU540-C000 part with different IP block
>> versions on it: FU540-C000 is ultimately a marketing name.  While
>> theoretically we shouldn't have another "FU540-C000" chip with different
>> peripheral IP block versions on it, I don't think any engineer can guarantee
>> that it won't happen.
> I would argue that if at some point there was indeed a chip with the
> same name but a different IP block version in it, we can figure out what
> to call it. Sure there are no guarantees, but it's still fairly unlikely
> in my opinion, so I personally wouldn't worry about this up front.
>
> Anyway, I don't feel strongly either way, I'm just pointing out that
> this is somewhat unusual. If you want to keep it, feel free to.


Thanks for the review, Thierry -


- Paul
