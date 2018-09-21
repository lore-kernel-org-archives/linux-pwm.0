From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH] pwm: tegra: Remove gratuituous blank line
Date: Fri, 21 Sep 2018 12:13:07 +0200
Message-ID: <20180921101307.12089-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

It's common to follow a device tree ID table by the MODULE_DEVICE_TABLE
immediately, without an extra blank line between.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pwm/pwm-tegra.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index f8ebbece57b7..48c4595a0ffc 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -300,7 +300,6 @@ static const struct of_device_id tegra_pwm_of_match[] = {
 	{ .compatible = "nvidia,tegra186-pwm", .data = &tegra186_pwm_soc },
 	{ }
 };
-
 MODULE_DEVICE_TABLE(of, tegra_pwm_of_match);
 
 static const struct dev_pm_ops tegra_pwm_pm_ops = {
-- 
2.19.0
