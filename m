From: Yizhuo <yzhai003@ucr.edu>
Subject: [PATCH] pwm: stm32: Fix the usage of uninitialized variable in stm32_pwm_config()
Date: Thu,  3 Oct 2019 21:46:49 -0700
Message-ID: <20191004044649.2405-1-yzhai003@ucr.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Yizhuo <yzhai003@ucr.edu>, Fabrice Gasnier <fabrice.gasnier@st.com>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Inside function stm32_pwm_config(), variable "psc" and " arr"
could be uninitialized if regmap_read() returns -EINVALs.
However, they are used later in the if statement to decide
the return value which is potentially unsafe.

The same case happens in function stm32_pwm_detect_channels()
with variable "ccer", but we cannot just return -EINVAL because
the error code is not acceptable by the caller. Aslo, the variable
"ccer" in functionstm32_pwm_detect_complementary() could also be
uninitialized, since stm32_pwm_detect_complementary() returns void,
the patch is not easy.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/pwm/pwm-stm32.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 359b08596d9e..22c54df52977 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -346,9 +346,15 @@ static int stm32_pwm_config(struct stm32_pwm *priv, int ch,
 	 */
 	if (active_channels(priv) & ~(1 << ch * 4)) {
 		u32 psc, arr;
+		int ret;
 
-		regmap_read(priv->regmap, TIM_PSC, &psc);
-		regmap_read(priv->regmap, TIM_ARR, &arr);
+		ret = regmap_read(priv->regmap, TIM_PSC, &psc);
+		if (ret)
+			return ret;
+
+		ret = regmap_read(priv->regmap, TIM_ARR, &arr);
+		if (ret)
+			return ret;
 
 		if ((psc != prescaler) || (arr != prd - 1))
 			return -EBUSY;
-- 
2.17.1
