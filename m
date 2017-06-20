Return-Path: <zhi.mao@mediatek.com>
From: Zhi Mao <zhi.mao@mediatek.com>
Subject: [PATCH 0/4] mediatek: pwm driver add MT2712/MT7622 support 
Date: Tue, 20 Jun 2017 14:54:12 +0800
Message-ID: <1497941657-23876-1-git-send-email-zhi.mao@mediatek.com>
Return-Path: zhi.mao@mediatek.com
MIME-Version: 1.0
Content-Type: multipart/related;
	boundary="__=_Part_Boundary_007_1456252146.276366653"
List-ID: <linux-pwm.vger.kernel.org>
To: john@phrozen.org, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pwm@vger.kernel.org
Cc: srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, zhi.mao@mediatek.com, yingjoe.chen@mediatek.com, yt.shen@mediatek.com, sean.wang@mediatek.com, zhenbao.liu@mediatek.com

--__=_Part_Boundary_007_1456252146.276366653
Content-Transfer-Encoding: base64
Content-Type: multipart/alternative;
	boundary="__=_Part_Boundary_008_1874387408.576876725"

--__=_Part_Boundary_008_1874387408.576876725
Content-Type: text/html
Content-Transfer-Encoding: base64

PHByZT4NCnB3bSBkcml2ZXIgYWRkIE1UMjcxMi9NVDc2MjIgc3VwcG9ydCwgZml4IGNsb2NrIGNv
bnRyb2wgaXNzdWUuDQpkdHNpIGZpbGUgd2lsbCBiZSB1cGxvYWQgbGF0dGVyLCBhZnRlciB0aGUg
Y2xvY2sgZGVmaW5lIGlzIHJlYWR5Lg0KDQpaaGkgTWFvICg0KToNCiAgcHdtOiBrY29uZmlnOiBt
b2RpZnkgbWVkaWF0ZWsgaW5mb3JtYXRpb24NCiAgcHdtOiBtZWRpYXRlazogZml4IGNsayBpc3N1
ZQ0KICBwd206IGJpbmRpbmdzOiBhZGQgTVQyNzEyL01UNzYyMiBpbmZvcm1hdGlvbg0KICBwd206
IG1lZGlhdGVrOiBhZGQgTVQyNzEyL01UNzYyMiBzdXBwb3J0DQoNCiAuLi4vZGV2aWNldHJlZS9i
aW5kaW5ncy9wd20vcHdtLW1lZGlhdGVrLnR4dCAgICAgICB8ICAgIDYgKy0NCiBkcml2ZXJzL3B3
bS9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDIgKy0NCiBkcml2
ZXJzL3B3bS9wd20tbWVkaWF0ZWsuYyAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxMzIgKysr
KysrKysrKysrKystLS0tLS0NCiAzIGZpbGVzIGNoYW5nZWQsIDEwMCBpbnNlcnRpb25zKCspLCA0
MCBkZWxldGlvbnMoLSkNCg0KPC9wcmU+PCEtLXR5cGU6dGV4dC0tPjwhLS17LS0+PHByZT4qKioq
KioqKioqKioqIEVtYWlsIENvbmZpZGVudGlhbGl0eSBOb3RpY2UNCiAqKioqKioqKioqKioqKioq
KioqKg0KVGhlIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBpbiB0aGlzIGUtbWFpbCBtZXNzYWdlIChp
bmNsdWRpbmcgYW55IA0KYXR0YWNobWVudHMpIG1heSBiZSBjb25maWRlbnRpYWwsIHByb3ByaWV0
YXJ5LCBwcml2aWxlZ2VkLCBvciBvdGhlcndpc2UNCmV4ZW1wdCBmcm9tIGRpc2Nsb3N1cmUgdW5k
ZXIgYXBwbGljYWJsZSBsYXdzLiBJdCBpcyBpbnRlbmRlZCB0byBiZSANCmNvbnZleWVkIG9ubHkg
dG8gdGhlIGRlc2lnbmF0ZWQgcmVjaXBpZW50KHMpLiBBbnkgdXNlLCBkaXNzZW1pbmF0aW9uLCAN
CmRpc3RyaWJ1dGlvbiwgcHJpbnRpbmcsIHJldGFpbmluZyBvciBjb3B5aW5nIG9mIHRoaXMgZS1t
YWlsIChpbmNsdWRpbmcgaXRzIA0KYXR0YWNobWVudHMpIGJ5IHVuaW50ZW5kZWQgcmVjaXBpZW50
KHMpIGlzIHN0cmljdGx5IHByb2hpYml0ZWQgYW5kIG1heSANCmJlIHVubGF3ZnVsLiBJZiB5b3Ug
YXJlIG5vdCBhbiBpbnRlbmRlZCByZWNpcGllbnQgb2YgdGhpcyBlLW1haWwsIG9yIGJlbGlldmUN
CiANCnRoYXQgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBlLW1haWwgaW4gZXJyb3IsIHBsZWFzZSBu
b3RpZnkgdGhlIHNlbmRlciANCmltbWVkaWF0ZWx5IChieSByZXBseWluZyB0byB0aGlzIGUtbWFp
bCksIGRlbGV0ZSBhbnkgYW5kIGFsbCBjb3BpZXMgb2YgDQp0aGlzIGUtbWFpbCAoaW5jbHVkaW5n
IGFueSBhdHRhY2htZW50cykgZnJvbSB5b3VyIHN5c3RlbSwgYW5kIGRvIG5vdA0KZGlzY2xvc2Ug
dGhlIGNvbnRlbnQgb2YgdGhpcyBlLW1haWwgdG8gYW55IG90aGVyIHBlcnNvbi4gVGhhbmsNCiB5
b3UhPC9wcmU+PCEtLX0tLT4=

--__=_Part_Boundary_008_1874387408.576876725
Content-Type: text/plain

pwm driver add MT2712/MT7622 support, fix clock control issue.
dtsi file will be upload latter, after the clock define is ready.

Zhi Mao (4):
  pwm: kconfig: modify mediatek information
  pwm: mediatek: fix clk issue
  pwm: bindings: add MT2712/MT7622 information
  pwm: mediatek: add MT2712/MT7622 support

 .../devicetree/bindings/pwm/pwm-mediatek.txt       |    6 +-
 drivers/pwm/Kconfig                                |    2 +-
 drivers/pwm/pwm-mediatek.c                         |  132
 ++++++++++++++------
 3 files changed, 100 insertions(+), 40 deletions(-)

--__=_Part_Boundary_008_1874387408.576876725--

--__=_Part_Boundary_007_1456252146.276366653--
