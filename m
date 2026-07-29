Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021084.outbound.protection.outlook.com [52.101.100.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D7E3AAF6C;
	Wed, 29 Jul 2026 15:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339545; cv=fail; b=U78/8d16ydlrT85jhuMMBEW5PrrS8xIrrMjuomQcFdSYJTrAazFvTpl5mJiKOVON0eGLdMIbFVgpT4kO8ZouhTHZNMO9viSt2A4qb8JQiRgoBmG+GqYupwhbtGbIbtxpeny5IPf1ZJPK9caDtWAMQTX/a0aypDWianlVctpasQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339545; c=relaxed/simple;
	bh=VEQEJJbsDI8hY5xCoH48JC9TExDj/LVMNtVpVom2uzo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jKJOZh4+UtEMuKwOdGJJJLfr6hvtd4zs5PsOKwAxHqKRC37Xx9nuuClNKbI5YAAP51g5noClir0zXW0HwggkZgILkheHs8gh5mhoY+nFRaQhaQft0kkMLhkfgnTf64QgTOLHNBoZofSxHAG/YmenO84dJDdW70YaIsWgWPycicM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=YVlkvYqE; arc=fail smtp.client-ip=52.101.100.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="YVlkvYqE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AB+Lv5wz4e++ZtHALJ1R2srl1Wdl2eb0EEJu+Mr6egSawyqH0uPGrcLozb42tIMDmIon40Yuzyc+ws3otgSx5/LIbIojHV+e36HTSruZjHz4Xq6Gx1mtbEtx/xv6r5zAme/ybsnq6AtSoIpKQ5nFsMWNuLV8QRk9TIxhHcLvc12+iS2QvSJ6TW3rWraejkkZ+rVMToG8wA+hW35Oyke3l5yDrCG4Y/q+qnGvcl0Mh93AyjtLAHoQDldNSn47y2fcw25bWIv/ZP4sQycTQGaOMeY4SjuQmNoCmzeI2nHEWLpn3+fMI6hOp8+U+u5joKRAFbDQgldu2fZUQoH0EHUuFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHlz9WAI7S//M+J0yaYaE0PSAJUtSeCjjL/fnGXasdM=;
 b=Rm4iIQkNop7j8eRJXTbebn/MSiTTGPuiiN5phverouX3n4DTndYIqODDIW1ewm5umVXQMKZMbPoxieVi3N+A7z5BAL9RdXbShUT/5uiFDELIriglKZRXKzro79RdT36y3ygnWmXvoW7Gp1Ov+tKINxl+bAAGQsTe3KYSuzEnh6Xx0+7miaSEd7rwPE/k42jAh34rhzSlGFSzzlP0fOBJ/ltAzQecT3VjKXvDDGHFfjnmJdIEixlyDASEr69f6Jup5XlX+3ycPBek6l3wuVq2DzL2Sbxxf0+HFByJBXuWTjNUF2GCTX7CvJg86RP8JZh8QGJBwvBy+Y80DprzHn+dVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHlz9WAI7S//M+J0yaYaE0PSAJUtSeCjjL/fnGXasdM=;
 b=YVlkvYqEcmaYutN25jLLqZQk+Cw9BmHgW7dltyo0MpugY8ee5A5FaGAMno0tIWfag6tdUL9kjtNl8+8Ilx3MqF8ORYH9cy83+CZe2Dmn8yJqlP2wD8dM0ORdgjxDiwPao0DSs4NI7BC9XPWK6U/nUiudkV3vVeT2pgvInFoRVJ0=
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
Date: Wed, 29 Jul 2026 16:38:46 +0100
Subject: [PATCH v2 4/5] rust: treewide: replace `__pinned_init` with
 `ptr_[try_]init`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-merge-init-v2-4-26adf47109e7@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785339529; l=13259;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=VEQEJJbsDI8hY5xCoH48JC9TExDj/LVMNtVpVom2uzo=;
 b=umXMuRHHErVgK/XOlzuD3oMp+vFsfOjy0AT+rqn5d4F9OBFwEifAtlPITwIbWU0nefmqozLW8
 i4PyKw5oHlVAMJ2c87ejm79KKWNkwUT6lS6fkr8NdVjYZesyRkpuUx7
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
X-MS-Office365-Filtering-Correlation-Id: 695ac10b-324b-4f27-17c3-08deed877d39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|376014|23010399003|18002099003|22082099003|56012099006|6133799003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	H300m2lRGvAoqXnQWkZLz8Suihbqn/gtKwhbiGWeKvw8I9EueXcUFrSZedIHbtj5mUemVvChuD3gGiu2sugKjndLlQUB46Libb2S9F+j8cTq0XZufs+GYCUYx+Fvv/wFPRE50fdAO2qcVR//yffK4rHHQ45SHD5OrGfVOVgH6yfif67uY6Zy1FeOex7XfJN1qLtv7ZvmGokX471qkWv9PYxFYo42qFPWCFXY48I1+IIhr+Dbd2RDQDdL48X6gSyy5H+jQ0nrCswwj4xAcp0m8aqNmXE6stUG3A/dmIJTzGZcLlcp9QrUfyBJ0XZHZfwoGf2drmtb1JhsOHkNJzzaO9Pfi7lKYdW/GYh6MG0scpkUFcE3NNGZCMH2EIpHGC1NihkQkTf5Dfu9J1+6L6+jM6L3i7etzITIkpOGZARDyokQYLs0SfYtIXFeqwiJaOOX44K73rNTlamRWqvUvSCsMPmVZy6Q0hvJTbBd539oIhX9VuRJMvEBqbGG2ixvgA8JCo2p817P0PCLC0Kygwwy+BuR2TktaRcQImyQ/EjRSrlZ/twP77fshDxVSOe8JwjDfxWQR9SXSHqf4ih14h9mMHW2o3bUUlX+OozNMyYEm9TIUKdVMe8WhdzZhQhLbWXmoZnHq2Kiky2tvECc+PH857Gy53/eqHk2zeRLo+pOccQnxydL8Dcwz3tw57pTOwT8nXyQUTwOHFHTMnmT3j9iWw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(6133799003)(10067099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXNKOGtPYmNLdDZQdmc4enlqZGl3MDdFZ0I3SCs4eVdjalFvMnhnTUpuNkN4?=
 =?utf-8?B?R2NHTzloR0lsRnpBTW1sSGljcThsT0srYWNGY1pxa05KMHpjQzFQQ21kREJF?=
 =?utf-8?B?K3JEVVFxeVI4UTlOeVlDK0NEUEpOQURNZG1lR2NleHpDVTNhM1l2K3hhZkds?=
 =?utf-8?B?SU13ejdGMVk1K2RGVTB6UDc3OENKNEpKQTB1Y1Vha2ZlTDkvUm0yUTNNSkdh?=
 =?utf-8?B?aXArb29lSlVvVG8xUFFRL0dHZnl3T3o3NHhTc2pYME1mL1lsaVJ6SzZVZS9N?=
 =?utf-8?B?cnp0R2xQeTh6Y3FrUGU0MEpuVVZvclg2WTVsc0NRQTg2MDZaVFF6bGJsMU45?=
 =?utf-8?B?WURuOXdTS1cvMERFUHVFdG03TVE3L0cyQlB2Y1VHdjhMdHVBbnVVZUNGc0tr?=
 =?utf-8?B?WFE1c0VpeGpvMDFQMU9tWDlhaVJKTmpBZmc1WmlQZE8vb2pzMVc1UGpydm01?=
 =?utf-8?B?N1NUOFE0YTFlc3czdEtjMjhmOWRRTGs0RiswV0dUUEQ4ODBpSXdNR1Q1ajhF?=
 =?utf-8?B?eG02eTdkZFN3d3dxYlRLc0k1MUlaZmhBQWs5TE9rWlIrOFFrSzRQdjlGQ2F4?=
 =?utf-8?B?aWVHTXVMQXRhTzFkV0FnV2l2ZnJENU1ON3pnN25yQndpZERtVHRmSEhNbm9X?=
 =?utf-8?B?MCtUcnl1MnExMTBNVytzbzMzRkF5eVNNMDVoVjlPRGpha0xZTnFvVENtN0dP?=
 =?utf-8?B?RVgwUWxUbzg5ZmFybmdUb3hBbFZ3R292TVhaaU1TcnFyMUZQclY4cUk5MWg2?=
 =?utf-8?B?RFp2bTMrNUVnRlRma21SUnpoa2dXSzBMbWE2NWwzWW5mRjZzdmJFZk1lTXNp?=
 =?utf-8?B?RHYvSWJnUkxqaG9INDBMOVQ4dk04OUNDSHo3K1dMVnBIaWRpTjlidzV3ZlJ2?=
 =?utf-8?B?QTl4cUpVaVo3elBkSU9tN2d2RWpMdkdMMWtraGkxcHF5ZkhSV0tkSWNTR1hp?=
 =?utf-8?B?UGEzenZIL095alNZd09KNWhSU1pvWGtYaHkwZmxvSGhwNTIyWWsyRSs3clV5?=
 =?utf-8?B?Q2dmdUdBcTJGLzlCaGJwRzJFVFFEY1pxTldydEI1N1ZrOVJkVDdUV0NWU0lt?=
 =?utf-8?B?b280TklKbFNVbUFrNXEyQUVhbzR5ZEtiTnEyZlBGMkZST25pTTA4dzN5UlZh?=
 =?utf-8?B?eVFvc2x4Q3BmdVFFdkpkSnd4MHB5OUVCN3hFMExYVnVsbFpuWE9XMUdNVnpK?=
 =?utf-8?B?ZFNMYlpPQnRITDVCYnNGT3hoelU4a2RKUWtBUUVWZ1I3YTZmeHZBeTdmSEdB?=
 =?utf-8?B?TS85TTJuK2ZyTWVSaDBvaWVlSW9WWEhGUC9UUk9sd204OFlEdVA4NnBGV29l?=
 =?utf-8?B?dnJMS3U3ZlMxdXhwQlQ0eVhzM2FlOVRuZ3YrQ0t0MXo4OS8wWUpNelVXUGFq?=
 =?utf-8?B?bHJlMmd0QXRlYk1TK0NuSVZWbVExenNXU3ptQy8vVG1ZZmM3QU15RHR3THYx?=
 =?utf-8?B?VVF3RjhodE0yOTBQTlJCQWE2cHNpemV6WE9DSkwvVW8ydG5ML0FhWUlGRzBU?=
 =?utf-8?B?cHZXVkxIODFWNFQ4RlRaVjFzNWUwWUFiS3J6bGRwdGJNZU1YRHB2M0RXbmoz?=
 =?utf-8?B?eGo5MVR3ZHlyT0ZsZ2pibW9tVXBTaEJISkhZNTUyQU9JU2NaYlVBbUczNFY2?=
 =?utf-8?B?dzdIcmNWdEgwcmFlMEhVSE1qSURYR1VVWkx0RSszVTVreGMrVFVYYnJsOUZY?=
 =?utf-8?B?SlNOWk1DVnZvZmc3U21vMUdGbEdMTEFNaStTQnBnNDd4VmZSMHlaNHRxTHpO?=
 =?utf-8?B?RlltQnRGcEVJZ0tTS0NvTlpJb0VSN1h5RXpuRVVmM2tVVUtDL29BZk9Td3Y0?=
 =?utf-8?B?b25Wb2QxY21TU0Myb0hNcWkrL3JUblNpU25VSGhOcGpnam03U0FtbkJkWnZY?=
 =?utf-8?B?YjhRM1UzVXhIWGFZNlVlZHk0bFRucVpqZFZJUnBCQzhXcjZlanBwdTVJUVFU?=
 =?utf-8?B?MlhQMGlDdnc3elZ5VVlLQkd3ZGx1SDI2OVJCV2xmOGo2UzhQcldoTUV0MG1S?=
 =?utf-8?B?ZXFYNUdaSjZTNHJJQVhvK2JGcEpWSzdPZGgzZXJXRUdQWE9hNS9TTmg4Z1dS?=
 =?utf-8?B?UXlFZ2pMdmJyUWdvSlJWYkFlM2RGY2ZxOXhWUmMxTG9JRFA1SENhMCtwdUps?=
 =?utf-8?B?b094ckJhY0lnbjhJWW41dzVlSGZ2dmJ0NDlDVWVBUkQzSFlEem9pV0d6dzZ3?=
 =?utf-8?B?ZDkvaTJyUlhFMkZsNlM5L1dRQ1YyZlMxc0JuMG1sbndSamJuWW5tWlVxdnNI?=
 =?utf-8?B?R0JuZm1kMFRMRFVnWE5ZUHlxTWhWc0VkSWRXRVhtNnNveXdtaDVkcm5RZEdL?=
 =?utf-8?B?bHZiQVovU3AwY1VGZWhqejVwV0xLd1RwWDlDc3VBcjlIdEFBOVZ1UT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 695ac10b-324b-4f27-17c3-08deed877d39
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 15:38:51.1055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VG1FDB0zjKS7HY2K5w6rniawO7xQT4nn0LQc3EouyjdxL25q/ljuamBXnyZ4PACkNmJZhfuQxQ0USMAiFlhRRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB7156

The `__init` method is not designed to be a public API (existence of "__"
is a hint for this); replace users with `pin_init::ptr_[try_]init` which
does the same thing.

There are a few users of `__init` which are replaced as well.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/gpu/nova-core/gsp/cmdq.rs |  4 ++--
 rust/kernel/alloc/kbox.rs         |  8 ++++----
 rust/kernel/dma.rs                | 10 +++++-----
 rust/kernel/drm/device.rs         |  2 +-
 rust/kernel/drm/gpuvm/va.rs       |  2 +-
 rust/kernel/drm/gpuvm/vm_bo.rs    |  2 +-
 rust/kernel/init.rs               |  6 ++++--
 rust/kernel/pwm.rs                |  2 +-
 rust/kernel/sync/arc.rs           |  8 ++++----
 rust/kernel/types.rs              |  8 ++++----
 rust/macros/module.rs             |  2 +-
 11 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 070de0731e95..dbcd06a43350 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -645,8 +645,8 @@ fn send_single_command<M>(&mut self, bar: Bar0<'_>, command: M) -> Result
         // SAFETY: `msg_header` and `cmd` are valid references, and not touched if the initializer
         // fails.
         unsafe {
-            msg_element.__init(core::ptr::from_mut(dst.header))?;
-            command.init().__init(core::ptr::from_mut(cmd))?;
+            pin_init::ptr_try_init(core::ptr::from_mut(dst.header), msg_element)?;
+            pin_init::ptr_try_init(core::ptr::from_mut(cmd), command.init())?;
         }
 
         // Fill the variable-length payload, which may be empty.
diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index 35d1e015848d..c04c687b9ef3 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -372,13 +372,13 @@ pub fn pin_slice<Func, Item, E>(
             // - `ptr` is a valid pointer to uninitialized memory.
             // - `ptr` is not used if an error is returned.
             // - `ptr` won't be moved until it is dropped, i.e. it is pinned.
-            unsafe { init(i).__pinned_init(ptr)? };
+            unsafe { pin_init::ptr_try_init(ptr, init(i))? };
 
             // SAFETY:
             // - `i + 1 <= len`, hence we don't exceed the capacity, due to the call to
             //   `with_capacity()` above.
             // - The new value at index buffer.len() + 1 is the only element being added here, and
-            //   it has been initialized above by `init(i).__pinned_init(ptr)`.
+            //   it has been initialized above by `ptr_try_init(ptr, i)`.
             unsafe { buffer.inc_len(1) };
         }
 
@@ -463,7 +463,7 @@ fn write_init<E>(mut self, init: impl Init<T, E>) -> Result<Self::Initialized, E
         let slot = self.as_mut_ptr();
         // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
         // slot is valid.
-        unsafe { init.__init(slot)? };
+        unsafe { pin_init::ptr_try_init(slot, init)? };
         // SAFETY: All fields have been initialized.
         Ok(unsafe { Box::assume_init(self) })
     }
@@ -473,7 +473,7 @@ fn write_pin_init<E>(mut self, init: impl PinInit<T, E>) -> Result<Pin<Self::Ini
         let slot = self.as_mut_ptr();
         // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
         // slot is valid and will not be moved, because we pin it later.
-        unsafe { init.__pinned_init(slot)? };
+        unsafe { pin_init::ptr_try_init(slot, init)? };
         // SAFETY: All fields have been initialized.
         Ok(unsafe { Box::assume_init(self) }.into())
     }
diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 200def84fb69..21e4f7b03836 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -449,7 +449,7 @@ pub fn init_at<E>(&mut self, i: usize, init: impl Init<T, E>) -> Result
         // - `T: AsBytes + FromBytes` guarantees all bit patterns are valid, so partial writes on
         //   error cannot leave the element in an invalid state.
         // - The DMA address has not been exposed yet, so there is no concurrent device access.
-        unsafe { init.__init(ptr)? };
+        unsafe { pin_init::ptr_try_init(ptr, init)? };
 
         Ok(())
     }
@@ -791,10 +791,10 @@ pub fn init_with_attrs<E>(
 
         // SAFETY:
         // - `ptr` is valid, properly aligned, and points to exclusively owned memory.
-        // - If `__init` fails, `self` is dropped, which safely frees the underlying `Coherent`'s
-        //   DMA memory. `T: AsBytes + FromBytes` ensures there are no complex `Drop` requirements
-        //   we are bypassing.
-        unsafe { init.__init(ptr)? };
+        // - If `ptr_try_init` fails, `self` is dropped, which safely frees the underlying
+        //   `Coherent`'s DMA memory. `T: AsBytes + FromBytes` ensures there are no complex `Drop`
+        //   requirements we are bypassing.
+        unsafe { pin_init::ptr_try_init(ptr, init)? };
 
         Ok(dmem)
     }
diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index 477cf771fb10..290f0cd471ce 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -244,7 +244,7 @@ pub fn new(dev: &device::Device, data: impl PinInit<T::Data, Error>) -> Result<S
         // SAFETY:
         // - `raw_data` is a valid pointer to uninitialized memory.
         // - `raw_data` will not move until it is dropped.
-        unsafe { data.__pinned_init(raw_data) }.inspect_err(|_| {
+        unsafe { pin_init::ptr_try_init(raw_data, data) }.inspect_err(|_| {
             // SAFETY: `__drm_dev_alloc()` was successful, hence `drm_dev` must be valid and the
             // refcount must be non-zero.
             unsafe { bindings::drm_dev_put(drm_dev) };
diff --git a/rust/kernel/drm/gpuvm/va.rs b/rust/kernel/drm/gpuvm/va.rs
index 0b09fe44ab39..b61209090c32 100644
--- a/rust/kernel/drm/gpuvm/va.rs
+++ b/rust/kernel/drm/gpuvm/va.rs
@@ -116,7 +116,7 @@ pub fn new(flags: AllocFlags) -> Result<GpuVaAlloc<T>, AllocError> {
     pub(super) fn prepare(mut self, va_data: impl PinInit<T::VaData>) -> *mut bindings::drm_gpuva {
         let va_ptr = MaybeUninit::as_mut_ptr(&mut self.0);
         // SAFETY: The `data` field is pinned.
-        let Ok(()) = unsafe { va_data.__pinned_init(&raw mut (*va_ptr).data) };
+        unsafe { pin_init::ptr_init(&raw mut (*va_ptr).data, va_data) };
         KBox::into_raw(self.0).cast()
     }
 }
diff --git a/rust/kernel/drm/gpuvm/vm_bo.rs b/rust/kernel/drm/gpuvm/vm_bo.rs
index c064ac63897b..cb0662c71087 100644
--- a/rust/kernel/drm/gpuvm/vm_bo.rs
+++ b/rust/kernel/drm/gpuvm/vm_bo.rs
@@ -181,7 +181,7 @@ pub(super) fn new(
         };
         let ptr = NonNull::new(raw_ptr).ok_or(AllocError)?;
         // SAFETY: `ptr->data` is a valid pinned location.
-        let Ok(()) = unsafe { value.__pinned_init(&raw mut (*raw_ptr).data) };
+        unsafe { pin_init::ptr_init(&raw mut (*raw_ptr).data, value) };
         // INVARIANTS: We just created the vm_bo so it's absent from lists, and the data is valid
         // as we just initialized it.
         Ok(GpuVmBoAlloc(ptr))
diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 05a12e869a57..7d2c6bc5dd36 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -158,7 +158,9 @@ fn pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> error::Result<Self::Pi
     {
         // SAFETY: We delegate to `init` and only change the error type.
         let init = unsafe {
-            pin_init_from_closure(|slot| init.__pinned_init(slot).map_err(|e| Error::from(e)))
+            pin_init_from_closure(|slot| {
+                pin_init::ptr_try_init(slot, init).map_err(|e| Error::from(e))
+            })
         };
         Self::try_pin_init(init, flags)
     }
@@ -176,7 +178,7 @@ fn init<E>(init: impl Init<T, E>, flags: Flags) -> error::Result<Self>
     {
         // SAFETY: We delegate to `init` and only change the error type.
         let init = unsafe {
-            init_from_closure(|slot| init.__pinned_init(slot).map_err(|e| Error::from(e)))
+            init_from_closure(|slot| pin_init::ptr_try_init(slot, init).map_err(|e| Error::from(e)))
         };
         Self::try_init(init, flags)
     }
diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
index 6c9d667009ef..5affd88b0fe8 100644
--- a/rust/kernel/pwm.rs
+++ b/rust/kernel/pwm.rs
@@ -600,7 +600,7 @@ pub fn new<'a>(
         let drvdata_ptr = unsafe { bindings::pwmchip_get_drvdata(c_chip_ptr) };
 
         // SAFETY: We construct the `T` object in-place in the allocated private memory.
-        unsafe { data.__pinned_init(drvdata_ptr.cast()) }.inspect_err(|_| {
+        unsafe { pin_init::ptr_try_init(drvdata_ptr.cast(), data) }.inspect_err(|_| {
             // SAFETY: It is safe to call `pwmchip_put()` with a valid pointer obtained
             // from `pwmchip_alloc()`. We will not use pointer after this.
             unsafe { bindings::pwmchip_put(c_chip_ptr) }
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 5ac4961b7cd2..66af7035b824 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -717,7 +717,7 @@ fn write_init<E>(mut self, init: impl Init<T, E>) -> Result<Self::Initialized, E
         let slot = self.as_mut_ptr();
         // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
         // slot is valid.
-        unsafe { init.__init(slot)? };
+        unsafe { pin_init::ptr_try_init(slot, init)? };
         // SAFETY: All fields have been initialized.
         Ok(unsafe { self.assume_init() })
     }
@@ -727,7 +727,7 @@ fn write_pin_init<E>(mut self, init: impl PinInit<T, E>) -> Result<Pin<Self::Ini
         let slot = self.as_mut_ptr();
         // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
         // slot is valid and will not be moved, because we pin it later.
-        unsafe { init.__pinned_init(slot)? };
+        unsafe { pin_init::ptr_try_init(slot, init)? };
         // SAFETY: All fields have been initialized.
         Ok(unsafe { self.assume_init() }.into())
     }
@@ -795,7 +795,7 @@ pub unsafe fn assume_init(self) -> UniqueArc<T> {
     #[inline]
     pub fn init_with<E>(mut self, init: impl Init<T, E>) -> core::result::Result<UniqueArc<T>, E> {
         // SAFETY: The supplied pointer is valid for initialization.
-        match unsafe { init.__init(self.as_mut_ptr()) } {
+        match unsafe { pin_init::ptr_try_init(self.as_mut_ptr(), init) } {
             // SAFETY: Initialization completed successfully.
             Ok(()) => Ok(unsafe { self.assume_init() }),
             Err(err) => Err(err),
@@ -810,7 +810,7 @@ pub fn pin_init_with<E>(
     ) -> core::result::Result<Pin<UniqueArc<T>>, E> {
         // SAFETY: The supplied pointer is valid for initialization and we will later pin the value
         // to ensure it does not move.
-        match unsafe { init.__pinned_init(self.as_mut_ptr()) } {
+        match unsafe { pin_init::ptr_try_init(self.as_mut_ptr(), init) } {
             // SAFETY: Initialization completed successfully.
             Ok(()) => Ok(unsafe { self.assume_init() }.into()),
             Err(err) => Err(err),
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index ac316fd7b538..46497957d846 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -417,13 +417,13 @@ pub const fn cast_from(this: *const T) -> *const Self {
 
 impl<T> Wrapper<T> for Opaque<T> {
     /// Create an opaque pin-initializer from the given pin-initializer.
-    fn pin_init<E>(slot: impl PinInit<T, E>) -> impl PinInit<Self, E> {
-        Self::try_ffi_init(|ptr: *mut T| {
+    fn pin_init<E>(init: impl PinInit<T, E>) -> impl PinInit<Self, E> {
+        Self::try_ffi_init(|slot: *mut T| {
             // SAFETY:
-            //   - `ptr` is a valid pointer to uninitialized memory,
+            //   - `slot` is a valid pointer to uninitialized memory,
             //   - `slot` is not accessed on error,
             //   - `slot` is pinned in memory.
-            unsafe { PinInit::<T, E>::__pinned_init(slot, ptr) }
+            unsafe { pin_init::ptr_try_init(slot, init) }
         })
     }
 }
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 06c18e207508..1421109f6487 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -621,7 +621,7 @@ unsafe fn __init() -> ::kernel::ffi::c_int {
                     // SAFETY: No data race, since `__MOD` can only be accessed by this module
                     // and there only `__init` and `__exit` access it. These functions are only
                     // called once and `__exit` cannot be called before or during `__init`.
-                    match unsafe { initer.__pinned_init(__MOD.as_mut_ptr()) } {
+                    match unsafe { ::pin_init::ptr_try_init(__MOD.as_mut_ptr(), initer) } {
                         Ok(m) => 0,
                         Err(e) => e.to_errno(),
                     }

-- 
2.54.0

