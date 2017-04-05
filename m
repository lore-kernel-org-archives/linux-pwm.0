From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/4] pwm: tegra: Add DT binding details to configure pin in suspends/resume
Date: Wed, 5 Apr 2017 19:43:45 +0530
Message-ID: <1491401626-31303-4-git-send-email-ldewangan@nvidia.com>
References: <1491401626-31303-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1491401626-31303-1-git-send-email-ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
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
 .../devicetree/bindings/pwm/nvidia,tegra20-pwm.txt | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
index b4e7377..145c323 100644
--- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
@@ -19,6 +19,19 @@ Required properties:
 - reset-names: Must include the following entries:
   - pwm
 
+Optional properties:
+============================
+In some of the interface like PWM based regualator device, it is required
+to configure the pins diffrently in different states, specially in suspend
+state of the system. The configuration of pin is provided via the pinctrl
+DT node as detailed in the pinctrl DT binding document
+	Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
+
+The PWM node will have following optional properties.
+pinctrl-names:	Pin state names. Must be "suspend" and "resume".
+pinctrl-0:	Node handle of the suspend state configuration of pins.
+pinctrl-1:	Node handle of the resume state configuration of pins.
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
+Here Pin PE7 is used as PWM.
+
+#include <dt-bindings/pinctrl/pinctrl-tegra.h>
+
+	pinmux@70000868 {
+		pwm_suspend: pwm_suspend_state {
+                        pe7 {
+                                nvidia,pins = "pe7";
+                                nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+		};
+
+		pwm_resume: pwm_resume_state {
+                        pe7 {
+                                nvidia,pins = "pe7";
+                                nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+		};
+	};
+
+	pwm@7000a000 {
+		/* Mandatory pwm properties */
+		pinctrl-names = "suspend", "resume";
+		pinctrl-0 = <&pwm_suspend>;
+		pinctrl-1 = <&pwm_resume>;
+	};
-- 
2.1.4
