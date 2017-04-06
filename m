From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V3 3/4] pwm: tegra: Add DT binding details to configure pin in suspends/resume
Date: Thu, 6 Apr 2017 19:51:00 +0530
Message-ID: <1491488461-24621-4-git-send-email-ldewangan@nvidia.com>
References: <1491488461-24621-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1491488461-24621-1-git-send-email-ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

In some of NVIDIA Tegra's platform, PWM controller is used to
control the PWM controlled regulators. PWM signal is connected to
the VID pin of the regulator where duty cycle of PWM signal decide
the voltage level of the regulator output.

The tristate (high impedance of PWM pin form Tegra) also define
one of the state of PWM regulator which needs to be configure in
suspend state of system.

Add DT binding details to provide the pin configuration state
from PWM and pinctrl DT node in suspend and active state of
the system.

Signed-off-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
Changes from v1:
- Use standard pinctrl names for sleep and active state.

 .../devicetree/bindings/pwm/nvidia,tegra20-pwm.txt | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
index b4e7377..4128cdc 100644
--- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
@@ -19,6 +19,19 @@ Required properties:
 - reset-names: Must include the following entries:
   - pwm
 
+Optional properties:
+============================
+In some of the interface like PWM based regulator device, it is required
+to configure the pins differently in different states, especially in suspend
+state of the system. The configuration of pin is provided via the pinctrl
+DT node as detailed in the pinctrl DT binding document
+	Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
+
+The PWM node will have following optional properties.
+pinctrl-names:	Pin state names. Must be "default" and "sleep".
+pinctrl-0:	Node handle for the default/active state of pi configurations.
+pinctrl-1:	Node handle for the sleep state of pin configurations.
+
 Example:
 
 	pwm: pwm@7000a000 {
@@ -29,3 +42,33 @@ Example:
 		resets = <&tegra_car 17>;
 		reset-names = "pwm";
 	};
+
+
+Example with the pin configuration for suspend and resume:
+=========================================================
+Pin PE7 is used as PWM interface.
+
+#include <dt-bindings/pinctrl/pinctrl-tegra.h>
+
+	pinmux@70000868 {
+		pwm_active_state: pwm_active_state {
+                        pe7 {
+                                nvidia,pins = "pe7";
+                                nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+		};
+
+		pwm_sleep_state: pwm_sleep_state {
+                        pe7 {
+                                nvidia,pins = "pe7";
+                                nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+		};
+	};
+
+	pwm@7000a000 {
+		/* Mandatory PWM properties */
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&pwm_active_state>;
+		pinctrl-1 = <&pwm_sleep_state>;
+	};
-- 
2.1.4
