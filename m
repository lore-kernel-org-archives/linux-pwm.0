Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.130
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794021807;
	b=IeLqYFexg74pHzD1sXV3rnoWVQCsYJZPLfqwhJjTqxw1pzU3pJWXCmjikDP4QR+Lr04U
	 UXD1l7yWrMwOmBUojlujAN7EeyK7AZ4GCLr2yveX5ktvY6+bhCIEqI9i0oPfP39lJAXNn
	 kIUuEHx3KWghTzCUWgnm/cy+kI7BHkN0v5ear0KJrf06QDEk2u7gQWImrHYREXFFrd5t6
	 tmfKv0zEVixgYOyqwS0rz4g/lJ7TZWFawq2DLXlUDW3/K0EtB9+Wuo6kjmh4YSu1jSSOe
	 ODRgUh/kVBdtRMkt1y790QEDcDWQNY2pDFLykXbM9ZxTbI5wmWHpgpGlOeeIhKV9Bww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794021807;
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
	bh=dnqz1cHie14+s4kyIfjZWJPcD2V22c6JdUl+C5oo55Q=;
	b=MX1T2+Ur7Z/DUYJYphYUk0YPBgfFVq9LhEXUkGOpaC/B6coQCA2GxpIfyUKeD65AtJLa
	 WSHz/Rx87KKJyFWfA+yG7ptKT4Oq5+IqWQtahSQ+A91YFHuv9IUGJcWzKUqkYIUkPkaqn
	 fZgAEY/LYNse5uQSZpBrjO2Xd3YkzjMyd9I/YiS3IP6zOsjvNfvdJoTLgO3wZSrgqMV0g
	 gG6B6bhvm5p4OloVU4z8epwm3MeGEgff0WiIGVxLgDyz1V2Qv1vD5RwL9n8GyuIgQgh/N
	 /DbBC0/dtdiRYULPBN2QMkQdW8vA46nGaUy1c+HJIEkfrqLwc2ZgrYaciP161/+BTmQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=starfivetech.com;
	spf=pass smtp.mailfrom=starfivetech.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.130
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2130.outbound.protection.partner.outlook.cn [139.219.17.130])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1801D606A326;
	Sat,  7 Nov 2026 03:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1801D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZdy24yRnC+YSbAXKLtByYnoAdVqCBTfC+cbYuxMzO+r2BRWWxZnu/4OhCmlw8o77BuF7TiSyZqmu5etPDVBp0bMjcKdyCrbkDse6P95tw3Q8FZyyafOCKJxZbjP0SwAD8hDBX1SfkHBFSJN5F9ZiVxSwDrV5XHSTNr2E5eAFiFU/JOefgzynikvKcSfKolxCTYviL+nswprr1IfLFNjZtP4cpDxXy9j5buDahyu8wu9S2gbXcPVPUhyCJ5HWswA78CZ5QgBzdxBxOFs8tsZk9LqNgfnmomtUMETlbYt+9AAM1Kwo2NTy8bU+PPgaePtbWjtWlZ7DdcZXLLVtLzPtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnqz1cHie14+s4kyIfjZWJPcD2V22c6JdUl+C5oo55Q=;
 b=nNXWbn3qcHPnBoJnBW2clg4xu9wMhFF639iCGrqqEpbUzxR1tCMnZyWb4mrX2bNjsMjjr8s1StLp1NvkGZl17K5Uh4t5JkKku3oEkjhtFOc56ZpEgttOurhtNXC7fL+CUtHUl0Yr/fW0hoHT3fvtRaTCJkEEtyZMPbk9LcKNl/dCQxoFTsBUVPmrY9xD2Jbq+PHD/eRgEU6ynDzFYNKuI3HVwRL3CRlVgAyGfU6BAD2le+UP6AbYZ+nTC3rbtWBaeBZiW1WEA+9BfSOmv3FBXwrCHtvnobDDwrN9Y+loLEghOYjpPe8NxLzS0I3mW+buPZcof6ni2muFT1IT6KfblQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:7::10) by NT0PR01MB0957.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 03:23:12 +0000
Received: from NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
 ([fe80::be4a:d29e:5188:b37e]) by
 NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn ([fe80::be4a:d29e:5188:b37e%3])
 with mapi id 15.21.0592.010; Sat, 7 Nov 2026 03:23:12 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Conor Dooley <conor@kernel.org>, "ukleinek@kernel.org"
	<ukleinek@kernel.org>
CC: "patchwork-bot+linux-riscv@kernel.org"
	<patchwork-bot+linux-riscv@kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "p.zabel@pengutronix.de"
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
Thread-Index: AQHdKHVcUHYiMwEYKEiLBGQTFfpjtLcaTHiAgAA6KyCAAIl/AIAAo5kAgAbIThA=
Date: Sat, 7 Nov 2026 03:23:12 +0000
Message-ID:
 <NT0PR01MB110240F13DA3D2EEBC9528A6E6752@NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn>
References: <20260810030714.48100-1-hal.feng@starfivetech.com>
 <179357141185.2624073.8394896290201314670.git-patchwork-notify@kernel.org>
 <NT0PR01MB11026FD52BC4266EFFEACBD5E66A2@NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn>
 <auheO4sRs4P36jgw@monoceros> <20261102-tidal-quintet-3867b525d891@spud>
In-Reply-To: <20261102-tidal-quintet-3867b525d891@spud>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NT0PR01MB1102:EE_|NT0PR01MB0957:EE_
x-ms-office365-filtering-correlation-id: 54838b51-c652-4abc-0a6d-08df3c7e7472
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|38070700021|261102123227099003|4143699003|261021121427099003|56012099006|261022075727099003|261009223027099003|261022105027099003|261026140227099003|261026121527099003|261028144727099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 uJhWbQT/ldU6ue7Yh+YCUfvJ+Jr55IJROuycZ9MPt07dyzWeGfstl8QylYm5Ce3yqEuTaCHWwX2tgPBOGbiBc5w59wy/xEIoJRnVd2YQUvHVmNXbfwXrCNaa5kGqRKabWHlBy8xh2ql/K/3I9FpoetnZAR2ifFulot5ABZkMH4NoDS2qm6Y0JobFxZFzO0fY/IqS8nNH9WAlYPFsqZ4A9tzFrZW/ZnXxOTKBVQHxSIJXvORQEKP1esLIsE0OOH3RS6WeO2F+CQC3OXhkPFps5zuFDlXYrtgUe84pAH0dFksod0UUl8g+2nNJZ1ZH64NYb5GzlmpaemfkPA1+Ae4knGn4yYZMUxkNt17rvydXZdf52hp1aiAuBYI7qxma8DGqjA579bZcOI/RlbGrGIvpAlexm5MGgleiW7AY9lnQ1/oqd3pRfw/u7fuLTX3Oel9jN7AiH2iLMmSIr2T5bG9SZUFyAwh7zhq+mMl56rKkB+p1009o4mJsRxRALR+NOTjUqeMrT/KQfNfkKZH6NpUAf6Ayw9NPmhcA4RHqLeuHIz8vQKLGH94VVNuByDSDTmon
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(38070700021)(261102123227099003)(4143699003)(261021121427099003)(56012099006)(261022075727099003)(261009223027099003)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JzNDKsHa9eH78OLM3KZK4q1hzCbUhl+DircNcSPhQXRicC/TIQqnJv10HvL0?=
 =?us-ascii?Q?ZcJLLFXJSLs3c8TmeVT3LiooQt/a2etnYvp2Vc0MdiGxEutcNYZzpS7wk9GZ?=
 =?us-ascii?Q?rRmWxia5lkk7R66wtXpWgphkpQ79ml1Q0RxDPRWgJhck8tq+iMF+DfR0NHvt?=
 =?us-ascii?Q?cQyVQNPzQdSu40FHWLETX2gXEbQEYP5toxAzgjGAn4IAOPEiQ3TPwzGTS/LU?=
 =?us-ascii?Q?gu++PXchqIjSq0R1ZN+fDAcefzbJmSgV7MRiW+tpSkqflThc9eYbcDthmGYM?=
 =?us-ascii?Q?nPcp9F+tcYCabCgKPDpTgWaYBPhZmEfhh5yB1Z3p4OWlh88w6fBQ7rbl1Wzd?=
 =?us-ascii?Q?C5V+iDSo+eRccmxx93U5HLJ13xwwiRBDVwm/dHc047/yydo8V4ESTXIrydYy?=
 =?us-ascii?Q?BhW0F+dT4b/I2ZyCxbSK7xFOwMBvQa3zcY8xEIe1aXl831qBP4mKg/pHe9Kh?=
 =?us-ascii?Q?X0DWnTzTCv3MYBc3YCUYQkZdASl7veWRDHGMA+DHhLO9bMZSwZZ06UMq1mh6?=
 =?us-ascii?Q?fKa6oY4gxD3SZmx+367vDrRVQeWIEZ4Bf8gOlUw/9p0yV0EgjXwI9UuzIemN?=
 =?us-ascii?Q?O5OJmSO//VkxztN+uMzsO3aabyubQB6/u/DAoO5Q4ODTKesyy+9wEU3rtX4d?=
 =?us-ascii?Q?mRyuWc8tD3cFXOMtISSMzJGRZu+qi/9qkB7HPvpHImgVKNnJThSZAp2SoQP+?=
 =?us-ascii?Q?lIX38aChYeyDgcvPbs/LjQp3g50Sr94k+bkOwHAhGtWTN+IInojES5JEq5g3?=
 =?us-ascii?Q?17gVaTDQI1THFQD3tEofv6gMPZvfqQBsIRevBowD2Tz2pWa4UpQq7kKVma8d?=
 =?us-ascii?Q?3WpIeYQqT2NlykConBsMXbM+gokMIn1VG72xo4ItE3lfmsW82P2QE+5UyDsD?=
 =?us-ascii?Q?bQQe0Y/v5AdaTZ1/bx0Iw6scSrttd7adKQYVKHl6WQP2tfCMcgHRHOY08AER?=
 =?us-ascii?Q?yH2Pw4IKtJz4GByD4xkIzHLWeVZkfBrt8zSqwkVLRsYiymRtRXFRbI+nnymz?=
 =?us-ascii?Q?VIshUIVAd8IM5ucP9uX/j2QanXEpeXEfvRrFCTEoSSR6/wsIZta+8Ib+3KLZ?=
 =?us-ascii?Q?ODeX8xN7YbCg4CAb6kNfHTgLSrLkpevHS8l1xmk3r5M5kbibxHm4ai2gW/Gt?=
 =?us-ascii?Q?O8uTQvJAE22NXy5mCq0IayhBMzUJVB0Ugu16aVya3CMb6fgR81vztzg+MeWb?=
 =?us-ascii?Q?6f/CB83dhGkwUOAMOsq82EU6c9rgtFBzB/+/094t0y0Ijc0xl7uwVaKl5kBm?=
 =?us-ascii?Q?+6HHEsNkrhjYMIRM2nvDpMFuuA/1Q7nPIOSx123HU207pcr7y7YJyQUjom8R?=
 =?us-ascii?Q?ZKkjmdy3vf9srAfAQjscAXqyrYSWvkLUsDZqXYm+kl09kT2qegNdJiT5QAaY?=
 =?us-ascii?Q?Qi9u9Ecm1NoHkOBVl5v9HjPn0MsqFMnu5/8dEvSHkiYrTcCTNZDkFYJ1Ej7c?=
 =?us-ascii?Q?8dIx78ckqK603gtTEOVhdxg9VGV+2W14pCMoFSpFY5Nj20AGoj7sLQl7zQjy?=
 =?us-ascii?Q?yeiw1Bs/gB/qmdalAHSLHkMmpfZHe4AQ0iLmEmeuV6SsX3ULGKgNtikTcEV5?=
 =?us-ascii?Q?ZCN+yhFxNB4IqYygvh5vUWaEuAxBax0kWH0wI70eGZ1oUqA8cbqAxb3740/x?=
 =?us-ascii?Q?AKLzAjCDbq1TtbEDvCIgPE3cMPDImh7lMKIaaV39wPefHfIM+sIY/l6Fgq1s?=
 =?us-ascii?Q?SV7G6PcgvHI/aMRxeRpz7vXsk2Psf1BzV0uf4pwxwOQWnLnONYmugn4ljlLb?=
 =?us-ascii?Q?OfXtLdWenA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
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
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 54838b51-c652-4abc-0a6d-08df3c7e7472
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2026 03:23:12.6864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IJ4RyN20dp5KJERDy5aEa1P8hwfFG/Zf76mA7A0TiAdlyXB5lUSEQWF4fjZ0el7MFRI0xtcFEDB5A4Tll2tqPonxZA4gLsyD2iUOeURA7pk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB0957

> On 26.11.3 03:43, Conor Dooley wrote:
> On Mon, Nov 02, 2026 at 10:57:10AM +0100, ukleinek@kernel.org wrote:
> > Hello,
> >
> > On Mon, Nov 02, 2026 at 02:11:46AM +0000, Hal Feng wrote:
> > > > On 26.11.2 06:17, patchwork-bot+linux-riscv wrote:
> > > > This series was applied to riscv/linux.git (fixes) by Conor Dooley
> > > > <conor.dooley@microchip.com>:
> > > >
> > > > On Mon, 10 Aug 2026 11:07:11 +0800 you wrote:
> > > > > Add OpenCores PTC PWM driver which is used in StarFive
> > > > > JH7100/JH7110/JHB100 SoC.
> > > > >
> > > > > I will maintain this pwm module in place of William.
> > > > >
> > > > > Changes since v21:
> > > > > - Allow non-zero duty cycles shorter than one clock tick to round=
 down
> to
> > > > >   zero.
> > > > > - Drop the .free() callback to preserve the PWM hardware state af=
ter
> > > > >   pwm_put().
> > > > > - Update the comment.
> > > > >
> > > > > [...]
> > > >
> > > > Here is the summary with links:
> > > >   - [RESEND,v22,1/3] dt-bindings: pwm: opencores: Update
> > > > compatibles, examples and maintainers
> > > >     (no matching commit)
> > > >   - [RESEND,v22,2/3] riscv: dts: starfive: Correct pwm nodes
> > > >     https://git.kernel.org/riscv/c/2186ec5f59c2
> > > >   - [RESEND,v22,3/3] pwm: Add OpenCores PTC PWM driver
> > > >     (no matching commit)
> > > >
> > > > You are awesome, thank you!
> > > > --
> > > > Deet-doot-dot, I am a bot.
> > > > https://korg.docs.kernel.org/patchwork/pwbot.html
> > >
> > > Has this patch series been applied? I've sent out the updated v23
> > > patch series, but Krzysztof pointed out the Tested-by tag should not =
be
> added in the dt-bindings patch.
> > > Should I send a v24 to drop the Tested-by tag tag, or should I make
> > > the changes on top of v22 if it has already been applied?
> >
> > The way I read it, only patch 2/3 "riscv: dts: starfive: Correct pwm
> > nodes" was applied.
>=20
> Yeah. And the mail is a quirk of me not removing the thread from the
> linux-riscv patchwork and pw-bot autoresponding when the series was
> "applied" by me to that tree when Paul fast-forwarded it.
> There should have been a b4-ty email from me a while ago saying that I ha=
d
> applied the dts patch.

I've sent out the v24, please check it.

https://lore.kernel.org/all/20261107031251.98972-1-hal.feng@starfivetech.co=
m/

Best regards,
Hal
