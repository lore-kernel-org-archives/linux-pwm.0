From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.3 25/71] pwm: stm32-lp: Add check in case requested period cannot be achieved
Date: Tue,  1 Oct 2019 12:38:35 -0400
Message-ID: <20191001163922.14735-25-sashal@kernel.org>
References: <20191001163922.14735-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191001163922.14735-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>, Sasha Levin <sashal@kernel.org>, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

From: Fabrice Gasnier <fabrice.gasnier@st.com>

[ Upstream commit c91e3234c6035baf5a79763cb4fcd5d23ce75c2b ]

LPTimer can use a 32KHz clock for counting. It depends on clock tree
configuration. In such a case, PWM output frequency range is limited.
Although unlikely, nothing prevents user from requesting a PWM frequency
above counting clock (32KHz for instance):
- This causes (prd - 1) = 0xffff to be written in ARR register later in
the apply() routine.
This results in badly configured PWM period (and also duty_cycle).
Add a check to report an error is such a case.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-stm32-lp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index 2211a642066db..97a9afa191ee0 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -59,6 +59,12 @@ static int stm32_pwm_lp_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	/* Calculate the period and prescaler value */
 	div = (unsigned long long)clk_get_rate(priv->clk) * state->period;
 	do_div(div, NSEC_PER_SEC);
+	if (!div) {
+		/* Clock is too slow to achieve requested period. */
+		dev_dbg(priv->chip.dev, "Can't reach %u ns\n",	state->period);
+		return -EINVAL;
+	}
+
 	prd = div;
 	while (div > STM32_LPTIM_MAX_ARR) {
 		presc++;
-- 
2.20.1
