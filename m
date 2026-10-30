Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793339672;
	b=hKAuQvn68V3X0VQxNsmuelfs8uWDg9SnP2odReUw8TarZ+S0aHPuZv/2niqTF/uBHCQh
	 +thvrMcW0SF+xdyzOYLCbl65J72cqyqTxulcJeYtqilOk0MpnLjegAS5NihT+hdin1np6
	 zgGeuNuc+n0yD/8goaQrWqXxXDlaCB6JnLn7iu+OC5zjPTDyGFRV9uB9VPfemft1g0Qt9
	 tgr9OFDuXwxGzocMoxdGRH6dYxKCq5Tx+kpiI5CNpYVyrJsmA3QB5TCji3Njrf7KPNn1p
	 r2gQeQ/LHsr5vZ9+5sfG0/IZfV4XcbFWLNYZZ7H9LgxtmDBGa+xgO7o2Jp+OPWZDd0g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793339672;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=6c7mfjgmLyONW+xIuA/jSg3iAP9gcKq8eJTuPXfk9jc=;
	b=YCzMwlf42A03PyLeFyINhrC1WKIYdqbXg9/Sv9h4rjhh7KQaFrTAJ9jHht0+ovUWA3XZ
	 LJdnx+7A9RHF6bSHZru7l7RRUzklLJQGnqvGaed5FGvb8R9L7w7C9UIMTgLKu5yQXBr+w
	 YNsNrqyjaj8N52+ozjpkCbpTrSjFIP3BAWDZbyYcBlYPa86EMOSyANg212Eazo51s1ToG
	 Zbyv+foXeAwFig17eUb3szUaKDCLuZB64xylHf+GZjowJJHy5GNHYG8nf4AsoUp5i/Ovw
	 NLRuKXR8eABvdzyMr7IUIgc47597jizYfVk5hyHeNvmd3RYX3GADIUrZ06ulj4HQ5mg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oHA8A7UH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.7
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013007.outbound.protection.outlook.com [40.107.201.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8412A606A31F;
	Fri, 30 Oct 2026 05:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8412A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oHA8A7UH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cqv4S4JE1xlIIfhvfjTE4v7wLNxRYhCTtalOb8Ujpbqp4rdbb+MfrH4g+kBwHGYSF5gtQTRaGlXy+1dvcG/bltOVlu6CAdw2E3vsdnCpf+Ur+MPmOtODYBidB/oBNTywV37570Aar8yDfVLNamAi1JsghKqSpRtrPjAB8n503EtKTzYR745sg+CY8K5SDWY75b4n8sCJZBCQWQwqvcSBOmtu5B0wQhtFeF++6wxME8AYr2opTlDOJVSAsriBo1+L/dlAxWuIedctNGhBkzxG2Pq5z33aUdVzYZ1vz8HLcsBvzDhgP6EUUCldCjupDJZFoerJ/9fODn6TVv4hfIfBYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6c7mfjgmLyONW+xIuA/jSg3iAP9gcKq8eJTuPXfk9jc=;
 b=csp2a0UUxKnI1vVPYao8Z5VIPnPpFjSulMlwQvtySVcl9w4zgOnuclHcCdAnGIHGC0qFtBdsBUgCgfPgq+Q8tzqF+Hf+HC57hoXfzgB20v0Xg9wtnuXYxfLTV1MpvlJ3c4WMHZroBjp1j41C5GEMWdPH05V0cKYLX2ZCyN9xNjt13IVk4LOq0vJMHRMmAk9tp7IaSGDjsJkUjpzwBrzShOpkkjM0pJbZaSF8UoT+w/HNrYEdYUej1l9N7ERT1ZpsKUFuH95kagq+emR6A3OeXtv0V+2FOgm/fCX+SMjmhgeerpqGq1We1f58T76mF+5Tm81NFBbL2xXms+dUNmHjqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6c7mfjgmLyONW+xIuA/jSg3iAP9gcKq8eJTuPXfk9jc=;
 b=oHA8A7UHMZ8epxuwdkRLVXyfA3iJhK6v+Cdz9n+QT/mV/T6GMT9rEdIAWfLNB+MKUSwGByNjWTQQg9Jgr8HhhT/GWGTH0e7qq0djaYiJqgAOioGSslSbfXUs1Wyx05vnlhp+hVsGG7bBtlcJzFfnigUbbGdjAZnV76cU5t8KL72fAid7FDJ4wl8rvbul06/14pOeos70kra7a3p2Hbc5rSI/XsWQqapBjwzk2K4cC7WH0TZpjZWZar+O6SIz8g/QzlK55gfmi7w/O3XuJlOEisGFp0yKEFBX4OZJSkEUD/EIqO8IYLDMS0m23Ht61UcgkkNOw3ZIoXGFzTIPIfVTpQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS0PR12MB6582.namprd12.prod.outlook.com (2603:10b6:8:d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Fri, 30 Oct
 2026 05:54:26 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 05:54:26 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-pwm@vger.kernel.org
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v2] pwm: tegra: Fix value discarding for duty and period
Date: Fri, 30 Oct 2026 14:54:03 +0900
Message-ID: <Zd2GpvGWSu-r_sJpx49U1g@nvidia.com>
In-Reply-To: <20261020133938.191013-2-u.kleine-koenig@baylibre.com>
References: <20261020133938.191013-2-u.kleine-koenig@baylibre.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: OS7PR01CA0166.jpnprd01.prod.outlook.com
 (2603:1096:604:24c::13) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS0PR12MB6582:EE_
X-MS-Office365-Filtering-Correlation-Id: 297e0268-b42f-4f99-0750-08df364a411c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|1800799024|23010399003|366016|11063799006|10067099003|261021123027099003|261022075727099003|56012099006|261021121427099003|261009223027099003|22082099003|18002099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	b7309WSttcAkhv3fr8yiR/adw620W5lecoRebK5fgOkXutz2OBy5ZAY/IW80rRlr2+pmSl3wQQJUVOFH/Ap4VSlSrPEIw/lP6rHh3w+4nQCn0Tluqvr8olMcr3QZ2ht1r8eB3fIlx5nGbuJ9cI6iQFDwlLEl7jpy0A8FH3tOo83gmvjxPqAp+djkuxiooawuQAByNGeWQfTgBBYqL4PTA+5ARgGCt9NcPMjkzDZuAibmX/rJnV9uiHgQVr1WmmUN/UD6cz6qRq7fIJpMl+X6qKzk4JFsqri76lL7lSvFGTeseLASxfVBJvHiZyQ5rV/skeZcCnnQKth0LOPnO3ExBSLRonSDKa3sdQtyuFpkSf22H7FuC4CD+ihbDfEcYejNQCYeIjXpTicN3mdoyWKIk9aoZPT8QBurf9CokElRFioErM7J5HfAL7pTF7/LYU0XeUR1jUoRhAWgZpedkTN5pPt1ZwVGA5hg9u0kQiBsv2P6LDRYosNgsUy1BNgjhyXYsmHxCMJdL3bm0AybLJBAzzpJc1pAsBaB925JmjBeAjrstRylIVNrC2lotNw3hIzY2yjkCd761i6K3UiX4Oggwhl0HyN2u5XJ5JqR1ZEuy7n7YliL7bTJYW+/A05KxRGq5+C6Qsld31p10b8RCM3FBDTakX0YvPavR2/r6CGAneA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(23010399003)(366016)(11063799006)(10067099003)(261021123027099003)(261022075727099003)(56012099006)(261021121427099003)(261009223027099003)(22082099003)(18002099003)(3023799007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjFLTDlDTFZJYXEzTVd1MFhhL00xVjhZRUdkcjdRUUQvaWdYV0I2MFpSVmVR?=
 =?utf-8?B?SjJYQm83dVkyeWEybE9oWUYzZCtFM1M5SHE5bnlDbEtiQ2ZLMmVQeWVwYi9N?=
 =?utf-8?B?WDRLNEdpZldQZEJKdXNGTElzeGdnMjhPajNmWGR6VEowOXhHZDNrQXRoWUxP?=
 =?utf-8?B?THZwUzVQWHdOSy82L0lvVGNPR0Z1RnlVdU8zVmVxNjFCa3NXNzVsdHNKMGox?=
 =?utf-8?B?NCtXZkhvRmpQYmtLOUFGTlJCSy9pWlU4R2RJc29mRE5jbTlFbTVIS3ZrbzRX?=
 =?utf-8?B?NVUxVnZ4ZFFyODI3RVdabUFFbVFZUzhYTmRvVnpaL3dCQXhqd2pUZjJsMlFl?=
 =?utf-8?B?VFp4MHNzSDBoZUxSZ0F3RldEYTVrSHpLSE54OXFlNFJqMWoySGZ0Tlo3Q3gx?=
 =?utf-8?B?UERXWGF1MjhOZDB4dU9hRGV6T0lQOU5ZOEp1R2dSY0lVcjFsbndnTEVMbVR3?=
 =?utf-8?B?cjRiMGFnczd2N0Q5THN6Yk5zWUZTaVlvTjdjSFlhVVNVMFVQbmNrVjJud2Fi?=
 =?utf-8?B?b0svVURTenlVRWpXemRhRGpPTFlwakVIMU1rckVqdzNsMStBSUVUTGQ0RFY0?=
 =?utf-8?B?bExRV3g5aGt3Z3UzR3dOWE94dzM3MmpkL1V4Rm5FaGc5UFJFZ2NaT24zTDBo?=
 =?utf-8?B?UXlyU21kOFltRWVpTHZhR3c1M2laV3ZkYzRCWERORDlhUTJFYWxIMWFyYjhs?=
 =?utf-8?B?ek5DNWsrdCtUV1RNNlRCdjc1aE4wVEJVMG9sYmZQV2hadWFLaENlazgyc052?=
 =?utf-8?B?cDFSZ2dWcE55cExnMEtlc1k5TFFseGZKOVMzb1IvLy9iM3hxN0kzc2NOYlZI?=
 =?utf-8?B?NzY3WG1seFhneUtLUHpLeVhCTktXUXNtalYrdzJvMWRoRk84WFF4UERKaTJU?=
 =?utf-8?B?VGFJdGU3b2hrMk1WQnRvTFFlTVdzZVM5OW9kTjR1V3pwSmxvTSsrQjl2N1ln?=
 =?utf-8?B?Y01sTzV5aU5jWEFvQXNFRkFTYnhKZkxhWDZZczJPVWJsVGwrbHJwMG5neDh1?=
 =?utf-8?B?NWhNNjBmT1BTKzJBaXJ6MC9DemY5Z09CNVk2cUVlRFc0Nk93dHhlaFlBd0pl?=
 =?utf-8?B?eWFUZ1pLaDlnQUpBbWxHMzdIelFFdXFiTGcreUhWdEdFU3M5ZlpYMVpPVXhz?=
 =?utf-8?B?bVBnZmN4R0hOWVYvZkx2ZXIxb3lOWTAyUjZMSDhib0pzQWF0RXVzN0tkMURR?=
 =?utf-8?B?dzJWdjFiV2NrMmNPbFZjRkExUFNRUFUxTFZEaTB2V3dramlNR3V4ZmlRQjJP?=
 =?utf-8?B?aHg4Z21TWG9FZXJ4eTRhVzNKVHBoNFJpRlV1dmZKUWVidzI0bXYzcDFnbE1N?=
 =?utf-8?B?ZkM0cklYMkhkdWRoRTUxS3I4SWUwZ3d6ci8yVDlFY3RIaEtGbFMzVjZMZXFT?=
 =?utf-8?B?eEhhbzFYTThtTDl5UXU5aTlCUTc4cWowSjFDVGRYb2dlTnhrQ041NU1MWEVH?=
 =?utf-8?B?RjZjUlAzbWQzd2YydkU4U2l2MWFHbDFiMDFBdENUOVdPOEdVTTRIZlIwaHM0?=
 =?utf-8?B?RlN3UVlWUFBUZU13MlExVjM2SWNnYkM4bEhLL2VwNThWOUJZdTNHVERJN1Yy?=
 =?utf-8?B?WFpkOHRERHcyaFQwNmh2MlRXUlFrRGJNOCs3cjZMZllDcVFPcGZHenlndlp5?=
 =?utf-8?B?emQ4VXh1QnZFTDNHOEdLYk4wdGcyM0I5ZG5NVXRJZXFmbEpPUkdHbmFBMWk4?=
 =?utf-8?B?eVNIcXVVYzFtZVYzbW5FQUJKakc2MkJkTHBSZ3c1ODFNSlNLQlNJU2xaWkpj?=
 =?utf-8?B?cSt0UngwdUdjS2dmNFRRemdVclNkUlFpdmV2S0JyODRQZHVFeUZyOHlVV2FX?=
 =?utf-8?B?dzNldkFNZm1rMS9JaHo4NzhGSDVIVy8rQ29xVWY2NUxFU1doam9sSjR2UzFR?=
 =?utf-8?B?M0owcVhtcmZkVitFSmNTWlREOUVYVzRXSG81NzN2bDJkbStsRlBpTnFUK1NY?=
 =?utf-8?B?YUpqWTdwckhjV05KYjlUWjMwQ0tlVkVEQkhsKzUvaDFsZDR5eHVVdndyZzN6?=
 =?utf-8?B?bXBNZHdqamhZY1FMMUNHSTdUb0pyOW9LMXVkK0ZWMWxNbm5RTU9yVnc3Wlo0?=
 =?utf-8?B?aUl4U3ozTm9lV0tlcnRzVmlRY1M0T2dhMTVCR3kzSGoyNGJLZ0VjeE1vV3Ro?=
 =?utf-8?B?TjcwUTFuWFF1WnFKZUxUMENpR0FDNnhiYkxFTGJoMlRYa3BQelU4cEdMYjE4?=
 =?utf-8?B?V3NQSUVzQ1BaaGxYVTVwd0h2VEkxSHZ2djlCUHFDd2l4N2ttMmYrNFd4MjUw?=
 =?utf-8?B?YlBHTUhheXJrR3JGKzdDcGdUd1IxeEZVOU1ESnVhK0x5SEVyTEtaQXJETG1Q?=
 =?utf-8?B?eHdWejFDaHZjd1dEUHpaOXBiZWVIQ2VHQUdkYkxkd2MyWk5pbzdBeXVTNmFI?=
 =?utf-8?Q?NmdB/ZTZE8t+QOHxNWj2iY4R6sca5te79vAQJF709nvGc?=
X-MS-Exchange-AntiSpam-MessageData-1: km00QbAGNPEn+g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 297e0268-b42f-4f99-0750-08df364a411c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 05:54:25.9571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P6P9W6128d5uL/V2rKgEFdm0F+yEc/EHcR63vfkKCgn1jRMlJWK36Gc8thHvsYPowj2vUbxh6uLFZFU4Wuawow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6582

On Tuesday, October 20, 2026 10:39=E2=80=AFPM Uwe Kleine-K=C3=B6nig wrote:
> tegra_pwm_config() is called with u64 values passed for duty_ns and
> period_ns in tegra_pwm_apply(). Make these parameters u64 instead of int
> to not lose the upper bits for bigger values. If such a discard happens
> the values that are written to hardware become wrong, or (if the
> discarded period value becomes 0) a division by zero happens.
>=20
> Adapt the math functions accordingly to not let the now potentially
> bigger values result in overflows. While touching these, also limit the
> scope of the required_clk_rate variable.
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/bug/linux-5c5b97d6-4da6-4d06-9dc7-957419dcd83=
2
> Fixes: fd3ddd4355c0 ("pwm: tegra: Implement .apply() callback")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
> Hello,
>=20
> Compared to (implicit) v1
> (https://lore.kernel.org/linux-pwm/20261015085336.4181137-2-u.kleine-koen=
ig@baylibre.com):
> this adds more adaptions to handle the bigger variable types, as found
> by both Sashiko and Mikko. I didn't think a lot about the
> required_clk_rate calculations, but I guess the saturating math I
> implemented should be fine.
>=20
> Best regards
> Uwe

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
Tested-by: Mikko Perttunen <mperttunen@nvidia.com> # Jetson AGX Thor (fan)

>=20
>  drivers/pwm/pwm-tegra.c | 34 ++++++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> index 5cdbe120ba2d..6d468a673ded 100644
> --- a/drivers/pwm/pwm-tegra.c
> +++ b/drivers/pwm/pwm-tegra.c
> @@ -138,22 +138,23 @@ static inline void tegra_pwm_writel(struct pwm_devi=
ce *pwm, unsigned int offset,
>  }
> =20
>  static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pw=
m,
> -			    int duty_ns, int period_ns)
> +			    u64 duty_ns, u64 period_ns)
>  {
>  	struct tegra_pwm_chip *pc =3D to_tegra_pwm_chip(chip);
> -	unsigned long long c =3D duty_ns;
> -	unsigned long rate, required_clk_rate;
> +	u64 c, rate;
>  	u32 val =3D 0;
>  	int err;
> =20
>  	/*
>  	 * Convert from duty_ns / period_ns to a fixed number of duty ticks
> -	 * per TEGRA_PWM_DEPTH cycles and make sure to round to the
> -	 * nearest integer during division.
> +	 * per TEGRA_PWM_DEPTH cycles.
>  	 */
> -	c *=3D TEGRA_PWM_DEPTH;
> -	c =3D DIV_ROUND_CLOSEST_ULL(c, period_ns);
> +	c =3D mul_u64_u64_div_u64(duty_ns, TEGRA_PWM_DEPTH, period_ns);
> =20
> +	/*
> +	 * The cast here is fine as c =E2=89=A4 TEGRA_PWM_DEPTH given that we h=
ave
> +	 * duty_ns =E2=89=A4 period_ns above.
> +	 */
>  	val =3D (u32)c << TEGRA_PWM_DUTY_SHIFT;
> =20
>  	/*
> @@ -176,6 +177,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
>  	 * dynamically (e.g. Tegra186 or Tegra194).
>  	 */
>  	if (pc->soc->num_channels =3D=3D 1) {
> +		u64 required_clk_rate;
>  		/*
>  		 * Rate is multiplied with TEGRA_PWM_DEPTH so that it matches
>  		 * with the maximum possible rate that the controller can
> @@ -187,10 +189,18 @@ static int tegra_pwm_config(struct pwm_chip *chip, =
struct pwm_device *pwm,
>  		 * source clock rate as required_clk_rate, PWM controller will
>  		 * be able to configure the requested period.
>  		 */
> -		required_clk_rate =3D DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * TEGRA_PWM_D=
EPTH,
> -						     period_ns);
> +		required_clk_rate =3D mul_u64_u64_div_u64_roundup(NSEC_PER_SEC, TEGRA_=
PWM_DEPTH,
> +								period_ns);
> =20
> -		if (required_clk_rate > clk_round_rate(pc->clk, required_clk_rate))
> +		/*
> +		 * clk_round_rate() and dev_pm_opp_set_rate() both take an unsigned
> +		 * long as frequency parameter, so cap required_clk_rate
> +		 * accordingly.
> +		 */
> +		if (required_clk_rate > ULONG_MAX)
> +			required_clk_rate =3D ULONG_MAX;
> +
> +		if (required_clk_rate > clk_round_rate(pc->clk, required_clk_rate)) {
>  			/*
>  			 * required_clk_rate is a lower bound for the input
>  			 * rate; for lower rates there is no value for PWM_SCALE
> @@ -201,6 +211,10 @@ static int tegra_pwm_config(struct pwm_chip *chip, s=
truct pwm_device *pwm,
>  			 */
>  			required_clk_rate *=3D 2;
> =20
> +			if (required_clk_rate > ULONG_MAX)
> +				required_clk_rate =3D ULONG_MAX;
> +		}
> +
>  		err =3D dev_pm_opp_set_rate(pwmchip_parent(chip), required_clk_rate);
>  		if (err < 0)
>  			return -EINVAL;
> --=20
> 2.56.0.rc1
>=20
>=20




