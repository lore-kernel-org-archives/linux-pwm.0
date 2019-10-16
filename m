Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37427 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729325AbfJPHix (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 03:38:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id p14so26745987wro.4
        for <linux-pwm@vger.kernel.org>; Wed, 16 Oct 2019 00:38:52 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
Date: Wed, 16 Oct 2019 09:38:42 +0200
Message-Id: <20191016073842.1300297-4-thierry.reding@gmail.com>
In-Reply-To: <20191016073842.1300297-1-thierry.reding@gmail.com>
References: <20191016073842.1300297-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: [PATCH 3/3] pwm: stm32: Pass breakinput instead of its values
To: Thierry Reding <thierry.reding@gmail.com>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Fabrice Gasnier <fabrice.gasnier@st.com>, linux-pwm@vger.kernel.org

Instead of passing the individual values of the breakpoint, pass a
pointer to the breakpoint.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/pwm/pwm-stm32.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 8f1f3371e1dd..9e500928c37d 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -491,11 +491,11 @@ static const struct pwm_ops stm32pwm_ops = {
 };
 
 static int stm32_pwm_set_breakinput(struct stm32_pwm *priv,
-				    int index, int level, int filter)
+				    const struct stm32_breakinput *bi)
 {
 	u32 bke, bkp, shift, mask, bdtr;
 
-	if (index == 0) {
+	if (bi->index == 0) {
 		bke = TIM_BDTR_BKE;
 		bkp = TIM_BDTR_BKP;
 		shift = TIM_BDTR_BKF_SHIFT;
@@ -509,10 +509,10 @@ static int stm32_pwm_set_breakinput(struct stm32_pwm *priv,
 
 	bdtr = bke;
 
-	if (level)
+	if (bi->level)
 		bdtr |= bkp;
 
-	bdtr |= (filter & TIM_BDTR_BKF_MASK) << shift;
+	bdtr |= (bi->filter & TIM_BDTR_BKF_MASK) << shift;
 
 	regmap_update_bits(priv->regmap, TIM_BDTR, mask, bdtr);
 
@@ -527,10 +527,7 @@ static int stm32_pwm_apply_breakinputs(struct stm32_pwm *priv)
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
