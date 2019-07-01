From: CK Hu <ck.hu@mediatek.com>
Subject: Re: [v5 4/7] drm/mediatek: add frame size control
Date: Mon, 1 Jul 2019 09:29:22 +0800
Message-ID: <1561944562.17120.1.camel@mtksdaap41>
References: <20190627080116.40264-1-jitao.shi@mediatek.com>
 <20190627080116.40264-5-jitao.shi@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190627080116.40264-5-jitao.shi@mediatek.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>, stonea168@163.com, dri-devel@lists.freedesktop.org, yingjoe.chen@mediatek.com, Ajay Kumar <ajaykumar.rs@samsung.com>, Vincent Palatin <vpalatin@chromium.org>, cawa.cheng@mediatek.com, Russell King <rmk+kernel@arm.linux.org.uk>, Thierry Reding <treding@nvidia.com>, linux-pwm@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, Andy Yan <andy.yan@rock-chips.com>, Matthias Brugger <matthias.bgg@gmail.com>, eddie.huang@mediatek.com, linux-arm-kernel@lists.infradead.org, Rahul Sharma <rahul.sharma@samsung.com>, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, Sean Paul <seanpaul@chromium.org>
List-Id: linux-pwm@vger.kernel.org

SGksIEppdGFvOgoKT24gVGh1LCAyMDE5LTA2LTI3IGF0IDE2OjAxICswODAwLCBKaXRhbyBTaGkg
d3JvdGU6Cj4gT3VyIG5ldyBEU0kgY2hpcCBoYXMgZnJhbWUgc2l6ZSBjb250cm9sLgo+IFNvIGFk
ZCB0aGUgZHJpdmVyIGRhdGEgdG8gY29udHJvbCBmb3IgZGlmZmVyZW50IGNoaXBzLgo+IAo+IFNp
Z25lZC1vZmYtYnk6IEppdGFvIFNoaSA8aml0YW8uc2hpQG1lZGlhdGVrLmNvbT4KPiBSZXZpZXdl
ZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4KClRoaXMgdmVyc2lvbiBpcyBkaWZmZXJl
bnQgdGhhbiBwcmV2aW91cyB2ZXJzaW9uLCBzbyB5b3Ugc2hvdWxkIHJlbW92ZQp0aGUgcmV2aWV3
ZWQtYnkgdGFnLiBGb3IgdGhpcyB2ZXJzaW9uLCBJIHN0aWxsIGdpdmUgeW91IGEKClJldmlld2Vk
LWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPgoKPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kc2kuYyB8IDYgKysrKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2Vy
dGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
c2kuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMKPiBpbmRleCA2YjY1NTA5
MjZkYjYuLjQ1ZTMzMTA1NTg0MiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RzaS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYwo+
IEBAIC03OCw2ICs3OCw3IEBACj4gICNkZWZpbmUgRFNJX1ZCUF9OTAkJMHgyNAo+ICAjZGVmaW5l
IERTSV9WRlBfTkwJCTB4MjgKPiAgI2RlZmluZSBEU0lfVkFDVF9OTAkJMHgyQwo+ICsjZGVmaW5l
IERTSV9TSVpFX0NPTgkJMHgzOAo+ICAjZGVmaW5lIERTSV9IU0FfV0MJCTB4NTAKPiAgI2RlZmlu
ZSBEU0lfSEJQX1dDCQkweDU0Cj4gICNkZWZpbmUgRFNJX0hGUF9XQwkJMHg1OAo+IEBAIC0xNjIs
NiArMTYzLDcgQEAgc3RydWN0IHBoeTsKPiAgc3RydWN0IG10a19kc2lfZHJpdmVyX2RhdGEgewo+
ICAJY29uc3QgdTMyIHJlZ19jbWRxX29mZjsKPiAgCWJvb2wgaGFzX3NoYWRvd19jdGw7Cj4gKwli
b29sIGhhc19zaXplX2N0bDsKPiAgfTsKPiAgCj4gIHN0cnVjdCBtdGtfZHNpIHsKPiBAQCAtNDMw
LDYgKzQzMiwxMCBAQCBzdGF0aWMgdm9pZCBtdGtfZHNpX2NvbmZpZ192ZG9fdGltaW5nKHN0cnVj
dCBtdGtfZHNpICpkc2kpCj4gIAl3cml0ZWwodm0tPnZmcm9udF9wb3JjaCwgZHNpLT5yZWdzICsg
RFNJX1ZGUF9OTCk7Cj4gIAl3cml0ZWwodm0tPnZhY3RpdmUsIGRzaS0+cmVncyArIERTSV9WQUNU
X05MKTsKPiAgCj4gKwlpZiAoZHNpLT5kcml2ZXJfZGF0YS0+aGFzX3NpemVfY3RsKQo+ICsJCXdy
aXRlbCh2bS0+dmFjdGl2ZSA8PCAxNiB8IHZtLT5oYWN0aXZlLAo+ICsJCSAgICAgICBkc2ktPnJl
Z3MgKyBEU0lfU0laRV9DT04pOwo+ICsKPiAgCWhvcml6b250YWxfc3luY19hY3RpdmVfYnl0ZSA9
ICh2bS0+aHN5bmNfbGVuICogZHNpX3RtcF9idWZfYnBwIC0gMTApOwo+ICAKPiAgCWlmIChkc2kt
Pm1vZGVfZmxhZ3MgJiBNSVBJX0RTSV9NT0RFX1ZJREVPX1NZTkNfUFVMU0UpCgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcg
bGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
