Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.110
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793112702;
	b=E2GDXeS2/XJl8LJxPNNGZUWpf4/AKnRjf4JO9bkEZSgu9PrJmdcGn6FAigrMYSvgipAe
	 WnLBlsekzAcf+aMJJsKQTVUkRHGFADsBAj7d0nbNGNpU3v8FMBNRWo1Y8uei4ez8lac79
	 NkeC3nt623K4NGSpwJEUYNRFpFnFZwxtSWLlkN18EEfytpq6ArX9YU8Z7dtZcGi6uOZWn
	 GgFNsCUdjhej2aaEG4foGXE39I4Zyc4dXvNdayqv9j2K5bNQo2mL37b8kn4rWgnTloArq
	 +3Kz3+uCW+HC7bbNNISfASIwQR3J/RcQTyxogqayFh8ZI+kNrI3jJdgdwlZUGItellw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112702;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:From:To:Cc:
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
	bh=W0tAYPaDOA4f756PfZHjoOunZ++lQmvM3dsZP3bK4pQ=;
	b=mcf5e7zP4W+bJKbMBYa99hGjR+F0+QkaRr3VvJxnkuZku+yRXDoPe6rP+UBbqJJOVLg7
	 lbC29NxBd9LHWn32DILsuveOcZFK8VkWFHyl/rtFWt3oFE41mnj/+jNwN/mfzzefrKHiu
	 PQtKKs8WjaJToKjBlmE6gH/qtKcT/tHDDqvtI3n5gALH4bapWBu0S8RpXo060HsJzTl52
	 eq66nN/vSa+CC2ESEghJan+7+It1dRTkt+wbrYUsaFj+oBIruV0VC8YPcWelSAF0Rk1/9
	 PUvcrGfolL29K3cglEmpFtFUIMP8in04Q8g2cJPpMnCyYRwpZYAYrBcj663cL7fXDXA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=garyguo.net;
	spf=pass smtp.mailfrom=garyguo.net;
	dkim=pass header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=iWv9x1NB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.110
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020110.outbound.protection.outlook.com [52.101.196.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA606606A31A;
	Tue, 27 Oct 2026 14:51:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA606606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=iWv9x1NB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lKDhRteJa7sXN1uXZ/fwYB3wxLEOznMWnvLKavl6ugWisX7nBD5jTj6M+sR7sMaUF+kZ215jLM23WGCNKvX4XyQXIRLwYXa3+Q89Uq9jKinWXyEb/6Xf4lOlCxWOJhDLchPQ/hoin9sRm0mUKZOMcVk+VgtcCfB43ymgqPbnj0DUrnWo5vQvCBH/ryQtHOViwE8WwY5/7ZQehVmkCWCS5qZxbRDInro21T1pxoCyCXqz19ARyiG4DGhxTk+0Z70qBcCuk/qp1JbVnYrxYbBaWHVk+/jEKLNKLGd5c0hz/RdRO4F7mQjQA0PBXJyWByZpRHTh+C3eEdk+NboKGbWzvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0tAYPaDOA4f756PfZHjoOunZ++lQmvM3dsZP3bK4pQ=;
 b=KLUA+rGJjZZ9yHPrSZy8pT+lsarOotfbQAF/Rfj5gdcrVMssEBDtmMTiOD6q2u+tfkCsD9XeRq+Xgg6JgIwDB7ihpgGOy3zEZWy+lrxifuCWZdKB8WLocBFYXd7kzOV8CplMvhnF9U5HwG3MDAkDDwQU/Yp8sC07c1dv9A8+97zo+2hqrRi2sjh1pr7MPuL1XOzWd1e3Y9wFLXtHGT66F2LkohCBJg3182hXOedr0Gzw+/Iq56MUOvCmI/RT+mBKjdrONiZH4Dhm63yHM1aTUOyiRTljyT54+oC8OudDhkK8mjhIuk5ICaDoqtcFXYytYgvzOjOd4/yw1zwcG+LNNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0tAYPaDOA4f756PfZHjoOunZ++lQmvM3dsZP3bK4pQ=;
 b=iWv9x1NB2cqjb7vKnPd2exvfbKN1Xdu33WhnvQwDcXEYXpjskwXTi1+rj5z75yzNMrhOh8plX25hhyQ27cNUIqerpOJjssdbIaQN2U8LTiBrd3xtjKdCpa5DWFtXhSWEWdg7A5CScMGqCigXcrA8yu2dOco7Pc77m0/tgvQ2bzU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LO3P265MB1961.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:bc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 14:51:35 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 14:51:35 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Oct 2026 22:51:15 +0800
Message-Id: <DMFPE71J8205.3FZKD5BKW3U7C@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Guenter Roeck" <linux@roeck-us.net>, "Andrea della Porta"
 <andrea.porta@suse.com>
Cc: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Florian
 Fainelli" <florian.fainelli@broadcom.com>, "Broadcom internal kernel review
 list" <bcm-kernel-feedback-list@broadcom.com>, "Jonathan Corbet"
 <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "Randy Dunlap"
 <rdunlap@infradead.org>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Ray Jui" <rjui@broadcom.com>, "Scott Branden"
 <sbranden@broadcom.com>, "Laurent Pinchart"
 <laurent.pinchart@ideasonboard.com>, "Gregor Herburger"
 <gregor.herburger@linutronix.de>, "Stanimir Varbanov" <svarbanov@suse.de>,
 <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-rpi-kernel@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-pwm@vger.kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH RFC 0/4] hwmon: Add fan tachometer support for Raspberry
 Pi RP1
X-Mailer: aerc 0.22.0
References: <cover.1792748690.git.andrea.porta@suse.com>
 <7df58d42-517c-4936-88b0-9d044d30882c@roeck-us.net>
 <auBzvB8TsvIK8Hik@apocalypse>
 <53a4b4bb-271c-4d2d-a9e4-cec4e0ce214b@roeck-us.net>
In-Reply-To: <53a4b4bb-271c-4d2d-a9e4-cec4e0ce214b@roeck-us.net>
X-ClientProxiedBy: TY6P301CA0007.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::17) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LO3P265MB1961:EE_
X-MS-Office365-Filtering-Correlation-Id: 54fb2695-c3d5-4e74-dcf7-08df3439cbfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|23010399003|10070799003|376014|1800799024|18002099003|22082099003|261026140227099003|261021121427099003|56012099006|4143699003|10067099003|261021123027099003|261009223027099003|261022105027099003|261026121527099003|260925021911599003|260925022911599003|260925021311599003;
X-Microsoft-Antispam-Message-Info:
	maYIBDOfQfFGMxIM5Irf4+rEPPxj7BXTbLUoyn+css2gqcvevKbYZPhbd/RzPbno567Y/Rl3Mu1WQG/6h1bhb+Jn8el2mhgigBUQXpXcRBw5YLZ4aBR5XFSMF8/oZL4W38ovSOgMGyGwtgBy5usNgesZeBzJJPODUZjBGfpM3xIf6czXfz861a8udpzjouMLy/q9wQYYIJ7CpJ0Ldf6K1QV7CWnoJmEV/3rIeFQFaXpdGCsiTICLNQuoPn+i2vpO8gqiOgWh21YVIljCDPdDLv+nPzJP8omqjN5fGrN9QpmHYsjkhNaqEED3smvTj+kQ8KugCANu612EQxokPSF9Fm41q8kwjOTpTJyub1XBWG9HxAXZjbb32SJmCCGiUbxx1aGvV7gk6ATuNe3SgO6J/tBORaA8jqHjOGKs1fe9AYHdDq7yeDK3rBQk3IpNrG0mkHbD2Yy57FPQuYQx1mEwvb10HhP0c9LIMwYG25/8AAzIStdh75BkAYsSM01dekrScm61rj/7mkWjEmVsrBdz2YCPbx9X5wENK7YxeYKkSRAWINwpCvZUlT6Lj7CVx55qrt4LfEp4FxARpdlc8t5/jP2FrJdyD/XfxWUlGBQ11mNrDICj8Ot6D0DTY8QiA63A
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(23010399003)(10070799003)(376014)(1800799024)(18002099003)(22082099003)(261026140227099003)(261021121427099003)(56012099006)(4143699003)(10067099003)(261021123027099003)(261009223027099003)(261022105027099003)(261026121527099003)(260925021911599003)(260925022911599003)(260925021311599003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0JVWUx2RlJGY251djdNckY2b1M1ZUk0SjlSSWVyVzBRRUlwdDJaYzBIZFJU?=
 =?utf-8?B?RllDZ3d0a3Y3ZE9rUnJROTFKUGVJczFoRHk2N1F3L1ltZ0w3OWQ1d00vbk12?=
 =?utf-8?B?T0RmVUU3aHJBRFhpWlBVU1dtMTdBbElJVHpkWHMvd0I0L3RmVXp6eUV1L2V0?=
 =?utf-8?B?M0RBZTlRcTlkb1dTVkhuajFuUloveWZublNxZGs5K09MbVBGTVhPZTdkTVhk?=
 =?utf-8?B?dGxwK0lTek50cFZqZVA1dHA5VzFTNG85TmswSjl5bEdsM3pRT3puR3UxRDZz?=
 =?utf-8?B?NnFKaDNJN0RYQW4wSEVwdDVWQy9NY1I2Qk1ZUHI1QUdJWU5nMi8yRXVBNE54?=
 =?utf-8?B?ZzdLd3I3ZTI0dm94dWRuUTJVdGtZWWN1QTBaZjZJSWxMZ0hEbGdoSkhnQVZI?=
 =?utf-8?B?RTJFRzFtdCtaSHVVeFdPS0dwbzFFM0YyZHoybTVwV3ZLQWxNb3RWSElqY2lZ?=
 =?utf-8?B?ZjJ5Vy9QWFNvejBCbnZia1FhZkgzZEttVnphSnhZekFmVkQvRGt3YzhrZUIz?=
 =?utf-8?B?NVEzbEpJcG0zcTIyYUdjSjFyUGNpTzlBeTlXZnRuaE0zK2RObEI1bnFVN2da?=
 =?utf-8?B?Z3UySEtpQjlCZW5xU0tpNE04bDdvSmkyTXdod25TUGlwSFpEUTZ5aU1IQTRR?=
 =?utf-8?B?RjRxcFJyWjJiSUtVdEEzYSsyalliMGllRGYrUVVmUXNNVWN6OWpnUlNyQmVy?=
 =?utf-8?B?MkVXaDRUemVtN2MrTUhxRDZrNXgvc0pqamREQk1YQVh0RlVlemVGbllJaVZL?=
 =?utf-8?B?blA0KzNZNzliNTFyZUxpd3J2RnMzTFV0bXQxZHEvYzVrekhPV1JOM0NxS3Fy?=
 =?utf-8?B?T0lhcFZydUFrOHA3Yk5neExlak5zdzd4NG5KSU9sS0N2WWttcEpLeUwzN05F?=
 =?utf-8?B?RS85N0lDclZkRDBaMWJRZTR1QVE2NzNpWDR0ZEYvT3FFaC9lYjRPekw4S1Va?=
 =?utf-8?B?UjlzZUtPaFArZVVqZnlvSEF1UTg3M1JXUnFVM3YwRTM2VlBjRWZVTnM0QThm?=
 =?utf-8?B?R1VDTWd6YnptQmNWQzJjWXZTYnN5NmpqMCsyampBYXRCZ3RzZzMwa0EyYnpT?=
 =?utf-8?B?aUVrV01ZdEcxbE05aWVzSlZDd21GRVpCc3A3d000TERneHByVlJJdllGcnBL?=
 =?utf-8?B?Ry8xTStZTTQrWEp2MUhjU1Z2MUtsaGJwcWlRUlFBRG92Qy9mY0NLeEVXeVlK?=
 =?utf-8?B?K0dJTU82TWttcyt0ZTdEaElkOGxhV1RreVI3NGtHRG9RNHZ3MUJRYTdUU0dB?=
 =?utf-8?B?Sjh4cWZNT0I1Q2FmRjlUa3dTZ0ZEQmlZRTQwZVJ3ZmFBTzI0dGVXODZSbTlE?=
 =?utf-8?B?RmxUZVR5WmxGaFozYmRNUEJZejluZjFKNFZvbzM5MWdFdkY3TEkwRThuR1VC?=
 =?utf-8?B?bjJKc3JiZmxiQ1NVSlVnTzdKZmR2ZVNrclNuOVpvTUF3V2pJQ1Nyelc1Z0NB?=
 =?utf-8?B?RklLSnVmYXhtTks1WlNaUUl0T3JKT3FDVmd4a1ZoZ29ibFZ4Qm44bkF3cmdQ?=
 =?utf-8?B?OHorbXl6Nm9NaDV5ZDJUbUhsMlE3eitnVldHQzUzejNwU29YUXBlTENzeUcw?=
 =?utf-8?B?endVeVlsRStyN2MwSU1PTTkvUzBueXgyaWFwTk9BdU5YUUNLSmFpNXV0Qy9h?=
 =?utf-8?B?bXBBeW9SN05ZOFZaWHJMR2RXRkhJcXpxYjFoT0JlRXlXM2xnbFJBWmhyMlFG?=
 =?utf-8?B?bUoyRmNMRlFLNFZuUzE5c1B6SGNOWUxMbTVkVGljelJ5THgvK0JLRHpsblZC?=
 =?utf-8?B?TDdFTFRTRFVNU1R2Y3FtWlc0RFZmcmdaS3NTYjcyOTRNbTJWL1RKci9VbTJO?=
 =?utf-8?B?bUZXS010QXlOYi8wd3F1UVhOcE1TVVZWMUZYajhZOVVlckhDcXB6L2djTmhX?=
 =?utf-8?B?bHR3K2JLWWV1L2Q0VW1TekNlZk14MUFNaUhNMnd0cHU3d0FuUndLQ3BlN3U3?=
 =?utf-8?B?UGhpVHc4TVpkaTBVRlNlbkcxNjN2d3VFMmwwSkhXcXFEdFNFN3UzNHhNY2xE?=
 =?utf-8?B?and3blZvSEUrc0pqejlKcWJldG05L0NQRE1QTTRzQ2Z3MTRvNnNJWklDdXlh?=
 =?utf-8?B?TW80LzZQdXNlZ09OMTllS0xtNEpyRVNMOU9wN2JpWnZRS1dmektSbk9UQjE2?=
 =?utf-8?B?QklIalo3c0tkczNPWHFzK2VDZU90Q1RSQ0JmUlpRNTV2T0NPTFBTbkxxbnV2?=
 =?utf-8?B?VVJVYlhWVjNtSDhqeGhWVExrOG9pdFlRUUpQalc2MFFLRkExd1NhdjJienJN?=
 =?utf-8?B?aG1ISDNlTDZ2OVg1UXk5RkkzMUM2eGNIS3RZZXFMMFNuQzNRVld5dTg1aUR2?=
 =?utf-8?B?UGZkQkpLS3g4eTlkWWl0Nzg2ZXBKaDVjb3ZUYVVnRzlRdjhMS0pIa3k5SzB3?=
 =?utf-8?Q?+qpSlrfEfBnvQH2gRWSaMMWkXoR6VoBoRFcqv?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 54fb2695-c3d5-4e74-dcf7-08df3439cbfc
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 14:51:35.3511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6yc9wjNsAOubu3nRK7HzqJLoNdm2s3mjDDJ43sxPofnXPx6rHZXb0zWLBCxgh53wz8ecN4DD4JI7iuBXXFfxtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P265MB1961

On Tue Oct 27, 2026 at 9:48 PM CST, Guenter Roeck wrote:
> On Tue, Oct 27, 2026 at 10:49:48AM +0100, Andrea della Porta wrote:
>> Hi Guenter,
>>=20
>> Yes, I also proposed that in the cover letter because auxbus seems also =
a viable
>> solution.
>>=20
>> The current implementation is a consequence to the discussion about the =
companion
>> PWM driver, from here (and the revisions that followed):
>>=20
>> https://lore.kernel.org/all/cover.1775223441.git.andrea.porta@suse.com/
>>=20
>> To give a short and hopefully coherent view of the decisions, here's a b=
reakdown:
>>=20
>> - first proposal: PWM driver + fan hwmon (to read the RPM), all in the s=
ame driver
>>=20
>> - V2: Uwe preferred to split the PWM driver from the hwmon one, so the h=
wmon was
>>   dropped from teh PWM driver in favor of a future (fan) driver. To acco=
mplish this,
>>   I moved from readl/writel to regmap + syscon.
>>=20
>> - V8: Gary proposed to export a function to read the fan RPM as a viable
>>   solution. As a result, the regmap/syscon was dropped as it was no long=
er needed
>>   and the function has been exported from the PWM driver
>>=20
>> - new patchset for fan driver: the now independent hwmon moodle just cal=
l the
>>   exported function from thw PWM driver.
>>=20
>> If the auxiliary bus is indeed the preferred approach, I'd like to ensur=
e we are
>> all aligned, as this would also require refactoring the PWM driver.
>>=20
>
> Let's say it that way: If you don't want to implement the auxiliary drive=
r,
> and you insist using the exported function, I would prefer for you to go =
back
> to the first solution. The one thing I really dislike is conceptually bro=
ken
> code, and I consider the current approach broken. Your call, but the one =
thing
> I won't accept is the code with the exported function.

I agree on the auxiliary driver part. However, I don't think EXPORT_SYMBOL_=
NS is
an issue, and regmap is not the right fit here:

- Previous version of the PWM1 patch series publish regmap using
  of_syscon_register_regmap, but this cannot be undone -- which needs to ha=
ppen
  on PWM device unbind (the RP1 PWM device is itself platform device, but R=
P1
  chip itself is PCIe device which must be removable).

- The tachometer register is not its own separate register, but rather (re)=
using
  the phase control register. The phase control is not implemented in the R=
P1
  PWM driver on the list yet, so this is currently a simple register read -=
- I
  can see that RP1 PWM driver need to take special care to about the tachom=
eter
  reading if the phase control is implemented.

  For the two reasons above, I think the way that tachometer is read should
  really be an implementation detail of the PWM driver and not for the hwmo=
n
  driver to worry about, so I suggested using EXPORT_SYMBOL_NS.

- EXPORT_SYMBOL_NS is the documented way for exposing functionality from pa=
rent
  device to auxiliary drivers: https://docs.kernel.org/driver-api/auxiliary=
_bus.html

Best,
Gary

