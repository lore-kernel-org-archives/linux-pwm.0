Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021084.outbound.protection.outlook.com [52.101.100.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DA33AAF7A;
	Wed, 29 Jul 2026 15:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339547; cv=fail; b=I70cpvgw4x6WYn5I/Z4CcWuubnU9Q9K2XhIr4IrocU8FAMcbxnInDKYOmUkNzrO4bBYZQ5hEAWGBJHjI4u2DRlNyUv380ya3y5onHicYYqUUZoQ8qBvdpIGiYgy9CCvYvujVtoSZ8I6TZdi+JiOfFPBor/ICd8EqiqfI0EOhagg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339547; c=relaxed/simple;
	bh=zDgXAYYbNF/wIewb6D3uWaa4YtOgIm7+tbX6qW6FmNo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=gXnglwkt6xIwM5FpTDtdDmMOsjts9oYAAg+K588B7FxTE8RszBUnWmx+/q0X1DR4LghYEy7jmSb9e67Wcvr32rhdfD9otlSEBqhR837plJUx3hKSVPv1kgmZJ3KkDJforQ98UvndsdAiOVJByfeswXuUGrhLg22L3PUK1dMU5rI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ps3YN3GO; arc=fail smtp.client-ip=52.101.100.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="ps3YN3GO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awleYUcT3/5mgNWaGfuWPGk4IWEsh97kyHOH0SZt8a9qqyEbfmfjsKM1v8qqZefTAGjSIfZj/P5ellOSHbWnGtyT2dy0FkdrrrV0L7zLQKvORBI0pRpEgZ1ZKTD2+oJ23P4Wx1VNpf9h7B+Jcpv1wJ7OMyMrkt+JydDLe7swRU36ps/Dja4jkSQoXM8yoyC1taI47LC2TfcawdpW+umkzsWHPOOYw/mX9v3uAZ0SCfixlh6M1XM0D5wsK2C0hT3EChJjERAaLhysAP/RGDtlpJVcMv7+S/b7jyImgMOZzjQRRQ+JxjicIiG1/GhZeYtR5rqUC4VnQq1HKlt3ZREOYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1v8TGnM0bYfN1qj+mxF0e9snZICu48os6X6HTZAvXJo=;
 b=vFgE7x4DRVOedgrvlgnoHuasXDufmqrQYtEZNH2quSc3KIt8eLKSC/B3brRs+Qel4+ZbHR9r3/DdIdLc3E51pG0UzUa3A02Dvyfys03H8RILQImeWieeUwabsQjOJMK0YQzGZXxgYk1SV7moFUcKNQAphEHQluB8vox6ZUTCnJEyek5uNo0swimfgPPtcyUL3hmg/tsU8vZ7btpWFx1A4fegt9lvxisuXADNrMwRzdRmNQyNj6rA0KYHCoD76Az3eCPFEeTZY4SVRlOiuEh5PxrpeOCYIR+aL3YZHjq+bBiKGdCxoL1OO0pOdsmqzeemZWL8eJ/F4HLT59lO9iPf4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1v8TGnM0bYfN1qj+mxF0e9snZICu48os6X6HTZAvXJo=;
 b=ps3YN3GOhchXFsZNzKe2abeXyVHy+pXqzETER8DKmUPeMI91DU4+1f2jrBjpLN+e5yrmZvOeZiAGKBUaAKwlheLN1p1/p92U8ZkTQ8TsJxJOUM4KaATj/kwSU7kWNu9i8fM2IVEutgriu/8Y5havKrx0B8XV3lXzk57rlLEy/HA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB7156.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:31d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 15:38:52 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%2]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 15:38:52 +0000
From: Gary Guo <gary@garyguo.net>
Date: Wed, 29 Jul 2026 16:38:47 +0100
Subject: [PATCH v2 5/5] rust: pin-init: remove `__pinned_init` method for
 `cfg(kernel)`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-merge-init-v2-5-26adf47109e7@garyguo.net>
References: <20260729-merge-init-v2-0-26adf47109e7@garyguo.net>
In-Reply-To: <20260729-merge-init-v2-0-26adf47109e7@garyguo.net>
To: Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Michal Wilczynski <m.wilczynski@samsung.com>
Cc: rust-for-linux@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gary Guo <gary@garyguo.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785339529; l=929;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=zDgXAYYbNF/wIewb6D3uWaa4YtOgIm7+tbX6qW6FmNo=;
 b=gGJhkhyKrlkmzgTQQUiWRjfSYYsFo/aOdpRfV+nkpuMnet2ot93d1c67qvpEWIgc1vWzVPlwI
 fYbsakId3c0BsdalKtv7qsBdGu0lJp8CTPpq4YJIqVK/yOsc7h0meAK
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0031.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::18) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB7156:EE_
X-MS-Office365-Filtering-Correlation-Id: b69a1271-548e-453b-4b47-08deed877d6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|376014|23010399003|18002099003|22082099003|56012099006|6133799003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	sYlkxTeYAG9rrqjEYldqFj/fOyIaaqk99HbYA/jxK7GdR1/SoBZkyIgl+M9ZhKaotJCKrHHafl5mitoxB+xNYATOaFu97I6Ad9GVywfazxlnlHgMtu6druG4yNklXjs8pE2SADCKtm0YlzPa/lt4fvfHAhdB5XFni3Bg/ZNKLD5slZ3ngvbTbjnyekfVk5iEDF5oafQ3McPzi+vEYXPJwUC6ffWkJkjXoePzhIPjlbjwSlKdYRHWAF8y4rmD/ssTqLmyJtsWIXvOkn4zSaaJ8W0lxX+DlBxieEMZ4jGQ4FGxFUcWUP04fOKCeMQtqUn94AfTlOlixcnFXkYPO/8LvGcV8ZJodVWmRkytfsVxY0CJ1KEfzQpwIiP+6PAYaJXS17WyWY2y3WI8xMPGXA0dzstEqEF9qMsMdFwxxp2x0Tn+vWoPYDMwstZucainJ72Os7i7q6vFqHdmhd4c3zQSprzkVWVapfmC6tjnJew1S4ngEZbtWiUfIX2sa+5WKtGlnG6r0mb+8ZGBaVRiA641vFwgOGbUM8WaeCJA2Tt7CVa7syPkmsFPAmnFueri2eadQpje7CD0nlLF86rSTofu5P5xG6rZ8QVyz+ErDrfyh03gjW+1CpTOQNIDMXdTMST/WH9aex21/Fw0Ja8DrhNrceyh5MeMRgDlghubLkcR39ixvLnT+Ay8qzrurj4g3XcMYcZy3v7xvuyWvF21nzUXXw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(6133799003)(10067099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWN6NFNHSjEzeTNoaEdqcmNlM3Rnb3FTbHBvWmRwRmVQMWFieitiSC9ZOTdV?=
 =?utf-8?B?a3lxaUdzSE9yYXhzUk9JYWhDb3dqL09KTlk2MCtxUHVkdkJIa0VmQkFxRG9w?=
 =?utf-8?B?NThjRllhL3drWTd2cDJvVi82TTEyUjlBTHR4WUpIa1h6Z2lVWFFNYzYyajQ0?=
 =?utf-8?B?UFZDM3pXK3hRenorejV5UWszejBvUGRoRWhWcFhTZHJpeThsTUYvTW1wOXpz?=
 =?utf-8?B?ekJCVU5HOHFJOENFL0VhZnRvNEtMTDRvRjF4VlF2QW4vZlFEWDdtUUxCbXlm?=
 =?utf-8?B?NTk2WldvRWpLS01xT1dOOC9IVmNIankyT0ZuYlRpMzZTcHMvRVNjbzlwL1Bs?=
 =?utf-8?B?eDFBbnRUUkJlNmtxams0Ui9hR2NpK2phRGJZM0xjb0krdVM1ZlQrak9Fd09J?=
 =?utf-8?B?Q2lDUXdscmRPeElqeG1taWxuLzVDaWF6UEo3TTVUTlBzSjRVbjZiY0VxNHJo?=
 =?utf-8?B?ZU1KSjlnK1pkcUgzQ3dFRHRkOUJBZ2hpVFR5blJ1ZTRVcjZOTnAvMWNjRlhB?=
 =?utf-8?B?ZVNjaVNtTkRhcGtXaVhzeFNUMFpIeHlZVlRIOUhwcHpLTzdaTzIyTXg1V3RV?=
 =?utf-8?B?bFFqdFU4SC9KamNYY1luSysrL0dVWmhqYk5qNjZ0S0w2TUs0bFVYYkxmN0J3?=
 =?utf-8?B?VC93cDVxTFFFcmhsRlp0UnpDNWJJNC9TQXBxczFTL1BxVHl0K0h0OEY1eTFH?=
 =?utf-8?B?RWQ4U2Nma09aVzJiU1ZKNldqbStHRk1KVXFDclcyZ1J5WnhtalJySUpLZGtx?=
 =?utf-8?B?cytCd09heXZ6Unl6SVU3elY0WHRtc1lidHhFd1RZM21QRnNEY3Rqc1dRc0xs?=
 =?utf-8?B?RzJNY3lrbmtDUmZlTktwWkh3eDVmZkZDSytEaGJQbFhYejBoYktKOHNzbXV5?=
 =?utf-8?B?dXlPd0hlbUdwYWd5czdCNW9sd1kzdlRuRWY4NExYZFBqampTSmFaYUNvM3JL?=
 =?utf-8?B?cFZXcUF4TFdoK3c3VEtIeXFoQmRpMHJra1Q2UitsV3ZqU0djQm9MRnI1cDFJ?=
 =?utf-8?B?SFVrZ3lrZXVPa3RjeGlQbVI0MFVhYTlZVzdHUnhncElURlBzcktocTh0TkRY?=
 =?utf-8?B?NGpXSFg2NXZjNUVDQzlqOHlNcElEMFloV2tWMlBsaXNRcHJjTDJxNWU3VU1U?=
 =?utf-8?B?UEZndVM1bTBvVWYzbDdhLzdaakQ3dHpXSGIxOFljbGx1MUk3U0poQTU5d01m?=
 =?utf-8?B?cGI4a21Od0I0a3RQM3RPS1daZEs3OTQzYWROSFoyS1NSRHlnTzcvandwNkxC?=
 =?utf-8?B?OHlGN254MmRRR3FsM05CWFFqQlVuSW1IaEdIR2FNS3h4eVhxUmdoWmQvQUNM?=
 =?utf-8?B?OXY3eTJjd2xFV0VYMldKQmJLK3A2TzlpMENPeHdMMGJoUVIrcFFOT3ZhK2Z4?=
 =?utf-8?B?c1VxNEgzT1A4TnN0RGo3YkJVWENubXVNRTlLSjNXdS9iNnJ2cytraGVKYjJH?=
 =?utf-8?B?eXhoaldJdnhuM3pleHRwMUN4MU15SDRjNERnRjBBSkVKcHN0RnR1dUhBNHpB?=
 =?utf-8?B?c01DUmFiOU5laTBOR1dncHI5RmdNaEtXRTFjVVphTm4wNWwzL3NvYTZpZ1Qw?=
 =?utf-8?B?T0gyZ2QyTnViVFVPWjM4SXZIWEdpdUpqZ2xyUTF3cGc0dk02bjcyQ2Z2WndU?=
 =?utf-8?B?b0lmWHIydXZIU0FQV0tBQU9UVCtKcnFaWWlZaC9wOXJBS0p1eXJvL2JQUUdw?=
 =?utf-8?B?VHFxUXordTBzeGorVUxhL2lrU0ZhM3VrQUNVWkk5V0thbXpnWGlSZWkyR2xs?=
 =?utf-8?B?RDlrWVkxYXFUaVNnSE5HVmJXWHVBMGhNTXdDakQwRmNGckd6dllRYXEzanNN?=
 =?utf-8?B?YXVieDBTRmJQalVTdWp0dGtrMmpDZVhVOXBMM0xHTHZIRGgyU25oMjZENDRC?=
 =?utf-8?B?eUVhcnRzNW5oZE4ycjlJRFBMWXEwa2dWanBEMHZpMVF1YTAxSDJPSDJacVVv?=
 =?utf-8?B?Rm1Cb05tYXVYSFdnc3h2aDJhSWpsN1NBblc5M2FVSFUzQTl0SS9VUkhtSExx?=
 =?utf-8?B?YmVnc3pVbzIrS1VKbHNYUkp4VEJJM2lKTXJLaUY5SHRmTDcvRU9aRlVTK3ZR?=
 =?utf-8?B?dkltRUtPU1hWUHFBWllUYlBuVGtwMEZWWEhpOGR4QTBndWJwRGh3bHpqSVVP?=
 =?utf-8?B?Sm9YN1JzR2lIUEF6MktleHl5UkNhZkt5aUVMeUVCeExyWm0xQXF0UjFKcUpk?=
 =?utf-8?B?dTVaNi93KzlQYkpWdnF0cW9Vd3BoSXdqeUpaUk54NjJTTTVHemFKS2N6WHh1?=
 =?utf-8?B?ckhRZnNpazkvUlFuT0tkdDVuTGJlTXhGeU9FN3VOMUJoOUhpUzd1RFV2NENU?=
 =?utf-8?B?cVVCdkgrbFdXZFQvcjh6UEY3RzdReVA4bEpES1oyOVlRTTg0WjI3QT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b69a1271-548e-453b-4b47-08deed877d6a
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 15:38:51.4464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a9efCIiKBgsvHW45PDRWtq4Dh5L24NFuJffx6y8Jhb4Bgck1nFRZdiWjzyT2/Am33B/gC8ePw+hPQsBAu3J0HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB7156

Remove `__pinned_init` for kernel configuration, with all users gone.
Still perserve it temporarily as deprecated so other users have time to
move off it.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/pin-init/src/lib.rs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
index 78a67ef54f4e..16f60dcb8330 100644
--- a/rust/pin-init/src/lib.rs
+++ b/rust/pin-init/src/lib.rs
@@ -917,7 +917,8 @@ pub unsafe trait PinInit<T: ?Sized, E = Infallible>: Sized {
     ///
     /// Same as `__init`.
     #[inline(always)]
-    #[cfg_attr(not(kernel), deprecated = "use `ptr_try_init` instead")]
+    #[cfg(not(kernel))]
+    #[deprecated = "use `ptr_try_init` instead"]
     unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
         // SAFETY: Per safety requirement.
         unsafe { self.__init(slot) }

-- 
2.54.0

