Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52823 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729325AbfJPHis (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 03:38:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id r19so1683967wmh.2
        for <linux-pwm@vger.kernel.org>; Wed, 16 Oct 2019 00:38:47 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
Date: Wed, 16 Oct 2019 09:38:40 +0200
Message-Id: <20191016073842.1300297-2-thierry.reding@gmail.com>
In-Reply-To: <20191016073842.1300297-1-thierry.reding@gmail.com>
References: <20191016073842.1300297-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: [PATCH 1/3] pwm: stm32: Remove clutter from ternary operator
To: Thierry Reding <thierry.reding@gmail.com>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Fabrice Gasnier <fabrice.gasnier@st.com>, linux-pwm@vger.kernel.org

Remove usage of the ternary operator to assign values for register
fields. This removes clutter and improves readability.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/pwm/pwm-stm32.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 9430b4cd383f..b12fb11b7a55 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -493,11 +493,19 @@ static const struct pwm_ops stm32pwm_ops = {
 static int stm32_pwm_set_breakinput(struct stm32_pwm *priv,
 				    int index, int level, int filter)
 {
-	u32 bke = (index == 0) ? TIM_BDTR_BKE : TIM_BDTR_BK2E;
-	int shift = (index == 0) ? TIM_BDTR_BKF_SHIFT : TIM_BDTR_BK2F_SHIFT;
-	u32 mask = (index == 0) ? TIM_BDTR_BKE | TIM_BDTR_BKP | TIM_BDTR_BKF
-				: TIM_BDTR_BK2E | TIM_BDTR_BK2P | TIM_BDTR_BK2F;
-	u32 bdtr = bke;
+	u32 bke, shift, mask, bdtr;
+
+	if (index == 0) {
+		bke = TIM_BDTR_BKE;
+		shift = TIM_BDTR_BKF_SHIFT;
+		mask = TIM_BDTR_BKE | TIM_BDTR_BKP | TIM_BDTR_BKF;
+	} else {
+		bke = TIM_BDTR_BK2E;
+		shift = TIM_BDTR_BK2F_SHIFT;
+		mask = TIM_BDTR_BK2E | TIM_BDTR_BK2P | TIM_BDTR_BK2F;
+	}
+
+	bdtr = bke;
 
 	/*
 	 * The both bits could be set since only one will be wrote
-- 
2.23.0
