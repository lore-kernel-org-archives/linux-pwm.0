From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 01/11] mfd: add atmel-hlcdc driver
Date: Wed, 9 Jul 2014 16:48:03 +0100
Message-ID: <20140709154803.GL2635@lee--X1>
References: <1404744671-1629-1-git-send-email-boris.brezillon@free-electrons.com>
 <1404744671-1629-2-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:59810 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755893AbaGIPsL (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Jul 2014 11:48:11 -0400
Received: by mail-ie0-f174.google.com with SMTP id rd18so6175915iec.5
        for <linux-pwm@vger.kernel.org>; Wed, 09 Jul 2014 08:48:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1404744671-1629-2-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris BREZILLON <boris.brezillon@free-electrons.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andrew Victor <linux@maxim.org.za>, Jean-Jacques Hiblot <jjhiblot@traphandler.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

On Mon, 07 Jul 2014, Boris BREZILLON wrote:

> The HLCDC IP available on some Atmel SoCs (i.e. at91sam9n12, at91sam9=
x5
> family or sama5d3 family) exposes 2 subdevices:
> - a display controller (controlled by a DRM driver)
> - a PWM chip
>=20
> The MFD device provides a regmap and several clocks (those connected
> to this hardware block) to its subdevices.
>=20
> This way concurrent accesses to the iomem range are handled by the re=
gmap
> framework, and each subdevice can safely access HLCDC registers.
>=20
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> ---
>  drivers/mfd/Kconfig             |  12 ++++
>  drivers/mfd/Makefile            |   1 +
>  drivers/mfd/atmel-hlcdc.c       | 119 ++++++++++++++++++++++++++++++=
++++++++++
>  include/linux/mfd/atmel-hlcdc.h |  78 ++++++++++++++++++++++++++
>  4 files changed, 210 insertions(+)
>  create mode 100644 drivers/mfd/atmel-hlcdc.c
>  create mode 100644 include/linux/mfd/atmel-hlcdc.h

[...]

> +static const struct mfd_cell atmel_hlcdc_cells[] =3D {
> +	{
> +		.name =3D "atmel-hlcdc-pwm",
> +		.of_compatible =3D "atmel,hlcdc-pwm",
> +	},
> +	{
> +		.name =3D "atmel-hlcdc-dc",
> +		.of_compatible =3D "atmel,hlcdc-dc",

'dc' is a little ambiguous.

Would be more transparent if s/dc/disp or similar.

> +	},
> +};

[...]

> +static struct platform_driver atmel_hlcdc_driver =3D {
> +	.probe =3D atmel_hlcdc_probe,
> +	.remove =3D atmel_hlcdc_remove,
> +	.driver =3D {
> +		.name =3D "atmel-hlcdc",
> +		.owner =3D THIS_MODULE,

Remove this line, it's not required.

> +		.of_match_table =3D atmel_hlcdc_match,
> +	},
> +};
> +module_platform_driver(atmel_hlcdc_driver);

Once those minor points are addressed, resubmit with my:

Acked-by: Lee Jones <lee.jones@linaro.org>

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
