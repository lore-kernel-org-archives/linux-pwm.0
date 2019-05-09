From: Anson Huang <anson.huang@nxp.com>
Subject: [PATCH V12 4/5] ARM: dts: imx7ulp: Add tpm pwm support
Date: Thu, 9 May 2019 13:29:41 +0000
Message-ID: <1557408252-21281-5-git-send-email-Anson.Huang@nxp.com>
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

QWRkIGkuTVg3VUxQIEVWSyBib2FyZCBQV00gc3VwcG9ydC4NCg0KU2lnbmVkLW9mZi1ieTogQW5z
b24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQotLS0NCk5vIGNoYW5nZS4NCi0tLQ0KIGFy
Y2gvYXJtL2Jvb3QvZHRzL2lteDd1bHAuZHRzaSB8IDEwICsrKysrKysrKysNCiAxIGZpbGUgY2hh
bmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMv
aW14N3VscC5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14N3VscC5kdHNpDQppbmRleCBkNmI3
MTEwLi44ZmI5NTU5IDEwMDY0NA0KLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14N3VscC5kdHNp
DQorKysgYi9hcmNoL2FybS9ib290L2R0cy9pbXg3dWxwLmR0c2kNCkBAIC0xMjQsNiArMTI0LDE2
IEBADQogCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCiAJCX07DQogDQorCQl0cG00OiBwd21ANDAy
NTAwMDAgew0KKwkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDd1bHAtcHdtIjsNCisJCQlyZWcgPSA8
MHg0MDI1MDAwMCAweDEwMDA+Ow0KKwkJCWFzc2lnbmVkLWNsb2NrcyA9IDwmcGNjMiBJTVg3VUxQ
X0NMS19MUFRQTTQ+Ow0KKwkJCWFzc2lnbmVkLWNsb2NrLXBhcmVudHMgPSA8JnNjZzEgSU1YN1VM
UF9DTEtfU09TQ19CVVNfQ0xLPjsNCisJCQljbG9ja3MgPSA8JnBjYzIgSU1YN1VMUF9DTEtfTFBU
UE00PjsNCisJCQkjcHdtLWNlbGxzID0gPDM+Ow0KKwkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQor
CQl9Ow0KKw0KIAkJdHBtNTogdHBtQDQwMjYwMDAwIHsNCiAJCQljb21wYXRpYmxlID0gImZzbCxp
bXg3dWxwLXRwbSI7DQogCQkJcmVnID0gPDB4NDAyNjAwMDAgMHgxMDAwPjsNCi0tIA0KMi43LjQN
Cg0K
