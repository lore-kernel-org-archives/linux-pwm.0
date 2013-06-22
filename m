Return-Path: <sylvester.nawrocki@gmail.com>
Return-Path: <sylvester.nawrocki@gmail.com>
Message-ID: <51C5FC44.6000001@gmail.com>
Date: Sat, 22 Jun 2013 21:34:28 +0200
From: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 00/18] Final Samsung PWM support cleanup
References: <1371766383-29077-1-git-send-email-tomasz.figa@gmail.com> <201306222001.49600.heiko@sntech.de>
In-Reply-To: <201306222001.49600.heiko@sntech.de>
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-pwm.vger.kernel.org>
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: =?ISO-8859-15?Q?Heiko_St=FCbner?= <heiko@sntech.de>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>, Thierry Reding <thierry.reding@gmail.com>

Hi,

W dniu 2013-06-22 20:01, Heiko St=EF=BF=BDbner pisze:
> Am Freitag, 21. Juni 2013, 00:12:45 schrieb Tomasz Figa:
>> Since we now have a proper Samsung PWM clocksource driver in place,
>> we can proceed with further cleanup of PWM timers support on Samsung SoC=
s.
>>
>> This series attempts to achieve this goal by:
>>   1) moving remaining Samsung platforms to the new clocksource driver
>>   2) removing old clocksource driver
>>   3) adding new multiplatform- and DT-aware PWM driver
>>   4) moving all Samsung platforms to use the new PWM driver
>>   5) removing old PWM driver
>>   6) removing all PWM-related code that is not used anymore
>>
>> Cleaning up the PWM driver is a bit tricky, because the design of current
>> driver makes it completely unsuitable for DT and multiplatform and would
>> require a heavy rework to make it usable, breaking any existing Samsung =
PWM
>> users by the way. To avoid any breakage I decided to keep the old driver,
>> add new one, move all platforms to it and then remove the old one.
>>
>> See particular patches for more detailed descriptions.
>>
>> On S3C6410-based Tiny6410 (Mini6410-compatible), after enabling pwm-beep=
er
>> and Exynos4210-based Origen board (with PWM0 attached to a scope):
>>
>> Tested-by: Tomasz Figa<tomasz.figa@gmail.com>
>
> On a s3c2416 based machine (with the additional two v3 patches)
>
> Tested-by: Heiko Stuebner<heiko@sntech.de>

I have tested this series on Mini2440 board (all v2 patches).
Only boot testing for now, however I'm going to inspect the PWM
output signal and will report back if there are any issues.
I think you could add my

Tested-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>

I had to revert this patch (introduced between v3.10-rc4 and v3.10-rc5)

commit 60e93575476f90a72146b51283f514da655410a7
Author: Chander Kashyap <chander.kashyap@linaro.org>
Date:   Tue May 28 18:32:07 2013 +0530

     serial: samsung: enable clock before clearing pending interrupts=20
during init

     Ensure that the uart controller clock is enabled prior to writing=20
to the
     interrupt mask and pending registers in the s3c24xx_serial_init_port
     function.

     Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


to make serial console working again on Mini2440, but this is a
different story.

Thanks,
Sylwester
