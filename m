From: Jitao Shi <jitao.shi@mediatek.com>
Subject: [v3 0/4] Add drivers for auo, kd101n80-45na and boe,
 tv101wum-nl6 panels
Date: Wed, 26 Jun 2019 10:53:56 +0800
Message-ID: <20190626025400.109567-1-jitao.shi@mediatek.com>
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

Q2hhbmdlcyBzaW5jZSB2MjoKIC0gY29ycmVjdCB0aGUgcGFuZWwgc2l6ZQogLSByZW1vdmUgYmxh
bmsgbGluZSBpbiBLY29uZmlnCiAtIG1vdmUgYXVvLGtkMTAxbjgwLTQ1bmEgcGFuZWwgZHJpdmVy
IGluIHRoaXMgc2VyaWVzLgoKQ2hhbmdlcyBzaW5jZSB2MToKCiAtIHVwZGF0ZSB0eXBvIG5sNiAt
PiBuMTYuCiAtIHVwZGF0ZSBuZXcgcGFuZWwgY29uZmlnIGFuZCBtYWtlZmlsZSBhcmUgYWRkZWQg
aW4gYWxwaGFiZXRpY2FsbHkgb3JkZXIuCiAtIGFkZCB0aGUgcGFuZWwgbW9kZSBhbmQgcGFuZWwg
aW5mbyBpbiBkcml2ZXIgZGF0YS4KIC0gbWVyZ2UgYXVvLGtkMTAxbjgwLTQ1YSBhbmQgYm9lLHR2
MTAxd3VtLW5sNiBpbiBvbmUgZHJpdmVyCgpKaXRhbyBTaGkgKDQpOgogIGR0LWJpbmRuZ3M6IGRp
c3BsYXk6IHBhbmVsOiBBZGQgQk9FIHR2MTAxd3VtLW4xNiBwYW5lbCBiaW5kaW5ncwogIGRybS9w
YW5lbDogc3VwcG9ydCBmb3IgQk9FIHR2MTAxd3VtLW5sNiB3dXhnYSBkc2kgdmlkZW8gbW9kZSBw
YW5lbAogIGR0LWJpbmRpbmdzOiBkaXNwbGF5OiBwYW5lbDogYWRkIGF1byBrZDEwMW44MC00NW5h
IHBhbmVsIGJpbmRpbmdzCiAgZHJtL3BhbmVsOiBzdXBwb3J0IGZvciBhdW8sa2QxMDFuODAtNDVu
YSB3dXhnYSBkc2kgdmlkZW8gbW9kZSBwYW5lbAoKIC4uLi9kaXNwbGF5L3BhbmVsL2F1byxrZDEw
MW44MC00NW5hLnR4dCAgICAgICB8ICAzNCArCiAuLi4vZGlzcGxheS9wYW5lbC9ib2UsdHYxMDF3
dW0tbmw2LnR4dCAgICAgICAgfCAgMzQgKwogZHJpdmVycy9ncHUvZHJtL3BhbmVsL0tjb25maWcg
ICAgICAgICAgICAgICAgIHwgICA5ICsKIGRyaXZlcnMvZ3B1L2RybS9wYW5lbC9NYWtlZmlsZSAg
ICAgICAgICAgICAgICB8ICAgMSArCiAuLi4vZ3B1L2RybS9wYW5lbC9wYW5lbC1ib2UtdHYxMDF3
dW0tbmw2LmMgICAgfCA3NTMgKysrKysrKysrKysrKysrKysrCiA1IGZpbGVzIGNoYW5nZWQsIDgz
MSBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2Rpc3BsYXkvcGFuZWwvYXVvLGtkMTAxbjgwLTQ1bmEudHh0CiBjcmVhdGUg
bW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvcGFu
ZWwvYm9lLHR2MTAxd3VtLW5sNi50eHQKIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9k
cm0vcGFuZWwvcGFuZWwtYm9lLXR2MTAxd3VtLW5sNi5jCgotLSAKMi4yMS4wCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBs
aXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWw=
