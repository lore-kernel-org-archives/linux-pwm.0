Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.99
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795881801;
	b=f2vhB9/AqeLsEcmqLMc+Gn6uYmznmwcIRM+P5KL/ZLeRwWc/CAg72rcip34t9sdC+Kee
	 mGnZjXXF6ZSiTFd9weFzIS8lkGP3Wer3rhJp8VjCWrCcGH8vepCkOGIk2IbkKeje+SkuC
	 rdOfNu2VWxBSNhrb94PQXDVPWejpAyE/eOMqc3ByLOPauvyCAKKTTvmG1zCk1jpj9LzVE
	 AtqlnN/433jkaWYFaLjEtORpJ610nAO8E8ajum8j9XQYaEROUcUeUiG7jSRwewYSUaa4p
	 gZn/b8fHx7IBKAsn14F95BHeV30GaReTMMpPNyfPIa/HdAlRMe1G2pZLGSVScpK2tfQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795881801;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:To:Subject:
	 From:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:MIME-Version:
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
	bh=LUHp9dVrRl0wD7/huE6jp+kmf3gVdXZjDi3/leTq+vs=;
	b=VwNQswe1F5JabMyI1TC6MDqD7iesO+dJOHUzM7N2b3xKQBTMFwAHUaVgAWyYXOBaBF43
	 htwzxNXRyhHkqvo9qxRqOhxniQbnKwZEKzgI7fWvSAHQWGXn3Ip+JiSXLeRiznMXUdq3i
	 dSzXkiNz5JTNudC7FyLs6miBEIdtn4Vn67l4qs3Q+uZ0QiatD4Jm3OkxPUH6ZYNXJ43VH
	 XMiea+vE80yiv6CO/GwHevn6FXvpz84p9xAdBF5OvQC1eJKme841bEwBgRba2CeDMxah7
	 0GMK509aumixhA0AQH4+gMA5EafVnMscoqUueChqnkEdMkFA3aR7MEPpvXeJGdTJODw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=garyguo.net;
	spf=pass smtp.mailfrom=garyguo.net;
	dkim=pass header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=a6JZ9Nmg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.99
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020099.outbound.protection.outlook.com [52.101.196.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FC7606A31C;
	Sat, 28 Nov 2026 16:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47FC7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=a6JZ9Nmg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2/M8Fp/7yddlvv1eHTyhX53jLkBIqVaycOQxugQw8x6JbzwEc/m60PrX5benhXy/HNK9Tr3ctxQiRA6klodUtiBAObpqwt+yNcxLRHKRS2zdtsx3rN0+v7ov5GdQ7q1CvkiXESbhAoFvyBGuDXK5QVyLeJYktKRX9ANbFnIOT7hZvfDaxiHrO2LjwMhvITB0YLCq3xMgJ4HRQTyZ4HAVeJmCWYXVH2Jtep79fDSoAbtfYRfFy5ExznRKHxMu3pKGtmVGlVzf1xWwuVZ6vm39mGBfz+uSjm/eYL/W6Gp/yr34tcoov/JkJM7fodu+0bCJryqkgk9GssX6TSmu/kwNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUHp9dVrRl0wD7/huE6jp+kmf3gVdXZjDi3/leTq+vs=;
 b=IjxCO34o/ylPqUvFi+Cjt9CMNVVUIjwQqlNcqN9uzGeXgbJvKKY9qbobEIKeHIc/c/eKwhKsyN+n4sHJwIx93Hrvb1DkrPMz62UF/UvPcfELSno0uOoe0dQ1P9Xv+uQr76tQb4d58N8xLiSVhUM7CicIjLLZdZgzw3zMgNIt0i53hr9JJJ7FO2BNM+hqOYr0IKXjePZRHNmMAhl74CqdwtBnKFnLs7TZsk7FYFZti2HoIiBiBZHm15k60yAV5gULAIimFdtk7xXHPl22aG6tYH53/FaaxjMkOKnPmPgJqJ4nBxuvivm8LaLvuCYs/QX0OoAFEe4xrwcIEiZhc+g1Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUHp9dVrRl0wD7/huE6jp+kmf3gVdXZjDi3/leTq+vs=;
 b=a6JZ9NmgSK2BozpTN2PWwlbvutLrmZBSM3SuTM6nIEOs4monWAW+RAP1Ha+QmAL8IgjAOTW9tEcCz6MnVejeiuJxhKv5JZvuPY5uY25mPygMmI26VWXUh7zs54OlLgJOw9eYdaptqBXxJXX982EGYONLWgr7QjvcgXijl/POIJI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by CWXP265MB3655.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.11; Sat, 28 Nov
 2026 16:03:17 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0662.007; Sat, 28 Nov 2026
 16:03:17 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 28 Nov 2026 16:03:16 +0000
Message-Id: <DN6YYRN9LCNA.2B6TA03Z7L33G@garyguo.net>
To: "Priya Bala Govindasamy" <pgovind2@uci.edu>, <m.wilczynski@samsung.com>,
 <ojeda@kernel.org>, <ukleinek@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <dakr@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <acourbot@nvidia.com>, <work@onurozkan.dev>, <elle@weathered-steel.dev>,
 <linux-pwm@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <ardalan@uci.edu>, <zhiyunq@cs.ucr.edu>, <dzueck@uci.edu>
Subject: Re: [PATCH v2] rust: pwm: reject over-aligned driver data in
 `Chip::new()`
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20261128032029.9516-1-pgovind2@uci.edu>
In-Reply-To: <20261128032029.9516-1-pgovind2@uci.edu>
X-ClientProxiedBy: LO4P123CA0214.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::21) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|CWXP265MB3655:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e290666-6eb6-4fb2-d2f0-08df4d691d6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|10070799003|1800799024|376014|7416014|921020|10067099003|56012099006|260925021911599003|260925021311599003|260925022911599003|261028144727099003|261026140227099003|261026121527099003|261021123027099003|261102123227099003|261022105027099003|261021121427099003|261102130727099003|261022075727099003|261009223027099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	+9QpT8oaZQiinUw+euXfnRsS0iqsj0Va5gOiTRXc34nrYWoo9iZZT0TYuuRc4AOkV3qh9NsZl8anCkHMEV98Z5OCPIxsjC/jGBg+k0RHFmT8YbY1kMjtSgbwmft9Lrn5jhFMpptnKjXbb5NWOoauAGTj0kxlikHJiKv/OkDXX3ZmXAzwioyun5jDcAa3GyxpaKH9vvj+zd+8gcIWuR/GKWd3mT7Lzwln2fPCJw6DZmOYNSZKvaPZfZUla/X6jNgNVw3NP9wD7GYSJYH+luQmuTiu7a7tyDXKDAZoUtOZM9JDFoWvC1QrrxVO15RnopHwZKiILYFhxv3mmJ9OG251onCTTXDSe6r0B7uq9Wi5tKq6bCINvNrrPyfd9EO6+Zpc15j0X/mpozqOPk3cf8iNrab4sAPb9eUyvErgvtiAnITKf61eoNimsiOgFx3RRqBf7vg0uovSyzTMOu3WPZJpg1BTfZ/b0KDPlQ5k7QmocnrUD2BieY+IR0nxTqy9fbvTPrjuji7CFgtLcQzgeYGaWUHfW1dMXaX7NqYAPy5ywomVNxSvQfa6JJAcCvvREIbhu7nQi83ygvMPJ/cxyiAQI5lP4vt8z+7AV+TJOe0aHlVp3nC0iyKzr/j6kv5Hwgmn8bfWNOYdSkD05Uyc8j8QGeiKKH5EaM3PSeRAvKRekRw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(10070799003)(1800799024)(376014)(7416014)(921020)(10067099003)(56012099006)(260925021911599003)(260925021311599003)(260925022911599003)(261028144727099003)(261026140227099003)(261026121527099003)(261021123027099003)(261102123227099003)(261022105027099003)(261021121427099003)(261102130727099003)(261022075727099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWcxVEZ4bUU1d25iVkhpZHQvY21leVJMdlhYNmt1SlpjcUx2ays4OGtEb0lB?=
 =?utf-8?B?T2dOT3ZOeGhRVmN4aVh3aTRrUmJReU9CaWY3aHpuQTRsNVl3bjREZFEvNS91?=
 =?utf-8?B?Nm5IcmNadEtvYkpTbm1iOVNJWm9SeTlPckl6Q08xNUNWVDhBOVBYeUd0ZEhR?=
 =?utf-8?B?c01jTVdMUzl3cGt4dWcwMUZrQ2J0YkFIUS8xWVF4RDFwR2tzbjhyNUp4Y2Nk?=
 =?utf-8?B?bm4xZjUwSWhiM1ZWWk5pVzZLMW8xcG4wOGY2RUxhSUNMTFhqaFpLS3RGbWo5?=
 =?utf-8?B?U013ejF3UnR3M0tpeXJXSWNBOG03NTJMcGt6NjRaNzlhVkhESGI4dkhidlYz?=
 =?utf-8?B?NlR1c0R0REV6eENoRGFWbWhpVytEcEMyS1JMSUhDSndXSGx5bDJMMjBnNUNo?=
 =?utf-8?B?Y0EyM1F6dks5ZExnM3VLdmtoRUJkNkY2b1h5bUF4cUZFTytQK3RQUEFDV3cz?=
 =?utf-8?B?Z2F1djdyb3NvcVVFRkp3VUNPZGwwMnRad1BkUFFiOHZDbG9ING5YSStrN2Zj?=
 =?utf-8?B?Y1Z1dXNyV2Ntb3lxT3dsNXZiU0dVRkNFYS8zMkVnRkNYaDl2MjZjVVdEbmN2?=
 =?utf-8?B?OUJWem9GNmM0bmc4N2paWlpzRnZKQllza3plQ0t4OE54OWlTemNyejl5YWVI?=
 =?utf-8?B?Y05OL1QwQkU2emdCSUY2QkxnbERMZjNtQnNJMHF2dkJIVkZzZ1k4YmhYTnlo?=
 =?utf-8?B?Qm9xakRYcnBGdkZXc1RlVHpPMjJ5VU9pSVMwV00yRVppN29MZVh3ZFZvOHMr?=
 =?utf-8?B?TjAwd0VFZko5VlQ3MWYrblJMdnM4NklKVHBPUnBKTWZTaFhOWlVCaWxCTVVS?=
 =?utf-8?B?WEhNanVFZjZ6TXRkT01aRjc2YkxXSmJaeUFiVTdKZE13ZXFSTWpTVzNqYlZD?=
 =?utf-8?B?OWR5aVMxZXQrN3RXZXdreWZyWUpKTExEQXA2NkVwTDVKS2U0d1NKcmNNQURv?=
 =?utf-8?B?UE1qdG05MWt5clBQem1hUVZwL3pnMUpOejlrQUNlem4wTTVnSmxmRFhQZzVI?=
 =?utf-8?B?L25Yd0RxdnFEcTEzWkVkeWtQSnEzKzNQSlRObkF4S3VxcFUvY3dHd2dvUmpR?=
 =?utf-8?B?RWdCaC9iU0ZTd1dvS3JMTHFHQzNsTXNDWXJiOXh6ZzkyMVZLQ1JCSzJ0dWJU?=
 =?utf-8?B?NEJEQ0FhZjIveUlQZEI4RVFhaXU2Y29qK0FqR2lScXp1ZkgyckV6V0swZnl4?=
 =?utf-8?B?Mk5BM01KQWlYVFlKd01Bcys2QVZFNUY3L3E4UTBWM1cxTkp5eVpIUjRTV2Mv?=
 =?utf-8?B?WnczZkpaZnkxeDZPTXpxVms1eElsLy9NNHgwMXFTc1VBcjJmSyt4WTgrYUhi?=
 =?utf-8?B?WlkwZFBEQ0VMMUFBU0dTQlhSTzh5T3pDL0xmOVNiNXZtR0JqUVA1V1ZwQXR2?=
 =?utf-8?B?K21KQVl5TExHYXUvS2ozL0JWK1Jpb3YzQTB4STU4TVYzREtISTRSMURZd2Na?=
 =?utf-8?B?a2VRaTN0RVZrYnlvekVGeTUra29ZaXRqOHF6L1dCV1dKOENNNDN6c0hBQmt5?=
 =?utf-8?B?ZDNHbkZZVDNrVy80dStjTG1pbEtHL1BDbDRFbjZjblFmSWpwMWJjYzUrT2h3?=
 =?utf-8?B?YVJORUhXQ2xjakpOYmd6M3EyeFBCV1JSSG9hSWhYRHRnQXVMZXpYNUZNZmhk?=
 =?utf-8?B?RHR1MGRGQmJyZG9IVmNWZ1BFMFNpbFVnOVk0bGp2MEp0V2NDZ29rci9yRnpD?=
 =?utf-8?B?MFFJZjE4Y2JhQzV4YWgraEFKWWhPcFBaTGhqYmRTNmVFVkNoSU9xL1FzSk4w?=
 =?utf-8?B?TXVSZUE3N3VTZ0swY1lrL0NHYnNqUjE2VmFOMVVxaTRFUEo3NGlVM2lzSWhs?=
 =?utf-8?B?M2tEU2ZjSXRVR3YzN1d6SGJFRkI5U1dRUE1LQnE2UGN3Z2E5OEZYSWY0OHln?=
 =?utf-8?B?OCszWEZYcVNqQmZPLy82dEZ0QVhISWNmMk5zQ2ZEMFRydkF1T3Bqamhab2s2?=
 =?utf-8?B?dklVN1k0eDFUWkF2aDZtK0RCQm9xcitDNWYxR3YxZng2RnlZRytDZGRpT3Ix?=
 =?utf-8?B?SlN1UjJmVUFBd1R4WVZlV3ZDMUZzYlMxeWZINmdZZndEa3NBWVRUcWY2V25M?=
 =?utf-8?B?eGkvRVNVWkh3VjNJQ1pKbUpYNjg1YzNFLzgySnVibzVSQlkvcVBxNll4NEZM?=
 =?utf-8?B?L20xbS9zTTJHSVVJc214Qm0rZGE3dVFKREM1ajBGckFwTCtNVG9mVzY5empJ?=
 =?utf-8?B?d1kyOXpwQVRJQWVZUXNQMHdUYmtNVk5tdnFja0RDQ253SUM4UlBnU3VPRmQr?=
 =?utf-8?B?QnNlU1ROSmFKRUN5dWpST3c1TWlCN2Y1SHIvejNENUNJcnZwclI0NUNsYTJQ?=
 =?utf-8?B?YjE0eGIvNWdEeVRubVQ3Ylh6bERVMlEvSTk1NnVDSXYvUzlzRkpiZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e290666-6eb6-4fb2-d2f0-08df4d691d6c
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2026 16:03:17.1890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ldr7Dr9W4LLQNsz2ImL3oVlYblVqHfek6a+NqWRx/mp0YDg/ZRRcf5fSdhevm93CD36gf2nUi+wjCop0lbovnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB3655

On Sat Nov 28, 2026 at 3:20 AM GMT, Priya Bala Govindasamy wrote:
> `PwmOps` does not restrict the alignment of driver data type `T`. In
> `Chip::new()`, the call to `pwmchip_alloc()` allocates memory for `T` and
> aligns it to `PWMCHIP_ALIGN` only. A `T` requiring greater alignment
> can receive a misaligned pointer.
>
> This is a soundness issue and it is not triggered on any of the in-tree
> users.
>
> Fix this by rejecting over-aligned types in `Chip::new()` by asserting
> that T's alignment does not exceed PWMCHIP_ALIGN.
>
> Fixes: d8046cd50879 ("rust: pwm: Add complete abstraction layer")
> Reported-by: Dylan Zueck <dzueck@uci.edu>
> Signed-off-by: Priya Bala Govindasamy <pgovind2@uci.edu>
> ---
> This issue was detected by FerroLens, an LLM-assisted analysis tool.
>
> Changes since v1:
>  - Moved the definition of PWMCHIP_ALIGN to include/linux/pwm.h and remov=
ed it from drivers/pwm/core.c.
>  - Simplified commit message.
>
> Link to v1: https://lore.kernel.org/all/caddec5478a0d39a73152247a60bc21b3=
c609cc7.1794600927.git.pgovind2@uci.edu/
>
>  drivers/pwm/core.c              | 2 --
>  include/linux/pwm.h             | 5 ++++-
>  rust/bindgen_parameters         | 1 +
>  rust/bindings/bindings_helper.h | 3 +++
>  rust/kernel/pwm.rs              | 5 +++++
>  5 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 4c6d716e5fde..520e5b788958 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -1594,8 +1594,6 @@ static void pwmchip_sysfs_unexport(struct pwm_chip =
*chip)
>  	}
>  }
> =20
> -#define PWMCHIP_ALIGN ARCH_DMA_MINALIGN
> -
>  static void *pwmchip_priv(struct pwm_chip *chip)
>  {
>  	return (void *)chip + ALIGN(struct_size(chip, pwms, chip->npwm), PWMCHI=
P_ALIGN);
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index b11ae91723f8..efd14a777b44 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -490,8 +490,11 @@ void pwmchip_remove(struct pwm_chip *chip);
> =20
>  /*
>   * For FFI wrapper use only:
> - * The Rust PWM abstraction needs this to properly free the pwm_chip.
> + * The Rust PWM abstraction uses PWMCHIP_ALIGN to check the alignment
> + * requirement of the pwm_chip's driver data.
> + * pwmchip_release is needed to properly free the pwm_chip.
>   */
> +#define PWMCHIP_ALIGN ARCH_DMA_MINALIGN
>  void pwmchip_release(struct device *dev);
> =20
>  int __devm_pwmchip_add(struct device *dev, struct pwm_chip *chip, struct=
 module *owner);
> diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
> index 5bab3cf06336..8e70ef2e34fb 100644
> --- a/rust/bindgen_parameters
> +++ b/rust/bindgen_parameters
> @@ -50,6 +50,7 @@
>  # recognized, block generation of the non-helper constants.
>  --blocklist-item ARCH_SLAB_MINALIGN
>  --blocklist-item ARCH_KMALLOC_MINALIGN
> +--blocklist-item PWMCHIP_ALIGN
>  --blocklist-item VM_MERGEABLE
>  --blocklist-item VM_READ
>  --blocklist-item VM_WRITE
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 3791af0aadc7..2af0af4f6858 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -114,6 +114,9 @@
>  /* `bindgen` gets confused at certain things. */
>  const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN =3D ARCH_SLAB_MINALIGN=
;
>  const size_t RUST_CONST_HELPER_ARCH_KMALLOC_MINALIGN =3D ARCH_KMALLOC_MI=
NALIGN;
> +#if IS_REACHABLE(CONFIG_PWM)
> +const size_t RUST_CONST_HELPER_PWMCHIP_ALIGN =3D PWMCHIP_ALIGN;
> +#endif
>  const size_t RUST_CONST_HELPER_PAGE_SIZE =3D PAGE_SIZE;
>  const size_t RUST_CONST_HELPER_GENLMSG_DEFAULT_SIZE =3D GENLMSG_DEFAULT_=
SIZE;
>  const gfp_t RUST_CONST_HELPER_GFP_ATOMIC =3D GFP_ATOMIC;
> diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
> index 8aa47304bec3..7fd93cc644bb 100644
> --- a/rust/kernel/pwm.rs
> +++ b/rust/kernel/pwm.rs
> @@ -587,6 +587,11 @@ pub fn new<'a>(
>          data: impl pin_init::PinInit<T, Error>,
>      ) -> Result<UnregisteredChip<'a, T>> {
>          let sizeof_priv =3D core::mem::size_of::<T>();
> +        const_assert!(
> +            core::mem::align_of::<T>() <=3D bindings::PWMCHIP_ALIGN,

align_of is in the kernel prelude.

Best,
Gary

> +            "PWM driver data is over-aligned"
> +        );
> +
>          // SAFETY: `pwmchip_alloc` allocates memory for the C struct and=
 our private data.
>          let c_chip_ptr_raw =3D
>              unsafe { bindings::pwmchip_alloc(parent_dev.as_raw(), num_ch=
annels, sizeof_priv) };


