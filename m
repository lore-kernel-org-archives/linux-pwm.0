From: Anson Huang <anson.huang@nxp.com>
Subject: RE: [PATCH V6 4/5] ARM: dts: imx7ulp: Add pwm0 support
Date: Tue, 19 Mar 2019 07:01:11 +0000
Message-ID: <DB3PR0402MB3916C788E11BB4C43B685AF5F5400@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1552977898-5590-1-git-send-email-Anson.Huang@nxp.com>
 <1552977898-5590-5-git-send-email-Anson.Huang@nxp.com>
 <20190319065434.mbadba7fi2hdncf4@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190319065434.mbadba7fi2hdncf4@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
Cc: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "stefan@agner.ch" <stefan@agner.ch>, "otavio@ossystems.com.br" <otavio@ossystems.com.br>, Leonard Crestez <leonard.crestez@nxp.com>, "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>, "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>, Robin Gong <yibin.gong@nxp.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>l
List-Id: linux-pwm@vger.kernel.org

DQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gRnJvbTogVXdlIEtsZWluZS1Lw7ZuaWcgW21haWx0bzp1LmtsZWluZS1rb2VuaWdA
cGVuZ3V0cm9uaXguZGVdDQo+IFNlbnQ6IDIwMTnlubQz5pyIMTnml6UgMTQ6NTUNCj4gVG86IEFu
c29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPg0KPiBDYzogdGhpZXJyeS5yZWRpbmdAZ21h
aWwuY29tOyByb2JoK2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOw0KPiBzaGF3
bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9u
aXguZGU7DQo+IGZlc3RldmFtQGdtYWlsLmNvbTsgbGludXhAYXJtbGludXgub3JnLnVrOyBzdGVm
YW5AYWduZXIuY2g7DQo+IG90YXZpb0Bvc3N5c3RlbXMuY29tLmJyOyBMZW9uYXJkIENyZXN0ZXog
PGxlb25hcmQuY3Jlc3RlekBueHAuY29tPjsNCj4gc2Nobml0emVsdG9ueUBnbWFpbC5jb207IGph
bi50dWVya0BlbXRyaW9uLmNvbTsgUm9iaW4gR29uZw0KPiA8eWliaW4uZ29uZ0BueHAuY29tPjsg
bGludXgtcHdtQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggVjYgNC81XSBBUk06IGR0czogaW14N3VscDogQWRkIHB3bTAgc3VwcG9y
dA0KPiANCj4gT24gVHVlLCBNYXIgMTksIDIwMTkgYXQgMDY6NTA6MjZBTSArMDAwMCwgQW5zb24g
SHVhbmcgd3JvdGU6DQo+ID4gQWRkIGkuTVg3VUxQIEVWSyBib2FyZCBQV00wIHN1cHBvcnQuDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4N
Cj4gPiAtLS0NCj4gPiBDaGFuZ2VzIHNpbmNlIFY1Og0KPiA+IAktIGNoYW5nZSAjcHdtLWNlbGxz
IHRvIDMuDQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDd1bHAtZXZrLmR0cyB8
IDEyICsrKysrKysrKysrKw0KPiA+ICBhcmNoL2FybS9ib290L2R0cy9pbXg3dWxwLmR0c2kgICAg
fCAxMCArKysrKysrKysrDQo+IA0KPiBJTUhPIHRoZSBjaGFuZ2UgdG8gdGhlIGV2ay5kdHMgYmVs
b25ncyBpbnRvIHRoZSBsYXN0IHBhdGNoLg0KDQpBaCwgeWVzLCB0aGUgUFdNIHBpbiBzZXR0aW5n
cyBpbiBib2FyZCBkdHMgc2hvdWxkIGJlbG9uZ3MgaW50byB0aGUgYmFja2xpZ2h0IHBhdGNoLA0K
SSB3aWxsIHJlc2VuZCBWNiwgdGhhbmtzLg0KDQpBbnNvbi4NCg0KPiANCj4gQmVzdCByZWdhcmRz
DQo+IFV3ZQ0KPiANCj4gLS0NCj4gUGVuZ3V0cm9uaXggZS5LLiAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgVXdlIEtsZWluZS1Lw7ZuaWcgICAgICAgICAgICB8DQo+IEluZHVzdHJpYWwgTGlu
dXggU29sdXRpb25zICAgICAgICAgICAgICAgICB8DQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtz
LnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGd3d3LnANCj4gZW5ndXRy
b25peC5kZSUyRiZhbXA7ZGF0YT0wMiU3QzAxJTdDYW5zb24uaHVhbmclNDBueHAuY29tJTdDZTMN
Cj4gNjQ1YTZkNGQ2NjQzYTFmODBmMDhkNmFjMzdjNzI1JTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNk
OTljNWMzMDE2MzUNCj4gJTdDMCU3QzAlN0M2MzY4ODU3NTI4OTcyMDg1NzImYW1wO3NkYXRhPU42
N3NtczlsWDZhc1hwWWFxJTJGdGYNCj4gVE5wTnolMkJlRElLTng4OSUyRjU3Q1lRQXdBJTNEJmFt
cDtyZXNlcnZlZD0wICB8DQo=
