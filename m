From: Jitao Shi <jitao.shi@mediatek.com>
Subject: [v3 0/3] Support mipitx on mt8183
Date: Sat, 18 May 2019 16:22:24 +0800
Message-ID: <20190518082227.14507-1-jitao.shi@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
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

Q2hhbmdlcyBzaW5jZSB2MjoKIC0gdXBkYXRlIEFja2VkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBr
ZXJuZWwub3JnPgogLSB1cGRhdGUgbXQ4MTgzIG1heCBiaXQgcmF0ZSBzdXBwb3J0CgpDaGFuZ2Vz
IHNpbmNlIHYxOgogLSB1cGRhdGUgZHQtYmluZGluZ3MgZG9jdW1lbnQgZm9yIG10ODE4MyBtaXBp
dHguCiAtIHJlbW92ZSBtdGtfbWlwaXR4X2Nsa19nZXRfb3BzIGFuZCBhc3NpZ24gY2xrX29wcyBp
biBwcm9iZS4KIC0gZml4IHRoZSBsaW5jZW5jZQogLSByZW1vdmUgdHhkaXYxIGZyb20gbXRrX21p
cGlfdHhfcGxsX3ByZXBhcmUKCkppdGFvIFNoaSAoMyk6CiAgZHQtYmluZGluZ3M6IGRpc3BsYXk6
IG1lZGlhdGVrOiB1cGRhdGUgZHNpIHN1cHBvcnRlZCBjaGlwcwogIGRybS9tZWRpYXRlazogc2Vw
YXJhdGUgbWlwaV90eCB0byBkaWZmZXJlbnQgZmlsZQogIGRybS9tZWRpYXRlazogYWRkIG1pcGlf
dHggZHJpdmVyIGZvciBtdDgxODMKCiAuLi4vZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkc2ku
dHh0ICAgICAgICAgfCAgIDIgKy0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9NYWtlZmlsZSAg
ICAgICAgICAgICB8ICAgMiArCiBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX21pcGlfdHgu
YyAgICAgICAgfCAzNDQgKystLS0tLS0tLS0tLS0tLS0tCiBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX21pcGlfdHguaCAgICAgICAgfCAgNTAgKysrCiBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX210ODE3M19taXBpX3R4LmMgfCAyODkgKysrKysrKysrKysrKysrCiBkcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX210ODE4M19taXBpX3R4LmMgfCAxNjAgKysrKysrKysKIDYgZmls
ZXMgY2hhbmdlZCwgNTI3IGluc2VydGlvbnMoKyksIDMyMCBkZWxldGlvbnMoLSkKIGNyZWF0ZSBt
b2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX21pcGlfdHguaAogY3JlYXRl
IG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfbXQ4MTczX21pcGlfdHgu
YwogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfbXQ4MTgz
X21pcGlfdHguYwoKLS0gCjIuMjEuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vZHJpLWRldmVs
