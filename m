Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021102.outbound.protection.outlook.com [52.101.95.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3834455166;
	Wed, 29 Jul 2026 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339535; cv=fail; b=GoZ+K1ADHT5rEoZHwEgYNHvtQCd8c4J/eZVaK2SuOhjjXWqnNcr7Y99o3SbeHq3PDsD82ZySTkw/NmHnHnDpaTi+jMKF8YKcgi6UTn0nfI9AwPYoVRWEVR21D+J/NR6rn+1rhP6p/TMfBEOuWFlKM3KwwezFomKSiQIBaXWcL8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339535; c=relaxed/simple;
	bh=tP3Sp/IlJIQBEZJsLm7lObRnOMULMVjEuoKDDAjMt5w=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=nwTeKps73l+oDOXmxBAMeciCzl5S7bOwNVQhyFJJVXwNAeeHEO/CUalDWqY/gZA/k6n45nt5g0baOn7rcVRuIGMTukxTKnNWASLleBaUaldrrOi80CHK68zEjfaMC9Zo8uK4evky1Y11nR88GsQHjWa+lLIxr7oUCkUtz/a6RNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=wAhkJdD2; arc=fail smtp.client-ip=52.101.95.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="wAhkJdD2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMXuCenosoQfJyXqfP/3SzSwRYSKKXMTJWlxumXcY8hmX5XgVKzRxSo3eJxW1zlu/C2USMvrdsjCqWFMyqgbNJEjyJQTsOWixzAFbmWJBP716P8w77TrdIsREDr5rTgfGybTnV3svmndVkuWnXaDC/lE2JUTgXuvTeqJ48lBwDaREC4E1zESYdA1Av3AJhWzLxOFu5IdiaGFhIV4nNzrfOfY5nginmT1VLWOjxWhlKOwMgaGUyx3bxlEHeoxzAJ9TBjjLmHH0Oa0mJKfd7nVFAEngGSMMTBSNylyJpdHTFW/M55o1OI77zyna62sl63zd8TJiGZbe8jgg65jBjsnFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRwoiQc/4HKBPn9bGC4mulvA7QkP6MRRF7To1lu0x8w=;
 b=O5+G7EoyIsoxX9/u1yAE9XWq/2spguPGCd9SnbbiDT8rvE+isD9aEMHWEylJGqJ2EHlK+fgFFcv6M6tkV7NwvzNeVk+FOXgZRfPykA2/ZaKy63Yzb1xjT7eqdyddmgKkV3qzJ369Ze9hVTp4YxD8z0OjZp04OG8b3l4eLD1YUWi2m71LYzbYqHld/PJ4ocMElxBKkBhGHSvHXyv6bEO/Fx39bRwxW/g4Wyw6w3576xILG3d6VtvPcEc/N9ZhCrJzjFYP06UEmbR/lj4ob993y0cBWpPvLJtHucNUATM8pFdMoz8mi+Iw9lXkOtqc8SxAPo40XOMRBHrsUuEUJUxJ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRwoiQc/4HKBPn9bGC4mulvA7QkP6MRRF7To1lu0x8w=;
 b=wAhkJdD2ElbcZ20mGZVawAdocUIJc2z4d0ofEzdHDTF7nN/l/vuPNdUp993bhroFI2Pk6HGmtewPb1BQufPnNM2LvXfP8BhuM005WPDE+JjrUaV9wpZQqQPWQ9YhEDgbFB8x89e9E5wwEO+DrYbk4Hhg1glmKHzQBR/2vZDTbbY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB7156.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:31d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 15:38:49 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%2]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 15:38:49 +0000
From: Gary Guo <gary@garyguo.net>
Subject: [PATCH v2 0/5] rust: pin-init: merge `__init` and `__pinned_init`
Date: Wed, 29 Jul 2026 16:38:42 +0100
Message-Id: <20260729-merge-init-v2-0-26adf47109e7@garyguo.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIIeamoC/22Oyw6CMBBFf4V0bRXKs678D8OitAOMkWKmhUAI/
 y7Frctzc++Z2ZgDQnDsHm2MYEaHoz1AXCKme2U74GgOZiIWRVwKwQegEFr0PAUjqzyRoMuWHYM
 PQYvLKXvWP3ZT8wLtgyE0GuWAN6Ss7kP0Rjst3MLib4NyHih0enR+pPX8aE6C6+/xOeExN1kuM
 wNlkafVo1O0dtN4teBZve/7F52NoXLcAAAA
X-Change-ID: 20260722-merge-init-3ed98519ec7f
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785339529; l=2552;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=tP3Sp/IlJIQBEZJsLm7lObRnOMULMVjEuoKDDAjMt5w=;
 b=HZDM0J7MvhkX4NRp9IX/v1e86u8tCAafpgVGEaPGatBCAddIQviq2Mt0uQh/sJA7j9oPg/iye
 ayzi5NW9kX1D/KLuxr9u7u/KLbEjJ/HLUZjwfbsQD3qy2zERGjUDmMq
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
X-MS-Office365-Filtering-Correlation-Id: 27222468-5131-4ef2-2f26-08deed877c59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|376014|23010399003|18002099003|56012099006|6133799003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	ZM30HnYbbZskxP/ZZGZvzanLlHnfWOMJfFcpdm/PpHphLV7odjko0/sb3/SAwDuz4YDEFwt0k17o1I68hiCGWJ/U8FbeLXCvIg/JbCqc+IRql4dH0yFsWBQ6SbQqQ9vLTLt32vDp8fkU+RRRQtlML36BSx8uzU6Gc06d/ZclhEyVmFla7DadCeBwjPDgl5+RNqy9YTCZJKXo8Xnta0XlShrfeHYP2O+YAO/dWcpmPLcphGNF0dWX2ZkmXL6lEQvNMk987KIn0G8uDYVLXm382an/+DYfTE/7kvJVxcQjeFk2bRivMeZpnqohq81CSAdpP4+IN95gmYPXTGUVSGMwchFpsoa8i8sGUR05J99VkUa9o6QEAumfOuaf4jYzGHkapFpUgqI4FiS9TZB/dfrdAiuT3Rp3QRzqcyYQl59G/h070XXza+XsGhk6hL6XeWUigxbGxh4xKR8D+vFf6c9y78w6Y46QDoEqp9XDDmWi2atljGz5u+u5WObE1COacXT+QPt01J0Zp7u+IwkU6TOlPbIVGq3dc7VrakL9YKjg7M9hmOvfLVjMj509GlovhMQ1TRLTKZ2GVjxqPgAqFRdGhU7OqOYusf5s8OejY2uZEQ7jF5+iHo1A8um3SWFyD408vxCUGf1eUbPYn6iXgezJSdA53B2tCGmx3WHqLwmKIJs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(23010399003)(18002099003)(56012099006)(6133799003)(10067099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXpLNzZHc3lYTDFxUnoyQkVjV3JHOFRDMDBBSTlKcTRmZmh2cEp5Z2l6Qmp4?=
 =?utf-8?B?enVOZ09Ya2laOWFleFd1ZVBHQmlpNldsbCs1ZzVMdHhld0ZrQ2pyNTY0SjBi?=
 =?utf-8?B?RFFHdjVRQTVPd2krQlRLL2dFWXNlT29wajZNVmgwTEZSWVo5UlRFY0ZLTzkz?=
 =?utf-8?B?RlYwY2FpYzFPZ2hxZXlRUnp4QS9sWnAyaVpUcy94UHdJZ20zNWhCTmdFTlQ4?=
 =?utf-8?B?QUVsYVlTWWdaYllXV2x2bU85d1R2NnE5d2JIYlBhYmtNUjNwZG04bnJFZTVP?=
 =?utf-8?B?OTVhcWpISGhEOW9udmtsL1VTL09lWVlwdlBYVG5SQXRvMm5nRmNLOFhubG4x?=
 =?utf-8?B?OHdjVHBPV1JmVXFSb1EvbG9XN3BtRWxtcWp4SXo3Zy9rOVMvZlBhdzFJQXdU?=
 =?utf-8?B?YlBjaUNkbDBmQTk1UUE4cHRSSHBYYVl3K2pUQUNaTFVzdmpVTFpPazF4eWFN?=
 =?utf-8?B?YzM1MFBOVXBSY2JWVUpWcXdsMUxINCtob3hHY3lqWWxXdEd4WFpaUUFCZTNx?=
 =?utf-8?B?aXVheDZzZEF2UDdSRkhBdHJaSzhjMDZ6eTAwc3FQUG1Yb2VYVnJsZFVWTlRW?=
 =?utf-8?B?bzRsd08remUraEtpbWpPQVBwcnRpRm1BM05TVjhiTk1BakNFS1A4QlhMRFZ0?=
 =?utf-8?B?RHVzM2QxTVJ3eHFVeVhDUml0OXJWSXRuQVU5ODY5bW5XN1AyaDROaGIrcjhj?=
 =?utf-8?B?Z1luRFhGZ3pjY2VsS0pRcnA0VkVhNVhpM3Bza2RGQ2JwQll3YjdXTXRkMkJ6?=
 =?utf-8?B?eTZlUndDREt3eXdaWHAvMHlKdnZNbkcxZ005QnQzdVNCMlNZUjRmMUNLbG5z?=
 =?utf-8?B?RU1tL1UyVXVHRVZVdWZMVjNjMFhqNlFSdVljQklyVkNkSFJ6SStmVmt4M1pp?=
 =?utf-8?B?ZWQzQ0szMnloTmdwTXlCbmlxVlVseXhpYU9CM2p2YnF3NFhERmNmcElBLzhU?=
 =?utf-8?B?QlJ6cWo2Tkxzcmc4R2UzZlYvV2kxMzZqdjJCekZIUnlWelVNUVh0dVVSODJN?=
 =?utf-8?B?dWk0b0cxSExkdFllQUlicmZrUjIwNW1QaFNIakNHcGlRTm9yRVhZZk9nQW01?=
 =?utf-8?B?N1h5MnRWV1kySENXMFRRQklmdlV2ZU5JMFZtclZPSXdPdmx0ekZCRmVrcWdu?=
 =?utf-8?B?VHdkcE5HRlVJVk1uZWtHb1ROcUdlNFNpaCtWYjhST25TUGRkWjZIRkVMeU1U?=
 =?utf-8?B?ZFppWmt0QW1FZjV2QWd3WGV2aDYxM2Z4NytKWW02cWpGaWJuOWJDOUhmb3Zo?=
 =?utf-8?B?RlloNjdIcFBYMTZ3N3ErUDBQWVhuUHg5SEduMVRJRElxdnpWbGdlWVlGRGtL?=
 =?utf-8?B?bkVQQjcvaGdTTnhmQ0NtcTRKRkRlM21MdkZlQUdiQXlYV2xRY09xUlhPeTNz?=
 =?utf-8?B?cnZhblVzZzEvUVpOaStyVW1vSFc1UmpkQWNwWTNDWnc2QjJkR3ZmK1RZWGlY?=
 =?utf-8?B?ZWV1VStoWk4yR3FDVlFVbTBrNGZnYmVqc2g4Rlg3ZE1DbDlBQnRVU3l5M1dj?=
 =?utf-8?B?Y2N5RFlzMFRGdzF0QnQvTWkvVzk4SVlQMkc4SUVRVTVuc2szM0k2WVExd2FD?=
 =?utf-8?B?R2ZHQ09hNGYrOVN4MDdQYXB1R0RIQlNmZXFUbktCVXhXWWZlbWlNaXVZKzUr?=
 =?utf-8?B?MGNQL0kySDlCQ0pKTGhsNHJDNmpNalNtQk1TbTc5VGFIdDUxMEhMN3p2YW1W?=
 =?utf-8?B?Z3VJZEVkVmpSTEtiYndkdWVpN1g3b0hvdGxRenk4WnpXVmFmd1NtbFJGUE5i?=
 =?utf-8?B?ZEM3Wk9ubERYWU9mMzhkM1pBT1V4VlZVLy9LenhVcUZFWndocG1qTi9kRmlM?=
 =?utf-8?B?bWdLMnY5Mzd5NUtiR3VlK3pDQ2VLamRpUFk5YXM3c0Rvbk90SzB5RDhlc3Zn?=
 =?utf-8?B?d0Q5TU0rWURYZUUzKzhJbFltN1BZSEFWSlU5ZE9GMUtwWVYvT1JSdng3eE44?=
 =?utf-8?B?TUFtSW40TW0zR0g3bVd4S21QdzM5M0lnNEdOb3BlMnJ4c1cvR1k5RERJc2lw?=
 =?utf-8?B?bEI5aE5IYmpNNUhVb2ZoRjA3RlRES1p0aitzS0R6YjhiaHdvWTYxWEtxUTBO?=
 =?utf-8?B?aG1Ybk1FLzZUY3E2SnJaTFhKdGYrMVlaaFlYdXpwN3M0REZHYUlSTHp4c25J?=
 =?utf-8?B?T01mbFJhR1FlL1R5eHcrUDQ4ZHZRNnBsRWZoRmVJczU0MGpTZFBkL2lIYnNk?=
 =?utf-8?B?dGZlN2ZZcnRIaGdqQjg4L1ZLVDZVVk5PeXlITVJUY0QwQldkNnV5UWxmeWlT?=
 =?utf-8?B?eHZ3YUFxd3JJT1I0NkxFRGpGRkdiTWxpdkxQQ21WaVI4SWJWVldydEF1SVB4?=
 =?utf-8?B?NkFTcW1DWmRWR2lUeEloNXFjdERJbVpVc0VETWxMQnNieEhCaVFhZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 27222468-5131-4ef2-2f26-08deed877c59
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 15:38:49.6638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +B5Iwd6lwrKHoJ1nVn47C236KnD6ENew7gafVUyj/FmtBPRLlPfft8nqdqHzvSeX7uDFLk4xuABkUYSEqezHaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB7156

Currently we have `PinInit::__pinned_init` and `Init::__init` which has
slightly different safety requirement but are required to do the same
thing. Instead of having to duplicate impl everywhere, it's simpler to just
use `Init` as a marker trait that cancels out the pinning requirement on
`PinInit::__pinned_init`. This also simplifies code (and shorten the symbol
name) so `__init` can always be used.

However, there are multiple users currently using `__pinned_init`. This is
not designed to be public API; however `pin_init` failed to provide a
public API alternative so it is still being used. Add `ptr_init` and
`ptr_try_init` methods and convert users to use them instead. `__init`
users can use these as well due to the super-trait relationship.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
Changes in v2:
- Add a public API for `__init` and convert users.
- Remove the part about multiple cycles. Danilo suggests me to take the
  entirety in single cycle as this doesn't conflict with other branches.
- Link to v1: https://patch.msgid.link/20260722-merge-init-v1-0-d4594de76538@garyguo.net

---
Gary Guo (5):
      rust: pin-init: examples: use `Wrapper::pin_init` instead of manual reimplementation
      rust: pin-init: merge `__pinned_init` and `__init`
      rust: pin-init: add `ptr_init` and `ptr_try_init` and recommend over `__init`
      rust: treewide: replace `__pinned_init` with `ptr_[try_]init`
      rust: pin-init: remove `__pinned_init` method for `cfg(kernel)`

 drivers/gpu/nova-core/gsp/cmdq.rs     |   4 +-
 rust/kernel/alloc/kbox.rs             |   8 +-
 rust/kernel/dma.rs                    |  10 +-
 rust/kernel/drm/device.rs             |   2 +-
 rust/kernel/drm/gpuvm/va.rs           |   2 +-
 rust/kernel/drm/gpuvm/vm_bo.rs        |   2 +-
 rust/kernel/init.rs                   |   6 +-
 rust/kernel/pwm.rs                    |   2 +-
 rust/kernel/sync/arc.rs               |   8 +-
 rust/kernel/types.rs                  |   8 +-
 rust/macros/module.rs                 |   2 +-
 rust/pin-init/examples/mutex.rs       |   6 +-
 rust/pin-init/examples/static_init.rs |  10 +-
 rust/pin-init/src/__internal.rs       |   8 +-
 rust/pin-init/src/alloc.rs            |   6 +-
 rust/pin-init/src/lib.rs              | 177 +++++++++++++++++-----------------
 16 files changed, 128 insertions(+), 133 deletions(-)
---
base-commit: 6d0795b507fb1db2e6aefe533d949db3a4abf4c6
change-id: 20260722-merge-init-3ed98519ec7f

Best regards,
--  
Gary Guo <gary@garyguo.net>

