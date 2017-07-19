From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 069/102] pwm: hibvt: explicitly request exclusive reset control
Date: Wed, 19 Jul 2017 17:26:13 +0200
Message-ID: <20170719152646.25903-70-p.zabel@pengutronix.de>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719152646.25903-1-p.zabel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
reset lines") started to transition the reset control request API calls
to explicitly state whether the driver needs exclusive or shared reset
control behavior. Convert all drivers requesting exclusive resets to the
explicit API call so the temporary transition helpers can be removed.

No functional changes.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/pwm/pwm-hibvt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-hibvt.c b/drivers/pwm/pwm-hibvt.c
index 8dadc58d6cdfe..27c107e78d59a 100644
--- a/drivers/pwm/pwm-hibvt.c
+++ b/drivers/pwm/pwm-hibvt.c
@@ -208,7 +208,7 @@ static int hibvt_pwm_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	pwm_chip->rstc = devm_reset_control_get(&pdev->dev, NULL);
+	pwm_chip->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (IS_ERR(pwm_chip->rstc)) {
 		clk_disable_unprepare(pwm_chip->clk);
 		return PTR_ERR(pwm_chip->rstc);
-- 
2.11.0
