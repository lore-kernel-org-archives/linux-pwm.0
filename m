Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020131.outbound.protection.outlook.com [52.101.195.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64EE400963;
	Tue, 29 Sep 2026 18:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790708171; cv=fail; b=RjKpa1QfK1yo9/ToojM73P8sR3bAg8CQLnrY8CGU0/XksCiHtCqEMrRjv55v/C2s0+imOOVLKCO6ig5hpYQh/pGW5b9t9i76zXWyP6ZrVreKfcxBHAYgmNRc4BIteNXbhhBYSAVtfisCGHAlM2tAo8Ig+TlAcMrKwRbUbpKboT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790708171; c=relaxed/simple;
	bh=d0BI357byHmpo8j8kP7EuaWfDPwHlIUcrt/0a0qRYl0=;
	h=Content-Type:Date:Message-Id:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=XLrLfDn4inZW6hZ32KtSREPlmiRidmp6hc5shDcTyIeqP0HK8hO3Hu0a3HHSwwNhE7MR+c5p8d3ok7R1+RN8yrpAufzZUom0KHFA10lE8uXHo0okYMKConFdF7RGi+9jF0EHTtMaf2D0QIT3VUFWlqwVh65U7T09Ysel6Eottos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=fjhBhJGZ; arc=fail smtp.client-ip=52.101.195.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="fjhBhJGZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/7azqA7bLFxTagacAZVZ2E/neoFYJfSHjkZEQy5yIR7xANyLr6gbheDMer3d915cfH6yHgIxitINUe5XyaPOxIX24YZe/paMDLG3OPuSSTmCMZIHLMfjooatUtZ/BMkbsFqZ/ubH6js8jwgw08IQZ0ZW664zoPiMSVW7R9C+UFN5GdlZlSa6bx7TOouAH7TyboZbQD3tXzTE0cL0ZRWVISVAUSWbAS3H0Djk9QIeOKZPa3J0Y0AgGyNgQho+QYXKLeRxDul+woNV+QGPkAIP48hjKS5POnkU2j0T4Ts/8fI9dzu01DClMOrWghQSxNbrNoRx3jdNoFABiFNCXuaDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2wrPr45KlNPHYK9msroHCsUZ+wRTgBRC2+dKN6c43s=;
 b=bkuNU95wBsoFiCbx4P0WyK5SokcK3YsRt8MI0DNgV7uHlwbQNVj77uGfxEYDZNGXKkooTx0owT0GEokgDSym+2v0QdXqbuFGpScl76hnvb8fusUc6AsML0yishOAOEsH9FfK/79AnpsEoeVH9OvqdKxPYVL1boXdWRbS8xPaXZXthBDGk1U+jSi3qZN45bQaJVg95BLDX/55An8SjEvme8RrYAERqrcG61dZbEDwznC2Hzyu5zoFimi78bM6GslcLodTmEPJLWzpYHrJhA85SiqqPuWv70uNfPo0XvbQCA+nZLY9owEmUqvjLaESMVCSK1OEMqMs15BY8AF7BueuyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2wrPr45KlNPHYK9msroHCsUZ+wRTgBRC2+dKN6c43s=;
 b=fjhBhJGZbBDRLnvRpDrEu5nkpvcefwv32lh86PkWVT9sn69fSFv3VylNmDSTQWgvS+X9/qBaAiJwgmTmynQGIVcmkeRc8KLLx4VEMN06gf8hCO0MnhK5aKa7RKQgWEx8lW2Rqu/fkLLAAzdUKM+GulbkCOSktQkVa8ogHQvD3ow=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWLP265MB5939.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Tue, 29 Sep
 2026 18:56:04 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0451.024; Tue, 29 Sep 2026
 18:56:04 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Sep 2026 19:56:03 +0100
Message-Id: <DLS12DO6AOOU.B7Q2AB8TNVB8@garyguo.net>
Subject: Re: [PATCH v12 2/2] pwm: rp1: Add RP1 PWM controller driver
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
References: <cover.1790686331.git.andrea.porta@suse.com>
 <d617188c890121e75cf90f59dec907d6ff254c85.1790686331.git.andrea.porta@suse.com>
In-Reply-To: <d617188c890121e75cf90f59dec907d6ff254c85.1790686331.git.andrea.porta@suse.com>
X-ClientProxiedBy: LO4P302CA0020.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::9) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWLP265MB5939:EE_
X-MS-Office365-Filtering-Correlation-Id: 792b94d7-2b98-4e99-6b9e-08df1e5b5021
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|18002099003|22082099003|921020|3023799007|10067099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	M0nRiAD7oU14H7/sBzLzQjTOxlC3hhICeP52jef8oar/aS/kdoLmOuta0c/x8B6is4Wu79jEIa9ZgDyXBWzsy3W7nxzpHV3m6cohhvpFO+y2sv7OMji4Qeq6KMftulDY/65mJq6M+vpbNETAAVwPuwB4spjo9Dnk3QcXuk4g1gx8PZNMQwrQkoDO56f8eZeDqJsRDPvRmBF6n9Oh6xNVNFDdBvsheBDuw+FoqIOk8W9MscTfuvqPeMERcsenN1fZRXmLXlf63U2dP97k1xxYSzhN5AJgiquL8PHrMV1UZDLznmx3L/QGN4r8hgHm+ce0vQURSsf26NVQOPdY1C94zhr0O0RWihtxS/j1M9MvK7Bm9U1cHab/IgyNIu7E6qth6wKYFHVxqh6Uoewyw6xv4bMyd9m/uSXGPepM/MxGoOCIZD2EFm+IHV/hITUZxwtwOqpkWZhKs77uQc9aQFcMgRV7JpmhLTUhVNFybJNmVVgms/FzM0TOq1xAd0xtjQcxnu2oKFRJOxAtJzr7jCPNKSC7tFIj+IUwwr/rZJGgd3fz2YlUz+YCGTmqATU/91dkIuk03YnQnnYWkBeHcgzHZoN3dEXfQNnR/mmEBL/kpux2sEtVOTwSeBiTRp31vv39nK61tOSfw0TxGGBXpyn/RKGZv7tvyR/HGyAWTPRYbZWbiOfwFLch214aTUz4udPl1PhiR/b5585troiThZKiDg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(18002099003)(22082099003)(921020)(3023799007)(10067099003)(56012099006)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnhINm1STW54Zm9ZWHBwTXJvVXNwNWlIWU5mdVNqQ2hyS3NhZkJvR2VZTkR3?=
 =?utf-8?B?dlBjSGhSdG9XU1pQaWFDajF5S2FtWUlBLzhXS0J1UHNsSkdMbTZBa3EvcGty?=
 =?utf-8?B?Q0xYamRNZHlndVhpVFlIQjlyblZTMnNQSnJxTzg3TmEySzdwK1ZpVVFydGtt?=
 =?utf-8?B?NUdwVG5Dc2JjVS9XUGZVTUdLbHB5RUtpSEtyVFFTN3VuTlBSbGhmTnZxWW03?=
 =?utf-8?B?dUpDSUZsbjBUTVBadWFKZUxjV0xlRFIzSW5GcGlpdnhaU1ZIM1BRcHpaMkhx?=
 =?utf-8?B?bjVTQ0F5a1MzdDdFZE8yeXFUQm8vVUFUdTAzVHdOZkNxQkFsK0gxV01Fc2F1?=
 =?utf-8?B?bk5WN1RuQUdXQllaZUlSYlVtUU5ERXAzVVkwVUdqS05QTzg5WjJ5cjF5Vmhr?=
 =?utf-8?B?RWpBNmpLQ3E0b09iWktnMW4zdWxyL0ZGeHJSSnR2bWZ3S1krMnFzZTlTS3gy?=
 =?utf-8?B?RTg2aWdFd2Y3MkdFOC9TdVdVQVpTemNkT2tMb3cwbWtjalBCbkVvUEE4UWEw?=
 =?utf-8?B?NlhTUnZURVp4SHZLT2dsNFo2UmxUTFQweEJPcVdHV0NhamFJUVlLeUZmMFpG?=
 =?utf-8?B?aHhJczhzU0NFT05HUFFSdDl2eVB5K1huNHB1dkdaYzkxSk55V2RBQzJkU3ZU?=
 =?utf-8?B?d0RkaHBkTW15TkRTN1FUZ0xCdW5KQ082RDQ5UjYxaG1Hd3l4dmNiUUJWbzkz?=
 =?utf-8?B?KzFqNDN1RDNCNXhDK1BOS1JTUXNPUUtxOEVaTlFDaHdKT2tNWlh1VnU1T2t0?=
 =?utf-8?B?OHg0OHJZQS9QRmg1amd4a1hEZXNvV0w5RmNpR2pWQ1lQcnpRUWt4RGI5bWdH?=
 =?utf-8?B?NUw3NkNKRUUreS9aNWR3NlNQUTFXUHFZWTB2M1p6NWVnbzFLYnFQYlltYzhl?=
 =?utf-8?B?MGluSWZoTENpWDkrUUxrcVRUTzVuWlNGWjhZdnJRNkIybTBoemkrV2g3WWw4?=
 =?utf-8?B?S2dadjVXMHI4clhmcStqWGV4WHhwRWhvRGxsRmJIWFhwUU1Kd1l1SFo0NU5B?=
 =?utf-8?B?Yk9DNUNzck9FOVJMSWZYSGxSbnZQVThyME9JUnlQMy9IY1VJQUR6ZDd5d0lZ?=
 =?utf-8?B?S0hEdFR0blN0bXlXditCRG9sRXh5enBXV3VpY2UxSHliN0dYRnd0czYwSnlZ?=
 =?utf-8?B?UzJneHVUYlBtNnBzOTZadlYyUnBBZHBlNVQ0MS9taVRhSG11RmdnUVZnN0pu?=
 =?utf-8?B?dkR6RU9HK1d6UWJiVld4dERPbzN3YVBlNlFLMWV4SyszdGFkM1BOVnBhUmUr?=
 =?utf-8?B?SjArWXN4dWdpajZjMjhYVHZ2cG95b0d1Y3BFWjNqaWxqa1dNbTdzL2swZWNs?=
 =?utf-8?B?YVJxWU15b2N2WXdGRzZFWk1uem92Sjl1aG1SSU1odWFzZ2xWcnRuSlFNU1A1?=
 =?utf-8?B?U0wycktyS21UaXJENk1XM0JlSkVQWHZHZ3R5cmw0Y1FLaTUvK3MrRUFsSS9F?=
 =?utf-8?B?dytaYVRSVm5HdHI5V3NXMDhMc3U4Ulh4T2FuajZwdDZXQ2tYQzZxTXhNZlFU?=
 =?utf-8?B?Qy8yS0xQZVZOZ052OExtMHBXcnRCbnd2RGRWN3VJVGh0WnVDcndJSVdKTDFI?=
 =?utf-8?B?dSswMWFlbThFd1B5WlF3MnRUbU5LQ25HeHFYSEVsdzRQWFZoaTZ2V1B2MGFY?=
 =?utf-8?B?NTFFNTJ3TCtCaVMvRW0zV09yUFk0YVJjekhqMGQ1MkZXY2FxcmdmdmFWQ1dq?=
 =?utf-8?B?am5STXJwU0tFZ2t3UWdJSEhOYTVMSC9RSHplTUYwU05STHBVdFIxTXpIdmxv?=
 =?utf-8?B?dEEwRUs3UHY4MGZ3RHQ3YzZZZ1JWb01pSTVKTllaOGZHQjBpMHZpSU55eG1Y?=
 =?utf-8?B?cVF3Sk8xZ1RVNyt2TzJIdzdpeUxCNGM3ZjN2aTNicmp2RVpvbVRoRHdxYkp6?=
 =?utf-8?B?TWc3dVdwTDdYK1BLMEpBTHc2ZG5JR2orZ3ZuOE9IaHNSUmVEOEtndWJnSWd6?=
 =?utf-8?B?by8zVGcwakJGNkV0ek9vOXhzcE5EbWpsNllDcGxXVVFlMWRnYlFyNEpucUg5?=
 =?utf-8?B?V1dUMGk1cnBKdTJuc0xoVDBweERnU0NHV3U4TW85eDYvYmpPQ2FROGdsSVk4?=
 =?utf-8?B?dUVhRmxqYXNTd2pDOUU1ZngwcEwvYk8yZ09mbWdOdnNBdUJqSTlQVkIwOHdJ?=
 =?utf-8?B?QTJwMXcrWWhyTU9xTlo1SzZWZC9hQzFTLys2azJFd1p0b3BGcFppbXZ5QW1m?=
 =?utf-8?B?NXpqSllMZ1l5c1BFN1RETE1ac3NpZVBManhsNEhYVVhqMVBVYytjbUlxclM4?=
 =?utf-8?B?S3Rnbk1MK3haWnpOK09lL2E2UW1pM3J5Y3kxTXdrcUdvaWNYK2s1Ly8wVmVC?=
 =?utf-8?Q?Dx6cD8SIw4yZxdR4DK?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 792b94d7-2b98-4e99-6b9e-08df1e5b5021
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 18:56:04.5952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /0Tfxj9sqAqO7Y3ZzEMK3L902vuyiWGnXfDUWSCNWdIZI/h3QXsLU6rHqcsiqF2OpoZIS/mdaNuKUL3lv0UT/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5939

On Tue Sep 29, 2026 at 2:02 PM BST, Andrea della Porta wrote:
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
> Co-developed-by: Andrea della Porta <andrea.porta@suse.com>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>

At a quick glance the code looks alright to me.

Tested-by: Gary Guo <gary@garyguo.net>

> ---
>  drivers/pwm/Kconfig   |   7 +
>  drivers/pwm/Makefile  |   1 +
>  drivers/pwm/pwm-rp1.c | 428 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 436 insertions(+)
>  create mode 100644 drivers/pwm/pwm-rp1.c
>

