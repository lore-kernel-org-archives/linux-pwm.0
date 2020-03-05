From: Sandipan Patra <spatra-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] pwm: tegra: Add support for Tegra194
Date: Thu, 5 Mar 2020 16:57:33 +0530
Message-ID: <1583407653-30059-1-git-send-email-spatra@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Cc: bbasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sandipan Patra <spatra-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Tegra194 has multiple PWM controllers with each having only one output.

Also the maxmimum frequency is higher than earlier SoCs.

Add support for Tegra194 and specify the number of PWM outputs and
maximum supported frequency using device tree match data.

Signed-off-by: Sandipan Patra <spatra-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt | 1 +
 drivers/pwm/pwm-tegra.c                                      | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
index 0a69ead..74c41e3 100644
--- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
@@ -9,6 +9,7 @@ Required properties:
   - "nvidia,tegra132-pwm", "nvidia,tegra20-pwm": for Tegra132
   - "nvidia,tegra210-pwm", "nvidia,tegra20-pwm": for Tegra210
   - "nvidia,tegra186-pwm": for Tegra186
+  - "nvidia,tegra194-pwm": for Tegra194
 - reg: physical base address and length of the controller's registers
 - #pwm-cells: should be 2. See pwm.yaml in this directory for a description of
   the cells format.
diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index aa12fb3..d26ed8f 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -282,9 +282,15 @@ static const struct tegra_pwm_soc tegra186_pwm_soc = {
 	.max_frequency = 102000000UL,
 };
 
+static const struct tegra_pwm_soc tegra194_pwm_soc = {
+	.num_channels = 1,
+	.max_frequency = 408000000UL,
+};
+
 static const struct of_device_id tegra_pwm_of_match[] = {
 	{ .compatible = "nvidia,tegra20-pwm", .data = &tegra20_pwm_soc },
 	{ .compatible = "nvidia,tegra186-pwm", .data = &tegra186_pwm_soc },
+	{ .compatible = "nvidia,tegra194-pwm", .data = &tegra194_pwm_soc },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, tegra_pwm_of_match);
-- 
2.7.4
