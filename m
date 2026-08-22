Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011069.outbound.protection.outlook.com [52.101.125.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F4E349CE8;
	Sat, 22 Aug 2026 07:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787385281; cv=fail; b=sIpQ74tufmKy71Ajqwd/b+S4q0L/hdnW4f3ZQKMRxYQV9vv7oqGWzsGEFiWmFjETg9c+xiNJXdRehsDQhlhi2eOACOcQzhBP4zhRm3IXXCdqxyCZLylfWRNT7nmOjfFBA7feAFH8JxlUPx1RUlYTipPVVu5puQKzUsyrNtE1+xY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787385281; c=relaxed/simple;
	bh=gGP69/UTSrhiiCo9knJeL4RAr06d1XenrPsrXzHySnY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XldGElAt9unGc44Lfss7L7hUNwz7txPecI+FfJGANrmv9lpLgdIwuKglG4KBJASqL5V794bDmKNktMyHQwoq++iSWNApSDPM9RsAC6/Kx9mVGhue0Ay9meAcGqA7/VZo+yCWFaH2bU5bSMd/UspyMEvH3VY7Kas5kDT5sfDbwc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=A99d9SLT; arc=fail smtp.client-ip=52.101.125.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="A99d9SLT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZL4ULAE5k9K9PODEiq9DfdNP2oEtHHRCv7FbkPRO/4F5cS0PQbTRBzpppXKIeUOanQL0ToWkxsIZsuPG8N+VK07FKW9PpeikJamxsV3Lynapa2iXkFUx24OjBZunRBUfEb2EYOcmJPsLWxeKAqpbILBBLNz1uUbZgkc66rwmKOiRcJQf0odFrVEbKkwF5/WS9d3WKII6rd5PidiyrdHIGwhDlFXR4VFeYmoqJUhCtuZQRHkBFxf1qsGVDhfpNNS6/yM5e4hBGFPqYN1Jhfdzs/4GFvFetqBsZroZdIT5PtbRs6zMXkruAaotAv5NRSG512eZboZT3gTWE8F7MQcU5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGP69/UTSrhiiCo9knJeL4RAr06d1XenrPsrXzHySnY=;
 b=itNjEZYNxvIHfWkiSNdO2+4GGLxGms3z0pADGWXeh7D79N4lLEvIrI16EcJafDd+nN0UQDslkN5ihOwPi07Z+OoeYohsy9PFhJEbvK3I5/B4fW7q1MlMku/LlHGXk77/rKT57YufQPKC69QfPlGYUOnCSqj1Go+aj8wm/9FoME6IlCEA534bi7J1GAxXDfOdizdmUnEDJ4shq8J4359VKA0yB8L6SjoNqufOw0j7jkCbrlCkVFvgsG0FaUiSuh0ibjuw0UaQVlK6qfWdMitCs5XJ/pVxpLmwy+ANGuiBipKXcrZUhRGVzGNJbIPkXE8Mr3uY+ABTZ0tzCMUWiJqxuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGP69/UTSrhiiCo9knJeL4RAr06d1XenrPsrXzHySnY=;
 b=A99d9SLTi5UEE4aKngRmcbq+NvBD8gZCyDiHGqupttqp1YzzhanlRZE3s1dqIeH2B1r1XCV/EXUt70HUTqHuIV0yS3mNs020zljFdmvb19l/TUwnpK5FAmVVLDnLM0MzrYmaH3kWMfJanrjtzF/vO2yc0hFOhJklQCAD/+Ueg6U=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSZPR01MB9519.jpnprd01.prod.outlook.com (2603:1096:604:1d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 07:54:35 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0339.010; Sat, 22 Aug 2026
 07:54:27 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "biju.das.au" <biju.das.au@gmail.com>,
	=?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@baylibre.com>
CC: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
	"robh@kernel.org" <robh@kernel.org>, wsa+renesas
	<wsa+renesas@sang-engineering.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v6 02/11] dt-bindings: pwm: rzg2l-gpt: Document
 renesas,poegs property
Thread-Topic: [PATCH v6 02/11] dt-bindings: pwm: rzg2l-gpt: Document
 renesas,poegs property
Thread-Index: AQHc9Ah7y9VZk+j+YEifAJ7ShMwOEraXYPY/gBLMTCA=
Date: Sat, 22 Aug 2026 07:54:26 +0000
Message-ID:
 <TY3PR01MB11346EDD83D9CA3F3252D48F586A22@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260604095647.108654-3-biju.das.jz@bp.renesas.com>
 <20260604100619.75EC51F00893@smtp.kernel.org> <aliM3iVA1LY7tW38@monoceros>
 <CADT+UeB-gV8QnuwpTUrHV-GvYPwebYg=RE68PcApZkACO4ENDw@mail.gmail.com>
In-Reply-To:
 <CADT+UeB-gV8QnuwpTUrHV-GvYPwebYg=RE68PcApZkACO4ENDw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSZPR01MB9519:EE_
x-ms-office365-filtering-correlation-id: adcb86a9-21db-4655-96e6-08df002296d6
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|11063799006|3023799007|56012099006|6133799003|10067099003|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 VKV2ekKpnlQWDjtPuB9ZlZsnstLHlOorg4KLJnoTAd2pi+3G/bDvPjdhNuEyionlvxXGhwwGiiTQvfUWG8INYQfisO+bk2qWTkssUAt8tNfMqrSj2REow2XNjbgj/b+lAkDnONNDSoszF8+xYl5gROOzUilwUtydK4tpWoTqQOmcvIgwSxj32KSBlG6scMjmhZwoMF+MiejtYCcQMP7/NV254ujfefZHn9s4OqDyGeT8DYLni99zqv6w4ZBG8/PyNyXaXHT8IPlkO/RECYhOhGqaYPuhZoE0/rGXNaPIG9HIPIP9uX9z4TG+phie+2EDN2iOPvyrVzUZ6LmFXkewDKWP1G5nn3C+75A1YkS5QIXUV4amHYQHfJGrF7Ge3UOJ0JLjNgtiuRV+Y3fW80lNOmBHHDmnLHggrrzVJISwMBNwBJN3+JUfKaV0O8j36llqAuoZZOFrJ8NnZfQaNK0FRL23e8rE3S78HdXryb7vUujgkifq9eIiMOGFsg6LA4hqiRBF/6aL/MeWPIXW245dSL0+Arq+O+o1LTcgE+wruoKA4acZzQEOC4oZxI0PeO1NK9ATNhcv1e8dzi5QjJbvEl05sWodn0CGkSFRP/Ap273JC4NBtM9U7kwX0fXU1Oof2Z3kRcWAIXhbwPJDXDarnzhKyG/NvvRkuY2XiRoiw7gd/KLXXtnRteZtU9zYtxk1oc0fnlNFkrjQgy0mOIp6CMf4JoclZn5K99DwL9IdTAs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(3023799007)(56012099006)(6133799003)(10067099003)(4143699003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Rk85cDU2YzBIYTl3WkJZUloxWDlkNmZVV2xvUEpVZDg0ZnRpUW40WitRaWNO?=
 =?utf-8?B?Zm1iQTQvaUkxOC9iMXV6M0ZKVHhWVVdVbTRQaTVybG1KK042dml6bURoSE11?=
 =?utf-8?B?ZDBnWkVySnh3Qk5Hb1F4RFVadFdVZm1rM01UdTdWMGJEUHBUTnlyVWxVdFhZ?=
 =?utf-8?B?WG11b1dqUkZvaGtnMndLK29CcE5GeStLamdlTGcxY1BiNG0rZTBFTE9vR1Qx?=
 =?utf-8?B?bDdKTEE0OFZXQU5QZE1ZY1JtL1JDaGZIVm10SUxLd25BRVN3KzFpRnFtWUlo?=
 =?utf-8?B?VkdsYXBHRDBZdGlaWkJIUDJrZkJzTVAwNWNsVlQ1NzZ3Z1lQWWMyYkNaaEdW?=
 =?utf-8?B?U3F1T0dEcms3T0RXT3lpNmFxcDAzUnFXd2pxNEVnbVArSlNUeGFJV3B3ZHZk?=
 =?utf-8?B?SHl0ZysxQmhzdkFPaGo4V0lYblYxSFJJbklPOFI0Tmo4T2VTay9VVUdEUEhz?=
 =?utf-8?B?RjdIUXdrQmlPeFBudVEvREMzUUdwVCs2eTg3YVd6UjY5WXdLbXVGZ3lGOXZN?=
 =?utf-8?B?QUZubnRkdm5SKzJTaU5oQnlpNStRNmVkZEtra21ScjFzaytMMGRvWGo1dnVR?=
 =?utf-8?B?TjQxZFRmWnRSb0hJQzFFQjhQczNyT05RZ0QwZ1k2VjR1TmYxN2o3Y09DZXAz?=
 =?utf-8?B?YlA1dlQ3QUxCeU8zRDdvL3RBODdkc2FvbVdxc2V6WVhscFpzREZYQlYzbU5k?=
 =?utf-8?B?K3B0bDJtZGpqeStBVU9GY1A3TVhNRUY3Z0ExdFNrUk15eFVtWUFUSzIzNWR1?=
 =?utf-8?B?alpHT2o1a3N3WjM0OUtRQk1SMXJRMGhQTlF4WitDbHk5c001NGF1U2hmUUNw?=
 =?utf-8?B?SElOQ09Hcm1OM0o0bGd2bXE2NXN4dUMzdGUyaXhnTHNhZy9JTlRCZ2ZyOHh4?=
 =?utf-8?B?bi9VQXkzVWdVaTV5dzQzVkt3U3YzeTg5ak5KRUI5SmhRV2RPNy9VM29PemtS?=
 =?utf-8?B?aDU2MG9ENmp4MjdDQjduU2RCMWxxbDJQUCttbUVNT240RDRCcjRXUk4rdnVs?=
 =?utf-8?B?ZDhZL3g5MGZsOVQwMDZwV1Q1VHYwMVU5b0FzMyswajJmNGFrRWhHUHZkWmpZ?=
 =?utf-8?B?TEdNN3B4dGhVM285M0dGbkdYbThaWFpiaGtuWXh1dk9mencvazcxQ1VYcW9H?=
 =?utf-8?B?SDN3MnpOczE0SnJOZDhtMFp2bGg0TldZNkhXZElnczdiQWxZTk1JR0dHTzRR?=
 =?utf-8?B?SGlvNGVRZGovcS9GL3dkcmQ0WXQ2Nkx5aTFVa3NTM2xkMGx0Tm1GTlVMSUhi?=
 =?utf-8?B?Tmg2M3VqdEk0Y1FWVkhHZHVBOU5wcXpKSmFYWTlyTmt0WUVoODMyNG13QmhM?=
 =?utf-8?B?OThxRlUwUEVBRk5kY3YrMUw3bnVhNEc1R2VpbHVoeDhIZUJZT2pCS3dFZWNq?=
 =?utf-8?B?L3JBMnczQ2dtNkE1TkxoM09tYzVHSGxPTXpaS3hpWkN0aDV0cXJFR2pWbk5O?=
 =?utf-8?B?T000SVZ3TDZPRUx4V2JOVFQwMmdVb0MyOWpaeTYyZ082dmxYanppNnRYbXJU?=
 =?utf-8?B?OHluNEhGYk1KZ2hCUzB5RStWbW11eVFTVW9zdTlUeURGdmdLaTFtQUFodVUx?=
 =?utf-8?B?SmRXTVUvTGNnQ3NMelM1d2FaeWhBZ3M2RGovMHREWGRrRTZVMVdGTWNZdTd0?=
 =?utf-8?B?VTFmaUU2RnFseTVIaE1TSTIvZ0NVY0pwTkZqWTJRUHRQVFVUd1NRcktaK0RW?=
 =?utf-8?B?bUQyNnN2bGZLU29RSnkxNjFQc2QyTWRBTjJDcXBiSWxGaFg5S0ZMSEN2b2lT?=
 =?utf-8?B?ZDlmM2RSUFR2bUc0dlg5b0JqdVFqbHdGQTFPR21kM3kvZGZXWEdDdExUdkxr?=
 =?utf-8?B?bzVVYit6d0xJRjNXSkh1UFpGWnEwZSs0SDJjMUZDYXJieHZGdi9aaGwwZWg3?=
 =?utf-8?B?ZTdvWkZiV1NUYVB4MlFYMXUyOUR6Nm9ta01LTlBDeFZ2YzZ6dXk2RGRGaUIw?=
 =?utf-8?B?NkgwRE9GbDRJSUhkZHFCa1BDMjdpKzltc3RETlJoaUM5U0Q3L3g1TjRBeDVm?=
 =?utf-8?B?d0ZXYW5VODYvaHo1ZllwS0JTZ2RyV1NiZFpJWXB1YkJRWFh5QkhBa1V3azZO?=
 =?utf-8?B?UVZJaVJ2N0dnZ3pHVWNEUjVXQzhheDZ2VkNpKzNjTGZENEMvNWp0T1JkL2lX?=
 =?utf-8?B?TVU5WVplMlpxR2lEcE5vbm8rZ1JDeEJNSVdaY0c0czFENzlCMllGTDRYd0dL?=
 =?utf-8?B?c1FmS1g3QVZET3ZMeituUWhtMkhjN1NVaFk4ZW8xYmZuOWRzQ1gzdFJ6ak9B?=
 =?utf-8?B?aWZ0L1hWNnk3L2tZVzlsNnV3eElodlU2L2JNVzlsMHJWRmN0elJaUWVLK1JO?=
 =?utf-8?B?dWNuM2VkeE9wVWp4Qjl0djliOHE3VHJxYU4xOUpURG5QSW8xbUc2UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adcb86a9-21db-4655-96e6-08df002296d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2026 07:54:26.8358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e2GkteABJkCf0JsVb1+fCL+YZg09vprVEUfyJewhJe0kKFZcV/7YfDvuf6mL2TIepcWyA0Y+HYlEVRwB861mSRlF7cA9l7o2UkO/u6w78Ak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9519

SGkgVXdlLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJpanUgRGFz
IDxiaWp1LmRhcy5hdUBnbWFpbC5jb20+DQo+IFNlbnQ6IDEwIEF1Z3VzdCAyMDI2IDA5OjQzDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMDIvMTFdIGR0LWJpbmRpbmdzOiBwd206IHJ6ZzJsLWdw
dDogRG9jdW1lbnQgcmVuZXNhcyxwb2VncyBwcm9wZXJ0eQ0KPiANCj4gSGkgVXdlLA0KPiANCj4g
SSBoYXZlIGNsYXJpZmllZCB0aGUgdXNlIGNhc2Ugd2l0aCBSb2Igb24gWzFdLCBhbmQgaGUgYWNr
ZWQgb24gWzJdIC4NCj4gU2VlIHRoZSBkZXRhaWxzIGJlbG93DQo+IA0KPiBbMV0NCj4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL09TMFBSMDFNQjU5MjI3NTZGMTgzNkFBQUJGRjYyQzA0Nzg2
MDQ5QE9TMFBSMDFNQjU5MjIuanBucHJkMDEucHJvZC5vdXRsb29rLmNvDQo+IG0vDQo+IFsyXSBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMjEyMTUyMDU4NDMuNDA3NDUwNC0zLWJpanUu
ZGFzLmp6QGJwLnJlbmVzYXMuY29tLw0KDQpJcyBpdCBvaywgaWYgSSBkcm9wIHRoZSBQT0VHIHN1
cHBvcnQgYXMgZmV3IFNvQ3Mgc3VjaCBhcyBSWi9UMkggYW5kIFJaL0czTCBuZWVkcyBQV00NCmFu
ZCB0aGlzIHBhdGNoIHNlcmllcyBpcyBibG9ja2luZyB0aGVtLiBMYXRlciBJIHdpbGwgc2VuZCBw
YXRjaCBmb3IgUE9FRy4NClBsZWFzZSBsZXQgbWUga25vdy4NCg0KTm90ZToNCk5vdywgUE9FRyBk
cml2ZXIgZXhwb3NlcyBhIHNpbXBsZSBjaGFyIGRldmljZS4gVXNpbmcgd3JpdGUgd2UgY29uZmln
dXJlIGl0Lg0KDQpDaGVlcnMsDQpCaWp1DQoNCj4gDQo+IENoZWVycywNCj4gQmlqdQ0KPiANCj4g
T24gVGh1LCBKdWwgMTYsIDIwMjYgYXQgODo1MOKAr0FNIFV3ZSBLbGVpbmUtS8O2bmlnIDx1Lmts
ZWluZS1rb2VuaWdAYmF5bGlicmUuY29tPiB3cm90ZToNCj4gPg0KPiA+IEhlbGxvIFJvYiwNCj4g
Pg0KPiA+IE9uIFRodSwgSnVuIDA0LCAyMDI2IGF0IDEwOjA2OjE5QU0gKzAwMDAsIHNhc2hpa28t
Ym90QGtlcm5lbC5vcmcgd3JvdGU6DQo+ID4gPiBUaGFuayB5b3UgZm9yIHlvdXIgY29udHJpYnV0
aW9uISBTYXNoaWtvIEFJIHJldmlldyBmb3VuZCAxIHBvdGVudGlhbCBpc3N1ZShzKSB0byBjb25z
aWRlcjoNCj4gPiA+IC0gW01lZGl1bV0gVGhlIGByZW5lc2FzLHBvZWdzYCBwcm9wZXJ0eSBpbXBy
b3Blcmx5IGVuY29kZXMgdGhlIGNvbnN1bWVyJ3MgY2hhbm5lbCBpbmRleCBhcyBhIHBoYW5kbGUN
Cj4gc3BlY2lmaWVyLCB3aGljaCBpcyBhIERldmljZXRyZWUgYW50aS1wYXR0ZXJuIGFuZCBicmVh
a3Mgc3RhbmRhcmQgcGhhbmRsZS1hcnJheSBwYXJzaW5nIHNlbWFudGljcy4NCj4gPiA+IC0tDQo+
ID4gPg0KPiA+ID4gY29tbWl0IDlkN2Y5ODQ3ZDNmMzIwZmI3MTUwMjJiNjE1OWM5YzdlODY5YWVl
ZGQNCj4gPiA+IEF1dGhvcjogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0K
PiA+ID4NCj4gPiA+IGR0LWJpbmRpbmdzOiBwd206IHJ6ZzJsLWdwdDogRG9jdW1lbnQgcmVuZXNh
cyxwb2VncyBwcm9wZXJ0eQ0KPiA+ID4NCj4gPiA+IFJaL0cyTCBHUFQgSVAgc3VwcG9ydHMgb3V0
cHV0IHBpbiBkaXNhYmxlIGZ1bmN0aW9uIGJ5IGRlYWQgdGltZQ0KPiA+ID4gZXJyb3IgYW5kIGRl
dGVjdGluZyBzaG9ydC1jaXJjdWl0cyBiZXR3ZWVuIG91dHB1dCBwaW5zLg0KPiA+ID4gQWRkIGRv
Y3VtZW50YXRpb24gZm9yIHRoZSBvcHRpb25hbCBwcm9wZXJ0eSByZW5lc2FzLHBvZWdzIHRvIGxp
bmsgYQ0KPiA+ID4gcGFpciBvZiBHUFQgSU9zIHdpdGggUE9FRy4NCj4gPiA+DQo+ID4gPiA+IGRp
ZmYgLS1naXQNCj4gPiA+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdt
L3JlbmVzYXMscnpnMmwtZ3B0LnlhbWwNCj4gPiA+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcHdtL3JlbmVzYXMscnpnMmwtZ3B0LnlhbWwNCj4gPiA+ID4gLS0tIGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9yZW5lc2FzLHJ6ZzJsLWdwdC55YW1s
DQo+ID4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vcmVu
ZXNhcyxyemcybC1ncHQueWFtbA0KPiA+ID4NCj4gPiA+IFsgLi4uIF0NCj4gPiA+DQo+ID4gPiA+
IEBAIC0yNDUsNiArMjQ1LDI4IEBAIHByb3BlcnRpZXM6DQo+ID4gPiA+ICAgIHJlc2V0czoNCj4g
PiA+ID4gICAgICBtYXhJdGVtczogMQ0KPiA+ID4gPg0KPiA+ID4gPiArICByZW5lc2FzLHBvZWdz
Og0KPiA+ID4gPiArICAgIG1pbkl0ZW1zOiAxDQo+ID4gPiA+ICsgICAgbWF4SXRlbXM6IDgNCj4g
PiA+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9waGFuZGxl
LWFycmF5DQo+ID4gPiA+ICsgICAgaXRlbXM6DQo+ID4gPiA+ICsgICAgICBpdGVtczoNCj4gPiA+
ID4gKyAgICAgICAgLSBkZXNjcmlwdGlvbjogcGhhbmRsZSB0byBQT0VHIGluc3RhbmNlIHRoYXQg
c2VydmVzIHRoZSBvdXRwdXQgZGlzYWJsZQ0KPiA+ID4gPiArICAgICAgICAtIGVudW06IFsgMCwg
MSwgMiwgMywgNCwgNSwgNiwgNyBdDQo+ID4gPiA+ICsgICAgICAgICAgZGVzY3JpcHRpb246IHwN
Cj4gPiA+ID4gKyAgICAgICAgICAgIEFuIGluZGV4IGlkZW50aWZ5aW5nIHBhaXIgb2YgR1BUIGNo
YW5uZWxzLg0KPiA+ID4NCj4gPiA+IFtTZXZlcml0eTogTWVkaXVtXQ0KPiA+ID4gRG9lcyB0aGlz
IHByb3BlcnR5IGNvcnJlY3RseSBmb2xsb3cgc3RhbmRhcmQgRGV2aWNldHJlZSBwaGFuZGxlIHNl
bWFudGljcz8NCj4gPiA+DQo+ID4gPiBCeSBEZXZpY2V0cmVlIHNwZWNpZmljYXRpb24sIHBoYW5k
bGUgYXJndW1lbnRzIGluIGEgcGhhbmRsZS1hcnJheQ0KPiA+ID4gYXJlIGRlZmluZWQgYW5kIGlu
dGVycHJldGVkIGJ5IHRoZSB0YXJnZXQgcHJvdmlkZXIgbm9kZSwgd2l0aCB0aGVpcg0KPiA+ID4g
bGVuZ3RoIGRpY3RhdGVkIGJ5IGEgY2VsbC1jb3VudCBwcm9wZXJ0eSBvbiB0aGUgcHJvdmlkZXIu
DQo+ID4gPg0KPiA+ID4gVGhpcyBkZWZpbml0aW9uIGFwcGVhcnMgdG8gaW52ZXJ0IHRoYXQgbW9k
ZWwgYnkgdXNpbmcgdGhlIHNwZWNpZmllcg0KPiA+ID4gdG8gZW5jb2RlIHRoZSBjb25zdW1lcidz
IChHUFQpIG93biBjaGFubmVsIGluZGV4IHJhdGhlciB0aGFuIGEgcHJvdmlkZXIgYXJndW1lbnQu
DQo+ID4gPg0KPiA+ID4gQWRkaXRpb25hbGx5LCBzdGFuZGFyZCBPUy1hZ25vc3RpYyBEVCBwYXJz
ZXJzIG1pZ2h0IGZhaWwgdG8gcmVzb2x2ZQ0KPiA+ID4gdGhpcyBiZWNhdXNlIHRoZSByZWZlcmVu
Y2VkIHByb3ZpZGVyIGJpbmRpbmcNCj4gPiA+IChyZW5lc2FzLHJ6ZzJsLXBvZWcueWFtbCkgZW5m
b3JjZXMNCj4gPiA+IGFkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZSBhbmQgbmF0aXZlbHkgbGFj
a3MgYSAjcG9lZy1jZWxscw0KPiA+ID4gcHJvcGVydHkgdG8gZGljdGF0ZSB0aGUgc3BlY2lmaWVy
IGxlbmd0aC4NCj4gPiA+DQo+ID4gPiBJcyBpdCBwb3NzaWJsZSB0byByZWRlc2lnbiB0aGlzIGJp
bmRpbmcgc28gaXQgZG9lc24ndCBlbmNvZGUgdGhlDQo+ID4gPiBjb25zdW1lcidzIGluZGV4IGlu
dG8gdGhlIHByb3ZpZGVyJ3MgcGhhbmRsZSBhcmd1bWVudCwgb3IgYXQgbGVhc3QNCj4gPiA+IGVu
c3VyZSB0aGUgUE9FRyBwcm92aWRlciBzcGVjaWZpZXMgYSAjcG9lZy1jZWxscyBwcm9wZXJ0eT8N
Cj4gPg0KPiA+IFlvdSBhY2tlZCB0aGUgcGF0Y2guIElzIHRoYXQgcmV2aWV3IGNvbmNlcm4gYnkg
U2FzaGlrbyB2YWxpZD8NCj4gPg0KPiA+IEJlc3QgcmVnYXJkcw0KPiA+IFV3ZQ0KDQo=
