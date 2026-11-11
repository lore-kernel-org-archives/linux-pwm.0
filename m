Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.75.139
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794365070;
	b=y2hewbUoB//9xQ/Wgi8gFQ8RCDuSApfDaexvjSXJKl5nInJrJQFJ9Qr5Q+tTyysrUub7
	 sVhz7nCtIaSIgwZBDOVgrrWkt9OkZE3gPMtCS1Ly39TxSUxWoZZx9lZbAbOMNEBHghtgd
	 fbxbwvF0ffTfX5yPpA0Jq8uR4du6P6/LUWNE8wt4dzl4z76ccuY4937fpIVXZjAffJIpB
	 NEJpbWsWXfBzDmmN10nx/mfzv0m9grymXt8DjzeoA8b5vwgkFjCIi99vYAbVTBOyx/IZy
	 iKoUrMZSrpF5EM60TEwcxwlUxX97Kptwnfu+ROBkEApK8d93I70szeWg9H/7c+qHTEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365070;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=5n3LJzBuDRTsiHMyGjXF19fxzf+jI5bxJApPMeXD9As=;
	b=Sz+B+YyLzKZ9N2kvnLSzWXgtoPN2WLmKacyJJOprm28b65feNBNYgo6Q92md9hq9FWYl
	 lgXRS7CDlq8+D+OYZhi5yFelS5sCxkk5hy7CT9KpZbmMv5tLg3eTaSD1ezzbAZMPF6M5L
	 2zjRSAlsGKnMjWG5wpfbT+j2ey2PdJ14B6mnEN26KRhpf1zSqJ1/bkEU+Uxvl/uJCo5Ao
	 KoI6LBl3F9rUXAjUb07lggYcQCR46TQrF0+ra41v4ZOZa3UA3aK6qVn1b0FbvyJuh//HC
	 m6rbMZXcAFgCtJQOw/eAIDfJiiRVdvP550yc3m8oh0FFnA9X7Mocs+NTppwtCl0JWfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	dkim=pass header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b="a5zUDqL/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.75.139
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022139.outbound.protection.outlook.com [40.107.75.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F8F606A31C;
	Wed, 11 Nov 2026 02:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70F8F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=a5zUDqL/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wLmIYT264DUrwZqgVoLJeTF3QlywzAXwwYOA0JWHuquUSu5rtcmZokRm+RIqJkLEbpcsx98ifKoxjiMzsXih1XAcAGlGaeh3oqfijm+M9KByNf/aCKwxaDSlsSCW5EnZxvG/ypXE2tpeR/hN2CE9ZCtK4uDKwShaWSR/TZ7jl8MWGnqYK0DqTA+HWb7LS9WmbsCUp7ccUGuJoHqC1OBAqIzC8m9L3Z4LufO7GeQwUlinbQ0XWZHLwSFqbWZUagvdq3Hs+tFU9n9Q148XpH4t/TQ6MfmIBjg/KcIJ2I23L5suRSk9Eu01brqPlTWWbrQGwSYib366zrrU8MzlulhPhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5n3LJzBuDRTsiHMyGjXF19fxzf+jI5bxJApPMeXD9As=;
 b=Bx5x88mAG5/EiT79Wu5H+CcwASFHZa+hJopTb5A+zA6iDzJL5Nl+Kf3ehXJC/kYxi5pCmOHjDk6SwurUu3W+9WrG1Gs8UrM5Y8ADZCL7rdjXikPs6N+pyelWGj4LO0Yu5ql79nwZTPwSJ5QFc/mBha3lDj/57tYthaOvDzE5YZjTt2RVJnDSIJquRCKcMp5n1MAz7lVkRvOiwv0FB7UxJ8QojmYGlIH4r7nw0jCRz87FbtUKcW42stSUXXUh9IQocfcfPowDDcMnWQgNOFiNcNtG6NuRnOj8J1ZD6VzaDzJo83wJrVwXMuksYUtdvDthcqcwfNeLUppBcwLjWIc3/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5n3LJzBuDRTsiHMyGjXF19fxzf+jI5bxJApPMeXD9As=;
 b=a5zUDqL/SPNlJTC48Oh5xFY0TLEGKkkajKbkkEFOmsu3JPkzExUU8UOSKYAYqJw0J1d5Kynz5bm3xS3ZeygicjKtZ5fHaF9Bw0eNnjqzL8shLFGqu+5sqaT57pRSErwFFDvKxZwn7lkkn4lZedRrxgnJx7NsTNVg4/LEOaEdn+J+XjCd/wniTPsJ5+j6MeUuRfDdtm1NiONymRtFSbhXxmaCowOtBhrKpq/cThrkadurLyN+rQAS9VvvVIefm1yIG7gSDPAiHDupBl7e6TQo9bQnP8UdDggzygSXGcwZ5KhoTdSA10OBl09NR547pgIh+5VNVIScfHTK3YRhPsaH2Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SEYPR03MB8479.apcprd03.prod.outlook.com (2603:1096:101:20b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 02:44:25 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4%7]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 02:44:25 +0000
Message-ID: <18a7edd2-354a-454b-8f9c-d66fbb0819ee@amlogic.com>
Date: Wed, 11 Nov 2026 10:44:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] pwm: meson: use bulk API for per-channel clocks
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Alexandre Mergnat <amergnat@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
References: <20260827-s6-s7-pwm-v4-0-d28a2015177d@amlogic.com>
 <20260827-s6-s7-pwm-v4-3-d28a2015177d@amlogic.com>
 <178879456435.2256446.2005394820666057840.b4-review@b4>
 <ap8FuWnIRVgcP98G@monoceros>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <ap8FuWnIRVgcP98G@monoceros>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SE2P216CA0128.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c7::15) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
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
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SEYPR03MB8479:EE_
X-MS-Office365-Filtering-Correlation-Id: 40ad3f2e-2875-455e-6e87-08df3f9db267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|10067099003|11063799006|4143699003|261026140227099003|261021121427099003|261022075727099003|261009223027099003|261102123227099003|261026121527099003|56012099006|261022105027099003|261028144727099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yxEVFKLHu/tNVzB7EQncakc6HToYJ4h6wVp6gwQSs3tpLRoiJHfiU/dZRQyLQwaVxOyh1WLzCUbHY3vRKYxK3bj1O98Z+3U8wOB8/GMby/v1K9ESaJF8jAekPsi63l6jnx2Z38ek08mEIPbb/Pp6WACGImQq4c9kZ+fnVV/52BW1uHMAqsuwSn1CqDNGTj82+ekAZboCyVLQXhXEwIkcz0g9E939sgVnOMrsR5/XLWG0qLcErGlMfqWdVF2e/3OnkHIrdrPlWrZ/q6OdseqS8ypkY8IT+e4smY1sjnILZ7fsA5nSLiYIdHNDEFIhaUk6Kv26mfZeQN4XPOYkFfhS0Z2mjaTh5HWLAW5nlVBJmCP+qjsBy+C0nTeKaVOhkG1I96qPOrZ13rjvDvDh0QXtUoGna7P3gzgBzlEAht6Kbd1LFRZGfvwKj1Scv+KuVjRunfveESSFfF0M8kTn7P3g7GbRr6DicbzwzL0+TDVEhVafktcUAAU9GvpuWz35i6KGFYu1okyCYqfgjcN2KhzyoP6Aym9/LdLVDgKClxgocQLYt8kBNBINtNQd7v1iEqpbLT9s1wWNU8zJT4k9u3wHAdyGA2byzaWpvODUTmw+MXVeDXZS5y1TKVo5Kjw+g/YIF2LudbdPG4TZ/Oseptu39/exNDCDo/5lf77nIXWpfHg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(10067099003)(11063799006)(4143699003)(261026140227099003)(261021121427099003)(261022075727099003)(261009223027099003)(261102123227099003)(261026121527099003)(56012099006)(261022105027099003)(261028144727099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzhEQktrb3RhT0lHeXgyRHlqOHk1WVhoOC9ITk1sWkNha2RJZEt1TWRlRkdp?=
 =?utf-8?B?dWpzNFkvVlBEYXVQZU1hd3g4am5ibGFDd0gwRldUR2dDR1NkTDVhVnB3aHYv?=
 =?utf-8?B?NCtyUmRUM0tlUDQ3QlBvTy9XQmNmcXJXZWhZQ0tsdDVzL2pJYW10Yll4bi92?=
 =?utf-8?B?bTBLNURjYzI5ZDRQN0pZcEwxK25iSnRBSyttMVFmOVB4TXI2Tm9wMkJ5eUw0?=
 =?utf-8?B?RHRCNWIrY04wZm81VXJIUVc2V0lCUTZIeHIrbnlTL3pUTXFML2tISUU3bG1p?=
 =?utf-8?B?WHczekhtOU11Y2RrcmQyMUxlWGFyRHFTaHB0NVo5MHVoV3MySmxia24xVmdt?=
 =?utf-8?B?WVJJVGNlbWFTdlJScTBhRDhxV21PREpqZ3V5a2VKVW0vQ2FtTnlpaVAyVmdn?=
 =?utf-8?B?WWk5ZXNjRHhZRG1pb2x6OEMybVJTd1oxL2Vod1B3K0o2RTNrMHVyQnRBakpy?=
 =?utf-8?B?ZGxWVjhyYjg3T25ZVkYwNU13aTlNcVE3a2o0czZYdkVZTlV1YWttQlNjQlhm?=
 =?utf-8?B?VVZvRG0rZGRiNE9KV0xEZVZ1bW1oZGsrbXI4cmkzeGlaQ1BNRC9TdzZESWo5?=
 =?utf-8?B?SXhHYTFLVC82ZnlWQndQOUdrenliNGJBcVFJbVpFeThYNnduZktXbW9TdmtT?=
 =?utf-8?B?TVVtVURpVkF1K1B6MFVvbWxIa0ZoeHUvK2tDbi9PMUVQM1kwaTJsS3I5ODkv?=
 =?utf-8?B?TFpKQ3JYNEFHZ1h1Qk85VEpNNWpsWnJwa2VRQ05ZcTM5TElZVDBHMUEwTXFo?=
 =?utf-8?B?STZnbW8xeGh4NmFRRDBmYnkyQUsvdXVaZmE2NDlVMCtjaTBTU2Y5cUJwWFNa?=
 =?utf-8?B?b09BamhScUhTK3ZteWd5M0JjY1lMalh6ZzkwL0Z1SzR2Yk4zMW95OEdEODhZ?=
 =?utf-8?B?NG92QytlWmROOXBDMUdMZzVvdU9RSDk3RlE4cG5QdWhzdUYzZEEyQjJ4YTdy?=
 =?utf-8?B?d3REUU1XcS9NYmVNd2VWQk4yUUhtSnBFK2twU3JNYytkK3AxVDJ2djNiOExs?=
 =?utf-8?B?STcwSTZFOVVsT2hZbmVUZ0xUa1JlTExDTEduTmttYzV6RDJrRjZSekVUMHMv?=
 =?utf-8?B?N0JmTTgyNHdyZUhBaklmeW1pbm5QelJNL0NHY0tvOFZ3OG44MWNhZjFRY2pN?=
 =?utf-8?B?WU95Q3lvZnUvbGtCb0hFMFZ0ZlUxenpzdWY3Z00xRkZGOG1BcUYvRUQ2eUxa?=
 =?utf-8?B?NU5QbXAvQXZkTU1JUlhKRXpaTStIaWtwd3RJd0lUZTFaUlMrdmx6RXdhOHpP?=
 =?utf-8?B?cFlOY29ETVBjcGhWQ29Fc3ZjL2NRbXNlTGtvRkJMcDJHM0RURS9RNGVjNld6?=
 =?utf-8?B?NWZxU2UvUkR6UW5qZTZvRGdtRVdNS2lIZnNxK3JDSkZxdEF0Yk9TeWhjUSt5?=
 =?utf-8?B?OFhPaFlZUktFQlg5dnhXQ1kxcHl2OEpvOWNTY1hQM0UxdCtTY0MweHJTMVlP?=
 =?utf-8?B?UnROb1NmaC9nM0pKVTBYNlVDbEhlUkZWaTE0c21sQ3U1SFdaSjAxejdTQXpn?=
 =?utf-8?B?NnRUalM0ZnhldFRnZHdZV29UbGZkbWdUei9xS0VMTFRJUVdNbDdicGI4NkVU?=
 =?utf-8?B?SHdMQ3ZaMUI3dVpkd0RaMUZvSjExcDhtMDhHNVJEMEZFS2FBYWQ0cm9CS05o?=
 =?utf-8?B?enNmN29OQnpCd0Qra2g1ZWNGeVJmd1pYek9LTWVVRDM1YU8xd1FrZFlqQ05v?=
 =?utf-8?B?aGNzdU90cGtIaG9LYmhrTTdtSHVCaGpoWkFMenFNK3BhelFzdGpVcHJROEQ4?=
 =?utf-8?B?UzY1eGt3SmVBcXpJOXBDRllHelpmZW41YytvRnZyNmNNMW1xK0xuY0hNbkNF?=
 =?utf-8?B?ampGdEo1VmNhYjRwMm9MeU5QbTc1QnNuNTRYSmlMQlhKbFc1V2U3UUxZQ0kr?=
 =?utf-8?B?eEcwUTFyRWFvd2NYMmN0QS9QdUVRUjFmREhhbUdWQnVvNFdUc2dYdWJpSllF?=
 =?utf-8?B?bVkySDF2MzdQcFBoUnltTkRCWk5XRlpqVml3RkpsQWZZczhZQnZRWGZteW8y?=
 =?utf-8?B?NTBuM1cxTyt6eHNUMy81Sll6di9EWmpsS0dsdTR2L0tUaHRVSWU2Mm44VVox?=
 =?utf-8?B?R295U25NMXFZQmI0SlFSaHRyeGNvQXNKQ3pnc3p2U2FJVHRvK3JZVzhWZy92?=
 =?utf-8?B?akNDbUg4YWdTcXNNL1VYcmZIdjUyOWIrOHFTeUxJQ3RkMmxoMWR1VEJKN0xM?=
 =?utf-8?B?aFFGbDNZNkVjeXhLYk4vQll4YW9qR3FuSGx6M1IvSlBiR2c4TnBvdEFadmhP?=
 =?utf-8?B?eXlpRHkxUzkyM2RRdzZERGJuV2NFTjhjNXZEUEV5T09LLzdxMytuYThPNDJj?=
 =?utf-8?B?Y3hCSjE1RXJQdENmb3ZIOXEwbTdpV21NUnRQZTJNQkcyNHFsWFhLUT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ad3f2e-2875-455e-6e87-08df3f9db267
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 02:44:24.9635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZOTWGZxKREmvXjiwFTFSxZxJph+5Ix4Ur1eKeaETgKj7bMrDR9EL5JB9qagZ3Xshyl3ut792D6DGkdOmvTFB88Um7Koh/NmUirS1Sb6SGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8479

Hi Uwe,
    Thanks for your review.

On 2026/9/8 02:44, Uwe Kleine-König wrote:
> 
> Hello,
> 
> On Mon, Sep 07, 2026 at 05:22:44PM +0200, Alexandre Mergnat wrote:
>>> The S4 PWM driver currently gets each channel clock individually with
>>> of_clk_get() and uses a custom cleanup action to release the clocks.
>>>
>>> Use devm_clk_bulk_get_all() instead to retrieve all per-channel clocks
>>> at once. Verify that the number of clocks matches the number of PWM
>>> channels and assign each clock to its corresponding channel.
>>>
>>> This also allows the per-channel clock initialization code to be shared
>>> by Meson PWM variants using one clock per channel.
>>>
>>> Signed-off-by: Xianwei Zhao<xianwei.zhao@amlogic.com>
>>>
>>> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
>>> index 22cefc6d5dd0..6f151464d7cc 100644
>>> --- a/drivers/pwm/pwm-meson.c
>>> +++ b/drivers/pwm/pwm-meson.c
>>> @@ -497,33 +497,25 @@ static int meson_pwm_init_channels_meson8b_v2(struct pwm_chip *chip)
>>>   	return meson_pwm_init_clocks_meson8b(chip, mux_parent_data);
>>>   }
>>>   
>>> -static void meson_pwm_s4_put_clk(void *data)
>>> -{
>>> -	struct clk *clk = data;
>>> -
>>> -	clk_put(clk);
>>> -}
>>> -
>>> -static int meson_pwm_init_channels_s4(struct pwm_chip *chip)
>>> +static int meson_pwm_init_channels_per_channel_clk(struct pwm_chip *chip)
>>>   {
>>>   	struct device *dev = pwmchip_parent(chip);
>>> -	struct device_node *np = dev->of_node;
>>>   	struct meson_pwm *meson = to_meson_pwm(chip);
>>> -	int i, ret;
>>> +	struct clk_bulk_data *clks;
>>> +	unsigned int i;
>>> +	int num;
>>>   
>>> -	for (i = 0; i < chip->npwm; i++) {
>>> -		meson->channels[i].clk = of_clk_get(np, i);
>>> -		if (IS_ERR(meson->channels[i].clk))
>>> -			return dev_err_probe(dev,
>>> -					     PTR_ERR(meson->channels[i].clk),
>>> -					     "Failed to get clk\n");
>>> -
>>> -		ret = devm_add_action_or_reset(dev, meson_pwm_s4_put_clk,
>>> -					       meson->channels[i].clk);
>>> -		if (ret)
>>> -			return dev_err_probe(dev, ret,
>>> -					     "Failed to add clk_put action\n");
>>> -	}
>>> +	num = devm_clk_bulk_get_all(dev, &clks);
>>> +	if (num < 0)
>>> +		return dev_err_probe(dev, num, "Failed to get clocks\n");
>>> +
>>> +	if (num != chip->npwm)
>>> +		return dev_err_probe(dev, -EINVAL,
>>> +				"expected %u clocks, got %d\n",
>> Small style nit: the continuation arguments are not aligned with the open
>> parenthesis, whereas the dev_err_probe() just above and the rest of the driver
>> do align them. Can you fix it please ?
> No need to resend for that, I can fix that up while applying (after
> checking I don't have further concerns).
> 
> Thanks Alex for your review!
> 

Is there anything else I need to do before this patch can be merged?

> Best regards
> Uwe
