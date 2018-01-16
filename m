From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH 5/8] pwm: stm32: add capture support
Date: Tue, 16 Jan 2018 13:43:48 +0100
Message-ID: <1516106631-18722-6-git-send-email-fabrice.gasnier@st.com>
References: <1516106631-18722-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516106631-18722-1-git-send-email-fabrice.gasnier@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, thierry.reding@gmail.com, robh+dt@kernel.org, alexandre.torgue@st.com, benjamin.gaignard@linaro.org
Cc: mark.rutland@arm.com, linux@armlinux.org.uk, mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com, benjamin.gaignard@st.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Add support for PMW input mode on pwm-stm32. STM32 timers support
period and duty cycle capture as long as they have at least two PWM
channels. One capture channel is used for period, one for duty-cycle.
When there's only one channel available, only period can be captured.
It's zero'ed in such a case.
This requires exclusive access (e.g. no pwm output running at the same
time, to protect common prescaler).
Timer DMA burst mode is being used, to take two snapshots of capture
registers (upon each period rising edge).
Falling edge captures duty cycle to capture registers (only).

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/pwm/pwm-stm32.c          | 301 ++++++++++++++++++++++++++++++++++++++-
 include/linux/mfd/stm32-timers.h |  16 +++
 2 files changed, 314 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 3ac55df..b9c7e878 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -9,6 +9,7 @@
  *             pwm-atmel.c from Bo Shen
  */
 
+#include <linux/dma-mapping.h>
 #include <linux/mfd/stm32-timers.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -21,11 +22,17 @@
 
 struct stm32_pwm {
 	struct pwm_chip chip;
+	struct completion completion;
 	struct mutex lock; /* protect pwm config/enable */
 	struct clk *clk;
 	struct regmap *regmap;
+	phys_addr_t phys_base;
 	u32 max_arr;
 	bool have_complementary_output;
+	u32 capture[2];
+	struct dma_chan *dmas[STM32_TIMERS_MAX_DMAS];
+	dma_addr_t dma_buf_phys;	/* dma buffer bus address (phys) */
+	u32 *dma_buf;			/* dma buffer cpu address */
 };
 
 struct stm32_breakinput {
@@ -63,6 +70,263 @@ static int write_ccrx(struct stm32_pwm *dev, int ch, u32 value)
 	return -EINVAL;
 }
 
+/*
+ * Capture using PWM input mode:
+ *                              ___          ___
+ * TI[1, 2, 3 or 4]: ........._|   |________|
+ *                             ^0  ^1       ^2
+ *                              .   .        .
+ *                              .   .        XXXXX
+ *                              .   .   XXXXX     |
+ *                              .  XXXXX     .    |
+ *                            XXXXX .        .    |
+ * COUNTER:        ______XXXXX  .   .        .    |_XXX
+ *                 start^       .   .        .        ^stop
+ *                      .       .   .        .
+ *                      v       v   .        v
+ *                                  v
+ * CCR1/CCR3:       tx..........t0...........t2
+ * CCR2/CCR4:       tx..............t1.........
+ *
+ * DMA burst transfer:          |            |
+ *                              v            v
+ * DMA buffer:                  { t0, tx }   { t2, t1 }
+ * DMA done:                                 ^
+ *
+ * 0: IC1/3 snapchot on rising edge: counter value -> CCR1/CCR3
+ *    + DMA transfer CCR[1/3] & CCR[2/4] values (t0, tx: doesn't care)
+ * 1: IC2/4 snapchot on falling edge: counter value -> CCR2/CCR4
+ * 2: IC1/3 snapchot on rising edge: counter value -> CCR1/CCR3
+ *    + DMA transfer CCR[1/3] & CCR[2/4] values (t2, t1)
+ *
+ * DMA done, compute:
+ * - Period     = t2 - t0
+ * - Duty cycle = t1 - t0
+ */
+static void stm32_pwm_dma_done(void *p)
+{
+	struct pwm_device *pwm = p;
+	struct stm32_pwm *priv = to_stm32_pwm_dev(pwm->chip);
+	/* Use cc1 / cc3 DMA resp for PWM input channels 1 & 2 / 3 & 4 */
+	struct dma_chan *dma_chan = priv->dmas[pwm->hwpwm < 2 ? 0 : 2];
+	struct dma_tx_state state;
+	enum dma_status status;
+
+	status = dmaengine_tx_status(dma_chan, dma_chan->cookie, &state);
+	if (status == DMA_COMPLETE) {
+		/* Period: t2 - t0 (take care of counter overflow) */
+		if (priv->dma_buf[0] <= priv->dma_buf[2])
+			priv->capture[0] = priv->dma_buf[2] - priv->dma_buf[0];
+		else
+			priv->capture[0] = priv->max_arr - priv->dma_buf[0] +
+				priv->dma_buf[2];
+
+		/* Duty cycle capture requires at least two capture units */
+		if (pwm->chip->npwm < 2)
+			priv->capture[1] = 0;
+		else if (priv->dma_buf[0] <= priv->dma_buf[3])
+			priv->capture[1] = priv->dma_buf[3] - priv->dma_buf[0];
+		else
+			priv->capture[1] = priv->max_arr - priv->dma_buf[0] +
+				priv->dma_buf[3];
+
+		if (priv->capture[1] > priv->capture[0]) {
+			/*
+			 * Race beetween PWM input and DMA: it may happen
+			 * falling edge triggers new capture on TI2/4 before DMA
+			 * had a chance to read CCR2/4. It means capture[1]
+			 * contains period + duty_cycle. So, subtract period.
+			 */
+			priv->capture[1] -= priv->capture[0];
+		}
+		complete(&priv->completion);
+	}
+}
+
+#define TIM_DCR_DBL_2_TRANSFERS		BIT(8)
+
+static int stm32_pwm_dma_start(struct stm32_pwm *priv, struct pwm_device *pwm)
+{
+	struct dma_chan *dma_chan = priv->dmas[pwm->hwpwm < 2 ? 0 : 2];
+	struct dma_async_tx_descriptor *desc;
+	struct dma_slave_config config;
+	dma_cookie_t cookie;
+	int ret;
+
+	if (!dma_chan || !priv->dma_buf)
+		return -ENODEV;
+
+	memset(&config, 0, sizeof(config));
+	config.src_addr = (dma_addr_t)priv->phys_base + TIM_DMAR;
+	config.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	ret = dmaengine_slave_config(dma_chan, &config);
+	if (ret)
+		return ret;
+
+	/* Prepare DMA transaction (4 32-bits words, twice bellow transfer) */
+	desc = dmaengine_prep_slave_single(dma_chan, priv->dma_buf_phys,
+					   4 * sizeof(u32), DMA_DEV_TO_MEM,
+					   DMA_PREP_INTERRUPT);
+	if (!desc)
+		return -EBUSY;
+
+	desc->callback = stm32_pwm_dma_done;
+	desc->callback_param = pwm;
+	cookie = dmaengine_submit(desc);
+	ret = dma_submit_error(cookie);
+	if (ret) {
+		dmaengine_terminate_all(dma_chan);
+		return ret;
+	}
+	dma_async_issue_pending(dma_chan);
+
+	/*
+	 * Timer DMA burst mode. Request 2 transfers to get both CCR1 & CCR2
+	 * (or CCR3 & CCR4) on each capture event from DMAR register:
+	 * - DBL (transfer len): 2
+	 * - DBA (start offset): CCR1 or CCR3 (offset / 4)
+	 * As 4 32-bits words has been requested above, we'll get two
+	 * snapchots in 'dma_buf': { CCR1, CCR2 }, { CCR1, CCR2 }
+	 * or { CCR3, CCR4 }, { CCR3, CCR4 }
+	 */
+	regmap_write(priv->regmap, TIM_DCR, TIM_DCR_DBL_2_TRANSFERS |
+		     (pwm->hwpwm < 2 ? (TIM_CCR1 / 4) : (TIM_CCR3 / 4)));
+	regmap_update_bits(priv->regmap, TIM_DIER, TIM_DIER_XDE,
+			   pwm->hwpwm < 2 ? TIM_DIER_CC1DE : TIM_DIER_CC3DE);
+
+	return 0;
+}
+
+static void stm32_pwm_dma_stop(struct stm32_pwm *priv, struct pwm_device *pwm)
+{
+	struct dma_chan *dma_chan = priv->dmas[pwm->hwpwm < 2 ? 0 : 2];
+
+	regmap_update_bits(priv->regmap, TIM_DIER, TIM_DIER_XDE, 0);
+	regmap_write(priv->regmap, TIM_DCR, 0);
+	dmaengine_terminate_all(dma_chan);
+}
+
+#define TIM_CCER_CC12P (TIM_CCER_CC1P | TIM_CCER_CC2P)
+#define TIM_CCER_CC12E (TIM_CCER_CC1E | TIM_CCER_CC2E)
+#define TIM_CCER_CC34P (TIM_CCER_CC3P | TIM_CCER_CC4P)
+#define TIM_CCER_CC34E (TIM_CCER_CC3E | TIM_CCER_CC4E)
+
+static int stm32_pwm_do_capture(struct stm32_pwm *priv, struct pwm_device *pwm,
+				unsigned long tmo_ms)
+{
+	unsigned long timeout = msecs_to_jiffies(tmo_ms);
+	long err;
+	int ret;
+
+	reinit_completion(&priv->completion);
+
+	/* Ensure registers have been updated */
+	regmap_update_bits(priv->regmap, TIM_EGR, TIM_EGR_UG, TIM_EGR_UG);
+
+	/* Clear pending flags, start counter, enable DMA, then capture */
+	regmap_write(priv->regmap, TIM_SR, 0);
+	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, TIM_CR1_CEN);
+	ret = stm32_pwm_dma_start(priv, pwm);
+	if (ret)
+		goto stop;
+	regmap_update_bits(priv->regmap, TIM_CCER, pwm->hwpwm < 2 ?
+			   TIM_CCER_CC12E : TIM_CCER_CC34E,
+			   TIM_CCER_CC12E | TIM_CCER_CC34E);
+
+	err = wait_for_completion_interruptible_timeout(&priv->completion,
+							timeout);
+
+	regmap_update_bits(priv->regmap, TIM_CCER, pwm->hwpwm < 2 ?
+			   TIM_CCER_CC12E : TIM_CCER_CC34E, 0);
+	stm32_pwm_dma_stop(priv, pwm);
+	if (err == 0)
+		ret = -ETIMEDOUT;
+	else if (err < 0)
+		ret = err;
+
+stop:
+	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, 0);
+	regmap_write(priv->regmap, TIM_SR, 0);
+
+	return ret;
+}
+
+static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
+			     struct pwm_capture *result, unsigned long tmo_ms)
+{
+	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
+	unsigned long long prd, div, dty;
+	unsigned long rate;
+	unsigned int psc = 0;
+	u32 raw_prd, raw_dty;
+	int ret = 0;
+
+	mutex_lock(&priv->lock);
+
+	if (active_channels(priv)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	ret = clk_enable(priv->clk);
+	if (ret) {
+		dev_err(priv->chip.dev, "failed to enable counter clock\n");
+		goto unlock;
+	}
+
+	rate = clk_get_rate(priv->clk);
+	if (!rate) {
+		ret = -EINVAL;
+		goto clk_dis;
+	}
+
+	/* prescaler: fit timeout window provided by upper layer */
+	div = (unsigned long long)rate * (unsigned long long)tmo_ms;
+	do_div(div, MSEC_PER_SEC);
+	prd = div;
+	while ((div > priv->max_arr) && (psc < MAX_TIM_PSC)) {
+		psc++;
+		div = prd;
+		do_div(div, psc + 1);
+	}
+	regmap_write(priv->regmap, TIM_ARR, priv->max_arr);
+	regmap_write(priv->regmap, TIM_PSC, psc);
+
+	/* Map TI1 or TI2 PWM input to IC1 & IC2 (or TI3/4 to IC3 & IC4) */
+	regmap_update_bits(priv->regmap,
+			   pwm->hwpwm < 2 ? TIM_CCMR1 : TIM_CCMR2,
+			   TIM_CCMR_CC1S | TIM_CCMR_CC2S, pwm->hwpwm & 0x1 ?
+			   TIM_CCMR_CC1S_TI2 | TIM_CCMR_CC2S_TI2 :
+			   TIM_CCMR_CC1S_TI1 | TIM_CCMR_CC2S_TI1);
+
+	/* Capture period on IC1/3 rising edge, duty cycle on IC2/4 falling. */
+	regmap_update_bits(priv->regmap, TIM_CCER, pwm->hwpwm < 2 ?
+			   TIM_CCER_CC12P : TIM_CCER_CC34P, pwm->hwpwm < 2 ?
+			   TIM_CCER_CC2P : TIM_CCER_CC4P);
+
+	ret = stm32_pwm_do_capture(priv, pwm, tmo_ms);
+	if (ret)
+		goto stop;
+
+	raw_prd = priv->capture[0];
+	raw_dty = priv->capture[1];
+
+	prd = (unsigned long long)raw_prd * (psc + 1) * NSEC_PER_SEC;
+	result->period = DIV_ROUND_UP_ULL(prd, rate);
+	dty = (unsigned long long)raw_dty * (psc + 1) * NSEC_PER_SEC;
+	result->duty_cycle = DIV_ROUND_UP_ULL(dty, rate);
+stop:
+	regmap_write(priv->regmap, TIM_CCER, 0);
+	regmap_write(priv->regmap, pwm->hwpwm < 2 ? TIM_CCMR1 : TIM_CCMR2, 0);
+	regmap_write(priv->regmap, TIM_PSC, 0);
+clk_dis:
+	clk_disable(priv->clk);
+unlock:
+	mutex_unlock(&priv->lock);
+
+	return ret;
+}
+
 static int stm32_pwm_config(struct stm32_pwm *priv, int ch,
 			    int duty_ns, int period_ns)
 {
@@ -231,6 +495,9 @@ static int stm32_pwm_apply_locked(struct pwm_chip *chip, struct pwm_device *pwm,
 static const struct pwm_ops stm32pwm_ops = {
 	.owner = THIS_MODULE,
 	.apply = stm32_pwm_apply_locked,
+#if IS_ENABLED(CONFIG_DMA_ENGINE)
+	.capture = stm32_pwm_capture,
+#endif
 };
 
 static int stm32_pwm_set_breakinput(struct stm32_pwm *priv,
@@ -344,23 +611,40 @@ static int stm32_pwm_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct stm32_timers *ddata = dev_get_drvdata(pdev->dev.parent);
 	struct stm32_pwm *priv;
-	int ret;
+	bool dma = false;
+	int i, ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
 	mutex_init(&priv->lock);
+	init_completion(&priv->completion);
 	priv->regmap = ddata->regmap;
+	priv->phys_base = ddata->phys_base;
 	priv->clk = ddata->clk;
 	priv->max_arr = ddata->max_arr;
 
 	if (!priv->regmap || !priv->clk)
 		return -EINVAL;
 
+	for (i = 0; i < STM32_TIMERS_MAX_DMAS; i++) {
+		priv->dmas[i] = ddata->dmas[i];
+		if (priv->dmas[i])
+			dma = true;
+	}
+
+	if (dma) {
+		priv->dma_buf = dma_alloc_coherent(dev->parent, PAGE_SIZE,
+						   &priv->dma_buf_phys,
+						   GFP_KERNEL);
+		if (!priv->dma_buf)
+			dev_dbg(dev, "can't allocate DMA buffer\n");
+	}
+
 	ret = stm32_pwm_apply_breakinputs(priv, np);
 	if (ret)
-		return ret;
+		goto dma_free;
 
 	stm32_pwm_detect_complementary(priv);
 
@@ -371,11 +655,18 @@ static int stm32_pwm_probe(struct platform_device *pdev)
 
 	ret = pwmchip_add(&priv->chip);
 	if (ret < 0)
-		return ret;
+		goto dma_free;
 
 	platform_set_drvdata(pdev, priv);
 
 	return 0;
+
+dma_free:
+	if (priv->dma_buf)
+		dma_free_coherent(priv->chip.dev, PAGE_SIZE,
+				  priv->dma_buf, priv->dma_buf_phys);
+
+	return ret;
 }
 
 static int stm32_pwm_remove(struct platform_device *pdev)
@@ -388,6 +679,10 @@ static int stm32_pwm_remove(struct platform_device *pdev)
 
 	pwmchip_remove(&priv->chip);
 
+	if (priv->dma_buf)
+		dma_free_coherent(priv->chip.dev, PAGE_SIZE,
+				  priv->dma_buf, priv->dma_buf_phys);
+
 	return 0;
 }
 
diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
index 2b4ffb9..219eccc 100644
--- a/include/linux/mfd/stm32-timers.h
+++ b/include/linux/mfd/stm32-timers.h
@@ -30,6 +30,8 @@
 #define TIM_CCR3	0x3C	/* Capt/Comp Register 3    */
 #define TIM_CCR4	0x40	/* Capt/Comp Register 4    */
 #define TIM_BDTR	0x44	/* Break and Dead-Time Reg */
+#define TIM_DCR		0x48	/* DMA control register    */
+#define TIM_DMAR	0x4C	/* DMA register for transfer */
 
 #define TIM_CR1_CEN	BIT(0)	/* Counter Enable	   */
 #define TIM_CR1_DIR	BIT(4)  /* Counter Direction	   */
@@ -39,17 +41,31 @@
 #define TIM_SMCR_SMS	(BIT(0) | BIT(1) | BIT(2)) /* Slave mode selection */
 #define TIM_SMCR_TS	(BIT(4) | BIT(5) | BIT(6)) /* Trigger selection */
 #define TIM_DIER_UIE	BIT(0)	/* Update interrupt	   */
+#define TIM_DIER_CC1DE	BIT(9)  /* CC1 DMA request Enable  */
+#define TIM_DIER_CC3DE	BIT(11) /* CC3 DMA request Enable  */
+#define TIM_DIER_XDE	GENMASK(14, 8)
 #define TIM_SR_UIF	BIT(0)	/* Update interrupt flag   */
 #define TIM_EGR_UG	BIT(0)	/* Update Generation       */
 #define TIM_CCMR_PE	BIT(3)	/* Channel Preload Enable  */
 #define TIM_CCMR_M1	(BIT(6) | BIT(5))  /* Channel PWM Mode 1 */
+#define TIM_CCMR_CC1S		(BIT(0) | BIT(1)) /* Capture/compare 1 sel */
+#define TIM_CCMR_IC1PSC		GENMASK(3, 2)	/* Input capture 1 prescaler */
+#define TIM_CCMR_CC2S		(BIT(8) | BIT(9)) /* Capture/compare 2 sel */
+#define TIM_CCMR_IC2PSC		GENMASK(11, 10)	/* Input capture 2 prescaler */
+#define TIM_CCMR_CC1S_TI1	BIT(0)	/* IC1/IC3 selects TI1/TI3 */
+#define TIM_CCMR_CC1S_TI2	BIT(1)	/* IC1/IC3 selects TI2/TI4 */
+#define TIM_CCMR_CC2S_TI2	BIT(8)	/* IC2/IC4 selects TI2/TI4 */
+#define TIM_CCMR_CC2S_TI1	BIT(9)	/* IC2/IC4 selects TI1/TI3 */
 #define TIM_CCER_CC1E	BIT(0)	/* Capt/Comp 1  out Ena    */
 #define TIM_CCER_CC1P	BIT(1)	/* Capt/Comp 1  Polarity   */
 #define TIM_CCER_CC1NE	BIT(2)	/* Capt/Comp 1N out Ena    */
 #define TIM_CCER_CC1NP	BIT(3)	/* Capt/Comp 1N Polarity   */
 #define TIM_CCER_CC2E	BIT(4)	/* Capt/Comp 2  out Ena    */
+#define TIM_CCER_CC2P	BIT(5)	/* Capt/Comp 2  Polarity   */
 #define TIM_CCER_CC3E	BIT(8)	/* Capt/Comp 3  out Ena    */
+#define TIM_CCER_CC3P	BIT(9)	/* Capt/Comp 3  Polarity   */
 #define TIM_CCER_CC4E	BIT(12)	/* Capt/Comp 4  out Ena    */
+#define TIM_CCER_CC4P	BIT(13)	/* Capt/Comp 4  Polarity   */
 #define TIM_CCER_CCXE	(BIT(0) | BIT(4) | BIT(8) | BIT(12))
 #define TIM_BDTR_BKE	BIT(12) /* Break input enable	   */
 #define TIM_BDTR_BKP	BIT(13) /* Break input polarity	   */
-- 
1.9.1
