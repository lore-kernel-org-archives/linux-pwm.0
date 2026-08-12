Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2127.outbound.protection.partner.outlook.cn [139.219.17.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AB6336EC5;
	Wed, 12 Aug 2026 09:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786525673; cv=fail; b=NzHh9kpQnYqcAoOjpM85mdIZJL3VmmMfmTJC+pQ5i86IUF7EgxelFiGEQ2oehR5gJ5r7NbmvmEjS9v7eNwM9I6D4aExSCTdf2aZyJwHBG+UpEamTq9O9USkKIpwxIzi2O/QT0TiOLF1UY1jz2K4yx3Ng7GqcfJhCQVV1qPMDQWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786525673; c=relaxed/simple;
	bh=C/jlVJe+8MmHPdHIc/doHEED/LZDsLOQtTAUHLNz1rA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m1b2XtYNIA8Vq54RquH47pmMIplhYLx5dfvKa83cVv/ADgJv+ft31Xh17QxWEQ873zwZcWPhYSx3wcaxZDcwKbBzue37ffYJH59MCOEIk9+PAxZmisFg3Lz+PREvD1jSWwTSkhsW+7kk7lk1KbhyafyaPTrX/QlRlU+fqbVlP7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YKWt4XEuTgDNRHir13hXt6P6lVLRge1sl3izM32CW1KVYOptNVinNSahfEjjxG9syg/UpCRIY2nHiyb/NwjwIKNG4P71sKaVfVW3t/XTh1f0oUeHXMA25LOVbeFSuNIBNB15OFTc6o5QUl56gKlChzcInUFvlRkjLXJ/atSoq7dVb0oUdY5IuP2h3U8N/NxfJUKaRAy9aJBtVj1kUh/8gEpKs14thynfmIuF3WLlIDL6hyaJZIC4rKo7O6u4MPtZ6+1jnA1e9R0N/vRnN3pN4i3aOVdWunW+nbvhMJ3vNp2EekwCTNBDPtt297X6DXXIpOeLL0aNI9TW4p0aIbq5oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyUNcjea0q79791ffeAx9Bj9IzUh4wLeLu5OSRwLdU8=;
 b=IAshwJ/aurRuBDYAy4ze1Audm/+e+nWOaDfKyQHy8PIYtlYw0fc/3gWQvVYR4TT4HnPTaO27YTDMMzk89LDsWIeIr/3tDlo7znHLYaoOmx2DoWJLHEGl/yD7caONGn+6Hgi++vyGHIGWiIaaEVqUgXmkQ4LADAthUH+wvpK2sb/OEx6XplQIijGiEF/pcV9FaVGfIND8jM4qrf5zW5m77Ow5U3JjkrdqY/seUTARnNorwcom/jKuj/xXqJGVYpVXSKqYKJ9/aVqEGP9cqMH+d7VFyaOtQve2wVXhG24iiqRupsdSHt0X+eERI9oNgWxkkzC/UL2h/It/IYOkeIFtTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1164.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 08:52:46 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::4386:5cc4:3bc4:4795]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::4386:5cc4:3bc4:4795%3])
 with mapi id 15.21.0315.011; Wed, 12 Aug 2026 08:52:46 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor@kernel.org>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>
CC: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RESEND v22 3/3] pwm: Add OpenCores PTC PWM driver
Thread-Topic: [RESEND v22 3/3] pwm: Add OpenCores PTC PWM driver
Thread-Index: AQHdKHVeZ/QSgcowYkWuKAxDcHEeFLaaHOLg
Date: Wed, 12 Aug 2026 08:52:46 +0000
Message-ID:
 <ZQ2PR01MB130705520872CE417DC5B261E6DC2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20260810030714.48100-1-hal.feng@starfivetech.com>
 <20260810030714.48100-4-hal.feng@starfivetech.com>
In-Reply-To: <20260810030714.48100-4-hal.feng@starfivetech.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-Mentions: ukleinek@kernel.org
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1164:EE_
x-ms-office365-filtering-correlation-id: 813bd83e-1f9f-4c6b-764f-08def84f14bc
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|13003099007|22082099003|18002099003|38070700021|4143699003|56012099006|10067099003|3023799007;
x-microsoft-antispam-message-info:
 pLTHrWIRBosHa0zx/ojLX3xyggspF/wl8wL2gt2Wr8WKd/IucN0ziBZpBv3ncYDewShLgLv82rELPyROyOR2RGZuSXvejWuGP/QlPR47COWk9kU5DvH4fYVOGQFc5s6rMdCI3yFdQOZi6IGJIyjPT+7kiQtNb/IRwmJLdJ9s33uLj6GP8bfvCeL7x1J346WdjT29Rqo9YYCPSID247H5PdVxXBP+6I/w2StcFGbFmj6yccbBfcyzZtheJDJs2YOwbj5ZXFGdxDeLjdn4Th1mVAM2Hn1ZeExOeQaHb3qzZveU4wESLS6QrptpatkAOQoDjP0e38rwDv0rotaRXt4YFrlb6Bk6mANI+hyVSdKb0vGgFZdXTde+D65UsNybS2848euSdCRAfeYfU4k8wMMNdFBaUuLy3bZRoxQ6n97vCl+5ose+8fipNGfOPLv612czCRoUQ6Kpq6cX0ijEdXn0lP/GFUUNRijeMQb/ZSlOAkusg495DYyhOOsn2rNVhCjInSD8ka3uk4s6mCa3S4HRDSplcZoX1NzcxGeUAneI8PQC919MJb0tWap0YJ1RYinf
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(13003099007)(22082099003)(18002099003)(38070700021)(4143699003)(56012099006)(10067099003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?CUbhCyrtnJv9bQr/xVDzGBs8TSKbCUaPqo65x8QFNQFXQQsFWvA+Md/Mg/?=
 =?iso-8859-1?Q?ECmxaxVpP/wNr3LDXVlWJxpYJ2NDfZkfg6X4YHDj6z+nJlCfRIHrhKBuD0?=
 =?iso-8859-1?Q?RI11TEpZ2s2WOlFrLErYcjCpQR/+0hAStpGGWG1LvOQJ4RTV2SXURpoMpz?=
 =?iso-8859-1?Q?WLQEo4ZZX+bPd/tndp5tr3Kqi4E9nSI0OcSgYbSK1GKeEK8jWPLx4/O9IP?=
 =?iso-8859-1?Q?8G6ROt9epF9QUv1qsXWkQPldP1CWtKMGRVa+KP9rduW3R1g2l7pPi02Bsg?=
 =?iso-8859-1?Q?A19tzlxzB0eU3YdxwTEKmzgGIqjChiTVs1vDSHvLhS8bYgAOeRoW2Eufpf?=
 =?iso-8859-1?Q?9Ag0miIKIL+UV/uVINenlrUIugPUyYElI6EfnWFBHmyBBLMZxVHAM+Z4pm?=
 =?iso-8859-1?Q?Z+6cNYkXBLNXs56tMPSeC5kNAYr1T2D3qKq9ShHnrdBx2XYdxcshhI6Faf?=
 =?iso-8859-1?Q?1Vf3QCQzKjhNTq9wmwbA2i1Yu4gJTssLg/TraPfKATdltgCJgXCkBcWBm3?=
 =?iso-8859-1?Q?rQ4eX4iDP6rL9OxTCsT3Js+2avG+XwNs6VeC3we9fzFExomBJxzRgPgrCc?=
 =?iso-8859-1?Q?xLp3hvBByDZzRmGb4sm/xjZ/7PAEOmSEdM1xdittCj+gmxXx/3TP+kMOrq?=
 =?iso-8859-1?Q?Jdb+YeeHLoYLFuWpzakrjNxPe8fpRG6BCRzNZapAdwRP2bQwwQ6oDwnWN2?=
 =?iso-8859-1?Q?Ij3/APIycDSvIlH0TJxA2WZuxTo3fh06IzyU5pS5UfpY4xbJzPgRSxrCwF?=
 =?iso-8859-1?Q?3JxmwgnE6QiCN4eldYCimOTdDNfUpo+FA6azO8D6ZRmudZVAwr6bMd1/QU?=
 =?iso-8859-1?Q?ivmwW3SoFIjiQjr8o/PAY3K1pnHL3scPwp55QK2iNg0rYDbigyzMiYM777?=
 =?iso-8859-1?Q?Z1EPXe/MQz9J4XiOmaPIHqdyoo9CQpgwc+cJzPXUF2bRB0xIL3//52gOBb?=
 =?iso-8859-1?Q?vd6dI9ZN8+Kjf6hm5scw+3JsZG+hwE4wkD+C6xCEs9G92+tT6S/487diaC?=
 =?iso-8859-1?Q?q8aSvzJNGLGAhJJJtxl/ztSYV6R1WT+U70R4xEqajW1Viu8o227yKN1/os?=
 =?iso-8859-1?Q?IB4v0gqvRJSbMiLYrGD9E/iAzB7JwM1aXiupCu9UXmGJpByin2Jl8TXDNQ?=
 =?iso-8859-1?Q?9cAuCK8aAU87qIfLSfutblZmrdjyUsEN7S9f5fa7kWV8IvEl+5wRoNJBiB?=
 =?iso-8859-1?Q?jDtZVYvFevleg5YEN1FugSPkZQjDzj2Xygnw4rutcvgjnRZ5dnXtbXUAYf?=
 =?iso-8859-1?Q?rrmITCPkAdnSKRdtDU3PEFOxvgatYXTB/r9L5Pjy7B7oMlyJ6hAlqsPze2?=
 =?iso-8859-1?Q?FyAWgNk5NSB8sCy/OIIAE7QqsgigoSwLhfbBgC2jym7n2rkUyOWuFnVFal?=
 =?iso-8859-1?Q?ND2ZnHEsCd1dj33GI//VLfhHZUUumH9s2SrhTTKmH2bcLVY8eVgqQX9fTc?=
 =?iso-8859-1?Q?+KOY74rh/1BC/r6RaAZ41oOPt9DTnh1TFHU/Fjj+IBYs3pbvpWuLKSYZ38?=
 =?iso-8859-1?Q?La5ftsk/TSTitbDq5lNSQ+LPOKq6jQxTnJdWv1RprkHb0znA06XEoZ+ZKY?=
 =?iso-8859-1?Q?0sqwSKVLpQVm7TG6nc3lZtoQKTNRKXrfQlKTZVL+A5UO7wos2369hSvnEN?=
 =?iso-8859-1?Q?TjybG4W5H/pcfmiJDWo5HSpO8By2JVySSUpFj0Qnr8XEFrC8Nl+dKOr9ET?=
 =?iso-8859-1?Q?JnhqJA7i5P8Chq0XFUXFRthQ7T4sAA3AUfuANcIr+hyloIPrph+tlFhHF2?=
 =?iso-8859-1?Q?3bIGwp1IPkYXAkFe0EVOUzW206mFdvUXQTTeONi/YQf2G6xH1crtNibtkT?=
 =?iso-8859-1?Q?askXaO1chA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 813bd83e-1f9f-4c6b-764f-08def84f14bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 08:52:46.6920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2LbNYTbh4mCc7w7Mw1ZqkyFETxwyWeKwx0qIDc3pdQBMrzsCx3lxnaFHE+UlAwl5qtYX1ZywDoLWaf/sEZEstvz76GChM2oWXaOrE2TnqUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1164

> On 26.08.10 11:07, Hal Feng wrote:
>=20
> Add PWM driver for OpenCores PTC IP core.
>=20
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>

Hi, Uwe,

As all AI comments have been addressed, could you please help review this s=
eries? @Uwe Kleine-K=F6nig

Best regards,
Hal

> ---
>  MAINTAINERS              |   6 +
>  drivers/pwm/Kconfig      |  12 ++
>  drivers/pwm/Makefile     |   1 +
>  drivers/pwm/pwm-ocores.c | 298
> +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 317 insertions(+)
>  create mode 100644 drivers/pwm/pwm-ocores.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8014b9f8253e..7886fd9a4ac0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20273,6 +20273,12 @@ F:	Documentation/i2c/busses/i2c-ocores.rst
>  F:	drivers/i2c/busses/i2c-ocores.c
>  F:	include/linux/platform_data/i2c-ocores.h
>=20
> +OPENCORES PWM DRIVER
> +M:	Hal Feng <hal.feng@starfivetech.com>
> +S:	Supported
> +F:	Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
> +F:	drivers/pwm/pwm-ocores.c
> +
>  OPENRISC ARCHITECTURE
>  M:	Jonas Bonn <jonas@southpole.se>
>  M:	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig index
> e8886a9b64d9..1268c07d07f1 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -546,6 +546,18 @@ config PWM_NTXEC
>  	  controller found in certain e-book readers designed by the original
>  	  design manufacturer Netronix.
>=20
> +config PWM_OCORES
> +	tristate "OpenCores PTC PWM support"
> +	depends on HAS_IOMEM && OF
> +	depends on COMMON_CLK
> +	depends on ARCH_STARFIVE || COMPILE_TEST
> +	help
> +	  PWM driver for OpenCores PTC IP core.
> +	  For details see https://opencores.org/projects/ptc.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-ocores.
> +
>  config PWM_OMAP_DMTIMER
>  	tristate "OMAP Dual-Mode Timer PWM support"
>  	depends on OF
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile index
> 5630a521a7cf..4d2d14c4852f 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -48,6 +48,7 @@ obj-$(CONFIG_PWM_MICROCHIP_CORE)	+=3D
> pwm-microchip-core.o
>  obj-$(CONFIG_PWM_MTK_DISP)	+=3D pwm-mtk-disp.o
>  obj-$(CONFIG_PWM_MXS)		+=3D pwm-mxs.o
>  obj-$(CONFIG_PWM_NTXEC)		+=3D pwm-ntxec.o
> +obj-$(CONFIG_PWM_OCORES)	+=3D pwm-ocores.o
>  obj-$(CONFIG_PWM_OMAP_DMTIMER)	+=3D pwm-omap-dmtimer.o
>  obj-$(CONFIG_PWM_PCA9685)	+=3D pwm-pca9685.o
>  obj-$(CONFIG_PWM_PXA)		+=3D pwm-pxa.o
> diff --git a/drivers/pwm/pwm-ocores.c b/drivers/pwm/pwm-ocores.c new
> file mode 100644 index 000000000000..f873089a385b
> --- /dev/null
> +++ b/drivers/pwm/pwm-ocores.c
> @@ -0,0 +1,298 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * OpenCores PTC PWM Driver
> + *
> + * https://opencores.org/projects/ptc
> + *
> + * Copyright (C) 2018-2026 StarFive Technology Co., Ltd.
> + *
> + * Limitations:
> + * - The hardware only supports inverted polarity.
> + * - The hardware minimum period / non-zero duty_cycle is (1 / pwm_apb
> clock frequency).
> + * - The hardware maximum period / duty_cycle of PWM is (U32_MAX /
> pwm_apb clock frequency).
> + * - The output is immediately set to low when the module is disabled.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pwm.h>
> +#include <linux/reset.h>
> +
> +#define OCPWM_HRC	0x4
> +#define OCPWM_LRC	0x8
> +#define OCPWM_CTRL	0xC
> +
> +#define OCPWM_CTRL_EN	BIT(0)
> +#define OCPWM_CTRL_OE	BIT(3)
> +#define OCPWM_CTRL_RST	BIT(7)
> +
> +#define OCPWM_NUM_SAVED_REGS	3
> +
> +struct ocores_pwm_device {
> +	void __iomem *base;
> +	struct clk *clk;
> +	unsigned long clk_rate;
> +	struct reset_control *rst;
> +	u32 saved_regs[OCPWM_NUM_SAVED_REGS];
> +};
> +
> +static int ocores_pwm_get_state(struct pwm_chip *chip,
> +				struct pwm_device *pwm,
> +				struct pwm_state *state)
> +{
> +	struct ocores_pwm_device *ddata =3D pwmchip_get_drvdata(chip);
> +	u32 period_data, duty_data, ctrl_data;
> +	int ret;
> +
> +	ret =3D pm_runtime_resume_and_get(pwmchip_parent(chip));
> +	if (ret < 0)
> +		return ret;
> +
> +	period_data =3D readl(ddata->base + OCPWM_LRC);
> +	duty_data =3D readl(ddata->base + OCPWM_HRC);
> +	ctrl_data =3D readl(ddata->base + OCPWM_CTRL);
> +
> +	state->period =3D DIV_ROUND_UP_ULL((u64)period_data * NSEC_PER_SEC,
> ddata->clk_rate);
> +	state->duty_cycle =3D DIV_ROUND_UP_ULL((u64)duty_data *
> NSEC_PER_SEC, ddata->clk_rate);
> +	if (state->duty_cycle > state->period)
> +		state->duty_cycle =3D state->period;
> +
> +	state->polarity =3D PWM_POLARITY_INVERSED;
> +	state->enabled =3D (ctrl_data & OCPWM_CTRL_EN) ? true : false;
> +
> +	pm_runtime_put(pwmchip_parent(chip));
> +
> +	return 0;
> +}
> +
> +static int ocores_pwm_apply(struct pwm_chip *chip,
> +			    struct pwm_device *pwm,
> +			    const struct pwm_state *state)
> +{
> +	struct ocores_pwm_device *ddata =3D pwmchip_get_drvdata(chip);
> +	bool was_enabled =3D pwm_is_enabled(pwm);
> +	u64 period_data, duty_data;
> +	int ret;
> +
> +	if (state->polarity !=3D PWM_POLARITY_INVERSED)
> +		return -EINVAL;
> +
> +	if (!state->enabled) {
> +		if (was_enabled) {
> +			writel(0, ddata->base + OCPWM_CTRL);
> +			pm_runtime_put(pwmchip_parent(chip));
> +		}
> +		return 0;
> +	}
> +
> +	period_data =3D mul_u64_u32_div(state->period, ddata->clk_rate,
> NSEC_PER_SEC);
> +	if (period_data > U32_MAX)
> +		period_data =3D U32_MAX;
> +
> +	duty_data =3D mul_u64_u32_div(state->duty_cycle, ddata->clk_rate,
> NSEC_PER_SEC);
> +	if (duty_data > U32_MAX)
> +		duty_data =3D U32_MAX;
> +
> +	if (!period_data)
> +		return -EINVAL;
> +
> +	if (!was_enabled) {
> +		ret =3D pm_runtime_resume_and_get(pwmchip_parent(chip));
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	writel(0, ddata->base + OCPWM_CTRL);
> +	writel(OCPWM_CTRL_RST, ddata->base + OCPWM_CTRL);
> +
> +	writel(period_data, ddata->base + OCPWM_LRC);
> +	writel(duty_data, ddata->base + OCPWM_HRC);
> +	writel(OCPWM_CTRL_OE | OCPWM_CTRL_EN, ddata->base +
> OCPWM_CTRL);
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops ocores_pwm_ops =3D {
> +	.get_state =3D ocores_pwm_get_state,
> +	.apply =3D ocores_pwm_apply,
> +};
> +
> +static int ocores_pwm_runtime_suspend(struct device *dev) {
> +	struct ocores_pwm_device *ddata =3D dev_get_drvdata(dev);
> +
> +	clk_disable_unprepare(ddata->clk);
> +
> +	return 0;
> +}
> +
> +static int ocores_pwm_runtime_resume(struct device *dev) {
> +	struct ocores_pwm_device *ddata =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret =3D clk_prepare_enable(ddata->clk);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable clock\n");
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused ocores_pwm_suspend(struct device *dev) {
> +	struct ocores_pwm_device *ddata =3D dev_get_drvdata(dev);
> +	int ret, i;
> +
> +	ret =3D pm_runtime_resume_and_get(dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	for (i =3D 0; i < OCPWM_NUM_SAVED_REGS; i++)
> +		ddata->saved_regs[i] =3D readl(ddata->base + 4 + 4 * i);
> +
> +	pm_runtime_put_sync(dev);
> +
> +	return pm_runtime_force_suspend(dev);
> +}
> +
> +static int __maybe_unused ocores_pwm_resume(struct device *dev) {
> +	struct ocores_pwm_device *ddata =3D dev_get_drvdata(dev);
> +	int ret, i;
> +
> +	ret =3D pm_runtime_force_resume(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D pm_runtime_resume_and_get(dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	writel(0, ddata->base + OCPWM_CTRL);
> +	writel(OCPWM_CTRL_RST, ddata->base + OCPWM_CTRL);
> +	for (i =3D 0; i < OCPWM_NUM_SAVED_REGS; i++)
> +		writel(ddata->saved_regs[i], ddata->base + 4 + 4 * i);
> +
> +	pm_runtime_put_sync(dev);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops ocores_pwm_pm_ops =3D {
> +	RUNTIME_PM_OPS(ocores_pwm_runtime_suspend,
> +		       ocores_pwm_runtime_resume, NULL)
> +	SYSTEM_SLEEP_PM_OPS(ocores_pwm_suspend,
> ocores_pwm_resume) };
> +
> +static void ocores_pwm_pm_disable(void *data) {
> +	struct device *dev =3D data;
> +	struct ocores_pwm_device *ddata =3D dev_get_drvdata(dev);
> +
> +	pm_runtime_disable(dev);
> +
> +	if (!pm_runtime_status_suspended(dev)) {
> +		/* Balance the reference held while the PWM is enabled. */
> +		if (readl(ddata->base + OCPWM_CTRL) & OCPWM_CTRL_EN)
> +			pm_runtime_put_noidle(dev);
> +
> +		ocores_pwm_runtime_suspend(dev);
> +	}
> +
> +	reset_control_assert(ddata->rst);
> +}
> +
> +static int ocores_pwm_probe(struct platform_device *pdev) {
> +	struct device *dev =3D &pdev->dev;
> +	struct ocores_pwm_device *ddata;
> +	struct pwm_chip *chip;
> +	int ret;
> +
> +	chip =3D devm_pwmchip_alloc(dev, 1, sizeof(*ddata));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +
> +	chip->ops =3D &ocores_pwm_ops;
> +	ddata =3D pwmchip_get_drvdata(chip);
> +
> +	ddata->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(ddata->base))
> +		return dev_err_probe(dev, PTR_ERR(ddata->base),
> +				     "Failed to map IO resources\n");
> +
> +	ddata->clk =3D devm_clk_get(dev, NULL);
> +	if (IS_ERR(ddata->clk))
> +		return dev_err_probe(dev, PTR_ERR(ddata->clk),
> +				     "Failed to get clock\n");
> +
> +	ddata->clk_rate =3D clk_get_rate(ddata->clk);
> +	if (!ddata->clk_rate || ddata->clk_rate > NSEC_PER_SEC)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid clock rate: %lu\n", ddata->clk_rate);
> +
> +	ddata->rst =3D devm_reset_control_get_optional_shared(dev, NULL);
> +	if (IS_ERR(ddata->rst))
> +		return dev_err_probe(dev, PTR_ERR(ddata->rst),
> +				     "Failed to get reset\n");
> +
> +	platform_set_drvdata(pdev, ddata);
> +
> +	ret =3D ocores_pwm_runtime_resume(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D reset_control_deassert(ddata->rst);
> +	if (ret)
> +		goto err_clk_disable;
> +
> +	ret =3D pm_runtime_set_active(dev);
> +	if (ret)
> +		goto err_reset_assert;
> +
> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_enable(dev);
> +
> +	if (!(readl(ddata->base + OCPWM_CTRL) & OCPWM_CTRL_EN))
> +		pm_runtime_put_sync(dev);
> +
> +	ret =3D devm_add_action_or_reset(dev, ocores_pwm_pm_disable, dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to add pm disable action\n");
> +
> +	ret =3D devm_pwmchip_add(dev, chip);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Could not register PWM chip\n");
> +
> +	return 0;
> +
> +err_reset_assert:
> +	reset_control_assert(ddata->rst);
> +err_clk_disable:
> +	ocores_pwm_runtime_suspend(dev);
> +	return dev_err_probe(dev, ret, "Failed to init pwm power\n"); }
> +
> +static const struct of_device_id ocores_pwm_of_match[] =3D {
> +	{ .compatible =3D "opencores,pwm-v1" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, ocores_pwm_of_match);
> +
> +static struct platform_driver ocores_pwm_driver =3D {
> +	.probe =3D ocores_pwm_probe,
> +	.driver =3D {
> +		.name =3D "ocores-pwm",
> +		.of_match_table =3D ocores_pwm_of_match,
> +		.pm =3D pm_ptr(&ocores_pwm_pm_ops),
> +	},
> +};
> +module_platform_driver(ocores_pwm_driver);
> +
> +MODULE_AUTHOR("Jieqin Chen");
> +MODULE_AUTHOR("Hal Feng <hal.feng@starfivetech.com>");
> +MODULE_DESCRIPTION("OpenCores PTC PWM driver");
> MODULE_LICENSE("GPL");
> --
> 2.43.2

