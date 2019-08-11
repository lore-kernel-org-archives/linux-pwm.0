From: Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH wn 3/4] dt-bindings: display: panel: add auo kd101n80-45na
 panel bindings
Date: Sun, 11 Aug 2019 17:10:00 +0800
Message-ID: <20190811091001.49555-4-jitao.shi@mediatek.com>
References: <20190811091001.49555-1-jitao.shi@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190811091001.49555-1-jitao.shi@mediatek.com>
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
Cc: stonea168@163.com, dri-devel@lists.freedesktop.org, Andy Yan <andy.yan@rock-chips.com>, Sam Ravnborg <sam@ravnborg.org>, Ajay Kumar <ajaykumar.rs@samsung.com>, Vincent Palatin <vpalatin@chromium.org>, cawa.cheng@mediatek.com, Russell King <rmk+kernel@arm.linux.org.uk>, Thierry Reding <treding@nvidia.com>, devicetree@vger.kernel.org, Jitao Shi <jitao.shi@mediatek.com>, linux-mediatek@lists.infradead.org, yingjoe.chen@mediatek.com, eddie.huang@mediatek.com, linux-arm-kernel@lists.infradead.org, Rahul Sharma <rahul.sharma@samsung.com>, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Sean Paul <seanpaul@chromium.org>
List-Id: linux-pwm@vger.kernel.org

QWRkIGRvY3VtZW50YXRpb24gZm9yIGF1byBrZDEwMW44MC00NW5hIHBhbmVsLgoKU2lnbmVkLW9m
Zi1ieTogSml0YW8gU2hpIDxqaXRhby5zaGlAbWVkaWF0ZWsuY29tPgpSZXZpZXdlZC1ieTogU2Ft
IFJhdm5ib3JnIDxzYW1AcmF2bmJvcmcub3JnPgotLS0KIC4uLi9kaXNwbGF5L3BhbmVsL2F1byxr
ZDEwMW44MC00NW5hLnR4dCAgICAgICB8IDM0ICsrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBj
aGFuZ2VkLCAzNCBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvcGFuZWwvYXVvLGtkMTAxbjgwLTQ1bmEudHh0
CgpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkv
cGFuZWwvYXVvLGtkMTAxbjgwLTQ1bmEudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2Rpc3BsYXkvcGFuZWwvYXVvLGtkMTAxbjgwLTQ1bmEudHh0Cm5ldyBmaWxlIG1vZGUg
MTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwMC4uOTk0YzJhMTNmOTQyCi0tLSAvZGV2L251bGwKKysr
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvcGFuZWwvYXVvLGtk
MTAxbjgwLTQ1bmEudHh0CkBAIC0wLDAgKzEsMzQgQEAKK0FVTyBDb3Jwb3JhdGlvbiAxMC4xIiBX
VVhHQSBURlQgTENEIHBhbmVsCisKK1JlcXVpcmVkIHByb3BlcnRpZXM6CistIGNvbXBhdGlibGU6
IHNob3VsZCBiZSAiYXVvLGtkMTAxbjgwLTQ1bmEiCistIHJlZzogdGhlIHZpcnR1YWwgY2hhbm5l
bCBudW1iZXIgb2YgYSBEU0kgcGVyaXBoZXJhbAorLSBlbmFibGUtZ3Bpb3M6IGEgR1BJTyBzcGVj
IGZvciB0aGUgZW5hYmxlIHBpbgorLSBwcDE4MDAtc3VwcGx5OiBjb3JlIHZvbHRhZ2Ugc3VwcGx5
CistIGF2ZGQtc3VwcGx5OiBwaGFuZGxlIG9mIHRoZSByZWd1bGF0b3IgdGhhdCBwcm92aWRlcyBw
b3NpdGl2ZSB2b2x0YWdlCistIGF2ZWUtc3VwcGx5OiBwaGFuZGxlIG9mIHRoZSByZWd1bGF0b3Ig
dGhhdCBwcm92aWRlcyBuZWdhdGl2ZSB2b2x0YWdlCistIGJhY2tsaWdodDogcGhhbmRsZSBvZiB0
aGUgYmFja2xpZ2h0IGRldmljZSBhdHRhY2hlZCB0byB0aGUgcGFuZWwKKworVGhlIGRldmljZSBu
b2RlIGNhbiBjb250YWluIG9uZSAncG9ydCcgY2hpbGQgbm9kZSB3aXRoIG9uZSBjaGlsZAorJ2Vu
ZHBvaW50JyBub2RlLCBhY2NvcmRpbmcgdG8gdGhlIGJpbmRpbmdzIGRlZmluZWQgaW4KK21lZGlh
L3ZpZGVvLWludGVyZmFjZXMudHh0LiBUaGlzIG5vZGUgc2hvdWxkIGRlc2NyaWJlIHBhbmVsJ3Mg
dmlkZW8gYnVzLgorCitFeGFtcGxlOgorJmRzaSB7CisJLi4uCisJcGFuZWxAMCB7CisJCWNvbXBh
dGlibGUgPSAiYXVvLGtkMTAxbjgwLTQ1bmEiOworCQlyZWcgPSA8MD47CisJCWVuYWJsZS1ncGlv
cyA9IDwmcGlvIDQ1IDA+OworCQlhdmRkLXN1cHBseSA9IDwmcHB2YXJuX2xjZD47CisJCWF2ZWUt
c3VwcGx5ID0gPCZwcHZhcnBfbGNkPjsKKwkJcHAxODAwLXN1cHBseSA9IDwmcHAxODAwX2xjZD47
CisJCWJhY2tsaWdodCA9IDwmYmFja2xpZ2h0X2xjZDA+OworCQlzdGF0dXMgPSAib2theSI7CisJ
CXBvcnQgeworCQkJcGFuZWxfaW46IGVuZHBvaW50IHsKKwkJCQlyZW1vdGUtZW5kcG9pbnQgPSA8
JmRzaV9vdXQ+OworCQkJfTsKKwkJfTsKKwl9OworfTsKLS0gCjIuMjEuMAoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlz
dApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
