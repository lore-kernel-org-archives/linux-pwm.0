From: Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH 2/2] arm64: dts: mt8183: add pwm0 node
Date: Sun, 5 May 2019 19:05:17 +0800
Message-ID: <20190505110517.965-3-jitao.shi@mediatek.com>
References: <20190505110517.965-1-jitao.shi@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190505110517.965-1-jitao.shi@mediatek.com>
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

QWRkIHB3bTAgbm9kZSB0byB0aGUgbXQ4MTgzCgpTaWduZWQtb2ZmLWJ5OiBKaXRhbyBTaGkgPGpp
dGFvLnNoaUBtZWRpYXRlay5jb20+Ci0tLQogYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9t
dDgxODMuZHRzaSB8IDExICsrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9u
cygrKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0
c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4My5kdHNpCmluZGV4IDg0ZjQ2
NWZhNGZhYy4uYjBkZGE1N2E3ZTIzIDEwMDY0NAotLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21l
ZGlhdGVrL210ODE4My5kdHNpCisrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4
MTgzLmR0c2kKQEAgLTMyMyw2ICszMjMsMTcgQEAKIAkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7CiAJ
CX07CiAKKwkJcHdtMDogcHdtQDExMDBlMDAwIHsKKwkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWss
bXQ4MTgzLWRpc3AtcHdtIjsKKwkJCXJlZyA9IDwwIDB4MTEwMGUwMDAgMCAweDEwMDA+OworCQkJ
aW50ZXJydXB0cyA9IDxHSUNfU1BJIDEyOCBJUlFfVFlQRV9MRVZFTF9MT1c+OworCQkJcG93ZXIt
ZG9tYWlucyA9IDwmc2Nwc3lzIE1UODE4M19QT1dFUl9ET01BSU5fRElTUD47CisJCQkjcHdtLWNl
bGxzID0gPDI+OworCQkJY2xvY2tzID0gPCZ0b3Bja2dlbiBDTEtfVE9QX01VWF9ESVNQX1BXTT4s
CisJCQkJCTwmaW5mcmFjZmcgQ0xLX0lORlJBX0RJU1BfUFdNPjsKKwkJCWNsb2NrLW5hbWVzID0g
Im1haW4iLCAibW0iOworCQl9OworCiAJCWF1ZGlvc3lzOiBzeXNjb25AMTEyMjAwMDAgewogCQkJ
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtYXVkaW9zeXMiLCAic3lzY29uIjsKIAkJCXJl
ZyA9IDwwIDB4MTEyMjAwMDAgMCAweDEwMDA+OwotLSAKMi4yMS4wCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRy
aS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWw=
