Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54684 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729325AbfJPHiw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 03:38:52 -0400
Received: by mail-wm1-f68.google.com with SMTP id p7so1664852wmp.4
        for <linux-pwm@vger.kernel.org>; Wed, 16 Oct 2019 00:38:49 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
Date: Wed, 16 Oct 2019 09:38:41 +0200
Message-Id: <20191016073842.1300297-3-thierry.reding@gmail.com>
In-Reply-To: <20191016073842.1300297-1-thierry.reding@gmail.com>
References: <20191016073842.1300297-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: [PATCH 2/3] pwm: stm32: Remove confusing bitmask
To: Thierry Reding <thierry.reding@gmail.com>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Fabrice Gasnier <fabrice.gasnier@st.com>, linux-pwm@vger.kernel.org

Both BKP bits are set in the BDTR register and the code relies on the
mask used during write to make sure only one of them is written. Since
this isn't immediately obvious, a comment is needed to explain it. The
same can be achieved by making explicit what happens, so add another
temporary variable that contains only the one bit that is actually ORed
into the register and get rid of the comment.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/pwm/pwm-stm32.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index b12fb11b7a55..8f1f3371e1dd 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -493,26 +493,24 @@ static const struct pwm_ops stm32pwm_ops = {
 static int stm32_pwm_set_breakinput(struct stm32_pwm *priv,
 				    int index, int level, int filter)
 {
-	u32 bke, shift, mask, bdtr;
+	u32 bke, bkp, shift, mask, bdtr;
 
 	if (index == 0) {
 		bke = TIM_BDTR_BKE;
+		bkp = TIM_BDTR_BKP;
 		shift = TIM_BDTR_BKF_SHIFT;
 		mask = TIM_BDTR_BKE | TIM_BDTR_BKP | TIM_BDTR_BKF;
 	} else {
 		bke = TIM_BDTR_BK2E;
+		bkp = TIM_BDTR_BK2P;
 		shift = TIM_BDTR_BK2F_SHIFT;
 		mask = TIM_BDTR_BK2E | TIM_BDTR_BK2P | TIM_BDTR_BK2F;
 	}
 
 	bdtr = bke;
 
-	/*
-	 * The both bits could be set since only one will be wrote
-	 * due to mask value.
-	 */
 	if (level)
-		bdtr |= TIM_BDTR_BKP | TIM_BDTR_BK2P;
+		bdtr |= bkp;
 
 	bdtr |= (filter & TIM_BDTR_BKF_MASK) << shift;
 
-- 
2.23.0
