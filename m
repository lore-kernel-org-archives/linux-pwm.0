From: Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [RFC 1/4] pwm: sifive: Add DT documentation for SiFive PWM
 Controller.
Date: Tue, 16 Oct 2018 10:31:42 -0700
Message-ID: <6e108e3c-15c1-b13b-ac3e-60c5eb209c7b@sifive.com>
References: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
 <1539111085-25502-2-git-send-email-atish.patra@wdc.com>
 <20181010134926.GD21134@ulmo> <25758ab9-eb36-741b-6264-42412b3ddd8e@wdc.com>
 <20181016110142.GC8852@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181016110142.GC8852@ulmo>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Atish Patra <atish.patra@wdc.com>, Rob Herring <robh+dt@kernel.org>
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Wesley Terpstra <wesley@sifive.com>, linus.walleij@linaro.org, palmer@sifive.com, linux-kernel@vger.kernel.org, hch@infradead.org, linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org


On 10/16/18 4:01 AM, Thierry Reding wrote:
> On Mon, Oct 15, 2018 at 03:57:35PM -0700, Atish Patra wrote:
>> On 10/10/18 6:49 AM, Thierry Reding wrote:
>>> On Tue, Oct 09, 2018 at 11:51:22AM -0700, Atish Patra wrote:
>>>> +Required properties:
>>>> +- compatible: should be one of
>>>> +	"sifive,fu540-c000-pwm0","sifive,pwm0".
>>> What's the '0' in here? A version number?
>>>
>> I think yes. Since fu540 is the first Linux capable RISC-V core, SiFive Guys
>> decided mark it as version 0.
>>
>> @Wesly: Please correct me if I am wrong.
> It seems fairly superfluous to me to have a version number in additon to
> the fu540-c000, which already seems to be the core plus some sort of
> part number. Do you really expect there to be any changes in the SoC
> that would require a different compatible string at this point? If the
> SoC has taped out, how will you ever get a different version of the PWM
> IP in it?
>
> I would expect any improvements or changes to the PWM IP to show up in a
> different SoC generation, at which point it would be something like
> "sifive,fu640-c000" maybe, or perhaps "sifive,fu540-d000", or whatever
> the numbering is.


The "0" suffix refers to a revision number for the underlying PWM IP block.

It's certainly important to keep that version number on the 
"sifive,pwm0" compatible string that doesn't have the chip name 
associated with it.

As to whether there could ever be a FU540-C000 part with different IP 
block versions on it: FU540-C000 is ultimately a marketing name.  While 
theoretically we shouldn't have another "FU540-C000" chip with different 
peripheral IP block versions on it, I don't think any engineer can 
guarantee that it won't happen.


- Paul
