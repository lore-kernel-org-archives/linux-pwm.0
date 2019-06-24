From: Jitao Shi <jitao.shi@mediatek.com>
Subject: [v2 0/2] add auo,kd101n80-45a panel driver
Date: Mon, 24 Jun 2019 15:59:59 +0800
Message-ID: <20190624080001.67222-1-jitao.shi@mediatek.com>
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
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-pwm@vger.kernel.org, David Airlie <airlied@linux.ie>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: stonea168@163.com, dri-devel@lists.freedesktop.org, Andy Yan <andy.yan@rock-chips.com>, Ajay Kumar <ajaykumar.rs@samsung.com>, Vincent Palatin <vpalatin@chromium.org>, cawa.cheng@mediatek.com, Russell King <rmk+kernel@arm.linux.org.uk>, Thierry Reding <treding@nvidia.com>, devicetree@vger.kernel.org, Jitao Shi <jitao.shi@mediatek.com>, linux-mediatek@lists.infradead.org, yingjoe.chen@mediatek.com, eddie.huang@mediatek.com, linux-arm-kernel@lists.infradead.org, Rahul Sharma <rahul.sharma@samsung.com>, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Sean Paul <seanpaul@chromium.org>
List-Id: linux-pwm@vger.kernel.org

Q2hhbmdlcyBzaW5jZSB2MToKIC0gbWVyZ2UgYXVvLGtkMTAxbjgwLTQ1YSBhbmQgYm9lLHR2MTAx
d3VtLW5sNiBpbiBvbmUgZHJpdmVyCgpUaGlzIHBhdGNoIGlzIGJhc2VkIG9uIHY1LjItcmMxIGFu
ZCB0aGVzZSBwYXRjaGVzOgpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL2NvdmVyLzExMDEy
MzU1LwpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzExMDEyMzQ1LwpodHRwczov
L3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzExMDEyMzQ5LwoKSml0YW8gU2hpICgyKToKICBk
dC1iaW5kaW5nczogZGlzcGxheTogcGFuZWw6IGFkZCBhdW8ga2QxMDFuODAtNDVuYSBwYW5lbCBi
aW5kaW5ncwogIGRybS9wYW5lbDogc3VwcG9ydCBmb3IgYXVvLGtkMTAxbjgwLTQ1bmEgd3V4Z2Eg
ZHNpIHZpZGVvIG1vZGUgcGFuZWwKCiAuLi4vZGlzcGxheS9wYW5lbC9hdW8sa2QxMDFuODAtNDVu
YS50eHQgICAgICAgfCAzNCArKysrKysrKysrKysrKysrCiAuLi4vZ3B1L2RybS9wYW5lbC9wYW5l
bC1ib2UtdHYxMDF3dW0tbmw2LmMgICAgfCA0MCArKysrKysrKysrKysrKysrKysrCiAyIGZpbGVz
IGNoYW5nZWQsIDc0IGluc2VydGlvbnMoKykKIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9wYW5lbC9hdW8sa2QxMDFuODAtNDVuYS50
eHQKCi0tIAoyLjIxLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1k
ZXZlbA==
