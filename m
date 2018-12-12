From: =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
Subject: [RFC PATCH v4 0/2] pwm: imx: Configure output to GPIO in disabled
 state
Date: Wed, 12 Dec 2018 12:04:49 +0000
Message-ID: <1544616263-82642-1-git-send-email-michal.vokac@ysoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Content-ID: <E4B6D36AE49ABA44834BA66DF79EDE8E@eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Fabio Estevam <fabio.estevam@nxp.com>, =?utf-8?B?TG90aGFyIFdhw59tYW5u?= <LW@karo-electronics.de>, Linus Walleij <linus.walleij@linaro.org>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>, =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
List-Id: linux-pwm@vger.kernel.org

VGhpcyBpcyBhbiBhdHRlbXB0IHRvIGRlYWwgd2l0aCBpLk1YIFNvQyBQV00gSFcgbGltaXRhdGlv
bi4NCldoZW4gYSBwYWQgaXMgY29uZmlndXJlZCBhcyBhIFBXTSBvdXRwdXQgdGhlIG91dHB1dCBs
ZXZlbCBpcyBhbHdheXMgMFYNCmlmIHRoZSBQV00gYmxvY2sgaXMgZGlzYWJsZWQuIFRoaXMgY2Fu
IGNhdXNlIHByb2JsZW1zIHdoZW4gaW52ZXJ0ZWQgUFdNDQpzaWduYWwgaXMgbmVlZGVkIHRvIGRy
aXZlIHRoZSBjb25uZWN0ZWQgY2lyY3VpdC4gV2l0aCBpbnZlcnRlZCBvdXRwdXQNCmR1dHkgY3lj
bGUgPSAwJSBjb3JyZXNwb25kcyB0byBoaWdoIG91dHB1dCBsZXZlbCBhbmQgZHV0eSBjeWNsZSA9
IDEwMCUNCmNvcnJlc3BvbmRzIHRvIGxvdyBvdXRwdXQgbGV2ZWwuIFRoaXMgbWVhbnMgdGhhdCB3
aGVuZXZlciB0aGUgUFdNIGJsb2NrDQppcyBkaXNhYmxlZCB0aGUgY29ubmVjdGVkIGNpcmN1aXQg
aXMgZmVkIHdpdGggMTAwJSBkdXR5IGN5Y2xlLg0KDQpUaGlzIGJpbmRpbmcgaXMgdG90YWxseSBv
cHRpb25hbCBhbmQgY3VycmVudCB1c2VycyBhcmUgbm90IGFmZmVjdGVkLg0KVGhlIGlkZWEgaXMg
dG8gdXNlIHR3byBuZXcgcGluY3RybCBzdGF0ZXMsICJwd20iIGFuZCAiZ3BpbyIsIGluc3RlYWQg
b2YNCnRoZSAiZGVmYXVsdCIgcGluY3RybCBzdGF0ZS4gVGhlIGdwaW8gc3RhdGUgaXMgc2VsZWN0
ZWQgIHdoZW4gUFdNIGlzDQpkaXNhYmxlZCBhbmQgdGhlIHB3bSBwaW5jdHJsIHN0YXRlIGlzIHNl
bGVjdGVkIHdoZW4gUFdNIGlzIGVuYWJsZWQuIEluIHRoZQ0KZ3BpbyBzdGF0ZSBsZXZlbCBvbiB0
aGUgb3V0cHV0IGlzIGNvbnRyb2xsZWQgYnkgdGhlIGludGVybmFsIHB1bGwtdXAuDQoNCk1pY2hh
bCBWb2vDocSNICgyKToNCiAgZHQtYmluZGluZ3M6IHB3bTogaW14OiBBbGxvdyBzd2l0Y2hpbmcg
UFdNIG91dHB1dCBiZXR3ZWVuIFBXTSBhbmQgR1BJTw0KICBwd206IGlteDogQ29uZmlndXJlIG91
dHB1dCB0byBHUElPIGluIGRpc2FibGVkIHN0YXRlDQoNCiBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcHdtL2lteC1wd20udHh0IHwgNDkgKysrKysrKysrKysrKysrDQogZHJpdmVy
cy9wd20vcHdtLWlteC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDc3ICsrKysrKysr
KysrKysrKysrKysrKysrDQogMiBmaWxlcyBjaGFuZ2VkLCAxMjYgaW5zZXJ0aW9ucygrKQ0KDQot
LSANCjIuMS40DQoNCg==
