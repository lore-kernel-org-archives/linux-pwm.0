From: YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 2/2] pwm: add Mediatek display PWM driver support
Date: Thu, 14 May 2015 22:45:10 +0800
Message-ID: <1431614710.15140.31.camel@mtksdaap41>
References: <1431336382-13167-1-git-send-email-yh.huang@mediatek.com>
	 <1431336382-13167-3-git-send-email-yh.huang@mediatek.com>
	 <CABuKBeJz_=Nxcen9QU_KHds6UJwUJL0yNpYDhvT3eFoV_EY5xA@mail.gmail.com>
	 <CABuKBeJc3Kvdoejyi0XFbQMU2saztzV5S7jiXCg-09juYeh4pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CABuKBeJc3Kvdoejyi0XFbQMU2saztzV5S7jiXCg-09juYeh4pg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Tue, 2015-05-12 at 14:44 +0200, Matthias Brugger wrote:
> 2015-05-12 14:37 GMT+02:00 Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> > Hi YH,
> >
> > 2015-05-11 11:26 GMT+02:00 YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>:
> >> Add display PWM driver support to modify backlight for MT8173/MT6595.
> >>
> >> Signed-off-by: YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> >> ---
> >>  drivers/pwm/Kconfig             |   9 ++
> >>  drivers/pwm/Makefile            |   1 +
> >>  drivers/pwm/pwm-disp-mediatek.c | 225 ++++++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 235 insertions(+)
> >>  create mode 100644 drivers/pwm/pwm-disp-mediatek.c
> >>
> >> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> >> index b1541f4..9edbb5a 100644
> >> --- a/drivers/pwm/Kconfig
> >> +++ b/drivers/pwm/Kconfig
> >> @@ -111,6 +111,15 @@ config PWM_CLPS711X
> >>           To compile this driver as a module, choose M here: the module
> >>           will be called pwm-clps711x.
> >>
> >> +config PWM_DISP_MEDIATEK
> >> +       tristate "MEDIATEK display PWM driver"
> >> +       depends on OF
> >> +       help
> >> +         Generic PWM framework driver for mediatek disp-pwm device.
> >> +
> >> +         To compile this driver as a module, choose M here: the module
> >> +         will be called pwm-disp-mediatek.
> >> +
> >>  config PWM_EP93XX
> >>         tristate "Cirrus Logic EP93xx PWM support"
> >>         depends on ARCH_EP93XX
> >> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> >> index ec50eb5..c5ff72a 100644
> >> --- a/drivers/pwm/Makefile
> >> +++ b/drivers/pwm/Makefile
> >> @@ -8,6 +8,7 @@ obj-$(CONFIG_PWM_BCM_KONA)      += pwm-bcm-kona.o
> >>  obj-$(CONFIG_PWM_BCM2835)      += pwm-bcm2835.o
> >>  obj-$(CONFIG_PWM_BFIN)         += pwm-bfin.o
> >>  obj-$(CONFIG_PWM_CLPS711X)     += pwm-clps711x.o
> >> +obj-$(CONFIG_PWM_DISP_MEDIATEK)        += pwm-disp-mediatek.o
> >>  obj-$(CONFIG_PWM_EP93XX)       += pwm-ep93xx.o
> >>  obj-$(CONFIG_PWM_FSL_FTM)      += pwm-fsl-ftm.o
> >>  obj-$(CONFIG_PWM_IMG)          += pwm-img.o
> >> diff --git a/drivers/pwm/pwm-disp-mediatek.c b/drivers/pwm/pwm-disp-mediatek.c
> >> new file mode 100644
> >> index 0000000..38293af
> >> --- /dev/null
> >> +++ b/drivers/pwm/pwm-disp-mediatek.c
> >> @@ -0,0 +1,225 @@
> >> +/*
> >> + * Mediatek display pulse-width-modulation controller driver.
> >> + * Copyright (c) 2015 MediaTek Inc.
> >> + * Author: YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> >> + *
> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License version 2 as
> >> + * published by the Free Software Foundation.
> >> + *
> >> + * This program is distributed in the hope that it will be useful,
> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >> + * GNU General Public License for more details.
> >> + */
> >> +
> >> +#include <linux/clk.h>
> >> +#include <linux/err.h>
> >> +#include <linux/io.h>
> >> +#include <linux/module.h>
> >> +#include <linux/of.h>
> >> +#include <linux/pwm.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/slab.h>
> >> +
> >> +#define DISP_PWM_EN_OFF                        (0x0)
> >> +#define PWM_ENABLE_SHIFT               (0x0)
> >> +#define PWM_ENABLE_MASK                        (0x1 << PWM_ENABLE_SHIFT)
> >
> > Get rid of the _SHIFT which are actually zero, it will make the code
> > more readable.
> >
> >> +
> >> +#define DISP_PWM_COMMIT_OFF            (0x08)
> >> +#define PWM_COMMIT_SHIFT               (0x0)
> >> +#define PWM_COMMIT_MASK                        (0x1 << PWM_COMMIT_SHIFT)
> >> +
> >> +#define DISP_PWM_CON_0_OFF             (0x10)
> >> +#define PWM_CLKDIV_SHIFT               (0x10)
> 
> I prefer to have the shift values in decimal instead of hex, as it
> makes it easier to see which bits in the registers are the relevant
> ones.
> Sorry forgot that one.
> 

I think you are right.

> Cheers,
> Matthias

Thank for your suggestion.

Regards,
YH Huang

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
