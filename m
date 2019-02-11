From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH v2 1/3] dt-bindings: pwm-stm32-lp: document pinctrl sleep state
Date: Mon, 11 Feb 2019 17:12:00 +0100
Message-ID: <1549901522-15071-2-git-send-email-fabrice.gasnier@st.com>
References: <1549901522-15071-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1549901522-15071-1-git-send-email-fabrice.gasnier@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: thierry.reding@gmail.com, robh+dt@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.torgue@st.com, tduszyns@gmail.com, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, mcoquelin.stm32@gmail.com, u.kleine-koenig@pengutronix.de, fabrice.gasnier@st.com, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Add documentation for pinctrl sleep state on STM32 LPTimer PWM.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt b/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt
index bd23302..6521bc4 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt
@@ -11,8 +11,10 @@ Required parameters:
 			bindings defined in pwm.txt.
 
 Optional properties:
-- pinctrl-names: 	Set to "default".
-- pinctrl-0: 		Phandle pointing to pin configuration node for PWM.
+- pinctrl-names: 	Set to "default". An additional "sleep" state can be
+			defined to set pins in sleep state when in low power.
+- pinctrl-n: 		Phandle(s) pointing to pin configuration node for PWM,
+			respectively for "default" and "sleep" states.
 
 Example:
 	timer@40002400 {
@@ -21,7 +23,8 @@ Example:
 		pwm {
 			compatible = "st,stm32-pwm-lp";
 			#pwm-cells = <3>;
-			pinctrl-names = "default";
+			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&lppwm1_pins>;
+			pinctrl-1 = <&lppwm1_sleep_pins>;
 		};
 	};
-- 
1.9.1
