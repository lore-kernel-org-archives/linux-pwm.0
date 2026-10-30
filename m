Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.114
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793348506;
	b=hvNAPfopoO2yPOcPpbtqwWDrjRoNjay8E5bh6tlUkoASYAHYrUaeE5DGRphSAnnNgUA5
	 +eLU6zZiuUIaNP3+yRVOeEQWhpvKM6F1Y/VtHTxxyWsGJu0ZvPjKiuOMmY0KbTZ0DGMxB
	 0DrvT6exXG8Z4yHov80xjdtP3UiYk3xf180kpkmFGWI/S/ujKsvxSBV06W6K5pm4qvCOq
	 WPi9DL9pZpjccVlyIdHK2V2OZlKQQXkRjeQV3TvLGrsBB4z+Xp7SViuNnq1amllM0KWbN
	 xDbPxl4uBrWI4f5iI++bwB3TElIETCn8EfPR0OL2lX/3p/AqWUmaEe8q7rklB2CDL4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793348506;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=fjp1wlnWwOw8wGx8lThl4QeJ7Y8SWXt6f5lFwTqOHrI=;
	b=VJD74PeMWPdKgN5YpbzJB33w+qLPJWi+2NrpG7PaegYsd83aPyKRaXA85wUYuJanRiDI
	 chXWA8VSdtybqnYAQDTK4jYOBwAWYcDNfdfhiI0S+PyACuJRGglsPY1CRJjMqMaCAW9pe
	 YkpYBdKHT8tpzZJ0LI5+JprPw3LY/XYbMlShsRRkfVxqzRqO1M6j2fgdNppl0hz2T9tdI
	 YBbtkKYlGIoJV7+7EMkxI/p3rL0WlR320MVX2MVZIPZ8ZKgiEZc9EE0t/osDcvXyIIcRd
	 wh3b06ffI5Oe8/yJqebQA+0k/H/95H6GbiobANdO9CBhtUrhEuQNAOGqCTlJSNDZQCA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=axiado.com;
	spf=pass smtp.mailfrom=axiado.com;
	dkim=pass header.d=axiado.com header.i=@axiado.com header.a=rsa-sha256 header.s=selector1 header.b=h9hEDDAX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.114
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021114.outbound.protection.outlook.com [52.101.57.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C067606A31C;
	Fri, 30 Oct 2026 08:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C067606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=axiado.com header.i=@axiado.com header.a=rsa-sha256 header.s=selector1 header.b=h9hEDDAX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNEDKJfZVZ1nwiS+VmI4cPplPwaEnjQFCuLyaXa/nwP7ebDuqNRWjzi4rPZzDQdSvD1srzR93WEnI+apy7DTiRm7eX+Oh4eYxekCkZKh4V2AX41H4WSVgHNZGmPhUaA7/GunsNDOmM3MVUTICNFJRFfhPuPv9Oh1Ci5cm8xaU9dxTUx7I3jugMY6n7t7i0CKr2Ev8wifc26ab59DFM36aSkvwNvVZTOD2thoC3T3RnFKU6UQlkcZl/kvwL8nHJjsWf+8n6ad7BQW8NctE1ppq/0LR4s8nWkApoNT7uYgcBh5v5OuUrps0LtyLd6x1yUvvK4jFfHFvh5qmkjw67MfbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjp1wlnWwOw8wGx8lThl4QeJ7Y8SWXt6f5lFwTqOHrI=;
 b=XCpgYR/wWtNeDm2DLOVBqgMo3Sm0ik4L5IeEA0mbvo49pb9BfUuj51NKjSFlnGJmOeAOttf1/T3E0yvjjkFc05UD12Z42wQOdwv+LgraJBAfSV02n0CPnS/bwYkRkAUU8L9dssqgHfgCQBnfN8wGAoJr4P6vCrCA1k9jZ3bC4655JrwbW3Ai7sOpvkwSlxGkTQZYLyVRRpXfie9K8Yv6mwRtxD/GdQHhUMDsgQHFXFejVpFFdemuKAX4/dhWCjuJ1oT4U2XomwLzM9D+DUYsuHtxR2AdgqkJQ5IaAM8d/i5OmIqCGCDpwFQFSx9p1956EBXKTlEWjocYfvS9Z4JsjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjp1wlnWwOw8wGx8lThl4QeJ7Y8SWXt6f5lFwTqOHrI=;
 b=h9hEDDAX1Mx7QcrV76jwUxKplVBRi+WSZHzcp5i6/ZnJ7xNMyhTHAvzlR4VO5QJiiyghwF40MCFWSa4qLWRysZ6ywFSQquPMRSsr1kZoR6ah5EM4b5oWrvePaxF/8MMsqkDRCno49eAsfMWipzXa2RUl/ZPzmOVI7uz1rko1/GCy4WZS2VsQfAh9wOhFFsbMNqQH7zTNFKzA66Z46KQmghp+k+wpEWZEkSk2kT1Ll5BHEjDYU6dG8lnuVguAdDCkRsJc9oLEhofCzcU99MDFJk78BlleQHjt9jY9YtvV1VjxXy8gZilu+W7JGW8nnUJpykxzM6tHzhxRTGMbi2cKSQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from DM4PR18MB4144.namprd18.prod.outlook.com (2603:10b6:5:38b::8) by
 IA0PPFF4890666F.namprd18.prod.outlook.com (2603:10b6:20f:fc04::c50) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 08:21:42 +0000
Received: from DM4PR18MB4144.namprd18.prod.outlook.com
 ([fe80::cb97:ca8a:e55a:b11]) by DM4PR18MB4144.namprd18.prod.outlook.com
 ([fe80::cb97:ca8a:e55a:b11%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 08:21:42 +0000
Message-ID: <0979887c-0924-4bc7-a9d0-cbd2b95bf459@axiado.com>
Date: Fri, 30 Oct 2026 09:21:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] pwm: add Axiado AX3000 PWM support
To: Akhila Kavi <akavi@axiado.com>, Prasad Bolisetty <pbolisetty@axiado.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 openbmc@lists.ozlabs.org, Conor Dooley <conor.dooley@microchip.com>
References: <20261005-axiado-ax3000-pwm-v6-0-7feecd0087e4@axiado.com>
Content-Language: en-GB
From: Petar Stepanovic <pstepanovic@axiado.com>
In-Reply-To: <20261005-axiado-ax3000-pwm-v6-0-7feecd0087e4@axiado.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR04CA0044.eurprd04.prod.outlook.com
 (2603:10a6:20b:46a::22) To DM4PR18MB4144.namprd18.prod.outlook.com
 (2603:10b6:5:38b::8)
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
X-MS-TrafficTypeDiagnostic: DM4PR18MB4144:EE_|IA0PPFF4890666F:EE_
X-MS-Office365-Filtering-Correlation-Id: 37c40f8d-9a0a-457e-474d-08df365ed3fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|260925022911599003|260925021911599003|260925021311599003|56012099006|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261022105027099003|261022075727099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	V3cOMRgUA0J/jjAcwDgC7Y6zQljnl98lmj0aJEe4YijrBecS1qXXmcxE3WTY3Nawnvn6J1dZMAROiuPwTi1ASzVluXNnIF0OSlEDDu+krYTpUo7BFKW4/3Q14ygIEZuaNEpwCcEIbyoFx/j/33dmHUXO0qPk39nvF7FDRucB8vWK0o8VInkAiIFWHio2Kr5/F8Jv0rrlyi3ulGTmUnXYv5TiPz7QAM4ThTe6UHPlPzy70UVOeIiPU8Nx7oMF82unPEOoT2KqVXR/xsTCfWClqMUVrPhMhMAeOOYP/zF15IYPsbwdbj1IuR4JhNbmNf59hFzpw8vwYLWR9fvtaGScLuPOHeTySZSjGBjnkp6c2qkVLRUhxdza2etouXqucBJtjRKEWEu4oD5N//Bg+m2+ij0duYa2aSjo+Vt2eyJ4mIFRwcRLEEBaRfFJyxFpV2t2xlW8fk/wN5+gBVrmijZV6biDsGTqvgST+V6AP8SQUziQobXqDwsXa4OtP5cIo57tLnfoB583PBZSVq/ZkrSAuTANxFBLEnnt19jJU751wEakj0+Xv6FhmfKk42GzJHxxFkI8Ekj8ea1+iWlwXZGXMXuHTzzK66BxELWU8tYtAAc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR18MB4144.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261022105027099003)(261022075727099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2QyMFlEY2FrVUtlODcrcFFQMisvcmk0MzkzWFhqbHBnalE5eE9xbGFJVXYy?=
 =?utf-8?B?UEErQTk0UzV0Z2hvMHROSDdjTlArSFFrSFZ6YitnaFRQdUpTakFFbzZvbGNV?=
 =?utf-8?B?RjNkbi8zMDc1SkVoSEMyS2l1UThqMHJTbWtGVXgvYWRVNFpId281MzMzNEx3?=
 =?utf-8?B?ZDF5ZGtQZFhVZkpBalRrdEZVVTZxQlNmanZrMEtHM3A1UGw3ZHNrbzk0UzNq?=
 =?utf-8?B?QklXckdEcDZWYVR1cGdSQm8rbllralFzRUxoZzM0YktPaUpRSkh4VkU2SXJH?=
 =?utf-8?B?eCtWeVN4L2UvTiswZVZTRC9jV3Z6a0FjbHlQTDhOYVlPYWtSalJVdGNQaHhV?=
 =?utf-8?B?TmEwZWpFcFkwSVYxMnBDbUdGdndxb2ZiYyt0SGExb05vdmxYUnFGb1NOVlRx?=
 =?utf-8?B?NkhBSXh5QVQyK0xSbEJVUVFFYWxUbWRQdHY0MGRZMlNqdVFCcjI5SHVuRjl2?=
 =?utf-8?B?SXdGRkJMSnVaVUkrVCs1UlprRGt6c2gxM25XOUphQXlMUHg5Y2RKa3ZZbUpk?=
 =?utf-8?B?Rzc5a1BJa3d0WUpWT2owRWN1K292NzBiQVdkV2pNOHVlakx3QW1pOGszeDYv?=
 =?utf-8?B?V3A5V2FUUDNGei85aStBS2QyMnFNYzhROHpFREJ3elFYZ3RPUytZYzhVQVJ0?=
 =?utf-8?B?SDNwdHZNSU5HcWZidW1PWm0vZCtSU1VvKzFmZjc0R1lkUkgwc0ZLd20zUjBl?=
 =?utf-8?B?blJYTG0zMHNkY05GNWRYTC9IN0tFQmtibElSc2VpNVc4RWxRZW1IR1o4aDR4?=
 =?utf-8?B?T2wzNys2M0RtNFp5aEVlcmhPRWNZbXdVZHRWZXN2dW40Q0wvNkhhSU9kS3Jh?=
 =?utf-8?B?NlpydXNYQmlOQWIzVVFnREw1K0k0VC9vN1ZCMWZIVGV5ZURhRlUxRHlYM2Z5?=
 =?utf-8?B?cno4Mmo2bTZPdmt5Y0pPclk0ZHFBSVV0TytucGJxR3YxYjhDQmg1K0E1SXVt?=
 =?utf-8?B?NmVaZlVtelc1MGd0UkdibzA0Mk5NK0VwRFEvMEZNWFRmaWxwait0SHYwVXZu?=
 =?utf-8?B?UkZGK2J0dVdCOG5pSDc5L3YyaGkvOGk5cmI0eUxleHJpQkdlMmZQdWRJTWRn?=
 =?utf-8?B?WWIrc0x2d2FHdVlmWlB3S0dvQ0hxWFpkREovODJ2anlMWDQ1TE1qQXBUNW9m?=
 =?utf-8?B?OTA4dWFvZVlIVzdKTXFOVTBVd0U3WDZPazJoNWs3RDFhblJsenN2VjFpTUZ0?=
 =?utf-8?B?cWFSdmprK1YvSkFDa0ZiSjFtemE4K0EvM1FQYnFaVCtOenVGTGw0Y2hYY25r?=
 =?utf-8?B?MFZwVytFc2txM1BsNjNLU1hORVByRklxQ3V1Qi8wZjRFK2plUzcrOUZKQVJM?=
 =?utf-8?B?ZGlUcGYxckRVckoyZlNwVWQ2WUMyTytZbUphYkVHV2NlY2RTV3NKRHdHTVMw?=
 =?utf-8?B?cEFJVjJVeGdqNjlkTXFpelBVdm9ZZ0VtczJuN0x0WUFFNkZ2ZUN3WEpneXdD?=
 =?utf-8?B?dFFSb2RjQStPak5GYXNSZ0NNM3FocUxEbjVtYWNwMks0OWh0Sk55ckJkS3Iv?=
 =?utf-8?B?alIybm4vTys0QUJ1bWJ4UnFNTUsrUmJJaERULzRhcG15YkxwaTRoTytHN0tK?=
 =?utf-8?B?eVh0Yzl1Yi9XWVpoTUFiQkdwRTBVQXRVOTB0N0c4VFJvYmpaQ0h2OUJDaDRx?=
 =?utf-8?B?RFZPK05pd2N6bXpnL3dLdlJrYzBSRWFOVEFocnFwcnNUUzBoTURzc1hVZUtv?=
 =?utf-8?B?RGZTOXg3NTJ6bWtQaHhJYkhBSjM1TnhqMG9Da0NFL3Y5bEMrWG1aaFpiWk1t?=
 =?utf-8?B?V1QvWjYwdDZZZElXeHcwVmRuUW5qRkRyd3NjSVhsbG8xQ1JiWGFpM3RjZHFk?=
 =?utf-8?B?bS9RTjh0WWd6b29FWTErWnh2djczL0tRU3kyL1F0MXRPblhmMUwxaUE3ZWxE?=
 =?utf-8?B?WHJPb0tLd1ZWNmg1K1FkNTdoYTZUanRMTjJoL2wvVjJ5aWYyWWo2Mjg3TWF3?=
 =?utf-8?B?U1NoUE5oTDdySlVuVEF1MUZlWlJVTHBLNEVZRytJbnByRTdGTXpWZDJWSE9G?=
 =?utf-8?B?eFlVVmJ4YUREUmI3ZllYelgydHVtTFB6aHBXcC9xcVdoTmozN29KL2pock9y?=
 =?utf-8?B?dHR0elNWRVpKQW9HekluUSs5akVLTytHL0xGRmxNQ0FXMENLWGhydjZwZDky?=
 =?utf-8?B?TFo0Qlg2ay9oSk9HVjJoemdjTnVkTlZrOVZtNHo0bDdraHNkTjhZVmU5RkNn?=
 =?utf-8?B?eXowcEZGOUs5RE8zUUMzK2xZdlAxalFxbHkrU201TWFEaDlqNlhwdnl1QjFj?=
 =?utf-8?B?K2gwYmV0VDdlc2xTNWFCZmFPbGRxcU1UVXVYY25vMUJHNitLcTBPTG4wR1Nl?=
 =?utf-8?B?V0hEV1FoQmw2UHdaY1k1QUVDcExLeGV6N01TQ3JacGZJSUcySHFxdz09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c40f8d-9a0a-457e-474d-08df365ed3fc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR18MB4144.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 08:21:42.3679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yX8zRBgr3FRUC+OkFaXKewEOtptZbuH2S46QsCZ/7GC7F7Tbsy99bT3KALyY2wDdbY6pah+o91e/lKug1vID0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFF4890666F


On 10/5/2026 9:46 AM, Petar Stepanovic wrote:
> This series adds support for the PWM controller found on Axiado
> AX3000 and AX3005 SoCs.
>
> A new driver is needed because this PWM controller is a SoC-specific
> hardware block used on Axiado SoCs. It has its own register layout,
> enable control, period configuration, duty-cycle configuration, and
> does not match any existing upstream PWM driver.
>
> The controller provides configurable PWM output signals. The driver
> exposes the controller through the Linux PWM framework and supports
> period and duty-cycle configuration.
>
> The driver converts the requested period and duty cycle from nanoseconds
> to hardware clock cycles based on the input clock rate.
>
> The datasheet is not publicly available. Public high-level product
> information is available at:
>
> https://axiado.com/products/#AX3080
>
> The register definitions and programming sequence used by this driver
> are based on Axiado internal SoC documentation.
>
> Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>
> ---
> Changes in v6:
> - Use 3 PWM cells and add the flags cell to PWM consumers.
> - Fix readback of the constant-high hardware state when the high-time
>   register is zero.
> - Link to v5: https://patch.msgid.link/20260921-axiado-ax3000-pwm-v5-0-202aad28e129@axiado.com
>
> Changes in v5:
> - Use the hardware disable state directly instead of emulating a
>   disabled
>   PWM with the constant-low representation.
> - Remove driver-side cached period and logically-disabled state.
> - Handle 0% duty cycle using the hardware constant-low representation
>   during waveform rounding.
> - Decode the constant-low representation as 0% duty with a
>   one-clock-cycle
>   period on readback.
> - Simplify waveform read/write handling and remove redundant validation.
> - Update the driver limitations documentation.
> - Link to v4: https://patch.msgid.link/20260908-axiado-ax3000-pwm-v4-0-19a03671cd5b@axiado.com
>
> Changes in v4:
> - Corrected the AX3005 compatible ordering to list
>   axiado,ax3005-pwm before its axiado,ax3000-pwm fallback.
> - Changed the disabled-state handling to program a constant-low
>   waveform,
>   because disabling the hardware controller drives the output high.
> - Added software state tracking so readback reports this constant-low
>   hardware representation as a logically disabled PWM.
> - Link to v3: https://patch.msgid.link/20260811-axiado-ax3000-pwm-v3-0-6ceaccd812cf@axiado.com
>
> Changes in v3:
> - Express AX3005 compatibility with AX3000 using a fallback compatible.
> - Update the Devicetree binding example accordingly.
> - Add 0% duty-cycle support using the hardware constant-low encoding.
> - Cache the rounded period for 0% duty-cycle waveform readback.
> - Allow sub-cycle duty requests to round down to 0% instead of rounding
>   up to one clock cycle.
> - Normalize high-time values greater than the period to 100% duty.
> - Drop the redundant AX3005 OF match entry and use the AX3000 fallback.
> - Clarify comments and PWM hardware limitations.
> - Link to v2: https://lore.kernel.org/r/20260723-axiado-ax3000-pwm-v2-0-22002f0b281d@axiado.com
>
> Changes in v2:
> - Migrated the driver from the legacy apply/get_state API to the new
>   waveform ops API (round_waveform_tohw/fromhw, read/write_waveform).
> - Cache the clock rate at probe and lock it with
>   devm_clk_rate_exclusive_get() instead of reading it on every op.
> - Improved rounding: clamp period/duty to hardware limits, reject
>   non-zero duty offset, preserve exact 100% duty, round sub-cycle duty
>   up to the minimum.
> - Added a "Limitations" comment block documenting hardware constraints.
> - Renamed macros from AX_PWM_* to AXIADO_PWM_* and dropped unused ones.
> - DT binding: dropped clock-names, made #pwm-cells required, and
>   updated the description and compatible list to cover both the AX3000
>   and AX3005 SoCs.
> - Added axiado,ax3005-pwm to the driver's OF device match table.
> - Link to v1: https://lore.kernel.org/r/20260618-axiado-ax3000-pwm-v1-0-c9797a909414@axiado.com
>
> To: Petar Stepanovic <pstepanovic@axiado.com>
> To: Akhila Kavi <akavi@axiado.com>
> To: Prasad Bolisetty <pbolisetty@axiado.com>
> To: Uwe Kleine-König <ukleinek@kernel.org>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Harshit Shah <hshah@axiado.com>
> Cc: linux-pwm@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
>
> ---
> Petar Stepanovic (2):
>       dt-bindings: pwm: add Axiado AX3000 PWM
>       pwm: add Axiado AX3000 PWM driver
>
>  .../devicetree/bindings/pwm/axiado,ax3000-pwm.yaml |  53 ++++
>  MAINTAINERS                                        |   9 +
>  drivers/pwm/Kconfig                                |  11 +
>  drivers/pwm/Makefile                               |   1 +
>  drivers/pwm/pwm-axiado.c                           | 282 +++++++++++++++++++++
>  5 files changed, 356 insertions(+)
> ---
> base-commit: 368d34807e6d04bb2089918383b58abf40e720a0
> change-id: 20260518-axiado-ax3000-pwm-cd7c346849f1
>
> Best regards,
> --  
> Petar Stepanovic <pstepanovic@axiado.com>

Hi,

Just following up on this patch series, as it has been over three weeks since v6 was submitted.

The latest revision addresses the feedback received on previous versions, and the DT binding already has an Acked-by.

Are there any remaining concerns or changes needed, or is the series ready to be picked up?

Thanks for your time.

Best regards,
Petar

