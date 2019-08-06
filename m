Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-eopbgr1400112.outbound.protection.outlook.com ([40.107.140.112]:64160
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726783AbfHFLjP (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 6 Aug 2019 07:39:15 -0400
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 6 Aug 2019 11:39:12 +0000
Message-ID: <OSBPR01MB453629FB169C11ABD4856B45D8D50@OSBPR01MB4536.jpnprd01.prod.outlook.com>
References: <1562576868-8124-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1562576868-8124-6-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdWw1Gh_CxgiO5gd+MY0vUvWX_ACDj+L3_Wcomkaf5Oo4Q@mail.gmail.com>
In-Reply-To: <CAMuHMdWw1Gh_CxgiO5gd+MY0vUvWX_ACDj+L3_Wcomkaf5Oo4Q@mail.gmail.com>
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: RE: [PATCH RFC 5/7] pwm: rcar: remove a redundant condition in
 rcar_pwm_apply()
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Linux PWM List <linux-pwm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

SGkgR2VlcnQtc2FuLA0KDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiwgU2VudDogVHVlc2Rh
eSwgQXVndXN0IDYsIDIwMTkgNjowNiBQTQ0KPiANCj4gSGkgU2hpbW9kYS1zYW4sDQo+IA0KPiBP
biBNb24sIEp1bCA4LCAyMDE5IGF0IDExOjA4IEFNIFlvc2hpaGlybyBTaGltb2RhDQo+IDx5b3No
aWhpcm8uc2hpbW9kYS51aEByZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4gU2luY2UgdGhlIHJjYXJf
cHdtX2FwcGx5KCkgaGFzIGFscmVhZHkgY2hlY2sgd2hlaHRlciBzdGF0ZS0+ZW5hYmxlZA0KPiA+
IGlzIG5vdCBzZXQgb3Igbm90LCB0aGlzIHBhdGNoIHJlbW92ZXMgYSByZWR1bmRhbnQgY29uZGl0
aW9uLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWW9zaGloaXJvIFNoaW1vZGEgPHlvc2hpaGly
by5zaGltb2RhLnVoQHJlbmVzYXMuY29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IEdlZXJ0IFV5dHRl
cmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+DQoNClRoYW5rIHlvdSBmb3IgeW91ciBy
ZXZpZXchDQoNCj4gVGhpcyBpcyBjb21wbGV0ZWx5IGluZGVwZW5kZW50IGZyb20gdGhlIHJlc3Qg
b2YgdGhlIHNlcmllcywgYW5kIGNhbiBiZSBhcHBsaWVkDQo+IGltbWVkaWF0ZWx5LCByaWdodD8N
Cg0KVGhhdCdzIHJpZ2h0Lg0KDQpCZXN0IHJlZ2FyZHMsDQpZb3NoaWhpcm8gU2hpbW9kYQ0KDQo+
IEdye29ldGplLGVldGluZ31zLA0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQN
Cj4gDQo+IA0KPiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExp
bnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3JnDQo+IA0KPiBJbiBwZXJzb25h
bCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhh
Y2tlci4gQnV0DQo+IHdoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAi
cHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4NCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcw0K
