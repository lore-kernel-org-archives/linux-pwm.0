From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH 1/5] dt-bindings: pwm-stm32: add #pwm-cells
Date: Wed, 19 Jun 2019 11:52:01 +0200
Message-ID: <1560937925-8990-2-git-send-email-fabrice.gasnier@st.com>
References: <1560937925-8990-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1560937925-8990-1-git-send-email-fabrice.gasnier@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, alexandre.torgue@st.com
Cc: mark.rutland@arm.com, linux@armlinux.org.uk, mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, benjamin.gaignard@st.com, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-pwm@vger.kernel.org

STM32 Timers support generic 3 cells PWM bindings to encode PWM number,
period and polarity as defined in pwm.txt.

Fixes: cd9a99c2f8e8 ("dt-bindings: pwm: Add STM32 bindings")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 Documentation/devicetree/bindings/pwm/pwm-stm32.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
index 3e6d550..a8690bf 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
@@ -8,6 +8,8 @@ Required parameters:
 - pinctrl-names: 	Set to "default".
 - pinctrl-0: 		List of phandles pointing to pin configuration nodes for PWM module.
 			For Pinctrl properties see ../pinctrl/pinctrl-bindings.txt
+- #pwm-cells:		Should be set to 3. This PWM chip uses the default 3 cells
+			bindings defined in pwm.txt.
 
 Optional parameters:
 - st,breakinput:	One or two <index level filter> to describe break input configurations.
@@ -28,6 +30,7 @@ Example:
 
 		pwm {
 			compatible = "st,stm32-pwm";
+			#pwm-cells = <3>;
 			pinctrl-0	= <&pwm1_pins>;
 			pinctrl-names	= "default";
 			st,breakinput = <0 1 5>;
-- 
2.7.4
