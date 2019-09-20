From: Anson Huang <anson.huang@nxp.com>
Subject: RE: [PATCH] pwm: mxs: use devm_platform_ioremap_resource() to
 simplify code
Date: Fri, 20 Sep 2019 08:49:53 +0000
Message-ID: <DB3PR0402MB39167A2F613F92FD8CA145C8F5880@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190718013205.24919-1-Anson.Huang@nxp.com>
 <AM0PR04MB42116F0753C9C6A619A2D8EC80C80@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916423A6E334EDD4C06B884F5AB0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190824002634.nfrhof3kpsrcc742@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190824002634.nfrhof3kpsrcc742@pengutronix.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
Cc: Aisheng Dong <aisheng.dong@nxp.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

UGluZy4uLiwgMSBtb250aCBwYXNzZWQsIE5PVCBzdXJlIHdoYXQgaXMgdGhlIGxhdGVzdCBzdGF0
dXMuDQoNCkFuc29uDQoNCj4gT24gVHVlLCBBdWcgMjAsIDIwMTkgYXQgMDU6NTY6NDBBTSArMDAw
MCwgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gR2VudGxlIHBpbmcuLi4NCj4gDQo+IE15IGltcHJl
c3Npb25bMV0gaXMgdGhhdCBUaGllcnJ5IGNvbGxlY3RzIHBhdGNoZXMgaW4gYnVsayBvbmNlIG9y
IHR3aWNlIHBlcg0KPiByZWxlYXNlIGN5Y2xlLiBUaGUgbGFzdCB0d28gc3VjaCBidWxrcyB3ZXJl
IGJldHdlZW4gNS4yLXJjNiBhbmQNCj4gNS4yLXJjNyBhbmQgaW4gdGhlIDUuMiBtZXJnZSB3aW5k
b3cuIFNvIGdpdmVuIHdlJ3JlIGF0IHY1LjMtcmM1IG5vdyBJIGV4cGVjdA0KPiBzb21lIGFjdGlv
biBzb29uIDotKQ0KPiANCj4gPiA+ID4gRnJvbTogQW5zb24uSHVhbmdAbnhwLmNvbSA8QW5zb24u
SHVhbmdAbnhwLmNvbT4NCj4gPiA+ID4gU2VudDogVGh1cnNkYXksIEp1bHkgMTgsIDIwMTkgOToz
MiBBTQ0KPiA+ID4gPg0KPiA+ID4gPiBVc2UgdGhlIG5ldyBoZWxwZXIgZGV2bV9wbGF0Zm9ybV9p
b3JlbWFwX3Jlc291cmNlKCkgd2hpY2ggd3JhcHMNCj4gPiA+ID4gdGhlDQo+ID4gPiA+IHBsYXRm
b3JtX2dldF9yZXNvdXJjZSgpIGFuZCBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoKSB0b2dldGhlciwg
dG8NCj4gPiA+ID4gc2ltcGxpZnkgdGhlIGNvZGUuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1v
ZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+ID4NCj4gPiA+IFJl
dmlld2VkLWJ5OiBEb25nIEFpc2hlbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KPiANCj4gQWNr
ZWQtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+
DQo+IA0KPiBCZXN0IHJlZ2FyZHMNCj4gVXdlDQo+IA0KPiBbMV0gZnJvbSBnaXQgbG9nIC0tY29t
bWl0dGVyPVRoaWVycnkgLS1mb3JtYXQ9JWNpIGRyaXZlcnMvcHdtIHwgY3V0IC1kXCAgLWYxIHwN
Cj4gdW5pcSAtYw0KPiAtLQ0KPiBQZW5ndXRyb25peCBlLksuICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCBVd2UgS2xlaW5lLUvDtm5pZyAgICAgICAgICAgIHwNCj4gSW5kdXN0cmlhbCBMaW51
eCBTb2x1dGlvbnMgICAgICAgICAgICAgICAgIHwNCj4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3Mu
cHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZ3d3cucA0KPiBlbmd1dHJv
bml4LmRlJTJGJmFtcDtkYXRhPTAyJTdDMDElN0NhbnNvbi5odWFuZyU0MG54cC5jb20lN0MzNA0K
PiBlZDc4ZTViOTA2NDJlNjE3M2QwOGQ3MjgyOWJjNjUlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5
OWM1YzMwMTYzDQo+IDUlN0MwJTdDMCU3QzYzNzAyMjAzMjAyNjc1NTMxMCZhbXA7c2RhdGE9Uk0w
RGpOOUIlMkZvbXhTU2xHcA0KPiBhZHhYNTB5WWVzTmpPQUZUWGFnaGt4eU9DUSUzRCZhbXA7cmVz
ZXJ2ZWQ9MCAgfA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtYXJtLWtlcm5lbAo=
