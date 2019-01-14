From: Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 4/5] arm: dts: mt7623: add a property "mediatek,num-pwms" for PWM
Date: Mon, 14 Jan 2019 16:21:23 +0800
Message-ID: <83a31ee1a74a9c23269da94c00f8fc20fa6bb5d0.1547453586.git.ryder.lee@mediatek.com>
References: <0c400cb1899c1afb4c9f021350cdc0c6ca3f6239.1547453586.git.ryder.lee@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0c400cb1899c1afb4c9f021350cdc0c6ca3f6239.1547453586.git.ryder.lee@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Sean Wang <sean.wang@kernel.org>, Weijie Gao <weijie.gao@mediatek.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Ryder Lee <ryder.lee@mediatek.com>
List-Id: linux-pwm@vger.kernel.org

This adds a property "mediatek,num-pwms" for PWM controller.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 arch/arm/boot/dts/mt7623.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index 98f1159..2dd2f93 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -443,6 +443,7 @@
 			 <&pericfg CLK_PERI_PWM5>;
 		clock-names = "top", "main", "pwm1", "pwm2",
 			      "pwm3", "pwm4", "pwm5";
+		mediatek,num-pwms = <5>;
 		status = "disabled";
 	};
 
-- 
1.9.1
