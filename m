From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH v3] pwm: add CSR SiRFSoC PWM driver
Date: Thu, 27 Feb 2014 10:49:06 +0800
Message-ID: <CAGsJ_4xLtXV6WtVhLgzFAaU9oG5UOt+LonFktBipQf_a6Yutng@mail.gmail.com>
References: <1391855002-26098-1-git-send-email-21cnbao@gmail.com> <lel46f$q2d$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:37783 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607AbaB0Ct2 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Feb 2014 21:49:28 -0500
Received: by mail-pd0-f172.google.com with SMTP id p10so1798814pdj.17
        for <linux-pwm@vger.kernel.org>; Wed, 26 Feb 2014 18:49:27 -0800 (PST)
In-Reply-To: <lel46f$q2d$1@ger.gmane.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Romain Izard <romain.izard.pro@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-pwm@vger.kernel.org, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>

Hello Romain,

2014-02-27 0:19 GMT+08:00 Romain Izard <romain.izard.pro@gmail.com>:
> Hello Barry,
>
> On 2014-02-08, Barry Song <21cnbao@gmail.com> wrote:
>> From: Rongjun Ying <Rongjun.ying@csr.com>
>>
>> PWM controller of CSR SiRFSoC can generate 7 independent outputs. Each output
>> duty cycle can be adjusted by setting the corresponding wait & hold registers.
>>
>> Supports 7 independent channel output: 6 for external(channel0-5) and 1 for
>> internal(channel6).
>>
>> Supports wide frequency range: divide by 2 to 65536*2 of source clock.
>>
>> Signed-off-by: Rongjun Ying <Rongjun.ying@csr.com>
>> Signed-off-by: Huayi Li <Huayi.Li@csr.com>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> ---
>>  -v3:
>>  add "depends on" COMPILE_TEST according to Arnd's feedback;
>>  move the pwm clock source to dts according to Arnd's feedback;
>>  add lost dt-binding document
>>
>>  Documentation/devicetree/bindings/pwm/pwm-sirf.txt |   17 +
>>  arch/arm/boot/dts/atlas6.dtsi                      |    3 +-
>>  arch/arm/boot/dts/prima2.dtsi                      |    3 +-
>>  drivers/pwm/Kconfig                                |    9 +
>>  drivers/pwm/Makefile                               |    1 +
>>  drivers/pwm/pwm-sirf.c                             |  308 ++++++++++++++++++++
>>  6 files changed, 339 insertions(+), 2 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sirf.txt
>>  create mode 100644 drivers/pwm/pwm-sirf.c
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sirf.txt b/Documentation/devicetree/bindings/pwm/pwm-sirf.txt
>> new file mode 100644
>> index 0000000..4b10109
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pwm/pwm-sirf.txt
>> @@ -0,0 +1,17 @@
>> +SiRF prima2 & atlas6 PWM drivers
>> +
>> +Required properties:
>> +- compatible: "sirf,prima2-pwm"
>> +- reg: physical base address and length of the controller's registers
>> +- #pwm-cells: should be 2.  The first cell specifies the per-chip index
>> +  of the PWM to use and the second cell is the period in nanoseconds.
>> +- clocks: from common clock binding: the 1st clock is for PWM controller
>> +  the 2nd clock is the source to generate PWM waves
>> +
>
> Describing the clocks this way seems limiting to me.
>
> Each output of the PWM controller on SiRFatlasVI and SiRFprimaII can
> independently use one clock among many for signal generation, with
> three PLLs and two external clock inputs available.

yes, that is the hardware spec. and i feel so happy you have read it.
now i get one more sirfsoc friend.

32K of RTC is too small to generate a normal PWM signal, PLLs in the
design can change for DVFS.
so that means a notifier callback is needed if PLL is changed for
CPUFreq, this makes SW buggy and complex.

when i reviewed the source codes in our local git,  i decided to move
to a general and clean SW solution at the first step.

>
> If we specify the source clock for the signal generation in the device
> tree as you do here, we will prevent the use of those different input
> clocks when incompatible frequencies are required, such as 32,768 Hz on
> one output line and 44,100 Hz on another one.

i prefer we use a normal clock source which can provide normal clock
rates. 26MHz is a suitable one which can provide a big scale.
even though we can use multiple clock sources, clock sources are the
knowledge of PWM and should not be visible to pwm clients as you
mentioned below.

>
> As the clock tree for SiRF SoCs is described in the source files in
> drivers/clk/sirf/*, it does not appear to me that the functional clock
> needs to be configured in the device tree: the names of available clock
> sources can be provided statically by the device tree matching table the
> pwm-sirf.c.  Moreover, this would continue to work with the current
> (undocumented) bindings for SiRFatlasVI and SiRFprimaII.

i don't understand "it does not appear to me that the functional clock
needs to be configured in the device tree", we are now using the clock
index in dts.
the index is mapping with the clock indexes in driver codes as you said.

>
> Alternatively, to keep the configuration in the device tree, all valid
> inputs for this SoC could be described here, instead of a single one.
>
> The choice of the clock used for each output can then be selected when
> configuring an output, with a selection algorithm using the best input for
> a given period in of_xlate() and config() callbacks.

this is right in case we don't make clock sources visible to PWM
clients. but for the moment, current driver have met the requirement
of PWM clients like LCD and audio codec in our tests.
so i think if there is some special rate we can not met in the future,
we have an incremental patch for that.
we might be able to have a "best-fit" algorithm to figure out
"best-fit" clock source, even a quick check-up table for these special
rates since they are few.

>
> --
> Romain Izard
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-barry
