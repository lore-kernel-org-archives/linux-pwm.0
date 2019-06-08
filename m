From: Jitao Shi <jitao.shi@mediatek.com>
Subject: [1/2] dt-bindngs: display: panel: Add BOE tv101wum-nl6 panel bindings
Date: Sat, 8 Jun 2019 15:02:29 +0800
Message-ID: <20190608070230.55381-1-jitao.shi@mediatek.com>
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

QWRkIGRvY3VtZW50YXRpb24gZm9yIGJvZSB0djEwMXd1bS1uMTYgcGFuZWwuCgpTaWduZWQtb2Zm
LWJ5OiBKaXRhbyBTaGkgPGppdGFvLnNoaUBtZWRpYXRlay5jb20+Ci0tLQogLi4uL2Rpc3BsYXkv
cGFuZWwvYm9lLHR2MTAxd3VtLW5sNi50eHQgICAgICAgIHwgMzQgKysrKysrKysrKysrKysrKysr
KwogMSBmaWxlIGNoYW5nZWQsIDM0IGluc2VydGlvbnMoKykKIGNyZWF0ZSBtb2RlIDEwMDY0NCBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9wYW5lbC9ib2UsdHYxMDF3
dW0tbmw2LnR4dAoKZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9kaXNwbGF5L3BhbmVsL2JvZSx0djEwMXd1bS1ubDYudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvcGFuZWwvYm9lLHR2MTAxd3VtLW5sNi50eHQKbmV3IGZp
bGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMDAwLi4yYTg0NzM1ZDc0MmQKLS0tIC9kZXYv
bnVsbAorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9wYW5l
bC9ib2UsdHYxMDF3dW0tbmw2LnR4dApAQCAtMCwwICsxLDM0IEBACitCb2UgQ29ycG9yYXRpb24g
MTAuMSIgV1VYR0EgVEZUIExDRCBwYW5lbAorCitSZXF1aXJlZCBwcm9wZXJ0aWVzOgorLSBjb21w
YXRpYmxlOiBzaG91bGQgYmUgImJvZSx0djEwMXd1bSIKKy0gcmVnOiB0aGUgdmlydHVhbCBjaGFu
bmVsIG51bWJlciBvZiBhIERTSSBwZXJpcGhlcmFsCistIGVuYWJsZS1ncGlvczogYSBHUElPIHNw
ZWMgZm9yIHRoZSBlbmFibGUgcGluCistIHBwMTgwMC1zdXBwbHk6IGNvcmUgdm9sdGFnZSBzdXBw
bHkKKy0gYXZkZC1zdXBwbHk6IAorLSBhdmVlLXN1cHBseTogCistIGJhY2tsaWdodDogcGhhbmRs
ZSBvZiB0aGUgYmFja2xpZ2h0IGRldmljZSBhdHRhY2hlZCB0byB0aGUgcGFuZWwKKworVGhlIGRl
dmljZSBub2RlIGNhbiBjb250YWluIG9uZSAncG9ydCcgY2hpbGQgbm9kZSB3aXRoIG9uZSBjaGls
ZAorJ2VuZHBvaW50JyBub2RlLCBhY2NvcmRpbmcgdG8gdGhlIGJpbmRpbmdzIGRlZmluZWQgaW4K
K21lZGlhL3ZpZGVvLWludGVyZmFjZXMudHh0LiBUaGlzIG5vZGUgc2hvdWxkIGRlc2NyaWJlIHBh
bmVsJ3MgdmlkZW8gYnVzLgorCitFeGFtcGxlOgorJmRzaSB7CisJLi4uCisJcGFuZWxAMCB7CisJ
CWNvbXBhdGlibGUgPSAiYm9lLHR2MTAxd3VtLW5sNiI7CisJCXJlZyA9IDwwPjsKKwkJZW5hYmxl
LWdwaW9zID0gPCZwaW8gNDUgMD47CisJCWF2ZGQtc3VwcGx5ID0gPCZwcHZhcm5fbGNkPjsKKwkJ
YXZlZS1zdXBwbHkgPSA8JnBwdmFycF9sY2Q+OworCQlwcDE4MDAtc3VwcGx5ID0gPCZwcDE4MDBf
bGNkPjsKKwkJYmFja2xpZ2h0ID0gPCZiYWNrbGlnaHRfbGNkMD47CisJCXN0YXR1cyA9ICJva2F5
IjsKKwkJcG9ydCB7CisJCQlwYW5lbF9pbjogZW5kcG9pbnQgeworCQkJCXJlbW90ZS1lbmRwb2lu
dCA9IDwmZHNpX291dD47CisJCQl9OworCQl9OworCX07Cit9OwpcIE5vIG5ld2xpbmUgYXQgZW5k
IG9mIGZpbGUKLS0gCjIuMjEuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
ZHJpLWRldmVs
