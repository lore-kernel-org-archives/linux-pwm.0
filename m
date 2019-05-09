From: Anson Huang <anson.huang@nxp.com>
Subject: [PATCH V12 5/5] ARM: dts: imx7ulp-evk: Add backlight support
Date: Thu, 9 May 2019 13:29:50 +0000
Message-ID: <1557408252-21281-6-git-send-email-Anson.Huang@nxp.com>
References: <1557408252-21281-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1557408252-21281-1-git-send-email-Anson.Huang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "otavio@ossystems.com.br" <otavio@ossystems.com.br>, Leonard Crestez <leonard.crestez@nxp.com>, Robin Gong <yibin.gong@nxp.com>, "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetre>
Cc: dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-pwm@vger.kernel.org

VGhpcyBwYXRjaCBhZGRzIGkuTVg3VUxQIEVWSyBib2FyZCBNSVBJLURTSSBiYWNrbGlnaHQgc3Vw
cG9ydC4NCg0KU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+
DQotLS0NCk5vIGNoYW5nZS4NCi0tLQ0KIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDd1bHAtZXZrLmR0
cyB8IDIwICsrKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlv
bnMoKykNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDd1bHAtZXZrLmR0cyBi
L2FyY2gvYXJtL2Jvb3QvZHRzL2lteDd1bHAtZXZrLmR0cw0KaW5kZXggYTA5MDI2YS4uNTlmMDk0
ZSAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDd1bHAtZXZrLmR0cw0KKysrIGIv
YXJjaC9hcm0vYm9vdC9kdHMvaW14N3VscC1ldmsuZHRzDQpAQCAtMjIsNiArMjIsMTQgQEANCiAJ
CXJlZyA9IDwweDYwMDAwMDAwIDB4NDAwMDAwMDA+Ow0KIAl9Ow0KIA0KKwliYWNrbGlnaHQgew0K
KwkJY29tcGF0aWJsZSA9ICJwd20tYmFja2xpZ2h0IjsNCisJCXB3bXMgPSA8JnRwbTQgMSA1MDAw
MCAwPjsNCisJCWJyaWdodG5lc3MtbGV2ZWxzID0gPDAgMjAgMjUgMzAgMzUgNDAgMTAwPjsNCisJ
CWRlZmF1bHQtYnJpZ2h0bmVzcy1sZXZlbCA9IDw2PjsNCisJCXN0YXR1cyA9ICJva2F5IjsNCisJ
fTsNCisNCiAJcmVnX3ZzZF8zdjM6IHJlZ3VsYXRvci12c2QtM3YzIHsNCiAJCWNvbXBhdGlibGUg
PSAicmVndWxhdG9yLWZpeGVkIjsNCiAJCXJlZ3VsYXRvci1uYW1lID0gIlZTRF8zVjMiOw0KQEAg
LTQwLDYgKzQ4LDEyIEBADQogCXN0YXR1cyA9ICJva2F5IjsNCiB9Ow0KIA0KKyZ0cG00IHsNCisJ
cGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCisJcGluY3RybC0wID0gPCZwaW5jdHJsX3B3bTA+
Ow0KKwlzdGF0dXMgPSAib2theSI7DQorfTsNCisNCiAmdXNkaGMwIHsNCiAJcGluY3RybC1uYW1l
cyA9ICJkZWZhdWx0IjsNCiAJcGluY3RybC0wID0gPCZwaW5jdHJsX3VzZGhjMD47DQpAQCAtNTcs
NiArNzEsMTIgQEANCiAJCWJpYXMtcHVsbC11cDsNCiAJfTsNCiANCisJcGluY3RybF9wd20wOiBw
d20wZ3JwIHsNCisJCWZzbCxwaW5zID0gPA0KKwkJCUlNWDdVTFBfUEFEX1BURjJfX1RQTTRfQ0gx
CTB4Mg0KKwkJPjsNCisJfTsNCisNCiAJcGluY3RybF91c2RoYzA6IHVzZGhjMGdycCB7DQogCQlm
c2wscGlucyA9IDwNCiAJCQlJTVg3VUxQX1BBRF9QVEQxX19TREhDMF9DTUQJMHg0Mw0KLS0gDQoy
LjcuNA0KDQo=
