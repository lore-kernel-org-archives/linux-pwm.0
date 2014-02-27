From: Romain Izard <romain.izard.pro@gmail.com>
Subject: Re: [PATCH v3] pwm: add CSR SiRFSoC PWM driver
Date: Thu, 27 Feb 2014 11:51:18 +0100
Message-ID: <CAMiSF3CczVV+Ob++_ACcwE+OXvFH8f9v1E=Q1F5x7Zz1BjCCzg@mail.gmail.com>
References: <1391855002-26098-1-git-send-email-21cnbao@gmail.com>
	<lel46f$q2d$1@ger.gmane.org>
	<CAGsJ_4xLtXV6WtVhLgzFAaU9oG5UOt+LonFktBipQf_a6Yutng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:52125 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbaB0KvU (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 27 Feb 2014 05:51:20 -0500
Received: by mail-wg0-f49.google.com with SMTP id x12so2795890wgg.32
        for <linux-pwm@vger.kernel.org>; Thu, 27 Feb 2014 02:51:18 -0800 (PST)
In-Reply-To: <CAGsJ_4xLtXV6WtVhLgzFAaU9oG5UOt+LonFktBipQf_a6Yutng@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-pwm@vger.kernel.org, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>

2014-02-27 3:49 GMT+01:00 Barry Song <21cnbao@gmail.com>:
> Hello Romain,
>
> 2014-02-27 0:19 GMT+08:00 Romain Izard <romain.izard.pro@gmail.com>:
>>
>> Describing the clocks this way seems limiting to me.
>>
>> Each output of the PWM controller on SiRFatlasVI and SiRFprimaII can
>> independently use one clock among many for signal generation, with
>> three PLLs and two external clock inputs available.
>
> yes, that is the hardware spec. and i feel so happy you have read it.
> now i get one more sirfsoc friend.
>
> 32K of RTC is too small to generate a normal PWM signal, PLLs in the
> design can change for DVFS.
> so that means a notifier callback is needed if PLL is changed for
> CPUFreq, this makes SW buggy and complex.
>
Well, my specific concern was the use of the bypass mode on the 32kHz
clock. As the PWM driver is also the interface for external clock distribution,
and 32 kHz is a common requirement for external devices, I wish to avoid
compounding error rates. I will get a less precise clock if I divide the 26 MHz
instead.

> when i reviewed the source codes in our local git,  i decided to move
> to a general and clean SW solution at the first step.
>>
>> If we specify the source clock for the signal generation in the device
>> tree as you do here, we will prevent the use of those different input
>> clocks when incompatible frequencies are required, such as 32,768 Hz on
>> one output line and 44,100 Hz on another one.
>
> i prefer we use a normal clock source which can provide normal clock
> rates. 26MHz is a suitable one which can provide a big scale.
> even though we can use multiple clock sources, clock sources are the
> knowledge of PWM and should not be visible to pwm clients as you
> mentioned below.
>
Thanks, I understand how you got to this conclusion.

>>
>> As the clock tree for SiRF SoCs is described in the source files in
>> drivers/clk/sirf/*, it does not appear to me that the functional clock
>> needs to be configured in the device tree: the names of available clock
>> sources can be provided statically by the device tree matching table the
>> pwm-sirf.c.  Moreover, this would continue to work with the current
>> (undocumented) bindings for SiRFatlasVI and SiRFprimaII.
>
> i don't understand "it does not appear to me that the functional clock
> needs to be configured in the device tree", we are now using the clock
> index in dts.
> the index is mapping with the clock indexes in driver codes as you said.
>
What I meant is that the clock tree in SiRF chips is not described in the
DTS, as you can get for example with OMAP chips, but it is defined in
tables in the source code. By extension, I meant that the functional clocks
used by the PWM module can be hidden from the DTS in the same way.
But you're right that it is not was your proposition does, and after checking
the previous discussions I see Arnd asked you for this change.

>>
>> Alternatively, to keep the configuration in the device tree, all valid
>> inputs for this SoC could be described here, instead of a single one.
>>
>> The choice of the clock used for each output can then be selected when
>> configuring an output, with a selection algorithm using the best input for
>> a given period in of_xlate() and config() callbacks.
>
> this is right in case we don't make clock sources visible to PWM
> clients. but for the moment, current driver have met the requirement
> of PWM clients like LCD and audio codec in our tests.
> so i think if there is some special rate we can not met in the future,
> we have an incremental patch for that.
> we might be able to have a "best-fit" algorithm to figure out
> "best-fit" clock source, even a quick check-up table for these special
> rates since they are few.

Perhaps this can be linked with the missing "clock-names" property, as this
will make it possible to add multiple functional clocks, with "iclk" matching
the interface clock (i.e. pwmc), and "fclk0", "fclk1", etc. matching
all supported
functional clocks.

With only the 26 MHz clock, the node would look like:

pwm: pwm@b0130000 {
        compatible = "sirf,prima2-pwm";
        #pwm-cells = <2>;
        reg = <0xb0130000 0x10000>;
        clocks = <&clks 21>,  <&clks 1>, <&clks 0>;
        clock-names = "iclk", "fclk0", "fclk3";
};

The result would look like this with both the 26 MHz and the 32 kHz clocks:

pwm: pwm@b0130000 {
        compatible = "sirf,prima2-pwm";
        #pwm-cells = <2>;
        reg = <0xb0130000 0x10000>;
        clocks = <&clks 21>,  <&clks 1>, <&clks 0>;
        clock-names = "iclk", "fclk0", "fclk3";
};

And with all possible clocks:

pwm: pwm@b0130000 {
        compatible = "sirf,prima2-pwm";
        #pwm-cells = <2>;
        reg = <0xb0130000 0x10000>;
        clocks = <&clks 21>,  <&clks 1>, <&clks 2>, <&clks 3>, <&clks
0>, <&clks 4>;
        clock-names = "iclk", "fclk0", "fclk1", "fclk2", "fclk3", "fclk4";
};

The code in the probe function would interpret the clock-name to build
the clock/index mapping table. This would not change a lot the binding you
proposed, as you still can describe only one functional clock, but it describes
which index in the configuration register is linked to the proposed clock.

-- 
Romain Izard
