Return-path: <kernel-bounces@pengutronix.de>
MIME-Version: 1.0
In-Reply-To: <20200905144503.1067124-1-j.neuschaefer@gmx.net>
References: <20200905133230.1014581-1-j.neuschaefer@gmx.net>
 <20200905144503.1067124-1-j.neuschaefer@gmx.net>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 5 Sep 2020 20:56:35 +0300
Message-ID: <CAHp75Vca+Tp0v_Q4RBuUNSo_5aq_u6mBGeXecHULC1Avgm5=Xg@mail.gmail.com>
Content-Type: multipart/alternative; boundary="000000000000dca1c205ae94b445"
Subject: Re: [PATCH v2 08/10] rtc: New driver for RTC in Netronix embedded
 controller
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

--000000000000dca1c205ae94b445
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Saturday, September 5, 2020, Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx=
.net>
wrote:

> With this driver, mainline Linux can keep its time and date in sync with
> the vendor kernel.
>
> Advanced functionality like alarm and automatic power-on is not yet
> supported.
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---
>
> v2:
> - Rework top-of-file comment [Lee Jones]
> - Sort the #include lines [Alexandre Belloni]
> - don't align =3D signs in struct initializers [Uwe Kleine-K=C3=B6nig]
> - Switch to regmap
> - Fix register number used to read minutes and seconds
> - Prefix registers with NTXEC_REG_
> - Add help text to the Kconfig option
> - Use devm_rtc_allocate_device and rtc_register_device, set ->range_min
> and ->range_max
> ---
>  drivers/rtc/Kconfig     |   8 +++
>  drivers/rtc/Makefile    |   1 +
>  drivers/rtc/rtc-ntxec.c | 130 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 139 insertions(+)
>  create mode 100644 drivers/rtc/rtc-ntxec.c
>
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 48c536acd777f..ae8f3dc36c9a3 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1301,6 +1301,14 @@ config RTC_DRV_CROS_EC
>           This driver can also be built as a module. If so, the module
>           will be called rtc-cros-ec.
>
> +config RTC_DRV_NTXEC
> +       tristate "Netronix embedded controller RTC driver"
> +       depends on MFD_NTXEC
> +       help
> +         Say yes here if you want to support the RTC functionality of th=
e
> +         embedded controller found in certain e-book readers designed by
> the
> +         ODM Netronix.
> +
>  comment "on-CPU RTC drivers"
>
>  config RTC_DRV_ASM9260
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index 880e08a409c3d..733479db18896 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -111,6 +111,7 @@ obj-$(CONFIG_RTC_DRV_MT7622)        +=3D rtc-mt7622.o
>  obj-$(CONFIG_RTC_DRV_MV)       +=3D rtc-mv.o
>  obj-$(CONFIG_RTC_DRV_MXC)      +=3D rtc-mxc.o
>  obj-$(CONFIG_RTC_DRV_MXC_V2)   +=3D rtc-mxc_v2.o
> +obj-$(CONFIG_RTC_DRV_NTXEC)    +=3D rtc-ntxec.o
>  obj-$(CONFIG_RTC_DRV_OMAP)     +=3D rtc-omap.o
>  obj-$(CONFIG_RTC_DRV_OPAL)     +=3D rtc-opal.o
>  obj-$(CONFIG_RTC_DRV_PALMAS)   +=3D rtc-palmas.o
> diff --git a/drivers/rtc/rtc-ntxec.c b/drivers/rtc/rtc-ntxec.c
> new file mode 100644
> index 0000000000000..82eb6352353cd
> --- /dev/null
> +++ b/drivers/rtc/rtc-ntxec.c
> @@ -0,0 +1,130 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * The Netronix embedded controller is a microcontroller found in some
> + * e-book readers designed by the ODM Netronix, Inc. It contains RTC,
> + * battery monitoring, system power management, and PWM functionality.
> + *
> + * This driver implements access to the RTC time and date.
> + *
> + * Copyright 2020 Jonathan Neusch=C3=A4fer
> + */
> +
> +#include <linux/mfd/ntxec.h>
> +#include <linux/module.h>




> +#include <linux/of_device.h>


No user for this. Perhaps you meant mod_devicetable.h?


> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/rtc.h>
> +#include <linux/types.h>
> +
> +struct ntxec_rtc {
> +       struct device *dev;
> +       struct ntxec *ec;
> +};
> +
> +#define NTXEC_REG_WRITE_YEAR   0x10
> +#define NTXEC_REG_WRITE_MONTH  0x11
> +#define NTXEC_REG_WRITE_DAY    0x12
> +#define NTXEC_REG_WRITE_HOUR   0x13
> +#define NTXEC_REG_WRITE_MINUTE 0x14
> +#define NTXEC_REG_WRITE_SECOND 0x15
> +
> +/* Convert an 8-bit value into the correct format for writing into a
> register */
> +#define u8_to_reg(x) (((x) & 0xff) << 8)


This needs more explanation. Does register be16?


> +
> +#define NTXEC_REG_READ_YM      0x20
> +#define NTXEC_REG_READ_DH      0x21
> +#define NTXEC_REG_READ_MS      0x23
> +
> +static int ntxec_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +       struct ntxec_rtc *rtc =3D dev_get_drvdata(dev);
> +       unsigned int value;
> +       int res;
> +
> +       res =3D regmap_read(rtc->ec->regmap, NTXEC_REG_READ_YM, &value);
> +       if (res < 0)
> +               return res;
> +
> +       tm->tm_year =3D (value >> 8) + 100;
> +       tm->tm_mon =3D (value & 0xff) - 1;
> +
> +       res =3D regmap_read(rtc->ec->regmap, NTXEC_REG_READ_DH, &value);
> +       if (res < 0)
> +               return res;
> +
> +       tm->tm_mday =3D value >> 8;
> +       tm->tm_hour =3D value & 0xff;
> +
> +       res =3D regmap_read(rtc->ec->regmap, NTXEC_REG_READ_MS, &value);
> +       if (res < 0)
> +               return res;
> +
> +       tm->tm_min =3D value >> 8;
> +       tm->tm_sec =3D value & 0xff;
> +
> +       return 0;
> +}
> +
> +static int ntxec_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +       struct ntxec_rtc *rtc =3D dev_get_drvdata(dev);
> +       int res =3D 0;
> +
> +       res |=3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_YEAR,
> u8_to_reg(tm->tm_year - 100));
> +       res |=3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_MONTH,
> u8_to_reg(tm->tm_mon + 1));
> +       res |=3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_DAY,
> u8_to_reg(tm->tm_mday));
> +       res |=3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_HOUR,
> u8_to_reg(tm->tm_hour));
> +       res |=3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_MINUTE,
> u8_to_reg(tm->tm_min));
> +       res |=3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_SECOND,
> u8_to_reg(tm->tm_sec));
> +
> +       return (res < 0) ? -EIO : 0;


Hmm... (I stumbled over res |=3D parts)


> +}
> +
> +static const struct rtc_class_ops ntxec_rtc_ops =3D {
> +       .read_time =3D ntxec_read_time,
> +       .set_time =3D ntxec_set_time,
> +};
> +
> +static int ntxec_rtc_probe(struct platform_device *pdev)
> +{
> +       struct rtc_device *dev;
> +       struct ntxec_rtc *rtc;
> +
> +       rtc =3D devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
> +       if (!rtc)
> +               return -ENOMEM;
> +
> +       rtc->dev =3D &pdev->dev;
> +       rtc->ec =3D dev_get_drvdata(pdev->dev.parent);
> +       platform_set_drvdata(pdev, rtc);
> +
> +       dev =3D devm_rtc_allocate_device(&pdev->dev);
> +       if (IS_ERR(dev))
> +               return PTR_ERR(dev);
> +
> +       dev->ops =3D &ntxec_rtc_ops;
> +       dev->range_min =3D RTC_TIMESTAMP_BEGIN_2000;
> +       dev->range_max =3D RTC_TIMESTAMP_END_2255;
> +
> +       return rtc_register_device(dev);
> +}
> +
> +static const struct of_device_id ntxec_rtc_of_match[] =3D {
> +       { .compatible =3D "netronix,ntxec-rtc" },
> +       { },


No need for comma in terminator line.


> +};
> +MODULE_DEVICE_TABLE(of, ntxec_rtc_of_match);
> +
> +static struct platform_driver ntxec_rtc_driver =3D {
> +       .driver =3D {
> +               .name =3D "ntxec-rtc",
> +               .of_match_table =3D ntxec_rtc_of_match,
> +       },
> +       .probe =3D ntxec_rtc_probe,
> +};
> +module_platform_driver(ntxec_rtc_driver);
> +
> +MODULE_AUTHOR("Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>");
> +MODULE_DESCRIPTION("RTC driver for Netronix EC");
> +MODULE_LICENSE("GPL");
> --
> 2.28.0
>
>

--=20
With Best Regards,
Andy Shevchenko

--000000000000dca1c205ae94b445
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Saturday, September 5, 2020, Jonathan Neusch=C3=A4fer &lt;<a hre=
f=3D"mailto:j.neuschaefer@gmx.net">j.neuschaefer@gmx.net</a>&gt; wrote:<br>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">With this driver, mainline Linux can keep it=
s time and date in sync with<br>
the vendor kernel.<br>
<br>
Advanced functionality like alarm and automatic power-on is not yet<br>
supported.<br>
<br>
Signed-off-by: Jonathan Neusch=C3=A4fer &lt;<a href=3D"mailto:j.neuschaefer=
@gmx.net">j.neuschaefer@gmx.net</a>&gt;<br>
---<br>
<br>
v2:<br>
- Rework top-of-file comment [Lee Jones]<br>
- Sort the #include lines [Alexandre Belloni]<br>
- don&#39;t align =3D signs in struct initializers [Uwe Kleine-K=C3=B6nig]<=
br>
- Switch to regmap<br>
- Fix register number used to read minutes and seconds<br>
- Prefix registers with NTXEC_REG_<br>
- Add help text to the Kconfig option<br>
- Use devm_rtc_allocate_device and rtc_register_device, set -&gt;range_min =
and -&gt;range_max<br>
---<br>
=C2=A0drivers/rtc/Kconfig=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A08 +++<br>
=C2=A0drivers/rtc/Makefile=C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0drivers/rtc/rtc-ntxec.c | 130 ++++++++++++++++++++++++++++++<wbr>++++=
++++++<br>
=C2=A03 files changed, 139 insertions(+)<br>
=C2=A0create mode 100644 drivers/rtc/rtc-ntxec.c<br>
<br>
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig<br>
index 48c536acd777f..ae8f3dc36c9a3 100644<br>
--- a/drivers/rtc/Kconfig<br>
+++ b/drivers/rtc/Kconfig<br>
@@ -1301,6 +1301,14 @@ config RTC_DRV_CROS_EC<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 This driver can also be built as a modul=
e. If so, the module<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 will be called rtc-cros-ec.<br>
<br>
+config RTC_DRV_NTXEC<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tristate &quot;Netronix embedded controller RTC=
 driver&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0depends on MFD_NTXEC<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0help<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Say yes here if you want to support the =
RTC functionality of the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0embedded controller found in certain e-b=
ook readers designed by the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ODM Netronix.<br>
+<br>
=C2=A0comment &quot;on-CPU RTC drivers&quot;<br>
<br>
=C2=A0config RTC_DRV_ASM9260<br>
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile<br>
index 880e08a409c3d..733479db18896 100644<br>
--- a/drivers/rtc/Makefile<br>
+++ b/drivers/rtc/Makefile<br>
@@ -111,6 +111,7 @@ obj-$(CONFIG_RTC_DRV_MT7622)=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 +=3D rtc-mt7622.o<br>
=C2=A0obj-$(CONFIG_RTC_DRV_MV)=C2=A0 =C2=A0 =C2=A0 =C2=A0+=3D rtc-mv.o<br>
=C2=A0obj-$(CONFIG_RTC_DRV_MXC)=C2=A0 =C2=A0 =C2=A0 +=3D rtc-mxc.o<br>
=C2=A0obj-$(CONFIG_RTC_DRV_MXC_V2)=C2=A0 =C2=A0+=3D rtc-mxc_v2.o<br>
+obj-$(CONFIG_RTC_DRV_NTXEC)=C2=A0 =C2=A0 +=3D rtc-ntxec.o<br>
=C2=A0obj-$(CONFIG_RTC_DRV_OMAP)=C2=A0 =C2=A0 =C2=A0+=3D rtc-omap.o<br>
=C2=A0obj-$(CONFIG_RTC_DRV_OPAL)=C2=A0 =C2=A0 =C2=A0+=3D rtc-opal.o<br>
=C2=A0obj-$(CONFIG_RTC_DRV_PALMAS)=C2=A0 =C2=A0+=3D rtc-palmas.o<br>
diff --git a/drivers/rtc/rtc-ntxec.c b/drivers/rtc/rtc-ntxec.c<br>
new file mode 100644<br>
index 0000000000000..82eb6352353cd<br>
--- /dev/null<br>
+++ b/drivers/rtc/rtc-ntxec.c<br>
@@ -0,0 +1,130 @@<br>
+// SPDX-License-Identifier: GPL-2.0-only<br>
+/*<br>
+ * The Netronix embedded controller is a microcontroller found in some<br>
+ * e-book readers designed by the ODM Netronix, Inc. It contains RTC,<br>
+ * battery monitoring, system power management, and PWM functionality.<br>
+ *<br>
+ * This driver implements access to the RTC time and date.<br>
+ *<br>
+ * Copyright 2020 Jonathan Neusch=C3=A4fer<br>
+ */<br>
+<br>
+#include &lt;linux/mfd/ntxec.h&gt;<br>
+#include &lt;linux/module.h&gt;</blockquote><div><br></div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">
+#include &lt;linux/of_device.h&gt;</blockquote><div><br></div><div>No user=
 for this. Perhaps you meant mod_devicetable.h?</div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">
+#include &lt;linux/platform_device.h&gt;<br>
+#include &lt;linux/regmap.h&gt;<br>
+#include &lt;linux/rtc.h&gt;<br>
+#include &lt;linux/types.h&gt;<br>
+<br>
+struct ntxec_rtc {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *dev;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct ntxec *ec;<br>
+};<br>
+<br>
+#define NTXEC_REG_WRITE_YEAR=C2=A0 =C2=A00x10<br>
+#define NTXEC_REG_WRITE_MONTH=C2=A0 0x11<br>
+#define NTXEC_REG_WRITE_DAY=C2=A0 =C2=A0 0x12<br>
+#define NTXEC_REG_WRITE_HOUR=C2=A0 =C2=A00x13<br>
+#define NTXEC_REG_WRITE_MINUTE 0x14<br>
+#define NTXEC_REG_WRITE_SECOND 0x15<br>
+<br>
+/* Convert an 8-bit value into the correct format for writing into a regis=
ter */<br>
+#define u8_to_reg(x) (((x) &amp; 0xff) &lt;&lt; 8)</blockquote><div><br></=
div><div>This needs more explanation. Does register be16?</div><div>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">
+<br>
+#define NTXEC_REG_READ_YM=C2=A0 =C2=A0 =C2=A0 0x20<br>
+#define NTXEC_REG_READ_DH=C2=A0 =C2=A0 =C2=A0 0x21<br>
+#define NTXEC_REG_READ_MS=C2=A0 =C2=A0 =C2=A0 0x23<br>
+<br>
+static int ntxec_read_time(struct device *dev, struct rtc_time *tm)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct ntxec_rtc *rtc =3D dev_get_drvdata(dev);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int res;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0res =3D regmap_read(rtc-&gt;ec-&gt;regmap, NTXE=
C_REG_READ_YM, &amp;value);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (res &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return res;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tm-&gt;tm_year =3D (value &gt;&gt; 8) + 100;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tm-&gt;tm_mon =3D (value &amp; 0xff) - 1;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0res =3D regmap_read(rtc-&gt;ec-&gt;regmap, NTXE=
C_REG_READ_DH, &amp;value);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (res &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return res;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tm-&gt;tm_mday =3D value &gt;&gt; 8;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tm-&gt;tm_hour =3D value &amp; 0xff;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0res =3D regmap_read(rtc-&gt;ec-&gt;regmap, NTXE=
C_REG_READ_MS, &amp;value);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (res &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return res;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tm-&gt;tm_min =3D value &gt;&gt; 8;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tm-&gt;tm_sec =3D value &amp; 0xff;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+static int ntxec_set_time(struct device *dev, struct rtc_time *tm)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct ntxec_rtc *rtc =3D dev_get_drvdata(dev);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int res =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0res |=3D regmap_write(rtc-&gt;ec-&gt;regmap, NT=
XEC_REG_WRITE_YEAR, u8_to_reg(tm-&gt;tm_year - 100));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0res |=3D regmap_write(rtc-&gt;ec-&gt;regmap, NT=
XEC_REG_WRITE_MONTH, u8_to_reg(tm-&gt;tm_mon + 1));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0res |=3D regmap_write(rtc-&gt;ec-&gt;regmap, NT=
XEC_REG_WRITE_DAY, u8_to_reg(tm-&gt;tm_mday));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0res |=3D regmap_write(rtc-&gt;ec-&gt;regmap, NT=
XEC_REG_WRITE_HOUR, u8_to_reg(tm-&gt;tm_hour));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0res |=3D regmap_write(rtc-&gt;ec-&gt;regmap, NT=
XEC_REG_WRITE_MINUTE, u8_to_reg(tm-&gt;tm_min));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0res |=3D regmap_write(rtc-&gt;ec-&gt;regmap, NT=
XEC_REG_WRITE_SECOND, u8_to_reg(tm-&gt;tm_sec));<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return (res &lt; 0) ? -EIO : 0;</blockquote><di=
v><br></div><div>Hmm... (I stumbled over res |=3D parts)</div><div>=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">
+}<br>
+<br>
+static const struct rtc_class_ops ntxec_rtc_ops =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.read_time =3D ntxec_read_time,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.set_time =3D ntxec_set_time,<br>
+};<br>
+<br>
+static int ntxec_rtc_probe(struct platform_device *pdev)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rtc_device *dev;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct ntxec_rtc *rtc;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rtc =3D devm_kzalloc(&amp;pdev-&gt;dev, sizeof(=
*rtc), GFP_KERNEL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!rtc)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rtc-&gt;dev =3D &amp;pdev-&gt;dev;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rtc-&gt;ec =3D dev_get_drvdata(pdev-&gt;dev.<wb=
r>parent);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0platform_set_drvdata(pdev, rtc);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dev =3D devm_rtc_allocate_device(&amp;<wbr>pdev=
-&gt;dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(dev))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR(dev)=
;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dev-&gt;ops =3D &amp;ntxec_rtc_ops;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dev-&gt;range_min =3D RTC_TIMESTAMP_BEGIN_2000;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dev-&gt;range_max =3D RTC_TIMESTAMP_END_2255;<b=
r>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return rtc_register_device(dev);<br>
+}<br>
+<br>
+static const struct of_device_id ntxec_rtc_of_match[] =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{ .compatible =3D &quot;netronix,ntxec-rtc&quot=
; },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{ },</blockquote><div><br></div><div>No need fo=
r comma in terminator line.</div><div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">
+};<br>
+MODULE_DEVICE_TABLE(of, ntxec_rtc_of_match);<br>
+<br>
+static struct platform_driver ntxec_rtc_driver =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.driver =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =3D &quot;ntx=
ec-rtc&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.of_match_table =3D=
 ntxec_rtc_of_match,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.probe =3D ntxec_rtc_probe,<br>
+};<br>
+module_platform_driver(ntxec_<wbr>rtc_driver);<br>
+<br>
+MODULE_AUTHOR(&quot;Jonathan Neusch=C3=A4fer &lt;<a href=3D"mailto:j.neusc=
haefer@gmx.net">j.neuschaefer@gmx.net</a>&gt;&quot;);<br>
+MODULE_DESCRIPTION(&quot;RTC driver for Netronix EC&quot;);<br>
+MODULE_LICENSE(&quot;GPL&quot;);<br>
--<br>
2.28.0<br>
<br>
</blockquote><br><br>-- <br>With Best Regards,<br>Andy Shevchenko<br><br><b=
r>

--000000000000dca1c205ae94b445--
