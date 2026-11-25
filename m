Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.80
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795623579;
	b=cSbTx8RgDVEDArpntatMhFCrxoOc8th+k1oHZCa52uOddmzHQqFRvK1kfOAhL4LwEJhU
	 t2zGt7sMvVu++QD1OV2hArIPXPgzHxZ0VJp/1Aismtfa3G9GDeCfmLofJ8w0RwdQbKX0F
	 irwmz+TkwFJq7oprGuZ2e/kjoQzyl50Z2Ofl+U4ZEtGV7kydSGocWNohX4pQI1oT8ekY9
	 6vf3h8TcYjETgLUulJWNGFRbFFbzI+tO4H4EFjsLVtsII1mbShdHJq23wj63AuKoaqrev
	 g0n/KHkziGDevwZ9QXVxK4gHYmCglgoK1dM074hZ03vH96o5p4cz+FLRzNpR0zb6aEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623579;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:From:To:
	 Subject:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:
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
	bh=st5CPMLtqQsyzzXYNFTS6SVM/oQUOZBkPYn3gBv8Cc0=;
	b=nQyaMp1xNyaOgGyOVEr52pqNkqqvsNIISGNvgVAQ2oWfy2sRU31sDYxzXH909D8ePNtv
	 byFZ7azVrSpXoMag2A3HYfnAjz7eFfInqu10KmzLNFqxrVY+PJw5kEIYtAqxsJNZuJAHu
	 5+FOkq76lVkVRpD/yD1oWD9d6iqghJtLveP8szJbiXIy3ZhihT/BsIdIDPryT8ji5fHZY
	 Q9gXMpwX+6yo5aziqTiFG4pJQwxDtLntWdyf76lw/q2aMXDryiErKEh8bHy2XTzaFMgEB
	 dNZmkOzcc3EXfWWjTN+QZ3FZRZB39xZ2K8dJyGzlNkwMjHOPjvaBxJ+E1/NDrkP1y0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=garyguo.net;
	spf=pass smtp.mailfrom=garyguo.net;
	dkim=pass header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=KSt9JGZE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.80
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021080.outbound.protection.outlook.com [52.101.95.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A0C606A31E;
	Wed, 25 Nov 2026 16:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89A0C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=KSt9JGZE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4Q5suvYW1QOJoR7rB/hRo/5jsDk4WxlodnRcYwkq47bRd/FZrkln/zQ3icN2ZupNdiwKIj6ZwwH6vSWGDtI7c2OYGMjpEI9Poeu8Zpha5iWPUE5iTTZ8VomC/F3cHrawyqOgODzVmXD7X7ymBdI3qCA0nTW24KMjeaFAVykSZ5FEp41tQmcFtADjopeG9baOmv+wycK3RANbTqswYSVEh4VyfqjVvdVtZ/XX+FY+/gJu2h9Vov2MKB5c0kxmcFs5TGtLI16mCu6fuxzww0qGXSIXiCwi94CAUckMES5eHHPx5J/94rdm9ao38fNxFJgC/0inCmJgD+lKjLdaUXViQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=st5CPMLtqQsyzzXYNFTS6SVM/oQUOZBkPYn3gBv8Cc0=;
 b=Cigcqmg0UqsbtocULDEfB8zTCkB9ijlKTTWSMvbcj764VfduaaKtq/uY4N4MYxu7w4aP3LRtkn6uI4N5UfnnS6rD3evtjXF0E3eu0zUfq4dDRfEbf7Lc/Gyt4IQLxa1EtppHNAuZDWUGblJSKvl4B9nKu9vd9piG2RUuF5V6kz2QyGXUUF8f3B4/N+044QRSUEyYJHszTSutKi67zjd/vMWp5GXeyJ2XklvNyyxu0jWPZMKQjhlgvs5a8YsqXwJsyqDdf7oUREixsjfsTgLXS9L3Oe6oyT3q0ViaRdzds/+7bR8rwRkwDh4mJT3rpT2Ilt/eYXzgPh2epb30Nx1Y/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=st5CPMLtqQsyzzXYNFTS6SVM/oQUOZBkPYn3gBv8Cc0=;
 b=KSt9JGZEnxEaiAZitEa169y2URDb4SW33tB0vZH4OrGaWGvLoP6pvuGNHbSiz5eK/DpFSMUZNgD9jAj9xqldxN3ToyalvZ8PNiTOcCdpWrDaXCB1kf4Gz9AYUomniYYgayL8e1+lEmUZrEtcq4rOo7in2JtAFjDwCt87rsLaOLk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LO0P265MB7313.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ee::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 16:19:32 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 16:19:32 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Nov 2026 16:19:30 +0000
Message-Id: <DN4FFKMFI488.187QX5RI55L8S@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Priya Bala Govindasamy" <pgovind2@uci.edu>, <m.wilczynski@samsung.com>,
 <ojeda@kernel.org>, <ukleinek@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <dakr@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <acourbot@nvidia.com>, <work@onurozkan.dev>, <elle@weathered-steel.dev>,
 <linux-pwm@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <ardalan@uci.edu>, <zhiyunq@cs.ucr.edu>, <dzueck@uci.edu>
Subject: Re: [PATCH 1/1] rust: pwm: reject over-aligned driver data in
 `Chip::new()`
X-Mailer: aerc 0.22.0
References: <cover.1794600927.git.pgovind2@uci.edu>
 <caddec5478a0d39a73152247a60bc21b3c609cc7.1794600927.git.pgovind2@uci.edu>
In-Reply-To: <caddec5478a0d39a73152247a60bc21b3c609cc7.1794600927.git.pgovind2@uci.edu>
X-ClientProxiedBy: LO6P123CA0017.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::7) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LO0P265MB7313:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f12134f-861f-4711-7417-08df4b0fe326
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|10070799003|366016|4143699003|22082099003|6133799003|261009223027099003|18002099003|3023799007|921020|10067099003|56012099006|261026140227099003|261026121527099003|261022105027099003|261022075727099003|261021121427099003|261028144727099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	U0PQ/F3sH5m4V4u53QgDzfvWlREfDlKakpjR3Z0DlX2ZM5mX9LOdgmW20krDR1rrHuuVqg+o4AbnpKi+uiokf9LN+xsYrFX5xgmVPlWPnVTeq0FhtsH5Cnw06bFDDmUuA438TMN6+KzUuS9DzSahZcx4uGeqSu1qo4g3O4PPIqOcct69YWPOEjPnIVoTTZzEzxXCrdZZz2H/JqJIehvAwKZjAhM/ApFG2o+Is6Km8JTeltRTYXGid8/3YoEPJRLhui3PMFtxddX40K87R8gBZiUx/IiQI28TkKWWL8vohUmdqm1nLWrtIHNN4wy0UEzw9KjFa0YQ0fZ4f2Y2j6YJLwhxCXcQzWM1fNiEhhdaFeVanN4SJutr2wGvedn1dPC5nUGhSw8rTY4x/NRage+WCsSqwJlNAU5n77onxWL1nUXghjFaRkszV0z8wWmfmWn2/oOnb1Sc3xME17lT8hLL8QvQ+bJ1yUukfnp+oVoKVZ8aG3MqijG/wvPYV6jKfnDg2DqH35ma9yvGhevA+nKqaHv3xxGXLla/WheM4INGPe59nKB1Y6W2BLECVhQYL84EuSjmopq3iTjFHIt47hNCcFqurDU6Q1vnz6P1obLkNyE9L/QwdwXNgFYbuI2OoIu3TLAIz3NdDpVu8g41q2a0903cAufm9K6lE62qJkRiLS0AOZbsCH2XXmmTD1XDwd+hvEQIuoKU+cw19mzgI8fnSw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(10070799003)(366016)(4143699003)(22082099003)(6133799003)(261009223027099003)(18002099003)(3023799007)(921020)(10067099003)(56012099006)(261026140227099003)(261026121527099003)(261022105027099003)(261022075727099003)(261021121427099003)(261028144727099003)(261102123227099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUhYWjZyMTBGUGM2UEI3Q1RSVVljb1RWdkU3dlhrOUUzZ1NyTTl0QlhkZExB?=
 =?utf-8?B?emp2cndlYXc0OUtuM1VvT0FaQ3NRRGpNekUyNVNOTVVTVTROVXl5a0tXSCtk?=
 =?utf-8?B?WFpBWWUyN0tLQ2I1S09TM1FTWmtzdXI5L1NQZUlCYjVkOW5LL1VqN3RteFd2?=
 =?utf-8?B?R0dTR2NBRG5GbnVxbmhEamZpWGZrNFhYbkU4OW4ycnRxcEU4NG80TVd3NVp5?=
 =?utf-8?B?RWVkWHZtWjVUT0JjdGN4VEp3TEF6RW9lWktIaVFZVzBSOCtlT0lVb3RrbVZN?=
 =?utf-8?B?OU5aNkFUdHpleW5hTzdnamo0QmhmUmhmakY2bnU2UlRxbE9pWHM3UjNuWUNL?=
 =?utf-8?B?WTU2RUZ6YWljbmFGRDZZbmd0VldibGFtWm9uSHRIZ09JeWN5UkxaYkY3d0Nq?=
 =?utf-8?B?alJhVVdTUkhOdjdHU0xBU0ZyOWkrZVdETThSMVJzdkhpYkZUYlQwL051UHB0?=
 =?utf-8?B?N3RDODUwSGJaY2hWUHhIMWtzSE9SVlQ1QmZmZldYNjJ1ZUpNMWZ0MWtBSkhK?=
 =?utf-8?B?dEI1STFzY2thZDI0WTU1VHNRTytMWkVDNUFVZnplTjZuVFJmeGZJS1psZW1M?=
 =?utf-8?B?ZDJ1V3ZSN1ErMVA5aHV1aW5XZHJvNGYyc3ZydThkNWNPMGdPcGhTZW4wWEhl?=
 =?utf-8?B?Wk91bzNXeVVNdWw1M3RJenFQWG90RTl0VmRaajhrUjdYOW9JektLVzdrT3N6?=
 =?utf-8?B?SkFKajFDZjZVdmdiQUxhdHJ6d0J6V3pvekMzM2RobHNUd2prTTlNcm9vUEVP?=
 =?utf-8?B?QnFqbEJWRmZ6aFBPcTZ3SnArRTBiM3o0YUtmVkhUdjhDYUt6cFZSRTFNMEd4?=
 =?utf-8?B?S1NpQXdWYURQeEpNekhPdzdYU0xLRUJJeU1oWk1FYjNoMDIyMEEveStmbXpG?=
 =?utf-8?B?clNqMkxDU1BSbi9KYU95OTNzVnZDRlNDVTNvZ2hUR2ZvYzY4L2w3S0t5MVBO?=
 =?utf-8?B?ZXozTUtWV21UN25wVDM5WU1yS00vYXV0dFI1Z0hJcy9FMUZhdi8xQUtmRkt2?=
 =?utf-8?B?ZCsvdDh3SWR2WjdWWjB2U0g1ZUtHSENPL0hYWnVZa1VOZC96Ti9lRG00dWVJ?=
 =?utf-8?B?dWJ5ODc4V3h4aWEzM203bnd0eTRvV1ZWVzJ5MHN3Y1pjNHJtc3h5ZWVHS3da?=
 =?utf-8?B?L1NGQjVXQVlpQkg0QjJlYy8wdHdQME9icEwvRmN4UDNVT2tFcVUwRml1MlJ6?=
 =?utf-8?B?TUZ6ODcvZVZFd0FySnpUb1MvOHhEcFQ0Z0JsS3VtYzB2NWlDc2hxUG1sQmM1?=
 =?utf-8?B?Q0wyYXBBTFhvODg5c1NMd2FzbThKZk41b0lzeFlnbXF0Ti9weFRDRXBEaGc4?=
 =?utf-8?B?Q1pvcUJnaXVIL3V0TFpqL2RPamVGVkhMWERENEhSUUxDWXFDaytXZkd4eUhD?=
 =?utf-8?B?QTdUY3AzZ2h0djJ2QzFDVnZQYTh6dS9pSU5TUXptRlJPc2NMWmNibnJlMmNK?=
 =?utf-8?B?TjNMWG96SG5laWhzM3ZYYnZ1QWNHNk85K0toblJTTi9qREV4cDRsUXN1SlNx?=
 =?utf-8?B?NDIrYlpsNXR3Vkh0WnRnNk5kU0hzUU45SjJZNXIrSFRUYjlKVzBueTRtVUo2?=
 =?utf-8?B?MURjbm51OEU4eHNtZ3MzZTJSLzlwcmthV3BLend2VEhCcC9XOG94bUFuTUZS?=
 =?utf-8?B?S0VmR3dhUlF5eFFyR1BUVVpCQ1IrR0hBNDdVVGNDOWUxUytGV3IwYkFIU2l3?=
 =?utf-8?B?T1hwclpYNy9mcStaREZPcDFobXNYUElIMkxNOXVqOGhMeUw1TmJzSno1d0dw?=
 =?utf-8?B?S1RNM3hRYjh6cXk2dzIxckFqZ1p0Y2lkc0t1ZzVJQ3p1cFRVNi94ZzY0bEF4?=
 =?utf-8?B?TXhJN2laL21ZY2VndnEvemRHSjNGNHpmVTVGWmlaMENLempscmtuUXdiczdk?=
 =?utf-8?B?YlpZMWVTMDA5WDN0NlJVeHpmU0VaRk9Zb0ZacDFYNCsrRkU1WkdmZm44eFdm?=
 =?utf-8?B?UWFTS1JTcUNrTW9qY3JsY055cXUzVjIwdndOeWV0SzJ2OUIrQ2xKai9oV0hv?=
 =?utf-8?B?OXBEVWJnY1N5SjVrMVNxVVRJRVVPRU9rZTNSNkVYK1JHOS92MnRXMVBiQ2Vq?=
 =?utf-8?B?ZDZhdzV0bVNzRFlCQ3JuM2RWdlNuWTJwU0V0WEtJRVpSTFMzaktwaTEvV0pO?=
 =?utf-8?B?MnZYRkl2SE9iQnlGRTZiZ3VEM1RxRDFCeFAvbzBHYldzN2VLaGpWRmIxZDIx?=
 =?utf-8?B?b1pqUFJHaGxSSFFJVGYvTTZXdFBkNGRYUmNSTU5wTXRoVDR0N1d4SWZwZVB6?=
 =?utf-8?B?ZDMyZVhVNGVrMW9GdGE3U0E2dXI5VlY3dHRqS3Brcnl3bDdWbkJpNjJKdk5V?=
 =?utf-8?B?eG56blFsczFVSGVORUpyMHdrR1RFUDJFRHpVd3VJcFZKV1hvblFKdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f12134f-861f-4711-7417-08df4b0fe326
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 16:19:32.1040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18a52Rh41J5QBJfQwwx/Q1MSwoSWpJv3GgsL90CX7K4uGpPe4pu55m9ODtFY7YZSeH+sJfA9ETZxlR3VD/5SwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB7313

On Fri Nov 13, 2026 at 8:25 PM GMT, Priya Bala Govindasamy wrote:
> `Chip::new()` does not check the alignment of the driver data type `T`.
> This allows a Rust kernel module to choose an arbitrary alignment for `T`=
.
>
> `pwmchip_alloc()` reserves `size_of::<T>()` bytes for the driver's
> private data. `pwmchip_priv()` aligns this storage to `PWMCHIP_ALIGN`,
> which is defined as `ARCH_DMA_MINALIGN`. But, `PwmOps` does not restrict
> the alignment of `T`, so a caller may provide a `T` whose required
> alignment is greater than `ARCH_DMA_MINALIGN`.

The commit message is overly verbose slop, please simplify it. Just state t=
he
issue (`pwmchip_alloc` aligns to `PWMCHIP_ALIGN` only) and the fix (reject
drvdata with higher alignment with const_assert).

>
> This can result in `drvdata_ptr` pointing to misaligned storage for `T`
> in the underlying C allocation.
> If `drvdata_ptr` is misaligned for `T`, that breaks the safety
> requirements of `pin_init::raw_try_init()` which requires a valid,
> aligned pointer as an argument. This is undefined behavior.
>
> Additionally, `Chip::drvdata()` can be called using the `Chip` produced b=
y
> `Chip::new()`. It creates a reference to `T` from the misaligned storage
> which is also undefined behavior.

These all follows from underalignments and there's no need to do this
explicitly.

>
> Reject over-aligned types at compile time by asserting that T's alignment
> does not exceed ARCH_DMA_MINALIGN.
>
> This issue was detected by FerroLens, an LLM-assisted analysis tool, and
> was then manually analyzed and reproduced.

This should be a note and not commit message. Move it below the ---.

Best,
Gary

> Fixes: d8046cd50879 ("rust: pwm: Add complete abstraction layer")
> Reported-by: Dylan Zueck <dzueck@uci.edu>
> Signed-off-by: Priya Bala Govindasamy <pgovind2@uci.edu>
> ---
>  rust/bindgen_parameters         | 1 +
>  rust/bindings/bindings_helper.h | 1 +
>  rust/kernel/pwm.rs              | 5 +++++
>  3 files changed, 7 insertions(+)
>
> diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
> index 5bab3cf06336..59d0a6518032 100644
> --- a/rust/bindgen_parameters
> +++ b/rust/bindgen_parameters
> @@ -49,6 +49,7 @@
>  # We use const helpers to aid bindgen, to avoid conflicts when constants=
 are
>  # recognized, block generation of the non-helper constants.
>  --blocklist-item ARCH_SLAB_MINALIGN
> +--blocklist-item ARCH_DMA_MINALIGN
>  --blocklist-item ARCH_KMALLOC_MINALIGN
>  --blocklist-item VM_MERGEABLE
>  --blocklist-item VM_READ
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 3791af0aadc7..4ffd714f9229 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -113,6 +113,7 @@
> =20
>  /* `bindgen` gets confused at certain things. */
>  const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN =3D ARCH_SLAB_MINALIGN=
;
> +const size_t RUST_CONST_HELPER_ARCH_DMA_MINALIGN =3D ARCH_DMA_MINALIGN;
>  const size_t RUST_CONST_HELPER_ARCH_KMALLOC_MINALIGN =3D ARCH_KMALLOC_MI=
NALIGN;
>  const size_t RUST_CONST_HELPER_PAGE_SIZE =3D PAGE_SIZE;
>  const size_t RUST_CONST_HELPER_GENLMSG_DEFAULT_SIZE =3D GENLMSG_DEFAULT_=
SIZE;
> diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
> index 8aa47304bec3..7823bb56d17a 100644
> --- a/rust/kernel/pwm.rs
> +++ b/rust/kernel/pwm.rs
> @@ -587,6 +587,11 @@ pub fn new<'a>(
>          data: impl pin_init::PinInit<T, Error>,
>      ) -> Result<UnregisteredChip<'a, T>> {
>          let sizeof_priv =3D core::mem::size_of::<T>();
> +        const_assert!(
> +            core::mem::align_of::<T>() <=3D bindings::ARCH_DMA_MINALIGN,
> +            "PWM driver data is over-aligned"
> +        );
> +
>          // SAFETY: `pwmchip_alloc` allocates memory for the C struct and=
 our private data.
>          let c_chip_ptr_raw =3D
>              unsafe { bindings::pwmchip_alloc(parent_dev.as_raw(), num_ch=
annels, sizeof_priv) };


