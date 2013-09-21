Return-Path: <mikedunn@newsguy.com>
From: Mike Dunn <mikedunn@newsguy.com>
Subject: [PATCH RESEND v5 2/2] PXA: add PWM nodes to pxa27x.dtsi
Date: Sat, 21 Sep 2013 12:19:34 -0700
Message-Id: <1379791174-2369-3-git-send-email-mikedunn@newsguy.com>
In-Reply-To: <1379791174-2369-1-git-send-email-mikedunn@newsguy.com>
References: <1379791174-2369-1-git-send-email-mikedunn@newsguy.com>
List-ID: <linux-pwm.vger.kernel.org>
To: linux-pwm@vger.kernel.org
Cc: Mike Dunn <mikedunn@newsguy.com>, Grant Likely <grant.likely@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chao Xie <chao.xie@marvell.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>

This patch adds PWM nodes for each of the four channels present on the
pxa270.

Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
---
 arch/arm/boot/dts/pxa27x.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index d7c5d72..a705469 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -10,5 +10,29 @@
 			marvell,intc-priority;
 			marvell,intc-nr-irqs = <34>;
 		};
+
+		pwm0: pwm@40b00000 {
+			compatible = "marvell,pxa270-pwm", "marvell,pxa250-pwm";
+			reg = <0x40b00000 0x10>;
+			#pwm-cells = <1>;
+		};
+
+		pwm1: pwm@40b00010 {
+			compatible = "marvell,pxa270-pwm", "marvell,pxa250-pwm";
+			reg = <0x40b00010 0x10>;
+			#pwm-cells = <1>;
+		};
+
+		pwm2: pwm@40c00000 {
+			compatible = "marvell,pxa270-pwm", "marvell,pxa250-pwm";
+			reg = <0x40c00000 0x10>;
+			#pwm-cells = <1>;
+		};
+
+		pwm3: pwm@40c00010 {
+			compatible = "marvell,pxa270-pwm", "marvell,pxa250-pwm";
+			reg = <0x40c00010 0x10>;
+			#pwm-cells = <1>;
+		};
 	};
 };
-- 
1.8.1.5
