Return-path: <kernel-bounces@pengutronix.de>
MIME-Version: 1.0
In-Reply-To: <20200905133230.1014581-6-j.neuschaefer@gmx.net>
References: <20200905133230.1014581-1-j.neuschaefer@gmx.net>
 <20200905133230.1014581-6-j.neuschaefer@gmx.net>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 5 Sep 2020 21:08:49 +0300
Message-ID: <CAHp75VdUHoOyM3bObzhdfiqpne0AmSK_UakteTZxnjqJVrNV9A@mail.gmail.com>
Content-Type: multipart/alternative; boundary="00000000000092af1905ae94e0d8"
Subject: Re: [PATCH v2 05/10] pwm: ntxec: Add driver for PWM function in
 Netronix EC
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Heiko Stuebner <heiko@sntech.de>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Fabio Estevam <festevam@gmail.com>, "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Sam Ravnborg <sam@ravnborg.org>, Daniel Palmer <daniel@0x0f.com>, Andreas Kemnade <andreas@kemnade.info>, NXP Linux Team <linux-imx@nxp.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Stephan Gerhold <stephan@gerhold.net>, allen <allen.chen@ite.com.tw>, Sascha Hauer <s.hauer@pengutronix.de>, Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Alessandro Zummo <a.zummo@towertech.it>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, Heiko Stuebner <heiko.stuebner@theobroma-systems.com>, Josua Mayer <josua.mayer@jm0.eu>, Shawn Guo <shawnguo@kernel.org>, "David S. Miller" <davem@davemloft.net>
List-ID: <linux-pwm.vger.kernel.org>

--00000000000092af1905ae94e0d8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Saturday, September 5, 2020, Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx=
.net>
wrote:

> The Netronix EC provides a PWM output which is used for the backlight
> on some ebook readers. This patches adds a driver for the PWM output.
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---
>
> v2:
> - Various grammar and style improvements, as suggested by Uwe Kleine-K=C3=
=B6nig,
>   Lee Jones, and Alexandre Belloni
> - Switch to regmap
> - Prefix registers with NTXEC_REG_
> - Add help text to the Kconfig option
> - Use the .apply callback instead of the old API
> - Add a #define for the time base (125ns)
> - Don't change device state in .probe; this avoids multiple problems
> - Rework division and overflow check logic to perform divisions in 32 bit=
s
> - Avoid setting duty cycle to zero, to work around a hardware quirk
> ---
>  drivers/pwm/Kconfig     |   8 ++
>  drivers/pwm/Makefile    |   1 +
>  drivers/pwm/pwm-ntxec.c | 160 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 169 insertions(+)
>  create mode 100644 drivers/pwm/pwm-ntxec.c
>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 7dbcf6973d335..7fd17c6cda95e 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -350,6 +350,14 @@ config PWM_MXS
>           To compile this driver as a module, choose M here: the module
>           will be called pwm-mxs.
>
> +config PWM_NTXEC
> +       tristate "Netronix embedded controller PWM support"




> +       depends on MFD_NTXEC && OF


I don=E2=80=99t see need to reduce test coverage and use of the driver by s=
ticking
with OF. Actually it=E2=80=99s not used.


> +       help
> +         Say yes here if you want to support the PWM output of the
> embedded
> +         controller found in certain e-book readers designed by the ODM
> +         Netronix.
> +
>  config PWM_OMAP_DMTIMER
>         tristate "OMAP Dual-Mode Timer PWM support"
>         depends on OF
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 2c2ba0a035577..1cc50dba22d1b 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -32,6 +32,7 @@ obj-$(CONFIG_PWM_MESON)               +=3D pwm-meson.o
>  obj-$(CONFIG_PWM_MEDIATEK)     +=3D pwm-mediatek.o
>  obj-$(CONFIG_PWM_MTK_DISP)     +=3D pwm-mtk-disp.o
>  obj-$(CONFIG_PWM_MXS)          +=3D pwm-mxs.o
> +obj-$(CONFIG_PWM_NTXEC)                +=3D pwm-ntxec.o
>  obj-$(CONFIG_PWM_OMAP_DMTIMER) +=3D pwm-omap-dmtimer.o
>  obj-$(CONFIG_PWM_PCA9685)      +=3D pwm-pca9685.o
>  obj-$(CONFIG_PWM_PXA)          +=3D pwm-pxa.o
> diff --git a/drivers/pwm/pwm-ntxec.c b/drivers/pwm/pwm-ntxec.c
> new file mode 100644
> index 0000000000000..325ec0e8f1996
> --- /dev/null
> +++ b/drivers/pwm/pwm-ntxec.c
> @@ -0,0 +1,160 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * The Netronix embedded controller is a microcontroller found in some
> + * e-book readers designed by the ODM Netronix, Inc. It contains RTC,
> + * battery monitoring, system power management, and PWM functionality.
> + *
> + * This driver implements PWM output.
> + *
> + * Copyright 2020 Jonathan Neusch=C3=A4fer
> + */
> +
> +#include <linux/mfd/ntxec.h>
> +#include <linux/module.h>




> +#include <linux/of_device.h>


mod_devicetable.h


> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>
> +
> +struct ntxec_pwm {
> +       struct device *dev;
> +       struct ntxec *ec;
> +       struct pwm_chip chip;
> +};
> +
> +static struct ntxec_pwm *pwmchip_to_pwm(struct pwm_chip *chip)
> +{
> +       return container_of(chip, struct ntxec_pwm, chip);
> +}
> +
> +#define NTXEC_REG_AUTO_OFF_HI  0xa1
> +#define NTXEC_REG_AUTO_OFF_LO  0xa2
> +#define NTXEC_REG_ENABLE       0xa3
> +#define NTXEC_REG_PERIOD_LOW   0xa4
> +#define NTXEC_REG_PERIOD_HIGH  0xa5
> +#define NTXEC_REG_DUTY_LOW     0xa6
> +#define NTXEC_REG_DUTY_HIGH    0xa7
> +
> +/* Convert an 8-bit value into the correct format for writing into a
> register */
> +#define u8_to_reg(x) (((x) & 0xff) << 8)


You spread this macro among the drivers w/o explanation what=E2=80=99s goin=
g on. I
think there will be better approach.


> +
> +/*
> + * The time base used in the EC is 8MHz, or 125ns. Period and duty cycle
> are
> + * measured in this unit.
> + */
> +#define TIME_BASE_NS 125
> +
> +/*
> + * The maximum input value (in nanoseconds) is determined by the time
> base and
> + * the range of the hardware registers that hold the converted value.
> + * It fits into 32 bits, so we can do our calculations in 32 bits as wel=
l.
> + */
> +#define MAX_PERIOD_NS (TIME_BASE_NS * 0x10000 - 1)
> +
> +static int ntxec_pwm_apply(struct pwm_chip *chip, struct pwm_device
> *pwm_dev,
> +                          const struct pwm_state *state)
> +{
> +       struct ntxec_pwm *pwm =3D pwmchip_to_pwm(pwm_dev->chip);
> +       unsigned int duty =3D state->duty_cycle;
> +       unsigned int period =3D state->period;
> +       int res =3D 0;
> +
> +       if (period > MAX_PERIOD_NS) {
> +               dev_warn(pwm->dev,
> +                        "Period is not representable in 16 bits after
> division by %u: %u\n",
> +                        TIME_BASE_NS, period);
> +               return -ERANGE;
> +       }
> +
> +       period /=3D TIME_BASE_NS;
> +       duty /=3D TIME_BASE_NS;
> +
> +       res |=3D regmap_write(pwm->ec->regmap, NTXEC_REG_PERIOD_HIGH,
> u8_to_reg(period >> 8));
> +       res |=3D regmap_write(pwm->ec->regmap, NTXEC_REG_PERIOD_LOW,
> u8_to_reg(period));
> +       res |=3D regmap_write(pwm->ec->regmap, NTXEC_REG_DUTY_HIGH,
> u8_to_reg(duty >> 8));
> +       res |=3D regmap_write(pwm->ec->regmap, NTXEC_REG_DUTY_LOW,
> u8_to_reg(duty));


These funny res |=3D is unusual pattern for returned error codes. Moreover
you are shadowing the real ones. Same go the rest drovers. Please fix by
checking each separately.


> +
> +       if (res < 0)
> +               return -EIO;
> +
> +       /*
> +        * Writing a duty cycle of zone puts the device into a state wher=
e
> +        * writing a higher duty cycle doesn't result in the brightness
> that it
> +        * usually results in. This can be fixed by cycling the ENABLE
> register.
> +        *
> +        * As a workaround, write ENABLE=3D0 when the duty cycle is zero.
> +        */
> +       if (state->enabled && duty !=3D 0) {
> +               res |=3D regmap_write(pwm->ec->regmap, NTXEC_REG_ENABLE,
> u8_to_reg(1));
> +
> +               /* Disable the auto-off timer */
> +               res |=3D regmap_write(pwm->ec->regmap,
> NTXEC_REG_AUTO_OFF_HI, u8_to_reg(0xff));
> +               res |=3D regmap_write(pwm->ec->regmap,
> NTXEC_REG_AUTO_OFF_LO, u8_to_reg(0xff));
> +               return res ? -EIO : 0;
> +       } else {
> +               return regmap_write(pwm->ec->regmap, NTXEC_REG_ENABLE,
> u8_to_reg(0));
> +       }
> +}
> +
> +static struct pwm_ops ntxec_pwm_ops =3D {
> +       .apply =3D ntxec_pwm_apply,
> +       .owner =3D THIS_MODULE,
> +};
> +
> +static int ntxec_pwm_probe(struct platform_device *pdev)
> +{
> +       struct ntxec *ec =3D dev_get_drvdata(pdev->dev.parent);
> +       struct ntxec_pwm *pwm;
> +       struct pwm_chip *chip;
> +       int res;
> +
> +       pwm =3D devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
> +       if (!pwm)
> +               return -ENOMEM;
> +
> +       pwm->ec =3D ec;
> +       pwm->dev =3D &pdev->dev;
> +
> +       chip =3D &pwm->chip;
> +       chip->dev =3D &pdev->dev;
> +       chip->ops =3D &ntxec_pwm_ops;
> +       chip->base =3D -1;
> +       chip->npwm =3D 1;
> +
> +       res =3D pwmchip_add(chip);
> +       if (res < 0)
> +               return res;
> +
> +       platform_set_drvdata(pdev, pwm);
> +
> +       return (res < 0) ? -EIO : 0;


What?!


> +}
> +
> +static int ntxec_pwm_remove(struct platform_device *pdev)
> +{
> +       struct ntxec_pwm *pwm =3D platform_get_drvdata(pdev);
> +       struct pwm_chip *chip =3D &pwm->chip;
> +
> +       return pwmchip_remove(chip);
> +}
> +
> +static const struct of_device_id ntxec_pwm_of_match[] =3D {
> +       { .compatible =3D "netronix,ntxec-pwm" },
>
>

> +       { },


No comma.


> +};
> +MODULE_DEVICE_TABLE(of, ntxec_pwm_of_match);
> +
> +static struct platform_driver ntxec_pwm_driver =3D {
> +       .driver =3D {
> +               .name =3D "ntxec-pwm",
> +               .of_match_table =3D ntxec_pwm_of_match,
> +       },
> +       .probe =3D ntxec_pwm_probe,
> +       .remove =3D ntxec_pwm_remove,
> +};
> +module_platform_driver(ntxec_pwm_driver);
> +
> +MODULE_AUTHOR("Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>");
> +MODULE_DESCRIPTION("PWM driver for Netronix EC");
> +MODULE_LICENSE("GPL");
> --
> 2.28.0
>
>

--=20
With Best Regards,
Andy Shevchenko

--00000000000092af1905ae94e0d8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Saturday, September 5, 2020, Jonathan Neusch=C3=A4fer &lt;<a hre=
f=3D"mailto:j.neuschaefer@gmx.net">j.neuschaefer@gmx.net</a>&gt; wrote:<br>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">The Netronix EC provides a PWM output which =
is used for the backlight<br>
on some ebook readers. This patches adds a driver for the PWM output.<br>
<br>
Signed-off-by: Jonathan Neusch=C3=A4fer &lt;<a href=3D"mailto:j.neuschaefer=
@gmx.net">j.neuschaefer@gmx.net</a>&gt;<br>
---<br>
<br>
v2:<br>
- Various grammar and style improvements, as suggested by Uwe Kleine-K=C3=
=B6nig,<br>
=C2=A0 Lee Jones, and Alexandre Belloni<br>
- Switch to regmap<br>
- Prefix registers with NTXEC_REG_<br>
- Add help text to the Kconfig option<br>
- Use the .apply callback instead of the old API<br>
- Add a #define for the time base (125ns)<br>
- Don&#39;t change device state in .probe; this avoids multiple problems<br=
>
- Rework division and overflow check logic to perform divisions in 32 bits<=
br>
- Avoid setting duty cycle to zero, to work around a hardware quirk<br>
---<br>
=C2=A0drivers/pwm/Kconfig=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A08 ++<br>
=C2=A0drivers/pwm/Makefile=C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0drivers/pwm/pwm-ntxec.c | 160 ++++++++++++++++++++++++++++++<wbr>++++=
++++++<br>
=C2=A03 files changed, 169 insertions(+)<br>
=C2=A0create mode 100644 drivers/pwm/pwm-ntxec.c<br>
<br>
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig<br>
index 7dbcf6973d335..7fd17c6cda95e 100644<br>
--- a/drivers/pwm/Kconfig<br>
+++ b/drivers/pwm/Kconfig<br>
@@ -350,6 +350,14 @@ config PWM_MXS<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 To compile this driver as a module, choo=
se M here: the module<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 will be called pwm-mxs.<br>
<br>
+config PWM_NTXEC<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tristate &quot;Netronix embedded controller PWM=
 support&quot;</blockquote><div><br></div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0depends on MFD_NTXEC &amp;&amp; OF</blockquote>=
<div><br></div><div>I don=E2=80=99t see need to reduce test coverage and us=
e of the driver by sticking with OF. Actually it=E2=80=99s not used.</div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0help<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Say yes here if you want to support the =
PWM output of the embedded<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0controller found in certain e-book reade=
rs designed by the ODM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Netronix.<br>
+<br>
=C2=A0config PWM_OMAP_DMTIMER<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tristate &quot;OMAP Dual-Mode Timer PWM support=
&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 depends on OF<br>
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile<br>
index 2c2ba0a035577..1cc50dba22d1b 100644<br>
--- a/drivers/pwm/Makefile<br>
+++ b/drivers/pwm/Makefile<br>
@@ -32,6 +32,7 @@ obj-$(CONFIG_PWM_MESON)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0+=3D pwm-meson.o<br>
=C2=A0obj-$(CONFIG_PWM_MEDIATEK)=C2=A0 =C2=A0 =C2=A0+=3D pwm-mediatek.o<br>
=C2=A0obj-$(CONFIG_PWM_MTK_DISP)=C2=A0 =C2=A0 =C2=A0+=3D pwm-mtk-disp.o<br>
=C2=A0obj-$(CONFIG_PWM_MXS)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +=3D pwm-mxs.=
o<br>
+obj-$(CONFIG_PWM_NTXEC)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 +=3D pwm-ntxec.o<br>
=C2=A0obj-$(CONFIG_PWM_OMAP_DMTIMER) +=3D pwm-omap-dmtimer.o<br>
=C2=A0obj-$(CONFIG_PWM_PCA9685)=C2=A0 =C2=A0 =C2=A0 +=3D pwm-pca9685.o<br>
=C2=A0obj-$(CONFIG_PWM_PXA)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +=3D pwm-pxa.=
o<br>
diff --git a/drivers/pwm/pwm-ntxec.c b/drivers/pwm/pwm-ntxec.c<br>
new file mode 100644<br>
index 0000000000000..325ec0e8f1996<br>
--- /dev/null<br>
+++ b/drivers/pwm/pwm-ntxec.c<br>
@@ -0,0 +1,160 @@<br>
+// SPDX-License-Identifier: GPL-2.0-only<br>
+/*<br>
+ * The Netronix embedded controller is a microcontroller found in some<br>
+ * e-book readers designed by the ODM Netronix, Inc. It contains RTC,<br>
+ * battery monitoring, system power management, and PWM functionality.<br>
+ *<br>
+ * This driver implements PWM output.<br>
+ *<br>
+ * Copyright 2020 Jonathan Neusch=C3=A4fer<br>
+ */<br>
+<br>
+#include &lt;linux/mfd/ntxec.h&gt;<br>
+#include &lt;linux/module.h&gt;</blockquote><div><br></div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">
+#include &lt;linux/of_device.h&gt;</blockquote><div><br></div><div>mod_dev=
icetable.h</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
+#include &lt;linux/platform_device.h&gt;<br>
+#include &lt;linux/pwm.h&gt;<br>
+#include &lt;linux/regmap.h&gt;<br>
+#include &lt;linux/types.h&gt;<br>
+<br>
+struct ntxec_pwm {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *dev;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct ntxec *ec;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct pwm_chip chip;<br>
+};<br>
+<br>
+static struct ntxec_pwm *pwmchip_to_pwm(struct pwm_chip *chip)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return container_of(chip, struct ntxec_pwm, chi=
p);<br>
+}<br>
+<br>
+#define NTXEC_REG_AUTO_OFF_HI=C2=A0 0xa1<br>
+#define NTXEC_REG_AUTO_OFF_LO=C2=A0 0xa2<br>
+#define NTXEC_REG_ENABLE=C2=A0 =C2=A0 =C2=A0 =C2=A00xa3<br>
+#define NTXEC_REG_PERIOD_LOW=C2=A0 =C2=A00xa4<br>
+#define NTXEC_REG_PERIOD_HIGH=C2=A0 0xa5<br>
+#define NTXEC_REG_DUTY_LOW=C2=A0 =C2=A0 =C2=A00xa6<br>
+#define NTXEC_REG_DUTY_HIGH=C2=A0 =C2=A0 0xa7<br>
+<br>
+/* Convert an 8-bit value into the correct format for writing into a regis=
ter */<br>
+#define u8_to_reg(x) (((x) &amp; 0xff) &lt;&lt; 8)</blockquote><div><br></=
div><div>You spread this macro among the drivers w/o explanation what=E2=80=
=99s going on. I think there will be better approach.</div><div>=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">
+<br>
+/*<br>
+ * The time base used in the EC is 8MHz, or 125ns. Period and duty cycle a=
re<br>
+ * measured in this unit.<br>
+ */<br>
+#define TIME_BASE_NS 125<br>
+<br>
+/*<br>
+ * The maximum input value (in nanoseconds) is determined by the time base=
 and<br>
+ * the range of the hardware registers that hold the converted value.<br>
+ * It fits into 32 bits, so we can do our calculations in 32 bits as well.=
<br>
+ */<br>
+#define MAX_PERIOD_NS (TIME_BASE_NS * 0x10000 - 1)<br>
+<br>
+static int ntxec_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm_d=
ev,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 const struct pwm_state *state)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct ntxec_pwm *pwm =3D pwmchip_to_pwm(pwm_de=
v-&gt;chip);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int duty =3D state-&gt;duty_cycle;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int period =3D state-&gt;period;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int res =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (period &gt; MAX_PERIOD_NS) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_warn(pwm-&gt;de=
v,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;Period is not representable in 16 bits after division by %=
u: %u\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 TIME_BASE_NS, period);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ERANGE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0period /=3D TIME_BASE_NS;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0duty /=3D TIME_BASE_NS;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0res |=3D regmap_write(pwm-&gt;ec-&gt;regmap, NT=
XEC_REG_PERIOD_HIGH, u8_to_reg(period &gt;&gt; 8));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0res |=3D regmap_write(pwm-&gt;ec-&gt;regmap, NT=
XEC_REG_PERIOD_LOW, u8_to_reg(period));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0res |=3D regmap_write(pwm-&gt;ec-&gt;regmap, NT=
XEC_REG_DUTY_HIGH, u8_to_reg(duty &gt;&gt; 8));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0res |=3D regmap_write(pwm-&gt;ec-&gt;regmap, NT=
XEC_REG_DUTY_LOW, u8_to_reg(duty));</blockquote><div><br></div><div>These f=
unny res |=3D is unusual pattern for returned error codes. Moreover you are=
 shadowing the real ones. Same go the rest drovers. Please fix by checking =
each separately.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (res &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIO;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Writing a duty cycle of zone puts the device=
 into a state where<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * writing a higher duty cycle doesn&#39;t resu=
lt in the brightness that it<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * usually results in. This can be fixed by cyc=
ling the ENABLE register.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * As a workaround, write ENABLE=3D0 when the d=
uty cycle is zero.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (state-&gt;enabled &amp;&amp; duty !=3D 0) {=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0res |=3D regmap_wri=
te(pwm-&gt;ec-&gt;regmap, NTXEC_REG_ENABLE, u8_to_reg(1));<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Disable the auto=
-off timer */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0res |=3D regmap_wri=
te(pwm-&gt;ec-&gt;regmap, NTXEC_REG_AUTO_OFF_HI, u8_to_reg(0xff));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0res |=3D regmap_wri=
te(pwm-&gt;ec-&gt;regmap, NTXEC_REG_AUTO_OFF_LO, u8_to_reg(0xff));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return res ? -EIO :=
 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return regmap_write=
(pwm-&gt;ec-&gt;regmap, NTXEC_REG_ENABLE, u8_to_reg(0));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+}<br>
+<br>
+static struct pwm_ops ntxec_pwm_ops =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.apply =3D ntxec_pwm_apply,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.owner =3D THIS_MODULE,<br>
+};<br>
+<br>
+static int ntxec_pwm_probe(struct platform_device *pdev)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct ntxec *ec =3D dev_get_drvdata(pdev-&gt;d=
ev.<wbr>parent);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct ntxec_pwm *pwm;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct pwm_chip *chip;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int res;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pwm =3D devm_kzalloc(&amp;pdev-&gt;dev, sizeof(=
*pwm), GFP_KERNEL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!pwm)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pwm-&gt;ec =3D ec;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pwm-&gt;dev =3D &amp;pdev-&gt;dev;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0chip =3D &amp;pwm-&gt;chip;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0chip-&gt;dev =3D &amp;pdev-&gt;dev;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0chip-&gt;ops =3D &amp;ntxec_pwm_ops;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0chip-&gt;base =3D -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0chip-&gt;npwm =3D 1;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0res =3D pwmchip_add(chip);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (res &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return res;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0platform_set_drvdata(pdev, pwm);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return (res &lt; 0) ? -EIO : 0;</blockquote><di=
v><br></div><div>What?!</div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">
+}<br>
+<br>
+static int ntxec_pwm_remove(struct platform_device *pdev)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct ntxec_pwm *pwm =3D platform_get_drvdata(=
pdev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct pwm_chip *chip =3D &amp;pwm-&gt;chip;<br=
>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return pwmchip_remove(chip);<br>
+}<br>
+<br>
+static const struct of_device_id ntxec_pwm_of_match[] =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{ .compatible =3D &quot;netronix,ntxec-pwm&quot=
; },<br><br></blockquote><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{ },</blockquote><div><br></div><div>No comma.<=
/div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
+};<br>
+MODULE_DEVICE_TABLE(of, ntxec_pwm_of_match);<br>
+<br>
+static struct platform_driver ntxec_pwm_driver =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.driver =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =3D &quot;ntx=
ec-pwm&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.of_match_table =3D=
 ntxec_pwm_of_match,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.probe =3D ntxec_pwm_probe,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.remove =3D ntxec_pwm_remove,<br>
+};<br>
+module_platform_driver(ntxec_<wbr>pwm_driver);<br>
+<br>
+MODULE_AUTHOR(&quot;Jonathan Neusch=C3=A4fer &lt;<a href=3D"mailto:j.neusc=
haefer@gmx.net">j.neuschaefer@gmx.net</a>&gt;&quot;);<br>
+MODULE_DESCRIPTION(&quot;PWM driver for Netronix EC&quot;);<br>
+MODULE_LICENSE(&quot;GPL&quot;);<br>
--<br>
2.28.0<br>
<br>
</blockquote><br><br>-- <br>With Best Regards,<br>Andy Shevchenko<br><br><b=
r>

--00000000000092af1905ae94e0d8--
