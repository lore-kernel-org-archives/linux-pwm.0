From: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [GIT PULL] Immutable branch between MFD, ARM, IIO and PWM due for
 the v4.10 merge window
Date: Tue, 24 Jan 2017 11:54:51 -0800
Message-ID: <CAOesGMhauUd0mPuUsRZnEWrAfQZj3Di_YwvxtD1rXr7B9fgqdw@mail.gmail.com>
References: <1484903709-11650-1-git-send-email-benjamin.gaignard@st.com>
 <20170123121222.GJ16020@dell> <CAOesGMhx6ZWekgW01-7GRcMiWtAohcfGdcu1FhkP=bTfsjBCmQ@mail.gmail.com>
 <20170124081244.GP16020@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170124081244.GP16020@dell>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Benjamin Gaignard <benjamin.gaignard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Alexandre TORGUE <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux PWM List <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, fabrice.gasnier-qxv4g6HH51o@public.gmane.org, gerald.baeza@s
List-Id: linux-pwm@vger.kernel.org

On Tue, Jan 24, 2017 at 12:12 AM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On Mon, 23 Jan 2017, Olof Johansson wrote:
>> On Mon, Jan 23, 2017 at 4:12 AM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> > Arm, IIO and PWM Maintainers,
>> >
>> > Enjoy!
>> >
>> > The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
>> >
>> >   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
>> >
>> > are available in the git repository at:
>> >
>> >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-arm-iio-pwm-v4.10
>> >
>> > for you to fetch changes up to 94df449273475980a39f1bf47f1e3d2b07ce6577:
>> >
>> >   ARM: dts: stm32: Enable pwm1 and pwm3 for stm32f469-disco (2017-01-23 12:06:28 +0000)
>> >
>> > ----------------------------------------------------------------
>> > Immutable branch between MFD, ARM, IIO and PWM due for the v4.10 merge window
>> >
>> > ----------------------------------------------------------------
>> > Benjamin Gaignard (8):
>> >       dt-bindings: mfd: Add bindings for STM32 Timers driver
>> >       mfd: Add STM32 Timers driver
>> >       dt-bindings: pwm: Add STM32 bindings
>> >       pwm: Add driver for STM32 plaftorm
>> >       iio: Add bindings for STM32 timer trigger driver
>> >       iio: Add STM32 timer trigger driver
>> >       ARM: dts: stm32: add Timers driver for stm32f429 MCU
>> >       ARM: dts: stm32: Enable pwm1 and pwm3 for stm32f469-disco
>> >
>> >  .../ABI/testing/sysfs-bus-iio-timer-stm32          |  29 ++
>> >  .../bindings/iio/timer/stm32-timer-trigger.txt     |  23 ++
>> >  .../devicetree/bindings/mfd/stm32-timers.txt       |  46 +++
>> >  .../devicetree/bindings/pwm/pwm-stm32.txt          |  35 ++
>> >  arch/arm/boot/dts/stm32f429.dtsi                   | 275 ++++++++++++++
>> >  arch/arm/boot/dts/stm32f469-disco.dts              |  28 ++
>> >  drivers/iio/trigger/Kconfig                        |   9 +
>> >  drivers/iio/trigger/Makefile                       |   1 +
>> >  drivers/iio/trigger/stm32-timer-trigger.c          | 342 ++++++++++++++++++
>> >  drivers/mfd/Kconfig                                |  11 +
>> >  drivers/mfd/Makefile                               |   2 +
>> >  drivers/mfd/stm32-timers.c                         |  80 +++++
>> >  drivers/pwm/Kconfig                                |   9 +
>> >  drivers/pwm/Makefile                               |   1 +
>> >  drivers/pwm/pwm-stm32.c                            | 398 +++++++++++++++++++++
>> >  include/linux/iio/timer/stm32-timer-trigger.h      |  62 ++++
>> >  include/linux/mfd/stm32-timers.h                   |  71 ++++
>> >  17 files changed, 1422 insertions(+)
>> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
>> >  create mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
>> >  create mode 100644 Documentation/devicetree/bindings/mfd/stm32-timers.txt
>> >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32.txt
>> >  create mode 100644 drivers/iio/trigger/stm32-timer-trigger.c
>> >  create mode 100644 drivers/mfd/stm32-timers.c
>> >  create mode 100644 drivers/pwm/pwm-stm32.c
>> >  create mode 100644 include/linux/iio/timer/stm32-timer-trigger.h
>> >  create mode 100644 include/linux/mfd/stm32-timers.h
>>
>> May I ask why you're creating an immutable branch of all this contents?
>>
>> We should get the dts/dtsi contents like usual from any maintainer;
>> just the DT updates in a branch.
>>
>> Sometimes (but less and less due to us discouraging the use) we need
>> an immutable branch that includes dt-include updates. But I don't see
>> any of those in this contents.
>>
>> I.e. I guess I can see the need between mfd and downstream trees
>> (iio/pwm), but not the DTS contents at this time. Or am I missing
>> something here?
>
> I agree with you.  However, since one of the STM32 Maintainers Acked
> the DTS patches, and the other one hasn't been heard from for months,
> I took that to mean he wanted me to apply and take them through the
> MFD tree.
>
> A misunderstanding or misaction perhaps, but this is the normal
> assumption.

It seems to be a misunderstanding in this case, since there are other
additions in the stm32 tree this release cycle so we should only pick
up DTS changes through our tree.

By now, I think it should be pretty well known that we nearly never
want DTS contents merged through any other tree. Ever.

So, please revoke your branch and take those out. We'll take them
through the normal flow. Thanks!


-Olof
