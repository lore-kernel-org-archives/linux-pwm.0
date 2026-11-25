Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.119
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795628708;
	b=Yd3lUw7bCuSOUu2B4HE5znzZq16w7quJH0twVlPlZfIcnsTDiUq+xhjDCWuKovG1QvZq
	 QATirmycxt7+THo57EyqyzcPN3Wh2b+7he/JhoCymWUKF0UfPuAnR89aKEhnIuf//ZOiB
	 3l0uWMZeZ1OqKOWEbE0CL7lEbHuCEd2QXi6G4nGaOVE7glZdJuFS1775qVVZBWSrVIO9p
	 kgT7zitItzKcrfHs9e80Kldzd8NN9KI6ZQoMNKcd4LpyHCKKvVOmuxriW3DGqcGZCFsU1
	 j03BSmjKqA0emCXsfCoMpHGUcPiYKYn0nFx3tlCgQ5wVfGMFU9ezZ+xLV/KdwJ5xnoQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628708;
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
	bh=YtUoZROMY4FEPZqPPD4EFLEbRhcPJTAaarz25kek/fw=;
	b=GvBXKZWNQQAvkRxBTXzDQ5j1vJYc27zBpjcXqn9xZfXLO6aNs9tw0xaA8JA5dcDA53Tl
	 HZDFThmuqH1Z5leu3tJFUgv5vJiobEsUa3el9xoIbCzymgjCAfiUaa0Xvxhnwfr/BGycG
	 4XwauWYT2wiAzIV7ktDG/+UY3j0exGIkWcnFzNrKxV3Tyknzsq0f4Y8cMpvevK2P4m+lg
	 36o7LlrZm5pJdOYqT8nbJ3APVl2FyHCgN7Hrqkdsy8rhblxRt+X0667Lup8qNbSHJCjOV
	 04Lwa2T37hUBXsBQqjC34zhpokDS+O4oiMC61dwCqTXAKTLfHhcPI+/aI7ihld6yjVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=garyguo.net;
	spf=pass smtp.mailfrom=garyguo.net;
	dkim=pass header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=nCAMQgye;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.119
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021119.outbound.protection.outlook.com [52.101.95.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F33C606A68D;
	Wed, 25 Nov 2026 17:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F33C606A68D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=nCAMQgye
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FgbSLzb5Skge3DRBA0xq0z3qUx7Y1NDe2uaKdHIBDzMcvjp3psWL1CUtuL47azo//almdrY2vhnZMNi+nUIAtIxqQfY9SKiqwpb8/hdRu4w8wr7dBTNBXMTD7v/I7e4AgiTUogEv4aAllQOd7GqO9kvt8oP30z+Uo35mCPzSE+IVT2rAGb8aPUZYA+o84ulmgmQTb/wQIyWAsuL+Q32h5ZudfatnK6Pq4uoR8w6rcY2SH0uFazqUHmdO31+YuIQPeEhuXKwqGP7+yJNzEyZUKBpRNnJfvK1BgX9xcPr+XlOzU6RFTMBZLrEYYeUeqtoDoG4rjJ4yaJN+bDjOjgMowQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtUoZROMY4FEPZqPPD4EFLEbRhcPJTAaarz25kek/fw=;
 b=xLVEHKs4N8GJuQjKoTa0hs+cl25n/RNWDME/b6to1A5wvmUifSA7jYSAnJHKs26KOzG2cq/J/3Mwd3G2BaaJPIZSDNNpqsafHXDGCq58/27eOQkMg+yyG70KdyJc6oEZ5Tbk7utNGI1God9vRX1vQt1phpOkDs7ELALM7nu48Dj9DWvoPpEF7irMpuhFHXn4HpIa6TBPSQpp8xspU9Y+wrpjpZh845gme7asu5qCArqCHqN3BGYGdh3WojsDVzoukw7UcIKz69/Q4RBkNlpyaFiU88B9gRFGdPhoQ3GFQPCx0zMOQ9OImBx+9T10CS08R8IR4gkz1HgBC6PEKJCJPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtUoZROMY4FEPZqPPD4EFLEbRhcPJTAaarz25kek/fw=;
 b=nCAMQgyeWY7sk2UAtvx5AcOAzxrgy03oiFsnRh040KhMj12epJshcf/xqEOwoib7LhN+6B4Dvqu5H1ughAHNiV3HKsPMP3rLyfalihL8v3+ssZinP2aecsPQE15QkNpTnhA9XNOFB5qT8/+yI6mPrncmczq3nzPfNKXb7vP57uE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LOCP265MB8641.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 17:45:04 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 17:45:04 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Nov 2026 17:45:03 +0000
Message-Id: <DN4H92P6CGXR.UWHS0SN6H62D@garyguo.net>
Cc: "Priya Bala Govindasamy" <pgovind2@uci.edu>, <m.wilczynski@samsung.com>,
 <ojeda@kernel.org>, <boqun@kernel.org>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <dakr@kernel.org>, <daniel.almeida@collabora.com>,
 <tamird@kernel.org>, <acourbot@nvidia.com>, <work@onurozkan.dev>,
 <elle@weathered-steel.dev>, <linux-pwm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <ardalan@uci.edu>, <zhiyunq@cs.ucr.edu>,
 <dzueck@uci.edu>
Subject: Re: [PATCH 1/1] rust: pwm: reject over-aligned driver data in
 `Chip::new()`
From: "Gary Guo" <gary@garyguo.net>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, "Gary Guo"
 <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <cover.1794600927.git.pgovind2@uci.edu>
 <caddec5478a0d39a73152247a60bc21b3c609cc7.1794600927.git.pgovind2@uci.edu>
 <DN4FFKMFI488.187QX5RI55L8S@garyguo.net> <awcbICD_lN4uJrKo@monoceros>
In-Reply-To: <awcbICD_lN4uJrKo@monoceros>
X-ClientProxiedBy: LO4P265CA0263.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::12) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LOCP265MB8641:EE_
X-MS-Office365-Filtering-Correlation-Id: dc1f4e0f-e9f7-47fb-d16a-08df4b1bd68a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|10070799003|376014|7416014|366016|18002099003|22082099003|6133799003|4143699003|10067099003|56012099006|261102123227099003|261026140227099003|261026121527099003|261021123027099003|261022105027099003|261022075727099003|261028144727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	kftRBvSra36uM+KTJjBYjcq0lqzk6es0MhvSmQyPbD4gWc3b0fdMMj7zWfRjJ7GPWwQXxxxmciZ4Tx8WJFh6on4HY4VCDBHp2iPoo50s+d5sdrz82U7qztChx7xu5AgI/5D7Swkk0ofcGNCGWs0rAknSWvnUhq70ZMDEpu3dLq7XljkJuhh1VpPzY5Lsl0WT3+BxwzqXuphaByssUVsV4+nc42cU/ZU1SH5fVFOSSaeyvozWPFJ1/VjgKrUxqXfSeXyH+9qyz3ZJBriXSZPpukQI1xes0uOxgN4ab7meOfwf7HRQp1wnk7hTzxLHQHzKxHGSBReWvjgOok7Rh5vDTdSWXDwLDeVDuxOwqFEV4tdn0M8tqoHg874WtsPx0FlHtPV7nFX+W5U8ZIAGxQcQ8v0UguW4zPElHmfJtbba5wFB7y9Uq3yVXjDCGYib+dFLXKMkGalp8mdUe1h0ceZCJV3aboiJIfVXOhvktSbUaourz2sxqsWbIer3KXoWIWKMzU9UAZj3ccRej6fxsW43VnqKNine0ZSeg+y0eGZ3uUg3itIFS8nlScpXCDgAacrNEKykUrb914YptAWm0xPb46E7NNG7Vc1Mk6fzEa6C8QwJyM5fMLWbtatjtGO30nT8ftlOZDW1WIgOYJcdKSXyodLuaQO33QOXfL77r39Fww4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(10070799003)(376014)(7416014)(366016)(18002099003)(22082099003)(6133799003)(4143699003)(10067099003)(56012099006)(261102123227099003)(261026140227099003)(261026121527099003)(261021123027099003)(261022105027099003)(261022075727099003)(261028144727099003)(261021121427099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGlGZlp4VGFDT0FHek5IWFRwbW15OHhhWHlNbVNMbnFtem1IdnBnU0F1ME0x?=
 =?utf-8?B?TzFOUlU1RklkN21TRmYrVE5yZ1ZMT0NNUU9IazJ4b3pVQXQ5SWN2QVRLTUhn?=
 =?utf-8?B?TCt0MlpHMDBiNkRTRnVqckhzRmF2aFlJSnVMZnNlSlJyb01HbHlsWEhaZXoz?=
 =?utf-8?B?Y2I1eGs5SEMvUXdmcitjdXpXTWxUYmppM1cySWNrKzh4UHVpdGZoZFVGWTVI?=
 =?utf-8?B?bTJGSC9ESFZDMGJLUEtMelV0QlFFUENjem5LQWViekphc2pLcEVDMVhQSDlW?=
 =?utf-8?B?RFp3U3hrZzl1VUo2Y1V5K3Z4RWVUQ3ptT0tEa0Mwd08ydzJ2L0RDdFcveDB1?=
 =?utf-8?B?Sm9RZ2ZNbTBsMmhYU2pkbU50NUFENXpoa01NYTlZUDBsRlpYbGkrc1psSlU4?=
 =?utf-8?B?dThqY2h4N0R4MjhRV001MEZnZS83R1lMR3hmVk9qTU85MWJpVVF0Q0tPVlBw?=
 =?utf-8?B?Mk51SVVYbDBMaDlRdU9McDFNcWFkQUJvazNxblBYb09YejB2ZE9HUnMzcG81?=
 =?utf-8?B?ODFNL21GRi94bUNkRUtlM2N1QUZZQlV0aTRMTDY4QWNqazM1WDUxSGZZcE9O?=
 =?utf-8?B?Lzk2RVlPWXphdmNTWVI2Y3BrVS9kalZxSFpvcWcycGt4Y294c0lNU2I1bW5j?=
 =?utf-8?B?ZnRTNEhSZ21nUnZWWEs4cnRMK2oveEs1VnR2Y2x5V2lURHROQzROSnQwcmtF?=
 =?utf-8?B?b3VjbUE4US9BczA1d0dQSThjWjVkQkc2bDRlb2JWYUJKTlNSVm40STNWOWRS?=
 =?utf-8?B?QytWT0pZOWxxVjRIU3FvZzZ0VzIxMWx6RnZkdVRLbFE0YmtYNGxaa2RTeURY?=
 =?utf-8?B?YVlnblA5cmxPOEhCVDRnVTBxTHYzUU52YUh5RU42Wkd6dCtmcWU1UHlvd3hs?=
 =?utf-8?B?RTB0Z0U2U0RKMDM4Tk5Jd1JuWEtVWHphV1lvZ3FMcVRsU01BdFZGdG1oSEEz?=
 =?utf-8?B?Uk1RNCs2b2o5ZXRUMVdNWXNxYTVSL1crdHI0ZzBGcy94c090WDFScnNndmJC?=
 =?utf-8?B?aDBSTGN3WUZOcVF5cnhiZHhEOHdBT1hRR2ZWOE5ncTBzSlpWS2xxMDNPTXE5?=
 =?utf-8?B?VTMzMEVNcU9LejN4ZVFabTZNOSt6M0J6S21OOVFrU2pQRkMrQzFJN3FmdlFR?=
 =?utf-8?B?dUNXcGROM1doNjNNN2E3UmtQK0RqaGZEcWJwQ3JQYXZsblJDb2VXdC9kQktl?=
 =?utf-8?B?dGFjRkIvUTc1TkwycGYyYjdldW9zYS9KZWZHSG8rdThscExMMWdjZ050S0hJ?=
 =?utf-8?B?ekVPUkJIcXRZZHFLZ1RlL3hNK1hUQzBJTzdYc0tjQkU3S2tubC8zUzZvMlBj?=
 =?utf-8?B?RDlWWU1UcGZSQm1SS3dNVWRPeXlyRTZxUkhyTWVPZXVQTHRBdU56NUd3RUxv?=
 =?utf-8?B?NFh4ZXdBekxhbmw0ZkhXb0FXQ2FwYlNxQlNuU2hTWURNbzd4TXdLbnA4dEVV?=
 =?utf-8?B?K1ArZ2t6R1I5MEZOUlAzczBmTzhKWUN4bTRhRjViK2N4RllBamlyNk1xOW1U?=
 =?utf-8?B?NS81UENXWEtQZ0NJYytXajVnVmJDSUgyTFdJazRoR0hDUVBNOEczZlM5NC9h?=
 =?utf-8?B?Ukxvb295YysrQWw2QVA1bUh0YjR3UlYvSzBJM1kzbnNQRm0wR1lhZllGTVFj?=
 =?utf-8?B?dVlDZ3BSSU5INVgxTnpDaDV6d0RHYS82WlF1M0VjTjhtNjVlMGMwMGdhV040?=
 =?utf-8?B?cnRDMnc3UHhmN3pFeGdzSHdEUlpwOFU0eExSRytTNUNPOHAxVXRQMWY0NWhF?=
 =?utf-8?B?SXRpcy94K1FVcEdzT2RvbTVYd1doS3hTMkdxa2tFb1diSUdQN3NFQ3VTN3B5?=
 =?utf-8?B?VjFDNTBxdm1KdWlUeUN6ODNLRjd0VSszQ0ZDVHEwckExNk9uQUpKazh3OXFs?=
 =?utf-8?B?SVRXdWtaSjRkSUFsNVFpWU9ibVpSSmdRcUZiMlBOTWtyTXpEdXVWK0lHaUow?=
 =?utf-8?B?RVhtanlVWFpCeWtGMUMwem9uMUdiVjJnZjB5SzdsVFZmdWRVTVBzSlhPYzho?=
 =?utf-8?B?aEVUcjJHZXJnQWl4MmI2dk00TVR4TCs5akI1MWRkSXRSalI1YlNxODRBd3JK?=
 =?utf-8?B?MzVpUFJITGlJVW1JQjVHTlNFdW94YXJGaGZFUnk0Qlk4Q2FBRGNEUGI1WkNy?=
 =?utf-8?B?S2RkZE5Sc3p4UFQxMWhma3JqNjd3aEx5dXFidy9ndEJWaVhLOGtoY0lQTFV0?=
 =?utf-8?B?NnRxbnhZZkdKOW1IclV0ZHdkSjR3L1N2UDB6a0pYVVluYXMySnZYck0xUHdj?=
 =?utf-8?B?akcvV283U1dIYkdaYnlVRnJQTkFrYmoxWFY5NitFZ0NlOTNnQ0t6NjQyZnB2?=
 =?utf-8?B?SWZwRUEwSUo2T1hXVklZSUlCYkRGUmJGRHlSTmVvejc2RHhnZUNVZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1f4e0f-e9f7-47fb-d16a-08df4b1bd68a
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 17:45:04.6758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ES9P43EmkTVXXrmePBip+g0bHFx6ym6RaaZRlv5A39rKVsRgvbIkQeDNMcAqXRkN39eWrGFupbjBkAU9AHVXXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOCP265MB8641

On Wed Nov 25, 2026 at 5:32 PM GMT, Uwe Kleine-K=C3=B6nig wrote:
> On Wed, Nov 25, 2026 at 04:19:30PM +0000, Gary Guo wrote:
>> On Fri Nov 13, 2026 at 8:25 PM GMT, Priya Bala Govindasamy wrote:
>> > This issue was detected by FerroLens, an LLM-assisted analysis tool, a=
nd
>> > was then manually analyzed and reproduced.
>>=20
>> This should be a note and not commit message. Move it below the ---.
>
> FTR: While I agree that the commit log is very verbose (and being only
> half Rust-literate I still don't understand it completely :-), but I
> like the info that this was found using a tool (in contrast to being a
> real problem triggering with mainline) in the commit log.

Perhaps better to just state "This is a soundness issue and not triggered o=
n
any of the in-tree users"? I think that's what's important for commit logs.
Whether a tool is used to find it doesn't have direct correlation to whethe=
r any
in-tree users are affected.

Given the removal of "Assisted-by" requirement recently I thought the idea =
is
that exact tool / model used doesn't belong to commit message anymore.

Best,
Gary
