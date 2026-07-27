Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010013.outbound.protection.outlook.com [52.101.228.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645343F4DD1;
	Mon, 27 Jul 2026 10:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146929; cv=fail; b=o7ZZGFyPLaAW9OAsmscWgJFkUiB4IFCnZRh5cYSoD2rNXTI3CjkSpRfczAvmajjdSFi8fmcp6Gt4vzMZdZ15JQp9CjWpXm9bDAy1YxxjLHRj4c/YvPNnVRbQaCYThyYcZJFwA9x2j3kY+OfDeSXQS5brU1hX+dCJfwCFR8m3N2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146929; c=relaxed/simple;
	bh=yIMei5cYIEpPqslv1QrlyBJXrTkHZwmlfKHW+RSDswQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P9f47xDytoob9W6D3l8PNzY96ctfYGLj2GDhJ9uz/+J092zfx7+KKNlvxHpbSp/nBH0qPInhk6p8zd1W57RdnXOfYjA3gR6c46TJLQqlMkGPL7V6tiQSqKtaIZlhm7dYv1hlfj4BeOvXOZtPxYDwyx1IOFI2SBenFCCBiVLEL9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=bk2hQkNT; arc=fail smtp.client-ip=52.101.228.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="bk2hQkNT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYD+9TH2POK4HZsU+f770hbq5udAyCgT99sGT4dXad3Y7id8v9GQJH/+OCJVmPq7u4Zn31HDh2mIOmgnd3Bfk1+Z4YXSTru8vkN8ZdQ1Z51IyRYMOhLF0uE72NyahqjP/+bggur5nx/qU+sYJ/bmT+nK8aHiZgEvu8xmngGo4xBb+z/prEdm93HYVnpiaIY0LXhtDy3GiYrffVxsGf/rk+tK07xI+skB2R14qndEV8WrwUEi8dGroHz5GEqJNSiGOXxHSAY+dB5PJyN8MVSYo+8yOjEKF8fZWea7tr6LIJtr6ohp25YEwmuyJYj5rGTHpVqKw1rupseUmmX/pOe3QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIMei5cYIEpPqslv1QrlyBJXrTkHZwmlfKHW+RSDswQ=;
 b=ie28prsf0N//d7tTDJEL3aPqjUEJCNneK5viKsAuua1AFUI/H8jdmBg1H4JZ5VKmhd/cbz470lkH3my7uQn6v1RhwBKa6yR+5/PJ6pB//kJGFUFIFRiU2I2zfWvG/xWjBwVMV5LRbdQWex3KlGDk+dBgvDfIYea7PH971jbxHanuUHTzut3WdyqW9Il7ZWZDxNWIz82Mso8KxhTUm5MgQ8+k0ACl3TVdPcq+mSBGtwNxQ+xY3KN6qcb+WBzbTZW7GL0VIBiO+e2N6Q7Usu14JwrdF59RZH2RfTvbpA54doCBM5XpXxWIDdFPST5XbJWNSk9aIGWibD8o2VRQVgRXgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIMei5cYIEpPqslv1QrlyBJXrTkHZwmlfKHW+RSDswQ=;
 b=bk2hQkNTRpNeHkEDpHljIDu3FXwpfEcoGRyTXllYJMoTF7j1qMuEP/4vyzKEaCV34b+YlLoAAaJbAx5F74grXZ6XFFHM6tW1Hqe5VxyQh7fjy23gxPO2+OqVdyaJUB4poNfNWlSUkgrRZeaEIKyA54p4vRbvKoRCPOJsC4iM7p4=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB8571.jpnprd01.prod.outlook.com (2603:1096:604:19e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 10:08:44 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 10:08:43 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <ukleinek@kernel.org>, "biju.das.au"
	<biju.das.au@gmail.com>
CC: Geert Uytterhoeven <geert+renesas@glider.be>, "magnus.damm"
	<magnus.damm@gmail.com>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v6 03/11] pwm: rzg2l-gpt: Add support for gpt linking with
 poeg
Thread-Topic: [PATCH v6 03/11] pwm: rzg2l-gpt: Add support for gpt linking
 with poeg
Thread-Index: AQHc9Ah9ppW+tlhIxUm9hAzobZYIQrZwEVGAgBE5qRCAACw2wA==
Date: Mon, 27 Jul 2026 10:08:43 +0000
Message-ID:
 <TY3PR01MB11346CA82616C2AD140A1F61886CC2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260604095647.108654-1-biju.das.jz@bp.renesas.com>
 <20260604095647.108654-4-biju.das.jz@bp.renesas.com>
 <aliNlCVK5qrZKPWi@monoceros>
 <TY3PR01MB11346A66C690388DDDC5EAEB286CC2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TY3PR01MB11346A66C690388DDDC5EAEB286CC2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB8571:EE_
x-ms-office365-filtering-correlation-id: eaa1cc7f-e342-4e07-a13f-08deebc70a53
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|22082099003|11063799006|5023799004|56012099006|18002099003|4143699003|3023799007|38070700021|6133799003;
x-microsoft-antispam-message-info:
 d9cUrhpvJZvQBK+h9FcSGWjfQedtImWJFgBPeVz74BL3PGvCHZ3AWcXy56pXWSZxnj2VpmEolhhSvh3DP/6c1uMUybc2g1+MkcK1PKO7KNnL9cfKuMBB6fxkNIv2TRWudfFPhyzHcttIjDkv75Wmop86B1WLTO9Nxcc2QBnGDHAoxCOZsToFlxAqgM6TsyJDL8canQCueQgE1tQSIvBQOjUJrd5z6VBHtBuW52sKXolYI2/Ypc1cXfdrB12kC+nKzZnwP7ttyi2N0RneBdYatjrB3JLPwiq+FKtGWM4q40BFOqw52ughnyXz0QgLj28uRfTXzHYcjf4CiXmnD2kDwYLb2e9H+QEUXyYFHD2W2xpC5Il6uYMSnrqBtKL2SEZUCvCLe3zKk6zr8Tr1AwAJ04wQxeE3dmjzp3SXuQIEkZQl4/sSDyW1pJyjMeSwpESJcE0lBaJbNBETf8pmfp/RjUzDkk6PLsUDJhP6JjP49NlvsUGgOuk8GCj+Dsh+wSn4WEDxgAphzyb3nPKTcXjExr74UiaQExn8C0ahKkxA9GITEzeADbl0IoiqWkF1+sd6xyFx4zZOETrgK41ANV2bEfkAfJedOTEVPk6I4S5ZSNgNtVutA9CV7Pqe7hMEmAG80G8jw56/QeLQ+1/FwDBXShFMQdJWVlqjV4ZylXJ1EiK6N2NcZ89lAYGSQnh7PevZ5A9Leo91177wxIBomA+XOk3ZftzQA2MBwK761rKqkT0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(22082099003)(11063799006)(5023799004)(56012099006)(18002099003)(4143699003)(3023799007)(38070700021)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TFM1NURqMCtpZERxZW1RaElzTWtCVk8wakZQKzdUNlJmdm96bEM0cGZMeWRY?=
 =?utf-8?B?Ym80WFdIMEZFb1h5ajF0VHI1NVQrdXlRZndtd2t4QTZXNDZRdXZnMElndGgy?=
 =?utf-8?B?NzlxV0ZkY0o0SmE1dEdaY2ZENGJtSTBOSlphcXFsbkw4RU1QbE9HY1VyRG4r?=
 =?utf-8?B?SVRlV1FkM29UaWZsaUIyYVIxZmNIOGR5QmdzWlZRRFhUTjJyZGYrN2pidFpO?=
 =?utf-8?B?MVppbjVpeUJNdUhONFFxdmNLd09ta0hMektUd044YU9RNGZtd1hIbE1TZ3Nw?=
 =?utf-8?B?THdkVk5LRWw1SUNreG5IQ0xncUUyUVM0VWQwT1FNZkJuTnMyaHlKVDF0c2N1?=
 =?utf-8?B?ZWZZZ3F6RFNYYWpYMjVKR0Q3enFUNlhEMFR3UEZlN01nUjdRZjZYWjJISzJw?=
 =?utf-8?B?bFFkMEo3RE5VWDFVcGZXb2YxUlVvai90SkNPWVRTZjd3Y0NJaXk2bENEU2tE?=
 =?utf-8?B?TlBqaDFUc3VjQkJUVFFxTnZzVnZUcWtiZDRtOWcyWTJrb2hpMnJSaktMZXZU?=
 =?utf-8?B?RkV5RzVsdEJYbTNuZXZkc3B4YW1VTXUxZVhJUk81RmUrNE5vallDSUFDZ1M0?=
 =?utf-8?B?QTlXdEZaUVFrMmlRRno4NGp0ZzBreEtjZW5xUUloK3NVMmlZMDR5QStVYkYx?=
 =?utf-8?B?OUhYN1RodnVKZU1FSHhxNGU5RjN0Ukd1WEVIQlluTkU0NEhHRFpFV1JxMXBr?=
 =?utf-8?B?L1c5S2gyTjFSU3QyMzJPV0ZYbEE4UjQyT1liR0p4SVRsT3JuL2dJQ0JRb3Q2?=
 =?utf-8?B?ejB4NldpVDUydWR2Z2ozOGNxdUVlU1JDZ0JRc2tGRU9xOG1LcXM3MWR4TXZS?=
 =?utf-8?B?NS95NU1yV1JCdmZORWo5enhYZnJ5aDl3clZLZGFOSWxzYXR5Z0JKRE91USsx?=
 =?utf-8?B?Wk5pd0NVWjhiMzJ0Z2hwRHFGc09aTHU1U0pEWFVVbzlqWGIzdTlYaW1nODZW?=
 =?utf-8?B?NWdyQnJnbEo1Ly9qanVsd0FqUG9VaWRqWFpGbUhyem9Ja1lwaTFDVXhHYzJM?=
 =?utf-8?B?SkJaL1QyYUM0V3ZaK295cDNjV2c3clJBTlozRnZWM2svaDhJR1g4QXhaRFFC?=
 =?utf-8?B?czM4V2hDWkExaHVxKzNrOEx4RGpjNkJEV1MxS2NseHNMK1dGc1dpRlR3OVRt?=
 =?utf-8?B?b1pWZzZ5WWl3dVRlcXJoNFFXVmxydUFCZXFtU21zeDdKbCtQRGY3MURCU2FQ?=
 =?utf-8?B?Sk13UDVNYlgvRmt5N2VTRlVkK21kK0ZrSGlZYmlDMGRDeXgrdzNtTzZ6Mm1V?=
 =?utf-8?B?K2tGNkJpNEUrT25aMWl3aENWWmtFZmlWbHc0TFNVekVoZVRoYkVDN05jUWZt?=
 =?utf-8?B?OTNjNnVyUEl2eWYvaE92VWhHWkNlNFFERmtGN3dsUUVubVRzWGdobXMvSmxr?=
 =?utf-8?B?eHJjczhITXl6aTRTMDlKaDFPWG5WYmh5UU1TQUtaVjJLbHczTUhRWXk3dzF1?=
 =?utf-8?B?WkJsZC9HWnRWR3RiekZ2U253TTNIVDNoL21wOHhSQU1MaFl6ODZiZnllLy8x?=
 =?utf-8?B?WDRFc0pRamRDUVBpWXNxWDJIdVpXZEViS2xhcE8xc2REU1lNTmxuYWN6Mndq?=
 =?utf-8?B?bTdXbVZGUGNNczNKV1JOdVlvVFY5MHpCRmgwb2NJU3RNb05tSGNrZXVEcU5N?=
 =?utf-8?B?YWtBVlQzQ3hFU3NFS0daazd6cWFRSVJuYUhlRGJtRzFxZnRONzZEampZdlhH?=
 =?utf-8?B?MlhNOEhCK0Jjc3VoYUdpK21oN1RNaGdqeHZHWU1ydXo0RTk3cEI0cWQ2ejZU?=
 =?utf-8?B?ZUxpb0NHeEFLSWlST2syNzcrTjVFQ2xQRmpyY0VrM2FUMk1hdGN6d3puNUtz?=
 =?utf-8?B?RitGdy9Ub0oxeS9wcUd1Ui9pNVdsSE54NE1ER29nbHRVTEk2alBEenJzOVpW?=
 =?utf-8?B?bHJnMy9JTDB4N3IxdkdvK2FCMVFLMnN2cnVqNGJKZUhUbUl2a1RmcmdpL1Yv?=
 =?utf-8?B?L291L29PSkpDTzRZN0VWVHNkVmQ4YVBseXhoR0NyLzdOV0RlVGQzeko4b3RB?=
 =?utf-8?B?SDU2bjFlcmYwOXZLWjFNNk1wdm9HK25iYTcyT0FiMi91MnZXcGpKSUs5bXl5?=
 =?utf-8?B?SHhaRFkrTlhsOWgvNC8wTDk2RmpkYzBCMzBKNWlneFozU1poT0FTWjE1ZGtW?=
 =?utf-8?B?QzBjRXArVTN6Y0t3Y2Fwb3ZCeWZNQWhvY2s0ZDhLSWJVZVcxanJPTzlkYWNG?=
 =?utf-8?B?U3N4YzAySWNBNld3S3p4TWh1ZnViTEo0c2g5RE1pbUNsbHFmemxibDkyMTYr?=
 =?utf-8?B?cU5ZbVJ6T3Jtd2JFYkVGL2x5dURueThWL1dOdHdlTjA4YnN0Sm1uS2c3dUFz?=
 =?utf-8?B?RzZOeXNodjM3L0IyVW9Gek95ZW1HK05CeVlDVzZFS01GejgrSFB6QT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa1cc7f-e342-4e07-a13f-08deebc70a53
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 10:08:43.6954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IAuVXpZ0wc5zFO1dXbt8hUmQDFd4zjZomaYKVppvRAXZI1DITttva4xFyHJJlJE2u9CzfIbfx/6H0ZpPi9ls8zKAO9PQItmjVeirZ8oBoDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8571

SGkgVXdlLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJpanUgRGFz
DQo+IFNlbnQ6IDI3IEp1bHkgMjAyNiAwODozNQ0KPiBTdWJqZWN0OiBSRTogW1BBVENIIHY2IDAz
LzExXSBwd206IHJ6ZzJsLWdwdDogQWRkIHN1cHBvcnQgZm9yIGdwdCBsaW5raW5nIHdpdGggcG9l
Zw0KPiANCj4gSGVsbG8gVXdlLA0KPiANCj4gVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQo+IA0K
PiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogVXdlIEtsZWluZS1Lw7Zu
aWcgPHVrbGVpbmVrQGtlcm5lbC5vcmc+DQo+ID4gU2VudDogMTYgSnVseSAyMDI2IDA5OjI2DQo+
ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiAwMy8xMV0gcHdtOiByemcybC1ncHQ6IEFkZCBzdXBw
b3J0IGZvciBncHQNCj4gPiBsaW5raW5nIHdpdGggcG9lZw0KPiA+DQo+ID4gSGVsbG8gQmlqdSwN
Cj4gPg0KPiA+IE9uIFRodSwgSnVuIDA0LCAyMDI2IGF0IDEwOjU2OjMzQU0gKzAxMDAsIEJpanUg
d3JvdGU6DQo+ID4gPiBGcm9tOiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+
DQo+ID4gPg0KPiA+ID4gVGhlIEdlbmVyYWwgUFdNIFRpbWVyIChHUFQpIGlzIGNhcGFibGUgb2Yg
ZGV0ZWN0aW5nICJkZWFkIHRpbWUgZXJyb3INCj4gPiA+IGFuZCBzaG9ydC1jaXJjdWl0cyBiZXR3
ZWVuIG91dHB1dCBwaW5zIiBhbmQgc2VuZCBPdXRwdXQgZGlzYWJsZQ0KPiA+ID4gcmVxdWVzdCB0
byBwb2VnKFBvcnQgT3V0cHV0IEVuYWJsZSBmb3IgR1BUKS4NCj4gPg0KPiA+IFdoYXQgaXMgYSBk
ZWFkIHRpbWUgZXJyb3I/DQo+IA0KPiBIYXJkd2FyZSBtYW51YWwgZG9lcyBub3QgbWVudGlvbiBh
bnkgdGhpbmcgcmVsYXRlZCB0byBkZWFkIHRpbWUgZXJyb3IuDQo+IA0KPiBJIGJlbGlldmUgaXQg
aXMgc3RhbmRhcmQgb25lDQo+IA0KPiAiDQo+IERlYWQtdGltZSBlcnJvciBpcyB0aGUgdW53YW50
ZWQgY2hhbmdlIGluIGF2ZXJhZ2Ugb3V0cHV0IHZvbHRhZ2UgYW5kIGN1cnJlbnQgY2F1c2VkIGJ5
IGFkZGluZyBhIHNhZmV0eQ0KPiBkZWxheSBiZXR3ZWVuIGNvbXBsZW1lbnRhcnkgc3dpdGNoaW5n
IHRyYW5zaXN0b3JzLg0KPiANCj4gVG8gcHJldmVudCBhIHNob3J0IGNpcmN1aXQgKCJzaG9vdC10
aHJvdWdoIiksIHRoZSBoaWdoLXNpZGUgYW5kIGxvdy1zaWRlIHRyYW5zaXN0b3JzIGluIGEgc3dp
dGNoaW5nIGxlZw0KPiBtdXN0IG5ldmVyIHR1cm4gb24gc2ltdWx0YW5lb3VzbHkuDQo+IFRoZSBp
bnRlbnRpb25hbCBkZWxheSB3aGVyZSBib3RoIHN3aXRjaGVzIGFyZSBvZmYgaXMgY2FsbGVkIGRl
YWQtdGltZS4NCj4gSG93ZXZlciwgdGhpcyBzYWZldHkgd2luZG93IGRpc3RvcnRzIHRoZSBpZGVh
bCBQV00gd2F2ZWZvcm0sIGNyZWF0aW5nIGFuIGVycm9yLiINCj4gDQo+ID4NCj4gPiA+IEFkZCBz
dXBwb3J0IGZvciBsaW5raW5nIHBvZWcgZ3JvdXAgd2l0aCBncHQsIHNvIHRoYXQgZ3B0IGNhbiBj
b250cm9sDQo+ID4gPiB0aGUgb3V0cHV0IGRpc2FibGUgZnVuY3Rpb24gYnkgYWRkaW5nIHJ6ZzJs
X2dwdF9wb2VnX2luaXQoKSB0byBwYXJzZQ0KPiA+ID4gdGhlIHJlbmVzYXMscG9lZ3MgZGV2aWNl
IHRyZWUgcHJvcGVydHkgYW5kIGVzdGFibGlzaCBsaW5rcyBiZXR3ZWVuDQo+ID4gPiBQT0VHIGdy
b3VwcyAoQeKAk0QpIGFuZCBHUFQgaGFyZHdhcmUgY2hhbm5lbHMgKDDigJM3KS4gRm9yIGVhY2gg
dmFsaWQsDQo+ID4gPiBlbmFibGVkIFBPRUcgcGhhbmRsZSBlbnRyeSwgdGhlIGRyaXZlcjoNCj4g
PiA+ICAtIFJlYWRzIHRoZSByZW5lc2FzLHBvZWctaWQgZnJvbSB0aGUgUE9FRyBub2RlIGFuZCB2
YWxpZGF0ZXMgaXQgYWdhaW5zdA0KPiA+ID4gICAgdGhlIHN1cHBvcnRlZCByYW5nZQ0KPiA+ID4g
IC0gUmVjb3JkcyB0aGUgR1BU4oCTUE9FRyBhc3NvY2lhdGlvbiBpbiBhIHBlci1jaGlwIGJpdG1h
cA0KPiA+ID4gKHBvZWdfZ3B0X2xpbmspDQo+ID4gPiAgLSBDb25maWd1cmVzIEdUSU5UQUQgdG8g
cm91dGUgdGhlIG91dHB1dCBkaXNhYmxlIHJlcXVlc3QgdG8gdGhlIGNvcnJlY3QNCj4gPiA+ICAg
IFBPRUcgZ3JvdXANCj4gPiA+ICAtIENvbmZpZ3VyZXMgR1RJT1IgKE9BREYvT0JERiBmaWVsZHMp
IHRvIHNldCBib3RoIG91dHB1dCBwaW5zIHRvDQo+ID4gPiAgICBoaWdoLWltcGVkYW5jZSBvbiBh
biBvdXRwdXQgZGlzYWJsZSBldmVudA0KPiA+DQo+ID4gRm9yIG15IHVuZGVyc3RhbmRpbmc6IElm
IEdQVCBpcyBsaW5rZWQgdG8gYSBQT0VHLCBhbiBlcnJvciBkZXRlY3RlZCBieSBHUFQgbWFrZXMg
dGhlIHBpbiBIaWdoLVo/DQo+IA0KPiBJdCBpcyBjb25maWd1cmFibGUuIEN1cnJlbnRseSB0aGUg
ZHJpdmVyIGNvbmZpZ3VyZWQgZm9yIEhpZ2gtWiBhcyBkZWZhdWx0Lg0KPiANCj4gYjEwLCBiOSBP
QURGWzE6MF0gQWxsIDAgUi9XIEdUSU9DQSBQaW4gRGlzYWJsZSBWYWx1ZSBTZXR0aW5nDQo+IA0K
PiAwIDA6IFByb2hpYml0IG91dHB1dCBkaXNhYmxlDQo+IDAgMTogU2V0IEdUSU9DQSBwaW4gdG8g
SGktWiBvbiBvdXRwdXQgZGlzYWJsZQ0KPiAxIDA6IFNldCBHVElPQ0EgcGluIHRvIDAgb24gb3V0
cHV0IGRpc2FibGUNCj4gMSAxOiBTZXQgR1RJT0NBIHBpbiB0byAxIG9uIG91dHB1dCBkaXNhYmxl
Lg0KPiANCj4gPg0KPiA+ID4gKy8qDQo+ID4gPiArICogVGhpcyBmdW5jdGlvbiBsaW5rcyBhIFBP
RUcgZ3JvdXB7QSxCLEMsRH0gd2l0aCBhIEdQVA0KPiA+ID4gK2NoYW5uZWx7MC4uN30gYW5kDQo+
ID4gPiArICogY29uZmlndXJlcyB0aGUgcGluIGZvciBvdXRwdXQgZGlzYWJsZS4NCj4gPiA+ICsg
Ki8NCj4gPiA+ICtzdGF0aWMgaW50IHJ6ZzJsX2dwdF9wb2VnX2luaXQoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldiwNCj4gPiA+ICsJCQkgICAgICAgc3RydWN0IHJ6ZzJsX2dwdF9jaGlwICpy
emcybF9ncHQpIHsNCj4gPiA+ICsJY29uc3QgY2hhciAqcG9lZ19uYW1lID0gInJlbmVzYXMscG9l
Z3MiOw0KPiA+ID4gKwlzdHJ1Y3Qgb2ZfcGhhbmRsZV9hcmdzIG9mX2FyZ3M7DQo+ID4gPiArCXN0
cnVjdCBwcm9wZXJ0eSAqcG9lZ3M7DQo+ID4gPiArCXVuc2lnbmVkIGludCBpOw0KPiA+ID4gKwl1
MzIgcG9lZ19ncnA7DQo+ID4gPiArCXUzMiBiaXRwb3M7DQo+ID4gPiArCWludCBjZWxsczsNCj4g
PiA+ICsJaW50IHJldDsNCj4gPiA+ICsNCj4gPiA+ICsJcG9lZ3MgPSBvZl9maW5kX3Byb3BlcnR5
KHBkZXYtPmRldi5vZl9ub2RlLCBwb2VnX25hbWUsIE5VTEwpOw0KPiA+ID4gKwlpZiAoIXBvZWdz
KQ0KPiA+ID4gKwkJcmV0dXJuIDA7DQo+ID4gPiArDQo+ID4gPiArCWNlbGxzID0gb2ZfcHJvcGVy
dHlfY291bnRfdTMyX2VsZW1zKHBkZXYtPmRldi5vZl9ub2RlLCBwb2VnX25hbWUpOw0KPiA+DQo+
ID4gSXQncyBhIGJpdCBzYWQgdGhhdCBvZl9maW5kX3Byb3BlcnR5KCkgaXMgY2FsbGVkIHR3aWNl
IGhlcmUuIEJ1dCBJDQo+ID4gZGlkbid0IHNwb3QgYSBmdW5jdGlvbiB0aGF0IGltcGxlbWVudHMg
d2hhdA0KPiA+IG9mX3Byb3BlcnR5X2NvdW50X3UzMl9lbGVtcygpIGRvZXMgZm9yIGEgZ2l2ZW4g
c3RydWN0IHByb3BlcnR5Ki4NCj4gDQo+IE9LLg0KPiANCj4gPg0KPiA+ID4gKwlpZiAoY2VsbHMg
PCAwKQ0KPiA+ID4gKwkJcmV0dXJuIGNlbGxzOw0KPiA+ID4gKw0KPiA+ID4gKwlpZiAoY2VsbHMg
JiAxKQ0KPiA+DQo+ID4gTWF5YmUgYWRkIGEgY29tbWVudCBoZXJlIGxpa2U6DQo+ID4NCj4gPiAJ
LyogcG9lZ3MgaXMgYSBsaXN0IG9mIHBhaXJzLCBzbyBjZWxscyBtdXN0IGJlIGV2ZW4gKi8NCg0K
SSBiZWxpZXZlIHRoaXMgY29tbWVudCBpcyBub3QgcmVxdWlyZWQgaWYgd2UgdXNlICJudW1fcG9l
Z19wYWlycyINCmFzIHBhaXJzIG11c3QgYmUgZXhhY3RseSAyLg0KDQpDaGVlcnMsDQpCaWp1DQoN
Cj4gDQo+IE9LLg0KDQoNCj4gDQo+ID4NCj4gPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+ID4g
Kw0KPiA+ID4gKwljZWxscyA+Pj0gMTsNCj4gPg0KPiA+IEkgdGhpbmsgYSBiZXR0ZXIgbmFtZSBm
b3IgYGNlbGxzYCBmcm9tIGhlcmUgb24gd291bGQgYmUgYmVuZWZpY2lhbCwNCj4gPiBzb21ldGhp
bmcgbGlrZSBgbnVtX3BvZWdfcGFpcnNgLiBGb3IgYmVmb3JlIGhlcmUgdGhlIG5hbWUgaXNuJ3Qg
b3B0aW1hbCwgYnV0IEkgZG9uJ3QgaGF2ZSBhIHNwb250YW5pb3VzDQo+IHN1Z2dlc3Rpb24gaGVy
ZS4gYGxlbmAgY29tZXMgdG8gbWluZC4NCj4gDQo+IE9LIHdpbGwgdXNlIGBudW1fcG9lZ19wYWly
c2AgaW5zdGVhZCBvZiBjZWxscy4NCg0K
