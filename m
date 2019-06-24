From: Jitao Shi <jitao.shi@mediatek.com>
Subject: [v2 0/2] Add BOE tv101wum-nl6 panel driver
Date: Mon, 24 Jun 2019 14:03:41 +0800
Message-ID: <20190624060343.62451-1-jitao.shi@mediatek.com>
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
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark
 Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-pwm@vger.kernel.org, David Airlie <airlied@linux.ie>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: stonea168@163.com, dri-devel@lists.freedesktop.org, Andy Yan <andy.yan@rock-chips.com>, Ajay Kumar <ajaykumar.rs@samsung.com>, Vincent Palatin <vpalatin@chromium.org>, cawa.cheng@mediatek.com, Russell King <rmk+kernel@arm.linux.org.uk>, Thierry Reding <treding@nvidia.com>, devicetree@vger.kernel.org, Jitao Shi <jitao.shi@mediatek.com>, linux-mediatek@lists.infradead.org, yingjoe.chen@mediatek.com, eddie.huang@mediatek.com, linux-arm-kernel@lists.infradead.org, Rahul Sharma <rahul.sharma@samsung.com>, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Sean Paul <seanpaul@chromium.org>
List-Id: linux-pwm@vger.kernel.org

Q2hhbmdlcyBzaW5jZSB2MToKCiAtIHVwZGF0ZSB0eXBvIG5sNiAtPiBuMTYuCiAtIHVwZGF0ZSBu
ZXcgcGFuZWwgY29uZmlnIGFuZCBtYWtlZmlsZSBhcmUgYWRkZWQgaW4gYWxwaGFiZXRpY2FsbHkg
b3JkZXIuCiAtIGFkZCB0aGUgcGFuZWwgbW9kZSBhbmQgcGFuZWwgaW5mbyBpbiBkcml2ZXIgZGF0
YS4KCkppdGFvIFNoaSAoMik6CiAgZHQtYmluZG5nczogZGlzcGxheTogcGFuZWw6IEFkZCBCT0Ug
dHYxMDF3dW0tbjE2IHBhbmVsIGJpbmRpbmdzCiAgZHJtL3BhbmVsOiBzdXBwb3J0IGZvciBCT0Ug
dHYxMDF3dW0tbmw2IHd1eGdhIGRzaSB2aWRlbyBtb2RlIHBhbmVsCgogLi4uL2Rpc3BsYXkvcGFu
ZWwvYm9lLHR2MTAxd3VtLW5sNi50eHQgICAgICAgIHwgIDM0ICsKIGRyaXZlcnMvZ3B1L2RybS9w
YW5lbC9LY29uZmlnICAgICAgICAgICAgICAgICB8ICAxMCArCiBkcml2ZXJzL2dwdS9kcm0vcGFu
ZWwvTWFrZWZpbGUgICAgICAgICAgICAgICAgfCAgIDEgKwogLi4uL2dwdS9kcm0vcGFuZWwvcGFu
ZWwtYm9lLXR2MTAxd3VtLW5sNi5jICAgIHwgNzE1ICsrKysrKysrKysrKysrKysrKwogNCBmaWxl
cyBjaGFuZ2VkLCA3NjAgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L3BhbmVsL2JvZSx0djEwMXd1bS1ubDYu
dHh0CiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL3BhbmVsL3BhbmVsLWJvZS10
djEwMXd1bS1ubDYuYwoKLS0gCjIuMjEuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vZHJpLWRldmVs
