From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 4/4] dt-bindings: pwm: mxs-pwm: Increase #pwm-cells
Date: Mon, 23 Sep 2019 10:13:48 +0200
Message-ID: <20190923081348.6843-5-linux@rasmusvillemoes.dk>
References: <20190923081348.6843-1-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190923081348.6843-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: devicetree@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

We need to increase the pwm-cells for the optional flags parameter, in
order to implement support for polarity setting via DT.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 Documentation/devicetree/bindings/pwm/mxs-pwm.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/mxs-pwm.txt b/Documentation/devicetree/bindings/pwm/mxs-pwm.txt
index 96cdde5f6208..1697dcd3b07c 100644
--- a/Documentation/devicetree/bindings/pwm/mxs-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/mxs-pwm.txt
@@ -3,7 +3,7 @@ Freescale MXS PWM controller
 Required properties:
 - compatible: should be "fsl,imx23-pwm"
 - reg: physical base address and length of the controller's registers
-- #pwm-cells: should be 2. See pwm.txt in this directory for a description of
+- #pwm-cells: should be 3. See pwm.txt in this directory for a description of
   the cells format.
 - fsl,pwm-number: the number of PWM devices
 
@@ -12,6 +12,6 @@ Example:
 pwm: pwm@80064000 {
 	compatible = "fsl,imx28-pwm", "fsl,imx23-pwm";
 	reg = <0x80064000 0x2000>;
-	#pwm-cells = <2>;
+	#pwm-cells = <3>;
 	fsl,pwm-number = <8>;
 };
-- 
2.20.1
