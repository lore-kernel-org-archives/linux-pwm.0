Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.146.117
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793585519;
	b=cti/Fns6+tOQYUOBwJGmM1Watazdgtkd2qVFT2xqWY6a61jpZ1lQoSwev56127t7DQAz
	 nV9C8vQ3aU3tPRCqCUODf7teqqnjIkl6K/DahIcLqlL7U5SEc3YV9o4ofLkUTMSPY7Eps
	 v/Koc9K/3ywywiFUnLk1rS308fvupDJGagzCBluUhZBQKnz7PRZBnb8o/I0xv4DvvjkGb
	 K3QTILA0ucVnVC1V9nUQZZ2MTPMFCfQpkjxgxgSvKkjCaQui92qrISC4q/Eji0bZKpc8S
	 +v4MQ9pJX+0VR6Ia3XGyyAzDsU2Y8Zz7FowHkGbwRAjTmlNFyAJ4VfzCYqKtIu3K50Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793585519;
	h=DMARC-Filter:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
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
	bh=MB56xPcMHiBrdSd6zT9wNeOvso0rPW7msyfvCfwp3ug=;
	b=r3OKrETDqdSWhYjwD4J2Q3BjZTn/nxMObFoG6WiU/sNJJk9ofOA7UPhddhJbP5qBO37c
	 1MpAPXhRzqy9S99+skJtucLF4vjH3Pv40eRPo8gDEKJW8OWietrwT0iOAHE7hw6/erdOU
	 s1AiBr4BuhL4ltm9Ad4UCHB5+O9Lg07JXKwh5EbTt9TZZ0qvic5a14U7Jn22vEk8bS6Fw
	 fEDpy6+0zhw9iKsH4UFHq+XwvclEuTNpJlLZ3LxDiszscaSHftCrY7axIMPYRvp0NUdya
	 iRkvFA6Bushc4OTs0cNdf7TCOLHEYmR+O8JzM+/o8wX8lYD3vdxawlkr+ajQH4VfoSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=starfivetech.com;
	spf=pass smtp.mailfrom=starfivetech.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.146.117
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2117.outbound.protection.partner.outlook.cn [139.219.146.117])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C1A606A324;
	Mon,  2 Nov 2026 02:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68C1A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+Gwe+BnlNo93GbyXbtvk3AMqufMsMnhQJbqjqc8xHbpznDjga9i7+wYsxe/PJ6RJVL4pNetriujOQWkKv2MI2Z45jpbuxKplZBwb4QDGMh2kCohicc+tcd+axiLrzNN2i2IP3Eo5poKboN7iih1sbL5U6RD9N8dMNBTc4D8v1/6xuNAQ8hxD/NB2gxdOwf3WVDAHX0ysrbsEckrbJ/ZsUa9GSmzg44nEeWV+TxzvPTWHQeqCmKQiCg9mSIdIUvIC/LMz0IgqTvLfpHVi251oh4VH0Ld5dif5+9aFf/Zd89Gwxqd+s0Tz2ugZkfQ6lCuQadVorxb3ibdKpXGakf81g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MB56xPcMHiBrdSd6zT9wNeOvso0rPW7msyfvCfwp3ug=;
 b=Zvlcz/8oUpf97WuIMHCV6OZ0JyL+lfH1GsZhvVFEmAE30hYq0/I0TVziW0JCOh/k0k+O/W7egI8JaJC0oYygimFaeVVv/6qQJU7OkcTyU+ehnTFQ0BCJD4DtFN/9QdANw9pnp/hVHqyS+eK99p4zj9SzzLONQOv/MgLGsJ/7wzv8n5zPcQbpO53oNA4iHgGt4O0k+Pztrvem81dedfz02R5v4uclh9//5fhNhuz9gpM9Q+IFgsoBpu0ZI2yShhhz/oTBEheD966/NtcDirKk8jb0c9LaSQjwuibTaHmH3g3vvispM/TCvsHLZ6hRR6jK+YXBVoy/Vj+7DQ/og+3NXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:7::10) by NT0PR01MB1120.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 02:11:46 +0000
Received: from NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
 ([fe80::be4a:d29e:5188:b37e]) by
 NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn ([fe80::be4a:d29e:5188:b37e%3])
 with mapi id 15.21.0569.011; Mon, 2 Nov 2026 02:11:46 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: "patchwork-bot+linux-riscv@kernel.org"
	<patchwork-bot+linux-riscv@kernel.org>, "conor@kernel.org" <conor@kernel.org>
CC: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"ukleinek@kernel.org" <ukleinek@kernel.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"emil.renner.berthing@canonical.com" <emil.renner.berthing@canonical.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "pjw@kernel.org" <pjw@kernel.org>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RESEND v22 0/3] Add OpenCores PTC PWM support
Thread-Topic: [RESEND v22 0/3] Add OpenCores PTC PWM support
Thread-Index: AQHdKHVcUHYiMwEYKEiLBGQTFfpjtLcaTHiAgAA6KyA=
Date: Mon, 2 Nov 2026 02:11:46 +0000
Message-ID:
 <NT0PR01MB11026FD52BC4266EFFEACBD5E66A2@NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn>
References: <20260810030714.48100-1-hal.feng@starfivetech.com>
 <179357141185.2624073.8394896290201314670.git-patchwork-notify@kernel.org>
In-Reply-To:
 <179357141185.2624073.8394896290201314670.git-patchwork-notify@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NT0PR01MB1102:EE_|NT0PR01MB1120:EE_
x-ms-office365-filtering-correlation-id: 1a86316e-d988-4ee4-0c34-08df3886a592
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|38070700021|4143699003|56012099006|261009223027099003|261028144727099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 fojYtCq1weEuVke97FitqTqrf/fbUdZ4L+PNHhcOonGHS0TPh2ximwm29hpbMA7wTIVaweoPQtQsdxW+DnU6yAWvQR2S6pMOxqfA7VkfC4P/uviGKpiSq1o4WebPQZSYyFTx6MkyKJllF1xr3BQ0ASSUdmxJ4lsm0a5R3qGqa/nyaIXpJHRY+3ulS+qpYneIO+Pe2vmzuRlmM/CSVJ+O99i9i/68QkgSF0l7nFFKtaXpyDTCl2b2b8rSWBitLAqjbnJEO1zMB5PZLVkxDZKU6+BzIEG94P6tDB8mFpuMRV7/Ctf0DCBD/gJHwPv4WmvG+OazqbMO903DnKnO9BEFGbvsCl3AiFXIqwU2qaj5f4GPGNdk0rb5XkzcU4i4fJRvvHMPF6No6hNKfuzCFX0PdqfQ7D1wCaLgcN7HDN5ltaZElFNY1Z5MMGUS4121dyxwyHHmEzi29KpRGls3Vyf3sHVx8V1smoXc2EPY/xfdEXCSB/1MP5XaUoqnN+hNVjtAym7qn2N3I/ZTC7pu+rvB74dMTSE/7hzZz7vnMDXm3+fQSyL0kkrsDBIPXU66vZWF
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(38070700021)(4143699003)(56012099006)(261009223027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d1NiL2tja09oOGxxbjV1WXVTcXNCWitZR0JocnZLWTJCVjJCcHBaR0Y3a1Mr?=
 =?utf-8?B?L1N1MjQ3VjZobXFTQnlUL0VUWUJCYVN4bEFxYmZqUmV2UzFyaUNhYUc1ejl3?=
 =?utf-8?B?eG9vK0hadVlHR0hwOFlxQ1hTSmp3a3NRbG5RRUp4U2sram9DQ1dVd0FkTVJ5?=
 =?utf-8?B?NE1TSDdiNWhYbnQ0WnlGTHEvRFVJaGoyeFMyZTc4MVhwUEFtSElha0F0ZzBP?=
 =?utf-8?B?ZWVSTFBWV1FtZFVCUzJoQmxENmhReU53R2lMeUJ6UWlXSDNjOGxwQk1MbjVO?=
 =?utf-8?B?T3o0SG01V2hmQTNYUzgyWk1yazgraHVMdzNLdXRYUUFNOGRKVWxSR2dUZ2tW?=
 =?utf-8?B?bW1FTXpOVkg3MEQxUXNoMGdDUGR3cHNqRXJsWkhkbFFTYU9qZGNCNWtPMlJj?=
 =?utf-8?B?eVZGL2c3bE1xbm9GRmVlZUxlMG44dkwzMXc3ZzVZYmcwMkdHaFZoRGxUQVpv?=
 =?utf-8?B?NGo3cWlPcUYwSEJsNVh5NG5rTmdFTnZ2ZlJWSnYwVFJxazhVdmVmVDNZcFN5?=
 =?utf-8?B?MU9PbTlQbVdLQVVHdWtqcUlHaWZ0OWFnRkZjUjliR29pTVVXdkhMVmdlRG5q?=
 =?utf-8?B?SFBjanFBMFdtVEp5L0pROGlwSXArcVpxRlZ1dTFaaS9MSXN6ZStkVFlFZFZ1?=
 =?utf-8?B?TXlFQ2ttejBLczB5aHRzbzhicVBibmVCUXlpTlZyb3Y4QzMyWkVqbXlhbGxn?=
 =?utf-8?B?OFFiUjEwMkJucUgzNWlKMVZoV3c0VDBCakQrSUg2cmdhWFRSTkZURnlDdUVT?=
 =?utf-8?B?c2FhdThoNDhaSVNObHNpMGRYc2tKTFJiWWVWMkNuUS9GdDVCc2h5M0pqTnRF?=
 =?utf-8?B?NG9tdDRhQXljcHlwU0E5cEUyUktTQ0oyemg5QXlYZHFXOFp1bVdvb2pGMitM?=
 =?utf-8?B?V1FNK0MvUmRvM0hYSjlSM1J4QTlwSmVnanpqVVZRMm0rcEdmNTBTaC8wNDNa?=
 =?utf-8?B?cTAxZjRvVEo4VEp6RzBoc3dBRlFidWhCM09ZVmJMMm5EejkzZXdpcXd5bEl6?=
 =?utf-8?B?enE2NHZSMGlYSDhLUWNPV0dFVjkxdTZySmJFcVFMWXZJVVA2aVJMaHNLQ2Jh?=
 =?utf-8?B?a0IxNWRXKzk4azE5VEJRQk84eGtwWGNHWm9LRk1sOXNGSEpvYkM1TS95Qmkz?=
 =?utf-8?B?TU9Ga3IwM3M4SUZtNnpwamlLbmw2S3gyeWMycXlCVko2Z01TajE5aGdyM2VW?=
 =?utf-8?B?WjdSV09nZi95NWVENkxMemdrVE16Z3F3ZVI2WlNLWDRGcys5Myt5ME9TNkNa?=
 =?utf-8?B?dTRQWGdXcUp0dXNMQ0xkUVo1R1JMYWpHZkhnTXhBQURObTlERlIwRHpIYUlx?=
 =?utf-8?B?MzNJSzVockVHRVBHVWJVRVBLb2RDeUJwOVVzVnZucWtDRWdmQmUzcVBTRjlI?=
 =?utf-8?B?dFo5NE9YMEFoT21COHljN1dxQVhodG5IZUY3czBhN2s3MzdVanp3T3dCS1NT?=
 =?utf-8?B?QWxzVTJLMC9FNkRObmlxRFVLcS9oMGQ0NlNRWG9RUzRyN0tZWExWZGN1U0E1?=
 =?utf-8?B?SXN2K2xycTUxQVRnREhmVDFCdnB5YXlkbVlwNEtGOGRSSnI3YzhsVTc2TGtw?=
 =?utf-8?B?K0pYeG9XTi8rRlhrNGg1ZHNlOG5DYlNqODU5QWlUdzZkWndVQ1cyeXBSOTZp?=
 =?utf-8?B?L3pESGxITHFkYkQvemYvM0pKM3pONlFudWhDcm45aUtNMkVSNGZNK3UzWUlp?=
 =?utf-8?B?OXRxWDlrZUNDVSttTnAvZHJJZXBEZnJBdFZ2NWNXbGpscTZLT1U4Q0lrZFg3?=
 =?utf-8?B?NHNCRGt6Q1hYR0x4enhuelM1bnpyek5iVEFIQ0RyV2VQcXRmOFVMclB5ZWZw?=
 =?utf-8?B?aTJMdzFrNFZCYkQ0YnZsU0NaRlV0TXFuY3VTMjJMN3ZXV1lNQVZMdzhpMWx4?=
 =?utf-8?B?RkpMN0FnZmVmVGMwV0xpM1JqOXVnc1dCa1pxNG5Oa0wzbUlnNWJ0Z3RuaUtn?=
 =?utf-8?B?cEtZNjFTekFDam1vVm5lUkdPTFF2YTl5VC94ZVBPNzVjYVVKbHY0S0FqZFlo?=
 =?utf-8?B?THdzbUNaZ09TN25YMnNJZ01TTmpUZkN6UWZhUUZiT3B6TVpQd05teitBNk5v?=
 =?utf-8?B?Yjl6aDNWWmJDbzY0bFdaaWNTZVF4WVVldVpnbEg0NUVIVStZL3M1SWFSRXhx?=
 =?utf-8?B?MGZrSkJTRW1PQkFCZ2U1WmhudzNFT1lZTTMzaUkvMzRZTm83MC80V05CYmcy?=
 =?utf-8?B?VEZ3K1NEMktJejk5a1VsQlVoS3dRR3NxVW50UUpncTNUeVVzQzd0aGFaenVr?=
 =?utf-8?B?MnhUN3pDMjllN29ManExL2owcXNvWXVkS3A4QVhNTFg0TitvSHdMU1RtVGpN?=
 =?utf-8?B?TGNSWnczU0x0a1ZUK0FVcndwakpuQjNlOVBSZWlJZEthZDhPNnlpZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a86316e-d988-4ee4-0c34-08df3886a592
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 02:11:46.3947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GjqHCxl2Ylp1fgyJVhYNCETL+01pcNhZEh7/hTYc7HINuT2WMtdbM0mUYNUBOtXpHvTcyJLb3vvkoP+z/OtFMrXDSwQxEjTxqNm/+gcs4W0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1120

PiBPbiAyNi4xMS4yIDA2OjE3LCBwYXRjaHdvcmstYm90K2xpbnV4LXJpc2N2IHdyb3RlOg0KPiBI
ZWxsbzoNCj4gDQo+IFRoaXMgc2VyaWVzIHdhcyBhcHBsaWVkIHRvIHJpc2N2L2xpbnV4LmdpdCAo
Zml4ZXMpIGJ5IENvbm9yIERvb2xleQ0KPiA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+Og0K
PiANCj4gT24gTW9uLCAxMCBBdWcgMjAyNiAxMTowNzoxMSArMDgwMCB5b3Ugd3JvdGU6DQo+ID4g
QWRkIE9wZW5Db3JlcyBQVEMgUFdNIGRyaXZlciB3aGljaCBpcyB1c2VkIGluIFN0YXJGaXZlDQo+
ID4gSkg3MTAwL0pINzExMC9KSEIxMDAgU29DLg0KPiA+DQo+ID4gSSB3aWxsIG1haW50YWluIHRo
aXMgcHdtIG1vZHVsZSBpbiBwbGFjZSBvZiBXaWxsaWFtLg0KPiA+DQo+ID4gQ2hhbmdlcyBzaW5j
ZSB2MjE6DQo+ID4gLSBBbGxvdyBub24temVybyBkdXR5IGN5Y2xlcyBzaG9ydGVyIHRoYW4gb25l
IGNsb2NrIHRpY2sgdG8gcm91bmQgZG93biB0bw0KPiA+ICAgemVyby4NCj4gPiAtIERyb3AgdGhl
IC5mcmVlKCkgY2FsbGJhY2sgdG8gcHJlc2VydmUgdGhlIFBXTSBoYXJkd2FyZSBzdGF0ZSBhZnRl
cg0KPiA+ICAgcHdtX3B1dCgpLg0KPiA+IC0gVXBkYXRlIHRoZSBjb21tZW50Lg0KPiA+DQo+ID4g
Wy4uLl0NCj4gDQo+IEhlcmUgaXMgdGhlIHN1bW1hcnkgd2l0aCBsaW5rczoNCj4gICAtIFtSRVNF
TkQsdjIyLDEvM10gZHQtYmluZGluZ3M6IHB3bTogb3BlbmNvcmVzOiBVcGRhdGUgY29tcGF0aWJs
ZXMsDQo+IGV4YW1wbGVzIGFuZCBtYWludGFpbmVycw0KPiAgICAgKG5vIG1hdGNoaW5nIGNvbW1p
dCkNCj4gICAtIFtSRVNFTkQsdjIyLDIvM10gcmlzY3Y6IGR0czogc3RhcmZpdmU6IENvcnJlY3Qg
cHdtIG5vZGVzDQo+ICAgICBodHRwczovL2dpdC5rZXJuZWwub3JnL3Jpc2N2L2MvMjE4NmVjNWY1
OWMyDQo+ICAgLSBbUkVTRU5ELHYyMiwzLzNdIHB3bTogQWRkIE9wZW5Db3JlcyBQVEMgUFdNIGRy
aXZlcg0KPiAgICAgKG5vIG1hdGNoaW5nIGNvbW1pdCkNCj4gDQo+IFlvdSBhcmUgYXdlc29tZSwg
dGhhbmsgeW91IQ0KPiAtLQ0KPiBEZWV0LWRvb3QtZG90LCBJIGFtIGEgYm90Lg0KPiBodHRwczov
L2tvcmcuZG9jcy5rZXJuZWwub3JnL3BhdGNod29yay9wd2JvdC5odG1sDQoNCkhpLCBDb25vciwN
Cg0KSGFzIHRoaXMgcGF0Y2ggc2VyaWVzIGJlZW4gYXBwbGllZD8gSSd2ZSBzZW50IG91dCB0aGUg
dXBkYXRlZCB2MjMgcGF0Y2ggc2VyaWVzLCBidXQNCktyenlzenRvZiBwb2ludGVkIG91dCB0aGUg
VGVzdGVkLWJ5IHRhZyBzaG91bGQgbm90IGJlIGFkZGVkIGluIHRoZSBkdC1iaW5kaW5ncyBwYXRj
aC4NClNob3VsZCBJIHNlbmQgYSB2MjQgdG8gZHJvcCB0aGUgVGVzdGVkLWJ5IHRhZyB0YWcsIG9y
IHNob3VsZCBJIG1ha2UgdGhlIGNoYW5nZXMgb24gdG9wDQpvZiB2MjIgaWYgaXQgaGFzIGFscmVh
ZHkgYmVlbiBhcHBsaWVkPw0KDQp2MjM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI2
MTAxNDExMDQyOS41Mjc2Mi0xLWhhbC5mZW5nQHN0YXJmaXZldGVjaC5jb20vDQoNCkJlc3QgcmVn
YXJkcywNCkhhbA0K
