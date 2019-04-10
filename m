From: Anson Huang <anson.huang@nxp.com>
Subject: [PATCH V11 4/5] ARM: dts: imx7ulp: Add tpm pwm support
Date: Wed, 10 Apr 2019 01:47:51 +0000
Message-ID: <1554860547-18237-5-git-send-email-Anson.Huang@nxp.com>
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

QWRkIGkuTVg3VUxQIEVWSyBib2FyZCBQV00gc3VwcG9ydC4NCg0KU2lnbmVkLW9mZi1ieTogQW5z
b24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQotLS0NCk5vIGNoYW5nZXMuDQotLS0NCiBh
cmNoL2FybS9ib290L2R0cy9pbXg3dWxwLmR0c2kgfCAxMCArKysrKysrKysrDQogMSBmaWxlIGNo
YW5nZWQsIDEwIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRz
L2lteDd1bHAuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDd1bHAuZHRzaQ0KaW5kZXggZDZi
NzExMC4uOGZiOTU1OSAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDd1bHAuZHRz
aQ0KKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14N3VscC5kdHNpDQpAQCAtMTI0LDYgKzEyNCwx
NiBAQA0KIAkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQogCQl9Ow0KIA0KKwkJdHBtNDogcHdtQDQw
MjUwMDAwIHsNCisJCQljb21wYXRpYmxlID0gImZzbCxpbXg3dWxwLXB3bSI7DQorCQkJcmVnID0g
PDB4NDAyNTAwMDAgMHgxMDAwPjsNCisJCQlhc3NpZ25lZC1jbG9ja3MgPSA8JnBjYzIgSU1YN1VM
UF9DTEtfTFBUUE00PjsNCisJCQlhc3NpZ25lZC1jbG9jay1wYXJlbnRzID0gPCZzY2cxIElNWDdV
TFBfQ0xLX1NPU0NfQlVTX0NMSz47DQorCQkJY2xvY2tzID0gPCZwY2MyIElNWDdVTFBfQ0xLX0xQ
VFBNND47DQorCQkJI3B3bS1jZWxscyA9IDwzPjsNCisJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0K
KwkJfTsNCisNCiAJCXRwbTU6IHRwbUA0MDI2MDAwMCB7DQogCQkJY29tcGF0aWJsZSA9ICJmc2ws
aW14N3VscC10cG0iOw0KIAkJCXJlZyA9IDwweDQwMjYwMDAwIDB4MTAwMD47DQotLSANCjIuNy40
DQoNCg==
