Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022102.outbound.protection.outlook.com [52.101.101.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E9B49AA4E;
	Tue, 22 Sep 2026 19:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106725; cv=fail; b=n/AuEoCbM9so69+qxnWSM0caL6AZ2avDjZ55n7ALEOQ9QdHVX//vq3+umj4t+WTjhO7/toLvOv9kQTeKT80dMrp1SwgcJGAUYMkfTH2GdC5isBq8zGTi6Ff9F5UoMJTV4qr3oVEttj0hUA1+q46QUtkkqLJOsolXvl3hNg5iiiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106725; c=relaxed/simple;
	bh=RydwBasDEKVNyttAYlhB3lBErQjkUxa2GN46k1og27Q=;
	h=Content-Type:Date:Message-Id:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=P2VQdQWXB8SycllhsMA9vGbl1mxvNV6Ohgu5AoBQxIrLLOoBNB9WipDQAOMW90k3Fg5Rb5mMRjD57qW5bQ338Q8p1InA0QdnxlhlQ9NnDRqykHMji0/qNu7hvs7uFP2j7XVcrwB+Yl4l7yl/9zRpxRXpMEXL35bGsFrsn/+3nw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=FjRcqS5q; arc=fail smtp.client-ip=52.101.101.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="FjRcqS5q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WhzM5J1Y7jUqDPMKkq1i65LgiyDgry1zGHjIaybBxLzN+KzbA1eMSGDy0/IuG5j0JyT4T/2sv4hQ/e/UtMUG+rahBUyOhtM3PtRzEEmoLyV1xssZ/ambEi2mMntv4jWrEMQQvpfKiwv3oOYukAhGvsxAA8SAe0ipBx8qwx2MpmlsWrzl9ouZHPX6rXwePACaUGgwm/JYtp23NCz9+JfVi/2+tJY4xjSLCkk4zoUUhSN+N8oDT2s3BxNbUa6sJLsjewGAp+chNkwWjSQZU35EMOeykV0XYEfzzYrf5i6PRPBY9UbDgDYHChy+vwU6+mS8I6ApCx7B3OoBDFfHjTzfJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5Bcd78l8+sjOwplPSg5ZNmwmo+3VWAJix2bNuNk2iw=;
 b=VGolt7Sh7jsx8I2Xj1FJrPZx6q4O/XGNUoLheqKYTJjw6S5/M1fq6cZSSF8Z6ztqaeYerBS59I86v5q3Vq8Lby8hyxS98FoRPd3oDbtr+YpIjhF4sRigpMVmztlCzN2FdETPPmxMwPBvLbZANUa/pB4X0SntRsahDdd2hsYD8O7MGT3grS4CvsfJ4NyO2JJCz2S4mKXAfNca4o6dj9xMsnjP8y6+rE+zab9tuh750w6PSBdllmZpHmSGdEeDudL2hSo56ChKodmKkW1zltOe2BmWf1chvwlGv5yJxUx6oDGEn3EAxK52fS1LoqJRI5UTWkQoBHEguv17n1rWjDE9+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5Bcd78l8+sjOwplPSg5ZNmwmo+3VWAJix2bNuNk2iw=;
 b=FjRcqS5qSCH9xwzi4exs3o6AoJ7HzQawyG0cDl7RF+6NOuYXRxXSPvc9E/UpjhRcHUWpY6f7hMdcRq9ELvvONyD8jGFHC8uwBvldiNzlGA66CRWoHfjy87uOARGz1dfuTu/oqvAIWhUqIkhngRnUMcVOvOmVKrWhgABT6Afq1YU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO0P265MB6341.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2d0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 19:51:59 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 19:51:58 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 20:51:57 +0100
Message-Id: <DLM3VDAEVVEO.1STV7HI3M3YXK@garyguo.net>
Subject: Re: [PATCH v9 2/3] pwm: rp1: Add RP1 PWM controller driver
From: "Gary Guo" <gary@garyguo.net>
To: "Andrea della Porta" <andrea.porta@suse.com>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 <linux-pwm@vger.kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Florian Fainelli" <florian.fainelli@broadcom.com>, "Broadcom internal
 kernel review list" <bcm-kernel-feedback-list@broadcom.com>,
 <devicetree@vger.kernel.org>, <linux-rpi-kernel@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 "Naushir Patuck" <naush@raspberrypi.com>, "Stanimir Varbanov"
 <svarbanov@suse.de>, <mbrugger@suse.com>, "Sean Young" <sean@mess.org>,
 "Julian Braha" <julianbraha@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>
X-Mailer: aerc 0.22.0
References: <cover.1789724999.git.andrea.porta@suse.com>
 <22f454003902173a7230d0aee5fbd7261fcc163e.1789724999.git.andrea.porta@suse.com>
In-Reply-To: <22f454003902173a7230d0aee5fbd7261fcc163e.1789724999.git.andrea.porta@suse.com>
X-ClientProxiedBy: LO4P123CA0276.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::11) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO0P265MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: 7425c890-6fb2-475c-6bdf-08df18e2f681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|921020|3023799007|10067099003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	V/4pkNRkk7A9yiuRnEhFbjzqL2Ebjn2sccgjpYIQo1v3ty8yt67y5omWwjmsNG3KBNJg3Honj5a6dMW2iiiHjP7bJSmzImoKcIJj2w3ILue2M5rH1bQEniNTTn0JDkxFOX97T/KsBPNFU/fsLy4BVomtCqmxWcOlAzRXmmuLKOaAc1cOWFfvWwUDzsjrfCfsXU4bnCv7oMY3NW30+F7ojSYgl/O5Mdfd3/Wxk+XN0KDI/OYQQI1oIWPZ/dNhX5hneE4xxGIDbT+MDA7PWFzif2W9dBNcfqQ6mFZBKUog51YREJ9PWXLpGaj/dY+4lcG9d0CW1ocM9elXfdiH72gJrc98CksRQA/geWwjMxAdoenUcOX3niKSw2sCubTssN5rPJKCYkcuOIEtw/e2DKeqhmecqFvMwJBlTNRQysI44Z5asghl1jUe+qiVcdaL2u6Nuo8fgQGSsMoqUWHKOKdK+I/Hw+cE5LlRWhhnAYeO6n7LjF5UBA1RMwgR19kaVxvrQnOT23il7w3+V+89yNKpkD8DBqExVS7XHc5piQSHww0StqcoAFzefUTxnoXiBc0IjM6+E96iCl/dcaowOgCV9nc5hfJMOpKFPlrDKtkIygMlMtbbTtfuuILzS7faWevl8maEaz6wcXziYjHSoyKN6tAXcQpzqr0CvM8rJBYvgZXWEsrVJGKXwQl9CT3glhqeA0weG7KXphLuCk/s/Qr2tg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(921020)(3023799007)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amZTMGJTQjRKaUVaVUlMNUxQcVlsdS9aTzJpVGtvTUF2R1p0eGpEbkNxa0Uz?=
 =?utf-8?B?L28rZmxFVWY2U09EK1pvaEsrWVJQTlRObW9nZzRHUkZtSGdJZHVPVDQ4R2Qx?=
 =?utf-8?B?NUdST0NFaWM1TUVOdkF6U3BoRUtLUlhVNE0wVGtkU2lZc2RlODQrbmZBaWN0?=
 =?utf-8?B?d0lmNjg4SnExejlyQmdsQjlrT0Y4cE9RWmI1dnhkYnczYTgyRTUzM3hzbUtV?=
 =?utf-8?B?SGkzSDdTV05OUW5ZOFptblgvN2JYd0pkTmhJZVBTUzhNQnVOOTBrY1Y5azhG?=
 =?utf-8?B?dit5K0hQU3d3aWN0OVRlbXAvT2xWM0oydU5jVjErVDE4SlVRd1RRYmxFdStn?=
 =?utf-8?B?TXlyQ1JPVUZ0RjN0WXNmRXcvNm1Jbkx5TG5MOVNUdG9haUVXTS96ak1iaUNI?=
 =?utf-8?B?c0p1Q1hVZW9QaU9VWmRYTFprYWpVQVY2K1BvSjR0cXZVbGZITGoxVzdjWFNF?=
 =?utf-8?B?SldkbG1ob0pGQXNqVUhnMFBzNkk4WHBtV2xUc0ZzYlVrUkJOaFFMa2xXNEFt?=
 =?utf-8?B?VWNSbktRR3ZaYjl6YTNuV1VRWm1sNEN4ZXlRZjhwdlI5ZU9wUlFjV1ZEWld4?=
 =?utf-8?B?dFBVK1FpdTRFa2RhejNLYjA4MGdFSEFuNjVpbjBTTmZIYjhGU1M3T3lwRFZY?=
 =?utf-8?B?anpRdVJFd01UbHczOFlmb0s3SytjcmFwcllCMHdXa2NKeVd4bFVRc2dmY0RE?=
 =?utf-8?B?TUNieExTV3NZNm8yUWVWamdKTlRuRVErSGwzcTFNRXl2OGhjdlM2Q0NNcE94?=
 =?utf-8?B?Z1E1Sjk4YWx6T1l1RU1iSkVYSVBNdFNWUzQ2OU9oTkdxRXhqaUczOXN2Ty85?=
 =?utf-8?B?SUVrbjErb0lWMFdIQStDR3o5YU5IbjVwYUZPc1Q1ZUVjM1k0MSt1K1hESUlE?=
 =?utf-8?B?ZXcvZHFoYUp0Z0JjUkhJQ0N4cUhFZ2RUTVNYbW16OFFJVlppMjFlUkxYUks2?=
 =?utf-8?B?Zm1haVNicUFZU1VaVCtoL2xoZWh1WWJPWjFnUnVBUjlobmtER2MyZ0NjZzJ0?=
 =?utf-8?B?TmRmdUloZWt2VXZ5SHZ2akZLNlh4MGQ2NTlxWm9VVXhQUDNhVm4yNTA0b1Jk?=
 =?utf-8?B?cWtLU0orN0ZpSzdGelI2VVFWQ0hCOVRnNm9IMk9WWVlWQTBFMEUyUHNKejdM?=
 =?utf-8?B?RVM4ZU1hM21rZmhkQVZURGkweEJuUDF6TkNkc0crMU1vN1JWUm9SZUlKUU95?=
 =?utf-8?B?MjhQenZrbTNnOXQxS3cyeldlZFp4TjFBb2JLUGN6MDNaTmJsRjdueTlGcEI3?=
 =?utf-8?B?Y1dpbk5FbWxKcGgwd01aTGV1S0ZSZTkrTzlxc1BCVEsrWkhSWEFBM0wzeWdz?=
 =?utf-8?B?SHlZQ2s1QndoZWd4MFdEcjBVNFYwM3B3MXAzaGxQVW55MUxZa3RFUndQM3I4?=
 =?utf-8?B?eE1TMnFDcVU4UmdjcEZVSHcyK1JBQ2pIZTdxeHVkUDJQM1NLL1JXMFdOWCtS?=
 =?utf-8?B?RFJpVDlkazdqUHJ3V08xaXBsVlpNemhiRkUxcnBPTWlTTmFXWkx4dUt4azJL?=
 =?utf-8?B?TVArZ080Vzl5Y3phK1M3S3dBY2xPOTVsL3lNQm9HYmlnQWkrVHpFWi9YUmNV?=
 =?utf-8?B?dVVuR1QvMjB0ZTZPRmloZE9ESGl1OVVjTzJhd0s2blAxU016cTVOVDRPKy9B?=
 =?utf-8?B?RTd6bjZtV0lDT0pqRWhVbUxBaTJOcm1xd3dEK016VXUwVFQwRERhTnQ5LzhX?=
 =?utf-8?B?QXNoRTJhZVNDWTkycCtScVNiMTJGWHhnanYveGdTL1VqSDhFNTBDSytiNXZ2?=
 =?utf-8?B?cTJ2dm1hNG5vQWJtbzZsVmpLVktxVnFlTnZrOUdRNk5WWldxRnlVTStkb0FH?=
 =?utf-8?B?VC9KU2FWN1hYUlp5cjd4bE0xUVRNZ0tHRFFoakV2SENMcVFtaDB3WHNPYmMy?=
 =?utf-8?B?MUE1RVZTb2E5TnhXYVpKYU1jK1l3TDVkSlZJNXJUc3hPeHR1Qnl4bzB1YkI2?=
 =?utf-8?B?OGlZNG9TUVY1SEV1bnhFbFpZc0RUSjdTTGNLektJUWVHWXNZVCtXaS9DQjFk?=
 =?utf-8?B?cnc1UlpxY1dRcHBib2NaMGduQlEyM1FqK1F2L09mU3JVWTlHNmZYN0NJOWxX?=
 =?utf-8?B?S1lzWU10SFFwekJGRlpmSHM5VGRTUmFqQnBpWFJuZFBreUNKRk1IRFU1WTNz?=
 =?utf-8?B?K2d4anI4NlZrcEVxeHlYa01tSXk0enhvTFFhUjlUeUUraW5XMnlaamlKZHoy?=
 =?utf-8?B?dlcybE5zT3kyd2FTYnNtOVA1Y0Q5ZC93ZGhNT3FrRDZ0M2JZa2J2dzdnWE4y?=
 =?utf-8?B?Vy9zZEdaNk1Jd0k1TnpnVFNUSkU4bkk2OC9FSEgrRVUvbm9WeW5lcDZZRGFW?=
 =?utf-8?Q?c3N3QrDcwrAaQs3o47?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7425c890-6fb2-475c-6bdf-08df18e2f681
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 19:51:58.8323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gVUgBHmyN4ZjWZufb1ewWnjCAamAeXqlNai/SMFXXbL05XFbED/EPptN3NMNQy0cjS6k2AownkAl7kturlrZsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6341

On Fri Sep 18, 2026 at 10:59 AM BST, Andrea della Porta wrote:
> From: Naushir Patuck <naush@raspberrypi.com>
>
> The Raspberry Pi RP1 southbridge features an embedded PWM
> controller with 4 output channels, alongside an RPM interface
> to read the fan speed on the Raspberry Pi 5.
>
> Add the supporting driver.
>
> Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
> Co-developed-by: Stanimir Varbanov <svarbanov@suse.de>
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>

Put yourself a Co-developed-by perhaps? You made significant changes.

I've tested the device on my Pi 5, and the fan is indeed spinning now :)

> ---
>  drivers/pwm/Kconfig                       |   8 +
>  drivers/pwm/Makefile                      |   1 +
>  drivers/pwm/pwm-rp1.c                     | 499 ++++++++++++++++++++++
>  include/soc/bcm2835/raspberrypi-pwm-rp1.h |  10 +
>  4 files changed, 518 insertions(+)
>  create mode 100644 drivers/pwm/pwm-rp1.c
>  create mode 100644 include/soc/bcm2835/raspberrypi-pwm-rp1.h
>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 7297760868790..e1baec8d294d1 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -637,6 +637,14 @@ config PWM_ROCKCHIP
>  	  Generic PWM framework driver for the PWM controller found on
>  	  Rockchip SoCs.
> =20
> +config PWM_RASPBERRYPI_RP1
> +	tristate "RP1 PWM support"
> +	depends on MISC_RP1 || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	select REGMAP_MMIO
> +	help
> +	  PWM framework driver for Raspberry Pi RP1 controller.
> +
>  config PWM_SAMSUNG
>  	tristate "Samsung PWM support"
>  	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 5630a521a7cff..c07fd24f69f39 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -57,6 +57,7 @@ obj-$(CONFIG_PWM_RENESAS_RZG2L_GPT)	+=3D pwm-rzg2l-gpt.=
o
>  obj-$(CONFIG_PWM_RENESAS_RZ_MTU3)	+=3D pwm-rz-mtu3.o
>  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
>  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
> +obj-$(CONFIG_PWM_RASPBERRYPI_RP1)	+=3D pwm-rp1.o
>  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
>  obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
>  obj-$(CONFIG_PWM_SL28CPLD)	+=3D pwm-sl28cpld.o
> diff --git a/drivers/pwm/pwm-rp1.c b/drivers/pwm/pwm-rp1.c
> new file mode 100644
> index 0000000000000..cfd38e46cc589
> --- /dev/null
> +++ b/drivers/pwm/pwm-rp1.c
> +
> +int rp1_pwm_read_tachometer(struct device *dev)
> +{
> +	struct pwm_chip *chip;
> +	struct rp1_pwm *rp1;
> +	u32 tach_val;
> +	int ret;
> +
> +	if (!dev)
> +		return -EINVAL;
> +
> +	device_lock(dev);

You should use the device link mechanism for synchronizing unbind / runtime=
 PM.
That can be done in your RP1 fan driver, and it doesn't need locking on thi=
s
driver.

So Sashiko is kinda reporting a false positive here.

> +
> +	chip =3D dev_get_drvdata(dev);
> +	if (!chip) {
> +		ret =3D -ENODEV;
> +		goto err_dev_unlock;
> +	}
> +
> +	rp1 =3D pwmchip_get_drvdata(chip);
> +	if (!rp1) {
> +		ret =3D -ENODEV;
> +		goto err_dev_unlock;
> +	}
> +
> +	mutex_lock(&rp1->lock);
> +	if (!rp1->clk_enabled) {
> +		ret =3D -EBUSY;
> +		goto err_clk_unlock;
> +	}
> +
> +	ret =3D regmap_read(rp1->regmap, RP1_PWM_PHASE(2), &tach_val);
> +	if (ret)
> +		goto err_clk_unlock;
> +
> +	ret =3D (int)tach_val;
> +
> +err_clk_unlock:
> +	mutex_unlock(&rp1->lock);
> +err_dev_unlock:
> +	device_unlock(dev);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_NS_GPL(rp1_pwm_read_tachometer, "RP1_PWM_FAN");
> +
> +static int rp1_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	unsigned long clk_rate;
> +	struct pwm_chip *chip;
> +	void __iomem	*base;
> +	struct rp1_pwm *rp1;
> +	int ret;
> +
> +	chip =3D devm_pwmchip_alloc(dev, RP1_PWM_NUM_PWMS, sizeof(*rp1));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +
> +	rp1 =3D pwmchip_get_drvdata(chip);
> +	ret =3D devm_mutex_init(dev, &rp1->lock);
> +	if (ret)
> +		return ret;
> +
> +	base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	rp1->regmap =3D devm_regmap_init_mmio(dev, base, &rp1_pwm_regmap_config=
);
> +	if (IS_ERR(rp1->regmap))
> +		return dev_err_probe(dev, PTR_ERR(rp1->regmap), "Cannot initialize reg=
map\n");

You mentioned "rework regmap error paths" in cover letter.

But the issue is that regmap doesn't need be used here at all. RP1 is on PC=
Ie
so there is no need for bus abstraction, direct use of MMIO is sufficient.
MMIO accessors have no error paths, so you're saying yourself from having t=
o
handle that, and also reduce the overhead by not having to go through an
abstraction w/ indirect funicton calls.

I suppose regmap was used when syscon was there; but it's not needed anymor=
e.

Best,
Gary

> +
> +	rp1->clk =3D devm_clk_get(dev, NULL);
> +	if (IS_ERR(rp1->clk))
> +		return dev_err_probe(dev, PTR_ERR(rp1->clk), "Clock not found\n");
> +

