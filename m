From: <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH 32/32] pwm: atmel: convert to
 devm_platform_ioremap_resource
Date: Mon, 6 Jan 2020 10:32:36 +0000
Message-ID: <5aef0df7-ab3a-fe81-3cd4-a81c08841a00@microchip.com>
References: <20191229080610.7597-1-tiny.windzz@gmail.com>
 <20191229080610.7597-32-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191229080610.7597-32-tiny.windzz@gmail.com>
Content-Language: en-US
Content-ID: <C0B3595014DD3C41BDEC06FF974DF51B@namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tiny.windzz@gmail.com, thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com, nsaenzjulienne@suse.de, shc_work@mail.ru, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, vz@mleia.com, slemieux.tyco@gmail.com, khilman@baylibre.com, matthias.bgg@gmail.com, heiko@sntech.de, palmer@dabbelt.com, paul.walmsley@sifive.com, mripard@kernel.org, wens@csie.org, jonathanh@nvidia.com, linux@prisktech.co.nz, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel
List-Id: linux-pwm@vger.kernel.org

DQoNCk9uIDI5LjEyLjIwMTkgMTA6MDYsIFlhbmd0YW8gTGkgd3JvdGU6DQo+IFVzZSBkZXZtX3Bs
YXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UoKSB0byBzaW1wbGlmeSBjb2RlLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogWWFuZ3RhbyBMaSA8dGlueS53aW5kenpAZ21haWwuY29tPg0KDQpBY2tlZC1ieTog
Q2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCj4gLS0tDQo+
ICBkcml2ZXJzL3B3bS9wd20tYXRtZWwuYyB8IDQgKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
cHdtL3B3bS1hdG1lbC5jIGIvZHJpdmVycy9wd20vcHdtLWF0bWVsLmMNCj4gaW5kZXggOWJhNzMz
NDY3ZTI2Li44NmNjNWNjYWE0NmMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcHdtL3B3bS1hdG1l
bC5jDQo+ICsrKyBiL2RyaXZlcnMvcHdtL3B3bS1hdG1lbC5jDQo+IEBAIC0zNDAsNyArMzQwLDYg
QEAgTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgYXRtZWxfcHdtX2R0X2lkcyk7DQo+ICBzdGF0aWMg
aW50IGF0bWVsX3B3bV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgew0K
PiAgICAgICAgIHN0cnVjdCBhdG1lbF9wd21fY2hpcCAqYXRtZWxfcHdtOw0KPiAtICAgICAgIHN0
cnVjdCByZXNvdXJjZSAqcmVzOw0KPiAgICAgICAgIGludCByZXQ7DQo+IA0KPiAgICAgICAgIGF0
bWVsX3B3bSA9IGRldm1fa3phbGxvYygmcGRldi0+ZGV2LCBzaXplb2YoKmF0bWVsX3B3bSksIEdG
UF9LRVJORUwpOw0KPiBAQCAtMzUxLDggKzM1MCw3IEBAIHN0YXRpYyBpbnQgYXRtZWxfcHdtX3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAgICAgICAgYXRtZWxfcHdtLT5k
YXRhID0gb2ZfZGV2aWNlX2dldF9tYXRjaF9kYXRhKCZwZGV2LT5kZXYpOw0KPiAgICAgICAgIGF0
bWVsX3B3bS0+dXBkYXRlZF9wd21zID0gMDsNCj4gDQo+IC0gICAgICAgcmVzID0gcGxhdGZvcm1f
Z2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsNCj4gLSAgICAgICBhdG1lbF9w
d20tPmJhc2UgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoJnBkZXYtPmRldiwgcmVzKTsNCj4gKyAg
ICAgICBhdG1lbF9wd20tPmJhc2UgPSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UocGRl
diwgMCk7DQo+ICAgICAgICAgaWYgKElTX0VSUihhdG1lbF9wd20tPmJhc2UpKQ0KPiAgICAgICAg
ICAgICAgICAgcmV0dXJuIFBUUl9FUlIoYXRtZWxfcHdtLT5iYXNlKTsNCj4gDQo+IC0tDQo+IDIu
MTcuMQ0KPiANCj4g
