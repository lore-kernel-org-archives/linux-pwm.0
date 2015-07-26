Return-Path: <ezequiel@vanguardiasur.com.ar>
MIME-Version: 1.0
In-Reply-To: <1437860378-9556-2-git-send-email-antoine.tenart@free-electrons.com>
References: <1437860378-9556-1-git-send-email-antoine.tenart@free-electrons.com>
	<1437860378-9556-2-git-send-email-antoine.tenart@free-electrons.com>
Date: Sun, 26 Jul 2015 19:56:55 -0300
Message-ID: <CAAEAJfA9ZH7xcKLY-qVvEbOeozxg_Vb9MjgoMBk3ceZCr00ciw@mail.gmail.com>
Subject: Re: [PATCH 1/5] pwm: add the Berlin pwm controller driver
From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Content-Type: multipart/alternative; boundary=f46d04428e245e0f0a051bcf27ce
List-ID: <linux-pwm.vger.kernel.org>
To: Antoine Tenart <antoine.tenart@free-electrons.com>
Cc: zmxu@marvell.com, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, jszhang@marvell.com, thierry.reding@gmail.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org

--f46d04428e245e0f0a051bcf27ce
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

El jul. 25, 2015 6:40 PM, "Antoine Tenart" <
antoine.tenart@free-electrons.com> escribi=C3=B3:
>
> Add a PWM controller driver for the Marvell Berlin SoCs. This PWM
> controller has 4 channels.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
>  drivers/pwm/Kconfig      |   9 +++
>  drivers/pwm/Makefile     |   1 +
>  drivers/pwm/pwm-berlin.c | 206
+++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 216 insertions(+)
>  create mode 100644 drivers/pwm/pwm-berlin.c
>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index b1541f40fd8d..1773da8145b8 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -92,6 +92,15 @@ config PWM_BCM2835
>           To compile this driver as a module, choose M here: the module
>           will be called pwm-bcm2835.
>
> +config PWM_BERLIN
> +       tristate "Berlin PWM support"
> +       depends on ARCH_BERLIN
> +       help
> +         PWM framework driver for Berlin.
> +
> +         To compile this driver as a module, choose M here: the module
> +         will be called pwm-berlin.
> +
>  config PWM_BFIN
>         tristate "Blackfin PWM support"
>         depends on BFIN_GPTIMERS
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index ec50eb5b5a8f..670c5fce8bbb 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -6,6 +6,7 @@ obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)       +=3D
pwm-atmel-hlcdc.o
>  obj-$(CONFIG_PWM_ATMEL_TCB)    +=3D pwm-atmel-tcb.o
>  obj-$(CONFIG_PWM_BCM_KONA)     +=3D pwm-bcm-kona.o
>  obj-$(CONFIG_PWM_BCM2835)      +=3D pwm-bcm2835.o
> +obj-$(CONFIG_PWM_BERLIN)       +=3D pwm-berlin.o
>  obj-$(CONFIG_PWM_BFIN)         +=3D pwm-bfin.o
>  obj-$(CONFIG_PWM_CLPS711X)     +=3D pwm-clps711x.o
>  obj-$(CONFIG_PWM_EP93XX)       +=3D pwm-ep93xx.o
> diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
> new file mode 100644
> index 000000000000..b124188aaef4
> --- /dev/null
> +++ b/drivers/pwm/pwm-berlin.c
> @@ -0,0 +1,206 @@
> +/*
> + * Marvell Berlin PWM driver
> + *
> + * Copyright (C) 2015 Marvell Technology Group Ltd.
> + *
> + * Antoine Tenart <antoine.tenart@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/spinlock.h>
> +
> +#define BERLIN_PWM_EN                  0x0
> +#define BERLIN_PWM_CONTROL             0x4
> +#define BERLIN_PWM_DUTY                        0x8
> +#define BERLIN_PWM_TCNT                        0xc
> +
> +#define BERLIN_PWM_CLK_RATE            100000000
> +#define BERLIN_PWM_PRESCALE_MASK       0x7
> +#define BERLIN_PWM_PRESCALE_MAX                4096
> +
> +struct berlin_pwm_chip {
> +       struct pwm_chip chip;
> +       void __iomem *base;
> +       spinlock_t lock;
> +};
> +
> +#define to_berlin_pwm_chip(chip)       \
> +       container_of((chip), struct berlin_pwm_chip, chip)
> +
> +#define berlin_pwm_readl(chip, channel, offset)                \
> +       readl((chip)->base + (channel) * 0x10 + offset)
> +#define berlin_pwm_writel(val, chip, channel, offset)  \
> +       writel(val, (chip)->base + (channel) * 0x10 + offset)
> +
> +static const u32 prescaler_table[] =3D {
> +       1,
> +       4,
> +       8,
> +       16,
> +       64,
> +       256,
> +       1024,
> +       4096,
> +};
> +
> +static int berlin_pwm_config(struct pwm_chip *chip, struct pwm_device
*pwm,
> +                            int duty_ns, int period_ns)
> +{
> +       struct berlin_pwm_chip *berlin_chip =3D to_berlin_pwm_chip(chip);
> +       int prescale;
> +       u32 val, duty, period;
> +       u64 tmp;
> +
> +       for (prescale =3D 0; prescale < ARRAY_SIZE(prescaler_table);
prescale++) {
> +               tmp =3D BERLIN_PWM_CLK_RATE;
> +               do_div(tmp, prescaler_table[prescale]);
> +               tmp *=3D period_ns;
> +               do_div(tmp, NSEC_PER_SEC);
> +
> +               if (tmp - 1 <=3D BERLIN_PWM_PRESCALE_MAX)
> +                       break;
> +       }
> +
> +       if (tmp - 1 > BERLIN_PWM_PRESCALE_MAX)
> +               return -EINVAL;
> +
> +       period =3D tmp;
> +       tmp *=3D duty_ns;
> +       do_div(tmp, period_ns);
> +       duty =3D tmp;
> +
> +       spin_lock(&berlin_chip->lock);
> +
> +       val =3D berlin_pwm_readl(berlin_chip, pwm->hwpwm,
BERLIN_PWM_CONTROL);
> +       val &=3D ~BERLIN_PWM_PRESCALE_MASK;
> +       val |=3D prescale;
> +       berlin_pwm_writel(val, berlin_chip, pwm->hwpwm,
BERLIN_PWM_CONTROL);
> +
> +       berlin_pwm_writel(duty, berlin_chip, pwm->hwpwm, BERLIN_PWM_DUTY)=
;
> +       berlin_pwm_writel(period, berlin_chip, pwm->hwpwm,
BERLIN_PWM_TCNT);
> +
> +       spin_unlock(&berlin_chip->lock);
> +
> +       return 0;
> +}
> +
> +static int berlin_pwm_set_polarity(struct pwm_chip *chip,
> +                                  struct pwm_device *pwm,
> +                                  enum pwm_polarity polarity)
> +{
> +       struct berlin_pwm_chip *berlin_chip =3D to_berlin_pwm_chip(chip);
> +       u32 val;
> +
> +       spin_lock(&berlin_chip->lock);
> +
> +       val =3D berlin_pwm_readl(berlin_chip, pwm->hwpwm,
BERLIN_PWM_CONTROL);
> +
> +       if (polarity =3D=3D PWM_POLARITY_NORMAL)
> +               val &=3D ~BIT(3);
> +       else
> +               val |=3D BIT(3);
> +
> +       berlin_pwm_writel(val, berlin_chip, pwm->hwpwm,
BERLIN_PWM_CONTROL);
> +
> +       spin_unlock(&berlin_chip->lock);
> +
> +       return 0;
> +}
> +
> +static int berlin_pwm_enable(struct pwm_chip *chip, struct pwm_device
*pwm)
> +{
> +       struct berlin_pwm_chip *berlin_chip =3D to_berlin_pwm_chip(chip);
> +
> +       spin_lock(&berlin_chip->lock);
> +       berlin_pwm_writel(0x1, berlin_chip, pwm->hwpwm, BERLIN_PWM_EN);
> +       spin_unlock(&berlin_chip->lock);
> +
> +       return 0;
> +}
> +
> +static void berlin_pwm_disable(struct pwm_chip *chip, struct pwm_device
*pwm)
> +{
> +       struct berlin_pwm_chip *berlin_chip =3D to_berlin_pwm_chip(chip);
> +
> +       spin_lock(&berlin_chip->lock);
> +       berlin_pwm_writel(0x0, berlin_chip, pwm->hwpwm, BERLIN_PWM_EN);
> +       spin_unlock(&berlin_chip->lock);
> +}
> +
> +static const struct pwm_ops berlin_pwm_ops =3D {
> +       .config =3D berlin_pwm_config,
> +       .set_polarity =3D berlin_pwm_set_polarity,
> +       .enable =3D berlin_pwm_enable,
> +       .disable =3D berlin_pwm_disable,
> +       .owner =3D THIS_MODULE,
> +};
> +
> +static const struct of_device_id berlin_pwm_match[] =3D {
> +       { .compatible =3D "marvell,berlin-pwm" },

Don't we need a sentinel here?

> +};
> +MODULE_DEVICE_TABLE(of, berlin_pwm_match);
> +
> +static int berlin_pwm_probe(struct platform_device *pdev)
> +{
> +       struct berlin_pwm_chip *pwm;
> +       struct resource *res;
> +       int ret;
> +
> +       pwm =3D devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
> +       if (!pwm)
> +               return -ENOMEM;
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       pwm->base =3D devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(pwm->base))
> +               return PTR_ERR(pwm->base);
> +
> +       pwm->chip.dev =3D &pdev->dev;
> +       pwm->chip.ops =3D &berlin_pwm_ops;
> +       pwm->chip.base =3D -1;
> +       pwm->chip.npwm =3D 4;
> +       pwm->chip.can_sleep =3D true;
> +       pwm->chip.of_xlate =3D of_pwm_xlate_with_flags;
> +       pwm->chip.of_pwm_n_cells =3D 3;
> +
> +       spin_lock_init(&pwm->lock);
> +
> +       ret =3D pwmchip_add(&pwm->chip);
> +       if (ret < 0) {
> +               dev_err(&pdev->dev, "Failed to add PWM chip: %d\n", ret);
> +               return ret;
> +       }
> +
> +       platform_set_drvdata(pdev, pwm);
> +
> +       return 0;
> +}
> +
> +static int berlin_pwm_remove(struct platform_device *pdev)
> +{
> +       struct berlin_pwm_chip *pwm =3D platform_get_drvdata(pdev);
> +
> +       return pwmchip_remove(&pwm->chip);
> +}
> +
> +static struct platform_driver berlin_pwm_driver =3D {
> +       .probe  =3D berlin_pwm_probe,
> +       .remove =3D berlin_pwm_remove,
> +       .driver =3D {
> +               .name   =3D "berlin-pwm",
> +               .of_match_table =3D berlin_pwm_match,
> +       },
> +};
> +module_platform_driver(berlin_pwm_driver);
> +
> +MODULE_AUTHOR("Antoine Tenart <antoine.tenart@free-electrons.com>");
> +MODULE_DESCRIPTION("Marvell Berlin PWM driver");
> +MODULE_LICENSE("GPL v2");
> --
> 2.4.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pwm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--f46d04428e245e0f0a051bcf27ce
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
El jul. 25, 2015 6:40 PM, &quot;Antoine Tenart&quot; &lt;<a href=3D"mailto:=
antoine.tenart@free-electrons.com">antoine.tenart@free-electrons.com</a>&gt=
; escribi=C3=B3:<br>
&gt;<br>
&gt; Add a PWM controller driver for the Marvell Berlin SoCs. This PWM<br>
&gt; controller has 4 channels.<br>
&gt;<br>
&gt; Signed-off-by: Antoine Tenart &lt;<a href=3D"mailto:antoine.tenart@fre=
e-electrons.com">antoine.tenart@free-electrons.com</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0drivers/pwm/Kconfig=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A09 +++<br>
&gt; =C2=A0drivers/pwm/Makefile=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt; =C2=A0drivers/pwm/pwm-berlin.c | 206 +++++++++++++++++++++++++++++++++=
++++++++++++++<br>
&gt; =C2=A03 files changed, 216 insertions(+)<br>
&gt; =C2=A0create mode 100644 drivers/pwm/pwm-berlin.c<br>
&gt;<br>
&gt; diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig<br>
&gt; index b1541f40fd8d..1773da8145b8 100644<br>
&gt; --- a/drivers/pwm/Kconfig<br>
&gt; +++ b/drivers/pwm/Kconfig<br>
&gt; @@ -92,6 +92,15 @@ config PWM_BCM2835<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 To compile this driver as a module,=
 choose M here: the module<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 will be called pwm-bcm2835.<br>
&gt;<br>
&gt; +config PWM_BERLIN<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0tristate &quot;Berlin PWM support&quot;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0depends on ARCH_BERLIN<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0help<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PWM framework driver for Berlin.<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0To compile this driver as a module,=
 choose M here: the module<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0will be called pwm-berlin.<br>
&gt; +<br>
&gt; =C2=A0config PWM_BFIN<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 tristate &quot;Blackfin PWM support&quot;<=
br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 depends on BFIN_GPTIMERS<br>
&gt; diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile<br>
&gt; index ec50eb5b5a8f..670c5fce8bbb 100644<br>
&gt; --- a/drivers/pwm/Makefile<br>
&gt; +++ b/drivers/pwm/Makefile<br>
&gt; @@ -6,6 +6,7 @@ obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)=C2=A0 =C2=A0 =C2=A0 =
=C2=A0+=3D pwm-atmel-hlcdc.o<br>
&gt; =C2=A0obj-$(CONFIG_PWM_ATMEL_TCB)=C2=A0 =C2=A0 +=3D pwm-atmel-tcb.o<br=
>
&gt; =C2=A0obj-$(CONFIG_PWM_BCM_KONA)=C2=A0 =C2=A0 =C2=A0+=3D pwm-bcm-kona.=
o<br>
&gt; =C2=A0obj-$(CONFIG_PWM_BCM2835)=C2=A0 =C2=A0 =C2=A0 +=3D pwm-bcm2835.o=
<br>
&gt; +obj-$(CONFIG_PWM_BERLIN)=C2=A0 =C2=A0 =C2=A0 =C2=A0+=3D pwm-berlin.o<=
br>
&gt; =C2=A0obj-$(CONFIG_PWM_BFIN)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=3D pwm=
-bfin.o<br>
&gt; =C2=A0obj-$(CONFIG_PWM_CLPS711X)=C2=A0 =C2=A0 =C2=A0+=3D pwm-clps711x.=
o<br>
&gt; =C2=A0obj-$(CONFIG_PWM_EP93XX)=C2=A0 =C2=A0 =C2=A0 =C2=A0+=3D pwm-ep93=
xx.o<br>
&gt; diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c<br>
&gt; new file mode 100644<br>
&gt; index 000000000000..b124188aaef4<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/pwm/pwm-berlin.c<br>
&gt; @@ -0,0 +1,206 @@<br>
&gt; +/*<br>
&gt; + * Marvell Berlin PWM driver<br>
&gt; + *<br>
&gt; + * Copyright (C) 2015 Marvell Technology Group Ltd.<br>
&gt; + *<br>
&gt; + * Antoine Tenart &lt;<a href=3D"mailto:antoine.tenart@free-electrons=
.com">antoine.tenart@free-electrons.com</a>&gt;<br>
&gt; + *<br>
&gt; + * This file is licensed under the terms of the GNU General Public<br=
>
&gt; + * License version 2. This program is licensed &quot;as is&quot; with=
out any<br>
&gt; + * warranty of any kind, whether express or implied.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &lt;linux/io.h&gt;<br>
&gt; +#include &lt;linux/kernel.h&gt;<br>
&gt; +#include &lt;linux/module.h&gt;<br>
&gt; +#include &lt;linux/platform_device.h&gt;<br>
&gt; +#include &lt;linux/pwm.h&gt;<br>
&gt; +#include &lt;linux/spinlock.h&gt;<br>
&gt; +<br>
&gt; +#define BERLIN_PWM_EN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 0x0<br>
&gt; +#define BERLIN_PWM_CONTROL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00x4<br>
&gt; +#define BERLIN_PWM_DUTY=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x8<br>
&gt; +#define BERLIN_PWM_TCNT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0xc<br>
&gt; +<br>
&gt; +#define BERLIN_PWM_CLK_RATE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
100000000<br>
&gt; +#define BERLIN_PWM_PRESCALE_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A00x7<br>
&gt; +#define BERLIN_PWM_PRESCALE_MAX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 4096<br>
&gt; +<br>
&gt; +struct berlin_pwm_chip {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct pwm_chip chip;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0void __iomem *base;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0spinlock_t lock;<br>
&gt; +};<br>
&gt; +<br>
&gt; +#define to_berlin_pwm_chip(chip)=C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0container_of((chip), struct berlin_pwm_chi=
p, chip)<br>
&gt; +<br>
&gt; +#define berlin_pwm_readl(chip, channel, offset)=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0readl((chip)-&gt;base + (channel) * 0x10 +=
 offset)<br>
&gt; +#define berlin_pwm_writel(val, chip, channel, offset)=C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0writel(val, (chip)-&gt;base + (channel) * =
0x10 + offset)<br>
&gt; +<br>
&gt; +static const u32 prescaler_table[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A01,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A04,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A08,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A016,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A064,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0256,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A01024,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A04096,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static int berlin_pwm_config(struct pwm_chip *chip, struct pwm_device=
 *pwm,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int duty_ns, int period_ns)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct berlin_pwm_chip *berlin_chip =3D to=
_berlin_pwm_chip(chip);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int prescale;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 val, duty, period;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0u64 tmp;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0for (prescale =3D 0; prescale &lt; ARRAY_S=
IZE(prescaler_table); prescale++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D BERLIN=
_PWM_CLK_RATE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do_div(tmp, pr=
escaler_table[prescale]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp *=3D perio=
d_ns;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do_div(tmp, NS=
EC_PER_SEC);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (tmp - 1 &l=
t;=3D BERLIN_PWM_PRESCALE_MAX)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (tmp - 1 &gt; BERLIN_PWM_PRESCALE_MAX)<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0period =3D tmp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp *=3D duty_ns;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0do_div(tmp, period_ns);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0duty =3D tmp;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock(&amp;berlin_chip-&gt;lock);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D berlin_pwm_readl(berlin_chip, pwm-=
&gt;hwpwm, BERLIN_PWM_CONTROL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0val &amp;=3D ~BERLIN_PWM_PRESCALE_MASK;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0val |=3D prescale;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0berlin_pwm_writel(val, berlin_chip, pwm-&g=
t;hwpwm, BERLIN_PWM_CONTROL);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0berlin_pwm_writel(duty, berlin_chip, pwm-&=
gt;hwpwm, BERLIN_PWM_DUTY);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0berlin_pwm_writel(period, berlin_chip, pwm=
-&gt;hwpwm, BERLIN_PWM_TCNT);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock(&amp;berlin_chip-&gt;lock);<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int berlin_pwm_set_polarity(struct pwm_chip *chip,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct pwm_device *pwm,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum pwm_polarity polarit=
y)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct berlin_pwm_chip *berlin_chip =3D to=
_berlin_pwm_chip(chip);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 val;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock(&amp;berlin_chip-&gt;lock);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D berlin_pwm_readl(berlin_chip, pwm-=
&gt;hwpwm, BERLIN_PWM_CONTROL);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (polarity =3D=3D PWM_POLARITY_NORMAL)<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val &amp;=3D ~=
BIT(3);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val |=3D BIT(3=
);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0berlin_pwm_writel(val, berlin_chip, pwm-&g=
t;hwpwm, BERLIN_PWM_CONTROL);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock(&amp;berlin_chip-&gt;lock);<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int berlin_pwm_enable(struct pwm_chip *chip, struct pwm_device=
 *pwm)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct berlin_pwm_chip *berlin_chip =3D to=
_berlin_pwm_chip(chip);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock(&amp;berlin_chip-&gt;lock);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0berlin_pwm_writel(0x1, berlin_chip, pwm-&g=
t;hwpwm, BERLIN_PWM_EN);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock(&amp;berlin_chip-&gt;lock);<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void berlin_pwm_disable(struct pwm_chip *chip, struct pwm_devi=
ce *pwm)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct berlin_pwm_chip *berlin_chip =3D to=
_berlin_pwm_chip(chip);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock(&amp;berlin_chip-&gt;lock);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0berlin_pwm_writel(0x0, berlin_chip, pwm-&g=
t;hwpwm, BERLIN_PWM_EN);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock(&amp;berlin_chip-&gt;lock);<br=
>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct pwm_ops berlin_pwm_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0.config =3D berlin_pwm_config,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0.set_polarity =3D berlin_pwm_set_polarity,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0.enable =3D berlin_pwm_enable,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0.disable =3D berlin_pwm_disable,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0.owner =3D THIS_MODULE,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct of_device_id berlin_pwm_match[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0{ .compatible =3D &quot;marvell,berlin-pwm=
&quot; },</p>
<p dir=3D"ltr">Don&#39;t we need a sentinel here?</p>
<p dir=3D"ltr">&gt; +};<br>
&gt; +MODULE_DEVICE_TABLE(of, berlin_pwm_match);<br>
&gt; +<br>
&gt; +static int berlin_pwm_probe(struct platform_device *pdev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct berlin_pwm_chip *pwm;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct resource *res;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0pwm =3D devm_kzalloc(&amp;pdev-&gt;dev, si=
zeof(*pwm), GFP_KERNEL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!pwm)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0res =3D platform_get_resource(pdev, IORESO=
URCE_MEM, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0pwm-&gt;base =3D devm_ioremap_resource(&am=
p;pdev-&gt;dev, res);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(pwm-&gt;base))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR=
(pwm-&gt;base);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0pwm-&gt;chip.dev =3D &amp;pdev-&gt;dev;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0pwm-&gt;chip.ops =3D &amp;berlin_pwm_ops;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0pwm-&gt;chip.base =3D -1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0pwm-&gt;chip.npwm =3D 4;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0pwm-&gt;chip.can_sleep =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0pwm-&gt;chip.of_xlate =3D of_pwm_xlate_wit=
h_flags;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0pwm-&gt;chip.of_pwm_n_cells =3D 3;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_init(&amp;pwm-&gt;lock);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D pwmchip_add(&amp;pwm-&gt;chip);<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;p=
dev-&gt;dev, &quot;Failed to add PWM chip: %d\n&quot;, ret);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0platform_set_drvdata(pdev, pwm);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int berlin_pwm_remove(struct platform_device *pdev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct berlin_pwm_chip *pwm =3D platform_g=
et_drvdata(pdev);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return pwmchip_remove(&amp;pwm-&gt;chip);<=
br>
&gt; +}<br>
&gt; +<br>
&gt; +static struct platform_driver berlin_pwm_driver =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0.probe=C2=A0 =3D berlin_pwm_probe,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0.remove =3D berlin_pwm_remove,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0.driver =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name=C2=A0 =
=C2=A0=3D &quot;berlin-pwm&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.of_match_tabl=
e =3D berlin_pwm_match,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
&gt; +};<br>
&gt; +module_platform_driver(berlin_pwm_driver);<br>
&gt; +<br>
&gt; +MODULE_AUTHOR(&quot;Antoine Tenart &lt;<a href=3D"mailto:antoine.tena=
rt@free-electrons.com">antoine.tenart@free-electrons.com</a>&gt;&quot;);<br=
>
&gt; +MODULE_DESCRIPTION(&quot;Marvell Berlin PWM driver&quot;);<br>
&gt; +MODULE_LICENSE(&quot;GPL v2&quot;);<br>
&gt; --<br>
&gt; 2.4.6<br>
&gt;<br>
&gt; --<br>
&gt; To unsubscribe from this list: send the line &quot;unsubscribe linux-p=
wm&quot; in<br>
&gt; the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">=
majordomo@vger.kernel.org</a><br>
&gt; More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordo=
mo-info.html">http://vger.kernel.org/majordomo-info.html</a><br>
</p>

--f46d04428e245e0f0a051bcf27ce--
