From: Anson Huang <anson.huang@nxp.com>
Subject: RE: [EXT] Re: [PATCH V11 5/5] ARM: dts: imx7ulp-evk: Add backlight
 support
Date: Wed, 10 Apr 2019 02:07:05 +0000
Message-ID: <DB3PR0402MB3916897ABC422445D50A100BF52E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1554860547-18237-1-git-send-email-Anson.Huang@nxp.com>
 <1554860547-18237-6-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5C0oTaaFFVKC=72+5UGMRwvoxJAsBJNsAp5H_16gsXhVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOMZO5C0oTaaFFVKC=72+5UGMRwvoxJAsBJNsAp5H_16gsXhVA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "stefan@agner.ch" <stefan@agner.ch>, "otavio@ossystems.com.br" <otavio@ossystems.com.br>, Leonard Crestez <leonard.crestez@nxp.com>, Robin Gong <yibin.gong@nxp.com>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

SGksIEZhYmlvDQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmFiaW8gRXN0ZXZhbSBbbWFpbHRvOmZlc3RldmFtQGdt
YWlsLmNvbV0NCj4gU2VudDogMjAxOeW5tDTmnIgxMOaXpSAxMDowMw0KPiBUbzogQW5zb24gSHVh
bmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+IENjOiB0aGllcnJ5LnJlZGluZ0BnbWFpbC5jb207
IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207DQo+IHNoYXduZ3VvQGtl
cm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsN
Cj4gbGludXhAYXJtbGludXgub3JnLnVrOyBzdGVmYW5AYWduZXIuY2g7IG90YXZpb0Bvc3N5c3Rl
bXMuY29tLmJyOw0KPiBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPjsg
Um9iaW4gR29uZw0KPiA8eWliaW4uZ29uZ0BueHAuY29tPjsgdS5rbGVpbmUta29lbmlnQHBlbmd1
dHJvbml4LmRlOyBsaW51eC0NCj4gcHdtQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54
cC5jb20+DQo+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0ggVjExIDUvNV0gQVJNOiBkdHM6IGlt
eDd1bHAtZXZrOiBBZGQgYmFja2xpZ2h0DQo+IHN1cHBvcnQNCj4gDQo+IFdBUk5JTkc6IFRoaXMg
ZW1haWwgd2FzIGNyZWF0ZWQgb3V0c2lkZSBvZiBOWFAuIERPIE5PVCBDTElDSyBsaW5rcyBvcg0K
PiBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZCBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUuDQo+IA0KPiANCj4gDQo+IE9uIFR1ZSwgQXByIDksIDIwMTkgYXQg
MTA6NDcgUE0gQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+IHdyb3RlOg0KPiAN
Cj4gPiAgI2luY2x1ZGUgImlteDd1bHAuZHRzaSINCj4gPiArI2luY2x1ZGUgPGR0LWJpbmRpbmdz
L3B3bS9wd20uaD4NCj4gDQo+IFRoaXMgaW5jbHVzaW9uIGlzIG5vdCBuZWVkZWQgaGVyZSBhcyBQ
V01fUE9MQVJJVFlfSU5WRVJURUQgaXMgbm90IHVzZWQNCj4gaW4gdGhpcyBkdHMuDQoNClRoYW5r
cyBmb3IgcmVtaW5kZXIsIEkgd2lsbCByZW1vdmUgaXQgbGF0ZXIuDQoNCkFuc29uLg0KDQo=
