From: Lukasz Majewski <l.majewski@majess.pl>
Subject: [PATCH v2 09/10] pwm: imx: doc: Update imx-pwm.txt documentation entry
Date: Thu, 27 Oct 2016 08:33:19 +0200
Message-ID: <1477549999-5125-1-git-send-email-l.majewski@majess.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Stefan Agner <stefan@agner.ch>, Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, kernel@pengutronix.de, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>
List-Id: linux-pwm@vger.kernel.org

The imx-pwm.txt documentation update as a preparation for polarity
support.

Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
---
Changes for v2:
- New patch
---
 Documentation/devicetree/bindings/pwm/imx-pwm.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.txt b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
index e00c2e9..c61bdf8 100644
--- a/Documentation/devicetree/bindings/pwm/imx-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
@@ -6,8 +6,8 @@ Required properties:
   - "fsl,imx1-pwm" for PWM compatible with the one integrated on i.MX1
   - "fsl,imx27-pwm" for PWM compatible with the one integrated on i.MX27
 - reg: physical base address and length of the controller's registers
-- #pwm-cells: should be 2. See pwm.txt in this directory for a description of
-  the cells format.
+- #pwm-cells: 2 for i.MX1 and 3 for i.MX27 and newer SoCs. See pwm.txt
+  in this directory for a description of the cells format.
 - clocks : Clock specifiers for both ipg and per clocks.
 - clock-names : Clock names should include both "ipg" and "per"
 See the clock consumer binding,
@@ -17,7 +17,7 @@ See the clock consumer binding,
 Example:
 
 pwm1: pwm@53fb4000 {
-	#pwm-cells = <2>;
+	#pwm-cells = <3>;
 	compatible = "fsl,imx53-pwm", "fsl,imx27-pwm";
 	reg = <0x53fb4000 0x4000>;
 	clocks = <&clks IMX5_CLK_PWM1_IPG_GATE>,
-- 
2.1.4
