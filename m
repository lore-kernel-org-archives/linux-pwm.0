From: Jitao Shi <jitao.shi@mediatek.com>
Subject: [v2 5/5] drm/mediatek: add mt8183 dsi driver support
Date: Tue, 16 Apr 2019 14:05:01 +0800
Message-ID: <20190416060501.76276-6-jitao.shi@mediatek.com>
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

QWRkIG10ODE4MyBkc2kgZHJpdmVyIGRhdGEuIEVuYWJsZSBzaXplIGNvbnRyb2wgYW5kCnJlZyBj
b21taXQgY29udHJvbC4KClNpZ25lZC1vZmYtYnk6IEppdGFvIFNoaSA8aml0YW8uc2hpQG1lZGlh
dGVrLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jIHwgOCArKysr
KysrKwogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RzaS5jCmluZGV4IDQ1OGE3MDBjZTc0Yy4uZjBiMzZlYzM4ZTRmIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHNpLmMKQEAgLTExMDQsMTEgKzExMDQsMTkgQEAgc3RhdGljIGNvbnN0IHN0
cnVjdCBtdGtfZHNpX2RyaXZlcl9kYXRhIG10MjcwMV9kc2lfZHJpdmVyX2RhdGEgPSB7CiAJLnJl
Z19jbWRxX29mZiA9IDB4MTgwLAogfTsKIAorc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZHNpX2Ry
aXZlcl9kYXRhIG10ODE4M19kc2lfZHJpdmVyX2RhdGEgPSB7CisJLnJlZ19jbWRxX29mZiA9IDB4
MjAwLAorCS5oYXNfc2hhZG93X2N0bCA9IHRydWUsCisJLmhhc19zaXplX2N0bCA9IHRydWUsCit9
OworCiBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtdGtfZHNpX29mX21hdGNoW10g
PSB7CiAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDI3MDEtZHNpIiwKIAkgIC5kYXRhID0g
Jm10MjcwMV9kc2lfZHJpdmVyX2RhdGEgfSwKIAl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10
ODE3My1kc2kiLAogCSAgLmRhdGEgPSAmbXQ4MTczX2RzaV9kcml2ZXJfZGF0YSB9LAorCXsgLmNv
bXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTgzLWRzaSIsCisJICAuZGF0YSA9ICZtdDgxODNfZHNp
X2RyaXZlcl9kYXRhIH0sCiAJeyB9LAogfTsKIAotLSAKMi4yMS4wCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRy
aS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWw=
