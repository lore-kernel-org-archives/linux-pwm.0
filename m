From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH 3/6] arm64: dts: r8a7795: Add PWM device nodes
Date: Wed,  9 Mar 2016 17:55:59 +0100
Message-ID: <1457542562-7880-4-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1457542562-7880-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1457542562-7880-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, geert@linux-m68k.org
Cc: linux-pwm@vger.kernel.org, magnus.damm@gmail.com, thierry.reding@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Ryo Kodama <ryo.kodama.vz@renesas.com>, Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
List-Id: linux-pwm@vger.kernel.org

Signed-off-by: Ryo Kodama <ryo.kodama.vz@renesas.com>
Signed-off-by: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
[uli: adapted to new MSTP clock scheme]
Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 54 ++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 5367a7b..531e3b6 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -618,6 +618,60 @@
 			status = "disabled";
 		};
 
+		pwm1: pwm@e6e31000 {
+			compatible = "renesas,pwm-r8a7795", "renesas,pwm-rcar";
+			reg = <0 0xe6e31000 0 0x10>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		pwm2: pwm@e6e32000 {
+			compatible = "renesas,pwm-r8a7795", "renesas,pwm-rcar";
+			reg = <0 0xe6e32000 0 0x10>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		pwm3: pwm@e6e33000 {
+			compatible = "renesas,pwm-r8a7795", "renesas,pwm-rcar";
+			reg = <0 0xe6e33000 0 0x10>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		pwm4: pwm@e6e34000 {
+			compatible = "renesas,pwm-r8a7795", "renesas,pwm-rcar";
+			reg = <0 0xe6e34000 0 0x10>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		pwm5: pwm@e6e35000 {
+			compatible = "renesas,pwm-r8a7795", "renesas,pwm-rcar";
+			reg = <0 0xe6e35000 0 0x10>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		pwm6: pwm@e6e36000 {
+			compatible = "renesas,pwm-r8a7795", "renesas,pwm-rcar";
+			reg = <0 0xe6e36000 0 0x10>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
 		scif0: serial@e6e60000 {
 			compatible = "renesas,scif-r8a7795",
 				     "renesas,rcar-gen3-scif", "renesas,scif";
-- 
2.6.4
