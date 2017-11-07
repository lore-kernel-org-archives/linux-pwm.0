From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] pwm: stm32-lp: Remove pwm_is_enabled check before calling pwm_disable
Date: Tue,  7 Nov 2017 11:30:41 +0800
Message-ID: <20171107033041.10905-1-axel.lin@ingics.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:52252 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932340AbdKGDa4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Nov 2017 22:30:56 -0500
Received: by mail-pg0-f66.google.com with SMTP id a192so9927247pge.9
        for <linux-pwm@vger.kernel.org>; Mon, 06 Nov 2017 19:30:56 -0800 (PST)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, Fabrice Gasnier <fabrice.gasnier@st.com>, Lee Jones <lee.jones@linaro.org>, Axel Lin <axel.lin@ingics.com>

The same checking is done by the implementation of pwm_disable().

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/pwm/pwm-stm32-lp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index 9793b296108f..1ac9e4384142 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -219,8 +219,7 @@ static int stm32_pwm_lp_remove(struct platform_device *pdev)
 	unsigned int i;
 
 	for (i = 0; i < priv->chip.npwm; i++)
-		if (pwm_is_enabled(&priv->chip.pwms[i]))
-			pwm_disable(&priv->chip.pwms[i]);
+		pwm_disable(&priv->chip.pwms[i]);
 
 	return pwmchip_remove(&priv->chip);
 }
-- 
2.11.0
