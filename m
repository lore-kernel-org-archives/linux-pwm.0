From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 2/2] pwm: sprd: Add Spreadtrum PWM support
Date: Tue, 13 Aug 2019 21:43:56 +0800
Message-ID: <CAMz4kuL-YFpV-JxAq2cM2=vKo1AUU2uWzrfG6SXG0NFqzOnq3Q@mail.gmail.com>
References: <6a38a3655bc8100764d85cb04dea5c2546a311e1.1565168564.git.baolin.wang@linaro.org>
 <40127356a1acd1f2ff1be1d8a120b305a4e17af4.1565168564.git.baolin.wang@linaro.org>
 <20190809091013.vguj4wty7qiab64t@pengutronix.de> <CAMz4kuLQsrBWjta1s=ZRPgxUd0_+_f-GbJV138tccuMLg2XCLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMz4kuLQsrBWjta1s=ZRPgxUd0_+_f-GbJV138tccuMLg2XCLA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>, Vincent Guittot <vincent.guittot@linaro.org>, linux-pwm@vger.kernel.org, DTML <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

Hi Uwe,

On Fri, 9 Aug 2019 at 18:06, Baolin Wang <baolin.wang@linaro.org> wrote:
>
>  Hi Uwe,
>
> On Fri, 9 Aug 2019 at 17:10, Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > On Thu, Aug 08, 2019 at 04:59:39PM +0800, Baolin Wang wrote:
> > > From: Neo Hou <neo.hou@unisoc.com>
> > >
> > > This patch adds the Spreadtrum PWM support, which provides maximum 4
> > > channels.
> > >
> > > Signed-off-by: Neo Hou <neo.hou@unisoc.com>
> > > Co-developed-by: Baolin Wang <baolin.wang@linaro.org>
> > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > > ---
> > >  drivers/pwm/Kconfig    |   10 ++
> > >  drivers/pwm/Makefile   |    1 +
> > >  drivers/pwm/pwm-sprd.c |  311 ++++++++++++++++++++++++++++++++++++++=
++++++++++
> > >  3 files changed, 322 insertions(+)
> > >  create mode 100644 drivers/pwm/pwm-sprd.c
> > >
> > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > > index a7e5751..4963b4d 100644
> > > --- a/drivers/pwm/Kconfig
> > > +++ b/drivers/pwm/Kconfig
> > > @@ -423,6 +423,16 @@ config PWM_SPEAR
> > >         To compile this driver as a module, choose M here: the module
> > >         will be called pwm-spear.
> > >
> > > +config PWM_SPRD
> > > +     tristate "Spreadtrum PWM support"
> > > +     depends on ARCH_SPRD || COMPILE_TEST
> >
> > I think you need
> >
> >         depends on HAS_IOMEM
>
> OK.
>
> >
> > > +     help
> > > +       Generic PWM framework driver for the PWM controller on
> > > +       Spreadtrum SoCs.
> > > +
> > > +       To compile this driver as a module, choose M here: the module
> > > +       will be called pwm-sprd.
> > > +
> > >  config PWM_STI
> > >       tristate "STiH4xx PWM support"
> > >       depends on ARCH_STI
> > > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > > index 76b555b..26326ad 100644
> > > --- a/drivers/pwm/Makefile
> > > +++ b/drivers/pwm/Makefile
> > > @@ -41,6 +41,7 @@ obj-$(CONFIG_PWM_ROCKCHIP)  +=3D pwm-rockchip.o
> > >  obj-$(CONFIG_PWM_SAMSUNG)    +=3D pwm-samsung.o
> > >  obj-$(CONFIG_PWM_SIFIVE)     +=3D pwm-sifive.o
> > >  obj-$(CONFIG_PWM_SPEAR)              +=3D pwm-spear.o
> > > +obj-$(CONFIG_PWM_SPRD)               +=3D pwm-sprd.o
> > >  obj-$(CONFIG_PWM_STI)                +=3D pwm-sti.o
> > >  obj-$(CONFIG_PWM_STM32)              +=3D pwm-stm32.o
> > >  obj-$(CONFIG_PWM_STM32_LP)   +=3D pwm-stm32-lp.o
> > > diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
> > > new file mode 100644
> > > index 0000000..f6fc793
> > > --- /dev/null
> > > +++ b/drivers/pwm/pwm-sprd.c
> > > @@ -0,0 +1,311 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (C) 2019 Spreadtrum Communications Inc.
> >
> > If there is a publicly available reference manual available, please add
> > a link to it here.
>
> Sure.

Sorry, we have not supplied a publicly available reference manual now.
So no change for this comment in next version.

--=20
Baolin Wang
Best Regards
