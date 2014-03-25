From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH v4 2/4] pwm: sirf: add dt-binding document
Date: Tue, 25 Mar 2014 20:32:56 +0800
Message-ID: <CAGsJ_4yDfHVJ4MN51XZNb8oHNWmzNmEm009j66ZN49H5hPTvFw@mail.gmail.com>
References: <1394013583-6352-1-git-send-email-21cnbao@gmail.com> <20140318211340.GF5917@mithrandir>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35011 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581AbaCYMdR (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Mar 2014 08:33:17 -0400
In-Reply-To: <20140318211340.GF5917@mithrandir>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Barry Song <Baohua.Song@csr.com>

2014-03-19 5:13 GMT+08:00 Thierry Reding <thierry.reding@gmail.com>:
> On Wed, Mar 05, 2014 at 05:59:43PM +0800, Barry Song wrote:
>> From: Barry Song <Baohua.Song@csr.com>
>>
>> this patch adds dt-binding document for pwm-sirf. here the controller clock
>> can't generate PWM signals, so we need seperate clock as signal source.
>
> Please capitalize properly. Also since the binding document should be OS
> agnostic, it shouldn't be using the name of the driver in the Linux
> kernel.
>
>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sirf.txt b/Documentation/devicetree/bindings/pwm/pwm-sirf.txt
>> new file mode 100644
>> index 0000000..47851ea
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pwm/pwm-sirf.txt
>> @@ -0,0 +1,23 @@
>> +SiRF prima2 & atlas6 PWM drivers
>> +
>> +Required properties:
>> +- compatible: "sirf,prima2-pwm"
>> +- reg: physical base address and length of the controller's registers
>> +- #pwm-cells: should be 2.  The first cell specifies the per-chip index of the
>> +  PWM to use and the second cell is the period in nanoseconds.
>
> The canonical way to describe this property is:
>
>         - #pwm-cells: Should be 2. See pwm.txt in this directory for a description of
>           the cells format.
>
>> +- clocks: from common clock binding: the 1st clock is for PWM controller the
>> +  other clocks are the sources to generate PWM signals
>> +- clock-names : The first one is the name of the clock for PWM, others are names
>> +  of clock sources to generate PWM signal, e.g.sigsrc0 ~sigsrc4. For prima2 and
>> +  atlas6, sigsrc0 is OSC with 26MHz, sigsrc3 is RTC with 32KHz, others are PLLs.
>> +  Generally, PWM module uses the OSC as clock source to generate PWM signals.
>
> I think a more common way to write this is:
>
>         - clocks: Must contain an entry for each entry in clock-names.
>           See ../clocks/clock-bindings.txt for details.
>         - clock-names: Must include the following entries:
>           - pwmc: PWM controller clock
>           - sigsrc0: source clock for ???
>           - ...
>           - sigsrc4: source clock for ???
>
> And perhaps given the requirements on prima2 and atlas6 (are those SoC
> generations or boards?) specify what each clock should be set to.
>
> If prima2 and atlas6 are boards, then the binding shouldn't mention them
> at all.

prima2 and atlas6 are SoCs not boards.

>
> Thierry

-barry
