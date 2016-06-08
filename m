From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v3 03/20] ARM: dts: STiH407: Declare PWM Capture data lines
 via Pinctrl
Date: Wed,  8 Jun 2016 10:21:18 +0100
Message-ID: <20160608092135.21184-4-lee.jones@linaro.org>
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
 arch/arm/boot/dts/stih407-pinctrl.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
index a538ae5..bc22122 100644
--- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
@@ -289,10 +289,12 @@
 				pinctrl_pwm1_chan0_default: pwm1-0-default {
 					st,pins {
 						pwm-out = <&pio3 0 ALT1 OUT>;
+						pwm-capturein = <&pio3 2 ALT1 IN>;
 					};
 				};
 				pinctrl_pwm1_chan1_default: pwm1-1-default {
 					st,pins {
+						pwm-capturein = <&pio4 3 ALT1 IN>;
 						pwm-out = <&pio4 4 ALT1 OUT>;
 					};
 				};
@@ -1030,6 +1032,7 @@
 			pwm0 {
 				pinctrl_pwm0_chan0_default: pwm0-0-default {
 					st,pins {
+						pwm-capturein = <&pio31 0 ALT1 IN>;
 						pwm-out = <&pio31 1 ALT1 OUT>;
 					};
 				};
-- 
2.8.3
