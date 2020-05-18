From: Aisheng Dong <aisheng.dong-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [PATCH] dt-bindings: pwm: Convert mxs pwm to json-schema
Date: Mon, 18 May 2020 06:07:06 +0000
Message-ID: <AM6PR04MB4966D0851412CE57C860B63C80B80@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1589456470-2658-1-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB4966B92CFFA23DD77748C77680B80@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916B5980C0681BFF3C08FE5F5B80@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <DB3PR0402MB3916B5980C0681BFF3C08FE5F5B80-RiGJ/uiH22/dnrWYgSyJ1I3W/0Ik+aLCnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anson Huang <anson.huang-3arQi8VN3Tc@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: dl-linux-imx <linux-imx-3arQi8VN3Tc@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gU2VudDogTW9uZGF5
LCBNYXkgMTgsIDIwMjAgMTozMiBQTQ0KPiANCj4gPiBTdWJqZWN0OiBSRTogW1BBVENIXSBkdC1i
aW5kaW5nczogcHdtOiBDb252ZXJ0IG14cyBwd20gdG8ganNvbi1zY2hlbWENCj4gPg0KPiA+ID4g
K3RpdGxlOiBGcmVlc2NhbGUgTVhTIFBXTSBjb250cm9sbGVyDQo+ID4gPiArDQo+ID4gPiArbWFp
bnRhaW5lcnM6DQo+ID4gPiArICAtIFNoYXduIEd1byA8c2hhd24uZ3VvQGxpbmFyby5vcmc+DQo+
ID4gPiArICAtIEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPg0KPiA+ID4gKw0KPiA+
ID4gK3Byb3BlcnRpZXM6DQo+ID4gPiArICBjb21wYXRpYmxlOg0KPiA+ID4gKyAgICBlbnVtOg0K
PiA+ID4gKyAgICAgIC0gZnNsLGlteDIzLXB3bQ0KPiA+ID4gKw0KPiA+ID4gKyAgcmVnOg0KPiA+
ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ID4gKw0KPiA+ID4gKyAgIiNwd20tY2VsbHMiOg0KPiA+
ID4gKyAgICBjb25zdDogMw0KPiA+DQo+ID4gU2VlbXMgeW91IG1pc3NlZCB0aGUgcmVmZXJlbmNl
IHRvIHB3bS55YW1sLg0KPiANCj4gSXQgaXMgYmVjYXVzZSBtYW55IHB3bSB5YW1sIGZpbGVzIGFs
c28gaGFzIG5vICIjcHdtLWNlbGxzIiByZWZlcmVuY2UsIHNvIEkgYW0NCj4gTk9UIHN1cmUgaWYg
aXQgaXMgYSBNVVNUOg0KPiANCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3
bS9hbGx3aW5uZXIsc3VuNGktYTEwLXB3bS55YW1sDQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9wd20vZ29vZ2xlLGNyb3MtZWMtcHdtLnlhbWwNCj4gRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9pcXM2MjBhLXB3bS55YW1sDQo+IC4uLg0KDQpJIGd1ZXNz
IHdlJ2QgYmV0dGVyIGFkZCBpdC4NCkxldCdzIHdhaXQgZm9yIFJvYidzIGZlZWRiYWNrLg0KDQpS
ZWdhcmRzDQpBaXNoZW5nDQoNCj4gDQo+IEFuc29uDQo=
