From: Romain Izard <romain.izard.pro@gmail.com>
Subject: Re: [PATCH v3] pwm: add CSR SiRFSoC PWM driver
Date: Fri, 28 Feb 2014 12:41:44 +0100
Message-ID: <CAMiSF3BxVXmR_aKwMnazZbN2RYr6D++k5oEgux73miberRxnbg@mail.gmail.com>
References: <1391855002-26098-1-git-send-email-21cnbao@gmail.com>
	<lel46f$q2d$1@ger.gmane.org>
	<CAGsJ_4xLtXV6WtVhLgzFAaU9oG5UOt+LonFktBipQf_a6Yutng@mail.gmail.com>
	<CAMiSF3CczVV+Ob++_ACcwE+OXvFH8f9v1E=Q1F5x7Zz1BjCCzg@mail.gmail.com>
	<CAGsJ_4ywPTbUnfVVFFNFMSwG0CGckxKqHZ81rvEDFK-_1H25tA@mail.gmail.com>
	<CAMiSF3CN33N867TtjatYx1EwaV5qJY=JYsSrVFpQvC+yS1T5rA@mail.gmail.com>
	<CAGsJ_4z_48pZcXJXkwyuujoq=cEF3Oov5_GBRtHHOufMdEpRGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:59411 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940AbaB1Llq (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Feb 2014 06:41:46 -0500
Received: by mail-wi0-f169.google.com with SMTP id bs8so1753330wib.4
        for <linux-pwm@vger.kernel.org>; Fri, 28 Feb 2014 03:41:44 -0800 (PST)
In-Reply-To: <CAGsJ_4z_48pZcXJXkwyuujoq=cEF3Oov5_GBRtHHOufMdEpRGA@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-pwm@vger.kernel.org, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>

2014-02-28 11:07 GMT+01:00 Barry Song <21cnbao@gmail.com>:
> 2014-02-28 17:06 GMT+08:00 Romain Izard <romain.izard.pro@gmail.com>:
>> 2014-02-28 4:01 GMT+01:00 Barry Song <21cnbao@gmail.com>:
>>>
>>> 1.  fclk should be named for pwm not for rtc, osc and pll, so the
>>> names might be ugly by fclk0~N.
>>>
>> For me, it's important to keep the number in the name of the clock as it is
>> the source of the information for binding the device tree clock on one side
>> and the clock source index in the selection register on the other side. If
>> we do not do it this way, we cannot easily handle new clocks in the future
>> in the binding.
>>
>> On the other hand, I strongly dislike the current clock specification
>> as <&clks #x>.
>> It would be probably a good thing to add a header linking the numbers
>> to symbols,
>> and we would then get:
>>
>>         clocks = <&clks SIRFCLK_A6_PWM>,
>>                 <&clks SIRFCLK_A6_OSC>,
>>                 <&clks SIRFCLK_A6_PLL1>,
>>                 <&clks SIRFCLK_A6_PLL2>,
>>                 <&clks SIRFCLK_A6_RTC>,
>>                 <&clks SIRFCLK_16_PLL3>;
>>         clock-names = "iclk", "fclk0", "fclk1", "fclk2", "fclk3", "fclk4";
>>
>> Note that as the binary output of the device tree would not change with this, we
>> do not need to worry about backwards compatibility in this precise case.
>
> this pwm controller is prima2-compatible, so it is actually a pwm
> controller highly bound with the special SoC.
> really strange things are we actually care about the clock types. we
> actually can't think fclk0~fclk4 as same things. for pll, i think it
> is buggy to use. for rtc, it only service special target for providing
> bypass 32KHz clock.
>
If you're not using DVFS, it may be useful to use the PLLs. I do not think
it's a good thing to say 'we will never use it' or 'we will not get it to work'.

I now remember our use case for low-speed PWM: buzzers. here we will
need to have a output range of typically 40-2000 Hz, which cannot be provided
by the 26 MHz input source.

> if we look this controller a separate IP, we need to look 5 clock
> source to be coequal. but it is not the real case.
> i think people will hate the things that we have a separate bypass
> mode for fclk3, why it is 3 but not 2, 1, 4 and 5?

I believe we can make the code to handle all clocks almost as equals,
because for the IP it is the case. The DVFS case has an inpact on the
PLLs, so it's not perfectly the case, but from the register point of view,
the only difference is the value in the input selection register.

If we want to output a 26 MHz clock, we need to enable bypass also
on fclk0: otherwise we're limited by the minimum divisor of 2. But for
me, the bypass should not be a 'visible' feature of the PWM for its users.
The users specify a PWM line, and a period. We give them what they
ask, or we return them an error if we cannot do that with the available
input clocks.

> that is why i move to a MACRO 26MHz in the original codes as i think
> it is a prima2 controller but not a controller used by prima2 even
> though we always want a IP module to be a IP module suitable for all
> SoCs.

The PWM controller is already used in prima2 and atlas6, it's almost the
same as the controller in atlas4/5 which won't get supported in the kernel
anytime soon. I expect the controller to be reused in future products: at
the end, the sirfsoc family has multiple SoCs. And the xin clock is 12
MHz on atlas5 but 26 MHz on atlas6, so the clock specification through
device tree is a pretty good idea.

>>> 2.  the driver need to manage all of the clocks. yes, it can. but it
>>> might be ugly again. we can either request the clk at the time of pwm
>>> configuration, or get all directy in probe and maintain an array.
>>
>> For me, what is important right now is to get the binding right. If the driver
>> cannot do everything the binding allows, this is not a problem. But we define
>> a binding that cannot easily be expanded, we will have problems when we
>> need the new features.
>>
>>> i am thinking what is the best way for it. if we do that by an
>>> incremental patch, it might be more concentrated and understandable.
>
> i think bypass mode for rtc will be included immediately since there
> is a real user.
>
For reviewing, I believe it is better if the features are added one by one.
This makes it somehow easier to understand each separate feature.
But I recognize it can be tiring as each patch needs to be tested separately.

-- 
Romain Izard
