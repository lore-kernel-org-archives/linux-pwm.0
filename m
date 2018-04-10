From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH V2 3/9] dt-bindings: Tegra186 tachometer device tree
 bindings
Date: Tue, 10 Apr 2018 06:43:41 -0700
Message-ID: <b735b140-314e-80f3-b8a4-660c573897b1@roeck-us.net>
References: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
 <1521607244-29734-4-git-send-email-rrajk@nvidia.com>
 <20180327145249.xjoo42qow34ksdle@rob-hp-laptop>
 <867aace8-dac7-51d4-bd46-15919b58b37d@kapsi.fi>
 <CAL_Jsq+AsUiWWBQ7K4OUM58KqQbvBHuFYmXxXLwr7viwoKW-Yw@mail.gmail.com>
 <615d6771-00c3-a4a7-a99f-ec4f6e667c8f@kapsi.fi>
 <CAL_JsqJ-ZJtprXcLxVhRGKp30DTFRO1NzNoqpeSne0marcnmBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqJ-ZJtprXcLxVhRGKp30DTFRO1NzNoqpeSne0marcnmBQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Mikko Perttunen <cyndis@kapsi.fi>
Cc: Rajkumar Rampelli <rrajk@nvidia.com>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Timur Tabi <timur@codeaurora.org>, Andy Gross <andy.gross@linaro.org>, Wei Xu <xuwei5@hisilicon.com>, Alex Elder <elder@linaro.org>, "heiko@sntech.de" <heiko@sntech.de>, Krzysztof Kozlowski <krzk@>
List-Id: linux-pwm@vger.kernel.org

On 04/10/2018 06:30 AM, Rob Herring wrote:
> On Mon, Apr 9, 2018 at 9:37 AM, Mikko Perttunen <cyndis@kapsi.fi> wrote:
>>
>>
>> On 04/09/2018 04:21 PM, Rob Herring wrote:
>>>
>>> On Mon, Apr 9, 2018 at 12:38 AM, Mikko Perttunen <cyndis@kapsi.fi> wrote:
>>>>
>>>> Rob,
>>>
>>>
>>> Please don't top post to lists.
>>>
>>>> this binding is for a specific IP block (for measuring/aggregating input
>>>> pulses) on the Tegra186 SoC, so I don't think it fits into any generic
>>>> binding.
>>>
>>>
>>> What is it hooked up to to measure? You only mention "fan" five times
>>> in the doc.
>>
>>
>> In practice, fans.
>>
>>>
>>> You have #pwm-cells too, so this block has PWM output as well? If not,
>>> then where's the PWM for the fan control because there is no point in
>>> having fan tach without some control mechanism.
>>
>>
>> It doesn't provide a PWM output. The (Linux) PWM framework provides
>> functionality in both directions - control and capture. But if the device
>> tree #pwm-cells/pwms properties are only for control, we may need to
>> introduce a new #capture-pwm-cells/capture-pwms or similar.
> 
> Yes, perhaps. But there is no point in having
> #capture-pwm-cells/capture-pwms if you aren't describing the
> connection between the fan and the fan controller.
> 
>> The idea is that the generic fan node can then specify two pwms, one for
>> control and one for capture, to enable e.g. closed-loop control (I'm not
>> personally familiar with the usecase for this but I could imagine something
>> like that). The control PWM can be something completely different, maybe not
>> a PWM in the first place (e.g. some fixed voltage).
> 
> Yes. As you can have different types of fans (3-wire, 4-wire, etc.)
> they would have different compatibles and differing properties
> associated with them.
> 
>>> There's only so many ways to control fans and types of fans, so yes,
>>> the interface of control and feedback lines between a fan and its
>>> controller should absolutely be generic.
>>
>>
>> I'm not quite getting what you mean by this. Clearly we need a custom
>> compatibility string for the tachometer as it's a different hardware block
>> with different programming than others.
> 
> Yes, of course. It's the interface between fan controllers and fans
> that I'm concerned about.
> 
>> Or are you complaining about the
>> nvidia,pulse-per-rev/capture-window-len properties?
> 
> Well, those sound like properties of a fan (at least the first one),
> so they belong in a fan node.
> 
> The aspeed fan controller is probably the closest thing we have to a
> fan binding. Look at that if you haven't already.
> 

FWIW, this is a fan speed (tachometer) counter which is modeled as pwm input.
This, in my opinion, and as stated before, is conceptually wrong. The pwm
subsystem should not (need to) know anything about fans, much less about
specifics such as the number of pulses per revolution.

Guenter
