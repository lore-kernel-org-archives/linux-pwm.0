From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Subject: Re: [PATCH v6 0/4] Initial support for ImgTec PWM DAC and PDM DAC
Date: Fri, 5 Dec 2014 08:52:41 -0300
Message-ID: <54819C89.1000508@imgtec.com>
References: <1417198345-19633-1-git-send-email-Naidu.Tellapati@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:10527 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266AbaLELyb (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 5 Dec 2014 06:54:31 -0500
In-Reply-To: <1417198345-19633-1-git-send-email-Naidu.Tellapati@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Naidu Tellapati <naidu.tellapati@gmail.com>, thierry.reding@gmail.com, abrestic@chromium.org, gregkh@linuxfoundation.org, arnd@arndb.de, James.Hartley@imgtec.com
Cc: devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, Arul.Ramasamy@imgtec.com, Sai.Masarapu@imgtec.com

Hi Thierry,

On 11/28/2014 03:12 PM, Naidu Tellapati wrote:
> The Pistachio SOC from Imagination Technologies includes =E2=80=93 4x=
 PDM blocks
> and 1x =E2=80=9Cbasic PWM=E2=80=9D block with four output channels. T=
hese share 4 MFIO pins,
> each PWM channel being muxed with each PDM block output (0-3 muxed wi=
th 0-3)
> using the CR_PERIP_PWM_PDM_CONTROL register in the peripheral wrapper
> register bank (offset 0x140). The PDM and PWM outputs are used to con=
trol
> targets such as LCD backlight.
>=20
> The PWM driver uses Linux PWM framework. Since the PDM does not fit i=
nto PWM
> framework we have implemented it as a MISC driver.
>=20
> The series is based on v3.18-rc5.
>=20
> Changes from v5:
>=20
>  * Used syscon for accessing PWM & PDM control register.
>=20
> Changes from v4:
>=20
>  * Removed CR_prefix from the defined macros.
>=20
>  * Folded same data type varibles in one line.
>=20
>  * Removed cr-periph property from PWM DT binding document.
>=20
>  * Removed regmap_update_bits from img_pwm_enable and img_pwm_disable=
 functions.
>=20
>  * Addressed few more comments given in v4.
>=20
> Changes from v3:
>=20
>  * Addressed couple of comments given in v3.
>=20
> Changes from v2:
>=20
>  * Added depends on MIPS || COMPILE_TEST.
>=20
>  * Corrected the logic while calculating time base steps.
>=20
>  * Addressed few other minor comments given in v2.
>=20
> Changes from v1:
>=20
>  * Used regmap_update_bits at some places in the driver.
>=20
>  * Placed some #defines next to their register.
>=20
>  * Added depends on HAS_IOMEM in Kconfig.
>=20
>  * Removed unnecessary paragraph from file header.
>=20
>  * Defined register masks in a readable way.
>=20
>  * Renamed clk-names with clock-names.
>=20
>  * Added system interface clock in DT binding document.
>=20
>  * Addressed few other minor review comments given in v1.
>=20
> Naidu Tellapati (4):
>   pwm: Imagination Technologies PWM DAC driver
>   DT: pwm: Add binding document for IMG PWM DAC
>   pdm: Imagination Technologies PDM DAC driver
>   DT: pdm: Add binding document for IMG PDM DAC
>=20

Any comments on this series? I was aiming at merging this for v3.19,
hope it's not too late already!

Thanks,
--=20
Ezequiel
