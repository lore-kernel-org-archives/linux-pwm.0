From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH v2] pwm: add CSR SiRFSoC PWM driver
Date: Thu, 6 Feb 2014 18:21:26 +0800
Message-ID: <CAGsJ_4xmtt2Pg_mHJmvt9uc3Y4gN7KUT1UOJhbr6FQYdiAH3qw@mail.gmail.com>
References: <1391061145-2078-1-git-send-email-21cnbao@gmail.com>
 <201401302049.27521.arnd@arndb.de> <CAGsJ_4xFKytv=Mj9eVwGY7RjyUy2W=iSXvnULKyBETYVzMVbOg@mail.gmail.com>
 <201401311623.56902.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:39578 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755307AbaBFKVr (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Feb 2014 05:21:47 -0500
Received: by mail-pa0-f52.google.com with SMTP id bj1so1508469pad.39
        for <linux-pwm@vger.kernel.org>; Thu, 06 Feb 2014 02:21:47 -0800 (PST)
In-Reply-To: <201401311623.56902.arnd@arndb.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Rongjun Ying <Rongjun.ying@csr.com>, Huayi Li <Huayi.Li@csr.com>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Barry Song <Baohua.Song@csr.com>

2014-01-31 23:23 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Friday 31 January 2014, Barry Song wrote:
>> >
>> > Is SRC_OSC_RATE the rate of spwm->clk? If so, it would be nice to just call
>> > clk_get_rate() here, in case you ever have a chip with a different rate.
>> >
>>
>> SRC_OSC_RATE is the fixed frequency of crystal oscillator, but
>> spwm->clk comes from the IO bus. the design is a little strange, pwm
>> channels don't use the clock of PWM controller to generate
>> period/duty, but use other sources.
>
> How about modeling  that other source as a fixed-rate clock in DT
> then?

sirfsoc clock drivers have a clock node for OSC whose index is "1".
do you think the following is the right way to handle?

in dts, put both pwm controller clock and OSC
672                         pwm: pwm@b0130000 {
673                                 compatible = "sirf,prima2-pwm";
674                                 #pwm-cells = <2>;
675                                 reg = <0xb0130000 0x10000>;
676                                 clocks = <&clks 21>,  <&clks 1>;
677                                 clock-names = "pwmc", "osc";
678                         };

and in pwm-sirf.c driver, use
clk = clk_get(dev, "osc");
clk_get_rate(clk);

to get the rate in probe()?


>
>         Arnd

-barry
