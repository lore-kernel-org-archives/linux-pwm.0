From: Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [PATCH v10 08/12] pwm: stm32-lp: Use %llu format specifier for period
Date: Thu, 19 Mar 2020 13:50:11 -0700
Message-ID: <eff18b7a8a99c4eecef3867dfc1dcaa1bce109eb.1584650604.git.gurus@codeaurora.org>
References: <cover.1584650604.git.gurus@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1584650604.git.gurus@codeaurora.org>
In-Reply-To: <cover.1584650604.git.gurus@codeaurora.org>
References: <cover.1584650604.git.gurus@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, linux-kernel@vger.kernel.org, Guru Das Srinagesh <gurus@codeaurora.org>, Fabrice Gasnier <fabrice.gasnier@st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>
List-Id: linux-pwm@vger.kernel.org

Since the PWM framework is switching struct pwm_args.period's
datatype to u64, prepare for this transition by using the right
specifier for printing a 64-bit value.

Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
---
 drivers/pwm/pwm-stm32-lp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index 67fca62..134c146 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -61,7 +61,7 @@ static int stm32_pwm_lp_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	do_div(div, NSEC_PER_SEC);
 	if (!div) {
 		/* Clock is too slow to achieve requested period. */
-		dev_dbg(priv->chip.dev, "Can't reach %u ns\n",	state->period);
+		dev_dbg(priv->chip.dev, "Can't reach %llu ns\n", state->period);
 		return -EINVAL;
 	}
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
