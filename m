From: Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH 2/2] pwm/mtk_disp: fix update reg issue when chip doesn't have
 commit
Date: Sun, 19 May 2019 18:56:49 +0800
Message-ID: <20190519105649.72368-3-jitao.shi@mediatek.com>
References: <20190519105649.72368-1-jitao.shi@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190519105649.72368-1-jitao.shi@mediatek.com>
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

VGhlIHNldHRpbmcgb2YgZGlzYWJsZSBkb3VibGUgYnVmZmVyIHdpbGwgbG9zZSB3aGVuIHN1c3Bl
bmQgYW5kIHJlc3VtZS4KU28gY29uZmlnIHRoZW0gYWdhaW4gaW4gcHdtIGNvbmZpZy4KClNpZ25l
ZC1vZmYtYnk6IEppdGFvIFNoaSA8aml0YW8uc2hpQG1lZGlhdGVrLmNvbT4KLS0tCiBkcml2ZXJz
L3B3bS9wd20tbXRrLWRpc3AuYyB8IDcgKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0
aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcHdtL3B3bS1tdGstZGlzcC5jIGIvZHJpdmVy
cy9wd20vcHdtLW10ay1kaXNwLmMKaW5kZXggMjcwNzlhY2MzZTFkLi4xNGVmOTgxMTY0ZDMgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvcHdtL3B3bS1tdGstZGlzcC5jCisrKyBiL2RyaXZlcnMvcHdtL3B3
bS1tdGstZGlzcC5jCkBAIC0xMzAsNiArMTMwLDEzIEBAIHN0YXRpYyBpbnQgbXRrX2Rpc3BfcHdt
X2NvbmZpZyhzdHJ1Y3QgcHdtX2NoaXAgKmNoaXAsIHN0cnVjdCBwd21fZGV2aWNlICpwd20sCiAJ
CW10a19kaXNwX3B3bV91cGRhdGVfYml0cyhtZHAsIG1kcC0+ZGF0YS0+Y29tbWl0LAogCQkJCQkg
bWRwLT5kYXRhLT5jb21taXRfbWFzaywKIAkJCQkJIDB4MCk7CisJfSBlbHNlIHsKKwkJbXRrX2Rp
c3BfcHdtX3VwZGF0ZV9iaXRzKG1kcCwgbWRwLT5kYXRhLT5ibHNfZGVidWcsCisJCQkJCSBtZHAt
PmRhdGEtPmJsc19kZWJ1Z19tYXNrLAorCQkJCQkgbWRwLT5kYXRhLT5ibHNfZGVidWdfbWFzayk7
CisJCW10a19kaXNwX3B3bV91cGRhdGVfYml0cyhtZHAsIG1kcC0+ZGF0YS0+Y29uMCwKKwkJCQkJ
IG1kcC0+ZGF0YS0+Y29uMF9zZWwsCisJCQkJCSBtZHAtPmRhdGEtPmNvbjBfc2VsKTsKIAl9CiAK
IAljbGtfZGlzYWJsZV91bnByZXBhcmUobWRwLT5jbGtfbW0pOwotLSAKMi4yMS4wCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGlu
ZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWw=
