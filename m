From: Jitao Shi <jitao.shi@mediatek.com>
Subject: [v3 2/3] drm/mediatek: dpi dual edge support
Date: Tue, 16 Apr 2019 13:52:41 +0800
Message-ID: <20190416055242.75764-3-jitao.shi@mediatek.com>
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
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMgfCAxMCArKysrKysrKysrCiAxIGZpbGUg
Y2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHBpLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jCmlu
ZGV4IDIyZTY4YTEwMGU3Yi4uNjY0MDUxNTkxNDFhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RwaS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHBpLmMKQEAgLTExNyw2ICsxMTcsNyBAQCBzdHJ1Y3QgbXRrX2RwaV9jb25mIHsKIAl1bnNpZ25l
ZCBpbnQgKCpjYWxfZmFjdG9yKShpbnQgY2xvY2spOwogCXUzMiByZWdfaF9mcmVfY29uOwogCWJv
b2wgZWRnZV9zZWxfZW47CisJYm9vbCBkdWFsX2VkZ2U7CiB9OwogCiBzdGF0aWMgdm9pZCBtdGtf
ZHBpX21hc2soc3RydWN0IG10a19kcGkgKmRwaSwgdTMyIG9mZnNldCwgdTMyIHZhbCwgdTMyIG1h
c2spCkBAIC0zNTMsNiArMzU0LDEzIEBAIHN0YXRpYyB2b2lkIG10a19kcGlfY29uZmlnX2Rpc2Fi
bGVfZWRnZShzdHJ1Y3QgbXRrX2RwaSAqZHBpKQogCQltdGtfZHBpX21hc2soZHBpLCBkcGktPmNv
bmYtPnJlZ19oX2ZyZV9jb24sIDAsIEVER0VfU0VMX0VOKTsKIH0KIAorc3RhdGljIHZvaWQgbXRr
X2RwaV9lbmFibGVfZHVhbF9lZGdlKHN0cnVjdCBtdGtfZHBpICpkcGkpCit7CisJbXRrX2RwaV9t
YXNrKGRwaSwgRFBJX0REUl9TRVRUSU5HLCBERFJfRU4gfCBERFJfNFBIQVNFLAorCQkgICAgIERE
Ul9FTiB8IEREUl80UEhBU0UpOworCW10a19kcGlfbWFzayhkcGksIERQSV9PVVRQVVRfU0VUVElO
RywgRURHRV9TRUwsIEVER0VfU0VMKTsKK30KKwogc3RhdGljIHZvaWQgbXRrX2RwaV9jb25maWdf
Y29sb3JfZm9ybWF0KHN0cnVjdCBtdGtfZHBpICpkcGksCiAJCQkJCWVudW0gbXRrX2RwaV9vdXRf
Y29sb3JfZm9ybWF0IGZvcm1hdCkKIHsKQEAgLTUwOSw2ICs1MTcsOCBAQCBzdGF0aWMgaW50IG10
a19kcGlfc2V0X2Rpc3BsYXlfbW9kZShzdHJ1Y3QgbXRrX2RwaSAqZHBpLAogCW10a19kcGlfY29u
ZmlnX2NvbG9yX2Zvcm1hdChkcGksIGRwaS0+Y29sb3JfZm9ybWF0KTsKIAltdGtfZHBpX2NvbmZp
Z18ybl9oX2ZyZShkcGkpOwogCW10a19kcGlfY29uZmlnX2Rpc2FibGVfZWRnZShkcGkpOworCWlm
IChkcGktPmNvbmYtPmR1YWxfZWRnZSkKKwkJbXRrX2RwaV9lbmFibGVfZHVhbF9lZGdlKGRwaSk7
CiAJbXRrX2RwaV9zd19yZXNldChkcGksIGZhbHNlKTsKIAogCXJldHVybiAwOwotLSAKMi4yMS4w
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2
ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWw=
