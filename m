Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55833 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388896AbfJPLGL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 07:06:11 -0400
Received: by mail-wm1-f66.google.com with SMTP id a6so2417932wma.5
        for <linux-pwm@vger.kernel.org>; Wed, 16 Oct 2019 04:06:09 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
Date: Wed, 16 Oct 2019 13:06:00 +0200
Message-Id: <20191016110601.1765415-3-thierry.reding@gmail.com>
In-Reply-To: <20191016110601.1765415-1-thierry.reding@gmail.com>
References: <20191016110601.1765415-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: [PATCH v2 2/3] pwm: stm32: Pass breakinput instead of its values
To: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Fabrice Gasnier <fabrice.gasnier@st.com>, linux-pwm@vger.kernel.org

Instead of passing the individual values of the breakpoint, pass a
pointer to the breakpoint.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/pwm/pwm-stm32.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index a5b323432d8c..db1d675b45fb 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -491,18 +491,18 @@ static const struct pwm_ops stm32pwm_ops = {
 };
 
 static int stm32_pwm_set_breakinput(struct stm32_pwm *priv,
-				    int index, int level, int filter)
+				    const struct stm32_breakinput *bi)
 {
-	u32 shift = TIM_BDTR_BKF_SHIFT(index);
-	u32 bke = TIM_BDTR_BKE(index);
-	u32 bkp = TIM_BDTR_BKP(index);
-	u32 bkf = TIM_BDTR_BKF(index);
+	u32 shift = TIM_BDTR_BKF_SHIFT(bi->index);
+	u32 bke = TIM_BDTR_BKE(bi->index);
+	u32 bkp = TIM_BDTR_BKP(bi->index);
+	u32 bkf = TIM_BDTR_BKF(bi->index);
 	u32 mask = bkf | bkp | bke;
 	u32 bdtr;
 
-	bdtr = (filter & TIM_BDTR_BKF_MASK) << shift | bke;
+	bdtr = (bi->filter & TIM_BDTR_BKF_MASK) << shift | bke;
 
-	if (level)
+	if (bi->level)
 		bdtr |= bkp;
 
 	regmap_update_bits(priv->regmap, TIM_BDTR, mask, bdtr);
@@ -518,10 +518,7 @@ static int stm32_pwm_apply_breakinputs(struct stm32_pwm *priv)
 	int ret;
 
 	for (i = 0; i < priv->num_breakinputs; i++) {
-		ret = stm32_pwm_set_breakinput(priv,
-					       priv->breakinputs[i].index,
-					       priv->breakinputs[i].level,
-					       priv->breakinputs[i].filter);
+		ret = stm32_pwm_set_breakinput(priv, &priv->breakinputs[i]);
 		if (ret < 0)
 			return ret;
 	}
-- 
2.23.0
