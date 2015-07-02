From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH v3 2/2] pwm: add MediaTek display PWM driver support
Date: Thu, 2 Jul 2015 16:14:28 +0800
Message-ID: <CAGS+omBYZ8LJrCwV=21_z33yjWfh9dqU5uve7SqMc9yB033wqg@mail.gmail.com>
References: <1435590211-38854-1-git-send-email-yh.huang@mediatek.com> <1435590211-38854-3-git-send-email-yh.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:35144 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752876AbbGBIOs (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 2 Jul 2015 04:14:48 -0400
Received: by ykdy1 with SMTP id y1so61715511ykd.2
        for <linux-pwm@vger.kernel.org>; Thu, 02 Jul 2015 01:14:48 -0700 (PDT)
In-Reply-To: <1435590211-38854-3-git-send-email-yh.huang@mediatek.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: YH Huang <yh.huang@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-pwm@vger.kernel.org, "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, srv_heupstream <srv_heupstream@mediatek.com>, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, Yingjoe Chen <yingjoe.chen@mediatek.com>

On Mon, Jun 29, 2015 at 11:03 PM, YH Huang <yh.huang@mediatek.com> wrote:
> Add display PWM driver support to modify backlight for MT8173 and MT6595.
> The PWM has one channel to control the brightness of the display.
> When the (high_width / period) is closer to 1, the screen is brighter; otherwise, it is darker.
>
> Change-Id: Ie85b295e2dddd90b4163af1c906df977f79b59d6
> Signed-off-by: YH Huang <yh.huang@mediatek.com>
> ---
>  drivers/pwm/Kconfig        |  10 ++
>  drivers/pwm/Makefile       |   1 +
>  drivers/pwm/pwm-mtk-disp.c | 256 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 267 insertions(+)
>  create mode 100644 drivers/pwm/pwm-mtk-disp.c
>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index b1541f4..90e3c079 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -211,6 +211,16 @@ config PWM_LPSS_PLATFORM
>           To compile this driver as a module, choose M here: the module
>           will be called pwm-lpss-platform.
>
> +config PWM_MTK_DISP
> +       tristate "MediaTek display PWM driver"
> +       depends on HAS_IOMEM

depends on ARCH_MEDIATEK || COMPILE_TEST

> +       help
> +         Generic PWM framework driver for MediaTek disp-pwm device.
> +         The PWM is used to control the backlight brightness for display.
> +
> +         To compile this driver as a module, choose M here: the module
> +         will be called pwm-mtk-disp.
> +
>  config PWM_MXS
>         tristate "Freescale MXS PWM support"
>         depends on ARCH_MXS && OF
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index ec50eb5..99c9e75 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_PWM_LPC32XX)     += pwm-lpc32xx.o
>  obj-$(CONFIG_PWM_LPSS)         += pwm-lpss.o
>  obj-$(CONFIG_PWM_LPSS_PCI)     += pwm-lpss-pci.o
>  obj-$(CONFIG_PWM_LPSS_PLATFORM)        += pwm-lpss-platform.o
> +obj-$(CONFIG_PWM_MTK_DISP)     += pwm-mtk-disp.o
>  obj-$(CONFIG_PWM_MXS)          += pwm-mxs.o
>  obj-$(CONFIG_PWM_PCA9685)      += pwm-pca9685.o
>  obj-$(CONFIG_PWM_PUV3)         += pwm-puv3.o
> diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
> new file mode 100644
> index 0000000..fb3a42e
> --- /dev/null
> +++ b/drivers/pwm/pwm-mtk-disp.c
> @@ -0,0 +1,256 @@
> +/*
> + * MediaTek display pulse-width-modulation controller driver.
> + * Copyright (c) 2015 MediaTek Inc.
> + * Author: YH Huang <yh.huang@mediatek.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/pwm.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#define DISP_PWM_EN            0x0
> +#define PWM_ENABLE_MASK                0x1

For one bit fields like this, it is nicer to use: BIT()

Thanks!
-Dan
