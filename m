From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] regulator: pwm: Don't warn on probe deferral
Date: Mon, 24 Feb 2020 14:40:48 +0000
Message-ID: <20200224144048.6587-1-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18372 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbgBXOkx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Feb 2020 09:40:53 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>

Deferred probe is an expected return value for devm_pwm_get(). Given
that the driver deals with it properly, there's no need to output a
warning that may potentially confuse users.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/regulator/pwm-regulator.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index e74e11101fc1..fb25777a7d47 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -354,7 +354,8 @@ static int pwm_regulator_probe(struct platform_device *pdev)
 	drvdata->pwm = devm_pwm_get(&pdev->dev, NULL);
 	if (IS_ERR(drvdata->pwm)) {
 		ret = PTR_ERR(drvdata->pwm);
-		dev_err(&pdev->dev, "Failed to get PWM: %d\n", ret);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Failed to get PWM: %d\n", ret);
 		return ret;
 	}
 
-- 
2.17.1
