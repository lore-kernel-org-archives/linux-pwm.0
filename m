From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH 2/8] pwm: stm32: protect common prescaler for all channels
Date: Tue, 16 Jan 2018 13:43:45 +0100
Message-ID: <1516106631-18722-3-git-send-email-fabrice.gasnier@st.com>
References: <1516106631-18722-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1516106631-18722-1-git-send-email-fabrice.gasnier@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: lee.jones@linaro.org, thierry.reding@gmail.com, robh+dt@kernel.org, alexandre.torgue@st.com, benjamin.gaignard@linaro.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, benjamin.gaignard@st.com, linux-pwm@vger.kernel.org, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

There may be a race, when configuring two pwm channels, with different
prescaler values, when there's no active channel yet.
Add mutex lock to avoid concurrent access on pwm apply state.
This is also precursor patch for pwm capture support.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
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
