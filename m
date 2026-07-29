Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021084.outbound.protection.outlook.com [52.101.100.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741A03C1D4A;
	Wed, 29 Jul 2026 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339549; cv=fail; b=JI/xzXVZVomY/v9UlASMihRuAEDhJoFjwHTCTL+bLwVQbIgR9dUfP2NCXRoN7wk6m3kDF+NBvJPdnKFM0ZFOBbXegVfT9SSQurCZnoJeVzEj3dyGEH2kED86OpwdHRl55m9FYt5zdCS2YEcXbim7vBN2yLO2dU9hdEvFCzvMDxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339549; c=relaxed/simple;
	bh=6S/zpmMVDWX85woylqQrQxqtdTHRWeyHB65QyU118Gw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=E6FZw9Y0Fila8mgDukUNeh3WNMft3PYessosq/DxnkF6J8/ankntx1IPUx1hwQLIIrpWhEmewPBZ9fR+FVqrdrsCnpfky2JKj3NZikOpOm5r+FBvkl3aZMfH7iKN29P2zyRxkGuRldplLq7hamBEOkt4TL0V3H6+g+wVxOzQ7+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=zqVuNEBt; arc=fail smtp.client-ip=52.101.100.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="zqVuNEBt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3YMpheUf6X5r414wuNMPS6behaR/ac8Z36IfHffRY7L3yA7Shl0UD6yy1+SIFYO5cc3vkHza6vRMjoB3ZyyHG3x98Fr3WQrocSPsZ/VDwCzsxufHQLLy6nB4TpagFzf5CVwicUPKfbN8gGMkpbeHKrBhLEXuiRxqGBaBgn3zkRvr58l5405s16sr/3DP6FyY8Pddt7Xz8Ox3W3qSGKM//o8CvrZtAGYs+jtA6i4MbOE9HCOh9wAR2WEK8AJPiyRWgJ5e6qUwxgMzaBs9NRr7i8Up6rT60p7WdKZG/THteQKGKHgfwREpNjMAMB2MzzozLRyEhiQ/AldhBBB/53GTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8NVmKD/D4lZoX+BAM7gsUe5KnaBVhUDmbHu5soYlcA=;
 b=HqctJc2tv8tKH0OG8rFPbgi+StjbAVo4JhqXIXv1OSSll5HJcSawDxsOCk2tk7CxqRqaIn9huIrlPmXK0H4P0lR3PGibuyXZg1hfZTwTcIqCCbPNLNnA+JFF+ZQTbvAWgoTszshDMS48ACk5dSDdlIQ42e8Y0ETyEBXBTMExLQSKDr7G1O9XxloVxsu3kJ/Kp91DEBQ4QozACrVEGdYgoOZsyjlsonlePlbl68nUhnCgowRKVUOreMdMGTVca/hPYL+ucwxwpetAPEAZlpUZJ2K+cqMgHzl/HB+E5DW/Itq/L89cKlVrKccWaLg4opqjg0+FdR9Ez019vjhqOPVHYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8NVmKD/D4lZoX+BAM7gsUe5KnaBVhUDmbHu5soYlcA=;
 b=zqVuNEBtqiJnQRZZakO02IF11y4CNLWpoUptCijjy8X1IuT1hSw3DkXetja+ddG2+NDMt9eq5tqfLrRdroZg9On6KzYz4pTeDljqQCkB8v3Vv0txr/42V8wnATMXoRfdX51XwLSUep0SFaEk66Kc3V0X3PzhyL0jjbr+wTAty4A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB7156.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:31d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 15:38:51 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%2]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 15:38:51 +0000
From: Gary Guo <gary@garyguo.net>
Date: Wed, 29 Jul 2026 16:38:44 +0100
Subject: [PATCH v2 2/5] rust: pin-init: merge `__pinned_init` and `__init`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-merge-init-v2-2-26adf47109e7@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785339529; l=19546;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=6S/zpmMVDWX85woylqQrQxqtdTHRWeyHB65QyU118Gw=;
 b=Q5hfA3HnRNJZ069MtFMl8/oL7aNSyGoMARdBcgWDl6x1pLU3k4LTYpDMDsMc1YtqCkklvW8nx
 cZfyB8Di0vsDw8J8WDQtbOE68KruFK2Vuod8AQXkiRoI/Mh9idqiNEO
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
X-MS-Office365-Filtering-Correlation-Id: e2b6eca4-c695-4e5a-17ab-08deed877cd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|376014|23010399003|18002099003|22082099003|56012099006|6133799003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	pkHzVBAhIkoKR8TKIcZJw1+WUhlQoJ0ot2pHI4mNtNB9pjSwhpi+kjyZAPSTt44LkwoqyKLwFkjG5nq6CqSTHkauc7/6KZ3jaItWT/6F50Ko0434xnKpvxnJWhf9hQDaL+mO/APN09ELNB5u1pJslmcebW828cgcv9FAobtZFzouDTfwFwX6OCx6SK0HWwfwMG29MUqZfB+xvr0LAuj9W7eCUVyVymLdvgHPUtspFAUaH4Sdu5qPV6VZUYA8meZmfhAZNoBKd4Oha3SNhh+FULBUsYTqRPIEkLA+0S3gqdNCNC5iu2WoAClu8m8bAGup6rp/CiNzfpkcTGNnIFu+lNo1qACA0fvZ90tnHwydTWyZ+d7nRtuhVopnVUwlg8K+GkZoVZlTuVzB7I1IudloQ1MHQttQJhRPE4IkwPUv9qwDvvu38HY8+agcbDXeMBKFFK6wG7SpyGSJktJOu/UBG7GR7BL0U6zU/6V7ejvirLBGz3/v64wXodQJWb9hugwBR+4Rl2I+bvwlxFr+p0LzT0MMthYwFUKqmUWAPnY/lDVC82bJgJlXRFjzJ6hyLLkVjv1W56gfQRXh8jlNWirZE0TqmwYiPn5Rle4tmZuopEAHNJ56h0S2PMOyRwmbddKG9AaKWQbg9GKgkCccKFNgpEbG7ALGBAEjztRmVK2/1Ua7xOltV+jQdl4s59KLrY+g2HD1VfIgxjqwGjoQfhicSg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(6133799003)(10067099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cW94UnNkRkw4RDlHU05KTWdjSEdicnVXcjFqWnRzaXh6eEJVczZ0c2F2Vmtz?=
 =?utf-8?B?QVdmVzRMV2hwM2dzdmdmTDJSRVBaZzBIRTRPUGs5S3pjeHc2TDB4d2VLello?=
 =?utf-8?B?bUNkY05HdEZVdlNYMEZCQmJmaXFXeGQrM2pTZnBDa25OUzdCT0ZISXhLZGNv?=
 =?utf-8?B?TVhsaldybVVMT1YwcEs0RGlHa0RDSW1FRXliSVN2OVBNSVM4TUFYMWo5Tktw?=
 =?utf-8?B?Mm5LanZBWnBNdWY2eXNnb0ZDV0FCMGVFUzIrdGtFZVcrbUtrQVBwZnU2U3Y2?=
 =?utf-8?B?R0pDWE5CenVNSldjd2kvTnNld3NZTjBLeGdDM0pBZDg2TkdBMkROSXllY2Yz?=
 =?utf-8?B?bVN4eWsrck1kT3FQaVZZck1RbmtPNk1zWVVhbjgrYUVXOFA2Q04xV0t6UWlK?=
 =?utf-8?B?UjRLaEZhNmZtdk9wQVJ6SHVKUGNPdUNkZmFIcEZveXp5OFJ3K0RMRkVMNlZi?=
 =?utf-8?B?UkQ3MHBzV25HbnFBZXk1cXlTVUlJSG5uRUFMWmVIenJYem9VRnJTZDJINEVE?=
 =?utf-8?B?ZDh4QVROL044blU3czQ5ZTlXRWxDMlhBbW1mbGJERFkrMGhONC9kVFcwSWVQ?=
 =?utf-8?B?OXFOcEVSQ0p3Z2ZiN0xkVGNGMloxd1RlWTF3Z2FScVFtbkU2ZnZGVE1VWk9n?=
 =?utf-8?B?TEF2eTIxQkkzQ2tGTWZPMEFoVURISjBCL2kxcndjbWdQWm9aeEYwS3p5THE5?=
 =?utf-8?B?cXZhdUhTUjF1QnU0bEY1NlduV3JsU0MzN2FXdVVtamNFeVpMYTh4WkZnMVlT?=
 =?utf-8?B?VjJUVFpteXoxbXYrRXorRnRCS0hlQ3ZvbTE5V2VmS05abFpxWTBwUCtIbW93?=
 =?utf-8?B?c1VZcjNLYlhkcmZ1VFpzL0pmMDVxOGRkeU1Hcy9FREs2WFBPcVZQa2ZmdmdR?=
 =?utf-8?B?NTRnNFNvMHZFQ1lCdUVsdVFQWVdzRWVLQmZqT0Eyek0rZGNvRGwxcll4b3Nn?=
 =?utf-8?B?WmtOTFVvL0t2MXBMR2NFdThCQ3hMNUJacTh0ekkrdVhjOFFCTEhjT1BFaFJq?=
 =?utf-8?B?NTd2RGM1WXdwR1VmeDBJbmVvYU1oSjYyUGp6OWFhbEVidnc4b0pYQS9zWXho?=
 =?utf-8?B?UVM1RkhkYlJVeWtRdk1SZG9VMGg4KzkwT1hOOFBaRXhqazdTV0pQZ3MwcC81?=
 =?utf-8?B?QjRRa0xkQjIzYkx1VDNXcFVOMXFJZEVkYXdTNnZQVlRZQnIvaXl4N0d3dGhR?=
 =?utf-8?B?L2puaThGcWE5YTBjVWcyTVlmOEhob0FNdUpyOUh0KzBud1lWaG1SSzk2b3pT?=
 =?utf-8?B?U0pmeEZwVWhWejh6aDNhRTAzb1c1Z1NhZVlMVEpYVW5ra283c1BnRVBFR3pa?=
 =?utf-8?B?S2Rud3JXTEN5d21RbDM2Ris0Z0hrcm1SUmNGbEIrTWVKWkx4Vkt5aW1ITjBk?=
 =?utf-8?B?Q0JNeTBVR2xyRTVRNm9idkdEQ0ZZWWxxdmg4alQ4cmx4K1cyd1g4bWc1L0Y1?=
 =?utf-8?B?MnVCY09jM2N2SUFRaUkzemVWdUFibld3UzA2VmxBck02NytrQ0R4Nk9Qc0hX?=
 =?utf-8?B?TDVzR3UzZ2NITkxJcTl0L3hOU3RCT0orMTFheFRQby9xZU85ZHJaYXpTbDJ0?=
 =?utf-8?B?cnpYc1ZqNGs5U2JIYS8xWXVqaDhCenBzclNEV1ZvTFI5dXBzZ1VyYVlpWXdG?=
 =?utf-8?B?WUdqL05oWVVoU0phQWp4T1B2OVJvbS9BU2ptT2VaeVlqMG5lVzk0dnp5R1A4?=
 =?utf-8?B?OERWeFdIYmk4dm1QMHZOcDNIVDV3c1dWb0ZkU2l0SmhaVitaYUVHMHltZGRr?=
 =?utf-8?B?dVFiOXdHZlJSVmpHZTlKaXR2Zjc3T2NqTjBBSnA0OUFKVmVJaXNVUmNERlpq?=
 =?utf-8?B?VUZSSUVSUmdDTnhHekQ1ZWFxTFBhYTRTdm5uZ3RhancrSmpSWmhQQ0NxQm04?=
 =?utf-8?B?Yk16c1c5Tk5YeTc5M3R5V0dzL3pxSzR6aXlhR2k0MXpqMlRVZXFvZUdBU0lX?=
 =?utf-8?B?MWFBNG5OUHZXZ3ZYNHE2SHFvMHpZRlVFUWJzZTRDNmpVckc5SUdiZ0hzeklO?=
 =?utf-8?B?YktQbDVMWFo4Z0FJdW9ZVGJiK1Ayd0o0N2Q1ZnFJVENQT05MOTYyMzBSZVQ4?=
 =?utf-8?B?Z2t6cTE4N2J3bGNrY3o5Si94T3J5SjdRREN1c0RLSFRpN2J2S3hQT0lWRHF2?=
 =?utf-8?B?M3hodkFVbldueU1wNkl6Rk5qeWZwTExCeE9wbS92T3RhVGFmTSsxOFAvR1pW?=
 =?utf-8?B?akVXSkZTK1VkcmU4TG45ZTlaU3haQVRFb1NIc2J5MWtWeHVHL0l2ak9EcGxl?=
 =?utf-8?B?UStCZkpGa1hZS0NNamlDRS95cXhXeDJBZUZndWQ5N2JQV2diU0NkM1U5bHhl?=
 =?utf-8?B?aHBjcEZMeDFMMERnUUd2SFdueFRjcG93VnpobXVjR05lYm9iU1VmUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b6eca4-c695-4e5a-17ab-08deed877cd0
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 15:38:50.4255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ss1zboEyqj3av9C4fUG9XMhZV4SDtodQ9P6mOB2nNOKKYkC5cQX1BPm2MsmVQ6vVWAPT4C5/zoUQWHpFRaNT/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB7156

These functions have the same requirements and are also required to execute
the same code. Prevent duplication by merging them to the single function
and document the additional relaxation of `Init::__init` on both the merged
function and the safety requirement of `Init`.

The existing `__pinned_init` function is deprecated and kept for
compatibility for existing users. For `cfg(kernel)`, it is soft-deprecated
for now and will be removed when all users are migrated.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/pin-init/examples/static_init.rs |   9 +--
 rust/pin-init/src/__internal.rs       |   8 +-
 rust/pin-init/src/alloc.rs            |   6 +-
 rust/pin-init/src/lib.rs              | 146 +++++++++++++---------------------
 4 files changed, 67 insertions(+), 102 deletions(-)

diff --git a/rust/pin-init/examples/static_init.rs b/rust/pin-init/examples/static_init.rs
index 58cd4241b78c..8e71556ffe85 100644
--- a/rust/pin-init/examples/static_init.rs
+++ b/rust/pin-init/examples/static_init.rs
@@ -59,7 +59,7 @@ fn deref(&self) -> &Self::Target {
             println!("doing init");
             let ptr = self.cell.get().cast::<T>();
             match self.init.take() {
-                Some(f) => unsafe { f.__pinned_init(ptr).unwrap() },
+                Some(f) => unsafe { f.__init(ptr).unwrap() },
                 None => unsafe { core::hint::unreachable_unchecked() },
             }
             self.present.set(true);
@@ -71,13 +71,10 @@ fn deref(&self) -> &Self::Target {
 pub struct CountInit;
 
 unsafe impl PinInit<CMutex<usize>> for CountInit {
-    unsafe fn __pinned_init(
-        self,
-        slot: *mut CMutex<usize>,
-    ) -> Result<(), core::convert::Infallible> {
+    unsafe fn __init(self, slot: *mut CMutex<usize>) -> Result<(), core::convert::Infallible> {
         let init = CMutex::new(0);
         std::thread::sleep(std::time::Duration::from_millis(1000));
-        unsafe { init.__pinned_init(slot) }
+        unsafe { init.__init(slot) }
     }
 }
 
diff --git a/rust/pin-init/src/__internal.rs b/rust/pin-init/src/__internal.rs
index 56dc655e323e..ae9a0e68cd75 100644
--- a/rust/pin-init/src/__internal.rs
+++ b/rust/pin-init/src/__internal.rs
@@ -181,7 +181,7 @@ pub fn init<E>(self: Pin<&mut Self>, init: impl PinInit<T, E>) -> Result<Pin<&mu
             unsafe { this.value.assume_init_drop() };
         }
         // SAFETY: The memory slot is valid and this type ensures that it will stay pinned.
-        unsafe { init.__pinned_init(this.value.as_mut_ptr())? };
+        unsafe { init.__init(this.value.as_mut_ptr())? };
         // INVARIANT: `this.value` is initialized above.
         this.is_init = true;
         // SAFETY: The slot is now pinned, since we will never give access to `&mut T`.
@@ -289,7 +289,7 @@ pub fn init<E>(self, init: impl PinInit<T, E>) -> Result<DropGuard<Pinned, T>, E
         // - when `Err` is returned, we also propagate the error without touching `ptr`;
         //   also `self` is consumed so it cannot be touched further.
         // - the drop guard will not hand out `&mut` (only `Pin<&mut T>`).
-        unsafe { init.__pinned_init(self.ptr)? };
+        unsafe { init.__init(self.ptr)? };
 
         // SAFETY:
         // - `self.ptr` is valid, properly aligned and pinned per type invariant.
@@ -396,9 +396,9 @@ fn default() -> Self {
     }
 }
 
-// SAFETY: `__pinned_init` always fails, which is always okay.
+// SAFETY: `__init` always fails, which is always okay.
 unsafe impl<T: ?Sized> PinInit<T, ()> for AlwaysFail<T> {
-    unsafe fn __pinned_init(self, _slot: *mut T) -> Result<(), ()> {
+    unsafe fn __init(self, _slot: *mut T) -> Result<(), ()> {
         Err(())
     }
 }
diff --git a/rust/pin-init/src/alloc.rs b/rust/pin-init/src/alloc.rs
index 5017f57442d8..641f4c7ce890 100644
--- a/rust/pin-init/src/alloc.rs
+++ b/rust/pin-init/src/alloc.rs
@@ -38,7 +38,7 @@ fn try_pin_init<E>(init: impl PinInit<T, E>) -> Result<Pin<Self>, E>
     fn pin_init(init: impl PinInit<T>) -> Result<Pin<Self>, AllocError> {
         // SAFETY: We delegate to `init` and only change the error type.
         let init = unsafe {
-            pin_init_from_closure(|slot| match init.__pinned_init(slot) {
+            pin_init_from_closure(|slot| match init.__init(slot) {
                 Ok(()) => Ok(()),
                 Err(i) => match i {},
             })
@@ -109,7 +109,7 @@ fn try_pin_init<E>(init: impl PinInit<T, E>) -> Result<Pin<Self>, E>
         let slot = slot.as_mut_ptr();
         // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
         // slot is valid and will not be moved, because we pin it later.
-        unsafe { init.__pinned_init(slot)? };
+        unsafe { init.__init(slot)? };
         // SAFETY: All fields have been initialized and this is the only `Arc` to that data.
         Ok(unsafe { Pin::new_unchecked(this.assume_init()) })
     }
@@ -149,7 +149,7 @@ fn write_pin_init<E>(mut self, init: impl PinInit<T, E>) -> Result<Pin<Self::Ini
         let slot = self.as_mut_ptr();
         // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
         // slot is valid and will not be moved, because we pin it later.
-        unsafe { init.__pinned_init(slot)? };
+        unsafe { init.__init(slot)? };
         // SAFETY: All fields have been initialized.
         Ok(unsafe { self.assume_init() }.into())
     }
diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
index f4ccb0e87200..fde53473763f 100644
--- a/rust/pin-init/src/lib.rs
+++ b/rust/pin-init/src/lib.rs
@@ -889,7 +889,7 @@ macro_rules! assert_pinned {
 /// When implementing this trait you will need to take great care. Also there are probably very few
 /// cases where a manual implementation is necessary. Use [`pin_init_from_closure`] where possible.
 ///
-/// The [`PinInit::__pinned_init`] function:
+/// The [`PinInit::__init`] function:
 /// - returns `Ok(())` if it initialized every field of `slot`,
 /// - returns `Err(err)` if it encountered an error and then cleaned `slot`, this means:
 ///     - `slot` can be deallocated without UB occurring,
@@ -909,6 +909,20 @@ macro_rules! assert_pinned {
 #[cfg_attr(not(kernel), doc = "[`Box<T>`]: alloc::alloc::boxed::Box")]
 #[must_use = "An initializer must be used in order to create its value."]
 pub unsafe trait PinInit<T: ?Sized, E = Infallible>: Sized {
+    /// Alias of [`PinInit::__init`].
+    ///
+    /// New code should use `__init` instead.
+    ///
+    /// # Safety
+    ///
+    /// Same as `__init`.
+    #[inline(always)]
+    #[cfg_attr(not(kernel), deprecated = "use `__init` instead")]
+    unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
+        // SAFETY: Per safety requirement.
+        unsafe { self.__init(slot) }
+    }
+
     /// Initializes `slot`.
     ///
     /// # Safety
@@ -917,7 +931,8 @@ pub unsafe trait PinInit<T: ?Sized, E = Infallible>: Sized {
     /// - the caller does not touch `slot` when `Err` is returned, they are only permitted to
     ///   deallocate.
     /// - `slot` will not move until it is dropped, i.e. it will be pinned.
-    unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E>;
+    ///   If `Self: Init<T, E>`, this requirement is cancelled and it may be moved.
+    unsafe fn __init(self, slot: *mut T) -> Result<(), E>;
 
     /// First initializes the value using `self` then calls the function `f` with the initialized
     /// value.
@@ -948,7 +963,7 @@ fn pin_chain<F>(self, f: F) -> ChainPinInit<Self, F, T, E>
 /// An initializer returned by [`PinInit::pin_chain`].
 pub struct ChainPinInit<I, F, T: ?Sized, E>(I, F, __internal::PhantomInvariant<(E, T)>);
 
-// SAFETY: The `__pinned_init` function is implemented such that it
+// SAFETY: The `__init` function is implemented such that it
 // - returns `Ok(())` on successful initialization,
 // - returns `Err(err)` on error and in this case `slot` will be dropped.
 // - considers `slot` pinned.
@@ -957,8 +972,8 @@ unsafe impl<T: ?Sized, E, I, F> PinInit<T, E> for ChainPinInit<I, F, T, E>
     I: PinInit<T, E>,
     F: FnOnce(Pin<&mut T>) -> Result<(), E>,
 {
-    unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
-        // SAFETY: All requirements fulfilled since this function is `__pinned_init`.
+    unsafe fn __init(self, slot: *mut T) -> Result<(), E> {
+        // SAFETY: All requirements fulfilled since this function is `__init`.
         let slot = unsafe { __internal::Slot::<__internal::Pinned, _>::new(slot) };
         let mut guard = slot.init(self.0)?;
         (self.1)(guard.let_binding())?;
@@ -980,19 +995,8 @@ unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
 /// When implementing this trait you will need to take great care. Also there are probably very few
 /// cases where a manual implementation is necessary. Use [`init_from_closure`] where possible.
 ///
-/// The [`Init::__init`] function:
-/// - returns `Ok(())` if it initialized every field of `slot`,
-/// - returns `Err(err)` if it encountered an error and then cleaned `slot`, this means:
-///     - `slot` can be deallocated without UB occurring,
-///     - `slot` does not need to be dropped,
-///     - `slot` is not partially initialized.
-/// - while constructing the `T` at `slot` it upholds the pinning invariants of `T`.
-///
-/// The `__pinned_init` function from the supertrait [`PinInit`] needs to execute the exact same
-/// code as `__init`.
-///
-/// Contrary to its supertype [`PinInit<T, E>`] the caller is allowed to
-/// move the pointee after initialization.
+/// The [`PinInit::__init`] function must work without the pinning requirement; the caller is
+/// allowed to move the pointee after initialization.
 ///
 #[cfg_attr(
     kernel,
@@ -1006,15 +1010,6 @@ unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
 #[cfg_attr(not(kernel), doc = "[`Box<T>`]: alloc::alloc::boxed::Box")]
 #[must_use = "An initializer must be used in order to create its value."]
 pub unsafe trait Init<T: ?Sized, E = Infallible>: PinInit<T, E> {
-    /// Initializes `slot`.
-    ///
-    /// # Safety
-    ///
-    /// - `slot` is a valid pointer to uninitialized memory.
-    /// - the caller does not touch `slot` when `Err` is returned, they are only permitted to
-    ///   deallocate.
-    unsafe fn __init(self, slot: *mut T) -> Result<(), E>;
-
     /// First initializes the value using `self` then calls the function `f` with the initialized
     /// value.
     ///
@@ -1053,10 +1048,18 @@ fn chain<F>(self, f: F) -> ChainInit<Self, F, T, E>
 /// An initializer returned by [`Init::chain`].
 pub struct ChainInit<I, F, T: ?Sized, E>(I, F, __internal::PhantomInvariant<(E, T)>);
 
+// SAFETY: The `__init` function does not rely on the pinning requirement.
+unsafe impl<T: ?Sized, E, I, F> Init<T, E> for ChainInit<I, F, T, E>
+where
+    I: Init<T, E>,
+    F: FnOnce(&mut T) -> Result<(), E>,
+{
+}
+
 // SAFETY: The `__init` function is implemented such that it
 // - returns `Ok(())` on successful initialization,
 // - returns `Err(err)` on error and in this case `slot` will be dropped.
-unsafe impl<T: ?Sized, E, I, F> Init<T, E> for ChainInit<I, F, T, E>
+unsafe impl<T: ?Sized, E, I, F> PinInit<T, E> for ChainInit<I, F, T, E>
 where
     I: Init<T, E>,
     F: FnOnce(&mut T) -> Result<(), E>,
@@ -1071,44 +1074,28 @@ unsafe fn __init(self, slot: *mut T) -> Result<(), E> {
     }
 }
 
-// SAFETY: `__pinned_init` behaves exactly the same as `__init`.
-unsafe impl<T: ?Sized, E, I, F> PinInit<T, E> for ChainInit<I, F, T, E>
-where
-    I: Init<T, E>,
-    F: FnOnce(&mut T) -> Result<(), E>,
-{
-    unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
-        // SAFETY: `__init` has less strict requirements compared to `__pinned_init`.
-        unsafe { self.__init(slot) }
-    }
-}
-
 /// Implement `PinInit` and `Init` for closures.
 ///
 /// It is unsafe to create this type, since the closure needs to fulfill the same safety
-/// requirement as the `__pinned_init`/`__init` functions.
+/// requirement as the `__init` functions.
 struct InitClosure<F, T: ?Sized>(F, __internal::PhantomInvariant<T>);
 
-// SAFETY: While constructing the `InitClosure`, the user promised that it upholds the
-// `__init` invariants.
-unsafe impl<T: ?Sized, F, E> Init<T, E> for InitClosure<F, T>
-where
-    F: FnOnce(*mut T) -> Result<(), E>,
+// SAFETY: When constructing via `init_from_closure`, the `__init` function does not rely on the
+// pinning requirement. When constructing via `pin_init_from_closure`, the opaque type prevents this
+// implementation from being visible.
+unsafe impl<T: ?Sized, F, E> Init<T, E> for InitClosure<F, T> where
+    F: FnOnce(*mut T) -> Result<(), E>
 {
-    #[inline]
-    unsafe fn __init(self, slot: *mut T) -> Result<(), E> {
-        (self.0)(slot)
-    }
 }
 
 // SAFETY: While constructing the `InitClosure`, the user promised that it upholds the
-// `__pinned_init` invariants.
+// `__init` invariants.
 unsafe impl<T: ?Sized, F, E> PinInit<T, E> for InitClosure<F, T>
 where
     F: FnOnce(*mut T) -> Result<(), E>,
 {
     #[inline]
-    unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
+    unsafe fn __init(self, slot: *mut T) -> Result<(), E> {
         (self.0)(slot)
     }
 }
@@ -1160,7 +1147,7 @@ unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
 pub const unsafe fn cast_pin_init<T, U, E>(init: impl PinInit<T, E>) -> impl PinInit<U, E> {
     // SAFETY: initialization delegated to a valid initializer. Cast is valid by function safety
     // requirements.
-    unsafe { pin_init_from_closure(|ptr: *mut U| init.__pinned_init(ptr.cast::<T>())) }
+    unsafe { pin_init_from_closure(|ptr: *mut U| init.__init(ptr.cast::<T>())) }
 }
 
 /// Changes the to be initialized type.
@@ -1195,7 +1182,7 @@ pub fn uninit<T, E>() -> impl Init<MaybeUninit<T>, E> {
     F: FnMut(usize) -> I,
     I: PinInit<T, E>,
 {
-    unsafe fn __pinned_init(mut self, slot: *mut [T; N]) -> Result<(), E> {
+    unsafe fn __init(mut self, slot: *mut [T; N]) -> Result<(), E> {
         /// # Invariants
         ///
         /// - `ptr[..num_init]` contains initialized elements of type `T`
@@ -1237,7 +1224,7 @@ fn drop(&mut self) {
             // - If `Err` is touched, the subslot is not touched further, the guard will drop
             //   previously initialized elements only.
             // - `slot` is pinned so is the subslot.
-            unsafe { init.__pinned_init(&raw mut (*slot)[i]) }?;
+            unsafe { init.__init(&raw mut (*slot)[i]) }?;
         }
 
         // Dismiss the drop guard now that all elements are initialized.
@@ -1246,18 +1233,13 @@ fn drop(&mut self) {
     }
 }
 
-// SAFETY: Follows the `PinInit` impl. `__init` executes the same code as `__pinned_init`.
+// SAFETY: `I: Init` cancels out the pinning requirement on subslots, which is the only place in the
+// `__init` function that relies on `slot` being pinned.
 unsafe impl<T, F, I, E, const N: usize> Init<[T; N], E> for ArrayInit<T, F>
 where
     F: FnMut(usize) -> I,
     I: Init<T, E>,
 {
-    #[inline(always)]
-    unsafe fn __init(self, slot: *mut [T; N]) -> Result<(), E> {
-        // SAFETY: `I: Init` cancels out the pinning requirement on subslots. The other safety
-        // requirements follow that of `__init`.
-        unsafe { self.__pinned_init(slot) }
-    }
 }
 
 /// Initializes an array by initializing each element via the provided initializer.
@@ -1336,13 +1318,13 @@ pub fn pin_init_scope<T, E, F, I>(make_init: F) -> impl PinInit<T, E>
 {
     // SAFETY:
     // - If `make_init` returns `Err`, `Err` is returned and `slot` is completely uninitialized,
-    // - If `make_init` returns `Ok`, safety requirement are fulfilled by `init.__pinned_init`.
-    // - The safety requirements of `init.__pinned_init` are fulfilled, since it's being called
-    //   from an initializer.
+    // - If `make_init` returns `Ok`, safety requirement are fulfilled by `init.__init`.
+    // - The safety requirements of `init.__init` are fulfilled, since it's being called from an
+    //   initializer.
     unsafe {
         pin_init_from_closure(move |slot: *mut T| -> Result<(), E> {
             let init = make_init()?;
-            init.__pinned_init(slot)
+            init.__init(slot)
         })
     }
 }
@@ -1390,41 +1372,27 @@ pub fn init_scope<T, E, F, I>(make_init: F) -> impl Init<T, E>
     }
 }
 
-// SAFETY: the `__init` function always returns `Ok(())` and initializes every field of `slot`.
-unsafe impl<T> Init<T> for T {
-    unsafe fn __init(self, slot: *mut T) -> Result<(), Infallible> {
-        // SAFETY: `slot` is valid for writes by the safety requirements of this function.
-        unsafe { slot.write(self) };
-        Ok(())
-    }
-}
+// SAFETY: The `__init` function does not rely on slot being pinned after it returns.
+unsafe impl<T> Init<T> for T {}
 
-// SAFETY: the `__pinned_init` function always returns `Ok(())` and initializes every field of
+// SAFETY: the `__init` function always returns `Ok(())` and initializes every field of
 // `slot`. Additionally, all pinning invariants of `T` are upheld.
 unsafe impl<T> PinInit<T> for T {
-    unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), Infallible> {
+    unsafe fn __init(self, slot: *mut T) -> Result<(), Infallible> {
         // SAFETY: `slot` is valid for writes by the safety requirements of this function.
         unsafe { slot.write(self) };
         Ok(())
     }
 }
 
-// SAFETY: when the `__init` function returns with
-// - `Ok(())`, `slot` was initialized and all pinned invariants of `T` are upheld.
-// - `Err(err)`, slot was not written to.
-unsafe impl<T, E> Init<T, E> for Result<T, E> {
-    unsafe fn __init(self, slot: *mut T) -> Result<(), E> {
-        // SAFETY: `slot` is valid for writes by the safety requirements of this function.
-        unsafe { slot.write(self?) };
-        Ok(())
-    }
-}
+// SAFETY: The `__init` function does not rely on slot being pinned after it returns.
+unsafe impl<T, E> Init<T, E> for Result<T, E> {}
 
-// SAFETY: when the `__pinned_init` function returns with
+// SAFETY: when the `__init` function returns with
 // - `Ok(())`, `slot` was initialized and all pinned invariants of `T` are upheld.
 // - `Err(err)`, slot was not written to.
 unsafe impl<T, E> PinInit<T, E> for Result<T, E> {
-    unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
+    unsafe fn __init(self, slot: *mut T) -> Result<(), E> {
         // SAFETY: `slot` is valid for writes by the safety requirements of this function.
         unsafe { slot.write(self?) };
         Ok(())
@@ -1467,7 +1435,7 @@ fn write_pin_init<E>(self, init: impl PinInit<T, E>) -> Result<Pin<Self::Initial
         //
         // The `'static` borrow guarantees the data will not be
         // moved/invalidated until it gets dropped (which is never).
-        unsafe { init.__pinned_init(slot)? };
+        unsafe { init.__init(slot)? };
 
         // SAFETY: The above call initialized the memory.
         Ok(Pin::static_mut(unsafe { self.assume_init_mut() }))

-- 
2.54.0

