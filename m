From: Beniamino Galvani <b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/3] ARM: dts: rk3xxx: add PWM nodes
Date: Thu,  8 May 2014 01:08:35 +0200
Message-ID: <1399504115-16257-4-git-send-email-b.galvani@gmail.com>
References: <1399504115-16257-1-git-send-email-b.galvani@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1399504115-16257-1-git-send-email-b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Beniamino Galvani <b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

This adds PWM nodes to the Rockchip device trees.

Signed-off-by: Beniamino Galvani <b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/boot/dts/rk3188.dtsi |   40 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/rk3xxx.dtsi |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index f1d8651..7dd8f6c 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -125,6 +125,22 @@
 			clock-names = "biu", "ciu";
 		};
 
+		pwm0: pwm@20030000 {
+			clocks = <&cru PCLK_PWM01>;
+		};
+
+		pwm1: pwm@20030010 {
+			clocks = <&cru PCLK_PWM01>;
+		};
+
+		pwm2: pwm@20050020 {
+			clocks = <&cru PCLK_PWM23>;
+		};
+
+		pwm3: pwm@20050030 {
+			clocks = <&cru PCLK_PWM23>;
+		};
+
 		cru: cru@20000000 {
 			compatible = "rockchip,rk3188-cru";
 			reg = <0x20000000 0x1000>,
@@ -331,6 +347,30 @@
 							<RK_GPIO3 20 RK_FUNC_1 &pcfg_pull_none>;
 				};
 			};
+
+			pwm0 {
+				pwm0_pins: pwm0-pins {
+					rockchip,pins = <RK_GPIO3 27 RK_FUNC_1 &pcfg_pull_none>;
+				};
+			};
+
+			pwm1 {
+				pwm1_pins: pwm1-pins {
+					rockchip,pins = <RK_GPIO3 28 RK_FUNC_1 &pcfg_pull_none>;
+				};
+			};
+
+			pwm2 {
+				pwm2_pins: pwm2-pins {
+					rockchip,pins = <RK_GPIO3 29 RK_FUNC_1 &pcfg_pull_none>;
+				};
+			};
+
+			pwm3 {
+				pwm3_pins: pwm3-pins {
+					rockchip,pins = <RK_GPIO3 30 RK_FUNC_1 &pcfg_pull_none>;
+				};
+			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 26e5a96..c46d552 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -130,5 +130,37 @@
 
 			status = "disabled";
 		};
+
+		pwm0: pwm@20030000 {
+			compatible = "rockchip,rk2928-pwm";
+			reg = <0x20030000 0x10>;
+			#pwm-cells = <2>;
+			clocks = <&clk_gates7 10>;
+			status = "disabled";
+		};
+
+		pwm1: pwm@20030010 {
+			compatible = "rockchip,rk2928-pwm";
+			reg = <0x20030010 0x10>;
+			#pwm-cells = <2>;
+			clocks = <&clk_gates7 10>;
+			status = "disabled";
+		};
+
+		pwm2: pwm@20050020 {
+			compatible = "rockchip,rk2928-pwm";
+			reg = <0x20050020 0x10>;
+			#pwm-cells = <2>;
+			clocks = <&clk_gates7 11>;
+			status = "disabled";
+		};
+
+		pwm3: pwm@20050030 {
+			compatible = "rockchip,rk2928-pwm";
+			reg = <0x20050030 0x10>;
+			#pwm-cells = <2>;
+			clocks = <&clk_gates7 11>;
+			status = "disabled";
+		};
 	};
 };
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
