Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-eopbgr1410100.outbound.protection.outlook.com ([40.107.141.100]:10880
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725817AbfHHHDM (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 8 Aug 2019 03:03:12 -0400
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 8 Aug 2019 07:02:55 +0000
Message-ID: <TYAPR01MB45447F9F1768D94E862DFDF0D8D70@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1562576868-8124-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1562576868-8124-7-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20190807070326.cgkbt4kpzhqvo5a3@pengutronix.de>
 <TYAPR01MB45445D854C1FDBB473A89559D8D70@TYAPR01MB4544.jpnprd01.prod.outlook.com>
 <CAMuHMdUQpTvwk=PxhwJGbW8izBXSzHw0sNvypzONPovR7sZutA@mail.gmail.com>
In-Reply-To: <CAMuHMdUQpTvwk=PxhwJGbW8izBXSzHw0sNvypzONPovR7sZutA@mail.gmail.com>
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: RE: [PATCH RFC 6/7] pwm: rcar: Add gpio support to output duty zero
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "geert+renesas@glider.be" <geert+renesas@glider.be>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>

SGkgR2VlcnQtc2FuLA0KDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiwgU2VudDogVGh1cnNk
YXksIEF1Z3VzdCA4LCAyMDE5IDM6NDkgUE0NCj4gDQo+IEhpIFNoaW1vZGEtc2FuLA0KPiANCj4g
T24gVGh1LCBBdWcgOCwgMjAxOSBhdCA1OjUzIEFNIFlvc2hpaGlybyBTaGltb2RhDQo+IDx5b3No
aWhpcm8uc2hpbW9kYS51aEByZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4gPiBGcm9tOiBVd2UgS2xl
aW5lLUvDtm5pZywgU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgNywgMjAxOSA0OjAzIFBNDQo+ID4g
PiBXaGlsZSBhdCBpdDogSWYgdGhlcmUgaXMgYSBwdWJsaWNseSBhdmFpbGFibGUgcmVmZXJlbmNl
IG1hbnVhbCBhZGRpbmcgYSBsaW5lOg0KPiA+ID4NCj4gPiA+ICAgICAgIFJlZmVyZW5jZSBNYW51
YWw6IGh0dHBzOi8vLi4uDQo+ID4gPg0KPiA+ID4gd291bGQgYmUgZ3JlYXQsIHRvby4NCj4gPg0K
PiA+IFVuZm9ydHVuYXRlbHksIHRoZSBkb2N1bWVudCBpcyBub3QgcHVibGljLi4uDQo+IA0KPiBS
Wi9HMSBoYXMgdGhlIHNhbWUgaGFyZHdhcmUgYmxvY2ssIHJpZ2h0Pw0KPiBJdHMgSGFyZHdhcmUg
VXNlcidzIE1hbnVhbCBpcyBwdWJsaWNseSBhdmFpbGFibGUsIGUuZy4gZm9yIFJaL0cxTToNCj4g
aHR0cHM6Ly93d3cucmVuZXNhcy5jb20vZXUvZW4vcHJvZHVjdHMvbWljcm9jb250cm9sbGVycy1t
aWNyb3Byb2Nlc3NvcnMvcnovcnpnL3J6ZzFtLmh0bWwjZG9jdW1lbnRzDQoNCllvdSdyZSByaWdo
dC4NCiMgU2luY2UgSSBjb3VsZCBnZXQgUlovRzIgc2VyaWVzIGhhcmR3YXJlIHVzZXIncyBtYW51
YWwgZnJvbSBwdWJsaWMgd2Vic2l0ZSB5ZXN0ZXJkYXksDQojIEkgd2FzIHRoaW5raW5nIGFueSBt
YW51YWxzIGFyZSBub3QgcHVibGljLi4uDQoNCkJlc3QgcmVnYXJkcywNCllvc2hpaGlybyBTaGlt
b2RhDQoNCg0KPiBHcntvZXRqZSxlZXRpbmd9cywNCj4gDQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgIEdlZXJ0DQo+IA0KPiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3Rz
IG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3JnDQo+IA0KPiBJbiBw
ZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2Vs
ZiBhIGhhY2tlci4gQnV0DQo+IHdoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0
IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4NCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcw0K
