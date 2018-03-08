From: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Subject: Re: Re: [PATCH 4/5] dt-bindings: pwm: sunxi: add new
 compatible strings
Date: Thu, 8 Mar 2018 15:27:08 +0000
Message-ID: <a86bc0b3-8e99-0b0d-2dd5-be42393b0564@arm.com>
References: <20180307020719.6675-1-andre.przywara@arm.com>
 <20180307020719.6675-5-andre.przywara@arm.com>
 <20180308020822.35utrgw3ksoldr24@rob-hp-laptop>
 <9431a141-8b9c-9743-0907-8f0720df34a2@arm.com>
 <CAL_Jsq+e8uRm0gi1dn3Ln-b37SC9WGw5aWPaBKoRA2vi-==j6A@mail.gmail.com>
Reply-To: andre.przywara-5wv7dgnIgG8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDNZNK75ZIKRBV5MQXKQKGQELVJCF7Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAL_Jsq+e8uRm0gi1dn3Ln-b37SC9WGw5aWPaBKoRA2vi-==j6A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-GB
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Linux PWM List <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Hi,

On 08/03/18 14:37, Rob Herring wrote:
> On Thu, Mar 8, 2018 at 3:09 AM, Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org> wrote:
>> Hi,
>>
>> On 08/03/18 02:08, Rob Herring wrote:
>>> On Wed, Mar 07, 2018 at 02:07:18AM +0000, Andre Przywara wrote:
>>>> The PWM controllers found in the Allwinner A64, H5 and H6 SoCs are fully
>>>> compatible to the PWM controllers found in the A13 and H3.
>>>
>>> If fully compatible, then shouldn't there be a fallback to one of the
>>> existing compatible strings?
>>
>> Yes, that was the idea. I was already wondering how we would
>> differentiate that from "real" compatible strings, but couldn't find
>> convincing examples. So should that read:
>>
>> - compatible: should at least contain be one of:
>>     - "allwinner,sun4i-a10-pwm"
>>     - "allwinner,sun5i-a10s-pwm"
>>     - "allwinner,sun5i-a13-pwm"
>>     - "allwinner,sun7i-a20-pwm"
>>     - "allwinner,sun8i-h3-pwm"
>>   May in addition contain one of:
>>     - "allwinner,sun50i-a64-pwm"
>>     - "allwinner,sun50i-h5-pwm"
>>     - "allwinner,sun50i-h6-pwm"
> 
> I can't validate a dts is correct with it written like this. Just list
> each valid combination on each line:
> 
> "allwinner,sun8i-h3-pwm", "allwinner,sun50i-h6-pwm"
> 
> (Assuming "allwinner,sun50i-h6-pwm" was the first implementation and
> h3 has the same block).

Ah, OK, that's makes some sense. I didn't find too many examples outside
of root compatible nodes in the binding docs, but I will use that.

>> And this would possibly need to be amended once we need to actually use
>> one of those strings (to implement a quirk, for instance)?
> 
> The most specific compatible provides that. The driver matches on the
> least specific one until you have a quirk to implement.

Yeah, I was just wondering how a (non-Linux) driver author would induce
what strings are actually needed just by reading the binding. But
enumerating the combinations explicitly should solve this.

Thanks!
Andre.

>> Or is there some other way of reserving those compatible strings, which
>> are not expected to be matched in drivers directly?
> 
> The binding should just list all that are appropriate from the start
> and the driver is free to match on which ever string it wants.
> 
> Rob
> 
