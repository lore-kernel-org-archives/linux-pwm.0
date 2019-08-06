Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-eopbgr1410125.outbound.protection.outlook.com ([40.107.141.125]:17248
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726036AbfHFLtB (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 6 Aug 2019 07:49:01 -0400
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 6 Aug 2019 11:48:57 +0000
Message-ID: <OSBPR01MB45363201E328DF9C15D2833FD8D50@OSBPR01MB4536.jpnprd01.prod.outlook.com>
References: <1562576868-8124-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1562576868-8124-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdVcAw_ApKMmrV7DaoJBGUZ1GzW3kmxnsTn72FtCGWhXPA@mail.gmail.com>
In-Reply-To: <CAMuHMdVcAw_ApKMmrV7DaoJBGUZ1GzW3kmxnsTn72FtCGWhXPA@mail.gmail.com>
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: RE: [PATCH RFC 2/7] pinctrl: sh-pfc: remove incomplete flag
 "cfg->type"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Linux PWM List <linux-pwm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

SGkgR2VlcnQtc2FuLA0KDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiwgU2VudDogVHVlc2Rh
eSwgQXVndXN0IDYsIDIwMTkgNjoyNCBQTQ0KPiANCj4gSGkgU2hpbW9kYS1zYW4sDQo+IA0KPiBP
biBNb24sIEp1bCA4LCAyMDE5IGF0IDExOjA4IEFNIFlvc2hpaGlybyBTaGltb2RhDQo+IDx5b3No
aWhpcm8uc2hpbW9kYS51aEByZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4gVGhlIG9sZCBjb21taXQg
YzU4ZDljMWIyNmUzICgic2gtcGZjOiBJbXBsZW1lbnQgZ2VuZXJpYyBwaW5jb25mDQo+ID4gc3Vw
cG9ydCIpIGJyb2tlIHRoZSBjZmctPnR5cGUgZmxhZyB0byBQSU5NVVhfVFlQRV9GVU5DVElPTiBi
ZWNhdXNlDQo+ID4gc2hfcGZjX3BpbmNvbmZfc2V0KCkgZGlkbid0IGNhbGwgc2hfcGZjX3JlY29u
ZmlnX3BpbigpLg0KPiA+IE5vdyBpZiB3ZSBmaXggdGhlIGNmZy0+dHlwZSBjb25kaXRpb24sIGl0
IGdldHMgd29yc2UgYmVjYXVzZToNCj4gPiAgLSBTb21lIGRyaXZlcnMgbWlnaHQgYmUgZGVmZXJy
ZWQgc28gdGhhdCAuc2V0X211eCgpIHdpbGwgYmUgY2FsbGVkDQo+ID4gICAgbXVsdGlwbGUgdGlt
ZXMuDQo+ID4gIC0gSW4gc3VjaCB0aGUgY2FzZSwgdGhlIHNoLXBmYyBkcml2ZXIgcmV0dXJucyAt
RUJVU1kgZXZlbiBpZg0KPiA+ICAgIHRoZSBncm91cCBpcyB0aGUgc2FtZSwgYW5kIHRoZW4gdGhh
dCBkcml2ZXIgZmFpbHMgdG8gcHJvYmUuDQo+ID4NCj4gPiBTaW5jZSB0aGUgcGluY3RybCBzdWJz
eXN0ZW0gYWxyZWFkeSBoYXMgc3VjaCBjb25kaXRpb25zIGFjY29yZGluZw0KPiA+IHRvIEBzZXRf
bXV4IGFuZCBAZ3Bpb19yZXF1ZXN0X2VuYWJsZSwgdGhpcyBwYXRjaCBqdXN0IHJlbW92ZQ0KPiA+
IHRoZSBpbmNvbXBsZXRlIGZsYWcgZnJvbSBzaC1wZmMvcGluY3RybC5jLg0KPiANCj4gRG8gd2Ug
bmVlZCB0byBzZXQgc2hfcGZjX3Bpbm11eF9vcHMuc3RyaWN0ID0gdHJ1ZT8NCg0KSWYgdGhlIC5z
dHJpY3QgPSB0cnVlLCB0aGUgZmluYWwgcHdtIHBhdGNoIG9uIHRoaXMgc2VyaWVzIGZhaWxlZCB3
aXRoIHRoZSBmb2xsb3dpbmcgZXJyb3I6DQoNClsgICAxMS40NTM3MTZdIHNoLXBmYyBlNjA2MDAw
MC5waW4tY29udHJvbGxlcjogcGluIEdQXzJfNyBhbHJlYWR5IHJlcXVlc3RlZCBieSBlNmUzMTAw
MC5wd207IGNhbm5vdCBjbGFpbSBmb3IgZTYwNTIwMDAuZ3Bpbzo0NTkNCg0KQmVzdCByZWdhcmRz
LA0KWW9zaGloaXJvIFNoaW1vZGENCg0KPiBHcntvZXRqZSxlZXRpbmd9cywNCj4gDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgIEdlZXJ0DQo+IA0KPiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4g
LS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsu
b3JnDQo+IA0KPiBJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3Bs
ZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0DQo+IHdoZW4gSSdtIHRhbGtpbmcgdG8gam91
cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4N
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcw0K
