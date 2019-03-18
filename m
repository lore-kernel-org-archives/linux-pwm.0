From: Anson Huang <anson.huang@nxp.com>
Subject: RE: [PATCH V4 2/5] pwm: Add i.MX TPM PWM driver support
Date: Mon, 18 Mar 2019 14:42:00 +0000
Message-ID: <DB3PR0402MB391633E42A4139C10A0A226DF5470@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1552610505-13568-1-git-send-email-Anson.Huang@nxp.com>
 <1552610505-13568-3-git-send-email-Anson.Huang@nxp.com>
 <20190315093532.xw5ivfkxrwvrkvix@pengutronix.de>
 <DB3PR0402MB39161B062231C59842595374F5470@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190318080743.xumj6e72bzumszvp@pengutronix.de>
 <DB3PR0402MB391627A8C741C84A2057E576F5470@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB39161A9884D5768F7280024FF5470@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190318141051.t2x2ddz73fmksadq@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190318141051.t2x2ddz73fmksadq@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
Cc: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "otavio@ossystems.com.br" <otavio@ossystems.com.br>, "stefan@agner.ch" <stefan@agner.ch>, Leonard Crestez <leonard.crestez@nxp.com>, "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>, "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>, Robin Gong <yibin.gong@nxp.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>l
List-Id: linux-pwm@vger.kernel.org

SGksIFV3ZQ0KCVllcywgSSB3aWxsIHBvc3QgYSBWNiwgYnV0IGJlZm9yZSBzZW5kaW5nIFY2LCBj
YW4geW91IGhlbHAgY29uZmlybSBpZiB5b3UgYWdyZWUgbXkgMiBhbnN3ZXJzIGZvciB5b3VyIGxh
c3QgY29tbWVudHMsIHN1Y2ggYXMgdGhlIGNvdW50ZXIgZGlzYWJsZSBmb3IgY2hhbmdpbmcgcHJl
c2NhbGUgYW5kIHRoZSBtdXRleCBsb2NrIGluIC5hcHBseSBmdW5jdGlvbj8NCg0KQmVzdCBSZWdh
cmRzIQ0KQW5zb24gSHVhbmcNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9t
OiBVd2UgS2xlaW5lLUvDtm5pZyBbbWFpbHRvOnUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5k
ZV0NCj4gU2VudDogMjAxOeW5tDPmnIgxOOaXpSAyMjoxMQ0KPiBUbzogQW5zb24gSHVhbmcgPGFu
c29uLmh1YW5nQG54cC5jb20+DQo+IENjOiB0aGllcnJ5LnJlZGluZ0BnbWFpbC5jb207IHJvYmgr
ZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207DQo+IHNoYXduZ3VvQGtlcm5lbC5v
cmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsNCj4gZmVz
dGV2YW1AZ21haWwuY29tOyBsaW51eEBhcm1saW51eC5vcmcudWs7IG90YXZpb0Bvc3N5c3RlbXMu
Y29tLmJyOw0KPiBzdGVmYW5AYWduZXIuY2g7IExlb25hcmQgQ3Jlc3RleiA8bGVvbmFyZC5jcmVz
dGV6QG54cC5jb20+Ow0KPiBzY2huaXR6ZWx0b255QGdtYWlsLmNvbTsgamFuLnR1ZXJrQGVtdHJp
b24uY29tOyBSb2JpbiBHb25nDQo+IDx5aWJpbi5nb25nQG54cC5jb20+OyBsaW51eC1wd21Admdl
ci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRD
SCBWNCAyLzVdIHB3bTogQWRkIGkuTVggVFBNIFBXTSBkcml2ZXIgc3VwcG9ydA0KPiANCj4gSGVs
bG8sDQo+IA0KPiBhcyB5b3UgZ290IHNvbWUgZmVlZGJhY2sgZm9yIHY1IGFscmVhZHkgSSBhc3N1
bWUgeW91IHdpbGwgcG9zdCBhIHY2Lg0KPiBJJ2xsIHNraXAgcmV2aWV3aW5nIHY1IHRoZW4uDQo+
IA0KPiBCZXN0IHJlZ2FyZHMNCj4gVXdlDQo+IA0KPiAtLQ0KPiBQZW5ndXRyb25peCBlLksuICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCBVd2UgS2xlaW5lLUvDtm5pZyAgICAgICAgICAgIHwN
Cj4gSW5kdXN0cmlhbCBMaW51eCBTb2x1dGlvbnMgICAgICAgICAgICAgICAgIHwNCj4gaHR0cHM6
Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYl
MkZ3d3cucA0KPiBlbmd1dHJvbml4LmRlJTJGJmFtcDtkYXRhPTAyJTdDMDElN0NhbnNvbi5odWFu
ZyU0MG54cC5jb20lN0M3OQ0KPiA3NTE0YWZmZmNiNGY3OTliZjQwOGQ2YWJhYjkxODglN0M2ODZl
YTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNQ0KPiAlN0MwJTdDMCU3QzYzNjg4NTE1MDcwNjQx
NzIwMSZhbXA7c2RhdGE9a1Z1dDFYOEp0akdkR09NMmN6eVJSYw0KPiA1ZGk3N0kySHU4ZFF0dGY4
REpuMUElM0QmYW1wO3Jlc2VydmVkPTAgIHwNCg==
