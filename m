From: Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v6 0/7] Support dsi for mt8183
Date: Sun, 11 Aug 2019 18:40:01 +0800
Message-ID: <20190811104008.53372-1-jitao.shi@mediatek.com>
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

Q2hhbmdlIHNpbmNlIHY1OgogLSBmaW5lIHR1bmUgZHBoeSB0aW1pbmcuCgpDaGFuZ2Ugc2luY2Ug
djQ6CiAtIG1vdmUgbWlwaV9kc2lfaG9zdF91bnJlZ2l0ZXIoKSB0byAucmVtb3ZlKCkKIC0gZmlu
ZSB0dW5lIGFkZCBmcmFtZSBzaXplIGNvbnRyb2wgY29kaW5nIHN0eWxlCiAtIGNoYW5nZSB0aGUg
ZGF0YSB0eXBlIG9mIGRhdGFfcmF0ZSBhcyB1MzIsIGFuZCBhZGQgRElWX1JPVU5EX1VQX1VMTAog
LSB1c2UgZGl2X3U2NCB3aGVuIDgwMDAwMDAwMDBVTEwgLyBkc2ktPmRhdGFfcmF0ZS4KCkNoYW5n
ZXMgc2luY2UgdjMKIC0gYWRkIG9uZSBtb3JlICd0YWInIGZvciBiaXR3aXNlIGRlZmluZS4KIC0g
YWRkIFRlc3RlZC1ieTogUnlhbiBDYXNlIDxyeWFuZGNhc2VAY2hyb21pdW0ub3JnPgoJYW5kIFJl
dmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPi4KIC0gcmVtb3ZlIGNvbXBhcmUg
ZGFfaHNfemVybyB0byBkYV9oc19wcmVwYXJlLgoKQ2hhbmdlcyBzaW5jZSB2MjoKIC0gY2hhbmdl
IHRoZSB2aWRlbyB0aW1pbmcgY2FsYyBtZXRob2QKIC0gZmluZSB0aGUgZHNpIGFuZCBtaXBpdHgg
aW5pdCBzZXF1ZW5jZQogLSBmaW5lIHR1bmUgY29tbWl0IG1zZwoKQ2hhbmdlcyBzaW5jZSB2MToK
IC0gc2VwYXJhdGUgZnJhbWUgc2l6ZSBhbmQgcmVnIGNvbW1pdCBjb250cm9sIGluZGVwZW5kZW50
IHBhdGNoZXMuCiAtIGZpeCBzb21lIHJldHVybiB2YWx1ZXMgaW4gcHJvYmUKIC0gcmVtb3ZlIERT
SV9DTURXMCBpbiAiQ01EUSByZWcgYWRkcmVzcyBvZiBtdDgxNzMgaXMgZGlmZmVyZW50IHdpdGgg
bXQyNzAxIiAKCkppdGFvIFNoaSAoNyk6CiAgZHJtL21lZGlhdGVrOiBtb3ZlIG1pcGlfZHNpX2hv
c3RfcmVnaXN0ZXIgdG8gcHJvYmUKICBkcm0vbWVkaWF0ZWs6IGZpeGVzIENNRFEgcmVnIGFkZHJl
c3Mgb2YgbXQ4MTczIGlzIGRpZmZlcmVudCB3aXRoCiAgICBtdDI3MDEKICBkcm0vbWVkaWF0ZWs6
IGFkZCBkc2kgcmVnIGNvbW1pdCBkaXNhYmxlIGNvbnRyb2wKICBkcm0vbWVkaWF0ZWs6IGFkZCBm
cmFtZSBzaXplIGNvbnRyb2wKICBkcm0vbWVkaWF0ZWs6IGFkZCBtdDgxODMgZHNpIGRyaXZlciBz
dXBwb3J0CiAgZHJtL21lZGlhdGVrOiBjaGFuZ2UgdGhlIGRzaSBwaHl0aW1pbmcgY2FsY3VsYXRl
IG1ldGhvZAogIGRybTogbWVkaWF0ZWs6IGFkanVzdCBkc2kgYW5kIG1pcGlfdHggcHJvYmUgc2Vx
dWVuY2UKCiBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYyB8ICAgMiArLQog
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYyAgICAgfCAyMjQgKysrKysrKysrKysr
KysrKysrLS0tLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCAxNjEgaW5zZXJ0aW9ucygrKSwgNjUgZGVs
ZXRpb25zKC0pCgotLSAKMi4yMS4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9kcmktZGV2ZWw=
