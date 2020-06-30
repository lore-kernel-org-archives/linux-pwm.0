From: Roy Im <roy.im.opensource@diasemi.com>
Subject: RE: [PATCH v15 3/3] Input: new da7280 haptic driver
Date: Tue, 30 Jun 2020 03:39:26 +0000
Message-ID: <DB8PR10MB3356EF71023E587911611C0C856F0@DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1593435662.git.Roy.Im@diasemi.com>
 <c7b8cb993abe7bb771108bb94e5d9edbeb4f7103.1593435662.git.Roy.Im@diasemi.com>
 <602a5743-d27b-3e81-e917-d343f58d35e9@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-eopbgr80077.outbound.protection.outlook.com ([40.107.8.77]:20470
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728930AbgF3Dja (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 29 Jun 2020 23:39:30 -0400
In-Reply-To: <602a5743-d27b-3e81-e917-d343f58d35e9@infradead.org>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>, Roy Im <roy.im.opensource@diasemi.com>, Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Brian Masney <masneyb@onstation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>, Maximilian Luz <luzmaximilian@gmail.com>, Pascal PAILLET-LME <p.paillet@st.com>, Rob Herring <robh@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Support Opensource <Support.Opensource@diasemi.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>

T24gVHVlLCBKdW5lIDMwLCAyMDIwIDEyOjE0IFBNLCBSYW5keSBEdW5sYXAgd3JvdGU6IA0KPiBP
biA2LzI5LzIwIDY6MDEgQU0sIFJveSBJbSB3cm90ZToNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9pbnB1dC9taXNjL0tjb25maWcgYi9kcml2ZXJzL2lucHV0L21pc2MvS2NvbmZpZw0KPiA+IGlu
ZGV4IDM2MmU4YTAuLjc5ZmJkZGIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pbnB1dC9taXNj
L0tjb25maWcNCj4gPiArKysgYi9kcml2ZXJzL2lucHV0L21pc2MvS2NvbmZpZw0KPiA+IEBAIC04
NjksNCArODY5LDE3IEBAIGNvbmZpZyBJTlBVVF9TVFBNSUMxX09OS0VZDQo+ID4gIAkgIFRvIGNv
bXBpbGUgdGhpcyBkcml2ZXIgYXMgYSBtb2R1bGUsIGNob29zZSBNIGhlcmU6IHRoZQ0KPiA+ICAJ
ICBtb2R1bGUgd2lsbCBiZSBjYWxsZWQgc3RwbWljMV9vbmtleS4NCj4gPg0KPiA+ICtjb25maWcg
SU5QVVRfREE3MjgwX0hBUFRJQ1MNCj4gPiArCXRyaXN0YXRlICJEaWFsb2cgU2VtaWNvbmR1Y3Rv
ciBEQTcyODAgaGFwdGljcyBzdXBwb3J0Ig0KPiA+ICsJZGVwZW5kcyBvbiBJTlBVVCAmJiBJMkMN
Cj4gPiArCXNlbGVjdCBJTlBVVF9GRl9NRU1MRVNTDQo+ID4gKwlzZWxlY3QgUkVHTUFQX0kyQw0K
PiA+ICsJaGVscA0KPiA+ICsJICBTYXkgWSB0byBlbmFibGUgc3VwcG9ydCBmb3IgdGhlIERpYWxv
ZyBEQTcyODAgaGFwdGljcyBkcml2ZXIuDQo+ID4gKwkgIFRoZSBoYXB0aWNzIGNhbiBiZSBjb250
cm9sbGVkIGJ5IGkyYyBjb21tdW5pY2F0aW9uLA0KPiANCj4gSWYgeW91IG1ha2UgYW55IG1vcmUg
dXBkYXRlcywgbWFrZSB0aGlzOiAgIEkyQyBjb21tdW5pY2F0aW9uLA0KPiBwbGVhc2UuDQoNCk9L
LCBJIHdpbGwgZG8uIFRoYW5rcyBmb3IgeW91ciBjb21tZW50Lg0KDQo+IA0KPiA+ICsJICBvciBi
eSBQV00gaW5wdXQsIG9yIGJ5IEdQSS4NCj4gPiArDQo+ID4gKwkgIFRvIGNvbXBpbGUgdGhpcyBk
cml2ZXIgYXMgYSBtb2R1bGUsIGNob29zZSBNIGhlcmU6IHRoZQ0KPiA+ICsJICBtb2R1bGUgd2ls
bCBiZSBjYWxsZWQgZGE3MjgwLg0KPiA+ICsNCj4gPiAgZW5kaWYNCj4gDQo+IHRoYW5rcy4NCj4g
LS0NCj4gflJhbmR5DQoNCg==
