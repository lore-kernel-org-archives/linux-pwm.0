Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.195.73
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795790660;
	b=d/wxh3Bc48ctYL1xJBjUKnvwcoWB03er/+5OXPK4HBPZ8C6EWcN78Z9FS+ObZbb5QMRo
	 HfYp0rSgPpL3PpO+yuH7qpuzwV/pMv+elRzvZueidJzSmVA4axCTygzfwWyv2Bhf530To
	 V4xI2o9iDPYFgHJREPAqGdA6jT8Uhx0jy1qSC/V1r/PL5ufQxzEg4IuGfPKXDIN2xmt7f
	 qpSJyVpJbB5DbrIo3pA9c22Ir4/vO3pCQFJUugMShctzq7gJO3UtK4HqUdM6hQ6XCaSN9
	 0pYZqJH1AMWuiede989prRwlJSMN2RufqHgbDgA1Q+wyhxcFwOUtHTAeCK0tfkHGGsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790660;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=2iv+XxnEZhNJiYBn1hDVSTm99gtyKx6icOcObKO0vZ0=;
	b=0d6ZkPMmBuhXLs+4EX5pSdAeA+Ek0JPfKHLyGfxGKR+zAvq+VV/bs/sIvZMlIEGRzkIf
	 r293YEX1VCeMmF9Y6AxvGtJjcKWC+n44jROQTfNPyHB1hYXcLd+6VhTZzXe3uVaHX+SvY
	 efWhBnG1uaJjbJtiuVdOZJqHCdb4smbjrZiMDJXs5XMOM+sD2bsmep+n7hOZqNkOVvQCI
	 E/UBAfPIqK4CO02HlfkRNng+0dI06YtNYOKFckybDjgdV+gjDMW+LMUmo0mTOOzNJJe1P
	 mWge6aUUMLpiPMdfIt3Qae5DV/lUpermZhoHlSQbOCsADXokbm+FyHh6tiCxV2lp5Ug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=garyguo.net;
	spf=pass smtp.mailfrom=garyguo.net;
	dkim=pass header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=FfSFj8XG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.195.73
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020073.outbound.protection.outlook.com [52.101.195.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B2E606A324;
	Fri, 27 Nov 2026 14:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69B2E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=FfSFj8XG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8vaUUGlzkiuFtbHx4BwD3icnKOB89qXFi5S2iQZgMCNZzWUZI50uc1t+dWTIrYkOic6gdUwT12aTHtQXWUhm/elud81OGbhp7N9YTT2kKJ961vGCZ2n2icBYZPdsNanOfLBSxrciGKOouw1oWaspC2TP3wn7EvnFRLkHFM+0y3A+1j30t7BycKqgmMLxl/3TvQ/NqsU3UHX09yLFnqdK6jULN2xYXeRtMGCprEKFpYhuzUqyJK4b/jaUmyQKudID5FKopEC0f0qyJZ40iViFu+b3jtm6yBX+/Wj+bYp+WMREK9rEyrTl5Qm3QdHgDkaS5WPVhhe9MiKncStyUPF0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2iv+XxnEZhNJiYBn1hDVSTm99gtyKx6icOcObKO0vZ0=;
 b=KN9AweXLK5cRNtqsRRNHfc3QwgPvAo3eq/MO5spcGaTn6+onv7vdmGlrA4rATQ/bEW9QcwEbtbTCh7NAjX3AbvrESSkj7PgIGkCe26jbifUXbgUjXUPE6fs9G6DoJEVgKcuHnChkXYUWznEY3AmMZJJ3P8zivnmXpzmXwxSFqZNt6RaD5FxKSJmj8/pnUuwLFfbW2AgTcZRyKHL0DLOaSDV3Q4a+Azr9s/x+QBxDG9muc/CmyVZFKUbHsehL5vrrtNXZvPpmWMCSdrN0ao52kdqTchyuRaPEmHGz26whUDAJ3GaNnz1s/Ggs086n4QIkuNMo/HXwCHBEz9b9VnvuNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2iv+XxnEZhNJiYBn1hDVSTm99gtyKx6icOcObKO0vZ0=;
 b=FfSFj8XGMK39AdwO4EvpdOT1RQlq8wYCGQDnnttIf/rn7JEEulM6JNP0XbVcz+xLCMe2/biIngK27CJSrwQZLrTNSvGIAj5VHnfS6Wd1RVVSSZzApe8pWlpMPegHBctPM6IAPRf1O81zF+Txc165RQZJ7glirj8dtHBcwftavvM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by CWXP265MB2823.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 14:44:18 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 14:44:18 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Nov 2026 14:44:17 +0000
Message-Id: <DN62NR2K4UO1.3IGAV5O5ZILY1@garyguo.net>
Cc: "Michal Wilczynski" <m.wilczynski@samsung.com>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <dakr@kernel.org>, <daniel.almeida@collabora.com>,
 <tamird@kernel.org>, <acourbot@nvidia.com>, <work@onurozkan.dev>,
 <elle@weathered-steel.dev>, <linux-pwm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <ardalan@uci.edu>, <zhiyunq@cs.ucr.edu>,
 <dzueck@uci.edu>
Subject: Re: [PATCH 1/1] rust: pwm: reject over-aligned driver data in
 `Chip::new()`
From: "Gary Guo" <gary@garyguo.net>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, "Priya Bala
 Govindasamy" <pgovind2@uci.edu>
X-Mailer: aerc 0.22.0
References: <cover.1794600927.git.pgovind2@uci.edu>
 <CGME20261113202542eucas1p27ba92593376041c476afa9c5286205cf@eucas1p2.samsung.com> <caddec5478a0d39a73152247a60bc21b3c609cc7.1794600927.git.pgovind2@uci.edu> <9ee41556-4a24-47b2-9db3-9665048658eb@samsung.com> <CAPPBnEbnBPsYxE5ZXPkhGfueMoYD6DAH7dDrR=wRcq_mD686fg@mail.gmail.com> <awlMukHhET0ALF2j@monoceros> <awlNXMCAAlf5trfM@monoceros>
In-Reply-To: <awlNXMCAAlf5trfM@monoceros>
X-ClientProxiedBy: LO4P123CA0513.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::23) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
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
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|CWXP265MB2823:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e339c7a-c237-4a78-c2b2-08df4c94ea52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|23010399003|1800799024|4143699003|22082099003|18002099003|10067099003|56012099006|261028144727099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	3nQlj89qCKSlRKkbpLJvTLkolFNUJiGwDYoKczMON21im3WQVfd0zKx4KK0/BPrPI5woHoJyf0nSPWfBZwC+kkl+bP/o4ydrKrzAh/iwYpmMm9KYkatInCGO2oSXsk052nz8ZlKwOtwXZ6ANyMvpP+I3YR4doeGrBSc8BHvPOeGklUZHZwgBCPvBaCfpY+wnQE7uqLKrLlwXhg2dtfVGqlbugKjMgNLdi/zs/WTHlsgULpHglQQutdJWhaPc072xIa26ZjF4uoVAdbtNU2pR8PBwQmQsp4NQai/NJDWYsSDps9qhZny/D69IEsdUQQcO9XdM4yfJ9y2FRO2PgrOTbCt3fiEVo12OGH7NaH83jklwV1XxTUZhxzogGwBWZc8ael380BUlXWD5/afT9/7kyO4Ynpwo8Of0ohkcOtkZBKocEHEHEGcGQhegAPvfWmvW4GSE0NcIZdrLo1pa1W9m+7QVApJo6Vd0FS5GbC+QnAJ8my3YNAjFjWzoz0mOqBWujFsmm3gY3yU/qAktZFUizrW5h2BHRHEPv53jLgQz8fQsjc4bBg6ByURYUwx2APWcWSvGZMC14xqdPTwwIm3b2SyAEGwuRuPMPXlm6ccoOMsWnrQR29wvYn3sb1/+UTdqUiphcv9EU6CLMkHantuBOg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(23010399003)(1800799024)(4143699003)(22082099003)(18002099003)(10067099003)(56012099006)(261028144727099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnVJMWRVVUtmVzRtNk13ODhibndUcnpvb0J0WjMwdHN1cTlsMDNTSXZsVkZo?=
 =?utf-8?B?eFZycW5LNUpqeU5FeStXcHNaTDVCNHQ1cm9qY3V5Ukl0enMxajVic2oxOXlB?=
 =?utf-8?B?WUorZVR1TXRlWGMyakprMDNGMVE0VGl3UnBRaElqYnBVaXR0MlhyT1RPb3ZY?=
 =?utf-8?B?ZVRZY3A5eUJmYllmbEg1TysvN24vUk82L1BDOUt5RmZ3RDFnNmk3Sm11MGNM?=
 =?utf-8?B?N1JkYmZjMVovSE9wM1ZWcG8xU1lFalBFaVhvNE1vV3p5aEdZVEw1Y1lLbVpM?=
 =?utf-8?B?a3lGZi9YS0NWZVRid0NEZUVGTlhKTHlwRWxVTzZzajkrRjdlYjhXWnBlRldq?=
 =?utf-8?B?NDQ0empCQ2VwVGR6UGNyWnd5d2wwcHlPZHpVSXZsQmFFLy9EaXBiWVgyVWwr?=
 =?utf-8?B?a2xaTkozSmRza3FyY3dNdmFROGVKOVh3ZGVic0orb2RVdERyUTNCeUw5V3lV?=
 =?utf-8?B?K1UyWU8xS3RKbjI5SFlISVFMOWtYNGd4U0d6N2JFc3E4a0xFc2o3R01XZ3Uv?=
 =?utf-8?B?SmZiQU5JM1NoWEV5aFF3L1phS2orWHVMZFFPQ2xCa1YwNzN2Tm5tUWE5RUNk?=
 =?utf-8?B?aCtUY2NNZnM5RDNaUTJyaUZCaEE5MVRFUG5uVUlDencyQVMzTFJyQ2orMHpk?=
 =?utf-8?B?ZlJaNzMvWE92dW5WaGlKeThsK29OVWpmL2ZCaGlRME9WRlYzaDV6NC82TXN3?=
 =?utf-8?B?UUZwVEFjUHhHZ2NKbVBrS1hXaDlwMExOS09jRHlVS09udy95bWdkYndYNWlz?=
 =?utf-8?B?RXo5NWZWWmwvUUVSMWwyUnNkZTRQTWhXMmJEb1dZaFBoUENlelRpNk9udnlB?=
 =?utf-8?B?TFhUUFVDQytwNVNpOTdTWHdmOUNlZitXYWw3NkphWWU4dm9wRXBYZDRXZStp?=
 =?utf-8?B?bTkvSmx5NjgyWlc1QlVTdWpqc21zbmxrNjhkdng5K1NKZGJMSTJsZi8wbWR1?=
 =?utf-8?B?WHVsa0RTdDhWQWhyV3R6WnRUS2p2b25wRytKc2R6b3Bmc1hkY0U2bGZuSjRW?=
 =?utf-8?B?T1QrK042bHc2OFY5bFg2TG5Wd3hRdlJFRGRoR1FjQlB5cEZXUlFlRHpNWDBF?=
 =?utf-8?B?Q005Q0dOWjQ3ZWY3OEFKenZxcDFNZFFQcnAxZDQ3cWZOeFRkR3EyTzd6aFdh?=
 =?utf-8?B?MEtKaTU1dGtsbXl2Qks1YmNEUjIwVzFhRi9hY0xiRC9wZEpERDVYdlljaWZk?=
 =?utf-8?B?YmdEWXNiUUtiTDkxck1hTFRINVhEWm55RWlYaTArbzFBbHFlc3pqQjJYdksv?=
 =?utf-8?B?bjdmbk5jTlIzQ0xqU05NVnhUdWw5aHI3aVRjRmJ2YUpQZEQ3L25udGxuaExj?=
 =?utf-8?B?M1Q4dE4vZG9ZbzRKczNUM3NudVRnQjFKVzhYSy9wblJiT2d3Y2FrWWszNUEv?=
 =?utf-8?B?Z01DSUNWaUc2V2YxazZYNzIvOUJqNjFlaEFsU2plTUtzbzJFaVFVWkh1Qlha?=
 =?utf-8?B?bmVLVEtHOEdCVlJVeTBmaDVJb1RXNWhZNmphbnd3Z29QMHhpN0xKTXM5Zmow?=
 =?utf-8?B?WFUyOEtxT0RqZzdYb2hrRDlNQ0VOSmZROU0zOCt4NXB1U0UvWjU4alZtd2Jn?=
 =?utf-8?B?cU1pQi9RUlBPME95cit5dktwZmV5c0RtcFc4VkxYMTlmclA5WEZlKzJvcUJw?=
 =?utf-8?B?Tk8xcmp1K3ExVytLaUJWcDJ3a2lITEc2VzJkWFlwZjhRRmJLeW52RlZ0Nkow?=
 =?utf-8?B?WjhFUks2aGM0TlFCUXZTbTlRWnNJYkU3WUFGYkFaMWtEelVDWVRpbmZVL1BL?=
 =?utf-8?B?OGVZT0JBTkJHMitVdFRwbjVuWVc0YWVsMENBSE8wVUI5S1c4c0FSSkNCbVZk?=
 =?utf-8?B?MXNFMmxwUzIyWjhvbWlnTEpHZ2h4aU45S25tL0dBUitjUk9SanE1T1NQbGoz?=
 =?utf-8?B?NUM2b2dxcEx0eEdHcDgraTMrVS8xVUNJQUVvd2Y1SzZUWXR5bXpSb2VIejNj?=
 =?utf-8?B?Q2xWSzNIZDR0R0NaV1o1VDNFTkx2ZllqRFRhMFNNb3UvQWRDdng2Z3kxNE0y?=
 =?utf-8?B?R0tjMHYyRzRnZjZjaTVVN1VYM016R2tvTmw2VkZycnhYeW5JS1hxYWNZTk5S?=
 =?utf-8?B?Z2FHYThja0tHdC9ZaE1DY3d1RzY0VlozTTU5VGR5WFY4MjRJUzVWSVBBTzNi?=
 =?utf-8?B?VXhGbTkxai90MHovTXVFa2hpRjFjU2hoT2M0WitXOElUNGd4N1I3WmYxK3p4?=
 =?utf-8?B?RUt2dmVLNEh5RlI4ZE5tbGtGTXozVktHNHl2ZXI0aU5RZitNQndQUGZ2QklM?=
 =?utf-8?B?YmJjaHpnV3F5bnU5d3BnTFI5cVgwZWhEK1l6V0IyVU9NbDRoY2UyTWhhR0lq?=
 =?utf-8?Q?Xeml3Br0l+f7M8QUWY?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e339c7a-c237-4a78-c2b2-08df4c94ea52
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 14:44:18.1385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mG7PCfQ5MumnS6mVIBZKh2N0crqGgl9eofMrFN4i1UwiN1b+ZarGkGtCVZejeoWHttDFYH7aIrVC/kSqBxdzBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2823

On Fri Nov 27, 2026 at 9:31 AM GMT, Uwe Kleine-K=C3=B6nig wrote:
> On Fri, Nov 27, 2026 at 10:28:09AM +0100, Uwe Kleine-K=C3=B6nig wrote:
>> Hello,
>>=20
>> On Thu, Nov 26, 2026 at 09:38:59AM -0800, Priya Bala Govindasamy wrote:
>> > On Wed, Nov 25, 2026 at 7:42=E2=80=AFAM Michal Wilczynski
>> > <m.wilczynski@samsung.com> wrote:
>> > > The C layout uses PWMCHIP_ALIGN, which is private to core.c. If Uwe
>> > > agrees it might be a good idea to move it to include/linux/pwm.h and
>> > > assert against that, so the two can't drift apart.
>> >=20
>> > Thanks for your comments. As per Gary and Uwe's feedback, I will
>> > shorten the commit message in the v2 patch. Just to confirm, for v2
>> > should I only update the commit message, or also move PWMCHIP_ALIGN
>> > into include/linux/pwm.h?
>>=20
>> There is precedent on a symbol that is only in include/linux/pwm.h for
>> Rust. So if you group PWMCHIP_ALIGN to pwmchip_release() and extend the
>> comment accordingly that would be ok for me.
>
> But having said that, I wonder if PWMCHIP_ALIGN is really needed. Isn't
> is possible to just check after pwmchip_alloc() if the alignment for T
> is good enough? Hmm, maybe that doesn't work as it's a runtime check and
> Rust might want to know during compile time?

It's better to know it during compilation time. A runtime check may risk
"accidentally being aligned" and then you get non-deterministic failure tha=
t
depends on allocator behaviour.

Best,
Gary
