From: Jitao Shi <jitao.shi@mediatek.com>
Subject: [v4 0/5] Support dpi for mt8183
Date: Sat, 18 May 2019 17:56:13 +0800
Message-ID: <20190518095618.18454-1-jitao.shi@mediatek.com>
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

Q2hhbmdlcyBzaW5jZSB2MzoKIC0gYWRkIGRwaSBwaW4gbW9kZSBjb250cm9sIHdoZW4gZHBpIG9u
IG9yIG9mZi4KIC0gdXBkYXRlIGRwaSBkdWFsIGVkZ2UgY29tbWVudC4KCkNoYW5nZXMgc2luY2Ug
djI6CiAtIHVwZGF0ZSBkdC1iaW5kaW5ncyBkb2N1bWVudCBmb3IgbXQ4MTgzIGRwaS4KIC0gc2Vw
YXJhdGUgZHVhbCBlZGdlIG1vZGZpY2F0aW9uIGFzIGluZGVwZW5kZW50IHBhdGNoLgoKSml0YW8g
U2hpICg1KToKICBkdC1iaW5kaW5nczogZGlzcGxheTogbWVkaWF0ZWs6IHVwZGF0ZSBkcGkgIHN1
cHBvcnRlZCBjaGlwcwogIGRybS9tZWRpYXRlazogZHBpIGR1YWwgZWRnZSBzdXBwb3J0CiAgZHJt
L21lZGlhdGVrOiBhZGQgbXQ4MTgzIGRwaSBkdWFsIGVkZ2Ugc3VwcG9ydAogIGRybS9tZWRpYXRl
azogY29udHJvbCBkcGkgcGlucyBkcGkgb3IgZ3BpbyBtb2RlIGluIG9uIG9yIG9mZgogIGRybS9t
ZWRpYXRlazogYWRkIG10ODE4MyBzdXBwb3J0IGRwaSBwaW5zIGNvbnRyb2wKCiAuLi4vZGlzcGxh
eS9tZWRpYXRlay9tZWRpYXRlayxkcGkudHh0ICAgICAgICAgfCAgMSArCiBkcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RwaS5jICAgICAgICAgICAgfCA2OCArKysrKysrKysrKysrKysrKyst
CiAyIGZpbGVzIGNoYW5nZWQsIDY3IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgotLSAK
Mi4yMS4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpk
cmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWw=
