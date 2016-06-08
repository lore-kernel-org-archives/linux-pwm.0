From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v3 05/20] ARM: dts: STiH416: Declare PWM Capture data lines
 via Pinctrl
Date: Wed,  8 Jun 2016 10:21:20 +0100
Message-ID: <20160608092135.21184-6-lee.jones@linaro.org>
References: <20160608092135.21184-1-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160608092135.21184-1-lee.jones@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: linux-pwm@vger.kernel.org, kernel@stlinux.com, devicetree@vger.kernel.org, patrice.chotard@st.com, robh+dt@kernel.org, thierry.reding@gmail.com, Lee Jones <lee.jones@linaro.org>, maxime.coquelin@st.com
List-Id: linux-pwm@vger.kernel.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih416-pinctrl.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/stih416-pinctrl.dtsi b/arch/arm/boot/dts/stih416-pinctrl.dtsi
index 051fc16..252b677 100644
--- a/arch/arm/boot/dts/stih416-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih416-pinctrl.dtsi
@@ -221,11 +221,14 @@
 				pinctrl_pwm1_chan0_default: pwm1-0-default {
 					st,pins {
 						pwm-out    = <&pio3 0 ALT1 OUT>;
+						pwm-capturein = <&pio3 2 ALT1 IN>;
+
 					};
 				};
 				pinctrl_pwm1_chan1_default: pwm1-1-default {
 					st,pins {
 						pwm-out    = <&pio4 4 ALT1 OUT>;
+						pwm-capturein = <&pio4 3 ALT1 IN>;
 					};
 				};
 				pinctrl_pwm1_chan2_default: pwm1-2-default {
@@ -337,6 +340,7 @@
 				pinctrl_pwm0_chan0_default: pwm0-0-default {
 					st,pins {
 						pwm-out    = <&pio9 7 ALT2 OUT>;
+						pwm-capturein = <&pio9 6 ALT2 IN>;
 					};
 				};
 			};
@@ -576,6 +580,7 @@
 				pinctrl_pwm0_chan1_default: pwm0-1-default {
 					st,pins {
 						pwm-out    = <&pio13 2 ALT2 OUT>;
+						pwm-capturein = <&pio13 1 ALT2 IN>;
 					};
 				};
 				pinctrl_pwm0_chan2_default: pwm0-2-default {
-- 
2.8.3
