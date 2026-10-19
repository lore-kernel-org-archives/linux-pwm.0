Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2108.outbound.protection.partner.outlook.cn [139.219.146.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B03C455627;
	Mon, 19 Oct 2026 06:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792390630; cv=fail; b=d0/sX/uVkhGXLp9iCJZVRYrl6y663q3UV1rYKekWr7y2dYPsezTMT3gE4BAf4AQdcRYokizo7Bs8JCC/r+mzIM89gQ48DqZ/hamJBlfgkypGv3KkamybjCwKGNWV/+f63MecggJJlS91dWvp1PRsSeC2qGwjdYOSk6HcoEVDuzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792390630; c=relaxed/simple;
	bh=GGvLE11ywpZlmxTTkaUdnDjoAlb7FLJJBk2Zd3UN63I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MK1JWtLxRdnIyC+uuXuLc2q2lnVGiRNAAuaq26TnRgQC7XPdS0Xetg7CHidx0KmKYln9qfA8jg7q4yavbplr9ryABxJkvo9FOBojMw8zb3Ez+xLSdPMllIb2fDg+NnDWIOp6OvjahcjEaaixH+rMrToVwz1WH5O8FpiG6v0OWnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jg3mqBYzdb2/M6VsimgQofU2iqtazw2ypF/jIYOxgnxeFfNalsuUZ58g70K8SMr/a+0gvDOJxAinF8MduunoFrXGxGBpyN3z9kAool3QBnHnlnFm9pLTkb6jMgksBivqWYTcbtQZ7R5a/vHuICgffW1ULZvqmdTZKvQxm93mpsbjYpORIIRlBqAyg4nCRPz9eJNDEaWK/p5E7y/EeUBul4lqETjjuh41+3Pc4sMoOMHmjZDxt9nvRzJwC8w9GiYmenht0kEJhjlZR1CpUyOY2RittPo6MgLYT1NLhW746PqkPBM9PWmud7tEW4Cwo6F8HtXLcHekw1ziQxnbz8nhLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbc2J2oyotb48dQ/wsJUre4WVKsAc054ldReOjsWDgg=;
 b=ATg4HBBBMwDDLox734b4duWKoO02pdS39PuaYplWXCPjVtx05ZbN9eELgApNpl2NqW3iMcFVx3Lx4GivTlIOZXY7BDcujaiC7GySwyDXFzvLI6fMWFWR0qzDuH8VomDJ04WFCMhEw3U5gLFRkyWWoBsr27MXmrr+RlC9iYO6OF0Hprdq4QXvDI9MPEyggDKOe/2NU9KEYTwKez+wF54ktEqhHDgx7KpUPP8QDkpfefknsWBNXAmrfefyFqbN6kfMWgWMX0SUepeUYpOfBoBRU6cveznp4jAK2yERtVWGs7YjUh5ArxtvXYGK2bxQsDK0WsupKFyMxNjkX49K15HOqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:7::10) by NT0PR01MB1103.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 02:43:07 +0000
Received: from NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
 ([fe80::be4a:d29e:5188:b37e]) by
 NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn ([fe80::be4a:d29e:5188:b37e%3])
 with mapi id 15.21.0522.017; Mon, 19 Oct 2026 02:43:07 +0000
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
Subject: RE: [PATCH v23 2/2] pwm: Add OpenCores PTC PWM driver
Thread-Topic: [PATCH v23 2/2] pwm: Add OpenCores PTC PWM driver
Thread-Index: AQHdW8vN6H96672t7EO/8E8iK06m+LcELU+Q
Date: Mon, 19 Oct 2026 02:43:06 +0000
Message-ID:
 <NT0PR01MB110227DC1E2F55D8363E97DEE6982@NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn>
References: <20261014110429.52762-1-hal.feng@starfivetech.com>
 <20261014110429.52762-3-hal.feng@starfivetech.com>
In-Reply-To: <20261014110429.52762-3-hal.feng@starfivetech.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NT0PR01MB1102:EE_|NT0PR01MB1103:EE_
x-ms-office365-filtering-correlation-id: fe87a998-a5bf-42bc-d0e9-08df2d8ab4a6
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|22082099003|18002099003|10067099003|3023799007|13003099007|4143699003|261009223027099003|261009221227099003|38070700021|56012099006;
x-microsoft-antispam-message-info:
 /zD6ApCOR9pChM2dXav/kwCoGvp5j6QWGm/EiGbWqqVABBUqs+ScI+8dqTyiRRVJwMLEs6pPDpJfJb8go+xQIktnuxLyCmTAnoB2o4f356yIr0/IBg7Fx4c+p2HZaLBAm6Tuqb1eJEDz3mugiCl7myCBfukuYJ3kjfkSiLxIqDKDUy6mnqFzrxYBb+WUs9OzXSwjh2qU7FuV94O2tGaTljX/6z1Q1KH8Y60mStHOxnDh5C9avC3RtzAhtRFFAadqHQLwVZG5lK9BEKhnbt6tUKkJjXIN2WWVb+fAyzaALJc0ABy59anrDPQDu4Km0cwQVpFFGTOjuj6YqfoOH1IcSNQblvAjqHSnItEPAFpaQGmOBgYDoL6ypv6f7OtWGO2IV/Qb8ZFYpf67tToTdDLZz+wLx+rE/0OSiNFV3WG3cFoD6KywrMXSPbpTqxMCJhaQGPa4Ho+jRpo9AXq56MFOH7UdXpuiJ2a9qBYkGGDwByspWtvMsVQ++cxvaBFuUm2o7Y3T4ihOMxBDClnZAm3fcUFucVV1IUfscbm+g2y8u8Q0SHuK8p6DjumKn44Iv/+v
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(10067099003)(3023799007)(13003099007)(4143699003)(261009223027099003)(261009221227099003)(38070700021)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Y/R+BO4GIrn/42fOdh9abU9nCNeWlub6b9vSEVMbslLc1Y5SYpDjPKcHYy?=
 =?iso-8859-1?Q?j1wx+/Y70z08EZGzuxlDxFYugrxHjqDI7Efu7UWtiLAV06I5rXUdcN1+8O?=
 =?iso-8859-1?Q?PEOLuR4cCQD0VqQSXPQ6QeuF1r51O7Hs40FNpIijJ6lN8r/rpEE8jry5zA?=
 =?iso-8859-1?Q?spre4bOfNoGb8qQexM3vmDV7sICN04YVHRiZvs5JmhBRzJ1oilIs6lHHJP?=
 =?iso-8859-1?Q?dOmcyKnHCo26aJdoj4tfOzkaowSu26mWgWQmA60K1S+XUSg/JwT+LWuEEY?=
 =?iso-8859-1?Q?f0p2tOzd+63ahj+coV3zItiQvd+xlVpW/0qIvWEqRzwDj6J5UBrSGvGR0c?=
 =?iso-8859-1?Q?jTEW7d9B11XBbcOLYQ3Z/4xadbYzc5JwES6emQoKBqYSWbF9jTVrd5Qz6p?=
 =?iso-8859-1?Q?7g3GuK4rCh2t29k9n/U4pR9ooWFoAdc56Y3Ty75R6Kn+9HHX3mea0XzLbR?=
 =?iso-8859-1?Q?SWBX/xm42tPooDOKT9VHxPBmu2oCtvTKADRWWnkBkrlFBf6i962it+2Cb+?=
 =?iso-8859-1?Q?ca6fodS6ujNFDSnGMZC0/f0JP+BIING7/9Q/1FCk4Z6T3E+bLzKNkUnUoe?=
 =?iso-8859-1?Q?LNSdYiLj2hVOkoYZppOXEnuVg4Uxn2LIzJ08LmKMqay9qRvZUQi6dxDoJe?=
 =?iso-8859-1?Q?RNgTM5DIb0ctwSYzTPL+cVouwCB1g8HQfLt3nHG1V6IMCG16+jZ3b54fWD?=
 =?iso-8859-1?Q?fsSfQylPeSnU+cauViC7V7lhCUswi8xuNVXem1tbPuNn5B12cmpp9PVOTY?=
 =?iso-8859-1?Q?NUnYk97gZACCT7N9oHTMJCWUUE5vZbqo1uPIo8gsazFdDFDwi3aX1u00iD?=
 =?iso-8859-1?Q?xmFVCWu2hDxihM8GE1m0QuyIjqKP/L7IRzGD7dyHV1yDAf4nP0tV93R/4q?=
 =?iso-8859-1?Q?l8SkCQeVK0L3wmN2KEjGYdMpU9JSa7du21xaBAB6Ll8bGI/QYQlVsRuKk/?=
 =?iso-8859-1?Q?azwyW8i/c1aGYNwbatKQpGoJP/mfqrPdDXcEGwXBNIrkBDfo6t4C9nMS0D?=
 =?iso-8859-1?Q?KKjte8FONzRoaUhjG14GeBmn15sUGMqXa0vka+WD0GITuSNRYrAuCf5gbH?=
 =?iso-8859-1?Q?yAbV8wIfPqKRPpcvwvotX6laiVY/DfKgpEcPldNL4hThcbrKDpyHxRiDJH?=
 =?iso-8859-1?Q?az0frRhCQE9tZLkVp/OXKweN5ZPAh9dIt5vCWgAbSl8/ABLTYhbOaoqIXl?=
 =?iso-8859-1?Q?FX5AmRMv4ANfWjoX/3WGqxvd128VjCqQAYJH4UJmwsepvdrsG3FAkiHF1z?=
 =?iso-8859-1?Q?Qn8zug+amftO9K2mc19JiFv4FIadBOgUZMzvF0DKTeMWqUjk38pzA06oPf?=
 =?iso-8859-1?Q?JPoXvfiMSxHVEBLjX1o8oT9VOJw3z1Chpz55E5tui7BOhxqf+v4yJhMxHP?=
 =?iso-8859-1?Q?jDubvjHVUBPDdgMdCKaDnKbuUHqfScnXlC6tLeWEYUBJaovAadDh5hmivF?=
 =?iso-8859-1?Q?FEAxbMkRbn8smjwEo4sJIc0czCkl7IhHiBLp6NyoH6DXOxxsWgnA7zmWF3?=
 =?iso-8859-1?Q?qEV8+39o8CwjpnKKHL4zXdqquTip+eBXyjl5sWSycX9K/LAWHQcEjqny9J?=
 =?iso-8859-1?Q?79KghEjerdq/fCp9OJ9L4vN5v8EGDiuWKVm1Y7TQg4uR9HiEqNi3oYnw3o?=
 =?iso-8859-1?Q?o49SkXuVvOqLbyOnDnFeAgCfrqgEykCIBWFVzw5wbSMq6OnyaNLFWcJLrS?=
 =?iso-8859-1?Q?Ib6kpSPd6tpD5EkqBHS+jVD604aLX22li6XBp/tuYk5gueIqii5UuKB0uj?=
 =?iso-8859-1?Q?WMzgO4pRW1V6FkznyPGjmD1oKb96uoLojkQzQStiGLK9A8Zw4qhGY7pUVV?=
 =?iso-8859-1?Q?DWPNcqji0w=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: fe87a998-a5bf-42bc-d0e9-08df2d8ab4a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 02:43:06.9176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MgLlWz5K3cFsfaTwbdkossedkDGuQxmvJcWAUraMIqueJwx07MAZV83ZWJ2MHx0lLyFtJFGJ+R3zUL2D3WzNVZHq8I6OxVQhQvrgbFgXVM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1103

Hi, Uwe Kleine-K=F6nig

Could you please help review and merge this driver patch?

Best regards,
Hal

> Add PWM driver for OpenCores PTC IP core.
>=20
> Tested-by: Maud Spierings <maud_spierings@hotmail.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  MAINTAINERS              |   6 +
>  drivers/pwm/Kconfig      |  12 ++
>  drivers/pwm/Makefile     |   1 +
>  drivers/pwm/pwm-ocores.c | 299
> +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 318 insertions(+)
>  create mode 100644 drivers/pwm/pwm-ocores.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1da3623e77ce..f4237ec609fb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20928,6 +20928,12 @@ F:	Documentation/i2c/busses/i2c-ocores.rst
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
> 729776086879..138e7cd6e991 100644
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
> file mode 100644 index 000000000000..4c7e87cb009f
> --- /dev/null
> +++ b/drivers/pwm/pwm-ocores.c
> @@ -0,0 +1,299 @@
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
> +	if (!state->enabled) {
> +		if (was_enabled) {
> +			writel(0, ddata->base + OCPWM_CTRL);
> +			pm_runtime_put(pwmchip_parent(chip));
> +		}
> +		return 0;
> +	}
> +
> +	if (state->polarity !=3D PWM_POLARITY_INVERSED)
> +		return -EINVAL;
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
> +	/* Keep the reference only if the PWM is already enabled. */
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

