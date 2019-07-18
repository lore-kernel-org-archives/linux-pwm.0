From: Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: [PATCH] pwm: mxs: use devm_platform_ioremap_resource() to
 simplify code
Date: Thu, 18 Jul 2019 03:35:08 +0000
Message-ID: <AM0PR04MB42116F0753C9C6A619A2D8EC80C80@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190718013205.24919-1-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190718013205.24919-1-Anson.Huang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-pwm@vger.kernel.org

PiBGcm9tOiBBbnNvbi5IdWFuZ0BueHAuY29tIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiBTZW50
OiBUaHVyc2RheSwgSnVseSAxOCwgMjAxOSA5OjMyIEFNDQo+IA0KPiBVc2UgdGhlIG5ldyBoZWxw
ZXIgZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKCkgd2hpY2ggd3JhcHMgdGhlDQo+IHBs
YXRmb3JtX2dldF9yZXNvdXJjZSgpIGFuZCBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoKSB0b2dldGhl
ciwgdG8gc2ltcGxpZnkNCj4gdGhlIGNvZGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBI
dWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IERvbmcgQWlzaGVuZyA8
YWlzaGVuZy5kb25nQG54cC5jb20+DQoNClJlZ2FyZHMNCkFpc2hlbmcNCg==
