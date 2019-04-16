From: Jitao Shi <jitao.shi@mediatek.com>
Subject: [v2 4/5] drm/mediatek: add frame size control
Date: Tue, 16 Apr 2019 14:05:00 +0800
Message-ID: <20190416060501.76276-5-jitao.shi@mediatek.com>
References: <20190416060501.76276-1-jitao.shi@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190416060501.76276-1-jitao.shi@mediatek.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-pwm@vger.kernel.org, David Airlie <airlied@linux.ie>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: stonea168@163.com, dri-devel@lists.freedesktop.org, Andy Yan <andy.yan@rock-chips.com>, Ajay Kumar <ajaykumar.rs@samsung.com>, Vincent Palatin <vpalatin@chromium.org>, cawa.cheng@mediatek.com, Russell King <rmk+kernel@arm.linux.org.uk>, Thierry Reding <treding@nvidia.com>, devicetree@vger.kernel.org, Jitao Shi <jitao.shi@mediatek.com>, linux-mediatek@lists.infradead.org, yingjoe.chen@mediatek.com, eddie.huang@mediatek.com, linux-arm-kernel@lists.infradead.org, Rahul Sharma <rahul.sharma@samsung.com>, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Sean Paul <seanpaul@chromium.org>
List-Id: linux-pwm@vger.kernel.org

T3VyIG5ldyBEU0kgY2hpcCBoYXMgZnJhbWUgc2l6ZSBjb250cm9sLgpTbyBhZGQgdGhlIGRyaXZl
ciBkYXRhIHRvIGNvbnRyb2wgZm9yIGRpZmZlcmVudCBjaGlwcy4KClNpZ25lZC1vZmYtYnk6IEpp
dGFvIFNoaSA8aml0YW8uc2hpQG1lZGlhdGVrLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RzaS5jIHwgNSArKysrKwogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygr
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMgYi9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jCmluZGV4IGJlNDI0MDVhMGE3OC4uNDU4YTcw
MGNlNzRjIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMKQEAgLTc4LDYgKzc4LDcgQEAK
ICNkZWZpbmUgRFNJX1ZCUF9OTAkJMHgyNAogI2RlZmluZSBEU0lfVkZQX05MCQkweDI4CiAjZGVm
aW5lIERTSV9WQUNUX05MCQkweDJDCisjZGVmaW5lIERTSV9TSVpFX0NPTgkJMHgzOAogI2RlZmlu
ZSBEU0lfSFNBX1dDCQkweDUwCiAjZGVmaW5lIERTSV9IQlBfV0MJCTB4NTQKICNkZWZpbmUgRFNJ
X0hGUF9XQwkJMHg1OApAQCAtMTYyLDYgKzE2Myw3IEBAIHN0cnVjdCBwaHk7CiBzdHJ1Y3QgbXRr
X2RzaV9kcml2ZXJfZGF0YSB7CiAJY29uc3QgdTMyIHJlZ19jbWRxX29mZjsKIAlib29sIGhhc19z
aGFkb3dfY3RsOworCWJvb2wgaGFzX3NpemVfY3RsOwogfTsKIAogc3RydWN0IG10a19kc2kgewpA
QCAtNDMwLDYgKzQzMiw5IEBAIHN0YXRpYyB2b2lkIG10a19kc2lfY29uZmlnX3Zkb190aW1pbmco
c3RydWN0IG10a19kc2kgKmRzaSkKIAl3cml0ZWwodm0tPnZmcm9udF9wb3JjaCwgZHNpLT5yZWdz
ICsgRFNJX1ZGUF9OTCk7CiAJd3JpdGVsKHZtLT52YWN0aXZlLCBkc2ktPnJlZ3MgKyBEU0lfVkFD
VF9OTCk7CiAKKwlpZiAoZHNpLT5kcml2ZXJfZGF0YS0+aGFzX3NpemVfY3RsKQorCQl3cml0ZWwo
dm0tPnZhY3RpdmUgPDwgMTYgfCB2bS0+aGFjdGl2ZSwgZHNpLT5yZWdzICsgRFNJX1NJWkVfQ09O
KTsKKwogCWhvcml6b250YWxfc3luY19hY3RpdmVfYnl0ZSA9ICh2bS0+aHN5bmNfbGVuICogZHNp
X3RtcF9idWZfYnBwIC0gMTApOwogCiAJaWYgKGRzaS0+bW9kZV9mbGFncyAmIE1JUElfRFNJX01P
REVfVklERU9fU1lOQ19QVUxTRSkKLS0gCjIuMjEuMAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vZHJpLWRldmVs
