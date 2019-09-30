From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH 1/2] dt-bindings: pwm-stm32: document pinctrl sleep state
Date: Mon, 30 Sep 2019 17:39:10 +0200
Message-ID: <1569857951-20007-2-git-send-email-fabrice.gasnier@st.com>
References: <1569857951-20007-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1569857951-20007-1-git-send-email-fabrice.gasnier@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org
Cc: alexandre.torgue@st.com, mark.rutland@arm.com, mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, benjamin.gaignard@st.com, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-pwm@vger.kernel.org

Add documentation for pinctrl sleep state that can be used by
STM32 timers PWM.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 Documentation/devicetree/bindings/pwm/pwm-stm32.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
index a8690bf..f1620c1 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
@@ -5,8 +5,9 @@ See ../mfd/stm32-timers.txt for details about the parent node.
 
 Required parameters:
 - compatible:		Must be "st,stm32-pwm".
-- pinctrl-names: 	Set to "default".
-- pinctrl-0: 		List of phandles pointing to pin configuration nodes for PWM module.
+- pinctrl-names: 	Set to "default". An additional "sleep" state can be
+			defined to set pins in sleep state when in low power.
+- pinctrl-n: 		List of phandles pointing to pin configuration nodes for PWM module.
 			For Pinctrl properties see ../pinctrl/pinctrl-bindings.txt
 - #pwm-cells:		Should be set to 3. This PWM chip uses the default 3 cells
 			bindings defined in pwm.txt.
@@ -32,7 +33,8 @@ Example:
 			compatible = "st,stm32-pwm";
 			#pwm-cells = <3>;
 			pinctrl-0	= <&pwm1_pins>;
-			pinctrl-names	= "default";
+			pinctrl-1	= <&pwm1_sleep_pins>;
+			pinctrl-names	= "default", "sleep";
 			st,breakinput = <0 1 5>;
 		};
 	};
-- 
2.7.4
