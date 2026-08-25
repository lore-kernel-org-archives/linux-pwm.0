Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010055.outbound.protection.outlook.com [52.101.229.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652DF397AF2;
	Tue, 25 Aug 2026 11:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787658639; cv=fail; b=Ke47gKA8rs/8wmz3/cbwmA7kviMY3slbAoABuAgtKnb1zF6Jh/WdWRGSrvbkv/PlbSwaMkFg66L7oaTPvopcKr1eH33GYoFZxA7mOqRq0PL30zM2FSdB87fQGADxzxgLSpSbGsPnte624vFpGnQ3RE/zwBcQPWHFRFlVAjBv0P0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787658639; c=relaxed/simple;
	bh=POWGbeT0IE9djfj5N685ozlYDiB0he2/rzjJQgloOTI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A1qGZYKYGm7bgaX9aCV4PPHwsgjfbTpB0yf7EiHD6OhU7IOKvFE6L5mdylkUVgFdHBOciN5uruvlb453dASVTlDuatA4X9CJNEsiKpP8nEh3akcW8DlR11Amt5F5+fCW2csczb1Kv8wv4iF75GkRwy8MfyPuvRwtQ0PebCN0yfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=RS+gtdkA; arc=fail smtp.client-ip=52.101.229.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="RS+gtdkA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WUFVAOOTZEDVxcBH1Cc3p8Bv7nD1NB5BzOxFFV5xNNpqP6c/TjjUf3EE3nYu1aV8RWJpEIQ+c7dukPt/eQL+4D3Ha1ECcboiPjbKXCYsWH88OPRML8jZ61h+iEO+vuylu3PIRFXE4jepFae5wDGMYVfCvjLZSAC133W1YfidRZzEBgRu7OKN5tWQVYIUJSZnOvM43XaDijw/5CH94/BqgCXnGa+eJkg6vQR9pf3TIuwJpRD7iFN2LA9/Rk0fRzynPyEf8YN4KnHWsEf3PejZRhN+fJPK0fSBQMgcRMMwXdsMAxVXjvvvdZ3sHIg8CaW4Z7Rx1VLOuGDe86VghN/Hxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7mVAMxVNDhC+1LT3szWdfV8geKiHTdCEbfGrt6FQF3E=;
 b=IXzUgOG/yUByOM/qHVJALyjtWL9TOIPNDhT7nIGs+Zzj8I4oN1OKQ/QX5EMDl306DGEbSD0CXX/p4SFa5Bw/Sf/pODuXL3oWtEo8uOx+JnHt2gLf3eJsT67s4KAHwvOjG90B7aFFpYF2kZSdNWVPijDp9ZvSXLWYo3gr/ONsmNbpS/uFuVklbMES9uNHVoH87Tq2UcR/fkMLvO5TcR6Rx22yDEYWifcB/Wn8MnqePGY/jLhNr9IvfRFMgK3oNrCYjaBIKr60KKnE/YjpgXVGJD6Z16RALHnuIZvVJO+8EadmIfpOhT9fje5VkrH7vJc2Odf01C1aZ+w3BlfAl7OG8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mVAMxVNDhC+1LT3szWdfV8geKiHTdCEbfGrt6FQF3E=;
 b=RS+gtdkAmBo2Hz+KS/M2ocuH0+nu3MmhYIpQBJcz2OFc9sROvVAmy8oZsHwHuCkBmjAWgn0Rfl7BrY7Ho+ihQJcpJ7x/TUT+eoMfc2TL7+tSZWSHryb/ZwzZpGC2cTX4J55M7lFgXSMqhlJp369LP4y45jcc8iz7h0EBm8jyLY4=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB11173.jpnprd01.prod.outlook.com (2603:1096:400:3bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 11:50:33 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 11:50:18 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "biju.das.au" <biju.das.au@gmail.com>, =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<ukleinek@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, "magnus.damm" <magnus.damm@gmail.com>, Philipp
 Zabel <p.zabel@pengutronix.de>
CC: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"biju.das.au" <biju.das.au@gmail.com>
Subject: RE: [PATCH v7 0/9] Add Renesas RZ/G3E GPT support
Thread-Topic: [PATCH v7 0/9] Add Renesas RZ/G3E GPT support
Thread-Index: AQHdM8fcHNqojDc8Z06HRZGhMEKG4baup+hg
Date: Tue, 25 Aug 2026 11:50:17 +0000
Message-ID:
 <TY3PR01MB1134675EC21115FAB879ACF2986AF2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260824125523.131762-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260824125523.131762-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB11173:EE_
x-ms-office365-filtering-correlation-id: 3dac5ec1-1545-4388-3def-08df029f08a1
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|56012099006|10067099003|6133799003|22082099003|11063799006|18002099003|38070700021;
x-microsoft-antispam-message-info:
 qkE8wGK3QKWcsfRIwV/ioqL2FjrfYJg3t0EJZwdeNZ+cV8g8i1gnoX8Qw2IJ5WYsq5LkGP8aRKEyAVr31V8zTqG3dsPh7WYpYcRhdbt4PFL+zhIK00t1qM6BNfKN0yjS53SIq4/eDgZLZsIRIZHVZzcFBsArRI0rAVRizqqGE34C9D5iIEe2Gdss+yrxKrt7BZVbytSxBZ+Sh0Lj+yuCr1M6Ev3Qy3igpJDHVRKfDJN+t6NPEP12laAL9ODj+u12zeDvSEofdAFiMztLVDyIlVdOOCGNH+rypdLywvlRPhyr3RyS+okK5JlG5hYMd5zRm0GQdDZEh+fN9IVECZVOQy2b2pNZqbQAs6CIvkRzUNFhPm5C+RQW9hscjv8BG4vyHUcUW8Hm6YLmvkMk7CtMTPPv9pVQB60vVyDz0xq3at1qEwaHKT9jsqqW/jFgWe6qM079nfJ8DuKikpla+VVK3OIROQUefLDDG3RWDh3f3mDggtBQKU2r6Ka02EDiH8xCRwCPvN9nVb5SXMx01wZ0dNRE6actNOS1tMyFDZgQcO36+QLJpJn4SQTugz7L0QnlJInsrspzuYjXT0VleVycKxaViUOVMfUHG/GIxRq4U8uwjbYHg8hv46ceZkZDFMjzZ7YwqNYHTLs142BbnV0CRczlqVBKLBu6KH7NrDSkFvnGKRs2CNzEW6HaGK5nPAhA4YvVD9+mqVxptrB/LjiCd0C7lnvlKRhknVuxV2yc1eg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(56012099006)(10067099003)(6133799003)(22082099003)(11063799006)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?wVXI9QkV7qDg7SPsCd0ip6lYrpCofH0yvvYK0Lg3nVXBonWlFMGmQhzdiT?=
 =?iso-8859-1?Q?JENtrxKJrPFe7Ou+44831ehSrHPrD1sGrrlNvkruBWH8YiVsXFzOI+G2XW?=
 =?iso-8859-1?Q?dNpK7VC6GnJ5OJmiMJDO6M2YGN9OW+9Hr8YnxMHhJTpVz0BUzusVWcrTvj?=
 =?iso-8859-1?Q?bTMI3R4I2h4Jkk4anJrif6/L8QgL+l+OREqxJPwFm1VDYPOsBQtgBFJvzN?=
 =?iso-8859-1?Q?+Bxyc9dYT/LaNm6PeOfDAanof3dANXFibJoVJNfVk3ghCxgHNbGeKtA3B8?=
 =?iso-8859-1?Q?sl+tF0cQsJzzI2o59UEEoNAmW4cDzMCWdE3vdfHMY4AJ0kCAOgCaLWDcHi?=
 =?iso-8859-1?Q?tf6iykwPDIqICwqeaFXyjm2a0oEBJdAATFu9/79mQSQDspXBlX9X6c8AG3?=
 =?iso-8859-1?Q?RM6TbTYMmtPHLBTmLEBy/x6M8tAtmDlAvKJENtNINf7yCSlJjJbn71C2Hl?=
 =?iso-8859-1?Q?jhW1AcTnGaRci0u7rnVy/IGaR+W+SMhQdl6bqez2IINY0Wy8vWmfXgxuaO?=
 =?iso-8859-1?Q?tCEEmeI6ZXjdSbvaBHPbkfYTbHZuXEzLZi1JiKbslu01jk3qsJiDtF6VgI?=
 =?iso-8859-1?Q?Exyxfr9L+0ZiPhz92bKK96yIVNA2dpyLKSDjlU6KvclTJ/MV8NoUzemnqb?=
 =?iso-8859-1?Q?PULTaHSemMbLlLWXQbLKJpVk7nOyOQOMa/vSpymhtdyq/hlnVxcNaOT4Ub?=
 =?iso-8859-1?Q?wm/3QHs7krcQenKbJoo1tM+i/CGtbO1Tu1sBduTfWC3zihkmQjSCEvlDrB?=
 =?iso-8859-1?Q?tyHr2mwQZuHQLl/FLEq5nGDXVaUQ+LPS5pbR7vcQQkVSPH/HMM9y1KbA8H?=
 =?iso-8859-1?Q?NzIbq4/Jr38OouOyfoCM4YU4ESQxyKkkIFAohMTR1z4kpd7OEZh6Det6W9?=
 =?iso-8859-1?Q?brchVD6qG2pYEf+TE0m8jH2qn9fBYLEO2Muv24iGq3GywXs8dxyg9QSqIM?=
 =?iso-8859-1?Q?Drv6FMfwLLdoEpE4bIVGYcnRh1u+1+Lvm4qIgodt3FwDXK8dkedKECxJ3m?=
 =?iso-8859-1?Q?H5Fy27GVXlv/PohvA6LihrG8qmcquj84rkmZYLEH1XHT7d/EvYSPy0e2jL?=
 =?iso-8859-1?Q?qGA+jszBk0JMdUoFaAnEoEbjWOSZ7e8JS1sNa3aCJWUILw1HbFfjmcdBtQ?=
 =?iso-8859-1?Q?qoR+qXu/mMOXEP9QaO6CICCmUN2k5fjftqRhAQn3T5wFtDVuMLMr3/5RBP?=
 =?iso-8859-1?Q?RZGhAFUjv0d1Ggh1be7Z0PYrFBDcWFVqXzPABZ+G6xeUF0i996V9DvqxI5?=
 =?iso-8859-1?Q?HRKsaiUgYxWwzKpil+yt9FnaRGG0bJn3gmlXyNNKxFtGeTfTIOsDEPA4IX?=
 =?iso-8859-1?Q?7RiRuOUVtb7lZVAOaZlSgtzDyXgZbq06IgSI+166iJLUD9xWKbwya8jCyh?=
 =?iso-8859-1?Q?vc5eArQQo8ie1KFkIsSJFZQ9kV4wmvdUB3XDU9cCAU0mUNeSSA8IREzgr7?=
 =?iso-8859-1?Q?NfSjDYsF1uft6CzO++3aZJS6BC99ZN7lq0R6L9EQyli42uNywUoJqi7xsI?=
 =?iso-8859-1?Q?+wfTeJ0RghIgidnsQKycNr1fGICRr6LZ21SQklunwwTJw7uzBCSnWk/9F6?=
 =?iso-8859-1?Q?I2FWnH8Fy9epC1Xlc60S8TA1/PqOuVoD+AC17ifq+rJ+v2tw4gbNrgqHel?=
 =?iso-8859-1?Q?GpNl3tVdmein81Y4MXz6gzvkdRMgCU2tguJTcxHm8zMVtNNIsFiEiAYi+S?=
 =?iso-8859-1?Q?3dCCsuGFku9vQgu0tZHrt4wcHgFoZMVJx2PTF36EhBkiXN/6NkCGhL+IaV?=
 =?iso-8859-1?Q?ycmtu/hYdDhyjQc1h3V9e/yV4BwCrSifPOTNTgdeximIIal8KpmjaZ2hoK?=
 =?iso-8859-1?Q?W6BJtxLPew=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dac5ec1-1545-4388-3def-08df029f08a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 11:50:17.7358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uvBmViXRGq0p013RA7XTw1vOR1M6wTqtpLwvK8hbNFuofsubtUP8dImaNU4eUa0rmMG6ZHhiSv22o848urbzSN80A3lf7BWEBNXW5MkFtp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11173

Hi Uwe,

Please ignore this series for review. I found some issues.
Will send V8 soon.

Cheers,
Biju

> -----Original Message-----
> From: Biju <biju.das.au@gmail.com>
> Sent: 24 August 2026 13:55
> Subject: [PATCH v7 0/9] Add Renesas RZ/G3E GPT support
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> This series extends the RZ/G2L GPT PWM driver with RZ/G3E SoC support.
>=20
> The RZ/G3E GPT has a number of hardware differences compared to RZ/G2L:
> it exposes 16 channels (across two GPT instances of 8 channels each), use=
s a 4-bit GTCR prescaler field
> (versus 3-bit on RZ/G2L), and has a discontinuous prescale sequence with =
powers-of-2 scaling rather than
> the continuous powers-of-4 sequence on RZ/G2L. It also has additional clo=
cks and resets (bus clock and
> rst_s).
>=20
> v6->v7:
>  * Reordered the patched moving POEG support to last.
>  * Replaced USEC_PER_SEC->NSEC_PER_MSEC for period/duty cycle
>    conversion.
>  * Avoided recalculation of prescale, if is_small_second_period =3D=3D tr=
ue.
>  * Moved `wfhw->gtccr =3D 0` into the if block in rzg2l_gpt_config().
>  * Added rzg2l_gpt_poeg_link_channels() and used __free for deallocating
>    device node pointer.
>  * Replaced dev_err()->dev_err_probe() in rzg2l_gpt_poeg_link_channels().
>  * Replaced local variable cells with num_poeg_pairs in
>    rzg2l_gpt_poeg_init().
> v5->v6:
>  * Added patch for fixing period_ticks overflow.
>  * Added patch to add missing newlines to dev_err_probe() messages.
>  * Dropped extra space in poegs variable assignment in
>    rzg2l_gpt_poeg_init().
>  * Updated the comment sections of rzg2l_gpt_poeg_init() with POEG and GP=
T
>    in upper-case and replaced configure->configures.
>  * Format specifiers in dev_err() changed from %d to %u in
>    rzg2l_gpt_poeg_init().
>  * Dropped local variables pv and dc from rzg2l_gpt_round_waveform_tohw()=
.
>  * Dropped blank line in rzg2l_gpt_round_waveform_tohw().
>  * Moved assignment of rzg2l_gpt->period_ticks[ch] to *_write_waveform().
>  * Restored clamping of duty_ticks with period_ticks in
>    rzg2l_gpt_round_waveform_tohw().
>  * Simplified rzg2l_gpt_write_waveform() using else if statement.
>  * Dropped local variable gptr in rzg2l_gpt_write_waveform().
>  * Moved mutex after early return in rzg2l_gpt_round_waveform_tohw().
>  * Dropped extra parameter rzg2l_gpt from rzg2l_gpt_calculate_prescale()
>    in rzg2l_gpt_round_waveform_tohw().
>  * Updated comment in rzg2l_gpt_calculate_period_or_duty().
>  * Updated rzg3e_gpt_calculate_prescale().
> v4->v5:
>  * Merged GPT linking POEG patch series here.
>  * Dropped suspend/resume patch; will be added later.
>  * Updated commit description for patches #2, #4, #5, and #6.
>  * Replaced return type of rzg2l_gpt_poeg_init() from void to int and
>    probe() check this return value.
>  * Added more error checks in rzg2l_gpt_poeg_init().
>  * Added a patch to drop the unused rzg2l_gpt_chip parameter from
>    rzg2l_gpt_calculate_prescale().
>  * Updated rzg2l_gpt_round_waveform_tohw() to initialize gtccr when the
>    period of the second channel is smaller.
>  * Replaced period_ticks with RZG2L_MAX_TICKS for the duty_ticks maximum
>    value check in rzg2l_gpt_round_waveform_tohw().
> v3->v4:
>  * Added wave form callback conversion back to this patch series.
>  * Updated rzg2l_gpt_is_ch_enabled() fit into 80-character limit for
>    consistency with other functions.
>  * Dropped field_{get,prep} as mainline now support it.
>  * Updated commit description for patch#3
>  * Retained RZG2L_GTCR_TPCS bit definitons
>  * Replaced gtcr_tpcs_mask->gtcr_tpcs
>  * Updated commit header and description for patch#4
>  * Renamed prescale_pow_of_two_mult_factor->prescale_mult
>  * Added RZG3E_GTCR_TPCS bit definition for RZ/G3E and added to
>    rzg3e_data.
>  * Added error checks on suspend() and device set to operational state
>    on failure().
>  * Added Rb tag from Geert for SoC dtsi.
>  * Added SW_GPIO9_CAN1_STB check to gpt0 node.
> v2->v3:
>  * Added Rb tag from Rob for bindings patch
>  * Dropped wave form callback conversion from this patch series as
>    it is covered in another series[1]
>  * Added suspend/resume support.
> v1->v2:
>  * Created separate document for RZ/G3E GPT.
>  * Updated commit header and description for binding patch.
>  * Added waveform callback conversion to this series.
>  * Collected tag.
>  * Added link to hardware manual
>  * Updated limitation section in driver patch.
>=20
> Biju Das (9):
>   pwm: rzg2l-gpt: Fix macro used for period/duty cycle conversion
>   pwm: rzg2l-gpt: Convert to waveform callbacks
>   pwm: rzg2l-gpt: Add info variable to struct rzg2l_gpt_chip
>   pwm: rzg2l-gpt: Add prescale_mult variable to struct rzg2l_gpt_info
>   pwm: rzg2l-gpt: Add calculate_prescale() callback to struct
>     rzg2l_gpt_info
>   dt-bindings: pwm: Document RZ/G3E GPT support
>   pwm: rzg2l-gpt: Add RZ/G3E support
>   dt-bindings: pwm: rzg2l-gpt: Document renesas,poegs property
>   pwm: rzg2l-gpt: Add support for gpt linking with poeg
>=20
>  .../bindings/pwm/renesas,rzg2l-gpt.yaml       |  23 ++
>  .../bindings/pwm/renesas,rzg3e-gpt.yaml       | 323 +++++++++++++++
>  drivers/pwm/pwm-rzg2l-gpt.c                   | 376 ++++++++++++++----
>  3 files changed, 634 insertions(+), 88 deletions(-)  create mode 100644
> Documentation/devicetree/bindings/pwm/renesas,rzg3e-gpt.yaml
>=20
>=20
> base-commit: 17b4db6750cedbf4b22fa3895631465a5688cff0
> --
> 2.43.0

