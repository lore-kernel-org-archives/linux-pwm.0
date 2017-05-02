From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V2] pwm: tegra: Set maximum pwm clock source per SoC tapeout
Date: Tue, 2 May 2017 19:35:37 +0530
Message-ID: <1493733937-15822-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

The PWM hardware IP is taped-out with different maximum frequency
on different SoCs.

From HW team:
	Before Tegra186, it is 38.4MHz.
	In Tegra186, it is 102MHz.

Add support to limit the clock source frequency to the maximum IP
supported frequency. Provide these values via SoC chipdata.

Signed-off-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

---
Changes from V1:
- Set the 48MHz maximum frequency for Tegra210 and earlier.
- Set the maximum frequency unconditionally as per V1 review comment.
---
 drivers/pwm/pwm-tegra.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 8c6ed55..e9b33f0 100644
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
@@ -201,7 +204,18 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(pwm->clk))
 		return PTR_ERR(pwm->clk);
 
-	/* Read PWM clock rate from source */
+	/* Set maximum frequency of the IP */
+	ret = clk_set_rate(pwm->clk, pwm->soc->max_frequency);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to set max frequency: %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * The requested and configured frequency may differ due to
+	 * clock register resolutions. Get the configured frequency
+	 * so that PWM period can be calculated more accurately.
+	 */
 	pwm->clk_rate = clk_get_rate(pwm->clk);
 
 	pwm->rst = devm_reset_control_get(&pdev->dev, "pwm");
@@ -273,10 +287,12 @@ static int tegra_pwm_resume(struct device *dev)
 
 static const struct tegra_pwm_soc tegra20_pwm_soc = {
 	.num_channels = 4,
+	.max_frequency = 48000000UL,
 };
 
 static const struct tegra_pwm_soc tegra186_pwm_soc = {
 	.num_channels = 1,
+	.max_frequency = 102000000UL,
 };
 
 static const struct of_device_id tegra_pwm_of_match[] = {
-- 
2.1.4
