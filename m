From: Anson Huang <anson.huang@nxp.com>
Subject: [PATCH V11 1/5] dt-bindings: pwm: Add i.MX TPM PWM binding
Date: Wed, 10 Apr 2019 01:47:34 +0000
Message-ID: <1554860547-18237-2-git-send-email-Anson.Huang@nxp.com>
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

QWRkIGkuTVggVFBNKExvdyBQb3dlciBUaW1lci9QdWxzZSBXaWR0aCBNb2R1bGF0aW9uIE1vZHVs
ZSkgUFdNIGJpbmRpbmcuDQoNClNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFu
Z0BueHAuY29tPg0KUmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQot
LS0NCk5vIGNoYW5nZXMuDQotLS0NCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vaW14LXRw
bS1wd20udHh0ICAgICAgICB8IDIyICsrKysrKysrKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hh
bmdlZCwgMjIgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvcHdtL2lteC10cG0tcHdtLnR4dA0KDQpkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9pbXgtdHBtLXB3bS50eHQgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL2lteC10cG0tcHdtLnR4dA0KbmV3
IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAuLjNiYTk1OGQNCi0tLSAvZGV2L251bGwN
CisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vaW14LXRwbS1wd20u
dHh0DQpAQCAtMCwwICsxLDIyIEBADQorRnJlZXNjYWxlIGkuTVggVFBNIFBXTSBjb250cm9sbGVy
DQorDQorUmVxdWlyZWQgcHJvcGVydGllczoNCistIGNvbXBhdGlibGUgOiBTaG91bGQgYmUgImZz
bCxpbXg3dWxwLXB3bSIuDQorLSByZWc6IFBoeXNpY2FsIGJhc2UgYWRkcmVzcyBhbmQgbGVuZ3Ro
IG9mIHRoZSBjb250cm9sbGVyJ3MgcmVnaXN0ZXJzLg0KKy0gI3B3bS1jZWxsczogU2hvdWxkIGJl
IDMuIFNlZSBwd20udHh0IGluIHRoaXMgZGlyZWN0b3J5IGZvciBhIGRlc2NyaXB0aW9uIG9mIHRo
ZSBjZWxscyBmb3JtYXQuDQorLSBjbG9ja3MgOiBUaGUgY2xvY2sgcHJvdmlkZWQgYnkgdGhlIFNv
QyB0byBkcml2ZSB0aGUgUFdNLg0KKy0gaW50ZXJydXB0czogVGhlIGludGVycnVwdCBmb3IgdGhl
IFBXTSBjb250cm9sbGVyLg0KKw0KK05vdGU6IFRoZSBUUE0gY291bnRlciBhbmQgcGVyaW9kIGNv
dW50ZXIgYXJlIHNoYXJlZCBiZXR3ZWVuIG11bHRpcGxlIGNoYW5uZWxzLCBzbyBhbGwgY2hhbm5l
bHMNCitzaG91bGQgdXNlIHNhbWUgcGVyaW9kIHNldHRpbmcuDQorDQorRXhhbXBsZToNCisNCit0
cG00OiBwd21ANDAyNTAwMDAgew0KKwljb21wYXRpYmxlID0gImZzbCxpbXg3dWxwLXB3bSI7DQor
CXJlZyA9IDwweDQwMjUwMDAwIDB4MTAwMD47DQorCWFzc2lnbmVkLWNsb2NrcyA9IDwmcGNjMiBJ
TVg3VUxQX0NMS19MUFRQTTQ+Ow0KKwlhc3NpZ25lZC1jbG9jay1wYXJlbnRzID0gPCZzY2cxIElN
WDdVTFBfQ0xLX1NPU0NfQlVTX0NMSz47DQorCWNsb2NrcyA9IDwmcGNjMiBJTVg3VUxQX0NMS19M
UFRQTTQ+Ow0KKwkjcHdtLWNlbGxzID0gPDM+Ow0KK307DQotLSANCjIuNy40DQoNCg==
