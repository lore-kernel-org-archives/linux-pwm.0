Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020107.outbound.protection.outlook.com [52.101.195.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F623E7160;
	Wed,  5 Aug 2026 10:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927415; cv=fail; b=tva6ofXmJKETqSml9AaTQKHS3SE0s8w/etnIDNyW4Be2QvWX9eX/x5NupRFDzddmuNE377JuSCXkWyPLC9JpYIXCPo1j8TEequQVHfbsbiG38c0Mwjhszc2GvAcDovrkuY3XJx/NE8o5o0oUkOifnhOMh2O1PiFRMmleSZTUDL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927415; c=relaxed/simple;
	bh=MbSE7Rnm1uhAGE4kc9NCCc9yaiqjXUfs8/cRQIxAmf8=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=DFvCoPaCnQd7fi2W/Qqe23P53Se8cjGV93FIjYLrpBjYLwnSOdBfZedrjR9st2EGg/xm7Yobs80oNj1bExYCAPg5otXAjWGMywypmiAw0hlidiuOiEgK/kBPbCsmqpzsGOVi5CO6V9F3p2zEz4RqJri9YQYxAQsUta89IhzLG9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=qAr6SXSm; arc=fail smtp.client-ip=52.101.195.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="qAr6SXSm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ox4PJXmgfpcC1OSJrYUX3amx2SAfv+Xn+EF27HWl98yp0cWCIed72MX8OPFdwExtPgcEzAAIu2Dgxfh9Q25FAeKKv1gdXQQVWh8kBMlBZjSEAuX0Sb696hOR5Y1hAxiypBjqxggzXLq87nRDbHS5BfrZ/qLFwG6hrhBCDCNDiMyOkrXEnjr3lVOcYBGZm6iP9t7FR8pvCnl9J2Fxbrqf32HntUsk3KU0a5Qu019Naqxm2JEy+2pymUse54eilsnh6jQoUs8hcBfRuZD7jgsEo+VWRD/dpE/LIQza5RRRDtyzNcyvQ7QE6rWF8N2ClDNsW1ftxe4BNzazEnIhuGXLEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Uu4n5BLq7NnNYOte/HyNDxB4s1yyYp1t9mgWZj8Dus=;
 b=K4t+eOhsj1Mr4A/3n06Hd3Q3P1nJRRog0uZ4Oe5RZQREMUN0HmDiiFtXl5cyNvFpci8gbk5uQrsE5zntZluuQQQi8qh9io+BoEJP5Nei5Rd2gWQFO1/Kd0I2tyt7z3SMyA3S98urElpfstG0FX+7F9sn23fuD+E2MGEuvQBST423J3vAazcjmCVkkvqtsAP8cdyuxEcYDHvd+tushPc/F11ABzIzm2afn3oA0PnCxrel+UaN+IFBK6bASQ4W9ypTBveWgTKCRYNCqYXP5j7w/O/xFCogE84WoxuqhoZjpW2J8cEO+i1lLgMiAeVFtv8weQG+cZ1mYmQE+1LXs4Db1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Uu4n5BLq7NnNYOte/HyNDxB4s1yyYp1t9mgWZj8Dus=;
 b=qAr6SXSmN/7qLo5beYv5J466jsWZFc9O322IoPGdalC+KIJUOSs+QQNW253ABX15bZDVlQ/uOn0BlS9k/+hZ8iBNYXBcgzCwaVcgaSqZIkLd3Q922OzlIckgBHTsfb1kwlHSEIfKUjv+1e+U/8thU57/DbHJRqXu7ZRIqcPwUyE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b4::24)
 by LO2P265MB3514.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:1a3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 10:56:50 +0000
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a]) by LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 10:56:49 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Aug 2026 11:56:48 +0100
Message-Id: <DKGYFH95Q42E.3GGHZCD6BGWU@garyguo.net>
Cc: <rust-for-linux@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] rust: pin-init: add `ptr_init` and
 `ptr_try_init` and recommend over `__init`
From: "Gary Guo" <gary@garyguo.net>
To: "Benno Lossin" <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Michal Wilczynski"
 <m.wilczynski@samsung.com>
X-Mailer: aerc 0.21.0
References: <20260729-merge-init-v2-0-26adf47109e7@garyguo.net>
 <20260729-merge-init-v2-3-26adf47109e7@garyguo.net>
 <DKGXPILQQPJH.2ISNN9UUFUBGS@kernel.org>
In-Reply-To: <DKGXPILQQPJH.2ISNN9UUFUBGS@kernel.org>
X-ClientProxiedBy: LO4P265CA0113.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::17) To LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4b4::24)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOZP265MB8551:EE_|LO2P265MB3514:EE_
X-MS-Office365-Filtering-Correlation-Id: da7feb28-fc8e-4075-728a-08def2e0402e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|23010399003|7416014|1800799024|366016|921020|4143699003|56012099006|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	okICjLI+6TJqlx58jwNiJNYqDpuaLGjxO4urzrSav2TOkguBOlM3AQd6x9Sr1CR5d3AvrnupP+hlHws1vNxwoMNZVXAD3/ryNUgzLPYrTffYfsauG56htGkhxjyKEcfL+RL5vwezzqJ3hDYk8CV+Y5qFSYukKFplY76Snh0gLzd5T3WQseGTWrDeYipBQ+9CtupIodkhMV/Dig/ne/Ic0ihmQI3y8XOxXprQVCuHdnT7AIXpsfETX8FXL1IjHsVKkUrjGUboKnfMzYv8eok+zSgRs9DCoh8p+znn1Jfj1FUQTNS/hVd21/lPReGMOY6iwBdIHbUUR1IMh2zKykMLb1ovh2eoGr9EEqOomKJ5sptsv78sfMHQmARkKmIBHrhPxBhqBJByuIYdRhdjoHbxTTJlgmpzAgKRzhvrRJWY3w75/FatRZluKeixpe1FalV+6bheCWh0Gw0SvEeIEo/kj7wKlYeOYpLG8nK0Aa1ZNpjFBXJw3a/PdKwHykfRtjxx1IQ5fG2JO/PCDTNjPcEXF/9PC9j3vgHBI/GwV8lsiccw4GStjS3QGz5ulja/Oe1biySukQl3vAOtIvALanbgeJFsLTk3PohGBqLKOr3AfzXe41h4xsXzV8K3dkVtOZZBIChPr9W3OPxy3MXq3Q0SEKcl7A6SyWh6T1dQ3iyQkfoz2kJaiATMqmoMb6QkvlMA6s3L3GYTFNZpWKgFRCKhJw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(23010399003)(7416014)(1800799024)(366016)(921020)(4143699003)(56012099006)(6133799003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDZLbG5Yc3ErTnhxNlVCODNDTUI2cHRrcmtSQ1JtNlVIcy9XRzRMNlZxRi9a?=
 =?utf-8?B?RHJDclNnZGovWEUwUjFYcXJUR1N4a3lPRkJ5aFhmR1gzNzZzM0NMMWZTb05z?=
 =?utf-8?B?SzNsVDF6WVhTbjBsVExJQmJUclQrOHJMOW85RUxGYkwvNVNwSm5QbGpQb0lx?=
 =?utf-8?B?OXhrR3ZSRjNyY2p3bUJZVmZtOWNJS3pRZ3NSZW9tbmVIeS9iZGlKVzRFaFJj?=
 =?utf-8?B?Y2RMd1ZMeERmeDdVK2gxNytBSGhmdlVjT2RPTU0rZFJZRkdtcWduMXM3YkFV?=
 =?utf-8?B?cHppcE9xMXBSWnBNQW1sNWV4V3RQNE9Uck56VHVLZGNla0xWem44bTY3cDVM?=
 =?utf-8?B?ZmEzQWxRV1dsTlo5bWZZNHRYblRyWW9FNyt3S0Z1Q0Z1MW9kMkN4dVc3VDNE?=
 =?utf-8?B?TEZiMjlxT1JOTUxiT1g4Wkw2dTM2QjBCWmppaEphblk2Q0hBSWJ6RlNSdEk2?=
 =?utf-8?B?VGhqTzMyVXZwNExPRXJrOGY5bHUyeXBBemIvcDJtck5kSkJicGp5WERFYldR?=
 =?utf-8?B?M3YvSWZVV3pMUVArb0Zwbkg4M3owb29rTnBDcU1GNno4Vjg0SHpnNVBWNlVm?=
 =?utf-8?B?am9DTlFmL0hzY2NUa21pMW5Ma2g3eGZ1dGNtU0pTUkUrZ2RxczhjbU5mNFBl?=
 =?utf-8?B?bEdmbTV4WDExMmhKQzVyY3ExeFBpYzgrbDRDa0c1NDV5UXBWd3oyYUtpU0Mz?=
 =?utf-8?B?T0FSWkFTejdUU3Uvb3FtRmVycnFtLzJVVHhJUEtGbVNmZ3F6c1FUTkxwODNi?=
 =?utf-8?B?ZlFralhPK01nd1NQaGFaZnJqWVRXVzFQaG9DYmU1Wkhoa1kzTzM3M1JNenpY?=
 =?utf-8?B?cEJRYklwWlNQUEc3OXJHWkJlaWNzVmQ3THJHelA1cUxva2J2QVkzRVArM2xv?=
 =?utf-8?B?b2xXWHNKTzI5dHNmOVNmei9zWUpYZkdXNGZxTmZqY0RheUV2S1pBRENkRXpp?=
 =?utf-8?B?Y1k3aVIvOGF5K0g2QjRoTEFmcmYxS3BQUzFkbG81a2R4elVJOXIrUG53VjNB?=
 =?utf-8?B?MnJSYU5WMzladFZQUTBML1FDNEIzSWxrOEhVek9EQ1J2c01kckVBeEhFS3Fq?=
 =?utf-8?B?NHF6djByL2xNRDlvanp0YWhibmljZGlkelZSOWJOOWNKL1dSTkhNZ3ZJMDBH?=
 =?utf-8?B?d2IvaWtIOEN3ZVpiV0Jaam45VE45Y09JakI4bkdlRHRzYVVDOXRvalY2OXZJ?=
 =?utf-8?B?clZMTnp4NXV6VkpvTFQ2dW5aeUdld0NVY201Qys4enV1RjZLYzcvTDZvS0d4?=
 =?utf-8?B?SDkyQ2pJZHJLZlpUMGw0M0dWQnB5dXpiUHVlM2Z5SCtteUN1L3F0U1FyQjR2?=
 =?utf-8?B?OEtVZWpneDJYcjk4SFlrVDY2RDYzYWZvZVNHbjVyQktTMXlXL3hhNnRjNk5o?=
 =?utf-8?B?cXJJd29BMVNHMUs1ZkhzUHYwWjRuUWRMclN0SHdMa2RyVzBEY3ZlcDluV1V2?=
 =?utf-8?B?czF4SStnbmFHWUgxaGpiMlVWT1E5NjZoYkNhSzYzM1oxYlVmVkwwYy8zbjA0?=
 =?utf-8?B?ZjU1MHU3RWZOdHJ1TWlKL2g3WllQaHBZZ0RldTEydHBkcmRubk9SZ0ZqVzZw?=
 =?utf-8?B?ODg0ZmFaOG5oSzkvYzhOVTVmYlZLOHFRNDdwVllVamN4d2diZkl1ZEZKK3l3?=
 =?utf-8?B?WW04dkZ5b1FqQkFoWWhVM1FTZUdxUVZCRUZDcnF5NW9NbU9mZVBFYjl6ZFEz?=
 =?utf-8?B?NUJIby9XaEhpbW9WZVVhSWVybDdIMGdEVzRHQUJsM1hmeWhBRlVmRlV1ZEQ0?=
 =?utf-8?B?bjg3MXI0RWFkQzdVaVZsUXQ3a0thRWc0QlBKbVZyOU5TSnUwV0IrRWJPME5j?=
 =?utf-8?B?dXd0TEE3SFcvTncrYUNuUzdVZWlBdEM5ZGtyREdHMVVuMlFQNzg1aTBUVkZ3?=
 =?utf-8?B?aHh1T25SZ3lmYjJFWGZjc3h5ZVFQVzlCU2h2MExuTGxCL3ZZZ09HYUlrVTRM?=
 =?utf-8?B?R3NSNzRxMWVrVXRoZHlEMy9KYm9PeUxFdm92VzhHNlFFT2dieHU3dWNsMXlv?=
 =?utf-8?B?UUE0ZzJiY1ZJUE1GV2pSWlR0YmJacnhYY2Zab2o4bnZMQlhhSTRza2lObXhx?=
 =?utf-8?B?TlRQMXNtcURHRVk3cnNhTURnUmFSdTNFRlU2STd1UHRLQUJmYnJoVzlxYlhw?=
 =?utf-8?B?VjB5QzNZbXMvbTRqQmtjaVljNlNMemhBWW5wSHIvbWM4ZXpVdEdNcDg0S3dY?=
 =?utf-8?B?TlhIRUkrZUFFdU52RGVjbGlVeUR0NjZmTVF2WWl1MHZTVUlSajdqR0FIZTl0?=
 =?utf-8?B?c1I4WVozYkFYQitCYzNXdVFqOXhZZFJISEc3TlVGdGd0UndwZGJYQTRkYnJB?=
 =?utf-8?B?c3Q0eVhSNmRNdDZvTzZPOGMvS2ZpY0tEbEhETnhlWHNjaU92Z3A2QT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: da7feb28-fc8e-4075-728a-08def2e0402e
X-MS-Exchange-CrossTenant-AuthSource: LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 10:56:49.8039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWHw+6YrH/jNNB+MXluzCVaVIw9VOPTW6ImIZxve5R5BO9RiYqU4MEv6oEUP+ORbapEXFdKcipFMwN5oDxAxlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3514

On Wed Aug 5, 2026 at 11:22 AM BST, Benno Lossin wrote:
> On Wed Jul 29, 2026 at 5:38 PM CEST, Gary Guo wrote:
>> The `__init` method is not designed to be a public API (existence of "__=
"
>> is a hint for this); but currently there is no other API that allows raw
>> initialization on pointers. Add `ptr_init` and `ptr_try_init` and recomm=
end
>> people to use this instead if raw pointer initialization is needed.
>
> How about we call these two functions `raw_init` and `raw_try_init`
> respectively? I feel like that conveys the meaning of what they are
> doing much better.
>
> With that: Reviewed-by: Benno Lossin <lossin@kernel.org>

Hmm, I agree that these names are better.

Given that I've picked these to pin-init-next already, I've amended the tre=
e.
Could you check the changes I made there?

Best,
Gary

>
> Cheers,
> Benno
>
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>> ---
>>  rust/pin-init/examples/static_init.rs |  5 +++--
>>  rust/pin-init/src/lib.rs              | 32 ++++++++++++++++++++++++++++=
+++-
>>  2 files changed, 34 insertions(+), 3 deletions(-)


