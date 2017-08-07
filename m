From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 2/4] ARM: dts: keystone-k2g: Add ECAP PWM DT nodes
Date: Mon, 7 Aug 2017 17:19:41 +0530
Message-ID: <20170807114943.22612-3-vigneshr@ti.com>
References: <20170807114943.22612-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170807114943.22612-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: Vignesh R <vigneshr@ti.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Add DT nodes for PWM ECAP IP present on 66AK2G SoC.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm/boot/dts/keystone-k2g.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
index bf4d1fa30840..b35d29672f30 100644
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@ -168,5 +168,25 @@
 				#reset-cells = <2>;
 			};
 		};
+
+		ecap0: pwm@21d1800 {
+			compatible = "ti,k2g-ecap", "ti,am3352-ecap";
+			#pwm-cells = <3>;
+			reg = <0x021d1800 0x60>;
+			power-domains = <&k2g_pds 0x38>;
+			clocks = <&k2g_clks 0x38 0>;
+			clock-names = "fck";
+			status = "disabled";
+		};
+
+		ecap1: pwm@21d1c00 {
+			compatible = "ti,k2g-ecap", "ti,am3352-ecap";
+			#pwm-cells = <3>;
+			reg = <0x021d1c00 0x60>;
+			power-domains = <&k2g_pds 0x39>;
+			clocks = <&k2g_clks 0x39 0x0>;
+			clock-names = "fck";
+			status = "disabled";
+		};
 	};
 };
-- 
2.13.3
