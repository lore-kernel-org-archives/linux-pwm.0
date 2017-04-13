From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH 2/2] pwm: tegra: Set maximum pwm clock source per SoC tapeout
Date: Thu, 13 Apr 2017 19:40:28 +0530
Message-ID: <1492092628-843-2-git-send-email-ldewangan@nvidia.com>
References: <1492092628-843-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14159 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753337AbdDMO3f (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 13 Apr 2017 10:29:35 -0400
In-Reply-To: <1492092628-843-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, jonathanh@nvidia.com
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>

The PWM hardware IP is taped-out with different maximum frequency
on different SoCs.

From HW team:
	For Tegra210, it is 38.4MHz.
	For Tegra186, it is 102MHz.

Add support to limit the clock source frequency to the maximum IP
supported frequency. Provide these values via SoC chipdata.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/pwm/pwm-tegra.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 8c6ed55..7016c08 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -41,6 +41,9 @@
 
 struct tegra_pwm_soc {
 	unsigned int num_channels;
+
+	/* Maximum IP frequency for given SoCs */
+	unsigned long max_frequency;
 };
 
 struct tegra_pwm_chip {
@@ -204,6 +207,24 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 	/* Read PWM clock rate from source */
 	pwm->clk_rate = clk_get_rate(pwm->clk);
 
+	/* Make sure clock source freqeuncy must less than IP supported */
+	if (pwm->soc->max_frequency &&
+	    (pwm->soc->max_frequency < pwm->clk_rate)) {
+		ret = clk_set_rate(pwm->clk, pwm->soc->max_frequency);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "Failed to set max frequency: %d\n",
+				ret);
+			return ret;
+		}
+
+		/*
+		 * The requested and configured frequency may differ due to
+		 * clock register resolutions. Get the configured frequency
+		 * so that PWM period can be calculated more accurately.
+		 */
+		 pwm->clk_rate = clk_get_rate(pwm->clk);
+	}
+
 	pwm->rst = devm_reset_control_get(&pdev->dev, "pwm");
 	if (IS_ERR(pwm->rst)) {
 		ret = PTR_ERR(pwm->rst);
@@ -275,12 +296,19 @@ static const struct tegra_pwm_soc tegra20_pwm_soc = {
 	.num_channels = 4,
 };
 
+static const struct tegra_pwm_soc tegra210_pwm_soc = {
+	.num_channels = 4,
+	.max_frequency = 38400000UL, /* 38.4MHz */
+};
+
 static const struct tegra_pwm_soc tegra186_pwm_soc = {
 	.num_channels = 1,
+	.max_frequency = 102000000UL, /* 102MHz */
 };
 
 static const struct of_device_id tegra_pwm_of_match[] = {
 	{ .compatible = "nvidia,tegra20-pwm", .data = &tegra20_pwm_soc },
+	{ .compatible = "nvidia,tegra210-pwm", .data = &tegra210_pwm_soc },
 	{ .compatible = "nvidia,tegra186-pwm", .data = &tegra186_pwm_soc },
 	{ }
 };
-- 
2.1.4
