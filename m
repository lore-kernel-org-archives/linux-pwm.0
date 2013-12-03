From: Milo Kim <milo.kim@ti.com>
Subject: Re: [PATCH v4 0/4] LP3943 MFD driver for a GPIO expander and a PWM
 generator
Date: Wed, 4 Dec 2013 08:27:44 +0900
Message-ID: <529E68F0.1090904@ti.com>
References: <1380082975-6022-1-git-send-email-milo.kim@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51029 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755380Ab3LCX1t (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 3 Dec 2013 18:27:49 -0500
In-Reply-To: <1380082975-6022-1-git-send-email-milo.kim@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>
Cc: Milo Kim <milo.kim@ti.com>, Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

Hello Guys,

Could you check this patchset?
Driver documentation was moved from 'Documentation' to 
'drivers/mfd/lp3943.c'.

Thanks,
   Milo

On 09/25/2013 01:22 PM, Milo Kim wrote:
> LP3943 is an integrated device capable of driving 16 output channels.
> It can be used for GPIO expander and PWM generators.
> LP3493 registers are controlled via the I2C interface.
>
> This patch-set consists of four parts - MFD, GPIO, PWM and documents.
>
> Update from v3 to v4:
>    Move the driver description from the documentation to the MFD driver file.
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

