Return-Path: <eric.y.miao@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1389884494-13729-1-git-send-email-s.hauer@pengutronix.de>
References: <1389884494-13729-1-git-send-email-s.hauer@pengutronix.de>
From: Eric Miao <eric.y.miao@gmail.com>
Date: Fri, 17 Jan 2014 10:49:44 -0800
Message-ID: <CAMPhdO85UJvNH7GiE5t1TE=5+8k4euqSEODkU+4ZwDhUaphuog@mail.gmail.com>
Subject: Re: [PATCH] pwm: Remove obsolete HAVE_PWM Kconfig symbol
Content-Type: multipart/alternative; boundary=047d7b5d36029a335204f02f02db
List-ID: <linux-pwm.vger.kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

--047d7b5d36029a335204f02f02db
Content-Type: text/plain; charset=UTF-8

Looks good to me, happy to see it gone.


On Thu, Jan 16, 2014 at 7:01 AM, Sascha Hauer <s.hauer@pengutronix.de>wrote:

> Before we had the PWM framework we used to have a barebone PWM api. The
> HAVE_PWM Kconfig symbol used to be selected by the PWM drivers to specify
> the PWM API is present in the kernel. Since the last legacy driver is gone
> the HAVE_PWM symbol can go aswell.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>
> I suggest that Thierry as PWM Maintainer takes the patch through his tree.
> Is that ok for you Thierry?
>
>  arch/arm/Kconfig           |  4 ----
>  arch/arm/mach-pxa/Kconfig  | 15 ---------------
>  arch/mips/Kconfig          |  1 -
>  drivers/input/misc/Kconfig |  4 ++--
>  include/linux/pwm.h        |  2 +-
>  5 files changed, 3 insertions(+), 23 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index c1f1a7e..1b6f499 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -109,9 +109,6 @@ config ARM_DMA_IOMMU_ALIGNMENT
>
>  endif
>
> -config HAVE_PWM
> -       bool
> -
>  config MIGHT_HAVE_PCI
>         bool
>
> @@ -606,7 +603,6 @@ config ARCH_LPC32XX
>         select CPU_ARM926T
>         select GENERIC_CLOCKEVENTS
>         select HAVE_IDE
> -       select HAVE_PWM
>         select USB_ARCH_HAS_OHCI
>         select USE_OF
>         help
> diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
> index 96100db..b96244c 100644
> --- a/arch/arm/mach-pxa/Kconfig
> +++ b/arch/arm/mach-pxa/Kconfig
> @@ -7,7 +7,6 @@ comment "Intel/Marvell Dev Platforms (sorted by hardware
> release time)"
>  config MACH_PXA3XX_DT
>         bool "Support PXA3xx platforms from device tree"
>         select CPU_PXA300
> -       select HAVE_PWM
>         select POWER_SUPPLY
>         select PXA3xx
>         select USE_OF
> @@ -23,12 +22,10 @@ config ARCH_LUBBOCK
>
>  config MACH_MAINSTONE
>         bool "Intel HCDDBBVA0 Development Platform (aka Mainstone)"
> -       select HAVE_PWM
>         select PXA27x
>
>  config MACH_ZYLONITE
>         bool
> -       select HAVE_PWM
>         select PXA3xx
>
>  config MACH_ZYLONITE300
> @@ -69,7 +66,6 @@ config ARCH_PXA_IDP
>  config ARCH_VIPER
>         bool "Arcom/Eurotech VIPER SBC"
>         select ARCOM_PCMCIA
> -       select HAVE_PWM
>         select I2C_GPIO
>         select ISA
>         select PXA25x
> @@ -120,7 +116,6 @@ config MACH_CM_X300
>         bool "CompuLab CM-X300 modules"
>         select CPU_PXA300
>         select CPU_PXA310
> -       select HAVE_PWM
>         select PXA3xx
>
>  config MACH_CAPC7117
> @@ -211,7 +206,6 @@ config TRIZEPS_PCMCIA
>
>  config MACH_LOGICPD_PXA270
>         bool "LogicPD PXA270 Card Engine Development Platform"
> -       select HAVE_PWM
>         select PXA27x
>
>  config MACH_PCM027
> @@ -222,7 +216,6 @@ config MACH_PCM027
>  config MACH_PCM990_BASEBOARD
>         bool "PHYTEC PCM-990 development board"
>         depends on MACH_PCM027
> -       select HAVE_PWM
>
>  choice
>         prompt "display on pcm990"
> @@ -246,7 +239,6 @@ config MACH_COLIBRI
>  config MACH_COLIBRI_PXA270_INCOME
>         bool "Income s.r.o. PXA270 SBC"
>         depends on MACH_COLIBRI
> -       select HAVE_PWM
>         select PXA27x
>
>  config MACH_COLIBRI300
> @@ -275,7 +267,6 @@ comment "End-user Products (sorted by vendor name)"
>
>  config MACH_H4700
>         bool "HP iPAQ hx4700"
> -       select HAVE_PWM
>         select IWMMXT
>         select PXA27x
>
> @@ -289,14 +280,12 @@ config MACH_HIMALAYA
>
>  config MACH_MAGICIAN
>         bool "Enable HTC Magician Support"
> -       select HAVE_PWM
>         select IWMMXT
>         select PXA27x
>
>  config MACH_MIOA701
>         bool "Mitac Mio A701 Support"
>         select GPIO_SYSFS
> -       select HAVE_PWM
>         select IWMMXT
>         select PXA27x
>         help
> @@ -306,7 +295,6 @@ config MACH_MIOA701
>
>  config PXA_EZX
>         bool "Motorola EZX Platform"
> -       select HAVE_PWM
>         select IWMMXT
>         select PXA27x
>
> @@ -346,7 +334,6 @@ config MACH_MP900C
>
>  config ARCH_PXA_PALM
>         bool "PXA based Palm PDAs"
> -       select HAVE_PWM
>
>  config MACH_PALM27X
>         bool
> @@ -444,7 +431,6 @@ config MACH_TREO680
>  config MACH_RAUMFELD_RC
>         bool "Raumfeld Controller"
>         select CPU_PXA300
> -       select HAVE_PWM
>         select POWER_SUPPLY
>         select PXA3xx
>
> @@ -608,7 +594,6 @@ config MACH_E800
>
>  config MACH_ZIPIT2
>         bool "Zipit Z2 Handheld"
> -       select HAVE_PWM
>         select PXA27x
>  endmenu
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 650de39..ce62af8 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -233,7 +233,6 @@ config MACH_JZ4740
>         select IRQ_CPU
>         select ARCH_REQUIRE_GPIOLIB
>         select SYS_HAS_EARLY_PRINTK
> -       select HAVE_PWM
>         select HAVE_CLK
>         select GENERIC_IRQ_CHIP
>
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 5f4967d..bc6ec8e 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -156,7 +156,7 @@ config INPUT_MAX8925_ONKEY
>
>  config INPUT_MAX8997_HAPTIC
>         tristate "MAXIM MAX8997 haptic controller support"
> -       depends on PWM && HAVE_PWM && MFD_MAX8997
> +       depends on PWM && MFD_MAX8997
>         select INPUT_FF_MEMLESS
>         help
>           This option enables device driver support for the haptic
> controller
> @@ -461,7 +461,7 @@ config INPUT_PCF8574
>
>  config INPUT_PWM_BEEPER
>         tristate "PWM beeper support"
> -       depends on PWM && HAVE_PWM
> +       depends on PWM
>         help
>           Say Y here to get support for PWM based beeper devices.
>
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index f0feafd..4717f54 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -7,7 +7,7 @@
>  struct pwm_device;
>  struct seq_file;
>
> -#if IS_ENABLED(CONFIG_PWM) || IS_ENABLED(CONFIG_HAVE_PWM)
> +#if IS_ENABLED(CONFIG_PWM)
>  /*
>   * pwm_request - request a PWM device
>   */
> --
> 1.8.5.2
>
>

--047d7b5d36029a335204f02f02db
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:courier =
new,monospace;font-size:small">Looks good to me, happy to see it gone.</div=
></div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Thu=
, Jan 16, 2014 at 7:01 AM, Sascha Hauer <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:s.hauer@pengutronix.de" target=3D"_blank">s.hauer@pengutronix.de</a>&g=
t;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Before we had the PWM framework we used to h=
ave a barebone PWM api. The<br>
HAVE_PWM Kconfig symbol used to be selected by the PWM drivers to specify<b=
r>
the PWM API is present in the kernel. Since the last legacy driver is gone<=
br>
the HAVE_PWM symbol can go aswell.<br>
<br>
Signed-off-by: Sascha Hauer &lt;<a href=3D"mailto:s.hauer@pengutronix.de">s=
.hauer@pengutronix.de</a>&gt;<br>
---<br>
<br>
I suggest that Thierry as PWM Maintainer takes the patch through his tree.<=
br>
Is that ok for you Thierry?<br>
<br>
=C2=A0arch/arm/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A04 ----<br=
>
=C2=A0arch/arm/mach-pxa/Kconfig =C2=A0| 15 ---------------<br>
=C2=A0arch/mips/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A01 -<br>
=C2=A0drivers/input/misc/Kconfig | =C2=A04 ++--<br>
=C2=A0include/linux/pwm.h =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A02 +-<br>
=C2=A05 files changed, 3 insertions(+), 23 deletions(-)<br>
<br>
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig<br>
index c1f1a7e..1b6f499 100644<br>
--- a/arch/arm/Kconfig<br>
+++ b/arch/arm/Kconfig<br>
@@ -109,9 +109,6 @@ config ARM_DMA_IOMMU_ALIGNMENT<br>
<br>
=C2=A0endif<br>
<br>
-config HAVE_PWM<br>
- =C2=A0 =C2=A0 =C2=A0 bool<br>
-<br>
=C2=A0config MIGHT_HAVE_PCI<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool<br>
<br>
@@ -606,7 +603,6 @@ config ARCH_LPC32XX<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select CPU_ARM926T<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select GENERIC_CLOCKEVENTS<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select HAVE_IDE<br>
- =C2=A0 =C2=A0 =C2=A0 select HAVE_PWM<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select USB_ARCH_HAS_OHCI<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select USE_OF<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 help<br>
diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig<br>
index 96100db..b96244c 100644<br>
--- a/arch/arm/mach-pxa/Kconfig<br>
+++ b/arch/arm/mach-pxa/Kconfig<br>
@@ -7,7 +7,6 @@ comment &quot;Intel/Marvell Dev Platforms (sorted by hardwa=
re release time)&quot;<br>
=C2=A0config MACH_PXA3XX_DT<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool &quot;Support PXA3xx platforms from device=
 tree&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select CPU_PXA300<br>
- =C2=A0 =C2=A0 =C2=A0 select HAVE_PWM<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select POWER_SUPPLY<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select PXA3xx<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select USE_OF<br>
@@ -23,12 +22,10 @@ config ARCH_LUBBOCK<br>
<br>
=C2=A0config MACH_MAINSTONE<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool &quot;Intel HCDDBBVA0 Development Platform=
 (aka Mainstone)&quot;<br>
- =C2=A0 =C2=A0 =C2=A0 select HAVE_PWM<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select PXA27x<br>
<br>
=C2=A0config MACH_ZYLONITE<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool<br>
- =C2=A0 =C2=A0 =C2=A0 select HAVE_PWM<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select PXA3xx<br>
<br>
=C2=A0config MACH_ZYLONITE300<br>
@@ -69,7 +66,6 @@ config ARCH_PXA_IDP<br>
=C2=A0config ARCH_VIPER<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool &quot;Arcom/Eurotech VIPER SBC&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select ARCOM_PCMCIA<br>
- =C2=A0 =C2=A0 =C2=A0 select HAVE_PWM<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select I2C_GPIO<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select ISA<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select PXA25x<br>
@@ -120,7 +116,6 @@ config MACH_CM_X300<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool &quot;CompuLab CM-X300 modules&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select CPU_PXA300<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select CPU_PXA310<br>
- =C2=A0 =C2=A0 =C2=A0 select HAVE_PWM<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select PXA3xx<br>
<br>
=C2=A0config MACH_CAPC7117<br>
@@ -211,7 +206,6 @@ config TRIZEPS_PCMCIA<br>
<br>
=C2=A0config MACH_LOGICPD_PXA270<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool &quot;LogicPD PXA270 Card Engine Developme=
nt Platform&quot;<br>
- =C2=A0 =C2=A0 =C2=A0 select HAVE_PWM<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select PXA27x<br>
<br>
=C2=A0config MACH_PCM027<br>
@@ -222,7 +216,6 @@ config MACH_PCM027<br>
=C2=A0config MACH_PCM990_BASEBOARD<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool &quot;PHYTEC PCM-990 development board&quo=
t;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 depends on MACH_PCM027<br>
- =C2=A0 =C2=A0 =C2=A0 select HAVE_PWM<br>
<br>
=C2=A0choice<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 prompt &quot;display on pcm990&quot;<br>
@@ -246,7 +239,6 @@ config MACH_COLIBRI<br>
=C2=A0config MACH_COLIBRI_PXA270_INCOME<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool &quot;Income s.r.o. PXA270 SBC&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 depends on MACH_COLIBRI<br>
- =C2=A0 =C2=A0 =C2=A0 select HAVE_PWM<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select PXA27x<br>
<br>
=C2=A0config MACH_COLIBRI300<br>
@@ -275,7 +267,6 @@ comment &quot;End-user Products (sorted by vendor name)=
&quot;<br>
<br>
=C2=A0config MACH_H4700<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool &quot;HP iPAQ hx4700&quot;<br>
- =C2=A0 =C2=A0 =C2=A0 select HAVE_PWM<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select IWMMXT<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select PXA27x<br>
<br>
@@ -289,14 +280,12 @@ config MACH_HIMALAYA<br>
<br>
=C2=A0config MACH_MAGICIAN<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool &quot;Enable HTC Magician Support&quot;<br=
>
- =C2=A0 =C2=A0 =C2=A0 select HAVE_PWM<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select IWMMXT<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select PXA27x<br>
<br>
=C2=A0config MACH_MIOA701<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool &quot;Mitac Mio A701 Support&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select GPIO_SYSFS<br>
- =C2=A0 =C2=A0 =C2=A0 select HAVE_PWM<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select IWMMXT<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select PXA27x<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 help<br>
@@ -306,7 +295,6 @@ config MACH_MIOA701<br>
<br>
=C2=A0config PXA_EZX<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool &quot;Motorola EZX Platform&quot;<br>
- =C2=A0 =C2=A0 =C2=A0 select HAVE_PWM<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select IWMMXT<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select PXA27x<br>
<br>
@@ -346,7 +334,6 @@ config MACH_MP900C<br>
<br>
=C2=A0config ARCH_PXA_PALM<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool &quot;PXA based Palm PDAs&quot;<br>
- =C2=A0 =C2=A0 =C2=A0 select HAVE_PWM<br>
<br>
=C2=A0config MACH_PALM27X<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool<br>
@@ -444,7 +431,6 @@ config MACH_TREO680<br>
=C2=A0config MACH_RAUMFELD_RC<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool &quot;Raumfeld Controller&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select CPU_PXA300<br>
- =C2=A0 =C2=A0 =C2=A0 select HAVE_PWM<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select POWER_SUPPLY<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select PXA3xx<br>
<br>
@@ -608,7 +594,6 @@ config MACH_E800<br>
<br>
=C2=A0config MACH_ZIPIT2<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool &quot;Zipit Z2 Handheld&quot;<br>
- =C2=A0 =C2=A0 =C2=A0 select HAVE_PWM<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select PXA27x<br>
=C2=A0endmenu<br>
<br>
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig<br>
index 650de39..ce62af8 100644<br>
--- a/arch/mips/Kconfig<br>
+++ b/arch/mips/Kconfig<br>
@@ -233,7 +233,6 @@ config MACH_JZ4740<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select IRQ_CPU<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select ARCH_REQUIRE_GPIOLIB<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select SYS_HAS_EARLY_PRINTK<br>
- =C2=A0 =C2=A0 =C2=A0 select HAVE_PWM<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select HAVE_CLK<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select GENERIC_IRQ_CHIP<br>
<br>
diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig<br>
index 5f4967d..bc6ec8e 100644<br>
--- a/drivers/input/misc/Kconfig<br>
+++ b/drivers/input/misc/Kconfig<br>
@@ -156,7 +156,7 @@ config INPUT_MAX8925_ONKEY<br>
<br>
=C2=A0config INPUT_MAX8997_HAPTIC<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tristate &quot;MAXIM MAX8997 haptic controller =
support&quot;<br>
- =C2=A0 =C2=A0 =C2=A0 depends on PWM &amp;&amp; HAVE_PWM &amp;&amp; MFD_MA=
X8997<br>
+ =C2=A0 =C2=A0 =C2=A0 depends on PWM &amp;&amp; MFD_MAX8997<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select INPUT_FF_MEMLESS<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 help<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 This option enables device driver suppor=
t for the haptic controller<br>
@@ -461,7 +461,7 @@ config INPUT_PCF8574<br>
<br>
=C2=A0config INPUT_PWM_BEEPER<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tristate &quot;PWM beeper support&quot;<br>
- =C2=A0 =C2=A0 =C2=A0 depends on PWM &amp;&amp; HAVE_PWM<br>
+ =C2=A0 =C2=A0 =C2=A0 depends on PWM<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 help<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Say Y here to get support for PWM based =
beeper devices.<br>
<br>
diff --git a/include/linux/pwm.h b/include/linux/pwm.h<br>
index f0feafd..4717f54 100644<br>
--- a/include/linux/pwm.h<br>
+++ b/include/linux/pwm.h<br>
@@ -7,7 +7,7 @@<br>
=C2=A0struct pwm_device;<br>
=C2=A0struct seq_file;<br>
<br>
-#if IS_ENABLED(CONFIG_PWM) || IS_ENABLED(CONFIG_HAVE_PWM)<br>
+#if IS_ENABLED(CONFIG_PWM)<br>
=C2=A0/*<br>
=C2=A0 * pwm_request - request a PWM device<br>
=C2=A0 */<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.8.5.2<br>
<br>
</font></span></blockquote></div><br></div>

--047d7b5d36029a335204f02f02db--
