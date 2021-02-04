Return-path: <fengzheng923@gmail.com>
MIME-Version: 1.0
References: <20210203125317.1975-1-fengzheng923@gmail.com> <20210203154628.infi5jnlofdrysvs@gilmour>
In-Reply-To: <20210203154628.infi5jnlofdrysvs@gilmour>
From: =?UTF-8?B?54+t5rab?= <fengzheng923@gmail.com>
Date: Thu, 4 Feb 2021 11:47:34 +0800
Message-ID: <CAE=m61-oXn8CkzUpSxkuS-gLkxjwd8wSeL42Q5T+27_V89xgNw@mail.gmail.com>
Content-Type: multipart/alternative; boundary="00000000000011124c05ba7a9129"
Subject: Re: [PATCH v2] pwm: sunxi: Add Allwinner SoC PWM controller driver
To: Maxime Ripard <maxime@cerno.tech>
Cc: thierry.reding@gmail.com, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, wens@csie.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>

--00000000000011124c05ba7a9129
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Maxime:

Maxime Ripard <maxime@cerno.tech> =E4=BA=8E2021=E5=B9=B42=E6=9C=883=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8811:46=E5=86=99=E9=81=93=EF=BC=9A

> Hi,
>
> On Wed, Feb 03, 2021 at 08:53:17PM +0800, Ban Tao wrote:
> > From: Ban Tao <fengzheng923@gmail.com>
> >
> > The Allwinner R818, A133, R329, V536 and V833 has a new PWM controller
> > IP compared to the older Allwinner SoCs.
> >
> > Signed-off-by: Ban Tao <fengzheng923@gmail.com>
>
> Thanks for your patch. There's a bunch of warnings reported by
> checkpatch --strict, they should be addressed.
>
> > ---
> > v1->v2:
> > 1.delete unnecessary code.
> > 2.using a named define for some constants.
> > 3.Add comment in sun50i_pwm_config function.
> > 4.using dev_err_probe() for error handling.
> > 5.disable the clock after pwmchip_remove().
> > ---
> >  MAINTAINERS              |   6 +
> >  drivers/pwm/Kconfig      |  11 ++
> >  drivers/pwm/Makefile     |   1 +
> >  drivers/pwm/pwm-sun50i.c | 348 +++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 366 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-sun50i.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e73636b75f29..d33cf1b69b43 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -737,6 +737,12 @@ L:       linux-media@vger.kernel.org
> >  S:   Maintained
> >  F:   drivers/staging/media/sunxi/cedrus/
> >
> > +ALLWINNER PWM DRIVER
> > +M:   Ban Tao <fengzheng923@gmail.com>
> > +L:   linux-pwm@vger.kernel.org
> > +S:   Maintained
> > +F:   drivers/pwm/pwm-sun50i.c
> > +
> >  ALPHA PORT
> >  M:   Richard Henderson <rth@twiddle.net>
> >  M:   Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index 9a4f66ae8070..17635a8f2ed3 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -552,6 +552,17 @@ config PWM_SUN4I
> >         To compile this driver as a module, choose M here: the module
> >         will be called pwm-sun4i.
> >
> > +config PWM_SUN50I
> > +     tristate "Allwinner enhanced PWM support"
> > +     depends on ARCH_SUNXI || COMPILE_TEST
> > +     depends on HAS_IOMEM && COMMON_CLK
> > +     help
> > +       Enhanced PWM framework driver for Allwinner R818, A133, R329,
> > +       V536 and V833 SoCs.
> > +
> > +       To compile this driver as a module, choose M here: the module
> > +       will be called pwm-sun50i.
> > +
>
> Even though it's unfortunate, there's a bunch of other SoCs part of the
> sun50i family that are supported by the sun4i driver.
>
> Which SoC introduced that new design? It's usually the name we pick up
> then.
>

In fact, some SoCs has not been supported by the sun4i driver, such as v833=
,
v536, r818, a133 and r329.
v833 and v536 are part of the sun8i family, but r818, a133 and r329 are
part of the sun50i family.
So,I'm confused, how do choose the name of this driver?


>
> >  config PWM_TEGRA
> >       tristate "NVIDIA Tegra PWM support"
> >       depends on ARCH_TEGRA || COMPILE_TEST
> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index 6374d3b1d6f3..b4754927fd8f 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -51,6 +51,7 @@ obj-$(CONFIG_PWM_STM32)             +=3D pwm-stm32.o
> >  obj-$(CONFIG_PWM_STM32_LP)   +=3D pwm-stm32-lp.o
> >  obj-$(CONFIG_PWM_STMPE)              +=3D pwm-stmpe.o
> >  obj-$(CONFIG_PWM_SUN4I)              +=3D pwm-sun4i.o
> > +obj-$(CONFIG_PWM_SUN50I)     +=3D pwm-sun50i.o
> >  obj-$(CONFIG_PWM_TEGRA)              +=3D pwm-tegra.o
> >  obj-$(CONFIG_PWM_TIECAP)     +=3D pwm-tiecap.o
> >  obj-$(CONFIG_PWM_TIEHRPWM)   +=3D pwm-tiehrpwm.o
> > diff --git a/drivers/pwm/pwm-sun50i.c b/drivers/pwm/pwm-sun50i.c
> > new file mode 100644
> > index 000000000000..37285d771924
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-sun50i.c
> > @@ -0,0 +1,348 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Driver for Allwinner sun50i Pulse Width Modulation Controller
> > + *
> > + * Copyright (C) 2020 Ban Tao <fengzheng923@gmail.com>
> > + */
> > +
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/pwm.h>
> > +#include <linux/clk.h>
> > +#include <linux/reset.h>
> > +
> > +#define PWM_GET_CLK_OFFSET(chan)     (0x20 + ((chan >> 1) * 0x4))
> > +#define PWM_CLK_APB_SCR                      BIT(7)
> > +#define PWM_DIV_M                    0
> > +#define PWM_DIV_M_WIDTH                      0x4
> > +
> > +#define PWM_CLK_REG                  0x40
> > +#define PWM_CLK_GATING                       BIT(0)
> > +
> > +#define PWM_ENABLE_REG                       0x80
> > +#define PWM_EN                               BIT(0)
> > +
> > +#define PWM_CTL_REG(chan)            (0x100 + 0x20 * chan)
> > +#define PWM_ACT_STA                  BIT(8)
> > +#define PWM_PRESCAL_K                        0
> > +#define PWM_PRESCAL_K_WIDTH          0x8
> > +
> > +#define PWM_PERIOD_REG(chan)         (0x104 + 0x20 * chan)
> > +#define PWM_ENTIRE_CYCLE             16
> > +#define PWM_ENTIRE_CYCLE_WIDTH               0x10
> > +#define PWM_ACT_CYCLE                        0
> > +#define PWM_ACT_CYCLE_WIDTH          0x10
> > +
> > +#define BIT_CH(bit, chan)            ((bit) << (chan))
> > +
> > +#define SETMASK(width, shift)                ((width?((-1U) >>
> (32-width)):0)  << (shift))
> > +#define CLRMASK(width, shift)                (~(SETMASK(width, shift))=
)
> > +#define GET_BITS(shift, width, reg)     \
> > +         (((reg) & SETMASK(width, shift)) >> (shift))
> > +#define SET_BITS(shift, width, reg, val) \
> > +         (((reg) & CLRMASK(width, shift)) | (val << (shift)))
> > +
> > +#define PWM_OSC_CLK                  24000000
> > +#define PWM_PRESCALER_MAX            256
> > +#define PWM_CLK_DIV_M__MAX           9
> > +#define PWM_ENTIRE_CYCLE_MAX         65536
> > +
> > +struct sun50i_pwm_data {
> > +     unsigned int npwm;
> > +};
> > +
> > +struct sun50i_pwm_chip {
> > +     struct pwm_chip chip;
> > +     struct clk *clk;
> > +     struct reset_control *rst_clk;
> > +     void __iomem *base;
> > +     const struct sun50i_pwm_data *data;
> > +};
> > +
> > +static inline struct sun50i_pwm_chip *sun50i_pwm_from_chip(struct
> pwm_chip *chip)
> > +{
> > +     return container_of(chip, struct sun50i_pwm_chip, chip);
> > +}
> > +
> > +static inline u32 sun50i_pwm_readl(struct sun50i_pwm_chip *chip,
> > +                               unsigned long offset)
> > +{
> > +     return readl(chip->base + offset);
> > +}
> > +
> > +static inline void sun50i_pwm_writel(struct sun50i_pwm_chip *chip,
> > +                                 u32 val, unsigned long offset)
> > +{
> > +     writel(val, chip->base + offset);
> > +}
> > +
> > +static int sun50i_pwm_set_polarity(struct pwm_chip *chip, struct
> pwm_device *pwm,
> > +                             enum pwm_polarity polarity)
> > +{
> > +     struct sun50i_pwm_chip *sun50i_pwm =3D sun50i_pwm_from_chip(chip)=
;
> > +     u32 temp;
> > +
> > +     temp =3D sun50i_pwm_readl(sun50i_pwm, PWM_CTL_REG(pwm->hwpwm));
> > +
> > +     if (polarity =3D=3D PWM_POLARITY_NORMAL)
> > +             temp |=3D PWM_ACT_STA;
> > +     else
> > +             temp &=3D ~PWM_ACT_STA;
> > +
> > +     sun50i_pwm_writel(sun50i_pwm, temp, PWM_CTL_REG(pwm->hwpwm));
> > +
> > +     return 0;
> > +}
> > +
> > +static int sun50i_pwm_config(struct pwm_chip *chip, struct pwm_device
> *pwm,
> > +             int duty_ns, int period_ns)
> > +{
> > +     struct sun50i_pwm_chip *sun50i_pwm =3D sun50i_pwm_from_chip(chip)=
;
> > +     unsigned long long c;
> > +     unsigned long entire_cycles, active_cycles;
> > +     unsigned int div_m, prescaler;
> > +     u32 tmp;
> > +
> > +     if (period_ns > 334) {
> > +             /* if freq < 3M, then select 24M clock */
> > +             c =3D PWM_OSC_CLK;
> > +             tmp =3D sun50i_pwm_readl(sun50i_pwm,
> PWM_GET_CLK_OFFSET(pwm->hwpwm));
> > +             tmp &=3D ~PWM_CLK_APB_SCR;
> > +             sun50i_pwm_writel(sun50i_pwm, tmp,
> PWM_GET_CLK_OFFSET(pwm->hwpwm));
> > +     } else {
> > +             /* if freq > 3M, then select APB as clock */
> > +             c =3D clk_get_rate(sun50i_pwm->clk);
> > +             tmp =3D sun50i_pwm_readl(sun50i_pwm,
> PWM_GET_CLK_OFFSET(pwm->hwpwm));
> > +             tmp |=3D PWM_CLK_APB_SCR;
> > +             sun50i_pwm_writel(sun50i_pwm, tmp,
> PWM_GET_CLK_OFFSET(pwm->hwpwm));
> > +     }
> > +
> > +     dev_dbg(chip->dev, "duty_ns=3D%d period_ns=3D%d c =3D%llu.\n",
> > +                     duty_ns, period_ns, c);
> > +
> > +     /*
> > +      * (clk / div_m / prescaler) / entire_cycles =3D NSEC_PER_SEC /
> period_ns.
> > +      * So, entire_cycles =3D clk * period_ns / NSEC_PER_SEC / div_m /
> prescaler.
> > +      */
> > +     c =3D c * period_ns;
> > +     do_div(c, NSEC_PER_SEC);
> > +     for (div_m =3D 0; div_m < PWM_CLK_DIV_M__MAX; div_m++) {
> > +             for (prescaler =3D 0; prescaler < PWM_PRESCALER_MAX;
> prescaler++) {
> > +                     /*
> > +                      * actual prescaler =3D prescaler + 1.
> > +                      * actual div_m =3D 0x1 << div_m.
> > +                     */
> > +                     entire_cycles =3D ((unsigned long)c/(0x1 <<
> div_m))/(prescaler + 1);
> > +                     if (entire_cycles <=3D PWM_ENTIRE_CYCLE_MAX) {
> > +                             goto calc_end;
> > +                     }
> > +             }
> > +     }
> > +
> > +calc_end:
> > +     /*
> > +      * duty_ns / period_ns =3D active_cycles / entire_cycles.
> > +      * So, active_cycles =3D entire_cycles * duty_ns / period_ns.
> > +      */
> > +     c =3D (unsigned long long)entire_cycles * duty_ns;
> > +     do_div(c, period_ns);
> > +     active_cycles =3D c;
> > +     if (entire_cycles =3D=3D 0)
> > +             entire_cycles++;
> > +
> > +     /* enable clk gating */
> > +     tmp =3D sun50i_pwm_readl(sun50i_pwm, PWM_CLK_REG);
> > +     tmp |=3D BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
> > +     sun50i_pwm_writel(sun50i_pwm, tmp, PWM_CLK_REG);
> > +
> > +     /* config  clk div_m*/
> > +     tmp =3D sun50i_pwm_readl(sun50i_pwm, PWM_GET_CLK_OFFSET(pwm->hwpw=
m));
> > +     tmp =3D SET_BITS(PWM_DIV_M, PWM_DIV_M_WIDTH, tmp, div_m);
> > +     sun50i_pwm_writel(sun50i_pwm, tmp, PWM_GET_CLK_OFFSET(pwm->hwpwm)=
);
> > +
> > +     /* config prescal */
> > +     tmp =3D sun50i_pwm_readl(sun50i_pwm, PWM_CTL_REG(pwm->hwpwm));
> > +     tmp =3D SET_BITS(PWM_PRESCAL_K, PWM_PRESCAL_K_WIDTH, tmp, prescal=
er);
> > +     sun50i_pwm_writel(sun50i_pwm, tmp, PWM_CTL_REG(pwm->hwpwm));
> > +
> > +     /* config active and period cycles */
> > +     tmp =3D sun50i_pwm_readl(sun50i_pwm, PWM_PERIOD_REG(pwm->hwpwm));
> > +     tmp =3D SET_BITS(PWM_ACT_CYCLE, PWM_ACT_CYCLE_WIDTH, tmp,
> active_cycles);
> > +     tmp =3D SET_BITS(PWM_ENTIRE_CYCLE, PWM_ENTIRE_CYCLE_WIDTH, tmp,
> (entire_cycles - 1));
> > +     sun50i_pwm_writel(sun50i_pwm, tmp, PWM_PERIOD_REG(pwm->hwpwm));
> > +
> > +     dev_dbg(chip->dev, "active_cycles=3D%lu entire_cycles=3D%lu
> prescaler=3D%u div_m=3D%u\n",
> > +                     active_cycles, entire_cycles, prescaler, div_m);
> > +
> > +     return 0;
> > +}
> > +
> > +static int sun50i_pwm_enable(struct pwm_chip *chip, struct pwm_device
> *pwm)
> > +{
> > +     struct sun50i_pwm_chip *sun50i_pwm =3D sun50i_pwm_from_chip(chip)=
;
> > +     u32 tmp;
> > +
> > +     /* enable pwm controller */
> > +     tmp =3D sun50i_pwm_readl(sun50i_pwm, PWM_ENABLE_REG);
> > +     tmp |=3D BIT_CH(PWM_EN, pwm->hwpwm);
> > +     sun50i_pwm_writel(sun50i_pwm, tmp, PWM_ENABLE_REG);
> > +
> > +     tmp =3D sun50i_pwm_readl(sun50i_pwm, PWM_CLK_REG);
> > +     tmp |=3D BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
> > +     sun50i_pwm_writel(sun50i_pwm, tmp, PWM_CLK_REG);
> > +
> > +     return 0;
> > +}
> > +
> > +static void sun50i_pwm_disable(struct pwm_chip *chip, struct pwm_devic=
e
> *pwm)
> > +{
> > +     struct sun50i_pwm_chip *sun50i_pwm =3D sun50i_pwm_from_chip(chip)=
;
> > +     u32 tmp;
> > +
> > +     /* disable pwm controller */
> > +     tmp =3D sun50i_pwm_readl(sun50i_pwm, PWM_ENABLE_REG);
> > +     tmp &=3D ~BIT_CH(PWM_EN, pwm->hwpwm);
> > +     sun50i_pwm_writel(sun50i_pwm, tmp, PWM_ENABLE_REG);
> > +
> > +     tmp =3D sun50i_pwm_readl(sun50i_pwm, PWM_CLK_REG);
> > +     tmp &=3D ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
> > +     sun50i_pwm_writel(sun50i_pwm, tmp, PWM_CLK_REG);
> > +}
> > +
> > +static const struct pwm_ops sun50i_pwm_ops =3D {
> > +     .config =3D sun50i_pwm_config,
> > +     .enable =3D sun50i_pwm_enable,
> > +     .disable =3D sun50i_pwm_disable,
> > +     .set_polarity =3D sun50i_pwm_set_polarity,
> > +     .owner =3D THIS_MODULE,
> > +};
> > +
> > +static const struct sun50i_pwm_data sun8i_pwm_data_c9 =3D {
> > +     .npwm =3D 9,
> > +};
> > +
> > +static const struct sun50i_pwm_data sun50i_pwm_data_c16 =3D {
> > +     .npwm =3D 16,
> > +};
> > +
> > +static const struct of_device_id sun50i_pwm_dt_ids[] =3D {
> > +     {
> > +             .compatible =3D "allwinner,sun8i-v833-pwm",
> > +             .data =3D &sun8i_pwm_data_c9,
> > +     }, {
> > +             .compatible =3D "allwinner,sun8i-v536-pwm",
> > +             .data =3D &sun8i_pwm_data_c9,
> > +     }, {
> > +             .compatible =3D "allwinner,sun50i-r818-pwm",
> > +             .data =3D &sun50i_pwm_data_c16,
> > +     }, {
> > +             .compatible =3D "allwinner,sun50i-a133-pwm",
> > +             .data =3D &sun50i_pwm_data_c16,
> > +     }, {
> > +             .compatible =3D "allwinner,sun50i-r329-pwm",
> > +             .data =3D &sun8i_pwm_data_c9,
> > +     }, {
> > +             /* sentinel */
> > +     },
> > +};
> > +MODULE_DEVICE_TABLE(of, sun50i_pwm_dt_ids);
>
> What are the differences between all these SoCs? If there's none between
> the v833, v536 and R329, and between the r818 and the A133, you should
> use the same compatible.
>

Compared with the sun4i driver, this patch is a completely different PWM IP
controller.


>
> The device tree binding must be documented too
>

DT binding docs and includes should be a separate patch, right?


>
> Maxime
>

--00000000000011124c05ba7a9129
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Maxime:</div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">Maxime Ripard &lt;maxime@cerno.tech&gt; =E4=
=BA=8E2021=E5=B9=B42=E6=9C=883=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=
=8811:46=E5=86=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">Hi,<br>
<br>
On Wed, Feb 03, 2021 at 08:53:17PM +0800, Ban Tao wrote:<br>
&gt; From: Ban Tao &lt;<a href=3D"mailto:fengzheng923@gmail.com" target=3D"=
_blank">fengzheng923@gmail.com</a>&gt;<br>
&gt; <br>
&gt; The Allwinner R818, A133, R329, V536 and V833 has a new PWM controller=
<br>
&gt; IP compared to the older Allwinner SoCs.<br>
&gt; <br>
&gt; Signed-off-by: Ban Tao &lt;<a href=3D"mailto:fengzheng923@gmail.com" t=
arget=3D"_blank">fengzheng923@gmail.com</a>&gt;<br>
<br>
Thanks for your patch. There&#39;s a bunch of warnings reported by<br>
checkpatch --strict, they should be addressed.<br>
<br>
&gt; ---<br>
&gt; v1-&gt;v2:<br>
&gt; 1.delete unnecessary code.<br>
&gt; 2.using a named define for some constants.<br>
&gt; 3.Add comment in sun50i_pwm_config function.<br>
&gt; 4.using dev_err_probe() for error handling.<br>
&gt; 5.disable the clock after pwmchip_remove().<br>
&gt; ---<br>
&gt;=C2=A0 MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A06 +<br>
&gt;=C2=A0 drivers/pwm/Kconfig=C2=A0 =C2=A0 =C2=A0 |=C2=A0 11 ++<br>
&gt;=C2=A0 drivers/pwm/Makefile=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 drivers/pwm/pwm-sun50i.c | 348 +++++++++++++++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 4 files changed, 366 insertions(+)<br>
&gt;=C2=A0 create mode 100644 drivers/pwm/pwm-sun50i.c<br>
&gt; <br>
&gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt; index e73636b75f29..d33cf1b69b43 100644<br>
&gt; --- a/MAINTAINERS<br>
&gt; +++ b/MAINTAINERS<br>
&gt; @@ -737,6 +737,12 @@ L:=C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailto:li=
nux-media@vger.kernel.org" target=3D"_blank">linux-media@vger.kernel.org</a=
><br>
&gt;=C2=A0 S:=C2=A0 =C2=A0Maintained<br>
&gt;=C2=A0 F:=C2=A0 =C2=A0drivers/staging/media/sunxi/cedrus/<br>
&gt;=C2=A0 <br>
&gt; +ALLWINNER PWM DRIVER<br>
&gt; +M:=C2=A0 =C2=A0Ban Tao &lt;<a href=3D"mailto:fengzheng923@gmail.com" =
target=3D"_blank">fengzheng923@gmail.com</a>&gt;<br>
&gt; +L:=C2=A0 =C2=A0<a href=3D"mailto:linux-pwm@vger.kernel.org" target=3D=
"_blank">linux-pwm@vger.kernel.org</a><br>
&gt; +S:=C2=A0 =C2=A0Maintained<br>
&gt; +F:=C2=A0 =C2=A0drivers/pwm/pwm-sun50i.c<br>
&gt; +<br>
&gt;=C2=A0 ALPHA PORT<br>
&gt;=C2=A0 M:=C2=A0 =C2=A0Richard Henderson &lt;<a href=3D"mailto:rth@twidd=
le.net" target=3D"_blank">rth@twiddle.net</a>&gt;<br>
&gt;=C2=A0 M:=C2=A0 =C2=A0Ivan Kokshaysky &lt;<a href=3D"mailto:ink@jurassi=
c.park.msu.ru" target=3D"_blank">ink@jurassic.park.msu.ru</a>&gt;<br>
&gt; diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig<br>
&gt; index 9a4f66ae8070..17635a8f2ed3 100644<br>
&gt; --- a/drivers/pwm/Kconfig<br>
&gt; +++ b/drivers/pwm/Kconfig<br>
&gt; @@ -552,6 +552,17 @@ config PWM_SUN4I<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0To compile this driver as a module, c=
hoose M here: the module<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0will be called pwm-sun4i.<br>
&gt;=C2=A0 <br>
&gt; +config PWM_SUN50I<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tristate &quot;Allwinner enhanced PWM support&quo=
t;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0depends on ARCH_SUNXI || COMPILE_TEST<br>
&gt; +=C2=A0 =C2=A0 =C2=A0depends on HAS_IOMEM &amp;&amp; COMMON_CLK<br>
&gt; +=C2=A0 =C2=A0 =C2=A0help<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0Enhanced PWM framework driver for Allwinne=
r R818, A133, R329,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0V536 and V833 SoCs.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0To compile this driver as a module, choose=
 M here: the module<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0will be called pwm-sun50i.<br>
&gt; +<br>
<br>
Even though it&#39;s unfortunate, there&#39;s a bunch of other SoCs part of=
 the<br>
sun50i family that are supported by the sun4i driver.<br>
<br>
Which SoC introduced that new design? It&#39;s usually the name we pick up<=
br>
then.<br></blockquote><div><br></div><div>In fact, some SoCs has not been s=
upported by the sun4i driver, such as v833,</div><div>v536, r818, a133 and =
r329.<br>v833 and v536 are part of the sun8i family, but r818, a133 and r32=
9 are part of the sun50i family.<br>So,I&#39;m confused, how do choose the =
name of this driver?<br></div><div>=C2=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
<br>
&gt;=C2=A0 config PWM_TEGRA<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tristate &quot;NVIDIA Tegra PWM support&quot=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0depends on ARCH_TEGRA || COMPILE_TEST<br>
&gt; diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile<br>
&gt; index 6374d3b1d6f3..b4754927fd8f 100644<br>
&gt; --- a/drivers/pwm/Makefile<br>
&gt; +++ b/drivers/pwm/Makefile<br>
&gt; @@ -51,6 +51,7 @@ obj-$(CONFIG_PWM_STM32)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0+=3D pwm-stm32.o<br>
&gt;=C2=A0 obj-$(CONFIG_PWM_STM32_LP)=C2=A0 =C2=A0+=3D pwm-stm32-lp.o<br>
&gt;=C2=A0 obj-$(CONFIG_PWM_STMPE)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 +=3D pwm-stmpe.o<br>
&gt;=C2=A0 obj-$(CONFIG_PWM_SUN4I)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 +=3D pwm-sun4i.o<br>
&gt; +obj-$(CONFIG_PWM_SUN50I)=C2=A0 =C2=A0 =C2=A0+=3D pwm-sun50i.o<br>
&gt;=C2=A0 obj-$(CONFIG_PWM_TEGRA)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 +=3D pwm-tegra.o<br>
&gt;=C2=A0 obj-$(CONFIG_PWM_TIECAP)=C2=A0 =C2=A0 =C2=A0+=3D pwm-tiecap.o<br=
>
&gt;=C2=A0 obj-$(CONFIG_PWM_TIEHRPWM)=C2=A0 =C2=A0+=3D pwm-tiehrpwm.o<br>
&gt; diff --git a/drivers/pwm/pwm-sun50i.c b/drivers/pwm/pwm-sun50i.c<br>
&gt; new file mode 100644<br>
&gt; index 000000000000..37285d771924<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/pwm/pwm-sun50i.c<br>
&gt; @@ -0,0 +1,348 @@<br>
&gt; +// SPDX-License-Identifier: GPL-2.0-only<br>
&gt; +/*<br>
&gt; + * Driver for Allwinner sun50i Pulse Width Modulation Controller<br>
&gt; + *<br>
&gt; + * Copyright (C) 2020 Ban Tao &lt;<a href=3D"mailto:fengzheng923@gmai=
l.com" target=3D"_blank">fengzheng923@gmail.com</a>&gt;<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &lt;linux/err.h&gt;<br>
&gt; +#include &lt;linux/io.h&gt;<br>
&gt; +#include &lt;linux/module.h&gt;<br>
&gt; +#include &lt;linux/of_device.h&gt;<br>
&gt; +#include &lt;linux/pwm.h&gt;<br>
&gt; +#include &lt;linux/clk.h&gt;<br>
&gt; +#include &lt;linux/reset.h&gt;<br>
&gt; +<br>
&gt; +#define PWM_GET_CLK_OFFSET(chan)=C2=A0 =C2=A0 =C2=A0(0x20 + ((chan &g=
t;&gt; 1) * 0x4))<br>
&gt; +#define PWM_CLK_APB_SCR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BIT(7)<br>
&gt; +#define PWM_DIV_M=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 0<br>
&gt; +#define PWM_DIV_M_WIDTH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x4<br>
&gt; +<br>
&gt; +#define PWM_CLK_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 0x40<br>
&gt; +#define PWM_CLK_GATING=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(0)<br>
&gt; +<br>
&gt; +#define PWM_ENABLE_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x80<br>
&gt; +#define PWM_EN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(0)<br>
&gt; +<br>
&gt; +#define PWM_CTL_REG(chan)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (0=
x100 + 0x20 * chan)<br>
&gt; +#define PWM_ACT_STA=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 BIT(8)<br>
&gt; +#define PWM_PRESCAL_K=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
&gt; +#define PWM_PRESCAL_K_WIDTH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x8<br>
&gt; +<br>
&gt; +#define PWM_PERIOD_REG(chan)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x104 =
+ 0x20 * chan)<br>
&gt; +#define PWM_ENTIRE_CYCLE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A016<br>
&gt; +#define PWM_ENTIRE_CYCLE_WIDTH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A00x10<br>
&gt; +#define PWM_ACT_CYCLE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
&gt; +#define PWM_ACT_CYCLE_WIDTH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x10<br=
>
&gt; +<br>
&gt; +#define BIT_CH(bit, chan)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((=
bit) &lt;&lt; (chan))<br>
&gt; +<br>
&gt; +#define SETMASK(width, shift)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ((width?((-1U) &gt;&gt; (32-width)):0)=C2=A0 &lt;&lt; (sh=
ift))<br>
&gt; +#define CLRMASK(width, shift)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 (~(SETMASK(width, shift)))<br>
&gt; +#define GET_BITS(shift, width, reg)=C2=A0 =C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(((reg) &amp; SETMASK(width, shift)=
) &gt;&gt; (shift))<br>
&gt; +#define SET_BITS(shift, width, reg, val) \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(((reg) &amp; CLRMASK(width, shift)=
) | (val &lt;&lt; (shift)))<br>
&gt; +<br>
&gt; +#define PWM_OSC_CLK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 24000000<br>
&gt; +#define PWM_PRESCALER_MAX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 25=
6<br>
&gt; +#define PWM_CLK_DIV_M__MAX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A09<=
br>
&gt; +#define PWM_ENTIRE_CYCLE_MAX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A065536<b=
r>
&gt; +<br>
&gt; +struct sun50i_pwm_data {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int npwm;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct sun50i_pwm_chip {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct pwm_chip chip;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct clk *clk;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct reset_control *rst_clk;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0void __iomem *base;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0const struct sun50i_pwm_data *data;<br>
&gt; +};<br>
&gt; +<br>
&gt; +static inline struct sun50i_pwm_chip *sun50i_pwm_from_chip(struct pwm=
_chip *chip)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return container_of(chip, struct sun50i_pwm_chip,=
 chip);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static inline u32 sun50i_pwm_readl(struct sun50i_pwm_chip *chip,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long offset)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return readl(chip-&gt;base + offset);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static inline void sun50i_pwm_writel(struct sun50i_pwm_chip *chip,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 val, unsigned long off=
set)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0writel(val, chip-&gt;base + offset);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int sun50i_pwm_set_polarity(struct pwm_chip *chip, struct pwm_=
device *pwm,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum pwm_polarity polarity)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct sun50i_pwm_chip *sun50i_pwm =3D sun50i_pwm=
_from_chip(chip);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 temp;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0temp =3D sun50i_pwm_readl(sun50i_pwm, PWM_CTL_REG=
(pwm-&gt;hwpwm));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (polarity =3D=3D PWM_POLARITY_NORMAL)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0temp |=3D PWM_ACT_STA=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0temp &amp;=3D ~PWM_AC=
T_STA;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0sun50i_pwm_writel(sun50i_pwm, temp, PWM_CTL_REG(p=
wm-&gt;hwpwm));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int sun50i_pwm_config(struct pwm_chip *chip, struct pwm_device=
 *pwm,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int duty_ns, int peri=
od_ns)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct sun50i_pwm_chip *sun50i_pwm =3D sun50i_pwm=
_from_chip(chip);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned long long c;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned long entire_cycles, active_cycles;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int div_m, prescaler;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 tmp;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (period_ns &gt; 334) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* if freq &lt; 3M, t=
hen select 24M clock */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c =3D PWM_OSC_CLK;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D sun50i_pwm_re=
adl(sun50i_pwm, PWM_GET_CLK_OFFSET(pwm-&gt;hwpwm));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp &amp;=3D ~PWM_CLK=
_APB_SCR;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sun50i_pwm_writel(sun=
50i_pwm, tmp, PWM_GET_CLK_OFFSET(pwm-&gt;hwpwm));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* if freq &gt; 3M, t=
hen select APB as clock */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c =3D clk_get_rate(su=
n50i_pwm-&gt;clk);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D sun50i_pwm_re=
adl(sun50i_pwm, PWM_GET_CLK_OFFSET(pwm-&gt;hwpwm));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp |=3D PWM_CLK_APB_=
SCR;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sun50i_pwm_writel(sun=
50i_pwm, tmp, PWM_GET_CLK_OFFSET(pwm-&gt;hwpwm));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0dev_dbg(chip-&gt;dev, &quot;duty_ns=3D%d period_n=
s=3D%d c =3D%llu.\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0duty_ns, period_ns, c);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * (clk / div_m / prescaler) / entire_cycles =3D =
NSEC_PER_SEC / period_ns.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * So, entire_cycles =3D clk * period_ns / NSEC_P=
ER_SEC / div_m / prescaler.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0c =3D c * period_ns;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0do_div(c, NSEC_PER_SEC);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0for (div_m =3D 0; div_m &lt; PWM_CLK_DIV_M__MAX; =
div_m++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (prescaler =3D 0;=
 prescaler &lt; PWM_PRESCALER_MAX; prescaler++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 * actual prescaler =3D prescaler + 1.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 * actual div_m =3D 0x1 &lt;&lt; div_m.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0entire_cycles =3D ((unsigned long)c/(0x1 &lt;&lt; div_m))/(prescaler=
 + 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (entire_cycles &lt;=3D PWM_ENTIRE_CYCLE_MAX) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto calc_end;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +calc_end:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * duty_ns / period_ns =3D active_cycles / entire=
_cycles.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * So, active_cycles =3D entire_cycles * duty_ns =
/ period_ns.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0c =3D (unsigned long long)entire_cycles * duty_ns=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0do_div(c, period_ns);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0active_cycles =3D c;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (entire_cycles =3D=3D 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0entire_cycles++;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* enable clk gating */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tmp =3D sun50i_pwm_readl(sun50i_pwm, PWM_CLK_REG)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tmp |=3D BIT_CH(PWM_CLK_GATING, pwm-&gt;hwpwm);<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0sun50i_pwm_writel(sun50i_pwm, tmp, PWM_CLK_REG);<=
br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* config=C2=A0 clk div_m*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tmp =3D sun50i_pwm_readl(sun50i_pwm, PWM_GET_CLK_=
OFFSET(pwm-&gt;hwpwm));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tmp =3D SET_BITS(PWM_DIV_M, PWM_DIV_M_WIDTH, tmp,=
 div_m);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0sun50i_pwm_writel(sun50i_pwm, tmp, PWM_GET_CLK_OF=
FSET(pwm-&gt;hwpwm));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* config prescal */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tmp =3D sun50i_pwm_readl(sun50i_pwm, PWM_CTL_REG(=
pwm-&gt;hwpwm));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tmp =3D SET_BITS(PWM_PRESCAL_K, PWM_PRESCAL_K_WID=
TH, tmp, prescaler);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0sun50i_pwm_writel(sun50i_pwm, tmp, PWM_CTL_REG(pw=
m-&gt;hwpwm));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* config active and period cycles */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tmp =3D sun50i_pwm_readl(sun50i_pwm, PWM_PERIOD_R=
EG(pwm-&gt;hwpwm));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tmp =3D SET_BITS(PWM_ACT_CYCLE, PWM_ACT_CYCLE_WID=
TH, tmp, active_cycles);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tmp =3D SET_BITS(PWM_ENTIRE_CYCLE, PWM_ENTIRE_CYC=
LE_WIDTH, tmp, (entire_cycles - 1));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0sun50i_pwm_writel(sun50i_pwm, tmp, PWM_PERIOD_REG=
(pwm-&gt;hwpwm));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0dev_dbg(chip-&gt;dev, &quot;active_cycles=3D%lu e=
ntire_cycles=3D%lu prescaler=3D%u div_m=3D%u\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0active_cycles, entire_cycles, prescaler, div_m);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int sun50i_pwm_enable(struct pwm_chip *chip, struct pwm_device=
 *pwm)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct sun50i_pwm_chip *sun50i_pwm =3D sun50i_pwm=
_from_chip(chip);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 tmp;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* enable pwm controller */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tmp =3D sun50i_pwm_readl(sun50i_pwm, PWM_ENABLE_R=
EG);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tmp |=3D BIT_CH(PWM_EN, pwm-&gt;hwpwm);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0sun50i_pwm_writel(sun50i_pwm, tmp, PWM_ENABLE_REG=
);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tmp =3D sun50i_pwm_readl(sun50i_pwm, PWM_CLK_REG)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tmp |=3D BIT_CH(PWM_CLK_GATING, pwm-&gt;hwpwm);<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0sun50i_pwm_writel(sun50i_pwm, tmp, PWM_CLK_REG);<=
br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void sun50i_pwm_disable(struct pwm_chip *chip, struct pwm_devi=
ce *pwm)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct sun50i_pwm_chip *sun50i_pwm =3D sun50i_pwm=
_from_chip(chip);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 tmp;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* disable pwm controller */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tmp =3D sun50i_pwm_readl(sun50i_pwm, PWM_ENABLE_R=
EG);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tmp &amp;=3D ~BIT_CH(PWM_EN, pwm-&gt;hwpwm);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0sun50i_pwm_writel(sun50i_pwm, tmp, PWM_ENABLE_REG=
);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tmp =3D sun50i_pwm_readl(sun50i_pwm, PWM_CLK_REG)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tmp &amp;=3D ~BIT_CH(PWM_CLK_GATING, pwm-&gt;hwpw=
m);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0sun50i_pwm_writel(sun50i_pwm, tmp, PWM_CLK_REG);<=
br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct pwm_ops sun50i_pwm_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.config =3D sun50i_pwm_config,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.enable =3D sun50i_pwm_enable,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.disable =3D sun50i_pwm_disable,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.set_polarity =3D sun50i_pwm_set_polarity,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.owner =3D THIS_MODULE,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct sun50i_pwm_data sun8i_pwm_data_c9 =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.npwm =3D 9,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct sun50i_pwm_data sun50i_pwm_data_c16 =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.npwm =3D 16,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct of_device_id sun50i_pwm_dt_ids[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.compatible =3D &quot=
;allwinner,sun8i-v833-pwm&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.data =3D &amp;sun8i_=
pwm_data_c9,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}, {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.compatible =3D &quot=
;allwinner,sun8i-v536-pwm&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.data =3D &amp;sun8i_=
pwm_data_c9,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}, {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.compatible =3D &quot=
;allwinner,sun50i-r818-pwm&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.data =3D &amp;sun50i=
_pwm_data_c16,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}, {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.compatible =3D &quot=
;allwinner,sun50i-a133-pwm&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.data =3D &amp;sun50i=
_pwm_data_c16,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}, {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.compatible =3D &quot=
;allwinner,sun50i-r329-pwm&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.data =3D &amp;sun8i_=
pwm_data_c9,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}, {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* sentinel */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0},<br>
&gt; +};<br>
&gt; +MODULE_DEVICE_TABLE(of, sun50i_pwm_dt_ids);<br>
<br>
What are the differences between all these SoCs? If there&#39;s none betwee=
n<br>
the v833, v536 and R329, and between the r818 and the A133, you should<br>
use the same compatible.<br></blockquote><div><br></div><div>Compared with =
the sun4i driver, this patch is a completely different PWM IP controller.</=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
The device tree binding must be documented too<br></blockquote><div><br></d=
iv><div>DT binding docs and includes should be a separate patch, right?</di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Maxime<br>
</blockquote></div></div>

--00000000000011124c05ba7a9129--
