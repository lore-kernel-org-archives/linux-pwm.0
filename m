Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793276161;
	b=1LOUaAFhPczj0nj+unV2rUAcIRN4GvxVCyWBl8SK5P7GzAY5rGpFMuAgFxldyhEUI7RC
	 G1KSkSVFD5gZLLcnHSNzhhbFsq7F6oc/xXluOndF54ztspmJoiFzisSJKNcr6rCbKq/zU
	 8XRPVEcCxq3iw6sDPpwuMS7cWqjlkc8uyBir9mpdsfhLOOyZTcWwNX5U7QqtvRp3Eka9H
	 IUOtpzYQvkH0XVP6pKiQmg+xatpH9twkSxBcs2DeZo4W5/eDhY8D+bPBwPnbTibMSuCP7
	 FFpXfsmaA7Lt+hx5SYBswDzLfULsdxTskD+Nq308IonfPSot5jSEMd4BoF5+mNu/D6A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793276161;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=4FG1lTduedfw8YECeCodWC9CEXG53o9URNot55tB6VQ=;
	b=vDmcO1pOOq17K2lP/ouAW0BddJsW9rhhgPbixl9QZTEmCRonlZyO5k6DRqCZ9w2MNhWv
	 DBI9w4uuI5HR1U+pIkGClG6kVarpfcSx1Cn/wmdluIxzZkp3NO5oBb/NDVzwsgi/CQJbb
	 wCUauXURhppCnqzPkFymCSPa4S1HRkA5YM1lnzb6RE3/We6cVv8ONENkU+n19i3R27tyj
	 vk/ebUCug9Sx0nyX4T/f50ahAx5Ap7fRqwisphaOSma2xVYNZvE/bupLHob3lD/CojlzO
	 i3eGnXlM0DaCjZN+gE982wxWGGcfsUIDpAyniwqNmutYrkfBuVM1eOKGmwlHfggpCNg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=ocxaLkDG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.16
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010016.outbound.protection.outlook.com [52.101.229.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26393606A31D;
	Thu, 29 Oct 2026 12:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26393606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=ocxaLkDG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mFn0Owr2roZU/MX8FiA+m7SUajUom7aIvJL6kczRSAUW75wGHjsw7eAqgrMtqo3YiE7n79Pp9kHZ3zzIgdOQlbaNWOR0dmwzmSJsnyoMVc3X/bNonEZaVktICoWQsXVWnEoCCgwiGcgf4mC+9eyVCak83zNWJ9WRWVtjGDVVlvE820nQKEqKvk76J49n7z3pOj4kTPTC9Sp7Gjew3vlN0Kvek6nSr41nNYf10RoO0NQ7dJs+8OSa+3BD/Br7iGqTO+5mQxmP/KerTjLlPRB6OFzhRXVjS9f9i+8DjVDoemM7ZBzvok4sCtRkRxhnx5BYSpVM9Ci+4HRFGFUNS1NZVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FG1lTduedfw8YECeCodWC9CEXG53o9URNot55tB6VQ=;
 b=tf8I/5v1N0OYS8/ilOAH7RDv28XZ4+aNq1FzMrrSIZ3GWoVf/pJdt2/GZkd1VD3FnV8m8jd0MclUOArN0iSBp/gv1jOfusrc3LO09+MuNDbtXEvSgjZDWDyl23/X7OgJYyPgpUFBDRUF3MufRRevGI31U0JJ6a2ahyPKWCU6ezXxVkYR8A/AqOHry4IeuAGrfo1fhnEhgkWaKGpNA0E/thu/dSHUK3dNP0CDJJzpmf0XJrtqqiRblt5m1sH8Pnasl0kjd/Ru9Ye9Ga1rhx7SLKmsEvlmgnQT0BrpGLLfpUezUBJjjoZYXBoyXVDr4C9w0+m6oKoByZgmo2DqxLUC7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FG1lTduedfw8YECeCodWC9CEXG53o9URNot55tB6VQ=;
 b=ocxaLkDGmFxwMqq6BA0NahZHyfo/5F4yB14lja01oDtgNN41QQVE+nqdQLJsRXHtc6JZJ0bmmUlvS2PBm24ctBHYUzujl5kp2jYNj8ft6uU2PqQ/2QiCWU/6BYkJMAGAFETc9tyMgS0aeSek39a0/OjCk+Ous28E2qiHubzj0z4=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY7PR01MB274352.jpnprd01.prod.outlook.com (2603:1096:403:409::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 12:15:57 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0546.021; Thu, 29 Oct 2026
 12:15:57 +0000
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
Thread-Index: AQHdNKk82/tuaP9n/EeQkyuMH6xUJbbqCW1wgCrLfhA=
Date: Thu, 29 Oct 2026 12:15:56 +0000
Message-ID:
 <TY3PR01MB1134645C4900EF032A3F7F594866E2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260825154847.197948-1-biju.das.jz@bp.renesas.com>
 <TY3PR01MB11346DCE43F0DBFEFF8871BC886892@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TY3PR01MB11346DCE43F0DBFEFF8871BC886892@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY7PR01MB274352:EE_
x-ms-office365-filtering-correlation-id: e6be5655-1215-4cb8-e4dd-08df35b662ce
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|38070700021|261028144727099003|11063799006|4143699003|56012099006|261009223027099003|261009221227099003|261021123027099003|261026140227099003|261026121527099003|261021121427099003|261022105027099003|10067099003|261022075727099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info:
 /B4xIujj2DrjLV8L7uxPiiVJn3WydVRbr/veVuil2F0qEQRixj+VPyD56eNsJC/smlzcWa6xvPGOrA+Ny+o1i13jUG4wHtXL9tG8xntjMIFEhaciRKpg9D0bkItC4jbmIrR1lifAMRqlH9X3LTqkrvR/dyFBs5n1VmGOKv1hvOonlLX+99GoscFCgy00fQAnqp/TXDSq6xDrO+JRqP3B8ZcbxrgsIlA9o9zyTwOSH3cL9jWtvW+4rxzLhCLwxFkmn9eodVpF6BuWeR3Htmu5tezNHWSNKH6kC8TYsCO9X+RiPvel/nr4Wk0hAuk7JDVY/+CwocjuAs5L0iU5HHQirZxZi7SQ/GqMcpcAtU4K1duwcFeaVGToyPEvDrbpLgE8qIPZoi9MegzxYIqJRTs7EEb9jBFrRzzugwSYfIBzKTTOREkba0kJW07XmXEINuc4+YbGwzKUkBWlR8DjUNHrxZ9/78t82NwTd81T7j1W37Qo122Gf9kHvGX2RjPsy0MA8aPTshQW9r9eZNFWhM1fzjodnmfMMeqC0rPTm6RmwIcjmRPQE80Sjrv3HPREIqTFfpNyv6QqqmmVGcr4HsRQ9gffDEoob4i13PaDOL26yiaGeuXHQN1aSb92lrTK+685Fh6cUcI3NkU89U4pjIi9whTeuCUTCaDxnHl6jZ9dWEw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(38070700021)(261028144727099003)(11063799006)(4143699003)(56012099006)(261009223027099003)(261009221227099003)(261021123027099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022105027099003)(10067099003)(261022075727099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?op33GOjncEIsVb0MzvxSo81PlTtX/VYtsreKaTBz2WQrLG6XEMH4Ul3Gev?=
 =?iso-8859-1?Q?MHOukOpE31xoQUkIxUbd0HyPYdwzORLmlDoJtRH/aowRTYv9qT5Rs55VhL?=
 =?iso-8859-1?Q?Nf761WKNobjXxUzvN/TOjdhnCxW3evPUjXhNLMH9TuSK5iTXV4iCEicXbx?=
 =?iso-8859-1?Q?QooI6sBwhfQ3eFRiQVLstKSIHXSDvEcZrpJO1Mfb3uoLWZpiNZWx4DSrS6?=
 =?iso-8859-1?Q?nvqFtU5iBZc0ol0/8GsKIYBxB0nPbsvmlhQSRfafs61w2+EtSzWJx8Ppom?=
 =?iso-8859-1?Q?tgh2xp+9tAzh4k6k5A1q5eXeG16AQgkLY6WbwkhxS1rToQGnsm9wl1ipAI?=
 =?iso-8859-1?Q?5quMMlY3dSn6YoRsScfpxAxYYnJMsLMy0wpieP7CA7OfQjhbDFsDNbO6r9?=
 =?iso-8859-1?Q?2+al0mJSyCp01cyYVhp7AhCURbQ5DLh0RTzVWGsyaOM89n2wuu4t17tIU6?=
 =?iso-8859-1?Q?MjcoUg3kM+MI2aKghjS+KeL/WxzVEY8g/8EwAK41GLMFITnSmT8mnwONP3?=
 =?iso-8859-1?Q?H2wVSPmso7yOPFM3y7bq8NsbBvNc9z99ZWgcz/hUB5AKx2RiSgifsDC3UM?=
 =?iso-8859-1?Q?597Ft9YBy5VrDnyjANLdzlVEZld4JiRjslQmfVoK3sCT+NchVYSMlyf/Yx?=
 =?iso-8859-1?Q?0y5XGdmztVuPZRor9ufX9ng+0whpwYPs2Yr5oxoPtxPBt41FYDml8L53ie?=
 =?iso-8859-1?Q?EgjO/mJc2Qb5xgpOAFT23DiLSIfsZJUi/4KBFe7u4Ntp6R0R5PGNF5avSm?=
 =?iso-8859-1?Q?cpvvAqJvLEQrtey+tydmIwioRhWnLwxvSzjrtrKAKQXnZ5xxABokpXrBy4?=
 =?iso-8859-1?Q?E/nyJro+WNWkRHTBENo4bB4L7NMrah+MjpTb6667+hFk+9Zi4QiPcHqsA7?=
 =?iso-8859-1?Q?uubAtSEFnC0LWYnyZFQuxyILkabaDanBhNn5yE1iJOC0MBAfXuUIS+oDTn?=
 =?iso-8859-1?Q?rZHn9cfg6+SNoRRoAS/VdXnxW03A6N8OhXV7GK5qyIS4gePTGKYMi0zN1V?=
 =?iso-8859-1?Q?NjroYnaEwMuqgXyvvDlimgR7WJBWcwqdXXLiiWlQLec4uiD+oXRod1Qydc?=
 =?iso-8859-1?Q?EzVsUy/nlj3tn/KRnb3YqRS5Gom4gWMSKkn3A0jBHiczc18CXCVnAvCj+V?=
 =?iso-8859-1?Q?gH9QXU8/EPBy35FuMqHbj1DZD3ctghv21VWHZyTDMGxu+cmG0KhVdruwSM?=
 =?iso-8859-1?Q?2/z2XQZFj9ETLRpWinMnncfgDDAJvP/Z1Wsv9fyr9itAZb4TJ1CNR0WnmL?=
 =?iso-8859-1?Q?QfJ94uYOqQuhvXHt/y7tnlUWt+F/vKbKylUm+bre7ncmEffEt88S+vgme7?=
 =?iso-8859-1?Q?I4VSlWq683mLU0VJcrMf6eGOdG6iarMBafXbzrPS+nYUd1/pJXEY6YPHK1?=
 =?iso-8859-1?Q?dV9Wg2g/xr7ft6nqNSenTIBoDBIm2BzUwAMjfxc3Eenma7bbn0aipIQbMg?=
 =?iso-8859-1?Q?q/8CCNOjYRmO0j5qbXAp+cBftO7VfF+Kmuf6d7Vv7c3ZqXtMht/RC4hhXm?=
 =?iso-8859-1?Q?+69J+DDk8sM1mPVG9pDvfQ7Brirk3yQBpAABMViXg2Hcg27wOTvBfe8Jzn?=
 =?iso-8859-1?Q?9h8wc/PrKQPt2i5PsG4xvtcen5e4VyXj+SXZy3+cz/suIAX7G/ToTClDV/?=
 =?iso-8859-1?Q?lAt2daUysXeNv3ms4HXU1WY9qqGYmU3JRU+Eqp54LHFricsW5QZaGXzfwb?=
 =?iso-8859-1?Q?fGpCt2tw/S+4nj17vIh+I77qviT1z2unc8y0LjDg64spC1GJGgkIA6QDj1?=
 =?iso-8859-1?Q?Rn8R2cK7uCc65m5yy1fqtk2knlYSxIGnANTVlRUDY1nLJW7umM2KwbDlP+?=
 =?iso-8859-1?Q?rb3MEWNrRQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6be5655-1215-4cb8-e4dd-08df35b662ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2026 12:15:56.7590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JbhA9lTeUj1mTe7nY7lINO3Yap/pPtT66i1VNLyPQq7w9xcFgJ0RUXIoywgQea+ZbMBCTK0j3dErLe/FYOXQ0CPHdkKvTmd/Pdnzd0HKBNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB274352

Hi All,

I will be sending new version fixing sashiko review comment.
https://sashiko.dev/#/patchset/20260825154847.197948-1-biju.das.jz%40bp.ren=
esas.com

Cheers,
Biju

> -----Original Message-----
> From: Biju Das
> Sent: 02 October 2026 07:44
> Subject: RE: [PATCH v8 0/9] Add Renesas RZ/G3E GPT support
>=20
> Hi All,
>=20
> > -----Original Message-----
> > From: Biju <biju.das.au@gmail.com>
> > Sent: 25 August 2026 16:48
> > Subject: [PATCH v8 0/9] Add Renesas RZ/G3E GPT support
> >
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > This series extends the RZ/G2L GPT PWM driver with RZ/G3E SoC support.
> >
> > The RZ/G3E GPT has a number of hardware differences compared to RZ/G2L:
> > it exposes 16 channels (across two GPT instances of 8 channels each),
> > uses a 4-bit GTCR prescaler field (versus 3-bit on RZ/G2L), and has a
> > discontinuous prescale sequence with powers-of-2 scaling rather than
> > the continuous powers-of-4 sequence on RZ/G2L. It also has additional c=
locks and resets (bus clock and
> rst_s).
> >
> > v7->v8:
> >  * Cached prescale value.
> >  * Updated rzg2l_gpt_write_waveform() for caching the period, If the
> >    channel is already enabled and the user changes its period.
> >  * Updated rzg3e_gpt_calculate_prescale() with >=3D 64.
> > v6->v7:
> >  * Reordered the patched moving POEG support to last.
> >  * Replaced USEC_PER_SEC->NSEC_PER_MSEC for period/duty cycle
> >    conversion.
> >  * Avoided recalculation of prescale, if is_small_second_period =3D=3D =
true.
> >  * Moved `wfhw->gtccr =3D 0` into the if block in rzg2l_gpt_config().
> >  * Added rzg2l_gpt_poeg_link_channels() and used __free for deallocatin=
g
> >    device node pointer.
> >  * Replaced dev_err()->dev_err_probe() in rzg2l_gpt_poeg_link_channels(=
).
> >  * Replaced local variable cells with num_poeg_pairs in
> >    rzg2l_gpt_poeg_init().
> > v5->v6:
> >  * Added patch for fixing period_ticks overflow.
> >  * Added patch to add missing newlines to dev_err_probe() messages.
> >  * Dropped extra space in poegs variable assignment in
> >    rzg2l_gpt_poeg_init().
> >  * Updated the comment sections of rzg2l_gpt_poeg_init() with POEG and =
GPT
> >    in upper-case and replaced configure->configures.
> >  * Format specifiers in dev_err() changed from %d to %u in
> >    rzg2l_gpt_poeg_init().
> >  * Dropped local variables pv and dc from rzg2l_gpt_round_waveform_tohw=
().
> >  * Dropped blank line in rzg2l_gpt_round_waveform_tohw().
> >  * Moved assignment of rzg2l_gpt->period_ticks[ch] to *_write_waveform(=
).
> >  * Restored clamping of duty_ticks with period_ticks in
> >    rzg2l_gpt_round_waveform_tohw().
> >  * Simplified rzg2l_gpt_write_waveform() using else if statement.
> >  * Dropped local variable gptr in rzg2l_gpt_write_waveform().
> >  * Moved mutex after early return in rzg2l_gpt_round_waveform_tohw().
> >  * Dropped extra parameter rzg2l_gpt from rzg2l_gpt_calculate_prescale(=
)
> >    in rzg2l_gpt_round_waveform_tohw().
> >  * Updated comment in rzg2l_gpt_calculate_period_or_duty().
> >  * Updated rzg3e_gpt_calculate_prescale().
> > v4->v5:
> >  * Merged GPT linking POEG patch series here.
> >  * Dropped suspend/resume patch; will be added later.
> >  * Updated commit description for patches #2, #4, #5, and #6.
> >  * Replaced return type of rzg2l_gpt_poeg_init() from void to int and
> >    probe() check this return value.
> >  * Added more error checks in rzg2l_gpt_poeg_init().
> >  * Added a patch to drop the unused rzg2l_gpt_chip parameter from
> >    rzg2l_gpt_calculate_prescale().
> >  * Updated rzg2l_gpt_round_waveform_tohw() to initialize gtccr when the
> >    period of the second channel is smaller.
> >  * Replaced period_ticks with RZG2L_MAX_TICKS for the duty_ticks maximu=
m
> >    value check in rzg2l_gpt_round_waveform_tohw().
> > v3->v4:
> >  * Added wave form callback conversion back to this patch series.
> >  * Updated rzg2l_gpt_is_ch_enabled() fit into 80-character limit for
> >    consistency with other functions.
> >  * Dropped field_{get,prep} as mainline now support it.
> >  * Updated commit description for patch#3
> >  * Retained RZG2L_GTCR_TPCS bit definitons
> >  * Replaced gtcr_tpcs_mask->gtcr_tpcs
> >  * Updated commit header and description for patch#4
> >  * Renamed prescale_pow_of_two_mult_factor->prescale_mult
> >  * Added RZG3E_GTCR_TPCS bit definition for RZ/G3E and added to
> >    rzg3e_data.
> >  * Added error checks on suspend() and device set to operational state
> >    on failure().
> >  * Added Rb tag from Geert for SoC dtsi.
> >  * Added SW_GPIO9_CAN1_STB check to gpt0 node.
> > v2->v3:
> >  * Added Rb tag from Rob for bindings patch
> >  * Dropped wave form callback conversion from this patch series as
> >    it is covered in another series[1]
> >  * Added suspend/resume support.
> > v1->v2:
> >  * Created separate document for RZ/G3E GPT.
> >  * Updated commit header and description for binding patch.
> >  * Added waveform callback conversion to this series.
> >  * Collected tag.
> >  * Added link to hardware manual
> >  * Updated limitation section in driver patch.
> >
> > Biju Das (9):
> >   pwm: rzg2l-gpt: Fix macro used for period/duty cycle conversion
> >   pwm: rzg2l-gpt: Convert to waveform callbacks
> >   pwm: rzg2l-gpt: Add info variable to struct rzg2l_gpt_chip
> >   pwm: rzg2l-gpt: Add prescale_mult variable to struct rzg2l_gpt_info
> >   pwm: rzg2l-gpt: Add calculate_prescale() callback to struct
> >     rzg2l_gpt_info
> >   dt-bindings: pwm: Document RZ/G3E GPT support
> >   pwm: rzg2l-gpt: Add RZ/G3E support
> >   dt-bindings: pwm: rzg2l-gpt: Document renesas,poegs property
> >   pwm: rzg2l-gpt: Add support for gpt linking with poeg
> >
> >  .../bindings/pwm/renesas,rzg2l-gpt.yaml       |  23 ++
> >  .../bindings/pwm/renesas,rzg3e-gpt.yaml       | 323 +++++++++++++++
> >  drivers/pwm/pwm-rzg2l-gpt.c                   | 385 ++++++++++++++----
> >  3 files changed, 643 insertions(+), 88 deletions(-)  create mode
> > 100644 Documentation/devicetree/bindings/pwm/renesas,rzg3e-gpt.yaml
> >
> > --
> > 2.43.0
>=20
> Gentle ping.
>=20
> Cheers,
> Biju

