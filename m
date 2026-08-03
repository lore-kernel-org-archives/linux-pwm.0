Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020086.outbound.protection.outlook.com [52.101.195.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B427410D06;
	Mon,  3 Aug 2026 13:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785765300; cv=fail; b=bbhLj7wqBw9EIlrf1oo0YQ1XhKkmRlYKtIELRYjgk5dQznx6dr/bv/NOkUXIwzTG5W1WGcsL3uemQDVi60JLha0jJTh3UKjvEuhDkNZEcTnQCuD9nvdmyvit8/W6n1CEU1GuasjeADTB9u2AHUPupi1dolD73AL2PlobDdfqNHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785765300; c=relaxed/simple;
	bh=dyarmhl8KFniJZmMaDXHw39JHFAB+Vcg5bXn6VpLPSc=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=QKELbLA7UGOfr+ZYUNafvE3pl0BXt4bUPgETtOQUE9jPggzlKWeQJbRdquEfyJPtW17R7F9xHg0yVAIE7LaLIm6EXGHcPwdDhJWCULfheI8RKKug7qcPbNYzM/5cb3icLufj71dM10JvK8QBcq+uH2CI8yc+6+dNKbHyQJoXWqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=IHarCYDI; arc=fail smtp.client-ip=52.101.195.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="IHarCYDI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qCI17pF54Vzi8K3EAtRWdew5CO++jUWhoqqYggPUd3iLRYFMzmZ7xaC2+YvWz6D9UXVnYZZKr6kzn7McCkxxG5icpt2ACcjeCIKa+UOk+cnKUHjZrtYoqyxnMY8LQfOpJQwwwS7Hcd5uWx1RYD6ltCB1dFcObWLaCf30TrcyyeVCcoXAv2bFFOzcYKXNzy8GtOg5RlGa4k/5z4D9lGfXTJCgtNn686l/05yfzAu7TljkFhuWwEW/fckeEFZq/cD98GgbPNjXGDi3E710Rz1B2Y/UDasL75Xvrssphvw/jy/CLt7RJ2xfajj17nzffw42P2u92r0bBVtCM/1oO0ilog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mc2EDHYU0Jjjs4no8M3qmIKrYhjlYefpBk1c8jgFF+Q=;
 b=sMojqDRFp2xaGvcyYfEqzS/M5qBTRMkfWctYlhnsOYoql1x7F1skjZC53z0CPYvm39IecNzP8KijiaiL+J0iI5/IbTyxi17cqzjptcHjYpVLc0GgSgtph+VM7lTqYoBSlWXbe4qYQ6qX816lxg4ABFmQpmIwY9RTysKwmmVgQtPux7k+jL53xZXE396FwgobUiz5WZ8gfQ6AUm86XI1oH6Px2PWOUfOOR1+oDpQGblp4aWWxyYqT9SuwCbPb9ablro6CMoiSECe4GmgfcL+c7fGnvgR5ohJdeF2bG2WueSa9qdbQB7uCquhjAeshoN9+tdLYIT2C0HUNBWbrDON+xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mc2EDHYU0Jjjs4no8M3qmIKrYhjlYefpBk1c8jgFF+Q=;
 b=IHarCYDIoJrB7xXL0i78PYMgnzwjRU/32JmeL2L6sx0tOGTpU/eiUNbOLVrAEa5UvHzlCToZdL/vZ2tF7L5FSV3wEmyu04XeBFi3LizGfMTBK7czDH47F4083DhiVpzoJX30acakF6uOpObaxuqetGvHtTTxq403SaTJ7kdjQVQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO0P265MB5810.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:264::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 13:54:53 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 13:54:53 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 14:54:52 +0100
Message-Id: <DKFCYQ6CGO8J.39DYX4LHWCZUR@garyguo.net>
To: "Gary Guo" <gary@garyguo.net>, "Benno Lossin" <lossin@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Michal Wilczynski"
 <m.wilczynski@samsung.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] rust: pin-init: merge `__init` and
 `__pinned_init`
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260729-merge-init-v2-0-26adf47109e7@garyguo.net>
In-Reply-To: <20260729-merge-init-v2-0-26adf47109e7@garyguo.net>
X-ClientProxiedBy: LO4P123CA0430.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::21) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO0P265MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: a098d680-cd12-48c5-2b5d-08def166cb63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|23010399003|1800799024|7416014|376014|56012099006|10067099003|6133799003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	QfEgoxWbw4XUQQoRMy7ht/i69aajYE3xux5Liq8gL+CLPghRwY7+O40WkugWMr8Gnyyzy+J2Lwn910N03QCiO1dmQHo3AO6X5HJiB39NaIyfPtDniZK6/FRJO/KZ67HlzjmhThAARAaZ+fouCMymlCCJRaLbJMlGaKahDINaUgqD8F9Q59XQgc2g3W8ESZsi71i2mzDW5hsHei1SL7/m5kBQ9qOJ1iYjOz8i2DZsa4xWz/mU8/wXwzS6XxsMOuyUcbhvXlG7fmU3f5aXzmmuiRavltL1YsDIolJto6lPqHBeG5jd50wAt9XM0ZHFTA2GHVd2D0CD80eLOeP9D18tDPqw4Yh//FEw5os5VyZ3eXydindZ/tPVbqf1iFcN2LwL1LWfUzp0gHhcrTvhI0NII7wN7PGIX74sttYJE3jIkFq/0VGS0RrUoDIC14DP9Bve2GAhuZCAFMhQ9v2HbrFMwyFlfLQvMLj/DEoiZurHQPXOHxT00Rq0IWgEKq2/eA0JBJYqol5kgbjPFWF8a8S7F8LJ/xb/58MLZtx5zcTQTESqIfdR7bBOF3JNrUT9HiR1ocgkXe9Tw/34ykW5f0Wwkf7t3+pi2iDRZYuEPCwxfCogeMXWVveHDaWG6hagn7i4au0wX9HkA+i7OqmrN1LDTg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(23010399003)(1800799024)(7416014)(376014)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHJBZTdCeURRbTF2UkZBUXprUStHUjhMTDVtbUc0amxWV0ZIMzkyZFZQY2sz?=
 =?utf-8?B?TE5tRXR6cnFBdWM0K1JUMHlGSkNJU3lnak5sWXdLZXRtUXE4NFUyY0NGb1dN?=
 =?utf-8?B?VTFHdVVOa3pRdE9QWFhlb2hTb0pkS1lkcEllckxLRm9MYTZuOEREMHFSd3BO?=
 =?utf-8?B?TjdBTnJyMC9JS1NVSzEySjAzWjhQaWZXNTZOcFNNSWswVk9uRGhTK1c4Tys5?=
 =?utf-8?B?cHhyMVNkcWhWb1NacnMxOUw0Mi9CV1NKYWZ0TGR3ZWtqblJKSmdIb3ZJN3FX?=
 =?utf-8?B?N0YyTE5lWXZWakF3bUh3eUU1RDhHWU5yUW4wSnZjMUdEMjlvYlF2akQ3L2o2?=
 =?utf-8?B?d1VPV3NabzVadjhJc29kelpFQVFheXhRZjF2K21kY1JMcDNFZEI5cVBrc2Ra?=
 =?utf-8?B?SExKL3pzV1hkZWpCeENWa3B4NEpFaXAyZzlFMi84Vm5wa2FRM3FFVmpNUzNN?=
 =?utf-8?B?WngwbDZ3dkZSVXRLOC94N3AvUmpZNFN2NEZ4SXRGNHZQZGxCYmhpZ3hCeTRi?=
 =?utf-8?B?K2N2MnJqbkpOcDNUVkIvNmhHM3VTZDBXdzMydDNJRlJTZVIyc0xRNmhXRUNY?=
 =?utf-8?B?bElTT0F5UkdkZmlFR3AwTnJHd3AzRVZxNGhaM2JQMjhJV1dKdGR2L3dRS29i?=
 =?utf-8?B?aFR3TDhrd3FOV3BPR2ZrMzYyY2QzR1pPenRQN2FaMFlRYzd5WmlzZWZuRHMr?=
 =?utf-8?B?LzhpTElDVVM3VmM2VStyOWw3NmdxRWNILzdHZmw0dFlxZjNDU3Qwc3dWR0Fy?=
 =?utf-8?B?bGpWTG45QjZHeHFjdktpVXZJdWwrWGNoS0tKQmgwZWM5Sk10cDhRVHhzM2xB?=
 =?utf-8?B?S0ZtSXNNS0tzNkN6emVKMjZOV1l1dTRjeWk0d0NMdWVTZStjVlNFZFZiOElC?=
 =?utf-8?B?emorNnRvdmNHMGpQV09zZ1BMRUNUSjY3V3VsRFNuOFEwa003bXV4dGcvc2o5?=
 =?utf-8?B?YWQraFRuVWdwRnd5WVg3Mk05eXJVQld5cUE3cm9JSVVzdG9Ga0F1RU1LQ0NI?=
 =?utf-8?B?MTlHV3B3WDRmMDJjNCtsOHhiSnhlSjZsQ0taN3M4bS93Z2lUZ3FnZTNheUQ0?=
 =?utf-8?B?andvZGQwUVBFcjdjR1EyM09qSkFiQkp0VWZodDVweXg4V285OVN4SnFnTWZ5?=
 =?utf-8?B?b0tEZThEai8wYU1VdFdJZUptOGJ5V0MvY0xRRkRUVVVEVWNNZlI2bmxHODN0?=
 =?utf-8?B?YXBKS1g4Z3dtY1IvUldGVnpnR0RQZC91VldTSVoxVUxCdkE0SFdJTndLTTFX?=
 =?utf-8?B?SmR2SVN4dXV6MnRtaURJWWtlNlVRWHRyeVBuT1VRdkxLbS9PNm1sV094UkJI?=
 =?utf-8?B?WjBWaXRLTDJXRmk4UThBTlVFZ0RwWWxWcm9aczl6bTRGM3NWRWM0dTgyTnd3?=
 =?utf-8?B?Q3FVVFBqU0RJRVUyUEoxN3pGcFpYWVZXWFd1bDFrT1N3cmJpSW40U2JYbHdM?=
 =?utf-8?B?Nll5Mi91MC9LcmEybzVwSmpWQm10ckVKdTM4aFhqL3RXa2tPUlNoVzcrZG9R?=
 =?utf-8?B?T2dxMUlIMDl1clVDU2pJclllOTZEZzlUVk9naE9QRFczL3VuYlJab3VnclhW?=
 =?utf-8?B?UjhaNU9DZzZpM0RtUXlEUTZsN0ZBVFlkQ2NTLzF3eVAvTjNxY0htSi9zMDNp?=
 =?utf-8?B?cjVjRkJQMnh6YkpCdHpTNm4zdU5WS3pXaDJoa1k5NUJCenJPMi8yK1ZPUFlR?=
 =?utf-8?B?UnFGR3VwZHorbVkvWkpUWU5IdkluREpmclJwUjJpSWwrMXRGcmcwSnprdlE2?=
 =?utf-8?B?cDBKVzgxK3dsaHhsb2hRcmo4SjRRQTN2bGNkT0pCZ2ttbnRPaVBXZytjaVRY?=
 =?utf-8?B?blZLTHZlNEZQQWlUUnV6blZhcllWYzlNbWxKZ2FqYkF3MnRGcmhwWUlHM3NJ?=
 =?utf-8?B?QTdqTUF5enJKWm9zcHF1bi94eGlpTlp5dThmNWtwbmVOT1hUcEJzR1BxNTJo?=
 =?utf-8?B?UEwzTjZmYjhwNEhCVmtVeTJXYXo0TmdJeHNPZWFlOGswalhqRjZmZDYycTRT?=
 =?utf-8?B?cVgrSjFET3NsdkdZYWF5SlRtelB6aXFFR2lyR2s4cEN6blRFVElJZURKdzBQ?=
 =?utf-8?B?aTF6d3FuYVQ1UENTZU0zaDlHbm1hVEhVQWR0NDFJU25ZNk16a21IYmNUalhE?=
 =?utf-8?B?SVZNY2hBMVZOcnlwdU5XWUsxODFNU3pRZnZNb0Nyb012dDlIR2lLNGdVYXdm?=
 =?utf-8?B?RVEvREtVbllvNmxoM1E1aDZMREJDaXpuS3RIdVZudVFTV0IwTmhIcU9FNzcy?=
 =?utf-8?B?aXIzNUNOa3NhdFBYZ3hCQTlhNEVxUXdYa0ZKT1FMMlEyMm9RU0JNcUU3aVFw?=
 =?utf-8?B?M1Z4L0Z2VjJwbXpyYkJGYVlocmFZM1M1bFRVWnByK1RYZm16dUhadz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a098d680-cd12-48c5-2b5d-08def166cb63
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 13:54:53.5539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1wNTPAUCcX6wQi1UPrbcZ99vsvHLgcNHP8A6tb1KEBeupw9SPRXVtK6EEM/75NSF+mSx7IBVPt6kbGIw6tS/Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5810

On Wed Jul 29, 2026 at 4:38 PM BST, Gary Guo wrote:
> Currently we have `PinInit::__pinned_init` and `Init::__init` which has
> slightly different safety requirement but are required to do the same
> thing. Instead of having to duplicate impl everywhere, it's simpler to ju=
st
> use `Init` as a marker trait that cancels out the pinning requirement on
> `PinInit::__pinned_init`. This also simplifies code (and shorten the symb=
ol
> name) so `__init` can always be used.
>
> However, there are multiple users currently using `__pinned_init`. This i=
s
> not designed to be public API; however `pin_init` failed to provide a
> public API alternative so it is still being used. Add `ptr_init` and
> `ptr_try_init` methods and convert users to use them instead. `__init`
> users can use these as well due to the super-trait relationship.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
> Changes in v2:
> - Add a public API for `__init` and convert users.
> - Remove the part about multiple cycles. Danilo suggests me to take the
>   entirety in single cycle as this doesn't conflict with other branches.
> - Link to v1: https://patch.msgid.link/20260722-merge-init-v1-0-d4594de76=
538@garyguo.net
>
> ---
> Gary Guo (5):
>       rust: pin-init: examples: use `Wrapper::pin_init` instead of manual=
 reimplementation

[ Reworded commit message as it's a bit unclear. ]

>       rust: pin-init: merge `__pinned_init` and `__init`
>       rust: pin-init: add `ptr_init` and `ptr_try_init` and recommend ove=
r `__init`
>       rust: treewide: replace `__pinned_init` with `ptr_[try_]init`
>       rust: pin-init: remove `__pinned_init` method for `cfg(kernel)`

Applied to pin-init-next.

Best,
Gary

>
>  drivers/gpu/nova-core/gsp/cmdq.rs     |   4 +-
>  rust/kernel/alloc/kbox.rs             |   8 +-
>  rust/kernel/dma.rs                    |  10 +-
>  rust/kernel/drm/device.rs             |   2 +-
>  rust/kernel/drm/gpuvm/va.rs           |   2 +-
>  rust/kernel/drm/gpuvm/vm_bo.rs        |   2 +-
>  rust/kernel/init.rs                   |   6 +-
>  rust/kernel/pwm.rs                    |   2 +-
>  rust/kernel/sync/arc.rs               |   8 +-
>  rust/kernel/types.rs                  |   8 +-
>  rust/macros/module.rs                 |   2 +-
>  rust/pin-init/examples/mutex.rs       |   6 +-
>  rust/pin-init/examples/static_init.rs |  10 +-
>  rust/pin-init/src/__internal.rs       |   8 +-
>  rust/pin-init/src/alloc.rs            |   6 +-
>  rust/pin-init/src/lib.rs              | 177 +++++++++++++++++-----------=
------
>  16 files changed, 128 insertions(+), 133 deletions(-)
> ---
> base-commit: 6d0795b507fb1db2e6aefe533d949db3a4abf4c6
> change-id: 20260722-merge-init-3ed98519ec7f
>
> Best regards,
> -- =20
> Gary Guo <gary@garyguo.net>


