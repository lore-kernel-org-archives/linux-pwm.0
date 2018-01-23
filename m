From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 10/16] pwm: Add PWM modes
Date: Tue, 23 Jan 2018 09:21:12 -0600
Message-ID: <CAL_JsqKs7t36xaOwx2mOeRgk_tHPjtvqfqJY+OJ49VjOStfs_w@mail.gmail.com>
References: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
 <1515766983-15151-11-git-send-email-claudiu.beznea@microchip.com>
 <20180119223452.doeqfd4aewkf5fla@rob-hp-laptop> <c5aeb8df-6aa8-cde4-9305-08777cac2f45@microchip.com>
 <CAL_JsqJho2OrdnHwRPpYsbNB4RFTq5qSLA=36D2zy=Mi7B8XwQ@mail.gmail.com> <759435bf-764f-68ea-de51-c878ceec28e2@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750911AbeAWPVe (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 23 Jan 2018 10:21:34 -0500
In-Reply-To: <759435bf-764f-68ea-de51-c878ceec28e2@microchip.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Claudiu Beznea <Claudiu.Beznea@microchip.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Jonathan Corbet <corbet@lwn.net>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Linux PWM List <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-amlogic@lists.infradead.org, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead>

On Tue, Jan 23, 2018 at 4:40 AM, Claudiu Beznea
<Claudiu.Beznea@microchip.com> wrote:
>
>
> On 22.01.2018 20:12, Rob Herring wrote:
>> On Mon, Jan 22, 2018 at 2:54 AM, Claudiu Beznea
>> <Claudiu.Beznea@microchip.com> wrote:
>>>
>>>
>>> On 20.01.2018 00:34, Rob Herring wrote:
>>>> On Fri, Jan 12, 2018 at 04:22:57PM +0200, Claudiu Beznea wrote:
>>>>> Define a macros for PWM modes to be used by device tree sources.
>>>>>
>>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>>>>> ---
>>>>>  include/dt-bindings/pwm/pwm.h | 3 +++
>>>>>  1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/include/dt-bindings/pwm/pwm.h b/include/dt-bindings/pwm/pwm.h
>>>>> index ab9a077e3c7d..b8617431f8ec 100644
>>>>> --- a/include/dt-bindings/pwm/pwm.h
>>>>> +++ b/include/dt-bindings/pwm/pwm.h
>>>>> @@ -12,4 +12,7 @@
>>>>>
>>>>>  #define PWM_POLARITY_INVERTED                       (1 << 0)
>>>>>
>>>>> +#define PWM_DTMODE_NORMAL                   (1 << 0)
>>>>
>>>> Bit 0 is already taken. I think you mean (0 << 1)?
>>> I wanted to have the PWM modes in a new cell, so that the pwms binding to be
>>> something like:
>>> pwms=<pwm-controller pwm-channel pwm-period pwm-flags pwm-mode>
>>>
>>> If you think it is mode feasible to also include PWM mode in the cell for
>>> PWM flags, please let me know.
>>
>> Yes, but you have to make "normal" be no bit set to be compatible with
>> everything already out there.
> I'm thinking having it separately is more clear and modular.

Having a standard number of cells (and fields in cells) is easier to
maintain. We've set this at 3 for PWMs and you have already found what
happens when you have a different number of cells. Adding a 4th cell
(and possibly a different form of 3 cells in the case of no channel #
cell) just creates more combinations to parse. And we don't want to go
update all the existing users using 3 cells to use 4 cells just to
align.

If the mode needed to be set in the common case, then I might feel
differently about having a separate cell. But these modes seem like a
special case. How many PWM controllers actually support modes like
these?

>>>> Personally, I'd just drop this define. A define for a 0 value makes more
>>>> sense when each state is equally used (like active high or low), but if
>>>> 0 is the more common case, then I don't the need for a define.
>>> I want it to have these defines like bit defines:
>>> PWM_DTMODE_NORMAL=0x1
>>> PWM_DTMODE_COMPLEMENTARY=0x2
>>> PWM_DTMODE_PUSH_PULL=0x4
>>
>> Thinking about this some more, shouldn't the new modes just be
>> implied? A client is going to require one of these modes or it won't
>> work right.
> The clients could or could not request the mode via DT. Every PWM chip registers
> supported modes at driver probe (default, if no PWM mode support is added
> to the PWM chip driver the PWM chip will supports only normal mode). If a
> PWM channel is requested by a PWM client via DT, and there is no PWM mode setting
> in DT bindings, e.g. requested with these bindings:
> pwms=<pwm-controller pwm-channel pwm-period> or
> pwms=<pwm-controller pwm-channel pwm-period pwm-flags>
> the first available mode of PWM chip will be used to instantiate the mode.
> If the defined modes are:
> PWM_DTMODE_NORMAL=0x1
> PWM_DTMODE_COMPLEMENTARY=0x2
> PWM_DTMODE_PUSH_PULL=0x4
> and the PWM chip driver registers itself, at probe, with (PWM_DTMODE_COMPLEMENTARY | PWM_DTMODE_PUSH_PULL)
> then the first available mode will be PWM_DTMODE_COMPLEMENTARY (first LSB bit
> of the variable that keeps the available modes).

Every driver already supports "normal", so that's implied. It would be
pointless to make every driver register that explicitly. It would be
pretty hard to not support normal as that's just ignore the 2nd
signal.

>> Also complementary mode could be accomplished with a single pwm output
>> and a board level inverter, right?
> Yes, I think this could be accomplished. Here I took into account only PWM controller
> capabilities. Having this, I think will involve having extra PWM bindings describing
> extra capabilities per-channel. And to change a little bit the implementation in order
> to have these capabilities per channel nor per PWM controller. What do you think?
>
> I think push-pull mode could also be accomplished having board inverter and delay
> modules. So, in these cases make sense to have per channel capabilities, as per my
> understanding.

Yes, it certainly is per channel. You may or may not have the 2nd pin
on any given channel. But again, if the client needs one of these
modes, then the h/w must be hooked up correctly to a channel with 2
signals.

Rob
