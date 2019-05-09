From: Anson Huang <anson.huang@nxp.com>
Subject: [PATCH V12 1/5] dt-bindings: pwm: Add i.MX TPM PWM binding
Date: Thu, 9 May 2019 13:29:19 +0000
Message-ID: <1557408252-21281-2-git-send-email-Anson.Huang@nxp.com>
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

QWRkIGkuTVggVFBNKExvdyBQb3dlciBUaW1lci9QdWxzZSBXaWR0aCBNb2R1bGF0aW9uIE1vZHVs
ZSkgUFdNIGJpbmRpbmcuDQoNClNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFu
Z0BueHAuY29tPg0KUmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQot
LS0NCk5vIGNoYW5nZS4NCi0tLQ0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9pbXgtdHBt
LXB3bS50eHQgICAgICAgIHwgMjIgKysrKysrKysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFu
Z2VkLCAyMiBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vaW14LXRwbS1wd20udHh0DQoNCmRpZmYgLS1naXQgYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL2lteC10cG0tcHdtLnR4dCBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vaW14LXRwbS1wd20udHh0DQpuZXcg
ZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMC4uM2JhOTU4ZA0KLS0tIC9kZXYvbnVsbA0K
KysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9pbXgtdHBtLXB3bS50
eHQNCkBAIC0wLDAgKzEsMjIgQEANCitGcmVlc2NhbGUgaS5NWCBUUE0gUFdNIGNvbnRyb2xsZXIN
CisNCitSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KKy0gY29tcGF0aWJsZSA6IFNob3VsZCBiZSAiZnNs
LGlteDd1bHAtcHdtIi4NCistIHJlZzogUGh5c2ljYWwgYmFzZSBhZGRyZXNzIGFuZCBsZW5ndGgg
b2YgdGhlIGNvbnRyb2xsZXIncyByZWdpc3RlcnMuDQorLSAjcHdtLWNlbGxzOiBTaG91bGQgYmUg
My4gU2VlIHB3bS50eHQgaW4gdGhpcyBkaXJlY3RvcnkgZm9yIGEgZGVzY3JpcHRpb24gb2YgdGhl
IGNlbGxzIGZvcm1hdC4NCistIGNsb2NrcyA6IFRoZSBjbG9jayBwcm92aWRlZCBieSB0aGUgU29D
IHRvIGRyaXZlIHRoZSBQV00uDQorLSBpbnRlcnJ1cHRzOiBUaGUgaW50ZXJydXB0IGZvciB0aGUg
UFdNIGNvbnRyb2xsZXIuDQorDQorTm90ZTogVGhlIFRQTSBjb3VudGVyIGFuZCBwZXJpb2QgY291
bnRlciBhcmUgc2hhcmVkIGJldHdlZW4gbXVsdGlwbGUgY2hhbm5lbHMsIHNvIGFsbCBjaGFubmVs
cw0KK3Nob3VsZCB1c2Ugc2FtZSBwZXJpb2Qgc2V0dGluZy4NCisNCitFeGFtcGxlOg0KKw0KK3Rw
bTQ6IHB3bUA0MDI1MDAwMCB7DQorCWNvbXBhdGlibGUgPSAiZnNsLGlteDd1bHAtcHdtIjsNCisJ
cmVnID0gPDB4NDAyNTAwMDAgMHgxMDAwPjsNCisJYXNzaWduZWQtY2xvY2tzID0gPCZwY2MyIElN
WDdVTFBfQ0xLX0xQVFBNND47DQorCWFzc2lnbmVkLWNsb2NrLXBhcmVudHMgPSA8JnNjZzEgSU1Y
N1VMUF9DTEtfU09TQ19CVVNfQ0xLPjsNCisJY2xvY2tzID0gPCZwY2MyIElNWDdVTFBfQ0xLX0xQ
VFBNND47DQorCSNwd20tY2VsbHMgPSA8Mz47DQorfTsNCi0tIA0KMi43LjQNCg0K
