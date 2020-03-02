From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V2] regulator: pwm: Don't warn on probe deferral
Date: Mon, 2 Mar 2020 14:14:28 +0000
Message-ID: <20200302141428.14119-1-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Deferred probe is an expected return value for devm_pwm_get(). Given
that the driver deals with it properly, rather than warn on probe
deferral, only output a message on probe deferral if debug level
prints are enabled.

Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
Changes since V1:
- Update change to add a debug print for probe deferral

 drivers/regulator/pwm-regulator.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index e74e11101fc1..638329bd0745 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -354,7 +354,11 @@ static int pwm_regulator_probe(struct platform_device *pdev)
 	drvdata->pwm = devm_pwm_get(&pdev->dev, NULL);
 	if (IS_ERR(drvdata->pwm)) {
 		ret = PTR_ERR(drvdata->pwm);
-		dev_err(&pdev->dev, "Failed to get PWM: %d\n", ret);
+		if (ret == -EPROBE_DEFER)
+			dev_dbg(&pdev->dev,
+				"Failed to get PWM, deferring probe\n");
+		else
+			dev_err(&pdev->dev, "Failed to get PWM: %d\n", ret);
 		return ret;
 	}
 
-- 
2.17.1
