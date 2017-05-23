From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH] pwm: silently error on EPROBE_DEFER
Date: Tue, 23 May 2017 18:05:03 +0200
Message-ID: <20170523160503.16920-1-jbrunet@baylibre.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36621 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763963AbdEWQFI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 23 May 2017 12:05:08 -0400
Received: by mail-wm0-f50.google.com with SMTP id 7so30177588wmo.1
        for <linux-pwm@vger.kernel.org>; Tue, 23 May 2017 09:05:07 -0700 (PDT)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org

In of_pwm_chip, if we fail to get the pwm chip due to probe defer, we
shouldn't print an error message. Just be silent in this case.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pwm/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index a0860b30bd93..1581f6ab1b1f 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -678,7 +678,9 @@ struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id)
 
 	pc = of_node_to_pwmchip(args.np);
 	if (IS_ERR(pc)) {
-		pr_err("%s(): PWM chip not found\n", __func__);
+		if (PTR_ERR(pc) != -EPROBE_DEFER)
+			pr_err("%s(): PWM chip not found\n", __func__);
+
 		pwm = ERR_CAST(pc);
 		goto put;
 	}
-- 
2.9.4
