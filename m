From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V2 3/9] dt-bindings: Tegra186 tachometer device tree bindings
Date: Mon, 9 Apr 2018 08:21:17 -0500
Message-ID: <CAL_Jsq+AsUiWWBQ7K4OUM58KqQbvBHuFYmXxXLwr7viwoKW-Yw@mail.gmail.com>
References: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
 <1521607244-29734-4-git-send-email-rrajk@nvidia.com> <20180327145249.xjoo42qow34ksdle@rob-hp-laptop>
 <867aace8-dac7-51d4-bd46-15919b58b37d@kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <867aace8-dac7-51d4-bd46-15919b58b37d@kapsi.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Mikko Perttunen <cyndis@kapsi.fi>
Cc: Rajkumar Rampelli <rrajk@nvidia.com>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Timur Tabi <timur@codeaurora.org>, Andy Gross <andy.gross@linaro.org>, Wei Xu <xuwei5@hisilicon.com>, Alex Elder <elder@linaro.org>, "heiko@sntech.de" <heiko@sn>
List-Id: linux-pwm@vger.kernel.org

On Mon, Apr 9, 2018 at 12:38 AM, Mikko Perttunen <cyndis@kapsi.fi> wrote:
> Rob,

Please don't top post to lists.

> this binding is for a specific IP block (for measuring/aggregating input
> pulses) on the Tegra186 SoC, so I don't think it fits into any generic
> binding.

What is it hooked up to to measure? You only mention "fan" five times
in the doc.

You have #pwm-cells too, so this block has PWM output as well? If not,
then where's the PWM for the fan control because there is no point in
having fan tach without some control mechanism.

There's only so many ways to control fans and types of fans, so yes,
the interface of control and feedback lines between a fan and its
controller should absolutely be generic.

Rob

>
> Thanks,
> Mikko
>
>
> On 03/27/2018 05:52 PM, Rob Herring wrote:
>>
>> On Wed, Mar 21, 2018 at 10:10:38AM +0530, Rajkumar Rampelli wrote:
>>>
>>> Supply Device tree binding documentation for the NVIDIA
>>> Tegra186 SoC's Tachometer Controller
>>>
>>> Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
>>> ---
>>>
>>> V2: Renamed compatible string to "nvidia,tegra186-pwm-tachometer"
>>>      Renamed dt property values of clock-names and reset-names to
>>> "tachometer"
>>>      from "tach"
>>
>>
>> Read my prior comments on v1.
>>
>> Rob
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
