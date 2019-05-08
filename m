From: CK Hu <ck.hu@mediatek.com>
Subject: Re: [v2 3/5] drm/mediatek: add dsi reg commit control
Date: Wed, 8 May 2019 10:56:40 +0800
Message-ID: <1557284200.31731.8.camel@mtksdaap41>
References: <20190416060501.76276-1-jitao.shi@mediatek.com>
 <20190416060501.76276-4-jitao.shi@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190416060501.76276-4-jitao.shi@mediatek.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jitao Shi <jitao.shi@mediatek.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>, stonea168@163.com, dri-devel@lists.freedesktop.org, yingjoe.chen@mediatek.com, Ajay Kumar <ajaykumar.rs@samsung.com>, Vincent Palatin <vpalatin@chromium.org>, cawa.cheng@mediatek.com, Russell King <rmk+kernel@arm.linux.org.uk>, Thierry Reding <treding@nvidia.com>, linux-pwm@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, Andy Yan <andy.yan@rock-chips.com>, Matthias Brugger <matthias.bgg@gmail.com>, eddie.huang@mediatek.com, linux-arm-kernel@lists.infradead.org, Rahul Sharma <rahul.sharma@samsung.com>, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Sean Paul <seanpaul@chromium>
List-Id: linux-pwm@vger.kernel.org

SGksIEppdGFvOgoKT24gVHVlLCAyMDE5LTA0LTE2IGF0IDE0OjA0ICswODAwLCBKaXRhbyBTaGkg
d3JvdGU6Cj4gTmV3IERTSSBJUCBoYXMgc2hhZG93IHJlZ2lzdGVyIGFuZCB3b3JraW5nIHJlZy4g
VGhlIHJlZ2lzdGVyCj4gdmFsdWVzIGFyZSB3cml0ZW4gdG8gc2hhZG93IHJlZ2lzdGVyLiBBbmQg
dGhlbiB0cmlnZ2VyIHdpdGgKPiBjb21taXQgcmVnLCB0aGUgcmVnaXN0ZXIgdmFsdWVzIHdpbGwg
YmUgbW92ZWQgd29ya2luZyByZWdpc3Rlci4KClRoaXMgcGF0Y2ggbG9va3MgZ29vZCwgYnV0IHRo
ZSBtZXNzYWdlIGlzIG5vdCBjb21wbGV0ZS4gVGhlIG1lc3NhZ2UgbWFrZQp1cyBiZWxpZXZlIHlv
dSB1c2Ugc2hhZG93IHJlZ2lzdGVyIHRvIHdvcmssIGJ1dCBhY3R1YWxseSwgc2hhZG93CnJlZ2lz
dGVyIGlzIGRlZmF1bHQgdHVybiBvbiBpbiBuZXcgRFNJIElQIGFuZCB5b3Ugd2FudCB0byB0dXJu
IG9mZiBpdC4KClJlZ2FyZHMsCkNLCgo+IAo+IFNpZ25lZC1vZmYtYnk6IEppdGFvIFNoaSA8aml0
YW8uc2hpQG1lZGlhdGVrLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kc2kuYyB8IDEwICsrKysrKysrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMo
KykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYyBi
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMKPiBpbmRleCA1NzNlNmJlYzZkMzYu
LmJlNDI0MDVhMGE3OCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RzaS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYwo+IEBAIC0x
MzEsNiArMTMxLDEwIEBACj4gICNkZWZpbmUgVk1fQ01EX0VOCQkJQklUKDApCj4gICNkZWZpbmUg
VFNfVkZQX0VOCQkJQklUKDUpCj4gIAo+ICsjZGVmaW5lIERTSV9TSEFET1dfREVCVUcJMHgxOTBV
Cj4gKyNkZWZpbmUgRk9SQ0VfQ09NTUlUCQlCSVQoMCkKPiArI2RlZmluZSBCWVBBU1NfU0hBRE9X
CQlCSVQoMSkKPiArCj4gICNkZWZpbmUgQ09ORklHCQkJCSgweGZmIDw8IDApCj4gICNkZWZpbmUg
U0hPUlRfUEFDS0VUCQkJMAo+ICAjZGVmaW5lIExPTkdfUEFDS0VUCQkJMgo+IEBAIC0xNTcsNiAr
MTYxLDcgQEAgc3RydWN0IHBoeTsKPiAgCj4gIHN0cnVjdCBtdGtfZHNpX2RyaXZlcl9kYXRhIHsK
PiAgCWNvbnN0IHUzMiByZWdfY21kcV9vZmY7Cj4gKwlib29sIGhhc19zaGFkb3dfY3RsOwo+ICB9
Owo+ICAKPiAgc3RydWN0IG10a19kc2kgewo+IEBAIC01OTQsNiArNTk5LDExIEBAIHN0YXRpYyBp
bnQgbXRrX2RzaV9wb3dlcm9uKHN0cnVjdCBtdGtfZHNpICpkc2kpCj4gIAl9Cj4gIAo+ICAJbXRr
X2RzaV9lbmFibGUoZHNpKTsKPiArCj4gKwlpZiAoZHNpLT5kcml2ZXJfZGF0YS0+aGFzX3NoYWRv
d19jdGwpCj4gKwkJd3JpdGVsKEZPUkNFX0NPTU1JVCB8IEJZUEFTU19TSEFET1csCj4gKwkJICAg
ICAgIGRzaS0+cmVncyArIERTSV9TSEFET1dfREVCVUcpOwo+ICsKPiAgCW10a19kc2lfcmVzZXRf
ZW5naW5lKGRzaSk7Cj4gIAltdGtfZHNpX3BoeV90aW1jb25maWcoZHNpKTsKPiAgCgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxp
bmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
