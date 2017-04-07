From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH V3 3/4] pwm: tegra: Add DT binding details to configure pin in suspends/resume
Date: Fri, 7 Apr 2017 15:04:01 +0530
Message-ID: <1491557642-15940-4-git-send-email-ldewangan@nvidia.com>
References: <1491557642-15940-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16419 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756647AbdDGJxB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 7 Apr 2017 05:53:01 -0400
In-Reply-To: <1491557642-15940-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, jonathanh@nvidia.com
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>

In some of NVIDIA Tegra's platform, PWM controller is used to
control the PWM controlled regulators. PWM signal is connected to
the VID pin of the regulator where duty cycle of PWM signal decide
the voltage level of the regulator output.

When system enters suspend, some PWM client/slave regulator devices
require the PWM output to be tristated.

Add DT binding details to provide the pin configuration state
from PWM and pinctrl DT node in suspend and active state of
the system.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>

---
Changes from v1:
- Use standard pinctrl names for sleep and active state.

Changes from V2:
- Fix the commit message and details
---
 .../devicetree/bindings/pwm/nvidia,tegra20-pwm.txt | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
index b4e7377..c57e11b 100644
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
+pinctrl-0:	phandle for the default/active state of pin configurations.
+pinctrl-1:	phandle for the sleep state of pin configurations.
+
 Example:
 
 	pwm: pwm@7000a000 {
@@ -29,3 +42,35 @@ Example:
 		resets = <&tegra_car 17>;
 		reset-names = "pwm";
 	};
+
+
+Example with the pin configuration for suspend and resume:
+=========================================================
+Suppose pin PE7 (On Tegra210) interfaced with the regulator device and
+it requires PWM output to be tristated when system enters suspend.
+Following will be DT binding to achieve this:
+
+#include <dt-bindings/pinctrl/pinctrl-tegra.h>
+
+	pinmux@700008d4 {
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
