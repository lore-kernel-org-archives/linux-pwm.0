From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: [PATCH v2] backlight: pwm: reject legacy pwm request for device defined in dt
Date: Mon, 12 Oct 2015 15:29:03 +0300
Message-ID: <1444652943-19712-1-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:40822 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbbJLMab (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Oct 2015 08:30:31 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jg1.han@samsung.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org

Platform PWM backlight data provided by board's device tree should be
complete enough to successfully request a pwm device using pwm_get()
API. This change fixes a bug, when an arbitrary (first found) PWM is
connected to a "pwm-backlight" compatible device, when explicit PWM
device reference is not given.

Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt
already describes "pwms" as a required property, instead of blind
selection of a potentially wrong PWM reject legacy PWM device
registration request, leave legacy API only for non-dt cases.

Based on initial implementation done by Dmitry Eremin-Solenikov.

Reported-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
The change is based on lee-backlight/for-backlight-next

Changes from v1 to v2:
* rebased on top of Nicolas' commit
    68feaca0b13 ("backlight: pwm: Handle EPROBE_DEFER while requesting the PWM")

Links to previous discussions of the change:
* https://patchwork.ozlabs.org/patch/483993/
* https://patchwork.ozlabs.org/patch/398849/

 drivers/video/backlight/pwm_bl.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index eff379b..ae3c6b6 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -271,19 +271,18 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	}
 
 	pb->pwm = devm_pwm_get(&pdev->dev, NULL);
-	if (IS_ERR(pb->pwm)) {
-		ret = PTR_ERR(pb->pwm);
-		if (ret == -EPROBE_DEFER)
-			goto err_alloc;
-
+	if (IS_ERR(pb->pwm) && PTR_ERR(pb->pwm) != -EPROBE_DEFER
+	    && !pdev->dev.of_node) {
 		dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n");
 		pb->legacy = true;
 		pb->pwm = pwm_request(data->pwm_id, "pwm-backlight");
-		if (IS_ERR(pb->pwm)) {
-			dev_err(&pdev->dev, "unable to request legacy PWM\n");
-			ret = PTR_ERR(pb->pwm);
-			goto err_alloc;
-		}
+	}
+
+	if (IS_ERR(pb->pwm)) {
+		ret = PTR_ERR(pb->pwm);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "unable to request PWM\n");
+		goto err_alloc;
 	}
 
 	dev_dbg(&pdev->dev, "got pwm for backlight\n");
-- 
2.5.0
