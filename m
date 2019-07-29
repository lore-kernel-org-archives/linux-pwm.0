Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-eopbgr1410135.outbound.protection.outlook.com ([40.107.141.135]:6073
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726048AbfG2FQj (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 29 Jul 2019 01:16:39 -0400
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 29 Jul 2019 05:16:33 +0000
Message-ID: <TYAPR01MB4544031C6A027A3690FFFB77D8DD0@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1562576868-8124-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1562576868-8124-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CACRpkdZqTaA04bja16xh338JiwoSqFpH_2rV95FaF7YhawQzMg@mail.gmail.com>
In-Reply-To: <CACRpkdZqTaA04bja16xh338JiwoSqFpH_2rV95FaF7YhawQzMg@mail.gmail.com>
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: RE: [PATCH RFC 2/7] pinctrl: sh-pfc: remove incomplete flag
 "cfg->type"
To: Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

SGkgTGludXMsIEdlZXJ0LA0KDQo+IEZyb206IExpbnVzIFdhbGxlaWosIFNlbnQ6IE1vbmRheSwg
SnVseSAyOSwgMjAxOSA4OjAyIEFNDQo+IA0KPiBPbiBNb24sIEp1bCA4LCAyMDE5IGF0IDExOjA4
IEFNIFlvc2hpaGlybyBTaGltb2RhDQo+IDx5b3NoaWhpcm8uc2hpbW9kYS51aEByZW5lc2FzLmNv
bT4gd3JvdGU6DQo+IA0KPiA+IFRoZSBvbGQgY29tbWl0IGM1OGQ5YzFiMjZlMyAoInNoLXBmYzog
SW1wbGVtZW50IGdlbmVyaWMgcGluY29uZg0KPiA+IHN1cHBvcnQiKSBicm9rZSB0aGUgY2ZnLT50
eXBlIGZsYWcgdG8gUElOTVVYX1RZUEVfRlVOQ1RJT04gYmVjYXVzZQ0KPiA+IHNoX3BmY19waW5j
b25mX3NldCgpIGRpZG4ndCBjYWxsIHNoX3BmY19yZWNvbmZpZ19waW4oKS4NCj4gPiBOb3cgaWYg
d2UgZml4IHRoZSBjZmctPnR5cGUgY29uZGl0aW9uLCBpdCBnZXRzIHdvcnNlIGJlY2F1c2U6DQo+
ID4gIC0gU29tZSBkcml2ZXJzIG1pZ2h0IGJlIGRlZmVycmVkIHNvIHRoYXQgLnNldF9tdXgoKSB3
aWxsIGJlIGNhbGxlZA0KPiA+ICAgIG11bHRpcGxlIHRpbWVzLg0KPiA+ICAtIEluIHN1Y2ggdGhl
IGNhc2UsIHRoZSBzaC1wZmMgZHJpdmVyIHJldHVybnMgLUVCVVNZIGV2ZW4gaWYNCj4gPiAgICB0
aGUgZ3JvdXAgaXMgdGhlIHNhbWUsIGFuZCB0aGVuIHRoYXQgZHJpdmVyIGZhaWxzIHRvIHByb2Jl
Lg0KPiA+DQo+ID4gU2luY2UgdGhlIHBpbmN0cmwgc3Vic3lzdGVtIGFscmVhZHkgaGFzIHN1Y2gg
Y29uZGl0aW9ucyBhY2NvcmRpbmcNCj4gPiB0byBAc2V0X211eCBhbmQgQGdwaW9fcmVxdWVzdF9l
bmFibGUsIHRoaXMgcGF0Y2gganVzdCByZW1vdmUNCj4gPiB0aGUgaW5jb21wbGV0ZSBmbGFnIGZy
b20gc2gtcGZjL3BpbmN0cmwuYy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFlvc2hpaGlybyBT
aGltb2RhIDx5b3NoaWhpcm8uc2hpbW9kYS51aEByZW5lc2FzLmNvbT4NCj4gDQo+IFRoaXMgbG9v
a3MgbGlrZSBpdCBzaG91bGQgaGF2ZSBhIEZpeGVzOiB0YWcgYXMgd2VsbC4NCg0KSSBnb3QgaXQu
IFRoZSBGaXhlcyB0YWcgc2hvdWxkIGJlOg0KDQpGaXhlczogYzU4ZDljMWIyNmUzICgic2gtcGZj
OiBJbXBsZW1lbnQgZ2VuZXJpYyBwaW5jb25mIHN1cHBvcnQiKQ0KDQo+IEdlZXJ0IHdpbGwgZGVj
aWRlIHdoYXQgdG8gZG8gd2l0aCB0aGlzLg0KDQpJIGdvdCBpdC4NCg0KPiBDYW4gYWxsIHRoZSBw
aW5jdHJsIHBhdGNoZXMgYmUgYXBwbGllZCBpbmRlcGVuZGVudGx5IG9mIHRoZSBvdGhlcg0KPiBj
aGFuZ2VzIHNvIEdlZXJ0IGNhbiBhcHBseSBhbmQgc2VuZCBtZSB0aG9zZSBwYXRjaGVzIGluIGhp
cyBwdWxsDQo+IHJlcXVlc3RzPw0KDQpUaGUgcGluY3RybCBwYXRjaGVzICgxLzcgdGhyb3VnaCAz
LzcpIGNhbiBiZSBhcHBsaWVkIG9uIG5leHQtMjAxOTA3MjYNCnNvIEkgdGhpbmsgR2VlcnQgY2Fu
IGFwcGx5IHRoZXNlIHBhdGNoZXMgaW50byBoaXMgcmVwby4NCg0KR2VlcnQsIGlmIEkgc2hvdWxk
IHJlc2VuZCB0aGUgcGluY3RybCBwYXRjaGVzLCBwbGVhc2UgbGV0IG1lIGtub3chDQoNCkJlc3Qg
cmVnYXJkcywNCllvc2hpaGlybyBTaGltb2RhDQoNCj4gWW91cnMsDQo+IExpbnVzIFdhbGxlaWoN
Cg==
