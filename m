From: Anson Huang <anson.huang@nxp.com>
Subject: RE: [PATCH] pwm: mxs: use devm_platform_ioremap_resource() to
 simplify code
Date: Tue, 20 Aug 2019 05:56:40 +0000
Message-ID: <DB3PR0402MB3916423A6E334EDD4C06B884F5AB0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190718013205.24919-1-Anson.Huang@nxp.com>
 <AM0PR04MB42116F0753C9C6A619A2D8EC80C80@AM0PR04MB4211.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM0PR04MB42116F0753C9C6A619A2D8EC80C80@AM0PR04MB4211.eurprd04.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Aisheng Dong <aisheng.dong@nxp.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-pwm@vger.kernel.org

R2VudGxlIHBpbmcuLi4NCg0KPiA+IEZyb206IEFuc29uLkh1YW5nQG54cC5jb20gPEFuc29uLkh1
YW5nQG54cC5jb20+DQo+ID4gU2VudDogVGh1cnNkYXksIEp1bHkgMTgsIDIwMTkgOTozMiBBTQ0K
PiA+DQo+ID4gVXNlIHRoZSBuZXcgaGVscGVyIGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJj
ZSgpIHdoaWNoIHdyYXBzIHRoZQ0KPiA+IHBsYXRmb3JtX2dldF9yZXNvdXJjZSgpIGFuZCBkZXZt
X2lvcmVtYXBfcmVzb3VyY2UoKSB0b2dldGhlciwgdG8NCj4gPiBzaW1wbGlmeSB0aGUgY29kZS4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29t
Pg0KPiANCj4gUmV2aWV3ZWQtYnk6IERvbmcgQWlzaGVuZyA8YWlzaGVuZy5kb25nQG54cC5jb20+
DQo+IA0KPiBSZWdhcmRzDQo+IEFpc2hlbmcNCg==
