From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 2/2] pwm: add Mediatek display PWM driver support
Date: Tue, 12 May 2015 14:44:20 +0200
Message-ID: <CABuKBeJc3Kvdoejyi0XFbQMU2saztzV5S7jiXCg-09juYeh4pg@mail.gmail.com>
References: <1431336382-13167-1-git-send-email-yh.huang@mediatek.com>
	<1431336382-13167-3-git-send-email-yh.huang@mediatek.com>
	<CABuKBeJz_=Nxcen9QU_KHds6UJwUJL0yNpYDhvT3eFoV_EY5xA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:34744 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932455AbbELMoW (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 12 May 2015 08:44:22 -0400
In-Reply-To: <CABuKBeJz_=Nxcen9QU_KHds6UJwUJL0yNpYDhvT3eFoV_EY5xA@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: YH Huang <yh.huang@mediatek.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-pwm@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, srv_heupstream <srv_heupstream@mediatek.com>, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>

2015-05-12 14:37 GMT+02:00 Matthias Brugger <matthias.bgg@gmail.com>:
> Hi YH,
>
> 2015-05-11 11:26 GMT+02:00 YH Huang <yh.huang@mediatek.com>:
>> Add display PWM driver support to modify backlight for MT8173/MT6595.
>>
>> Signed-off-by: YH Huang <yh.huang@mediatek.com>
>> ---
>>  drivers/pwm/Kconfig             |   9 ++
>>  drivers/pwm/Makefile            |   1 +
>>  drivers/pwm/pwm-disp-mediatek.c | 225 ++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 235 insertions(+)
>>  create mode 100644 drivers/pwm/pwm-disp-mediatek.c
>>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index b1541f4..9edbb5a 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -111,6 +111,15 @@ config PWM_CLPS711X
>>           To compile this driver as a module, choose M here: the module
>>           will be called pwm-clps711x.
>>
>> +config PWM_DISP_MEDIATEK
>> +       tristate "MEDIATEK display PWM driver"
>> +       depends on OF
>> +       help
>> +         Generic PWM framework driver for mediatek disp-pwm device.
>> +
>> +         To compile this driver as a module, choose M here: the module
>> +         will be called pwm-disp-mediatek.
>> +
>>  config PWM_EP93XX
>>         tristate "Cirrus Logic EP93xx PWM support"
>>         depends on ARCH_EP93XX
>> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
>> index ec50eb5..c5ff72a 100644
>> --- a/drivers/pwm/Makefile
>> +++ b/drivers/pwm/Makefile
>> @@ -8,6 +8,7 @@ obj-$(CONFIG_PWM_BCM_KONA)      += pwm-bcm-kona.o
>>  obj-$(CONFIG_PWM_BCM2835)      += pwm-bcm2835.o
>>  obj-$(CONFIG_PWM_BFIN)         += pwm-bfin.o
>>  obj-$(CONFIG_PWM_CLPS711X)     += pwm-clps711x.o
>> +obj-$(CONFIG_PWM_DISP_MEDIATEK)        += pwm-disp-mediatek.o
>>  obj-$(CONFIG_PWM_EP93XX)       += pwm-ep93xx.o
>>  obj-$(CONFIG_PWM_FSL_FTM)      += pwm-fsl-ftm.o
>>  obj-$(CONFIG_PWM_IMG)          += pwm-img.o
>> diff --git a/drivers/pwm/pwm-disp-mediatek.c b/drivers/pwm/pwm-disp-mediatek.c
>> new file mode 100644
>> index 0000000..38293af
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-disp-mediatek.c
>> @@ -0,0 +1,225 @@
>> +/*
>> + * Mediatek display pulse-width-modulation controller driver.
>> + * Copyright (c) 2015 MediaTek Inc.
>> + * Author: YH Huang <yh.huang@mediatek.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/pwm.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +
>> +#define DISP_PWM_EN_OFF                        (0x0)
>> +#define PWM_ENABLE_SHIFT               (0x0)
>> +#define PWM_ENABLE_MASK                        (0x1 << PWM_ENABLE_SHIFT)
>
> Get rid of the _SHIFT which are actually zero, it will make the code
> more readable.
>
>> +
>> +#define DISP_PWM_COMMIT_OFF            (0x08)
>> +#define PWM_COMMIT_SHIFT               (0x0)
>> +#define PWM_COMMIT_MASK                        (0x1 << PWM_COMMIT_SHIFT)
>> +
>> +#define DISP_PWM_CON_0_OFF             (0x10)
>> +#define PWM_CLKDIV_SHIFT               (0x10)

I prefer to have the shift values in decimal instead of hex, as it
makes it easier to see which bits in the registers are the relevant
ones.
Sorry forgot that one.

Cheers,
Matthias
