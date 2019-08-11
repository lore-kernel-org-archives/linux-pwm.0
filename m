From: Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v6 3/7] drm/mediatek: add dsi reg commit disable control
Date: Sun, 11 Aug 2019 18:40:04 +0800
Message-ID: <20190811104008.53372-4-jitao.shi@mediatek.com>
References: <20190811104008.53372-1-jitao.shi@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190811104008.53372-1-jitao.shi@mediatek.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark
 Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-pwm@vger.kernel.org, David Airlie <airlied@linux.ie>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: stonea168@163.com, dri-devel@lists.freedesktop.org, Andy Yan <andy.yan@rock-chips.com>, Ajay Kumar <ajaykumar.rs@samsung.com>, Vincent Palatin <vpalatin@chromium.org>, cawa.cheng@mediatek.com, Russell King <rmk+kernel@arm.linux.org.uk>, Thierry Reding <treding@nvidia.com>, devicetree@vger.kernel.org, Jitao Shi <jitao.shi@mediatek.com>, linux-mediatek@lists.infradead.org, yingjoe.chen@mediatek.com, eddie.huang@mediatek.com, linux-arm-kernel@lists.infradead.org, Rahul Sharma <rahul.sharma@samsung.com>, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Sean Paul <seanpaul@chromium.org>
List-Id: linux-pwm@vger.kernel.org

TmV3IERTSSBJUCBoYXMgc2hhZG93IHJlZ2lzdGVyIGFuZCB3b3JraW5nIHJlZy4gVGhlIHJlZ2lz
dGVyCnZhbHVlcyBhcmUgd3JpdGVuIHRvIHNoYWRvdyByZWdpc3Rlci4gQW5kIHRoZW4gdHJpZ2dl
ciB3aXRoCmNvbW1pdCByZWcsIHRoZSByZWdpc3RlciB2YWx1ZXMgd2lsbCBiZSBtb3ZlZCB3b3Jr
aW5nIHJlZ2lzdGVyLgoKVGhpcyBmdWNudGlvbiBpcyBkZWZ1YWx0IG9uLiBCdXQgdGhpcyBkcml2
ZXIgZG9lc24ndCB1c2UgdGhpcwpmdW5jdGlvbi4gU28gYWRkIHRoZSBkaXNhYmxlIGNvbnRyb2wu
CgpTaWduZWQtb2ZmLWJ5OiBKaXRhbyBTaGkgPGppdGFvLnNoaUBtZWRpYXRlay5jb20+ClJldmll
d2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHNpLmMgfCAxMCArKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5z
ZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNp
LmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jCmluZGV4IGFjOGU4MGUzNzlm
Ny4uMzE0YmZiMWM4MjdiIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RzaS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMKQEAgLTEyMyw2
ICsxMjMsMTAgQEAKICNkZWZpbmUgVk1fQ01EX0VOCQkJQklUKDApCiAjZGVmaW5lIFRTX1ZGUF9F
TgkJCUJJVCg1KQogCisjZGVmaW5lIERTSV9TSEFET1dfREVCVUcJMHgxOTBVCisjZGVmaW5lIEZP
UkNFX0NPTU1JVAkJCUJJVCgwKQorI2RlZmluZSBCWVBBU1NfU0hBRE9XCQkJQklUKDEpCisKICNk
ZWZpbmUgQ09ORklHCQkJCSgweGZmIDw8IDApCiAjZGVmaW5lIFNIT1JUX1BBQ0tFVAkJCTAKICNk
ZWZpbmUgTE9OR19QQUNLRVQJCQkyCkBAIC0xNDksNiArMTUzLDcgQEAgc3RydWN0IHBoeTsKIAog
c3RydWN0IG10a19kc2lfZHJpdmVyX2RhdGEgewogCWNvbnN0IHUzMiByZWdfY21kcV9vZmY7CisJ
Ym9vbCBoYXNfc2hhZG93X2N0bDsKIH07CiAKIHN0cnVjdCBtdGtfZHNpIHsKQEAgLTU4Niw2ICs1
OTEsMTEgQEAgc3RhdGljIGludCBtdGtfZHNpX3Bvd2Vyb24oc3RydWN0IG10a19kc2kgKmRzaSkK
IAl9CiAKIAltdGtfZHNpX2VuYWJsZShkc2kpOworCisJaWYgKGRzaS0+ZHJpdmVyX2RhdGEtPmhh
c19zaGFkb3dfY3RsKQorCQl3cml0ZWwoRk9SQ0VfQ09NTUlUIHwgQllQQVNTX1NIQURPVywKKwkJ
ICAgICAgIGRzaS0+cmVncyArIERTSV9TSEFET1dfREVCVUcpOworCiAJbXRrX2RzaV9yZXNldF9l
bmdpbmUoZHNpKTsKIAltdGtfZHNpX3BoeV90aW1jb25maWcoZHNpKTsKIAotLSAKMi4yMS4wCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwg
bWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWw=
