From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH 3/4] dt-bindings: iio: stm32-lptimer-counter: document pinctrl sleep state
Date: Tue, 5 Feb 2019 13:40:28 +0100
Message-ID: <1549370429-19116-4-git-send-email-fabrice.gasnier@st.com>
References: <1549370429-19116-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549370429-19116-1-git-send-email-fabrice.gasnier@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jic23@kernel.org, thierry.reding@gmail.com, robh+dt@kernel.org
Cc: mark.rutland@arm.com, alexandre.torgue@st.com, mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, vilhelm.gray@gmail.com, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-pwm@vger.kernel.org

Add documentation for optional pinctrl sleep state that can be used by
STM32 LPTimer encoder/counter.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 .../devicetree/bindings/iio/counter/stm32-lptimer-cnt.txt         | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/counter/stm32-lptimer-cnt.txt b/Documentation/devicetree/bindings/iio/counter/stm32-lptimer-cnt.txt
index a04aa5c..e90bc47 100644
--- a/Documentation/devicetree/bindings/iio/counter/stm32-lptimer-cnt.txt
+++ b/Documentation/devicetree/bindings/iio/counter/stm32-lptimer-cnt.txt
@@ -10,8 +10,9 @@ See ../mfd/stm32-lptimer.txt for details about the parent node.
 
 Required properties:
 - compatible:		Must be "st,stm32-lptimer-counter".
-- pinctrl-names: 	Set to "default".
-- pinctrl-0: 		List of phandles pointing to pin configuration nodes,
+- pinctrl-names: 	Set to "default". An additional "sleep" state can be
+			defined to set pins in sleep state.
+- pinctrl-n: 		List of phandles pointing to pin configuration nodes,
 			to set IN1/IN2 pins in mode of operation for Low-Power
 			Timer input on external pin.
 
@@ -21,7 +22,8 @@ Example:
 		...
 		counter {
 			compatible = "st,stm32-lptimer-counter";
-			pinctrl-names = "default";
+			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&lptim1_in_pins>;
+			pinctrl-1 = <&lptim1_sleep_in_pins>;
 		};
 	};
-- 
1.9.1
