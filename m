From: Jitao Shi <jitao.shi@mediatek.com>
Subject: [v3 3/3] drm/mediatek: add mt8183 dpi support
Date: Tue, 16 Apr 2019 13:52:42 +0800
Message-ID: <20190416055242.75764-4-jitao.shi@mediatek.com>
References: <20190416055242.75764-1-jitao.shi@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190416055242.75764-1-jitao.shi@mediatek.com>
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

U2lnbmVkLW9mZi1ieTogSml0YW8gU2hpIDxqaXRhby5zaGlAbWVkaWF0ZWsuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMgfCAxOSArKysrKysrKysrKysrKysrKysr
CiAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RwaS5jCmluZGV4IDY2NDA1MTU5MTQxYS4uZmJiMDg3MjE4Nzc1IDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHBpLmMKQEAgLTY4MSw2ICs2ODEsMTYgQEAgc3RhdGljIHVuc2lnbmVkIGludCBt
dDI3MDFfY2FsY3VsYXRlX2ZhY3RvcihpbnQgY2xvY2spCiAJCXJldHVybiAyOwogfQogCitzdGF0
aWMgdW5zaWduZWQgaW50IG10ODE4M19jYWxjdWxhdGVfZmFjdG9yKGludCBjbG9jaykKK3sKKwlp
ZiAoY2xvY2sgPD0gMjcwMDApCisJCXJldHVybiA4OworCWVsc2UgaWYgKGNsb2NrIDw9IDE2NzAw
MCkKKwkJcmV0dXJuIDQ7CisJZWxzZQorCQlyZXR1cm4gMjsKK30KKwogc3RhdGljIGNvbnN0IHN0
cnVjdCBtdGtfZHBpX2NvbmYgbXQ4MTczX2NvbmYgPSB7CiAJLmNhbF9mYWN0b3IgPSBtdDgxNzNf
Y2FsY3VsYXRlX2ZhY3RvciwKIAkucmVnX2hfZnJlX2NvbiA9IDB4ZTAsCkBAIC02OTIsNiArNzAy
LDEyIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RwaV9jb25mIG10MjcwMV9jb25mID0gewog
CS5lZGdlX3NlbF9lbiA9IHRydWUsCiB9OwogCitzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kcGlf
Y29uZiBtdDgxODNfY29uZiA9IHsKKwkuY2FsX2ZhY3RvciA9IG10ODE4M19jYWxjdWxhdGVfZmFj
dG9yLAorCS5yZWdfaF9mcmVfY29uID0gMHhlMCwKKwkuZHVhbF9lZGdlID0gdHJ1ZSwKK307CisK
IHN0YXRpYyBpbnQgbXRrX2RwaV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQog
ewogCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7CkBAIC03ODcsNiArODAzLDkgQEAg
c3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbXRrX2RwaV9vZl9pZHNbXSA9IHsKIAl7
IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE3My1kcGkiLAogCSAgLmRhdGEgPSAmbXQ4MTcz
X2NvbmYsCiAJfSwKKwl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My1kcGkiLAorCSAg
LmRhdGEgPSAmbXQ4MTgzX2NvbmYsCisJfSwKIAl7IH0sCiB9OwogCi0tIAoyLjIxLjAKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWls
aW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==
