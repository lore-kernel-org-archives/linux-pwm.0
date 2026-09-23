Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020143.outbound.protection.outlook.com [52.101.196.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A3151D516;
	Wed, 23 Sep 2026 13:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790171170; cv=fail; b=GTmVZ3FuY9kLbpjBtb9NKdNzcVs3lVVIzMmiilryUVjcPf16bJml1eiQve6GOeQc6/J6eNrbU20GhqbbgsiUvvBIN49k29tMjkotvMMRXZZeB3Pczz8ioa1MH768httf2JG0K643lfhSZRA9UHVuZE1g341zNf1zW9I88NZga2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790171170; c=relaxed/simple;
	bh=/bMOef3T9Oc2pAmSiQtlIxN/wcytN8CpRXBChs4GzxY=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=qruGsfIaAWPGS20cP94JOe1stwO93gtqHM4Jub75ziQDmL6t03Rc3wM8URVXj4m+S246muXZI294hzsguGvC0jM84V+ibB69vo/HXEK674JfrSxQma3plYvt6iL2PTnIxcmgL6+CsDhBl4c12bBneeoB6rpUkSzrWTjSOjtav5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=sIlUzyrl; arc=fail smtp.client-ip=52.101.196.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="sIlUzyrl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=roTChYKXLhfvrJ1WJgwqw1CUuhJf/NSNak9kKu6AwBKu44AB2zp5kkCQSDJfK/+mxCh+Fx+FECOfBK64eSgDzuYq0ITWpxrW+o30FhwkL1drrSo04SCm+LRfdh9JvH4DtqRMxwqbdwV8xF3PL+Mg4qvBltH+YQEsKJqRSKIpF+KLHcAHAgg1trdZRUQVN9xAfwR0xM35yIDk1DEw9fViuuGRSHrJo6QKTIgdNFGYl/UoAoceoUUOG6RfyIWLfNJNbyvNhIqNZJmw0qDTmVQhVwnyS0knfwStHSRmQ5xeCPZuysxOJRSTTbuKjUKrqMWRZjQUa1YaXiHebOy9/O8d1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cbHxkRN7Kj7bx8Pw1O1h1gJUwL+dGfcKJdqg/bxzVc=;
 b=ILH/1Iqbx1/jbc+J3F8tAcdFwiia16sbPmnpLkUymUvOJ2o/tQzfMc8V7vEMZXPrlAazr6AEEFUPgUsbnd0H+6jxFhVWNMbYN0e7ulPY+wzharH+JQ6Bdk8SPUDTmy7wHFa2wZ1+0G5jaeXBMWVo5o+Bp7asoJ1Pp7aXVjKhj0ZpZUjz+faes8+2lNYwkPCohje8vITrTjScxa+h06yuhpZCcJqgAmT/fYSvNhfCJdlQAaJblbUqNqcmHOD0yxyN5Pkafj65wHUf5H35P/YaeulmI+WMPAiyHlEo7aU41q3n6LRN88YDulOi5j7+gvDbGC1JllQYLOn1AqefoPnTig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cbHxkRN7Kj7bx8Pw1O1h1gJUwL+dGfcKJdqg/bxzVc=;
 b=sIlUzyrlH3jimWkGiXj1m/GmPzYiDHa9vM5y7CHtqKu4AReUZwhvZMRn0g1i66YefLksq8T9HiHZEvwQGgs9A2KHetPhsZh+OtNqzcmrVHZlZ334eJx9kJrO0lTX7YwQvSI37aSQCjPnA9FSt7beUEehEoXTa1qo5w3pvbpx0zo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO4P265MB6043.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:29e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 13:46:03 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 13:46:03 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 14:46:02 +0100
Message-Id: <DLMQPQRYTSNW.2Z6C0408NMCYK@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Andrea della Porta" <andrea.porta@suse.com>, "Gary Guo"
 <gary@garyguo.net>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 <linux-pwm@vger.kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Florian Fainelli" <florian.fainelli@broadcom.com>, "Broadcom internal
 kernel review list" <bcm-kernel-feedback-list@broadcom.com>,
 <devicetree@vger.kernel.org>, <linux-rpi-kernel@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 "Naushir Patuck" <naush@raspberrypi.com>, "Stanimir Varbanov"
 <svarbanov@suse.de>, <mbrugger@suse.com>, "Sean Young" <sean@mess.org>,
 "Julian Braha" <julianbraha@gmail.com>, "Christophe JAILLET"
 <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v9 2/3] pwm: rp1: Add RP1 PWM controller driver
X-Mailer: aerc 0.22.0
References: <cover.1789724999.git.andrea.porta@suse.com>
 <22f454003902173a7230d0aee5fbd7261fcc163e.1789724999.git.andrea.porta@suse.com> <DLM3VDAEVVEO.1STV7HI3M3YXK@garyguo.net> <arPLa_g4mAg1t2rq@apocalypse>
In-Reply-To: <arPLa_g4mAg1t2rq@apocalypse>
X-ClientProxiedBy: LO4P265CA0047.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::14) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO4P265MB6043:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a3d0a1a-4146-4d1d-6d11-08df197902a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|376014|23010399003|1800799024|3023799007|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4rEpAgV5NzOC+uHoyOhwyHJZvAx7rx/YTVqK4mwnJZUpRrftc4Ee8b8KZlmcrHxX//m0qqqz1wgSz2wch6V94Dw1rHF3ypaZrDZ/hs4g8hUJOYUAWvdXkNa0m5qMKMCclUW9C2PLxPPsLMqwc+nSA5xHaPHe6CJkw+wRXPfQICbIjyZIAUtL5tTe81exS8g9wgahqpaGAeAY4t0oP91D1/md/z1Kdy+XAcFkLVva3DuDN4MrTrTUKSERSQNbwpaCSufWsc/sRP1HDwFmvRd7RvF3oc3yUqXaSimNH3mLrXyu7fl1PwTSf7jZV7RdrNVRk7ZB98CSlN5OgBs6YBxKT0e3r56HZgEitlZhDxjzN8sFvTAWkMElnegq21Xp9WDeNjszQevRuOUynzNK+Qlfd7Koh893GWi7qvzrB06g7+hfNitjuVvjBlh9Zbwd/esC1rdJu6iHH+R0Eb6pMxG2MRkdLtjp8dWllfAC294fuWHrGMdJNOZ9ge1ykjLkehWElsSd4rJVUN7baUn1mKZTlGWUOK/mzn77O1BkHw1TH0lekgcRSmqdpN/JvkbfZ6zXqzJWkS0kUJp7HFBun5yRHmPKS2Nug06TZB2Iu6eXu/dV5Z2nOcr8+0NnixLVLzIWCz6r+fvKkMrKxBm09VCC0lYHf07bQo/3gY0sMNv8/C4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(376014)(23010399003)(1800799024)(3023799007)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azR2NS9nUG1qdmc0MkpFUEJLZU0wZmZMQzNOVGYrS0RyZFF2R0JnTnlrb0o5?=
 =?utf-8?B?eVYyTzdMS2g1TWRzbjZ5S3hpK0tSR0RnbFBFVWJxb3U5SEdrWUd4MTFvbElo?=
 =?utf-8?B?dnlRQTNrS0VOR0tEMURZUisydDVWZUV4RCtvV045ajNPN3hMcy9FY3RpTWhM?=
 =?utf-8?B?U3o5YjU3Nnk0djdseEJMdms5TjdmZUJWS2lzQk9KSVNvbk9zVXo3bVlaY2N4?=
 =?utf-8?B?R0dqTkt6cVJ4SlFUUUl0d05iK0NyUU8yUFZlbjVTTk9naVNiZTgrRFdMcndp?=
 =?utf-8?B?RlNMb3ZoN0s0QXEzQTZ3dFhSdWoxVlpjcFNTcmJwdUZad3Vmb1VkY00zYTBV?=
 =?utf-8?B?SW1KMHRPRU1ZVEl3UEpkRGVoUk9OL1RiV0JsTGgvYVJXcjIyR2NxM2thcjVl?=
 =?utf-8?B?ZmlnbE1JL0pUSVpMeVM5MmR3MDluZlJxMlJpbXM2WUE3MjRpWjBZY0xSV1Zh?=
 =?utf-8?B?RmkrWUJUUjUxdU94aFpFUjZjOGVOeEhnSGV1VEVPeUlseFpDTTI2L0VEV2ZQ?=
 =?utf-8?B?b08yaUsrMld2NUk4bWg0djY1aTdKVzVFWWJTNnVYTkJaeURCcHFhMnZMTnV5?=
 =?utf-8?B?RmpBYTVQbysxTXZoZUttcHZUY1RJRnVvL0pQVUtPY1owejY1NmFxL29mKzRQ?=
 =?utf-8?B?UjB6WlVHZmJyM2pMT25JYndJZlpIRU9UL1A4NXhBeUpLc3l0b0ErYmVIVjlN?=
 =?utf-8?B?bDFSb1gydWVqamt5M3ZWSDltczFEcTRNVHdnK2NZUno3cjZzVEtyN1IxRzNG?=
 =?utf-8?B?WHlNYUdaS2I1cTV3Y1BXeGY3NHVVME13NExlOVFTMmpQbnY5L1kyVWNFWUVG?=
 =?utf-8?B?UEFTckFtVk9MejBSeHNiclF5ZENxNzBTelFMM05xQjJ3OCtjMDJiV2d1cFMz?=
 =?utf-8?B?L1BnSlZldjAzazhRYW9kcFlRR21BSzJqaGtyT3lHR2g5WXdMY2htYWtQL1BX?=
 =?utf-8?B?ZXVJSnRXWHVkZWkzSFdleWpPYXVCVVAvallMUldBOWJZd0s2NUhHMWVpalN6?=
 =?utf-8?B?dmdqOC9KR0N1dWpZa2xFOEJqU1RzRFJGQUprd05hVXFlZnQ2b095Z1R5K09X?=
 =?utf-8?B?L0dENEw5Z25nUGhDOVFBNnpra3U2ekdjdWlZQVdmMk5leldxMEdQUGtWVjRZ?=
 =?utf-8?B?KzgzcHFUMHhBL0xoT0pCL2VVdWgwc0lwTzlaQVQxMjBCdExHekZGQ1dFSnl3?=
 =?utf-8?B?WlUzZTEvbVA3dFdTVy9OVlBoSm1ldU1aT3I2R1dRTmpvRzhJbHdrMnRHdzla?=
 =?utf-8?B?Vy9KZWVYU3NaY3FPa1kxR2ROcTQ5aVkycmdUQ1lmeVRRUEhsa3dhSTFLZlJK?=
 =?utf-8?B?VzRQdUlRUmJXdmxyMnlCNGIvd2JrelhQa0Y3WGFzZjZGcjVtL0VnVWdtWUN1?=
 =?utf-8?B?a0dSNE1EeFlxS3pEN1o1Q1B5amt6ZVZ6UHdIM0czQTluRkJsVTRLNHdxWGhP?=
 =?utf-8?B?MVBWZ3J4UUhNdjFTd0JBZjFwY3pnRDVVZmxJeHZEcEROajBqNUR4S2pNWTdH?=
 =?utf-8?B?Z21CUUZPTFdsZ21PWXpkSU1RbHNkTFB0TDEyTFZwY05MZDFSTGp1ZXI1dUFE?=
 =?utf-8?B?U0pRdCtLYWNQamNpRTcxa0xnRjZLYkh3Q0hRRVhIR0NvdTZteFRMbDFKSW1q?=
 =?utf-8?B?SFBlWmsvdkxXSkpPR1dEMnZ3citXVGI5SzYwL1hOenppOHE2bE9Qd2V1V1Uy?=
 =?utf-8?B?eGt3TjFjVlA1ek4xTStZa2M5bHZpay8rRjlvYlZ0TTU2WlZsRTk0Ykp6OGx5?=
 =?utf-8?B?dURNU2t2NnRzMy9WK3hSL3dvM1R0Y1AyOVB1c1hPSzd6Qm0zU1VCU2lFN095?=
 =?utf-8?B?M21BZXpadDdTRXhwZ2dLMjl3RU1hRUFxeDA5ZDhhTGE1Z01uTXpJQmVGMjRL?=
 =?utf-8?B?MXFLbFBqVnNVS1JWeDNoYURMeDhubnBkNXhrS3J0bU5ZalRyK3h4ZVI0RmZj?=
 =?utf-8?B?elQ3MDBnQTEvSDNBdkZhQi9kMHBPZCtXZ016ei82Zmxsd0QwQytvY0JMY0xT?=
 =?utf-8?B?eWJENFN3UDFBK0g1RXd3REk4NkpjTkhKQ0kxcy9QS2w4Nnl4aXV4WG42eW9s?=
 =?utf-8?B?akFKS2dQUnNNWTFLYml3V1hINGhoanhaYXVnWlF0S05nSSsvUjVOZnc3U1hw?=
 =?utf-8?B?R0RSYXNnUUlVTjV3RnhRc2pmbFJIelR5bG54cnVHUU4wL3JMNDR4TmlkWlFo?=
 =?utf-8?B?RHN4dnVqQnZHcngxSmcxNVdHZTlVZ21PbzB1ZWREYURMeVBCRWhBeDNpT1E1?=
 =?utf-8?B?NmRPM2lTKy9URWZuandHclJ2MXFZUTBndmdsd0h3MlUvQnh2aXk3MDZpRGlq?=
 =?utf-8?B?QzI3ZWZzSDlUU29CVnNDcDY2UkdjUmlpbCtOTTBXSlRUOGdGZE9DUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a3d0a1a-4146-4d1d-6d11-08df197902a3
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 13:46:03.7135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QmvF7Yo1H7ZnN25/Y2kUAXeN7wivWlDyBDpAEUJcYvN4n1s19/AzefqtFyjvI85ixjz+Yj56GYueNPYpOuYqfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6043

On Wed Sep 23, 2026 at 1:51 PM BST, Andrea della Porta wrote:
> Hi Gary,
> thanks for your feedback!
>
> On 20:51 Tue 22 Sep     , Gary Guo wrote:
>> On Fri Sep 18, 2026 at 10:59 AM BST, Andrea della Porta wrote:
>> > From: Naushir Patuck <naush@raspberrypi.com>
>> >
>> > The Raspberry Pi RP1 southbridge features an embedded PWM
>> > controller with 4 output channels, alongside an RPM interface
>> > to read the fan speed on the Raspberry Pi 5.
>> >
>> > Add the supporting driver.
>> >
>> > Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
>> > Co-developed-by: Stanimir Varbanov <svarbanov@suse.de>
>> > Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
>> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
>>=20
>> Put yourself a Co-developed-by perhaps? You made significant changes.
>
> Ack.
>
>>=20
>> I've tested the device on my Pi 5, and the fan is indeed spinning now :)
>
> Nice! Thanks for testing it :)
>
>>=20
>> > ---
>> >  drivers/pwm/Kconfig                       |   8 +
>> >  drivers/pwm/Makefile                      |   1 +
>> >  drivers/pwm/pwm-rp1.c                     | 499 +++++++++++++++++++++=
+
>> >  include/soc/bcm2835/raspberrypi-pwm-rp1.h |  10 +
>> >  4 files changed, 518 insertions(+)
>> >  create mode 100644 drivers/pwm/pwm-rp1.c
>> >  create mode 100644 include/soc/bcm2835/raspberrypi-pwm-rp1.h
>> >
>> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> > index 7297760868790..e1baec8d294d1 100644
>> > --- a/drivers/pwm/Kconfig
>> > +++ b/drivers/pwm/Kconfig
>> > @@ -637,6 +637,14 @@ config PWM_ROCKCHIP
>> >  	  Generic PWM framework driver for the PWM controller found on
>> >  	  Rockchip SoCs.
>> > =20
>> > +config PWM_RASPBERRYPI_RP1
>> > +	tristate "RP1 PWM support"
>> > +	depends on MISC_RP1 || COMPILE_TEST
>> > +	depends on HAS_IOMEM
>> > +	select REGMAP_MMIO
>> > +	help
>> > +	  PWM framework driver for Raspberry Pi RP1 controller.
>> > +
>> >  config PWM_SAMSUNG
>> >  	tristate "Samsung PWM support"
>> >  	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TE=
ST
>> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
>> > index 5630a521a7cff..c07fd24f69f39 100644
>> > --- a/drivers/pwm/Makefile
>> > +++ b/drivers/pwm/Makefile
>> > @@ -57,6 +57,7 @@ obj-$(CONFIG_PWM_RENESAS_RZG2L_GPT)	+=3D pwm-rzg2l-g=
pt.o
>> >  obj-$(CONFIG_PWM_RENESAS_RZ_MTU3)	+=3D pwm-rz-mtu3.o
>> >  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
>> >  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
>> > +obj-$(CONFIG_PWM_RASPBERRYPI_RP1)	+=3D pwm-rp1.o
>> >  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
>> >  obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
>> >  obj-$(CONFIG_PWM_SL28CPLD)	+=3D pwm-sl28cpld.o
>> > diff --git a/drivers/pwm/pwm-rp1.c b/drivers/pwm/pwm-rp1.c
>> > new file mode 100644
>> > index 0000000000000..cfd38e46cc589
>> > --- /dev/null
>> > +++ b/drivers/pwm/pwm-rp1.c
>> > +
>> > +int rp1_pwm_read_tachometer(struct device *dev)
>> > +{
>> > +	struct pwm_chip *chip;
>> > +	struct rp1_pwm *rp1;
>> > +	u32 tach_val;
>> > +	int ret;
>> > +
>> > +	if (!dev)
>> > +		return -EINVAL;
>> > +
>> > +	device_lock(dev);
>>=20
>> You should use the device link mechanism for synchronizing unbind / runt=
ime PM.
>> That can be done in your RP1 fan driver, and it doesn't need locking on =
this
>> driver.
>
> This does not enforce the locking though.

What locking do you think is needed?

Driver core takes care of ordering so you will never see a depended device
going away while a dependant device is still bound. Your RP1 fan driver jus=
t
need to make sure that it never calls this API after it's itself unbound --
which it needs to guarantee anyway.

> Is it enough to just rely on
> caller to create the device link in advance? IOW, just add a documentatio=
n
> comment to the exported function prologue stating that the consumer is
> responsible to sync via a device link is acceptable?

If you use pwm_get API then a device link is automatically created for you
already (however, this automatic link does not pass runtime PM flags, so if=
 you
need that you still need to add link explicitly).

How this is supposed to be synchronized or documented is very hard to get r=
ight
without seeing the user side driver -- if you already have a working versio=
n of
the RP1 fan driver it might benefit to have it attached as a RFC patch in t=
he
series; or an option to to drop the tachometer API and add it as part of th=
e fan
driver series.

> Otherwise the only way I see to protect it in any scenario is via the mut=
ex
> I've already implemented and a second flag for the removing path (device_=
lock
> will be dropped, of course).
>
>>=20
>> So Sashiko is kinda reporting a false positive here.
>>=20
>> > +
>> > +	chip =3D dev_get_drvdata(dev);
>> > +	if (!chip) {
>> > +		ret =3D -ENODEV;
>> > +		goto err_dev_unlock;
>> > +	}
>> > +
>> > +	rp1 =3D pwmchip_get_drvdata(chip);
>> > +	if (!rp1) {
>> > +		ret =3D -ENODEV;
>> > +		goto err_dev_unlock;
>> > +	}
>> > +
>> > +	mutex_lock(&rp1->lock);
>> > +	if (!rp1->clk_enabled) {
>> > +		ret =3D -EBUSY;
>> > +		goto err_clk_unlock;
>> > +	}
>> > +
>> > +	ret =3D regmap_read(rp1->regmap, RP1_PWM_PHASE(2), &tach_val);
>> > +	if (ret)
>> > +		goto err_clk_unlock;
>> > +
>> > +	ret =3D (int)tach_val;
>> > +
>> > +err_clk_unlock:
>> > +	mutex_unlock(&rp1->lock);
>> > +err_dev_unlock:
>> > +	device_unlock(dev);
>> > +
>> > +	return ret;
>> > +}
>> > +EXPORT_SYMBOL_NS_GPL(rp1_pwm_read_tachometer, "RP1_PWM_FAN");
>> > +
>> > +static int rp1_pwm_probe(struct platform_device *pdev)
>> > +{
>> > +	struct device *dev =3D &pdev->dev;
>> > +	unsigned long clk_rate;
>> > +	struct pwm_chip *chip;
>> > +	void __iomem	*base;
>> > +	struct rp1_pwm *rp1;
>> > +	int ret;
>> > +
>> > +	chip =3D devm_pwmchip_alloc(dev, RP1_PWM_NUM_PWMS, sizeof(*rp1));
>> > +	if (IS_ERR(chip))
>> > +		return PTR_ERR(chip);
>> > +
>> > +	rp1 =3D pwmchip_get_drvdata(chip);
>> > +	ret =3D devm_mutex_init(dev, &rp1->lock);
>> > +	if (ret)
>> > +		return ret;
>> > +
>> > +	base =3D devm_platform_ioremap_resource(pdev, 0);
>> > +	if (IS_ERR(base))
>> > +		return PTR_ERR(base);
>> > +
>> > +	rp1->regmap =3D devm_regmap_init_mmio(dev, base, &rp1_pwm_regmap_con=
fig);
>> > +	if (IS_ERR(rp1->regmap))
>> > +		return dev_err_probe(dev, PTR_ERR(rp1->regmap), "Cannot initialize =
regmap\n");
>>=20
>> You mentioned "rework regmap error paths" in cover letter.
>>=20
>> But the issue is that regmap doesn't need be used here at all. RP1 is on=
 PCIe
>> so there is no need for bus abstraction, direct use of MMIO is sufficien=
t.
>> MMIO accessors have no error paths, so you're saying yourself from havin=
g to
>> handle that, and also reduce the overhead by not having to go through an
>> abstraction w/ indirect funicton calls.
>>
>> I suppose regmap was used when syscon was there; but it's not needed any=
more.
>
> True, and I don't have any issue in converting back to MMIO call and drop=
 the conditional for
> error checking, but please consider the following, since the driver may b=
e extended in the
> future to support more features:
>
> - regmap gives you free debugfs view on the registers, which may be usefu=
l to test
>   the new features.

Do you have any register that we want to access that is not part of the PWM
facility, other than tachometer?

> - regmap_write/read may still return an error in case the passed register=
 is not in range.
>   This will be trapped at runtime only, but could still be useful during =
development

I think this is rather a anti-feature. Having additional error paths for so=
me
thing that never happens is not a good idea, especially that you basically =
get 0
coverage for these paths.

You already know the shape of the register region, so the bounds checking
provided by regmap would be better served by an ahead-of-time check:

    #define RP1_PWM_REG_MAX (RP1_PWM_DUTY(RP1_PWM_NUM_PWMS) + 4)

    struct resource *res;
    base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &res);
    if (IS_ERR(base))
        return PTR_ERR(base);

    if (resource_size(res) < RP1_PWM_REG_MAX) ...

Shameless plug: Rust abstractions for I/O access is actually pretty good in=
 this
regard in the sense that we try to prove statically that access canot fail.=
 It
also has PWM and platform abstractions. If you're interested in learning Ru=
st
this driver might be a good candidate :) If you're going to LPC we can chat
about this there.

Best,
Gary

> - I expect the PWM driver to be a access with very low frequency, so I gu=
ess the overhead=20
>   imposed by regmap is negligible.
>
> Since we already have it, I'd prefer to leave regmap if possible for the =
aforementioned reasons,
> but I'm obviously open to drop it in favor of direct MMIO calls in case y=
ou or anyone else are
> not seeing those as real benefits.


