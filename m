From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH v3] pwm: add CSR SiRFSoC PWM driver
Date: Fri, 28 Feb 2014 20:17:23 +0800
Message-ID: <CAGsJ_4z7xQQ8bhDW2P50Fk=x1PGdpoH_4mqMd9YwH5+7_X6NXg@mail.gmail.com>
References: <1391855002-26098-1-git-send-email-21cnbao@gmail.com>
 <lel46f$q2d$1@ger.gmane.org> <CAGsJ_4xLtXV6WtVhLgzFAaU9oG5UOt+LonFktBipQf_a6Yutng@mail.gmail.com>
 <CAMiSF3CczVV+Ob++_ACcwE+OXvFH8f9v1E=Q1F5x7Zz1BjCCzg@mail.gmail.com>
 <CAGsJ_4ywPTbUnfVVFFNFMSwG0CGckxKqHZ81rvEDFK-_1H25tA@mail.gmail.com>
 <CAMiSF3CN33N867TtjatYx1EwaV5qJY=JYsSrVFpQvC+yS1T5rA@mail.gmail.com>
 <CAGsJ_4z_48pZcXJXkwyuujoq=cEF3Oov5_GBRtHHOufMdEpRGA@mail.gmail.com> <CAMiSF3BxVXmR_aKwMnazZbN2RYr6D++k5oEgux73miberRxnbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:49999 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbaB1MRn (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Feb 2014 07:17:43 -0500
Received: by mail-pb0-f50.google.com with SMTP id md12so682775pbc.23
        for <linux-pwm@vger.kernel.org>; Fri, 28 Feb 2014 04:17:43 -0800 (PST)
In-Reply-To: <CAMiSF3BxVXmR_aKwMnazZbN2RYr6D++k5oEgux73miberRxnbg@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Romain Izard <romain.izard.pro@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-pwm@vger.kernel.org, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>

2014-02-28 19:41 GMT+08:00 Romain Izard <romain.izard.pro@gmail.com>:
> 2014-02-28 11:07 GMT+01:00 Barry Song <21cnbao@gmail.com>:
>> 2014-02-28 17:06 GMT+08:00 Romain Izard <romain.izard.pro@gmail.com>:
>>> 2014-02-28 4:01 GMT+01:00 Barry Song <21cnbao@gmail.com>:
>>>>
>>>> 1.  fclk should be named for pwm not for rtc, osc and pll, so the
>>>> names might be ugly by fclk0~N.
>>>>
>>> For me, it's important to keep the number in the name of the clock as it is
>>> the source of the information for binding the device tree clock on one side
>>> and the clock source index in the selection register on the other side. If
>>> we do not do it this way, we cannot easily handle new clocks in the future
>>> in the binding.
>>>
>>> On the other hand, I strongly dislike the current clock specification
>>> as <&clks #x>.
>>> It would be probably a good thing to add a header linking the numbers
>>> to symbols,
>>> and we would then get:
>>>
>>>         clocks = <&clks SIRFCLK_A6_PWM>,
>>>                 <&clks SIRFCLK_A6_OSC>,
>>>                 <&clks SIRFCLK_A6_PLL1>,
>>>                 <&clks SIRFCLK_A6_PLL2>,
>>>                 <&clks SIRFCLK_A6_RTC>,
>>>                 <&clks SIRFCLK_16_PLL3>;
>>>         clock-names = "iclk", "fclk0", "fclk1", "fclk2", "fclk3", "fclk4";
>>>
>>> Note that as the binary output of the device tree would not change with this, we
>>> do not need to worry about backwards compatibility in this precise case.
>>
>> this pwm controller is prima2-compatible, so it is actually a pwm
>> controller highly bound with the special SoC.
>> really strange things are we actually care about the clock types. we
>> actually can't think fclk0~fclk4 as same things. for pll, i think it
>> is buggy to use. for rtc, it only service special target for providing
>> bypass 32KHz clock.
>>
> If you're not using DVFS, it may be useful to use the PLLs. I do not think
> it's a good thing to say 'we will never use it' or 'we will not get it to work'.
>
> I now remember our use case for low-speed PWM: buzzers. here we will
> need to have a output range of typically 40-2000 Hz, which cannot be provided
> by the 26 MHz input source.
>
>> if we look this controller a separate IP, we need to look 5 clock
>> source to be coequal. but it is not the real case.
>> i think people will hate the things that we have a separate bypass
>> mode for fclk3, why it is 3 but not 2, 1, 4 and 5?
>
> I believe we can make the code to handle all clocks almost as equals,
> because for the IP it is the case. The DVFS case has an inpact on the
> PLLs, so it's not perfectly the case, but from the register point of view,
> the only difference is the value in the input selection register.

i don't think it is worthy if we make everything equal even though we
can. but it is just making things worse. if there is something we can
do for special cases, that is adding a check-up table for them.
there is a module like dev_pm_domain which can coordinate the
dependency of device power domain, if we can have similar things to
coordinate the change of clock frequency, we can update PWM divider
after PLL is updated. but it will break the "best-fit" as you might
select pll1 as best-fit at beginning, then after pll1 changes, pll2
becomes "best-fit".

>
> If we want to output a 26 MHz clock, we need to enable bypass also
> on fclk0: otherwise we're limited by the minimum divisor of 2. But for
> me, the bypass should not be a 'visible' feature of the PWM for its users.
> The users specify a PWM line, and a period. We give them what they
> ask, or we return them an error if we cannot do that with the available
> input clocks.

i don't think bypass is something related to typical PWM. so we need
some comments to make things really acceptable.
when you say a period, you are just ignoring duty. note bypass is
something ignoring duty. and make the codes be a little look be out of
place .

>
>> that is why i move to a MACRO 26MHz in the original codes as i think
>> it is a prima2 controller but not a controller used by prima2 even
>> though we always want a IP module to be a IP module suitable for all
>> SoCs.
>
> The PWM controller is already used in prima2 and atlas6, it's almost the
> same as the controller in atlas4/5 which won't get supported in the kernel
> anytime soon. I expect the controller to be reused in future products: at
> the end, the sirfsoc family has multiple SoCs. And the xin clock is 12
> MHz on atlas5 but 26 MHz on atlas6, so the clock specification through
> device tree is a pretty good idea.

when atlas6 uses the same PWM, it is still prima2-compatible. there is
no difference for source clock layout.
when i said prima2-compatible, it is not only prima2, as atlas6 is
also prima2-compatible for pwm.

i do agree putting fixed clock in dts is a good way. a4/a5 is not
supported in the new kernel version any more, the coming soc will have
completely different clock layout. so that means the current clock
tree is just for prima2 and atlas6.

if you do have some idea about clock, it is highly welcomed that you
send the codes in clk and i will ack.

>
>>>> 2.  the driver need to manage all of the clocks. yes, it can. but it
>>>> might be ugly again. we can either request the clk at the time of pwm
>>>> configuration, or get all directy in probe and maintain an array.
>>>
>>> For me, what is important right now is to get the binding right. If the driver
>>> cannot do everything the binding allows, this is not a problem. But we define
>>> a binding that cannot easily be expanded, we will have problems when we
>>> need the new features.
>>>
>>>> i am thinking what is the best way for it. if we do that by an
>>>> incremental patch, it might be more concentrated and understandable.
>>
>> i think bypass mode for rtc will be included immediately since there
>> is a real user.
>>
> For reviewing, I believe it is better if the features are added one by one.
> This makes it somehow easier to understand each separate feature.
> But I recognize it can be tiring as each patch needs to be tested separately.

that is my original idea, doing things by incremental patch. and you
asked the feature of 32KHz, and i think 32KHz is not a difficult case
to handle. doing 32Khz here can show the possible clock sources and
make things smooth if we want to  some other similar items. as people
have seen several source clocks before the beginning.


>
> --
> Romain Izard

-barry
