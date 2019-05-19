From: Jitao Shi <jitao.shi@mediatek.com>
Subject: [v3 0/7] Support dsi for mt8183
Date: Sun, 19 May 2019 17:25:30 +0800
Message-ID: <20190519092537.69053-1-jitao.shi@mediatek.com>
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

Q2hhbmdlcyBzaW5jZSB2MjoKIC0gY2hhbmdlIHRoZSB2aWRlbyB0aW1pbmcgY2FsYyBtZXRob2QK
IC0gZmluZSB0aGUgZHNpIGFuZCBtaXBpdHggaW5pdCBzZXF1ZW5jZQogLSBmaW5lIHR1bmUgY29t
bWl0IG1zZwoKQ2hhbmdlcyBzaW5jZSB2MToKIC0gc2VwYXJhdGUgZnJhbWUgc2l6ZSBhbmQgcmVn
IGNvbW1pdCBjb250cm9sIGluZGVwZW5kZW50IHBhdGNoZXMuCiAtIGZpeCBzb21lIHJldHVybiB2
YWx1ZXMgaW4gcHJvYmUKIC0gcmVtb3ZlIERTSV9DTURXMCBpbiAiQ01EUSByZWcgYWRkcmVzcyBv
ZiBtdDgxNzMgaXMgZGlmZmVyZW50IHdpdGggbXQyNzAxIgoKSml0YW8gU2hpICg3KToKICBkcm0v
bWVkaWF0ZWs6IG1vdmUgbWlwaV9kc2lfaG9zdF9yZWdpc3RlciB0byBwcm9iZQogIGRybS9tZWRp
YXRlazogZml4ZXMgQ01EUSByZWcgYWRkcmVzcyBvZiBtdDgxNzMgaXMgZGlmZmVyZW50IHdpdGgK
ICAgIG10MjcwMQogIGRybS9tZWRpYXRlazogYWRkIGRzaSByZWcgY29tbWl0IGRpc2FibGUgY29u
dHJvbAogIGRybS9tZWRpYXRlazogYWRkIGZyYW1lIHNpemUgY29udHJvbAogIGRybS9tZWRpYXRl
azogYWRkIG10ODE4MyBkc2kgZHJpdmVyIHN1cHBvcnQKICBkcm0vbWVkaWF0ZWs6IGNoYW5nZSB0
aGUgZHNpIHBoeXRpbWluZyBjYWxjdWxhdGUgbWV0aG9kCiAgZHJtOiBtZWRpYXRlazogYWRqdXN0
IGRzaSBhbmQgbWlwaV90eCBwcm9iZSBzZXF1ZW5jZQoKIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHJtX2Rydi5jIHwgICAyICstCiBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rz
aS5jICAgICB8IDIxOSArKysrKysrKysrKysrKysrKystLS0tLS0tCiAyIGZpbGVzIGNoYW5nZWQs
IDE2MyBpbnNlcnRpb25zKCspLCA1OCBkZWxldGlvbnMoLSkKCi0tIAoyLjIxLjAKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5n
IGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==
