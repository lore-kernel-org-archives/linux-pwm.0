From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH 4/5] pwm: tegra: Add DT node compatible for Tegra186
Date: Wed, 22 Jun 2016 17:17:22 +0530
Message-ID: <1466596043-27262-5-git-send-email-ldewangan@nvidia.com>
References: <1466596043-27262-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466596043-27262-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, swarren@wwwdotorg.org, gnurou@gmail.com
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-pwm@vger.kernel.org

Tegra186 has 8 different PWM controller and each controller has only
one output. Earlier generation SoCs have the 4 PWM output per controller.

Add DT node compatible for Tegra186.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
index c52f03b..2851b2d 100644
--- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
@@ -1,10 +1,12 @@
 Tegra SoC PWFM controller
 
 Required properties:
-- compatible: For Tegra20, must contain "nvidia,tegra20-pwm".  For Tegra30,
-  must contain "nvidia,tegra30-pwm".  Otherwise, must contain
-  "nvidia,<chip>-pwm", plus one of the above, where <chip> is tegra114,
-  tegra124, tegra132, or tegra210.
+- compatible: For Tegra20, must contain "nvidia,tegra20-pwm".
+	      For Tegra30, must contain "nvidia,tegra30-pwm".
+	      For Tegra114, Tegra124, Tegra132, Tegra210 must contain
+	      "nvidia,<chip>-pwm", plus one of the above, where <chip> is
+	      tegra114, tegra124, tegra132, or tegra210.
+	      For Tegra186, must contain "nvidia,tegra186-pwm".
 - reg: physical base address and length of the controller's registers
 - #pwm-cells: should be 2. See pwm.txt in this directory for a description of
   the cells format.
-- 
2.1.4
