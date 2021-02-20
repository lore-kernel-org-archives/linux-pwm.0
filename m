Return-path: <kernel-bounces@pengutronix.de>
MIME-Version: 1.0
References: <20210203125317.1975-1-fengzheng923@gmail.com>
 <20210203151200.fdzzq23teoypbxad@pengutronix.de>
In-Reply-To: <20210203151200.fdzzq23teoypbxad@pengutronix.de>
From: =?UTF-8?B?54+t5rab?= <fengzheng923@gmail.com>
Date: Sat, 20 Feb 2021 10:18:27 +0800
Message-ID: <CAE=m618FY6_Qq1gNmkivswKjCB984WfV_Cr_Cw253ffGQmAS5Q@mail.gmail.com>
Content-Type: multipart/alternative; boundary="000000000000d05a8005bbbb2ff0"
Subject: Re: [PATCH v2] pwm: sunxi: Add Allwinner SoC PWM controller driver
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, mripard@kernel.org, wens@csie.org, thierry.reding@gmail.com, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>

--000000000000d05a8005bbbb2ff0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> =E4=BA=8E2021=E5=B9=
=B42=E6=9C=883=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8811:12=E5=86=99=
=E9=81=93=EF=BC=9A

> Hello Ban,
>
> On Wed, Feb 03, 2021 at 08:53:17PM +0800, Ban Tao wrote:
> > v1->v2:
>
> FTR: v1 wasn't sent to any list, so don't try to find it in some
> archive.
>

Sorry, I understand. So is the next patch v3? Or v2?

>
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
>
> Please add a section here about how this PWM behaves. Things to cover:
>
>  - Mention if the hardware cannot do 0% or 100%
>  - Describe if changing the settings is racy, e.g. if it can happen when
>    switching from duty_cycle=3D100 + period=3D1000 to duty_cycle=3D200 +
>    period=3D2000 that we see a period with duty_cycle=3D100 and period=3D=
2000
>    or similar
>  - Tell if on a reconfiguration the currently running period is
>    completed.
>
> Please stick to the format used in other drivers to simplify grepping,
> see the Limitations section in drivers/pwm/pwm-sl28cpld.c for an
> example.
>
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
>
> Please use a driver specific prefix for these defines.
>
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
>
> You're reinventing the stuff from <linux/bitfield.h> here. Please don't.
>
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
>
> For v1 I asked to test this driver with PWM_DEBUG enabled and to fix all
> emitted warnings. This didn't happen :-\
>
> > +static int sun50i_pwm_config(struct pwm_chip *chip, struct pwm_device
> *pwm,
> > +             int duty_ns, int period_ns)
>
> Please align to the opening brace in the line above.
>
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
>
> Inconsistent spacing in the message.
>
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
>
> The calculation could be done without this double-for loop. Something
> like:
>
>         div_m =3D order_base_2(PWM_ENTIRE_CYCLE_MAX * PWM_PRESCALER_MAX /=
 c);
>         if (div_m >=3D PWM_CLK_DIV_M__MAX)
>                 bail out;
>
>         prescaler =3D DIV_ROUND_UP(c << div_m, PWM_ENTIRE_CYCLE_MAX) - 1;
>
> (but please double check, I didn't.) Also note that this doesn't yield
> the best approximation for period in general. (But that's ok for now,
> maybe just mention it in a comment.)
>
> > +                     /*
> > +                      * actual prescaler =3D prescaler + 1.
> > +                      * actual div_m =3D 0x1 << div_m.
> > +                     */
> > +                     entire_cycles =3D ((unsigned long)c/(0x1 <<
> div_m))/(prescaler + 1);
>
> c / (1 << div_m) can be written as c >> div_m which reads better and
> might result in better code.
>
> > +                     if (entire_cycles <=3D PWM_ENTIRE_CYCLE_MAX) {
> > +                             goto calc_end;
> > +                     }
>
> No { } for one line bodys please.
>
> > +             }
> > +     }
>
> Missing error handling for the case that
>
>         c >> (PWM_CLK_DIV_M__MAX - 1) / PWM_PRESCALER_MAX >
> PWM_ENTIRE_CYCLE_MAX
>
> > +
> > +calc_end:
> > +     /*
> > +      * duty_ns / period_ns =3D active_cycles / entire_cycles.
> > +      * So, active_cycles =3D entire_cycles * duty_ns / period_ns.
>
> active_cyles is the number of clock steps for duty_cycle, right?
>
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
>
> prescale
>
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
>
> align to opening brace.
>
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
> > +
> > +static int sun50i_pwm_probe(struct platform_device *pdev)
> > +{
> > +     struct sun50i_pwm_chip *pwm;
>
> "pwm" isn't a good name, in PWM code this name is usually used for
> struct pwm_device pointers (and sometimes the global pwm id). I usually
> use "ddata" for driver data (and would have called "sun50i_pwm_chip"
> "sun50i_pwm_ddata" instead). Another common name is "priv".
>
> > +     int ret;
> > +
> > +     pwm =3D devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
> > +     if (!pwm)
> > +             return -ENOMEM;
> > +
> > +     pwm->data =3D of_device_get_match_data(&pdev->dev);
> > +     if (!pwm->data)
>
> Error message here
>
> > +             return -ENODEV;
> > +
> > +     pwm->base =3D devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(pwm->base))
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(pwm->base),
> > +                                  "can't remap pwm resource\n");
> > +
> > +     pwm->clk =3D devm_clk_get(&pdev->dev, NULL);
> > +     if (IS_ERR(pwm->clk))
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(pwm->clk),
> > +                                  "get unnamed clock failed\n");
>
> s/unnamed/PWM/ ?
>
> > +
> > +     pwm->rst_clk =3D devm_reset_control_get_exclusive(&pdev->dev, NUL=
L);
> > +     if (IS_ERR(pwm->rst_clk))
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(pwm->rst_clk),
> > +                                  "get reset failed\n");
> > +
> > +     /* Deassert reset */
> > +     ret =3D reset_control_deassert(pwm->rst_clk);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "cannot deassert reset control: %pe\n=
",
> > +                     ERR_PTR(ret));
> > +             return ret;
>
> Even though reset_control_deassert probably will never return
> -EPROBE_DEFER, you should use dev_err_probe here to for consistency.
>
> > +     }
> > +
> > +     ret =3D clk_prepare_enable(pwm->clk);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "cannot prepare and enable clk %pe\n"=
,
> > +                     ERR_PTR(ret));
> > +             goto err_clk;
> > +     }
> > +
> > +     pwm->chip.dev =3D &pdev->dev;
> > +     pwm->chip.ops =3D &sun50i_pwm_ops;
> > +     pwm->chip.npwm =3D pwm->data->npwm;
> > +     pwm->chip.of_xlate =3D of_pwm_xlate_with_flags;
> > +     pwm->chip.base =3D -1;
> > +     pwm->chip.of_pwm_n_cells =3D 3;
> > +
> > [...]
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
>

--000000000000d05a8005bbbb2ff0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Uwe Kleine-K=C3=B6nig &lt;<a href=3D"=
mailto:u.kleine-koenig@pengutronix.de">u.kleine-koenig@pengutronix.de</a>&g=
t; =E4=BA=8E2021=E5=B9=B42=E6=9C=883=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=
=E5=8D=8811:12=E5=86=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">Hello Ban,<br>
<br>
On Wed, Feb 03, 2021 at 08:53:17PM +0800, Ban Tao wrote:<br>
&gt; v1-&gt;v2:<br>
<br>
FTR: v1 wasn&#39;t sent to any list, so don&#39;t try to find it in some<br=
>
archive.<br></blockquote><div><br></div><div>Sorry, I understand. So is the=
 next patch v3? Or v2?</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
<br>
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
<br>
Please add a section here about how this PWM behaves. Things to cover:<br>
<br>
=C2=A0- Mention if the hardware cannot do 0% or 100%<br>
=C2=A0- Describe if changing the settings is racy, e.g. if it can happen wh=
en<br>
=C2=A0 =C2=A0switching from duty_cycle=3D100 + period=3D1000 to duty_cycle=
=3D200 +<br>
=C2=A0 =C2=A0period=3D2000 that we see a period with duty_cycle=3D100 and p=
eriod=3D2000<br>
=C2=A0 =C2=A0or similar<br>
=C2=A0- Tell if on a reconfiguration the currently running period is<br>
=C2=A0 =C2=A0completed.<br>
<br>
Please stick to the format used in other drivers to simplify grepping,<br>
see the Limitations section in drivers/pwm/pwm-sl28cpld.c for an<br>
example.<br>
<br>
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
<br>
Please use a driver specific prefix for these defines.<br>
<br>
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
<br>
You&#39;re reinventing the stuff from &lt;linux/bitfield.h&gt; here. Please=
 don&#39;t.<br>
<br>
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
<br>
For v1 I asked to test this driver with PWM_DEBUG enabled and to fix all<br=
>
emitted warnings. This didn&#39;t happen :-\<br>
<br>
&gt; +static int sun50i_pwm_config(struct pwm_chip *chip, struct pwm_device=
 *pwm,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int duty_ns, int peri=
od_ns)<br>
<br>
Please align to the opening brace in the line above.<br>
<br>
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
<br>
Inconsistent spacing in the message.<br>
<br>
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
<br>
The calculation could be done without this double-for loop. Something<br>
like:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 div_m =3D order_base_2(PWM_ENTIRE_CYCLE_MAX * P=
WM_PRESCALER_MAX / c);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (div_m &gt;=3D PWM_CLK_DIV_M__MAX)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bail out;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 prescaler =3D DIV_ROUND_UP(c &lt;&lt; div_m, PW=
M_ENTIRE_CYCLE_MAX) - 1;<br>
<br>
(but please double check, I didn&#39;t.) Also note that this doesn&#39;t yi=
eld<br>
the best approximation for period in general. (But that&#39;s ok for now,<b=
r>
maybe just mention it in a comment.)<br>
<br>
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
<br>
c / (1 &lt;&lt; div_m) can be written as c &gt;&gt; div_m which reads bette=
r and<br>
might result in better code.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (entire_cycles &lt;=3D PWM_ENTIRE_CYCLE_MAX) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto calc_end;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
<br>
No { } for one line bodys please.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
<br>
Missing error handling for the case that<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 c &gt;&gt; (PWM_CLK_DIV_M__MAX - 1) / PWM_PRESC=
ALER_MAX &gt; PWM_ENTIRE_CYCLE_MAX<br>
<br>
&gt; +<br>
&gt; +calc_end:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * duty_ns / period_ns =3D active_cycles / entire=
_cycles.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * So, active_cycles =3D entire_cycles * duty_ns =
/ period_ns.<br>
<br>
active_cyles is the number of clock steps for duty_cycle, right?<br>
<br>
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
<br>
prescale<br>
<br>
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
<br>
align to opening brace.<br>
<br>
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
&gt; +<br>
&gt; +static int sun50i_pwm_probe(struct platform_device *pdev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct sun50i_pwm_chip *pwm;<br>
<br>
&quot;pwm&quot; isn&#39;t a good name, in PWM code this name is usually use=
d for<br>
struct pwm_device pointers (and sometimes the global pwm id). I usually<br>
use &quot;ddata&quot; for driver data (and would have called &quot;sun50i_p=
wm_chip&quot;<br>
&quot;sun50i_pwm_ddata&quot; instead). Another common name is &quot;priv&qu=
ot;.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pwm =3D devm_kzalloc(&amp;pdev-&gt;dev, sizeof(*p=
wm), GFP_KERNEL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!pwm)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pwm-&gt;data =3D of_device_get_match_data(&amp;pd=
ev-&gt;dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!pwm-&gt;data)<br>
<br>
Error message here<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pwm-&gt;base =3D devm_platform_ioremap_resource(p=
dev, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (IS_ERR(pwm-&gt;base))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return dev_err_probe(=
&amp;pdev-&gt;dev, PTR_ERR(pwm-&gt;base),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;can&#39;t remap pwm=
 resource\n&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pwm-&gt;clk =3D devm_clk_get(&amp;pdev-&gt;dev, N=
ULL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (IS_ERR(pwm-&gt;clk))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return dev_err_probe(=
&amp;pdev-&gt;dev, PTR_ERR(pwm-&gt;clk),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;get unnamed clock f=
ailed\n&quot;);<br>
<br>
s/unnamed/PWM/ ?<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pwm-&gt;rst_clk =3D devm_reset_control_get_exclus=
ive(&amp;pdev-&gt;dev, NULL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (IS_ERR(pwm-&gt;rst_clk))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return dev_err_probe(=
&amp;pdev-&gt;dev, PTR_ERR(pwm-&gt;rst_clk),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;get reset failed\n&=
quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Deassert reset */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D reset_control_deassert(pwm-&gt;rst_clk);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;pdev-&gt=
;dev, &quot;cannot deassert reset control: %pe\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ERR_PTR(ret));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
<br>
Even though reset_control_deassert probably will never return<br>
-EPROBE_DEFER, you should use dev_err_probe here to for consistency.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D clk_prepare_enable(pwm-&gt;clk);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;pdev-&gt=
;dev, &quot;cannot prepare and enable clk %pe\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ERR_PTR(ret));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_clk;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pwm-&gt;<a href=3D"http://chip.dev" rel=3D"norefe=
rrer" target=3D"_blank">chip.dev</a> =3D &amp;pdev-&gt;dev;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pwm-&gt;chip.ops =3D &amp;sun50i_pwm_ops;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pwm-&gt;chip.npwm =3D pwm-&gt;data-&gt;npwm;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pwm-&gt;chip.of_xlate =3D of_pwm_xlate_with_flags=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pwm-&gt;chip.base =3D -1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pwm-&gt;chip.of_pwm_n_cells =3D 3;<br>
&gt; +<br>
&gt; [...]<br>
<br>
Best regards<br>
Uwe<br>
<br>
-- <br>
Pengutronix e.K.=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| Uwe Kleine-K=C3=B6nig=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>
Industrial Linux Solutions=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| <a href=3D"https://www.pengutronix.de/" rel=3D"noreferrer" t=
arget=3D"_blank">https://www.pengutronix.de/</a> |<br>
</blockquote></div></div>

--000000000000d05a8005bbbb2ff0--
