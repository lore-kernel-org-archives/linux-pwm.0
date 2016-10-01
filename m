From: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Subject: [PATCH v2 4/6] arm: dts: imx7: Update #pwm-cells for PWM polarity
 control
Date: Sat, 1 Oct 2016 15:42:33 +0530
Message-ID: <20161001101235.24598-5-bhuvanchandra.dv@toradex.com>
References: <20161001101235.24598-1-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161001101235.24598-1-bhuvanchandra.dv@toradex.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: shawnguo@kernel.org, thierry.reding@gmail.com
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org, l.majewski@samsung.com, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, stefan@agner.ch, robh+dt@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Update #pwm-cells to 3 in order to support PWM signal polarity control.

Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 arch/arm/boot/dts/imx7s.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 0d7d5ac..8d1d471 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -601,7 +601,7 @@
 				clocks = <&clks IMX7D_PWM1_ROOT_CLK>,
 					 <&clks IMX7D_PWM1_ROOT_CLK>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -612,7 +612,7 @@
 				clocks = <&clks IMX7D_PWM2_ROOT_CLK>,
 					 <&clks IMX7D_PWM2_ROOT_CLK>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -623,7 +623,7 @@
 				clocks = <&clks IMX7D_PWM3_ROOT_CLK>,
 					 <&clks IMX7D_PWM3_ROOT_CLK>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -634,7 +634,7 @@
 				clocks = <&clks IMX7D_PWM4_ROOT_CLK>,
 					 <&clks IMX7D_PWM4_ROOT_CLK>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
-- 
2.9.2
