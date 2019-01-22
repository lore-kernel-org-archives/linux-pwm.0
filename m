From: Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH V2] pwm: Add MediaTek MT8183 display PWM driver support
Date: Tue, 22 Jan 2019 17:02:43 +0800
Message-ID: <20190122090243.27304-1-jitao.shi@mediatek.com>
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

VXNlIHRoZSBtdGtfcHdtX2RhdGEgc3RydWN0aW9uIHRvIGRlZmluZSBkaWZmZXJlbnQgcmVnaXN0
ZXJzCmFuZCBhZGQgTVQ4MTgzIHNwZWNpZmljIHJlZ2lzdGVyIG9wZXJhdGlvbnMsIHN1Y2ggYXMg
TVQ4MTgzCmRvZXNuJ3QgaGF2ZSBjb21taXQgcmVnaXN0ZXIsIG5lZWRzIHRvIGRpc2FibGUgZG91
YmxlIGJ1ZmZlcgpiZWZvcmUgd3JpdGluZyByZWdpc3RlciwgYW5kIG5lZWRzIHRvIHNlbGVjdCBj
b21taXQgbW9kZQphbmQgdXNlIFBXTV9QRVJJT0QvUFdNX0hJR0hfV0lEVEguCgpTaWduZWQtb2Zm
LWJ5OiBKaXRhbyBTaGkgPGppdGFvLnNoaUBtZWRpYXRlay5jb20+Ci0tLQogZHJpdmVycy9wd20v
cHdtLW10ay1kaXNwLmMgfCAxMSArKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDExIGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3B3bS9wd20tbXRrLWRpc3AuYyBiL2RyaXZl
cnMvcHdtL3B3bS1tdGstZGlzcC5jCmluZGV4IDg5Mzk0MGQ0NWYwZC4uMTU4MDNjNzFmZTgwIDEw
MDY0NAotLS0gYS9kcml2ZXJzL3B3bS9wd20tbXRrLWRpc3AuYworKysgYi9kcml2ZXJzL3B3bS9w
d20tbXRrLWRpc3AuYwpAQCAtMjc3LDEwICsyNzcsMjEgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBt
dGtfcHdtX2RhdGEgbXQ4MTczX3B3bV9kYXRhID0gewogCS5jb21taXRfbWFzayA9IDB4MSwKIH07
CiAKK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX3B3bV9kYXRhIG10ODE4M19wd21fZGF0YSA9IHsK
KwkuZW5hYmxlX21hc2sgPSBCSVQoMCksCisJLmNvbjAgPSAweDE4LAorCS5jb24wX3NlbCA9IDB4
MCwKKwkuY29uMSA9IDB4MWMsCisJLmhhc19jb21taXQgPSBmYWxzZSwKKwkuYmxzX2RlYnVnID0g
MHg4MCwKKwkuYmxzX2RlYnVnX21hc2sgPSAweDMsCit9OworCiBzdGF0aWMgY29uc3Qgc3RydWN0
IG9mX2RldmljZV9pZCBtdGtfZGlzcF9wd21fb2ZfbWF0Y2hbXSA9IHsKIAl7IC5jb21wYXRpYmxl
ID0gIm1lZGlhdGVrLG10MjcwMS1kaXNwLXB3bSIsIC5kYXRhID0gJm10MjcwMV9wd21fZGF0YX0s
CiAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDY1OTUtZGlzcC1wd20iLCAuZGF0YSA9ICZt
dDgxNzNfcHdtX2RhdGF9LAogCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTczLWRpc3At
cHdtIiwgLmRhdGEgPSAmbXQ4MTczX3B3bV9kYXRhfSwKKwl7IC5jb21wYXRpYmxlID0gIm1lZGlh
dGVrLG10ODE4My1kaXNwLXB3bSIsIC5kYXRhID0gJm10ODE4M19wd21fZGF0YX0sCiAJeyB9CiB9
OwogTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgbXRrX2Rpc3BfcHdtX29mX21hdGNoKTsKLS0gCjIu
MTIuNQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJp
LWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
