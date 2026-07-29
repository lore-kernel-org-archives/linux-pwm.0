Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021102.outbound.protection.outlook.com [52.101.95.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A09B455179;
	Wed, 29 Jul 2026 15:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339539; cv=fail; b=KvlLHXAo81CBMDR0xq6OrY/UXmsxr2RQdMkvqS9HPXDb1T67lB3Laj1M7gS1hwtsrpXf+GQTLIYXAxVAJFBr4RmoXHhhA72tPAv1fVPWxtTVdqmyHpJyA2YgRBoJyzY1u7/j6RlR+DwN7UBtBzVyUPTXuvfW8kN1GUYjPVihLW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339539; c=relaxed/simple;
	bh=XDV0sDvaYUhPvDQbNEremRe5pJA2s23P/ySkYJoJ8VU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=MpwZKigOicKm5ozwfTexPpYkZBxpJw+CVV1Iui5D8qF39n6HtkBTmuBAG3SSF4a9ItjKIaJLX+oPRFEzk8qlS/d3r33F+xT1+xeF135sUUPvxbloM90JksXHivyy9HaJHWCLXsnwnaCLjC83AiOTjspobU/sov9R0Fe8EV2UkMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=g5FhvcHX; arc=fail smtp.client-ip=52.101.95.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="g5FhvcHX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2iLcMhWe3tCfd2cAsnFU+NNZ+A2LOZLOlHSYh8RmEh214sRtgVcD1LFM4PALCZxt+RRrQLAtJPgXcFBvGx3ddHYETKnJ0p/ToajMUTZPXG2hFAJLu3/p6H3/Uv1kD/G+E9SunYkKdByb3f0ABZdCCRRTiKtIkTd3PaCaJIwIFXetehn7t9YO4BtAzsTHtLfRaon1fkcOS/BlkRzVseNfgdY1/nv+SxZSpT1Nq6i8xvYLV4/bjAbC3Q0bDntYMk94/sA24+QjRO74T9gJcJ2PDR/C9Bw/7CMPp8osWXl2CII7c3NUPAPaFbYN79lpGsKwM9WOGFVhOj4F5DhgrPRDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8XTEC489iIBHCBVdNq+qu1t5mwnZjYj7c2w7SKizuw=;
 b=d49cdJFap9tnhknSwWoohQfwn6zx4HzbRaIdW3iw2hsOhPkj78xE9ESXuYHE2KgcgEn/spreTmChaYeC2RnkN6VsLesAMQG77VurBBaBvOPoPlrD4X8bSb7OhPWMQLZpwgbfXc7QJ/SsZG7PPrSI574qruwb2W3t3Fs+eYnUAnIU1JW1RaXrbgxM2H3pNue/VVnKX6tewnhvT8BfgW9aszehIQPu85QLnz0SpYhFbTjxmOdwpk+ZrhzdMAl0KFD2ZCBem232SzZRRo7rOh6hCKNG3AJhQGTU/G/fviyn/aFiB9yktmfVtw4q5aPeiORv+K4tOb4wL68knneiCLmHmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8XTEC489iIBHCBVdNq+qu1t5mwnZjYj7c2w7SKizuw=;
 b=g5FhvcHXd7WDdZJ7o5ztGDTweiBElED4+pD0LytGFWgIRoSYanV3rPN6MffYbsUxsatA94JWT/VfL4ggT9d1H+F62OxR7FhbznB8ESIma/CumrCABgIfYWg4aKm8uzQ6uhtC+05mw0iC1R80fHMVXlbBOQGT8gA2qNH5er9YsmI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB7156.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:31d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 15:38:50 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%2]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 15:38:50 +0000
From: Gary Guo <gary@garyguo.net>
Date: Wed, 29 Jul 2026 16:38:43 +0100
Subject: [PATCH v2 1/5] rust: pin-init: examples: use `Wrapper::pin_init`
 instead of manual reimplementation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-merge-init-v2-1-26adf47109e7@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785339529; l=900;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=XDV0sDvaYUhPvDQbNEremRe5pJA2s23P/ySkYJoJ8VU=;
 b=6AEdmVcb9beWSDRktqBmNjYDgOQ0heKhM5rOWWUj9bso1+PDi23/t4ytKAGYN6um16DSi/YRn
 9lQVlh0KhVdA4x2haBVKzwiYU3UAB0ZESQUkAsmXDHyRG0MsGS3Mzba
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
X-MS-Office365-Filtering-Correlation-Id: 35275d76-e558-4a51-de61-08deed877c99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|376014|23010399003|18002099003|22082099003|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	H1D0Tz2jShzYBrAxsOgQgXXlg+nXoxbHSmFbxSxaC1jLXu33FDebCj1CKRfWOLZ7R7QTrGI8T5BscNbBu1fsiQQEaWZCjdP0nMTJmbqgmPLdnzzzVhiHmhypkiEh0zDVp4QAtIfg2RCosMxn78MswtYy9NV6gKnc+slApuLM4Ki+7DkphaqTHEeDTWCRd5LYNFgF3npSxGdjuugjJfqayEdFy3JyJwrC7lr+9ypS+iz0DkDXnm8oOHUAgigUvFm0/ACics/58AsdDk2pCNrStaYC5R4a54lErIlCTn+hhfVhJdpGuOLACRyPnQVtrcBqOJAZ+XO/eGV19oPH5yGZ8XrejVASHzqU5dExRPCd6DI+fLTcHUSgVKXDEfzhRsPhaz0yTSXa2jWPk57sNMy8s2ipc2S/aU/meB7vI9jjWUUDaKA7PZDKas8KchcV5NsnfIcs4Bq4pYDPZ9g6QwTu+YweKJSBVb7PuIjb7LwWTwF7FwmTk3VhYZyLIDTXCEX9vNWxnC7VSfx2YPKd/3q4ABgWfl3ILRfWHa3F4+dy3EYAhQ/CPsN/zgC2KjyN83Arz6DI8MUPcF6N32+n2Bbae/+WeLhKlc/6frzsbx0htIgDuderUPlRDp0EHTwdwAkg0Xoj8IOWF3578aXXEUHm1TcGedmOg/fiasJiXrrFVcsOmtxcVn6brLwNOIT962TFWQD1UAvHifXmCdWatR74zA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(10067099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZldNTU8wYjNjQzFWWUJjaU5hYUhlL0NJRzFOLzl2S1NlWVVLQ1ZrTVpmeWxB?=
 =?utf-8?B?SkQ0K2dVaWl3TE5MRDFlRjY4SVY1L0o1ekhmUU02S2ZaTkFRaDJ1c2VZQnY1?=
 =?utf-8?B?VWhtNXFtUXFhdE05S3Q5UEd6eU9XRlIzTDY3N1ByMHpsbGc2ZnhtOFdZdzFs?=
 =?utf-8?B?SFRWaktuUzcxNnpLTEk4UjhnMHVDcFZwcXV0MXlONXRDUUdNTWJ1d3RyQXo0?=
 =?utf-8?B?UEZSY2FhdEV6dG9hVUFsL21lNEtDRDBwdVllNmErelp4NmtnZDRUMWM2RFJS?=
 =?utf-8?B?VGxEMkdLckxVa1lvSTdVRlJFNG9OSWx2K0k1U2QwOWoxbGhra1Q2dmFEZUhk?=
 =?utf-8?B?NWUyYTdkOVo0NkNpZFNpVEdacHB2cmR0QUdtQjVIbXFaeU1mczEwdmxsbzJo?=
 =?utf-8?B?VWsvcmhjaFNueWh3K09nNGxaQzJoR0FaYkJVck5FbGxIZU94L1lQelZwR2Y1?=
 =?utf-8?B?RWNCZE9JaTBxS3d6MzIzREIzUzczajNuME42YnFjQk9zbGlGbFphN2cxVi9F?=
 =?utf-8?B?cFFjYTl3ZEhOMzIrT1hGZVhSVDZSWlQxNEdqbGZXSEJMdElWQzNEbEZ1V0pI?=
 =?utf-8?B?eHRMaktaNlBCblE0Mk02OWlYaXVEZW5WbFFEa1QwMStqN0RiODRPdW5BWVNq?=
 =?utf-8?B?ODRKZFp1N2ZvSnZwM2lzdktDWHRManBqQUx3bzRKMW5HZEtjbzU4bGxubHBs?=
 =?utf-8?B?dnlZeHNuVFJlSkk2SWpiS1RiejNZeVBHSElMQjZIa0ZPZ0dDeFlvQ2t3QnFI?=
 =?utf-8?B?Q0tOVTBIRk5xNnlJN2NDV2dMb2NycVAxWG1KN1JNTWhmZ3hkZWhHeDNUTmJC?=
 =?utf-8?B?OFF1WEVDbW05M055blA0WUZFcmo3RkM0VmFkdVYxYUV4YXpVSHczVno3REkx?=
 =?utf-8?B?cHBjZXhpTTdRU1kxWitWRWtnc3RBbnVQNlJhbnFCOVN6U2hucUJPcGtvUHQ2?=
 =?utf-8?B?NDdDSHkrSTJOOEpvUjJ4eUtkWllzSnRHUHBXTnNMek1lNEh6V0VTVitYbGlH?=
 =?utf-8?B?SHIrYlU0V1BZS0JrcldhMnBwVEpmRWNqeHMwRWczQkN1ZngwNGJIaWlXWVlB?=
 =?utf-8?B?dGVFL01BTEczcVFBa2JRRk1BUzVSK0s3REpVK1lxV1FJdlA0WVpubWRCMnBY?=
 =?utf-8?B?TTQzK2ZWZWdEVTJyRlR2NXlJa1BYRDIxYmRPM1FuSFExL0VXRmJob3IvUE5T?=
 =?utf-8?B?V2NzR2RXZFYyMlkrVU5DM0ZydWhWODQ1YlNKb3FOSUVJSHlEdFRYZ2tZYzV5?=
 =?utf-8?B?Zk9EM2NYclVCcWd1VmhmeXRTaEZWR3h3Y0VUdkVid3A2YTkzUG5Dd0NVSmd2?=
 =?utf-8?B?N3E4a01DdG8wZThrVmFzZkhlMHhYWkV2M2lhVmZvWHpPNXVzTTVLYXdyTmY4?=
 =?utf-8?B?RGxsdGs5NG1sWlo3WVppZXNyQ0M2dU0vVjJabEFtbnlUdXJwdWtZby91d1NI?=
 =?utf-8?B?YlBUVWVWdldLVjU0MnBBNGRFZjZYUlo1YXUwbXZIazZveUFaaEF5cmN6MnJk?=
 =?utf-8?B?MmFYTWgyQ3FKY2llL3hFMWZzRmtaYllFQU1lM1V4aFRqYjVlaUhSTTdNWXAz?=
 =?utf-8?B?blhNaW5FR3NudG5Jd1B0M0RGY1QrenZEVG1XbnBOaEF0bk1uVlN5aW1ld1Ra?=
 =?utf-8?B?emVRQXQwcjNDRTJNeS9kWGFXeG42RjlaaHkxVElmR2ZiSk8rbk91d0VCK0RL?=
 =?utf-8?B?cTJvemlhRnF4UFV0NlU0M3grRWtaMVB2RGU2cGYzS2F6UHBDNFpjanB5Z2or?=
 =?utf-8?B?SHNCRkN3SGw3MktKTHd2QldqMHF2UkFWNmdZbU9jTVF0RmV5a3M2aHI3Vm8y?=
 =?utf-8?B?TjlkVFl6SlBSYmFVSm5aWk5ESFRiRzlRbVhEaFRVcCtyc3IrclFob0RhS1RV?=
 =?utf-8?B?MGk3dWJmdG1GVW5Sa2k0cXdvMkVNVGdwNlBwRVE5d0EzVHlUUzFJZk93RjNW?=
 =?utf-8?B?UWpzMkJYZ252TUNtN2hzWldPUGRQVWZIKzdSTjZXMmlaOGFKeVJsby9neW1k?=
 =?utf-8?B?am50UGZaREYxUDc2N3dWd3pjT1MwVjF2QURzOXpNM29ZdldWOS9KbEZ5dlNT?=
 =?utf-8?B?MEoxUnVWT1VqMU5FbW1OR3NKaEJNQ0wwNXk5cm9mSHV5c2RMcUMvdVM5WVJT?=
 =?utf-8?B?N0NGMkJITGMyd3J6RmE1T1RHejh2czVXTWVzTTZ4M05FajdaZURRZnZ3Ulhz?=
 =?utf-8?B?UTc0UUJoNHVtRlEvalN0K25jMzBOTFhLREFHeXpmNy9UN0Ntb2dacFlKaUs4?=
 =?utf-8?B?dHhuQXBFTDBwcVptYlEvQy94TFJVV24vU0xLVkdjT1RPQVh0b1BOVTV2RzFP?=
 =?utf-8?B?Tlp3TzlEMmNJdVZ3Z2lXb0F2b2VBcUFrN3V4Rno2cUxhc1VyV1ZFQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 35275d76-e558-4a51-de61-08deed877c99
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 15:38:50.0603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nna+NQnQJGPttgtqgbgNmsvTDVJJgy+mYlZlJ8+2o7O0LoeBPktOUgQOul5ok5dDBKOzDCjGTRBsDgEB59dZew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB7156

`UnsafeCell` is able to obtain the extension trait via `Wrapper`.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/pin-init/examples/mutex.rs | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/rust/pin-init/examples/mutex.rs b/rust/pin-init/examples/mutex.rs
index 882f3e23f5dd..e8d4dbb664fe 100644
--- a/rust/pin-init/examples/mutex.rs
+++ b/rust/pin-init/examples/mutex.rs
@@ -79,11 +79,7 @@ pub fn new(val: impl PinInit<T>) -> impl PinInit<Self> {
             wait_list <- ListHead::new(),
             spin_lock: SpinLock::new(),
             locked: Cell::new(false),
-            data <- unsafe {
-                pin_init_from_closure(|slot: *mut UnsafeCell<T>| {
-                    val.__pinned_init(slot.cast::<T>())
-                })
-            },
+            data <- UnsafeCell::pin_init(val),
         })
     }
 

-- 
2.54.0

