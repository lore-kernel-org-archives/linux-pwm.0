From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [RESEND PATCH v2 2/8] pwm: stm32: protect common prescaler for all channels
Date: Wed, 14 Feb 2018 11:04:33 +0100
Message-ID: <1518602679-3064-3-git-send-email-fabrice.gasnier@st.com>
References: <1518602679-3064-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1518602679-3064-1-git-send-email-fabrice.gasnier@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, thierry.reding@gmail.com, alexandre.torgue@st.com
Cc: benjamin.gaignard@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com, benjamin.gaignard@st.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

There may be a race, when configuring two pwm channels, with different
prescaler values, when there's no active channel yet.
Add mutex lock to avoid concurrent access on pwm apply state.
This is also precursor patch for pwm capture support.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 drivers/pwm/pwm-stm32.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 59524f9..3ac55df 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -21,6 +21,7 @@
 
 struct stm32_pwm {
 	struct pwm_chip chip;
+	struct mutex lock; /* protect pwm config/enable */
 	struct clk *clk;
 	struct regmap *regmap;
 	u32 max_arr;
@@ -213,9 +214,23 @@ static int stm32_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	return ret;
 }
 
+static int stm32_pwm_apply_locked(struct pwm_chip *chip, struct pwm_device *pwm,
+				  struct pwm_state *state)
+{
+	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
+	int ret;
+
+	/* protect common prescaler for all active channels */
+	mutex_lock(&priv->lock);
+	ret = stm32_pwm_apply(chip, pwm, state);
+	mutex_unlock(&priv->lock);
+
+	return ret;
+}
+
 static const struct pwm_ops stm32pwm_ops = {
 	.owner = THIS_MODULE,
-	.apply = stm32_pwm_apply,
+	.apply = stm32_pwm_apply_locked,
 };
 
 static int stm32_pwm_set_breakinput(struct stm32_pwm *priv,
@@ -335,6 +350,7 @@ static int stm32_pwm_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	mutex_init(&priv->lock);
 	priv->regmap = ddata->regmap;
 	priv->clk = ddata->clk;
 	priv->max_arr = ddata->max_arr;
-- 
1.9.1
