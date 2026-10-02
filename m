Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011056.outbound.protection.outlook.com [40.107.74.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7CD3E1D07;
	Fri,  2 Oct 2026 06:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790923467; cv=fail; b=knReVgMR3TYw0ethcEAQYULwQXFunaFT+L+pKZG1pgY26ZQ/xNDU6rhtsRRya2fc9TCBPS2GWf/qjM0XV4zmTq27isf6qclnK1wYIe/U8Wi9HKFIaajuPdq4CTbaJg3WXBM55wSdpos5gTWLbBFUCgmlnTxCttTWxiqZRc34hyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790923467; c=relaxed/simple;
	bh=qujSzWcpA2o1bAQU+ox3IcJPJz27mJKNfM89oLxjRkg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fo2g/RUbhcgeLplP8ckXsWGEP7/eG29Wt9Xv7cnDC4Qxpdihbiz01EGe30lLIHzB9OwYTGbBaQfcTUifkO3h7LSFacjlrKb05mxIgBiNij62pRhcYloIe/jzFUZyLob+AvkuEd0HhfVFBkysJH/J08BVUKN/tR11w9OfDgD0SzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=TMIuz2Zt; arc=fail smtp.client-ip=40.107.74.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="TMIuz2Zt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQdEsUnC0S43qXJB+hp3IEo3syVCzQhcCQk79zmuF74CG4So9HRa7sjPhQjPkqqWSG/6w70q4IUGFWWPYkGMfYW78jdYGQ6v1MvyCYUXerkeYcdWjhNPW9hl0S+zoHs5EFxhpYlun5C6CtLVFAKafGszisZyKfv9QhND0ooJeLggAfFtt9NS3XUEQgEVKJg/s49ODrbjmT3zmj3Y1/UJm+jeQLI+Wjc4g/OtoTlR2WQTpdxspFCZpyzK5HDDugOSWN0bv1afn7Agz5DQLAVzrQ2TNAAnTZFXE2fyzocS7DkISnVBzUbKspfqVWCUNiE3yTyJ/h8ljZ1uT+82EiYxnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Urgq08dhplqNMwKxurOFkAMtI+zug1dXyKaPllgXDqs=;
 b=HYNnLu/ilaF6z0jiIlRSH4Y6CDYFOUTmNMKwNeo7bYuVi6xVoVTKtFtCt1/Eqj8GqX7qU9aWog3d9CJLHrbmJXOIUYxv2akPWl5t7f9Y8BnU3eyY4R2Supg+v5+v1osvBa0BnrJJtj++n3siV0XvCo0v+MXNa6x7ZZSZUKq2gERmsFqrHC2pHaHm8qHlLCg3XJrmwxyjUqPdS2mtP1WIYLa3auNTSpflVuCBsoMlQ6PpSIpHegL8zJweeZzNKE2MoN79WOnHmrkCsjb17B6aEfuizU0nz3wDEV2njN/wTfYcVXNZ/D6VbzybERZyJIisdv95kB8tTT7Of/3pV02pmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Urgq08dhplqNMwKxurOFkAMtI+zug1dXyKaPllgXDqs=;
 b=TMIuz2ZtL3e45DV3oKlxJo5AiOnZsJJ8k/fxeukPdwezx6XZ5tJZBDzfTyuBxS6xNkgZM/xam/ntaK5KwBwT9GQUVwQAHv/m7qa7uq1xaNwWHJue1JF3IlNcPGPu9wuGMXCeJ0oqh4cuXgixv2NfGBIGr3qYCAnmxIuSSqkgMgY=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY3PR01MB10220.jpnprd01.prod.outlook.com (2603:1096:400:1db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 06:44:22 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0451.026; Fri, 2 Oct 2026
 06:44:21 +0000
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
Subject: RE: [PATCH v8 0/9] Add Renesas RZ/G3E GPT support
Thread-Topic: [PATCH v8 0/9] Add Renesas RZ/G3E GPT support
Thread-Index: AQHdNKk82/tuaP9n/EeQkyuMH6xUJbbqCW1w
Date: Fri, 2 Oct 2026 06:44:21 +0000
Message-ID:
 <TY3PR01MB11346DCE43F0DBFEFF8871BC886892@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260825154847.197948-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260825154847.197948-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY3PR01MB10220:EE_
x-ms-office365-filtering-correlation-id: 7a740525-35b7-4ae8-a252-08df20509759
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|56012099006|10067099003|6133799003|38070700021|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 3Y6ZfjGXUMeJp8yHsNC7SjG62DN44D/JaZf57maPjXIyGTHR+WmtRr4X+W372V1VfKRdQ0ZEeDpZnSgkzNfkOBojFgRY3dAxbw0sf7iQLaEi1ZXnhwKWFdZAzmFBWLxX43pHZyKibgVusx45JhBW9XlUATn/tZg9wLAdUFtWgIXxgIXDjQUk5mDnN0VV+VbzSIuzkTU6Cpu7Fz4B6J1foQdAjiZJgpdClomidVVuWuH6ZkxYnXaS8ucGxU0qBLMYWi0KCCl9q9Huylp0cCx4b8DLYlwbUYFzWpi+BoMpWaUnDbTnJcXoj3pysxkqwvCkgfh/fFYufeu3N/bvcI87n4vp0jfu7Nw3By2GRkCP69jZqYL1MyFh0z6fCYJo8ioBavSe/oDfFJC+fdPh/LoqshNRKRf6MTMTt9c0bg0d1S62Pf8g7yG5IIH7MIOkAHuHzwYnDa0xok6tHiQ4Im/7kZUFNEJ6utMldtWkFNouEPUPktKgOWTljDuQFuP+KD0QWfS9oEUsZEk0jOXdgcRyiC/DiU4e/YO9XpFCNFNFDFt/UvD9t387PHbcgwgesB0i3Ohw6TAMDZFKK4O6HRxsLSFspuqdW+Jw8he6v/6QSmuTsPanQ3fBOQ/E1zsX8bjJWkz5+Qi+uIcDfj6/uF177b+/unejbVQzGI3zwQwRqJIpNbpQUvAZ9lV9v7ayYogXNA365Atl35jThcZuyelvKl9hgOGUVNVBzxXqa9qER1k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(56012099006)(10067099003)(6133799003)(38070700021)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?UcfWqVaUonow1xrsFl9DgQzO/7odoRTfZjkn+nqRq5NnTL1hurgQU8lwfC?=
 =?iso-8859-1?Q?d2rYHxccve7/NDoJL3r5eQjeCBCc3xtjZEhxF2JiBAEArio0f4dHVqtm48?=
 =?iso-8859-1?Q?UlEn0+jwUPxhB2qWvajwf0bc+Ar0ZouOcV7SmOW0u6RwlPxLg8pD8FO112?=
 =?iso-8859-1?Q?KLHq0NgPJ4CFKK6mOym9R1rpxlA2gswy/ZsyLef5hCSXyVklRtFGRXFdc+?=
 =?iso-8859-1?Q?DnepVueHs60Mmr4O/d/u/hiCSWIbC4lQf/1a8bX8o2vBASRITeIiBxXzhN?=
 =?iso-8859-1?Q?UAaF6MGRubEVp8DhKmvpeMk6V54UL2aLJVUDDCVQIPixzX/mxOFKktawky?=
 =?iso-8859-1?Q?NALpiIv7hvwJZ8qMZ/IZELh8eD1bi7Ub4LYoPKWOINXRfvFxr9i2FQR4ay?=
 =?iso-8859-1?Q?mBfGOINPsTY3Lwf2t2ER295kEdo6PPY3ATz4d2cyzIxE8JdIq6vDS4xHRa?=
 =?iso-8859-1?Q?f01R28gFQSD0kaFphNs3XHG3ot/FM7OCEVjXA//nUrX+v5zZP4wogt8OR2?=
 =?iso-8859-1?Q?DRkRFMCVXUgCG3uAaNT6eS+Ri5sBR7tbQ/t5OuJJvO800EfFKNLQKtaiB7?=
 =?iso-8859-1?Q?YOk/rsBqWM+ZmjHUUVJi68gfqCo8gaQPbyJhBe7DiMfDt7GBjG8WPoNVWe?=
 =?iso-8859-1?Q?oIDUckl33S8RH6Zd4eqjh9AvBlQ9lAHBmVN+OkOzajrZ1wKHEIZIltwtik?=
 =?iso-8859-1?Q?tPhykW11DERc/xUyyz9g1wVD+p35Db94gnjJuk8r8DKDZ5NoeuWdRi6LXs?=
 =?iso-8859-1?Q?UOAiUz55ZQs9xsztFavLAsBAEODwGiHKdTKxukP3FR+NBAexTv+R8k57Mc?=
 =?iso-8859-1?Q?IPXQ6P9iXZ4Uly7a5gSEsDJEPFBlJRGRE35XZjo/yb8yPA7Z1yre/Ixy+F?=
 =?iso-8859-1?Q?LL1saNt/PxKYAz27s+niyySalJYZiR+xVJ4olJMKcEDVS5e8hsTuuXOecx?=
 =?iso-8859-1?Q?bIljIxIRT14xR0Ct0avHOpe9x45yPEbGjB95gsiXpXFf4wkxnMEM7oQWOp?=
 =?iso-8859-1?Q?7dmsNFqk6rt9Wlg2fzEfwIKq7tSEyiOXih+7FGYP9bP0OwcNedVQQz6IXS?=
 =?iso-8859-1?Q?ibi+g/j+dVZ8wKqgc/4ofwlkkEGWqSSPU9SxwBwAqy4uL6sjA4VFQIGrNS?=
 =?iso-8859-1?Q?1j185wVZFnhrtGVrpP5pWtiCfetLzhE780dMWmCupfQ90Leq5zkgOPN+1b?=
 =?iso-8859-1?Q?GgH3V5aSWOVixikIZ6jFg/XA0Cn88hu1YrwLFJclYIh2xpyDDOvR/Noltc?=
 =?iso-8859-1?Q?G53/ydQC8TSn/0zPYkDQEShmflUoj2zM3+t89zliGRGb+2xYODqwv73e1u?=
 =?iso-8859-1?Q?dgSVJl9qwHTB/Ste0kYVZBY/7uXcIEUet8RweAskjKkCs+Ie40b36EIJxo?=
 =?iso-8859-1?Q?xZ5yssOVnT2IuPjqK8lHKvZsE1J0bYGOF17pphyT6xpwHvd7DarPE2ZzIQ?=
 =?iso-8859-1?Q?eU9frZL5eWWdlsIHGN7SSbfS3+Z8IWstCbtqdEoc/hrRwpk7km68RkHnBj?=
 =?iso-8859-1?Q?Ilr2FTCKxn+1tVmdrtKPe/FY8tDOnUoHrSugr8WC4PjRLihnzxa6y2oVYw?=
 =?iso-8859-1?Q?MpSMHvMs9oTH7y2dajE6zkqqDzNlPCG7tkcBtMheTJ4UyuVDSxI+8lNNlm?=
 =?iso-8859-1?Q?2rsL2GAqGwZoYo0GHVfGA2XEvTLq7Of6usALilYBf27MEPGmVkCUiXwMGS?=
 =?iso-8859-1?Q?jm2B8huUKgdmcsfNK8dq03d6F58EPWTt7jya0a93MiUOH1K7+UQfhOnDpZ?=
 =?iso-8859-1?Q?szKd3K1gD9WYxt4MqA9mMQZzP1nwnuITNGVgouy05NHWljafF6+31z7f01?=
 =?iso-8859-1?Q?tw6REYH1ng=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a740525-35b7-4ae8-a252-08df20509759
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 06:44:21.7666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EpkouA+PlmDW/esBlkcnV8PYxraLzIJcqMwcpnO8aGBIvbq2/SkjU2g960GdUozd0Aq3TUwditVl0XqfnJvI4jCujoAJg6tmvXcWYzAS1dc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10220

Hi All,

> -----Original Message-----
> From: Biju <biju.das.au@gmail.com>
> Sent: 25 August 2026 16:48
> Subject: [PATCH v8 0/9] Add Renesas RZ/G3E GPT support
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
> v7->v8:
>  * Cached prescale value.
>  * Updated rzg2l_gpt_write_waveform() for caching the period, If the
>    channel is already enabled and the user changes its period.
>  * Updated rzg3e_gpt_calculate_prescale() with >=3D 64.
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
>  drivers/pwm/pwm-rzg2l-gpt.c                   | 385 ++++++++++++++----
>  3 files changed, 643 insertions(+), 88 deletions(-)  create mode 100644
> Documentation/devicetree/bindings/pwm/renesas,rzg3e-gpt.yaml
>=20
> --
> 2.43.0

Gentle ping.

Cheers,
Biju

