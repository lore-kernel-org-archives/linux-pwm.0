Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.195.136
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794226023;
	b=cZcyTil8rZwFLhEPFGSdXRZclyC5DOvtNtaThZ8wsNhnoEra+dvYgf0IMnKxPp7L/5yR
	 jR1t2sTVkThP3OZU9UcCjmITjbXnQfMUY0kCD1yGC6pa+uZfICpuDJJYIKMAhXe7gYNki
	 z/Jmf7sJKNg3BJkK82XTiScmfAr8sRFsg0ES3FPhjbDGpplT4leDv1L7KdeGCSNQj1lsj
	 n7H4lZjDp4OzXxkiUfXC5sz3bARLL/bvESnDFvXrlabEIPy8r04yraXKPPFTO98YR3ZcX
	 wnc3QaI6wt2s+ivqjCInnUixodnFBmcyVRvCGuQze6V4xAqcUxjw4nBc0vn68pHqdpw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794226023;
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
	bh=TFCq3DxHOsDy1W542xtGk633l0+maTl/mCrVtZeVOqY=;
	b=yUHE6Ce6iKDmV3o8YQCKOQfEkVJe4XrK02h2phEATfszVASPXv+3GeW6hbT4SfroWVeX
	 KksA3SMAW0i7u44xcKNS4+hMtY9RcamAqX3mp/RoTd+4gnmNjce0gXMo8sdaaNGkJRR/X
	 BYndMAnpG/T7dr7O16T0BeHGM7jV4mMKSbj+nL78qUyMqKXG/sJo7zAqxdAXYGMmeALe7
	 GV1f1MF0DVpm9ZLlLnIZyO9o+4LNO1Ml4o6npYm1tPKmC91IMAqd59iqcCMcFf50fhsZl
	 78HtAJ2yfbnTqP6JCWc196VVxPGsbabhGVWfhNKFFWcmu3NnYVHgaX7KXv3yFLKvjmQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=garyguo.net;
	spf=pass smtp.mailfrom=garyguo.net;
	dkim=pass header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=JOVI75jk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.195.136
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020136.outbound.protection.outlook.com [52.101.195.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADB0606A321;
	Mon,  9 Nov 2026 12:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2ADB0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=JOVI75jk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DlrL5Il0p/a8/jKYjJz6AAw+MWEhH7Zb1OU5lS0npKGYoBJhIYrDB6M8c1yEd53Hs6F2ruEOO5DhDB6Xqvm6UHjfp2pplAIR9xXl2eLaFeWJ0+wyIfdnM5j//bERXOPEbOP+ATVa0PI8w30F0dfvW6IPJwCfZdx8hltvXguX5u02pAah2MN9jPpvh7Ve+zfekqflihqJ7/qMB39SzrLG5XjgoqScqenvQeqHM6vnirsKmwcwgmAX1Bicbj0q6BcU42MskG6FLYxB5gQVHjs+qbVCT58V2amQCLAV2fW0p09tjxtsM1NgwHU7M+i6FUqFAvOuwIJNhW1ykDgBHOOVvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFCq3DxHOsDy1W542xtGk633l0+maTl/mCrVtZeVOqY=;
 b=J1XjAVBYilm/AeoYN+e78ExXxUBc64jGiaA5ljGzmKFXLjIVyn1NBkaUuy8G+p9eeRIL/zHSMUc2/juKPTdldNRSvREocqLKIwfN3VoS2Ryd6DVbaZGOWHgTUWQDqYb+JPaR9Is4WPamQ+L8QLEd6ED7GMsq/NVS64TSnApnIviAQpDosWBPBHlD2jpZmr3PMq57OveOqp7TXSGukJOsn+26Yahzwt+LbJGOx1auTdhD5dhi8he568+EB+NmajgkZ0++e4UegnLyN4kMf5MYIwJkaKq2KpSG648kw50vbMEp0PitUmUUEJcxWj45ArrpHfQrrsLhtCfUZkVKxFd18A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFCq3DxHOsDy1W542xtGk633l0+maTl/mCrVtZeVOqY=;
 b=JOVI75jk8Zt0hCsKcLPTtWQg52Goww0PgVOKnMC6eZbqrVOVRL+E8YfK6Yj4P8qJWUwjgxDNYyUyx+vZeOEc9SxPkB6sTSNo2TjN0DwV/vm4SS853ljfwCSysWBwYkfgcaKGIBA+SCxGM93/x2kqNkBZSi3b655DKBaBajY3Nw8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LODP265MB722019.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4da::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 12:06:59 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 12:06:59 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Nov 2026 12:06:58 +0000
Message-Id: <DMQO1I1ZSCL0.1QIOEVT87OAQA@garyguo.net>
Cc: <ojeda@kernel.org>, <boqun@kernel.org>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <dakr@kernel.org>,
 <daniel.almeida@collabora.com>, <tamird@kernel.org>, <acourbot@nvidia.com>,
 <work@onurozkan.dev>, <elle@weathered-steel.dev>,
 <linux-riscv@lists.infradead.org>, <linux-pwm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <ardalan@uci.edu>, <zhiyunq@cs.ucr.edu>,
 <dzueck@uci.edu>
Subject: Re: [PATCH 1/1] rust: pwm: track the owner module when registering
 `Chip`
From: "Gary Guo" <gary@garyguo.net>
To: "Priya Bala Govindasamy" <pgovind2@uci.edu>, <m.wilczynski@samsung.com>,
 <fustini@kernel.org>, <guoren@kernel.org>, <wefu@redhat.com>,
 <ukleinek@kernel.org>
X-Mailer: aerc 0.22.0
References: <cover.1793150685.git.pgovind2@uci.edu>
 <f9cf8f0d897f22888134b2b17f1b0f86bcda311a.1793150685.git.pgovind2@uci.edu>
In-Reply-To: <f9cf8f0d897f22888134b2b17f1b0f86bcda311a.1793150685.git.pgovind2@uci.edu>
X-ClientProxiedBy: LO4P265CA0079.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::12) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LODP265MB722019:EE_
X-MS-Office365-Filtering-Correlation-Id: d6316b9a-5ca5-47f4-a1b2-08df3e59f528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|7416014|366016|1800799024|4143699003|56012099006|261021121427099003|261021135927099003|261022075727099003|261022105027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	l12mtQP9M83+XAhIWCGtNyyVo0DB112drj9Gsy3oEu+awt5BoLvlZch8LGKgmPNPys0gRSFvuBVexna0JsfXBVtNgxCWWacmrDwe54rl420ghOpNf274xRzKw36oYCXo9t3r06+UDAqi6FMiF7yC+KyUo/E5hVpFoHYDd7pC9VDp6G6i+qGUf/qR6n2hh0VhuoMjKh2bkKBcQOc9G/rjqFzq+R6Pz+PvQ6qMuP80rMGvP4A4ywxVWqgz6RXfeZif3Ftt9S5f8BZ6M4Mdz6pTowgg8TuVIK0p/qUNVv/5SstJqeuy3wBNhjTfT1gHNbTBujIw5NLDrP4WeAQuZD8Yp3Vr9zc7KQki1yEubKsAgEqq9iYHK7jmXIxYU5OY9DJ9tszxr/Vh9nLhcTAJZWh3at4V46VMFiU9Bc43/UaAKgsKqqrh7fWDqX7yr64CcF00PPb7turP1bd3XcOBy7oTRGssCaLnjUKWZ3Tl8T/RhLLYg7fT++7wWNqKgjaJfJyQuG3VJ9z20sAY2s9WlAvAdM0+9CGo6xp7h0sJftYVRJDI2zWOLww0tXSKIHO46Hq/qBlh/UUXscpoiZG25JpQDnundpUPWrL7lRI8mOJonTSZyVrPNr9vAtwRTIgdy9So6S23k4mFjaJJTLb0PJe5fxnFGKZJvZBfEniplG552+M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(7416014)(366016)(1800799024)(4143699003)(56012099006)(261021121427099003)(261021135927099003)(261022075727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3l3ZlZZMjR5cGJETGtWL2RvRVdUVm01Q29xUDhhWGJxb1ZzQUFydTlURlZD?=
 =?utf-8?B?RVVMWTZQTTV3Mm1GVytGaWtQVHFjTlB1dkV3c1MvNHNxRGlaT1diZnFHNk1v?=
 =?utf-8?B?RVpJSWN0cG9kaDNSZnROUWlCZ0kvTkhCSlYwb3JqajdDanRPK1F2ZWZFS3l5?=
 =?utf-8?B?dzlQc0s0SkZjL2U3OUJWbHB5WVZhYTVXRnAyZE02REpaRDNDWWVkd1R5MWIw?=
 =?utf-8?B?MGFQeHcraXpHa2tua2JpRTArOXhueW1lU1NVcm1ZMjBIL1NyMkppSzZsTVV1?=
 =?utf-8?B?RUdpQ3QvTW1BSXJ1NFlZdXFyMjJrVU8zMGUyTHlNbzNhWXM4UUJjdzNSNGcv?=
 =?utf-8?B?S2tqRkY4WUpaV0prK2tFK1hsUVBadnBBK3N3Vnh0b1lyWU9mR091VmREZGpx?=
 =?utf-8?B?Z1hnSmZnN2QzNG91TDRSZEUrQnkwR3B4dzdZRjVPaDN1VUJtZE5DTkcwQ292?=
 =?utf-8?B?SS8rQ3UwYW1yL2VNNGk0VVlnMUVZYUR0dkFMMGx6MEppWVplcU5XclJUK0xh?=
 =?utf-8?B?aW5CUVM3eGROVGZ6MzJzNENQcU5pMG93SVhXMUlwcnJwQVVPZEtHaGRacGtP?=
 =?utf-8?B?YWdiY3hDZ0pxZUd0ME10YlVheU1kdFlCWTM0Wk04bE5odGhoSmJybm1PU1JS?=
 =?utf-8?B?T0VOT0tueWtvdmJLZHZQeGtLNS8yYTd0ZTFFTFRtb0RXL0V6YUZiVUhYUVFt?=
 =?utf-8?B?cmZyUlFBU2ZWcW9BOE9pWUp1cXNEbUNIRHJScGxXY2NnZ01BbWNqSzQ5WCtG?=
 =?utf-8?B?bkgvd3NuLzhaS3QrN2NYaEVlTm1qMTFzWDFvRVFTdHdOMWZCV01TcmlXRmFs?=
 =?utf-8?B?cHIzYTVpOG4zR1Y5Zy9vL0NjazNGZmNoa085Qk1hVllzZ1p5Rlp4NS9jeVoz?=
 =?utf-8?B?WFVVZ0x2ckJ6OXhXdEs2eVFWME5BUDd2OUJJeVNhZ3pkU3lCWER5a0JtZ3FK?=
 =?utf-8?B?YlpOQWlQQW52K0swWTRlVGZQbDIySGk5ZGlSNlFsK0g0WHR2UWtCclprUDdt?=
 =?utf-8?B?bEpOWk44T21TWEp6NTZBTWVTVDNjeUc1dU5XQktuSHpFZ2RSOTgxZlFuK1FY?=
 =?utf-8?B?QThsY2NnOXlBSlRObU9YbkVCcXdoOS84UWRpQzVZZ2NIakRKZVU4SGxWQkR6?=
 =?utf-8?B?ajJCd0pjVWpNcWlsaWhXejVkWGNqeDI5Nk42SlcrTEYrMVZKZktXZWxuN3Aw?=
 =?utf-8?B?dkxYOTFRMis2dm5GOWJ6clgvZDZ5WUZwaEpTZVRzRkhqUG9DRkJrYkNlV0Q5?=
 =?utf-8?B?V3FyWFY2Umc2b1MvbVY4QVBNT2ZCUVRVV1N0T1BFWEtDMEh6MTRjTzlHVXh1?=
 =?utf-8?B?c0tlLzNQN1JNQTVWczJidjhKMVdjVHNackxYUk9sZE1YUzZhMnBIS05Ub2tB?=
 =?utf-8?B?MUFkdnllVVAxWEJJOURXQ2lLamE3R3RibTRVRUkzcTB5QkQ3YWthbHBRVG5X?=
 =?utf-8?B?c3ZrOERPTUphTC9XejNwR1FlZS9sekM5OWJoai9xSWZYMjRTSzd6UTJjbkNB?=
 =?utf-8?B?enFtZVI2NkNLeW0vd0N3WUttWDNoV0VaSDM4Q1FkbDR0Zi9rZEhPR082Rlll?=
 =?utf-8?B?bzJiT2Vsb2NGYi91R3VEcmNlUmU2N0krYytzRS9JaU90NXhBSUNtNUxTM3JT?=
 =?utf-8?B?ZDBOQ3FkQ0hmdWt1dXFNQ3NBL3hWOW5LRnNWZlNubE5RUEhBM01SNTU4THBj?=
 =?utf-8?B?QWNkUW5laTRwcEt6UEkyQ0pKMXBIT1ludHVsai9PMDN6NEcyWUErWTNPOXNO?=
 =?utf-8?B?N3JkVkphVDRwdHRRMmlOR2lhYjNuRXJsa1dsRTlxWUZaaEhOTk1uSUxyaWpR?=
 =?utf-8?B?Mk9zUmRXaFd3QUZTMlpWSDJZWXpoZENRYTZTT1JKcXBSek1VbGY3Z1kxT1pz?=
 =?utf-8?B?TGQ4QmNDOWExUzdvazg3NUcvUnhjalZja0Q2TmNsbkM4UjE0NW55N0tmaVN2?=
 =?utf-8?B?ZkNWcFE2KzdyTzBXdmlWYlo1V01VbUI2QzRVaU9VZlZ6SlV5WEZVT3QyQ3FJ?=
 =?utf-8?B?R0wvdHBCR0xsVEcxbnJPWHpjdDdhVmhqUHNTcklWa3o2KzNiUnJMRi9lZ2NX?=
 =?utf-8?B?aDdKWVJJQk1icFU4SktMaEhQcUlyaVY1eElnMHM1ZUpuVTlWVUU2ZTVIUWZN?=
 =?utf-8?B?RTB2bW9laEVkTnlJWndIUzNsTjR2MmJzeHpUT1dGZDd0K28xVXhpSzRXUFpj?=
 =?utf-8?B?YlVzMHNpdTN4Tk43Q1R5ZS9QOTd6T3RidFpBUEhXY1ZiK1lzVFVSZVZlTWxK?=
 =?utf-8?B?a3ErKysvSWMzUXMxc29DZEZYdm5OYUpXbFczb0E2blRUN28rTFB5UERaV3RH?=
 =?utf-8?B?b05yZVQ2Sk5UdFdGb0FqMy9hOVh0Z2RZbTlUbDduOXVxMDE1UG5Ldz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d6316b9a-5ca5-47f4-a1b2-08df3e59f528
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:06:59.7857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lDfhNzSVlwNftKuTy3AfutOqizSurpBDV8c6JC90t7J2djg0hZRkVw2nPKhylRK/83vMte046oTaqtmjhe45Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LODP265MB722019

On Wed Oct 28, 2026 at 10:28 PM GMT, Priya Bala Govindasamy wrote:
> `UnregisteredChip::register` calls the C function `__pwmchip_add`
> to register a PWM chip with the PWM core.
> `__pwmchip_add` documents that its `owner` argument is supposed to
> be `THIS_MODULE`, but `UnregisteredChip::register` passes
> `core::ptr::null_mut()`. This is acceptable for built-in drivers.
>
> However, for loadable drivers, registering the chip with a null owner
> prevents the PWM core from taking a reference to the owner module when
> a PWM is requested or its character device is opened.
> This means that the owner module can be unloaded while references to the
> chip remain. This can lead to use-after-free and
> kernel panic.
>
> Fix this by marking PwmOps as a `#[vtable]` trait so each implementation
> exposes its actual OwnerModule, then pass that to `__pwmchip_add()`.

For some context the vtable module infrastructure was not there when PWM
abstraction was added.

So I'm more seeing this as improvement as we improve loadable module suppor=
t
rather than a bug in PWM abstraction that is fixed.

The fix looks good to me.

Reviewed-by: Gary Guo <gary@garyguo.net>

Best,
Gary

>
> Fixes: d8046cd50879 ("rust: pwm: Add complete abstraction layer")
> Reported-by: Dylan Zueck <dzueck@uci.edu>
> Assisted-by: LLM
> Signed-off-by: Priya Bala Govindasamy <pgovind2@uci.edu>

