Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021084.outbound.protection.outlook.com [52.101.100.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEB63AAF5C;
	Wed, 29 Jul 2026 15:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339543; cv=fail; b=ouNtsKtbukeDijS5fNjNxXjD8cBT4ts8VgNu7TGSXXk7v1CdsiEGARNUjTl20UEJFPuHplzes7cemHavUSq3pr9mEnPwIWvOzkXa1whao62bhyRAAkTt8l+GHJf3gOvdqmeeCPtH2P8ipHtfSfbtSxo2aC2E08gfePRCKkcz4c8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339543; c=relaxed/simple;
	bh=9QZwCl8ntNV/87PfNLRxepcne4jqatcn4iSr48gqvbY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=kCfBxneyzTGwJPqmcj8DMkIPh4eRdEFQn9lPd+qIH45lDHBwZ/X2Xs7xD7yxyfGYAlVu/naNIgY43jhQXQv4xdT6OegIiMRWbNJe2PFG9k0Z/Rw+yg3F6NwZyVlqxtQUKQZSmUmLaedzxzJiTfYY/3O3Za08AxHw8S9fh46U1Ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=cBl+Z7FL; arc=fail smtp.client-ip=52.101.100.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="cBl+Z7FL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=axvlFavqVfHWvDANZAhKShBnv5lf8ih/O3Hij6CRjzdnIGnthKfF70xL+HIrH5iD5IbV6TtlJMKCqrlo2o/K+1Kde2SDC9tS9rjpX5q4VVPeTc7mLIvgAbAQ1qX9dn0gtpLVywhNO2gvmPyeF+JUXtgZwhgVADFPLevUUjRS9laW+ftTieFnqx2/YSlrQztfrd6nQj3tMLBRPGSgh6utysV46Y/NANYBt9JNUgDaN7dTD3aVUoHcXkEcpzVjjENbU9fMpC82HEJhPeATVdau/wlSXA6etegWdPEXEKd2CVuAm9Y+r4H6Ct9YJQDfyiW0FtPD0X8WXPc1NVzKSKpLZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8Vx6XgrSuMsl8C3R1k2ToTdC7o+9nGeRS/aNSzJi1I=;
 b=w0Jfly9Kf8g3ZIlqZmYfdV1TuzqzsbOKmpLoXndVxq2Z+Bo+NRKWEDKXPawOo8Z3pNQfGY/FdkSPE73yRMs/2KGaz2pFLI8kK51dAE7C36TIWB01PCS0xPkGxUU3kB++gjRnHnUwiNQjtgCLKSP0UjcJYhH/Matigb5k95ZSK2wUsyTCCXHz+tJD/nrBA3xx6NcdiOHMqzTc+tKMs636ZYpAh7+OytpfGtUy+Nazdggg5SN56rDF5vdzi4bM3SMjH0tjtNa3MF1X27qGH0onYejD/XTU8ocAf4vLKmu6q/twvGmYp4aDwMMTKBaEx4Cu1s10mUbFk8nOwGpckSB22Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8Vx6XgrSuMsl8C3R1k2ToTdC7o+9nGeRS/aNSzJi1I=;
 b=cBl+Z7FLd9O5WuzK86CY+HkzofvFF6kbJLY8elhJuj1yVhnyHUUkkj342QjOHumjCCrXFSxaH/aKZOLqVEDJC3B+QcTO+xxbvWn/7T+HInlPKV+wYdLyKa1KwQQWClWqCr9uHtjdDer1U6yZQN35TNNDc+KZkOLX0A7XPP31hiM=
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
 15:38:51 +0000
From: Gary Guo <gary@garyguo.net>
Date: Wed, 29 Jul 2026 16:38:45 +0100
Subject: [PATCH v2 3/5] rust: pin-init: add `ptr_init` and `ptr_try_init`
 and recommend over `__init`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-merge-init-v2-3-26adf47109e7@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785339529; l=3908;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=9QZwCl8ntNV/87PfNLRxepcne4jqatcn4iSr48gqvbY=;
 b=7+ZVEXKpBDz/J+X+gOOpKMon60tBLRj5pgNlEFh4757aKUnIFS3ht+8mfFkdgkaEaWqorXhMm
 XclGyl3IFeMBVcpHnJTVLtaFWRvEA2U87kiZAkIvGehtJEOTT4TPCaC
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
X-MS-Office365-Filtering-Correlation-Id: 886cb844-2ddd-4fd7-f625-08deed877d02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|376014|23010399003|18002099003|22082099003|56012099006|6133799003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	+f417LilsoKo5TjKYxQLrLO6rtlrAee//KiibGCJVkXwjvadcnyBP0onwLbIuayi2q/gMaSbQaJ5nWbkI1SVosHCq5tlnbGTI0Vmh5RDvKw1GD2xd2UhT8+0MVeHq5W2M0M1+j1fHQ7gAzQH83UmgamLNMm7P/lgIfT9FxgvEIw+wNbegHj7XFLD5DBqmHrV0H2JJzvfb91kchMnmZHNxOo1b0s0AfebkFch9UU9gi5uG/w4oZDvxGjITozkxVf7kTZPaa4C31Ymq6bMNI8zHMXFKJGcDfg3ezKTGAl80jxIoGoluTP5w4zZwd5NQkk8NV0PaB1B+LvJvrzXarq7ZU68yYREl+J51MLcNfyx6hRwCD+Gt8J+3yZFCOR3ZPbtbbbKms4XnodbvtDr6sT2RZ75xOY1jdjTLpF7QsA4l/aZzkGrShgOsUFjqM0pUHbfH566PmU/ba2pvde1OLYsX9IgOYLQNrHZWWlUehKCdZaKDQAHEacaadI1LadAEEXxJlHy02+ifXscBdUWegzAvTIB09JF7l5GYcHJ9gRqSOefcKH6hBwz7iABPPBB19845FeETMyNn6LGiCJa+TycAyhF2Ct6C+GZZ4qRHZ3C34nySkEeUhi9YkC+B8TWpcMDRTUIKdqA5yA9ob5qZAxQ191JdfWJA4Av536BCDSq1VUfizsZMfu58D4YdHaQuVsX7Xz9NKup1KQsq7Wp2gZH2w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(6133799003)(10067099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFBvaGxHZURNUVFReW1Fb3E3UFF3K09HSzN3N3ovdEp4TWxpMHU5aVQrc0xn?=
 =?utf-8?B?S094QTRVYjJwY2F3cVlxRndKSFl3QldPbFloOU5Oc0VtL2ZMdVBKSXhJS0FI?=
 =?utf-8?B?clBnYW5nK1NxQnI5VGtFaERWSzg2OTFQTzdRZzFqS1h6Y2FJS2Y1cURDTm96?=
 =?utf-8?B?aDlBZ3d6K0VFdnFJM1J2NkZka2s2THZjTit6R1ZmODZHR3kvRGRWbHNaVWt0?=
 =?utf-8?B?dHBJdklJSDhsblFjaXZEZDViNUQ3a29qd2toTnZCRms4SkFNdG50MzFxM0Z2?=
 =?utf-8?B?TzVORVZKcnEybWpzRm83VzF6UWdtczgyL2RJS1dLeTViM2xTbmNEbGZrVGVh?=
 =?utf-8?B?aE5ZeHB2TTdzc3Rjdy85RUtNZnptdUdQUDJtR1VQTDNzQ1lkazk5VW5QMnU0?=
 =?utf-8?B?TWp5MVk0VGZLRHUwK2JubXl0aWFLL2QxOHBLN3RDdWdVTTZZVEZ6Y2JvY05y?=
 =?utf-8?B?djV0R0NDd3pVQStNR1pjMEMzdUhmQnVaTEN2Y2tMekd0Z3duLzB5Q2kxWHIw?=
 =?utf-8?B?U2xiMXdEVFY2TnhrM2JrZGcvN2JNSG5hVFd6b3lxakoyVTZkR0VNQlYvUDJT?=
 =?utf-8?B?MmFIRWRMS2lPV1hKc3VoN2l3T0U4VXZRRDVlRzFmbUhqL3lPYS9XVmxJU2pK?=
 =?utf-8?B?L1piOXFWb0NzM0dLRXMvbUgvNm1ESHB5V29GT1FBbllhMVlrYTViU3I3a3ly?=
 =?utf-8?B?SEF4cW9INTd2RmhhRW5IcHlFUU9OVk9ibk1ucDlaZi9scXFobDNxcy8yM2ti?=
 =?utf-8?B?TzFnbjdQM3FzMVF6aEszU2JMOGxPak1vN0p1OTNLV0RHWkFlalBIZ0NDblEv?=
 =?utf-8?B?WitxSTFBRThMd0huaW1FLyt2TlhJcW1wY3Y3Vy9tZVU2WWNHTHNISXk0UTlH?=
 =?utf-8?B?V1orV3BRSjArNW9HbnBVZERJR1cxYkQ3S3daeCsrZ0JwUDJNUk9IREEyaUpm?=
 =?utf-8?B?cDlSUjlKU1VZZDFTNUdtaHZxUzZNWDFlRHlBRmJqRFBTWEtXbzg3WHpPN1Jh?=
 =?utf-8?B?Y2hYaElBekJUbmliVHBuKzU4NGtCOHQ3WXNCOG41Y21BdkpRRW9TQ3MwTlRR?=
 =?utf-8?B?cHg4VjV6VWN3NWdFMVRmaVpFN2JqejRJWmVTVVE3dklGbW4rcGg0a0xFREZa?=
 =?utf-8?B?bWJqTXRDVmVnMnFyV0dQZnVFN0kvNHVUdjF0RXNvdDM0d2wwNk0xOTAyREdo?=
 =?utf-8?B?Y3d3SWRZSzMwSEhzdXlQZlV5bXJwSzNJUm9tUzlkYTIyWjBsbnExdzBJL2F5?=
 =?utf-8?B?NXdQYTFmZHlsQXhxSWNBb0R3OTUyNFh4QWJDT1hteWxHWi9NandxdHVid2JT?=
 =?utf-8?B?RkV4UysxdXlUb3pXT2Y1c3BWZjNIMDNWOE5qVmk5bkJOT3puNUFJMDM3T1U5?=
 =?utf-8?B?Y3ZpLzdVb3ZJU21IdlQwRkFRSzZJZG9NSGdKeVkzZDAxSnVBb1J1THVjZnhO?=
 =?utf-8?B?VkEvYVRISVVkV1VGQkdVenNMb2FlT3pzUENGY3liSE9FamtQS0hZanJkaVd3?=
 =?utf-8?B?ZGN2dmVxdEZBenllVkVKemQydEFrYWt2WVVlYzFRQW44cnJyNllmRmpacklK?=
 =?utf-8?B?L1F3UC9PNVgrYkJCZGVRK05MbEpuZ0pyUy85bkljWGowZCtXeDFwTWh4cDE2?=
 =?utf-8?B?OTRzQkZpbVExSFhVN1lUMU95enpidFl1dTRvcjZ4T2MwTHoxb2NKbGxpelp5?=
 =?utf-8?B?MDlvMjZrZXpSak5vbmZENEhWZ2x0cm5zTzJYdERKemFxdW9vYzAwSXNIQjJh?=
 =?utf-8?B?Ky9zVXFmbnhDTGNBSzBIbFZuOUVUMktWYXFGQWkrRnM2RTltRFpTYUpCaDdM?=
 =?utf-8?B?Unl2NVlhZHhyQkxNbm9LSjFiajJ1d3A2KzZlQUNaZlExVS92eDAxNVRMY21M?=
 =?utf-8?B?cHRBTHlGTWFiRVkxWmVIdklIQXpHZVVCY0hyNkhndTJVRzVDeUlNSWNwYjJa?=
 =?utf-8?B?aDR6VFdxd1ZmdURWNThIVkNROFBMMFRYSEdQeldMOWhVZ1JmWHQ4WE9HOXhW?=
 =?utf-8?B?Ujd6dlN3djAwVk5ld2ZKWGI2bFU4eHRLQlFTUkUrN1JNVjBvcjlsKzV1Z2Zn?=
 =?utf-8?B?MnpvdFJ0WTRNNmFFNENNYWtUWWp5Vk8ycEJHVTJ6ci9Eelp0NHNCSXBmY1dh?=
 =?utf-8?B?a1RJN09WUXV5SVc3eDBlZTJnVDJzRWJKUmw5VTk2dTJEOU0wbE9vRG5SemVt?=
 =?utf-8?B?SkpTR3JKdGtxVU5aWHhTNVlzMnVRT3dqRkx5YSszbHJubWtZN0ozN1IyUXpq?=
 =?utf-8?B?UHY2ajh2VWNsUy9IU1BFcW9EQzlpZ0F4UFA0dHcxTXVPM0ZDNkZDYkkyL2Vt?=
 =?utf-8?B?REUvZ3lEbVp0cGEwcWhSUWJ2UXdXZDh2UXg2eDcxUnZWOUM5S2pVZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 886cb844-2ddd-4fd7-f625-08deed877d02
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 15:38:50.7564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DDTyFQGnfe6oNBEXuUAEeUtAIgJO2STCyNzud5ELSAn6sPKpg15izQiCx5ZRE13u7/fAK7ARXNfQWIlIpWPsug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB7156

The `__init` method is not designed to be a public API (existence of "__"
is a hint for this); but currently there is no other API that allows raw
initialization on pointers. Add `ptr_init` and `ptr_try_init` and recommend
people to use this instead if raw pointer initialization is needed.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/pin-init/examples/static_init.rs |  5 +++--
 rust/pin-init/src/lib.rs              | 32 +++++++++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/rust/pin-init/examples/static_init.rs b/rust/pin-init/examples/static_init.rs
index 8e71556ffe85..109cceea2eab 100644
--- a/rust/pin-init/examples/static_init.rs
+++ b/rust/pin-init/examples/static_init.rs
@@ -59,7 +59,7 @@ fn deref(&self) -> &Self::Target {
             println!("doing init");
             let ptr = self.cell.get().cast::<T>();
             match self.init.take() {
-                Some(f) => unsafe { f.__init(ptr).unwrap() },
+                Some(f) => unsafe { pin_init::ptr_init(ptr, f) },
                 None => unsafe { core::hint::unreachable_unchecked() },
             }
             self.present.set(true);
@@ -74,7 +74,8 @@ unsafe impl PinInit<CMutex<usize>> for CountInit {
     unsafe fn __init(self, slot: *mut CMutex<usize>) -> Result<(), core::convert::Infallible> {
         let init = CMutex::new(0);
         std::thread::sleep(std::time::Duration::from_millis(1000));
-        unsafe { init.__init(slot) }
+        unsafe { pin_init::ptr_init(slot, init) };
+        Ok(())
     }
 }
 
diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
index fde53473763f..78a67ef54f4e 100644
--- a/rust/pin-init/src/lib.rs
+++ b/rust/pin-init/src/lib.rs
@@ -917,7 +917,7 @@ pub unsafe trait PinInit<T: ?Sized, E = Infallible>: Sized {
     ///
     /// Same as `__init`.
     #[inline(always)]
-    #[cfg_attr(not(kernel), deprecated = "use `__init` instead")]
+    #[cfg_attr(not(kernel), deprecated = "use `ptr_try_init` instead")]
     unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
         // SAFETY: Per safety requirement.
         unsafe { self.__init(slot) }
@@ -925,6 +925,8 @@ unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
 
     /// Initializes `slot`.
     ///
+    /// It is not recommended to call this directly. Use [`ptr_init`] or [`ptr_try_init`].
+    ///
     /// # Safety
     ///
     /// - `slot` is a valid pointer to uninitialized memory.
@@ -960,6 +962,34 @@ fn pin_chain<F>(self, f: F) -> ChainPinInit<Self, F, T, E>
     }
 }
 
+/// Initializes `slot` with an initializer.
+///
+/// # Safety
+///
+/// - `slot` is a valid pointer to uninitialized memory.
+/// - `slot` will not move until it is dropped, i.e. it will be pinned.
+///   If `init` implements `Init<T, E>`, this requirement is cancelled and it may be moved.
+#[inline(always)]
+pub unsafe fn ptr_init<T>(slot: *mut T, init: impl PinInit<T>) {
+    // SAFETY: Per safety requirement.
+    unsafe { init.__init(slot).unwrap_or_else(|e| match e {}) }
+}
+
+/// Fallibly initializes `slot` with an initializer.
+///
+/// # Safety
+///
+/// - `slot` is a valid pointer to uninitialized memory.
+/// - the caller does not touch `slot` when `Err` is returned, they are only permitted to
+///   deallocate.
+/// - `slot` will not move until it is dropped, i.e. it will be pinned.
+///   If `init` implements `Init<T, E>`, this requirement is cancelled and it may be moved.
+#[inline(always)]
+pub unsafe fn ptr_try_init<T, E>(slot: *mut T, init: impl PinInit<T, E>) -> Result<(), E> {
+    // SAFETY: Per safety requirement.
+    unsafe { init.__init(slot) }
+}
+
 /// An initializer returned by [`PinInit::pin_chain`].
 pub struct ChainPinInit<I, F, T: ?Sized, E>(I, F, __internal::PhantomInvariant<(E, T)>);
 

-- 
2.54.0

