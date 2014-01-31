From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH v2] pwm: add CSR SiRFSoC PWM driver
Date: Fri, 31 Jan 2014 20:05:49 +0800
Message-ID: <CAGsJ_4xFKytv=Mj9eVwGY7RjyUy2W=iSXvnULKyBETYVzMVbOg@mail.gmail.com>
References: <1391061145-2078-1-git-send-email-21cnbao@gmail.com> <201401302049.27521.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:54870 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753951AbaAaMGK (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 31 Jan 2014 07:06:10 -0500
Received: by mail-pa0-f49.google.com with SMTP id hz1so4304831pad.8
        for <linux-pwm@vger.kernel.org>; Fri, 31 Jan 2014 04:06:10 -0800 (PST)
In-Reply-To: <201401302049.27521.arnd@arndb.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Rongjun Ying <Rongjun.ying@csr.com>, Huayi Li <Huayi.Li@csr.com>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Barry Song <Baohua.Song@csr.com>

2014-01-31 Arnd Bergmann <arnd@arndb.de>:
> On Thursday 30 January 2014, Barry Song wrote:
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index 7acab93..0a252f8 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -166,6 +166,15 @@ config PWM_SAMSUNG
>>         To compile this driver as a module, choose M here: the module
>>         will be called pwm-samsung.
>>
>> +config PWM_SIRF
>> +     tristate "SiRF PWM support"
>> +     depends on ARCH_SIRF
>> +     help
>
> please make this "depends on ARCH_SIRF || COMPILE_TEST" if you can, so we
> can build it on other platforms for test purposes. If you do this, you
> have to list the full set of dependencies, so probably another
> "depends on HAVE_CLK".

sounds good. it seems we can have this for other PWM drivers as well?

>
>> +
>> +#define to_sirf_chip(chip)   container_of(chip, struct sirf_pwm, chip)
>> +
>> +static unsigned int sirf_pwm_ns_to_cycles(struct pwm_chip *chip, unsigned int time_ns)
>> +{
>> +     u64 dividend;
>> +     unsigned int cycle;
>> +     /*
>> +      * on SiRFSoC, OSC input is const, we use it as the source to generate
>> +      * PWM wave
>> +      */
>> +#define SRC_OSC_RATE 26000000ULL
>> +     dividend = SRC_OSC_RATE * time_ns + NSEC_PER_SEC / 2;
>> +     do_div(dividend, NSEC_PER_SEC);
>> +
>> +     cycle = dividend & 0xFFFFFFFFUL;
>> +
>> +     return cycle > 1 ? cycle : 1;
>> +}
>> +
>
> Is SRC_OSC_RATE the rate of spwm->clk? If so, it would be nice to just call
> clk_get_rate() here, in case you ever have a chip with a different rate.
>

SRC_OSC_RATE is the fixed frequency of crystal oscillator, but
spwm->clk comes from the IO bus. the design is a little strange, pwm
channels don't use the clock of PWM controller to generate
period/duty, but use other sources.

> This is a very nice driver otherwise!
>
>         Arnd

-barry
