From: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v3 1/2] gpio: mvebu: use platform_irq_count
Date: Wed, 4 Dec 2019 09:24:35 +0000
Message-ID: <1575451330-11112-1-git-send-email-peng.fan@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Content-ID: <225D19D2BDA71E469714620A2E966AED@eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "rjui@broadcom.com" <rjui@broadcom.com>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "sbranden@broadcom.com" <sbranden@broadcom.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "robh@kernel.org" <robh@kernel.org>
Cc: "bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, dl-linux-imx <linux-imx@nxp.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peng Fan <peng.fan@nxp.com>
List-Id: linux-pwm@vger.kernel.org

RnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQoNCnBsYXRmb3JtX2lycV9jb3VudCgp
IGlzIHRoZSBtb3JlIGdlbmVyaWMgd2F5IChpbmRlcGVuZGVudCBvZg0KZGV2aWNlIHRyZWVzKSB0
byBkZXRlcm1pbmUgdGhlIGNvdW50IG9mIGF2YWlsYWJsZSBpbnRlcnJ1cHRzLiBTbw0KdXNlIHRo
aXMgaW5zdGVhZC4NCg0KQXMgcGxhdGZvcm1faXJxX2NvdW50KCkgbWlnaHQgcmV0dXJuIGFuIGVy
cm9yIGNvZGUgKHdoaWNoDQpvZl9pcnFfY291bnQgZG9lc24ndCkgc29tZSBhZGRpdGlvbmFsIGhh
bmRsaW5nIGlzIG5lY2Vzc2FyeS4NCg0KUmV2aWV3ZWQtYW5kLUNvbW1pdC1Mb2ctUHJvdmlkZWQt
Ynk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+DQpT
aWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCi0tLQ0KDQpWMzogQWRk
IHRhZw0KDQpWMjoNCiBVcGRhdGUgY29tbWl0IGxvZywgYWRkIGVyciBoYW5kbGluZw0KIE5vdCB0
ZXN0ZWQsIGp1c3QgY29kZSBpbnNwZWN0aW9uDQoNCg0KIGRyaXZlcnMvZ3Bpby9ncGlvLW12ZWJ1
LmMgfCA3ICsrKysrLS0NCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncGlvL2dwaW8tbXZlYnUuYyBiL2RyaXZl
cnMvZ3Bpby9ncGlvLW12ZWJ1LmMNCmluZGV4IDk5M2JiZWIzYzAwNi4uZjBmZDgyYjM0MTdjIDEw
MDY0NA0KLS0tIGEvZHJpdmVycy9ncGlvL2dwaW8tbXZlYnUuYw0KKysrIGIvZHJpdmVycy9ncGlv
L2dwaW8tbXZlYnUuYw0KQEAgLTQ2LDcgKzQ2LDYgQEANCiAjaW5jbHVkZSA8bGludXgvaXJxZG9t
YWluLmg+DQogI2luY2x1ZGUgPGxpbnV4L21mZC9zeXNjb24uaD4NCiAjaW5jbHVkZSA8bGludXgv
b2ZfZGV2aWNlLmg+DQotI2luY2x1ZGUgPGxpbnV4L29mX2lycS5oPg0KICNpbmNsdWRlIDxsaW51
eC9waW5jdHJsL2NvbnN1bWVyLmg+DQogI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5o
Pg0KICNpbmNsdWRlIDxsaW51eC9wd20uaD4NCkBAIC0xMTAyLDcgKzExMDEsMTEgQEAgc3RhdGlj
IGludCBtdmVidV9ncGlvX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCQlz
b2NfdmFyaWFudCA9IE1WRUJVX0dQSU9fU09DX1ZBUklBTlRfT1JJT047DQogDQogCS8qIFNvbWUg
Z3BpbyBjb250cm9sbGVycyBkbyBub3QgcHJvdmlkZSBpcnEgc3VwcG9ydCAqLw0KLQloYXZlX2ly
cXMgPSBvZl9pcnFfY291bnQobnApICE9IDA7DQorCWVyciA9IHBsYXRmb3JtX2lycV9jb3VudChw
ZGV2KTsNCisJaWYgKGVyciA8IDApDQorCQlyZXR1cm4gZXJyOw0KKw0KKwloYXZlX2lycXMgPSBl
cnIgIT0gMDsNCiANCiAJbXZjaGlwID0gZGV2bV9remFsbG9jKCZwZGV2LT5kZXYsIHNpemVvZihz
dHJ1Y3QgbXZlYnVfZ3Bpb19jaGlwKSwNCiAJCQkgICAgICBHRlBfS0VSTkVMKTsNCi0tIA0KMi4x
Ni40DQoNCg==
