From: Milo Kim <milo.kim-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v5 0/4] LP3943 MFD driver for a GPIO expander and a PWM
 generator
Date: Fri, 6 Dec 2013 11:28:14 +0900
Message-ID: <52A1363E.5030404@ti.com>
References: <1386295714-22323-1-git-send-email-milo.kim@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1386295714-22323-1-git-send-email-milo.kim-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Hello guys,

My apologies for too messy messages.
Would you please refer to the patch-set with 'PATCH RESEND v5'?
Thanks.

   Milo

On 12/06/2013 11:08 AM, Milo Kim wrote:
> LP3943 is an integrated device capable of driving 16 output channels.
> It can be used for GPIO expander and PWM generators.
> LP3493 registers are controlled via the I2C interface.
>
> This patch-set consists of four parts - MFD, GPIO, PWM and documents.
>
> Update from v4 to v5:
>    Add Thierry's ACK for the PWM driver and the DT documentation
>
> Milo Kim (4):
>    mfd: add LP3943 MFD driver
>    gpio: add LP3943 I2C GPIO expander driver
>    pwm: add LP3943 PWM driver
>    Documentation: add LP3943 DT bindings and document
>
>   .../devicetree/bindings/gpio/gpio-lp3943.txt       |   37 +++
>   Documentation/devicetree/bindings/mfd/lp3943.txt   |   33 ++
>   .../devicetree/bindings/pwm/pwm-lp3943.txt         |   58 ++++
>   drivers/gpio/Kconfig                               |    8 +
>   drivers/gpio/Makefile                              |    1 +
>   drivers/gpio/gpio-lp3943.c                         |  242 +++++++++++++++
>   drivers/mfd/Kconfig                                |   11 +
>   drivers/mfd/Makefile                               |    1 +
>   drivers/mfd/lp3943.c                               |  167 +++++++++++
>   drivers/pwm/Kconfig                                |   10 +
>   drivers/pwm/Makefile                               |    1 +
>   drivers/pwm/pwm-lp3943.c                           |  314 ++++++++++++++++++++
>   include/linux/mfd/lp3943.h                         |  114 +++++++
>   13 files changed, 997 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/gpio/gpio-lp3943.txt
>   create mode 100644 Documentation/devicetree/bindings/mfd/lp3943.txt
>   create mode 100644 Documentation/devicetree/bindings/pwm/pwm-lp3943.txt
>   create mode 100644 drivers/gpio/gpio-lp3943.c
>   create mode 100644 drivers/mfd/lp3943.c
>   create mode 100644 drivers/pwm/pwm-lp3943.c
>   create mode 100644 include/linux/mfd/lp3943.h
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
