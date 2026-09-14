Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2118.outbound.protection.partner.outlook.cn [139.219.146.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4EE370ACC;
	Mon, 14 Sep 2026 03:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789354938; cv=fail; b=EZUwj3MtXsKAhBoG/IzXM391ZFOTzgtcAuxmaiZD+kIQyJfuh8YQ0eVIYItlrnvvDHXzC2DIOQkhwzNT8uMs6HD2wtQSVDE8QIIFaP2USaFnLsf8rVnXs4rj4QmTDLyjjQvAUap+MxAduJrPzK11AV8RJxRsp14mwKdvjsGpfUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789354938; c=relaxed/simple;
	bh=0hfGUpYNJPOndUHP7AvyATyJK8X29LlkPo9Y88enw00=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FI7MjFPM9iKrLJ9iGC4OjxZAVFzaZyah/xO8Uu+GkGfJW7C68TuhDBx5+kuTyJmW6Ta1tjBx7pNWqdTJjyHdOcYhMvF5TWHXL2/ayjWtSQkBStCaoH0oZlFBdkeQpYJkjVhbtHqtFeVZzEyyltSg2CIlduVQlswTq/6sPhF8G5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W96VGio5qOmELwW/bmqm9N0eJqzMk4AfIymQaA4i43+QzkJ5KxfmpDKUoCtsZklqbA7BOcYIIXAXqzPrTEEopR4oydnyRIlv83lUck1377Xh925TYatr4B6Jy6ZP7VvzpLrusNAtJi51pjcsT8vydyGQlv3/IDUPe2+XR2oeeUo3oMAqKY38y0MVlDy4raD7G8Ex/TLllJBOTyU9qy7X8dwCXSJ2qzx7It1YzTWsNbx8g0K2ohtMvW3B0MY4uRPLp3pk3x8QAiExWhOwPged3fyJfaLOINC9x52j/JsW/uWbR1UEeSXQ3iX2droV6qSmeYZsgYWFF/qaDqKxBh8tbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hfGUpYNJPOndUHP7AvyATyJK8X29LlkPo9Y88enw00=;
 b=i4SSMxiypDCFDVD/eMRj2aN3tAn8EUH9MpEecCpCsfWV4VNz1OLFTCfgDmncTxAY2ptvi4T/dvweLl/pswoACDh5NLBcBMZChMP6tBQ0wZBsNb/akAK5X8qc/+TyhKf1SqoQaymAnL+Uz3HzSGV4kCaJ118POI75cdhbb+GZDxPlU9DwBHHD6P3BULpvA6cNCtab/jgQdplUFJLqp3QSiyUy49f6f476PWQ8I6h+h55ExjGcnPI4UQFTesaZ4BEL4hyoweZjKJS9AVUu9Sf+HsmV/VmBriRWPmcVjLTAe+Fi3HN64oo9KkI7AYmHQsazU5OsTB1itCB3rFkU+V4JSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:7::10) by NT0PR01MB1152.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 03:02:01 +0000
Received: from NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
 ([fe80::be4a:d29e:5188:b37e]) by
 NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn ([fe80::be4a:d29e:5188:b37e%3])
 with mapi id 15.21.0406.007; Mon, 14 Sep 2026 03:02:01 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Maud Spierings <maud_spierings@hotmail.com>
CC: "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "conor@kernel.org"
	<conor@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "emil.renner.berthing@canonical.com"
	<emil.renner.berthing@canonical.com>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"pjw@kernel.org" <pjw@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"ukleinek@kernel.org" <ukleinek@kernel.org>
Subject: RE: [RESEND v22 0/3] Add OpenCores PTC PWM support
Thread-Topic: [RESEND v22 0/3] Add OpenCores PTC PWM support
Thread-Index: AQHdKHVcUHYiMwEYKEiLBGQTFfpjtLbDp0+AgAnuyqA=
Date: Mon, 14 Sep 2026 03:02:01 +0000
Message-ID:
 <NT0PR01MB110215832CD3F81372D96302E6BB2@NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn>
References: <20260810030714.48100-1-hal.feng@starfivetech.com>
 <VI0P189MB36879B75BAD80D203B6390C8E3B22@VI0P189MB3687.EURP189.PROD.OUTLOOK.COM>
In-Reply-To:
 <VI0P189MB36879B75BAD80D203B6390C8E3B22@VI0P189MB3687.EURP189.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NT0PR01MB1102:EE_|NT0PR01MB1152:EE_
x-ms-office365-filtering-correlation-id: 1f34906c-8d78-49f0-6a4a-08df120c8ca8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|22082099003|18002099003|38070700021|4143699003|10067099003|56012099006;
x-microsoft-antispam-message-info:
 lA2Vk2GkGaB1FbeCJLD1VSVL9tZ72rphHsmR8+obVlhXp1Bh/sj4u54P9ifwwKfTACE+A39FUWulX+OqOQi51SK2XfhTIk47jn3GEt5ykFs0G9r82HRxKrwLQeStrMnMcFtaowhFqeyhEyzrFMmEB1wroHV3UMNf2dIE9fWLsHPFsYFIy+vg+C7tNt0i6O+DkHzU6aX9ikczhTk5yryNhXeLPQR31YmCgfzA2aLpnlgbGiT6Hp4xO2x4vMrklZdRD+UUvV08KNphY6ms4O4Im65ZfuU+rmamcTosElIu8NgbIWHt3CbgNQjtDaYrHTp0oOsumBSpYZPaDwRQtGjMu74ynIzcwd5WbSc1XNdJP8AmK0z7pMBwbYndbdgkjdAWMLitYLWWwIsRIXEGIi6bscNZb3FCwueGnNPvU8RR/7YR0uLlVaaH7QbgCHjgpZrlXuiRcHovu++/Jsx3gbjwiqhELnJ4RTZ7aMdKRVmbzoD+y8LR8BqvXVyEEmCSSsIgmbDZO6p9zoDNuLjSjW6MeOjSS0uMQiwI32x+BDxP9Ovybh5+vULn66joMs4Qha2y
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(22082099003)(18002099003)(38070700021)(4143699003)(10067099003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NjVjZVhVcExGa0Q3S3FPcE9BNkovQTVlYlM3TzlDdFdITkN6eXlkdFFra09O?=
 =?utf-8?B?a1VrNkRjRTNRZ0Y2YldjejhmQ3ZMd0VKMENRdWJCNXdCc2dGZmt3SkgrV1BK?=
 =?utf-8?B?cnA0VTNpL0F3YjRtVVozeFBrR3BaeTVRcUQ2azJjdDVKTEVJWHBkZFdGT0JJ?=
 =?utf-8?B?QVpLNHhIbHZXenJpUVBLSWx6VGtXaFFOUmJ6UU9ETjdqZHg0cmhKa3pMVVda?=
 =?utf-8?B?Z3JpQ3Q0akxiSTNtNVlaaHhYWDMrTC9HNTJ2ZXoxTkh3a1MvMS9PSURkMklY?=
 =?utf-8?B?aS81STF4Y1hldENXM3FqRFlYd2VzdTBRVU9WWjhBbXUvNDVZdy85b3h1M0Fv?=
 =?utf-8?B?cG0zYUZqdTlwdWpZV2t5QjJoU1JwcnpkQU9FTXlBMUtFaHNxcTZXeFhabFZV?=
 =?utf-8?B?Mm1UMmJqTGQyU2FwODVPblNKVXlRaWs3UVZBZXpkRHJ3N1NkYnA4ZXBDYnBU?=
 =?utf-8?B?emowQ1RlSFg5cE9mNlFDYkV0bVhqVTI4NElMTjJYM3RTa1grb0JHcDk4UC85?=
 =?utf-8?B?cE9DWGZWQW0zalB4TTBQck12OExMOERlb0VWSllaZVJjOC9LWmg1Yi9xSTlm?=
 =?utf-8?B?b0xGM3Q2U2FSSHhsdWRtdGFjZlhENDNvSkRzZllsMkNTY2lFSVBNUmhtL0Fr?=
 =?utf-8?B?Vm9NTWtqNVRjK0JmQkpUSFRyaEltTWJ6WXo1Y3ZBcERnMVcyM2p1a1g3c1ZH?=
 =?utf-8?B?ZlJ2bnlPTVdvdXF4K3Y4R2JseE0yczdYMzN5TWVYZ281a2pqdTAxS1NhTVU1?=
 =?utf-8?B?NFpRbXZhWndXemVlYzlGdlViUGpEeXk4ZW5IR1BKc3BsNEE1aGg5ZlBSRWNV?=
 =?utf-8?B?amx6VEtURnNLZ0xOQVJnbkFDZjZLdWE4QVZySHVjRG80OE9vbEk0K1YzVkJl?=
 =?utf-8?B?bWtoV2Qxb0dNUGhNeHVmd3RPTHRIUjlEWDBFbWIreVZaS0pYanRUKzFocXpG?=
 =?utf-8?B?R3dwV3R6L2hibXV4NTYvV3RGa3Q3c1lSN3p6WGJEMXNrblk1WUZ5cURYZzhl?=
 =?utf-8?B?TnE0VVNrbEVZcmh3alQ2c2RjVWtMTEEwVDdtWEt4TkJ1aTUyc2VCT295UVdv?=
 =?utf-8?B?OXlKeWo0NGxmNisycDBXaUJTa3l6dDVTYmh3VEtIWVVmV0E1MnBNVVg4dEp1?=
 =?utf-8?B?M1l3QzJpa0ZHbHFmbk1NUitnZWxMaVAzZXlRYm8zVytWYjc5TGlBZDROR3o3?=
 =?utf-8?B?TXBPNUkxOTNacmR2RkNLZ1BoK0NYZWMxWUF5Q0pRKzFZY3ViTEQ2YVhvQWVi?=
 =?utf-8?B?RWdzRXp2WVBJNXJpQXhSWWFmT21TTVFRbFJkcVI4c3M3M2RHT1N4ZmJ6cjJS?=
 =?utf-8?B?RGlDVnlHbmw5a1BHdFhjSkhmSG1lK2hUU1hwendTTmVCRHhUMnFLU0FXVXY1?=
 =?utf-8?B?bG1EaXAzNERBK1U0ZElWcU1hOENhT29zbUpWdzM1WlpPZFhkclN6eUNJQjRm?=
 =?utf-8?B?SGlQckRBZ0RsejlJdVNCNGh0L1BUcnBoVERENFkyYnl0MHZOT1VScVE1TVNh?=
 =?utf-8?B?WHAycVpUcFR4RHlGTndBNmR6azJpaGlZTlpScHdxUTZMemJiaHhTKzc0YlBm?=
 =?utf-8?B?ejlUWGlYUDZoM0lsOUpnMVdvMU1qZ2tQd2V2Q2M1ODVONU1Zb1QwQ3JZQTlO?=
 =?utf-8?B?aHZiYmtyMGJTNDRoSTRLWEVuZVdUanlYaHp2Rkkxb2V0K2Ewc3VnUkN3K2ZX?=
 =?utf-8?B?RHBHa3M4TExEM1hSTjZFbUZUVGtUbUIzSTNKKzgvRERoQWZndlNjWnRUZ3JY?=
 =?utf-8?B?T0pyZEFQaFU3NHdMMnpZNWpQSzhhZ09zQ004ajhDYzdIdjROSHNtejBOdmlJ?=
 =?utf-8?B?QnYzMmJ3QVBNUGw1eWpSQ3dZUDNiU1JoT0tqZmVnQ2xBVUo2S0ZONysrREVz?=
 =?utf-8?B?SFhHVlE4ZXovUUl6eFhsUW5jYmdkSGlhak9IY2dqbDZaSXdGeUp4MXBHcXI4?=
 =?utf-8?B?akdzc0pCZ1VXL1pMaTlDSzR6OThmRXVHOXcwTGI2dmdDRGZGT1I1Q0VXSjBz?=
 =?utf-8?B?SzFzMjV4aG9aRk1sVnpyWlAvamdYWkRJaUNQcG5veklqZnZITSs2Znp0K0k4?=
 =?utf-8?B?OVRZNVBWdUFhc0Q3b1diRm02aTYzMUxEZXJHaVpkK1QxZkQwSHpERHVub0ht?=
 =?utf-8?B?dFMvY0djKzdveVFjRkpvTzg0aTVXQUExd2VEY2tURGhkYy8rRko5bmp4MkNO?=
 =?utf-8?B?UFAyL2Jya3czWW4yTEhNVm1STTB3RkdKVEhqQ0d6aWZUM0RaaUdsSVVYSHNX?=
 =?utf-8?B?MEJPVDlCeFZ4TnRWWDROTEpNbzRRcklid3lMRE1VWFhZcy9PSjRaV1gvc1pZ?=
 =?utf-8?B?NFRIV2N4UDRLYnRWamd4MjFsS1cwcnhYQW9iZ0ZOQkJHUHliSGpsdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f34906c-8d78-49f0-6a4a-08df120c8ca8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 03:02:01.7724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z6CAAukBgAywUI2EKo9wRcTmiq/UDGH0gh930Zm/nVSjtWj+iqejuAo5LRo8qyVUfiA68rvaKTaxDEGCJZMdLEpCdl2Kt9Fui4HN0kXs7io=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1152

PiBPbiAyNi4wOS4wOCAwMzowNywgTWF1ZCBTcGllcmluZ3Mgd3JvdGU6IA0KPiBIZWxsbyBIYWws
DQo+IA0KPiBUaGFua3MgZm9yIHBpY2tpbmcgdXAgdGhpcyBzZXJpZXMsIEkndmUgdGVzdGVkIGl0
IG9uIG15IGZtbDEzdjAxIGJvYXJkIGluIHRoZQ0KPiBmcmFtZXdvcmsgMTMgY2hhc3Npcy4gU2Vl
aW5nIHRoZSBwd21zIHNwbGl0IG91dCBpbnRvIHNlcGVyYXRlIG5vZGVzIGlzIGhvdyBJDQo+IGVu
dmlzaW9uZWQgdGhpcyBkcml2ZXIgdG9vLg0KPiANCj4gTm93IHRvIGZpZ3VyZSBvdXQgaG93IHRv
IGdldCB0aGUgcHdtIGJhY2tsaWdodCBkcml2ZXIgdG8gd29yayBuaWNlbHkgd2l0aCBhbg0KPiBp
bnZlcnRlZCBwd20uDQo+IA0KPiBUZXN0ZWQtYnk6IE1hdWQgU3BpZXJpbmdzIDxtYXVkX3NwaWVy
aW5nc0Bob3RtYWlsLmNvbT4NCg0KVGhhbmtzIGZvciB5b3VyIGF0dGVudGlvbiBhbmQgdGVzdGlu
Zy4NCg0KVG8gd29yayB3aXRoIHRoZSBwd20gYmFja2xpZ2h0IGRyaXZlciwgYWRkIHRoZSBQV01f
UE9MQVJJVFlfSU5WRVJURUQgZmxhZyB0bw0KdGhlIGRldmljZSB0cmVlLg0KDQpCZXN0IHJlZ2Fy
ZHMsDQpIYWwNCg0KPiANCj4gPiBBZGQgT3BlbkNvcmVzIFBUQyBQV00gZHJpdmVyIHdoaWNoIGlz
IHVzZWQgaW4gU3RhckZpdmUNCj4gPiBKSDcxMDAvSkg3MTEwL0pIQjEwMCBTb0MuDQo+ID4NCj4g
PiBJIHdpbGwgbWFpbnRhaW4gdGhpcyBwd20gbW9kdWxlIGluIHBsYWNlIG9mIFdpbGxpYW0uDQo+
ID4NCj4gPiBDaGFuZ2VzIHNpbmNlIHYyMToNCj4gPiAtIEFsbG93IG5vbi16ZXJvIGR1dHkgY3lj
bGVzIHNob3J0ZXIgdGhhbiBvbmUgY2xvY2sgdGljayB0byByb3VuZCBkb3duIHRvDQo+ID4gICB6
ZXJvLg0KPiA+IC0gRHJvcCB0aGUgLmZyZWUoKSBjYWxsYmFjayB0byBwcmVzZXJ2ZSB0aGUgUFdN
IGhhcmR3YXJlIHN0YXRlIGFmdGVyDQo+ID4gICBwd21fcHV0KCkuDQo+ID4gLSBVcGRhdGUgdGhl
IGNvbW1lbnQuDQo+ID4NCj4gPiBDaGFuZ2VzIHNpbmNlIHYyMDoNCj4gPiAtIEZpeCAwJSBkdXR5
IGN5Y2xlIHN1cHBvcnQuDQo+ID4NCj4gPiBDaGFuZ2VzIHNpbmNlIHYxOToNCj4gPiAtIERyb3Ag
dGhlIG9uZU9mIGNvbnN0cnVjdCBpbiBkdC1iaW5kaW5ncy4NCj4gPiAtIEFkZHJlc3MgU2FzaGlr
byBBSSByZXZpZXcgY29tbWVudHMgZm9yIHRoZSBPcGVuQ29yZXMgUFdNIGRyaXZlci4NCj4gPiAg
IEluIG9jb3Jlc19wd21fYXBwbHkoKSwgaGFuZGxpbmcgZGlzYWJsZSByZXF1ZXN0cyBmaXJzdCwg
dGhlbiBjYWxjdWxhdGluZw0KPiA+ICAgYW5kIHZhbGlkYXRpbmcgcGVyaW9kL2R1dHkgZm9yIGVu
YWJsZSByZXF1ZXN0cyBiZWZvcmUgdGFraW5nIGEgcnVudGltZQ0KPiA+ICAgUE0gcmVmZXJlbmNl
IG9yIHRvdWNoaW5nIHRoZSBoYXJkd2FyZSByZWdpc3RlcnMuDQo+ID4NCj4gPiBDaGFuZ2VzIHNp
bmNlIHYxODoNCj4gPiAtIEFkZHJlc3MgU2FzaGlrbyBBSSByZXZpZXcgY29tbWVudHMgZm9yIHRo
ZSBPcGVuQ29yZXMgUFdNIGRyaXZlci4NCj4gPiAtIEZpeCBydW50aW1lIFBNIHVzYWdlIGNvdW50
IGhhbmRsaW5nIG9uIHByb2JlLCBlcnJvciBwYXRocywgUFdNIHJlbGVhc2UNCj4gPiAgIGFuZCBk
cml2ZXIgdGVhcmRvd24uDQo+ID4gLSBSZWplY3QgcGVyaW9kIG9yIGR1dHkgY3ljbGUgdmFsdWVz
IGJlbG93IHRoZSBoYXJkd2FyZSBtaW5pbXVtLg0KPiA+IC0gUmVzdG9yZSBQV00gcmVnaXN0ZXJz
IGFjcm9zcyBzeXN0ZW0gc2xlZXAgcmVzdW1lLg0KPiA+IC0gUmV0dXJuIHRoZSByZWFsIGVycm9y
IGZyb20gZGV2bV9wd21jaGlwX2FsbG9jKCkuDQo+ID4gLSBQcmVzZXJ2ZSBib290bG9hZGVyLWNv
bmZpZ3VyZWQgUFdNIHN0YXRlIGR1cmluZyBwcm9iZSBhbmQga2VlcA0KPiBydW50aW1lDQo+ID4g
ICBQTSBhY3RpdmUgaWYgdGhlIFBXTSBpcyBhbHJlYWR5IGVuYWJsZWQuDQo+ID4gLSBVc2Ugc3lu
Y2hyb25vdXMgcnVudGltZSBQTSBwdXQgYmVmb3JlIHBvc3NpYmxlIHRlYXJkb3duLg0KPiA+DQo+
ID4gQ2hhbmdlcyBzaW5jZSB2MTc6DQo+ID4gLSBTaW1wbGlmeSB0aGUgY29kZS4gTWFrZSBpdCBt
b3JlIHJlYWRhYmxlLg0KPiA+IC0gUmVzdHJ1Y3R1cmUgdGhlIGRyaXZlciB0byByZWdpc3RlciB0
aGUgcHdtIGNoaXAgZm9yIG9uZSBwd20gY2hhbm5lbCwNCj4gPiAgIGJlY2F1c2UgZWFjaCBPcGVu
Q29yZXMgUFRDIElQIGNvcmUgb25seSBzdXBwb3J0cyBvbmUgUFdNIGNoYW5uZWwuDQo+ID4gICBE
cm9wIHN0YXJmaXZlIGNvbXBhdGlibGVzLg0KPiA+ICAgQWRkIHBhdGNoZXMgdG8gZml4IHRoZSBk
dC1iaW5kaW5ncyBhbmQgZGV2aWNlIHRyZWUuDQo+ID4gLSBTdXBwb3J0IHJ1bnRpbWUgcG0gYW5k
IHN5c3RlbSBzbGVlcCBwbS4NCj4gPiAtIERpc2FibGUgdGhlIHB3bSBtb2R1bGUgYW5kIHJlc2V0
IHRoZSBwd20gY291bnRlciBiZWZvcmUgdXBkYXRpbmcgdGhlDQo+ID4gICBwZXJpb2QgYW5kIGR1
dHkgY3ljbGUuDQo+ID4gLSBJbXByb3ZlIHRoZSBkZXNjcmlwdGlvbnMuDQo+ID4gLSBVcGRhdGUg
dGhlIGR0LWJpbmRpbmdzIG1haW50YWluZXIgdG8gSGFsIEZlbmcuDQo+ID4NCj4gPiBIaXN0b3J5
Og0KPiA+IHYyMToNCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjA3MDEwNzQ0
NDIuNzcxNC0xLWhhbC5mZW5nQHN0YXJmaXZldGVjDQo+ID4gaC5jb20vDQo+ID4gdjIwOg0KPiA+
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI2MDYyOTA2MzYwMS42MzkxNy0xLWhhbC5m
ZW5nQHN0YXJmaXZldGUNCj4gPiBjaC5jb20vDQo+ID4gdjE5Og0KPiA+IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2FsbC8yMDI2MDYxNTE1NTc1OS4xMjkyMTAtMS1oYWwuZmVuZ0BzdGFyZml2ZXQN
Cj4gPiBlY2guY29tLw0KPiA+IHYxODoNCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwv
MjAyNjA1MTUwNTQ3MjMuMjUwMjQtMS1oYWwuZmVuZ0BzdGFyZml2ZXRlDQo+ID4gY2guY29tLw0K
PiA+IHYxNzoNCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNTAxMDYxMDM1NDAu
MTAwNzktMS13aWxsaWFtLnFpdUBzdGFyZml2DQo+ID4gZXRlY2guY29tLw0KPiA+DQo+ID4gSGFs
IEZlbmcgKDMpOg0KPiA+ICAgZHQtYmluZGluZ3M6IHB3bTogb3BlbmNvcmVzOiBVcGRhdGUgY29t
cGF0aWJsZXMsIGV4YW1wbGVzIGFuZA0KPiA+ICAgICBtYWludGFpbmVycw0KPiA+ICAgcmlzY3Y6
IGR0czogc3RhcmZpdmU6IENvcnJlY3QgcHdtIG5vZGVzDQo+ID4gICBwd206IEFkZCBPcGVuQ29y
ZXMgUFRDIFBXTSBkcml2ZXINCj4gPg0KPiA+ICAuLi4vYmluZGluZ3MvcHdtL29wZW5jb3Jlcyxw
d20ueWFtbCAgICAgICAgICAgfCAgIDYgKy0NCj4gPiAgTUFJTlRBSU5FUlMgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgICA2ICsNCj4gPiAgLi4uL2Jvb3QvZHRzL3N0YXJmaXZl
L2poNzEwMC1jb21tb24uZHRzaSAgICAgIHwgIDI4ICstDQo+ID4gIGFyY2gvcmlzY3YvYm9vdC9k
dHMvc3RhcmZpdmUvamg3MTAwLmR0c2kgICAgICB8ICA2NyArKystDQo+ID4gIC4uLi9ib290L2R0
cy9zdGFyZml2ZS9qaDcxMTAtY29tbW9uLmR0c2kgICAgICB8ICAyNyArLQ0KPiA+ICAuLi4vYm9v
dC9kdHMvc3RhcmZpdmUvamg3MTEwLW1pbGt2LW1hcnMuZHRzICAgfCAgIDYgKy0NCj4gPiAgLi4u
L2R0cy9zdGFyZml2ZS9qaDcxMTAtbWlsa3YtbWFyc2NtLmR0c2kgICAgIHwgICA2ICstDQo+ID4g
IC4uLi9kdHMvc3RhcmZpdmUvamg3MTEwLXBpbmU2NC1zdGFyNjQuZHRzICAgICB8ICAgNiArLQ0K
PiA+ICAuLi4vamg3MTEwLXN0YXJmaXZlLXZpc2lvbmZpdmUtMi1saXRlLmR0c2kgICAgfCAgIDYg
Ky0NCj4gPiAgLi4uL2poNzExMC1zdGFyZml2ZS12aXNpb25maXZlLTIuZHRzaSAgICAgICAgIHwg
ICA2ICstDQo+ID4gIGFyY2gvcmlzY3YvYm9vdC9kdHMvc3RhcmZpdmUvamg3MTEwLmR0c2kgICAg
ICB8ICA2NyArKystDQo+ID4gIGRyaXZlcnMvcHdtL0tjb25maWcgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAxMiArDQo+ID4gIGRyaXZlcnMvcHdtL01ha2VmaWxlICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAgMSArDQo+ID4gIGRyaXZlcnMvcHdtL3B3bS1vY29yZXMuYyAgICAgICAg
ICAgICAgICAgICAgICB8IDI5OA0KPiArKysrKysrKysrKysrKysrKysNCj4gPiAgMTQgZmlsZXMg
Y2hhbmdlZCwgNTE4IGluc2VydGlvbnMoKyksIDI0IGRlbGV0aW9ucygtKSAgY3JlYXRlIG1vZGUN
Cj4gPiAxMDA2NDQgZHJpdmVycy9wd20vcHdtLW9jb3Jlcy5jDQo+ID4NCj4gPg0KPiA+IGJhc2Ut
Y29tbWl0OiBkYjJkZGI4NzE0MzUxOWUyMGE5NWFhMzZjNjBiMzYxMDdiNzM2YTU4DQo+ID4gLS0N
Cj4gPiAyLjQzLjINCg0K
