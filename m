From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] pwm: sun4i: properly check current state
Date: Sun, 25 Feb 2018 02:55:58 +0100
Message-ID: <20180225015558.4843-1-alexandre.belloni@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, Maxime Ripard <maxime.ripard@bootlin.com>, linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Correctly extract the prescaler value from CTRL_REG before comparing it to
PWM_PRESCAL_MASK.

Also, check that both PWM_CLK_GATING and PWM_EN to ensure the PWM is
enabled instead of relying on only one of those.

Fixes: 93e0dfb2c52f ("pwm: sun4i: Improve hardware read out")
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/pwm/pwm-sun4i.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 334199c58f1d..42e6f0873d1c 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -117,7 +117,8 @@ static void sun4i_pwm_get_state(struct pwm_chip *chip,
 
 	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
 
-	if ((val == PWM_PRESCAL_MASK) && sun4i_pwm->data->has_prescaler_bypass)
+	if ((PWM_REG_PRESCAL(val, pwm->hwpwm) == PWM_PRESCAL_MASK) &&
+	    sun4i_pwm->data->has_prescaler_bypass)
 		prescaler = 1;
 	else
 		prescaler = prescaler_table[PWM_REG_PRESCAL(val, pwm->hwpwm)];
@@ -130,7 +131,8 @@ static void sun4i_pwm_get_state(struct pwm_chip *chip,
 	else
 		state->polarity = PWM_POLARITY_INVERSED;
 
-	if (val & BIT_CH(PWM_CLK_GATING | PWM_EN, pwm->hwpwm))
+	if ((val & BIT_CH(PWM_CLK_GATING | PWM_EN, pwm->hwpwm)) ==
+	    BIT_CH(PWM_CLK_GATING | PWM_EN, pwm->hwpwm))
 		state->enabled = true;
 	else
 		state->enabled = false;
-- 
2.16.1
