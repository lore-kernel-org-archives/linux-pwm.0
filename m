Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40785 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390722AbfJPLGJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 07:06:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id o28so4904663wro.7
        for <linux-pwm@vger.kernel.org>; Wed, 16 Oct 2019 04:06:07 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
Date: Wed, 16 Oct 2019 13:05:59 +0200
Message-Id: <20191016110601.1765415-2-thierry.reding@gmail.com>
In-Reply-To: <20191016110601.1765415-1-thierry.reding@gmail.com>
References: <20191016110601.1765415-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: [PATCH v2 1/3] pwm: stm32: Remove clutter from ternary operator
To: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Fabrice Gasnier <fabrice.gasnier@st.com>, linux-pwm@vger.kernel.org

Remove usage of the ternary operator to assign values for register
fields. Instead, parameterize the register and field offset macros
and pass the index to them.

This removes clutter and improves readability.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/pwm/pwm-stm32.c          | 21 +++++++++------------
 include/linux/mfd/stm32-timers.h | 12 ++++--------
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 9430b4cd383f..a5b323432d8c 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -493,20 +493,17 @@ static const struct pwm_ops stm32pwm_ops = {
 static int stm32_pwm_set_breakinput(struct stm32_pwm *priv,
 				    int index, int level, int filter)
 {
-	u32 bke = (index == 0) ? TIM_BDTR_BKE : TIM_BDTR_BK2E;
-	int shift = (index == 0) ? TIM_BDTR_BKF_SHIFT : TIM_BDTR_BK2F_SHIFT;
-	u32 mask = (index == 0) ? TIM_BDTR_BKE | TIM_BDTR_BKP | TIM_BDTR_BKF
-				: TIM_BDTR_BK2E | TIM_BDTR_BK2P | TIM_BDTR_BK2F;
-	u32 bdtr = bke;
+	u32 shift = TIM_BDTR_BKF_SHIFT(index);
+	u32 bke = TIM_BDTR_BKE(index);
+	u32 bkp = TIM_BDTR_BKP(index);
+	u32 bkf = TIM_BDTR_BKF(index);
+	u32 mask = bkf | bkp | bke;
+	u32 bdtr;
 
-	/*
-	 * The both bits could be set since only one will be wrote
-	 * due to mask value.
-	 */
-	if (level)
-		bdtr |= TIM_BDTR_BKP | TIM_BDTR_BK2P;
+	bdtr = (filter & TIM_BDTR_BKF_MASK) << shift | bke;
 
-	bdtr |= (filter & TIM_BDTR_BKF_MASK) << shift;
+	if (level)
+		bdtr |= bkp;
 
 	regmap_update_bits(priv->regmap, TIM_BDTR, mask, bdtr);
 
diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
index 067d14655c28..f8db83aedb2b 100644
--- a/include/linux/mfd/stm32-timers.h
+++ b/include/linux/mfd/stm32-timers.h
@@ -70,14 +70,11 @@
 #define TIM_CCER_CC4E	BIT(12)	/* Capt/Comp 4  out Ena    */
 #define TIM_CCER_CC4P	BIT(13)	/* Capt/Comp 4  Polarity   */
 #define TIM_CCER_CCXE	(BIT(0) | BIT(4) | BIT(8) | BIT(12))
-#define TIM_BDTR_BKE	BIT(12) /* Break input enable	   */
-#define TIM_BDTR_BKP	BIT(13) /* Break input polarity	   */
+#define TIM_BDTR_BKE(x)	BIT(12 + (x) * 12) /* Break input enable */
+#define TIM_BDTR_BKP(x)	BIT(13 + (x) * 12) /* Break input polarity */
 #define TIM_BDTR_AOE	BIT(14)	/* Automatic Output Enable */
 #define TIM_BDTR_MOE	BIT(15)	/* Main Output Enable      */
-#define TIM_BDTR_BKF	(BIT(16) | BIT(17) | BIT(18) | BIT(19))
-#define TIM_BDTR_BK2F	(BIT(20) | BIT(21) | BIT(22) | BIT(23))
-#define TIM_BDTR_BK2E	BIT(24) /* Break 2 input enable	   */
-#define TIM_BDTR_BK2P	BIT(25) /* Break 2 input polarity  */
+#define TIM_BDTR_BKF(x)	(0xf << (16 + (x) * 4))
 #define TIM_DCR_DBA	GENMASK(4, 0)	/* DMA base addr */
 #define TIM_DCR_DBL	GENMASK(12, 8)	/* DMA burst len */
 
@@ -87,8 +84,7 @@
 #define TIM_CR2_MMS2_SHIFT	20
 #define TIM_SMCR_TS_SHIFT	4
 #define TIM_BDTR_BKF_MASK	0xF
-#define TIM_BDTR_BKF_SHIFT	16
-#define TIM_BDTR_BK2F_SHIFT	20
+#define TIM_BDTR_BKF_SHIFT(x)	(16 + (x) * 4)
 
 enum stm32_timers_dmas {
 	STM32_TIMERS_DMA_CH1,
-- 
2.23.0
