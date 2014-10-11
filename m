From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: [PATCH 1/2] backlight: pwm: don't call legacy pwm request for device defined in dt
Date: Sat, 11 Oct 2014 16:46:25 +0300
Message-ID: <1413035186-11771-2-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1413035186-11771-1-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:61165 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152AbaJKNqj (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sat, 11 Oct 2014 09:46:39 -0400
In-Reply-To: <1413035186-11771-1-git-send-email-vladimir_zapolskiy@mentor.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, stable@vger.kernel.org

Platform PWM backlight data provided by board's device tree should be
complete enough to successfully request a pwm device using pwm_get() API.

Based on initial implementation done by Dmitry Eremin-Solenikov.

Reported-by: Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>
Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jingoo Han <jg1.han@samsung.com>
Cc: Bryan Wu <cooloney@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/backlight/pwm_bl.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index cb5ae4c..dd7aaf7 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -272,15 +272,15 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	}
 
 	pb->pwm = devm_pwm_get(&pdev->dev, NULL);
-	if (IS_ERR(pb->pwm)) {
+	if (IS_ERR(pb->pwm) && !pdev->dev.of_node) {
 		dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n");
-
 		pb->pwm = pwm_request(data->pwm_id, "pwm-backlight");
-		if (IS_ERR(pb->pwm)) {
-			dev_err(&pdev->dev, "unable to request legacy PWM\n");
-			ret = PTR_ERR(pb->pwm);
-			goto err_alloc;
-		}
+	}
+
+	if (IS_ERR(pb->pwm)) {
+		dev_err(&pdev->dev, "unable to request PWM\n");
+		ret = PTR_ERR(pb->pwm);
+		goto err_alloc;
 	}
 
 	dev_dbg(&pdev->dev, "got pwm for backlight\n");
-- 
1.7.10.4

