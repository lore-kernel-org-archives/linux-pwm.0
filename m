From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH v2] pwm: pwm-lpc18xx-sct: test clock rate to avoid division by 0
Date: Wed,  2 Mar 2016 23:57:09 +0100
Message-ID: <1456959443-10032-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:38055 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797AbcCBW7b (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Wed, 2 Mar 2016 17:59:31 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Thierry Reding <thierry.reding@gmail.com>, Joachim Eastwood <manabian@gmail.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

The clk API may return 0 on clk_get_rate, so we should check the result before
using it as a divisor.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/pwm/pwm-lpc18xx-sct.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index 9163085101bc94..9861fed4e67d04 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -360,6 +360,11 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
 	}
 
 	lpc18xx_pwm->clk_rate = clk_get_rate(lpc18xx_pwm->pwm_clk);
+	if (!lpc18xx_pwm->clk_rate) {
+		dev_err(&pdev->dev, "pwm clock has no frequency\n");
+		ret = -EINVAL;
+		goto disable_pwmclk;
+	}
 
 	mutex_init(&lpc18xx_pwm->res_lock);
 	mutex_init(&lpc18xx_pwm->period_lock);
-- 
2.7.0
