From: Jitao Shi <jitao.shi@mediatek.com>
Subject: [v4 4/7] drm/mediatek: add frame size control
Date: Sat, 1 Jun 2019 17:26:12 +0800
Message-ID: <20190601092615.67917-5-jitao.shi@mediatek.com>
References: <20190601092615.67917-1-jitao.shi@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190601092615.67917-1-jitao.shi@mediatek.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-pwm@vger.kernel.org, David Airlie <airlied@linux.ie>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: stonea168@163.com, dri-devel@lists.freedesktop.org, Andy Yan <andy.yan@rock-chips.com>, Ajay Kumar <ajaykumar.rs@samsung.com>, Vincent Palatin <vpalatin@chromium.org>, cawa.cheng@mediatek.com, Russell King <rmk+kernel@arm.linux.org.uk>, Thierry Reding <treding@nvidia.com>, devicetree@vger.kernel.org, Jitao Shi <jitao.shi@mediatek.com>, linux-mediatek@lists.infradead.org, yingjoe.chen@mediatek.com, eddie.huang@mediatek.com, linux-arm-kernel@lists.infradead.org, Rahul Sharma <rahul.sharma@samsung.com>, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Sean Paul <seanpaul@chromium.org>
List-Id: linux-pwm@vger.kernel.org

T3VyIG5ldyBEU0kgY2hpcCBoYXMgZnJhbWUgc2l6ZSBjb250cm9sLgpTbyBhZGQgdGhlIGRyaXZl
ciBkYXRhIHRvIGNvbnRyb2wgZm9yIGRpZmZlcmVudCBjaGlwcy4KClNpZ25lZC1vZmYtYnk6IEpp
dGFvIFNoaSA8aml0YW8uc2hpQG1lZGlhdGVrLmNvbT4KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5o
dUBtZWRpYXRlay5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYyB8
IDUgKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kc2kuYwppbmRleCBlZWE0NzI5NDA3OWUuLjE4YTE5MjY1NmE4OSAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RzaS5jCkBAIC03OCw2ICs3OCw3IEBACiAjZGVmaW5lIERTSV9WQlBf
TkwJCTB4MjQKICNkZWZpbmUgRFNJX1ZGUF9OTAkJMHgyOAogI2RlZmluZSBEU0lfVkFDVF9OTAkJ
MHgyQworI2RlZmluZSBEU0lfU0laRV9DT04JCTB4MzgKICNkZWZpbmUgRFNJX0hTQV9XQwkJMHg1
MAogI2RlZmluZSBEU0lfSEJQX1dDCQkweDU0CiAjZGVmaW5lIERTSV9IRlBfV0MJCTB4NTgKQEAg
LTE2Miw2ICsxNjMsNyBAQCBzdHJ1Y3QgcGh5Owogc3RydWN0IG10a19kc2lfZHJpdmVyX2RhdGEg
ewogCWNvbnN0IHUzMiByZWdfY21kcV9vZmY7CiAJYm9vbCBoYXNfc2hhZG93X2N0bDsKKwlib29s
IGhhc19zaXplX2N0bDsKIH07CiAKIHN0cnVjdCBtdGtfZHNpIHsKQEAgLTQzMCw2ICs0MzIsOSBA
QCBzdGF0aWMgdm9pZCBtdGtfZHNpX2NvbmZpZ192ZG9fdGltaW5nKHN0cnVjdCBtdGtfZHNpICpk
c2kpCiAJd3JpdGVsKHZtLT52ZnJvbnRfcG9yY2gsIGRzaS0+cmVncyArIERTSV9WRlBfTkwpOwog
CXdyaXRlbCh2bS0+dmFjdGl2ZSwgZHNpLT5yZWdzICsgRFNJX1ZBQ1RfTkwpOwogCisJaWYgKGRz
aS0+ZHJpdmVyX2RhdGEtPmhhc19zaXplX2N0bCkKKwkJd3JpdGVsKHZtLT52YWN0aXZlIDw8IDE2
IHwgdm0tPmhhY3RpdmUsIGRzaS0+cmVncyArIERTSV9TSVpFX0NPTik7CisKIAlob3Jpem9udGFs
X3N5bmNfYWN0aXZlX2J5dGUgPSAodm0tPmhzeW5jX2xlbiAqIGRzaV90bXBfYnVmX2JwcCAtIDEw
KTsKIAogCWlmIChkc2ktPm1vZGVfZmxhZ3MgJiBNSVBJX0RTSV9NT0RFX1ZJREVPX1NZTkNfUFVM
U0UpCi0tIAoyLjIxLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1k
ZXZlbA==
