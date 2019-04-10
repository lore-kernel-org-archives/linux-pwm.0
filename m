From: Anson Huang <anson.huang@nxp.com>
Subject: [PATCH V11 5/5] ARM: dts: imx7ulp-evk: Add backlight support
Date: Wed, 10 Apr 2019 01:47:57 +0000
Message-ID: <1554860547-18237-6-git-send-email-Anson.Huang@nxp.com>
References: <1554860547-18237-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554860547-18237-1-git-send-email-Anson.Huang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "stefan@agner.ch" <stefan@agner.ch>, "otavio@ossystems.com.br" <otavio@ossystems.com.br>, Leonard Crestez <leonard.crestez@nxp.com>, Robin Gong <yibin.gong@nxp.com>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-arm-kernel@lists.infradead.org
Cc: dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-pwm@vger.kernel.org

VGhpcyBwYXRjaCBhZGRzIGkuTVg3VUxQIEVWSyBib2FyZCBNSVBJLURTSSBiYWNrbGlnaHQgc3Vw
cG9ydC4NCg0KU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+
DQotLS0NCk5vIGNoYW5nZXMuDQotLS0NCiBhcmNoL2FybS9ib290L2R0cy9pbXg3dWxwLWV2ay5k
dHMgfCAyMSArKysrKysrKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0
aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14N3VscC1ldmsuZHRz
IGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14N3VscC1ldmsuZHRzDQppbmRleCBhMDkwMjZhLi45NDg5
MWM3IDEwMDY0NA0KLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14N3VscC1ldmsuZHRzDQorKysg
Yi9hcmNoL2FybS9ib290L2R0cy9pbXg3dWxwLWV2ay5kdHMNCkBAIC04LDYgKzgsNyBAQA0KIC9k
dHMtdjEvOw0KIA0KICNpbmNsdWRlICJpbXg3dWxwLmR0c2kiDQorI2luY2x1ZGUgPGR0LWJpbmRp
bmdzL3B3bS9wd20uaD4NCiANCiAvIHsNCiAJbW9kZWwgPSAiTlhQIGkuTVg3VUxQIEVWSyI7DQpA
QCAtMjIsNiArMjMsMTQgQEANCiAJCXJlZyA9IDwweDYwMDAwMDAwIDB4NDAwMDAwMDA+Ow0KIAl9
Ow0KIA0KKwliYWNrbGlnaHQgew0KKwkJY29tcGF0aWJsZSA9ICJwd20tYmFja2xpZ2h0IjsNCisJ
CXB3bXMgPSA8JnRwbTQgMSA1MDAwMCAwPjsNCisJCWJyaWdodG5lc3MtbGV2ZWxzID0gPDAgMjAg
MjUgMzAgMzUgNDAgMTAwPjsNCisJCWRlZmF1bHQtYnJpZ2h0bmVzcy1sZXZlbCA9IDw2PjsNCisJ
CXN0YXR1cyA9ICJva2F5IjsNCisJfTsNCisNCiAJcmVnX3ZzZF8zdjM6IHJlZ3VsYXRvci12c2Qt
M3YzIHsNCiAJCWNvbXBhdGlibGUgPSAicmVndWxhdG9yLWZpeGVkIjsNCiAJCXJlZ3VsYXRvci1u
YW1lID0gIlZTRF8zVjMiOw0KQEAgLTQwLDYgKzQ5LDEyIEBADQogCXN0YXR1cyA9ICJva2F5IjsN
CiB9Ow0KIA0KKyZ0cG00IHsNCisJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCisJcGluY3Ry
bC0wID0gPCZwaW5jdHJsX3B3bTA+Ow0KKwlzdGF0dXMgPSAib2theSI7DQorfTsNCisNCiAmdXNk
aGMwIHsNCiAJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCiAJcGluY3RybC0wID0gPCZwaW5j
dHJsX3VzZGhjMD47DQpAQCAtNTcsNiArNzIsMTIgQEANCiAJCWJpYXMtcHVsbC11cDsNCiAJfTsN
CiANCisJcGluY3RybF9wd20wOiBwd20wZ3JwIHsNCisJCWZzbCxwaW5zID0gPA0KKwkJCUlNWDdV
TFBfUEFEX1BURjJfX1RQTTRfQ0gxCTB4Mg0KKwkJPjsNCisJfTsNCisNCiAJcGluY3RybF91c2Ro
YzA6IHVzZGhjMGdycCB7DQogCQlmc2wscGlucyA9IDwNCiAJCQlJTVg3VUxQX1BBRF9QVEQxX19T
REhDMF9DTUQJMHg0Mw0KLS0gDQoyLjcuNA0KDQo=
