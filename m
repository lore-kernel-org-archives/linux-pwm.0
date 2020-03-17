From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Subject: [RFC PATCH 5/7] pwm: replace polarity enum with macros
Date: Tue, 17 Mar 2020 14:32:29 +0200
Message-ID: <20200317123231.2843297-6-oleksandr.suvorov@toradex.com>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-pwm@vger.kernel.org
Cc: Paul Barker <pbarker@konsulko.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Igor Opaniuk <igor.opaniuk@toradex.com>, Philippe Schenker <philippe.schenker@toradex.com>, Oleksandr Suvorov <oleksandr.suvorov@toradex.com>, Alex Elder <elder@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Alexandre Torgue <alexandre.torgue@st.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Thompson <daniel.thompson@linaro.org>, Fabrice Gasnier <fabrice.gasnier@st.com>, Florian Fainelli <f.fainelli@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Jingoo Han <jingooh>
List-Id: linux-pwm@vger.kernel.org

To avoid duplication of pwm polarity definitions,
remove "enum pwm_polarity" and use macros instead.

Prepare to use both polarity flags in DTs.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
---

 drivers/pwm/core.c                  |  2 +-
 drivers/pwm/pwm-atmel-tcb.c         |  8 ++++----
 drivers/pwm/pwm-bcm-kona.c          |  2 +-
 drivers/pwm/pwm-bcm2835.c           |  2 +-
 drivers/pwm/pwm-berlin.c            |  2 +-
 drivers/pwm/pwm-ep93xx.c            |  2 +-
 drivers/pwm/pwm-hibvt.c             |  2 +-
 drivers/pwm/pwm-lpc18xx-sct.c       |  2 +-
 drivers/pwm/pwm-omap-dmtimer.c      |  2 +-
 drivers/pwm/pwm-renesas-tpu.c       |  4 ++--
 drivers/pwm/pwm-samsung.c           |  2 +-
 drivers/pwm/pwm-stm32.c             |  2 +-
 drivers/pwm/pwm-tiecap.c            |  2 +-
 drivers/pwm/pwm-tiehrpwm.c          |  4 ++--
 drivers/pwm/pwm-vt8500.c            |  2 +-
 drivers/pwm/sysfs.c                 |  2 +-
 drivers/staging/greybus/pwm.c       |  2 +-
 drivers/video/backlight/lp8788_bl.c |  2 +-
 include/linux/mfd/lp8788.h          |  2 +-
 include/linux/pwm.h                 | 29 ++++++++---------------------
 include/trace/events/pwm.h          |  2 +-
 21 files changed, 33 insertions(+), 46 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 08afbb5b98aa..2cb9db8d545b 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -257,7 +257,7 @@ static bool pwm_ops_check(const struct pwm_ops *ops)
  * Returns: 0 on success or a negative error code on failure.
  */
 int pwmchip_add_with_polarity(struct pwm_chip *chip,
-			      enum pwm_polarity polarity)
+			      unsigned int polarity)
 {
 	struct pwm_device *pwm;
 	unsigned int i;
diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index 98526a286347..9e8a0b4b1751 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -31,7 +31,7 @@
 				 ATMEL_TC_BEEVT | ATMEL_TC_BSWTRG)
 
 struct atmel_tcb_pwm_device {
-	enum pwm_polarity polarity;	/* PWM polarity */
+	unsigned int polarity;		/* PWM polarity */
 	unsigned div;			/* PWM clock divider */
 	unsigned duty;			/* PWM duty expressed in clk cycles */
 	unsigned period;		/* PWM period expressed in clk cycles */
@@ -60,7 +60,7 @@ static inline struct atmel_tcb_pwm_chip *to_tcb_chip(struct pwm_chip *chip)
 
 static int atmel_tcb_pwm_set_polarity(struct pwm_chip *chip,
 				      struct pwm_device *pwm,
-				      enum pwm_polarity polarity)
+				      unsigned int polarity)
 {
 	struct atmel_tcb_pwm_device *tcbpwm = pwm_get_chip_data(pwm);
 
@@ -147,7 +147,7 @@ static void atmel_tcb_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	unsigned group = pwm->hwpwm / 2;
 	unsigned index = pwm->hwpwm % 2;
 	unsigned cmr;
-	enum pwm_polarity polarity = tcbpwm->polarity;
+	unsigned int polarity = tcbpwm->polarity;
 
 	/*
 	 * If duty is 0 the timer will be stopped and we have to
@@ -206,7 +206,7 @@ static int atmel_tcb_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	unsigned group = pwm->hwpwm / 2;
 	unsigned index = pwm->hwpwm % 2;
 	u32 cmr;
-	enum pwm_polarity polarity = tcbpwm->polarity;
+	unsigned int polarity = tcbpwm->polarity;
 
 	/*
 	 * If duty is 0 the timer will be stopped and we have to
diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index 02da511814f1..83eab0cc51ce 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -174,7 +174,7 @@ static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
 }
 
 static int kona_pwmc_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
-				  enum pwm_polarity polarity)
+				  unsigned int polarity)
 {
 	struct kona_pwmc *kp = to_kona_pwmc(chip);
 	unsigned int chan = pwm->hwpwm;
diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index 91e24f01b54e..2110aef85f19 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -107,7 +107,7 @@ static void bcm2835_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 }
 
 static int bcm2835_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
-				enum pwm_polarity polarity)
+				unsigned int polarity)
 {
 	struct bcm2835_pwm *pc = to_bcm2835_pwm(chip);
 	u32 value;
diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
index b91c477cc84b..1a080bf33047 100644
--- a/drivers/pwm/pwm-berlin.c
+++ b/drivers/pwm/pwm-berlin.c
@@ -127,7 +127,7 @@ static int berlin_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm_dev,
 
 static int berlin_pwm_set_polarity(struct pwm_chip *chip,
 				   struct pwm_device *pwm_dev,
-				   enum pwm_polarity polarity)
+				   unsigned int polarity)
 {
 	struct berlin_pwm_chip *pwm = to_berlin_pwm_chip(chip);
 	u32 value;
diff --git a/drivers/pwm/pwm-ep93xx.c b/drivers/pwm/pwm-ep93xx.c
index 02345b6f9fe8..71897ad5f6a0 100644
--- a/drivers/pwm/pwm-ep93xx.c
+++ b/drivers/pwm/pwm-ep93xx.c
@@ -111,7 +111,7 @@ static int ep93xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 }
 
 static int ep93xx_pwm_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
-			       enum pwm_polarity polarity)
+			       unsigned int polarity)
 {
 	struct ep93xx_pwm *ep93xx_pwm = to_ep93xx_pwm(chip);
 	int ret;
diff --git a/drivers/pwm/pwm-hibvt.c b/drivers/pwm/pwm-hibvt.c
index c57a94e7da0f..7e39abce0c14 100644
--- a/drivers/pwm/pwm-hibvt.c
+++ b/drivers/pwm/pwm-hibvt.c
@@ -116,7 +116,7 @@ static void hibvt_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 static void hibvt_pwm_set_polarity(struct pwm_chip *chip,
 					struct pwm_device *pwm,
-					enum pwm_polarity polarity)
+					unsigned int polarity)
 {
 	struct hibvt_pwm_chip *hi_pwm_chip = to_hibvt_pwm_chip(chip);
 
diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index 5ff11145c1a3..3ebb7cca0204 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -225,7 +225,7 @@ static int lpc18xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 static int lpc18xx_pwm_set_polarity(struct pwm_chip *chip,
 				    struct pwm_device *pwm,
-				    enum pwm_polarity polarity)
+				    unsigned int polarity)
 {
 	return 0;
 }
diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 082ccec93133..ebbd1fe57d57 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -210,7 +210,7 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 
 static int pwm_omap_dmtimer_set_polarity(struct pwm_chip *chip,
 					 struct pwm_device *pwm,
-					 enum pwm_polarity polarity)
+					 unsigned int polarity)
 {
 	struct pwm_omap_dmtimer_chip *omap = to_pwm_omap_dmtimer_chip(chip);
 
diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index 32beeb93ade1..3c594cef2d5a 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -72,7 +72,7 @@ struct tpu_pwm_device {
 	struct tpu_device *tpu;
 	unsigned int channel;		/* Channel number in the TPU */
 
-	enum pwm_polarity polarity;
+	unsigned int polarity;
 	unsigned int prescaler;
 	u16 period;
 	u16 duty;
@@ -325,7 +325,7 @@ static int tpu_pwm_config(struct pwm_chip *chip, struct pwm_device *_pwm,
 }
 
 static int tpu_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *_pwm,
-				enum pwm_polarity polarity)
+				unsigned int polarity)
 {
 	struct tpu_pwm_device *pwm = pwm_get_chip_data(_pwm);
 
diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index 87a886f7dc2f..7bf4f76e25bc 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -413,7 +413,7 @@ static void pwm_samsung_set_invert(struct samsung_pwm_chip *chip,
 
 static int pwm_samsung_set_polarity(struct pwm_chip *chip,
 				    struct pwm_device *pwm,
-				    enum pwm_polarity polarity)
+				    unsigned int polarity)
 {
 	struct samsung_pwm_chip *our_chip = to_samsung_pwm_chip(chip);
 	bool invert = (polarity == PWM_POLARITY_NORMAL);
diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index d3be944f2ae9..a83ea66f36c9 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -383,7 +383,7 @@ static int stm32_pwm_config(struct stm32_pwm *priv, int ch,
 }
 
 static int stm32_pwm_set_polarity(struct stm32_pwm *priv, int ch,
-				  enum pwm_polarity polarity)
+				  unsigned int polarity)
 {
 	u32 mask;
 
diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index b96b388f0969..744144f83355 100644
--- a/drivers/pwm/pwm-tiecap.c
+++ b/drivers/pwm/pwm-tiecap.c
@@ -109,7 +109,7 @@ static int ecap_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 }
 
 static int ecap_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
-				 enum pwm_polarity polarity)
+				 unsigned int polarity)
 {
 	struct ecap_pwm_chip *pc = to_ecap_pwm_chip(chip);
 	u16 value;
diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 71c337443dd5..cde0231e835a 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -109,7 +109,7 @@ struct ehrpwm_pwm_chip {
 	unsigned long clk_rate;
 	void __iomem *mmio_base;
 	unsigned long period_cycles[NUM_PWM_CHANNEL];
-	enum pwm_polarity polarity[NUM_PWM_CHANNEL];
+	unsigned int polarity[NUM_PWM_CHANNEL];
 	struct clk *tbclk;
 	struct ehrpwm_context ctx;
 };
@@ -306,7 +306,7 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 static int ehrpwm_pwm_set_polarity(struct pwm_chip *chip,
 				   struct pwm_device *pwm,
-				   enum pwm_polarity polarity)
+				   unsigned int polarity)
 {
 	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
 
diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
index fc434965c5ed..076c9f207d64 100644
--- a/drivers/pwm/pwm-vt8500.c
+++ b/drivers/pwm/pwm-vt8500.c
@@ -158,7 +158,7 @@ static void vt8500_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 static int vt8500_pwm_set_polarity(struct pwm_chip *chip,
 				   struct pwm_device *pwm,
-				   enum pwm_polarity polarity)
+				   unsigned int polarity)
 {
 	struct vt8500_chip *vt8500 = to_vt8500_chip(chip);
 	u32 val;
diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 769ac09c56c2..7cf787ac5e23 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -180,7 +180,7 @@ static ssize_t polarity_store(struct device *child,
 {
 	struct pwm_export *export = child_to_pwm_export(child);
 	struct pwm_device *pwm = export->pwm;
-	enum pwm_polarity polarity;
+	unsigned int polarity;
 	struct pwm_state state;
 	int ret;
 
diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/pwm.c
index 891a6a672378..338c76c4be9b 100644
--- a/drivers/staging/greybus/pwm.c
+++ b/drivers/staging/greybus/pwm.c
@@ -213,7 +213,7 @@ static int gb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 };
 
 static int gb_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
-			       enum pwm_polarity polarity)
+			       unsigned int polarity)
 {
 	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
 
diff --git a/drivers/video/backlight/lp8788_bl.c b/drivers/video/backlight/lp8788_bl.c
index ba42f3fe0c73..a589d5e51865 100644
--- a/drivers/video/backlight/lp8788_bl.c
+++ b/drivers/video/backlight/lp8788_bl.c
@@ -37,7 +37,7 @@ struct lp8788_bl_config {
 	enum lp8788_bl_full_scale_current full_scale;
 	enum lp8788_bl_ramp_step rise_time;
 	enum lp8788_bl_ramp_step fall_time;
-	enum pwm_polarity pwm_pol;
+	unsigned int pwm_pol;
 };
 
 struct lp8788_bl {
diff --git a/include/linux/mfd/lp8788.h b/include/linux/mfd/lp8788.h
index 3d5c480d58ea..e0321aedf4c0 100644
--- a/include/linux/mfd/lp8788.h
+++ b/include/linux/mfd/lp8788.h
@@ -227,7 +227,7 @@ struct lp8788_backlight_platform_data {
 	enum lp8788_bl_full_scale_current full_scale;
 	enum lp8788_bl_ramp_step rise_time;
 	enum lp8788_bl_ramp_step fall_time;
-	enum pwm_polarity pwm_pol;
+	unsigned int pwm_pol;
 	unsigned int period_ns;
 };
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 38b7ed8ef913..c7b35f0602fa 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -5,26 +5,13 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <dt-bindings/pwm/pwm.h>
 
 struct pwm_capture;
 struct seq_file;
 
 struct pwm_chip;
 
-/**
- * enum pwm_polarity - polarity of a PWM signal
- * @PWM_POLARITY_NORMAL: a high signal for the duration of the duty-
- * cycle, followed by a low signal for the remainder of the pulse
- * period
- * @PWM_POLARITY_INVERTED: a low signal for the duration of the duty-
- * cycle, followed by a high signal for the remainder of the pulse
- * period
- */
-enum pwm_polarity {
-	PWM_POLARITY_NORMAL,
-	PWM_POLARITY_INVERTED,
-};
-
 /**
  * struct pwm_args - board-dependent PWM arguments
  * @period: reference period
@@ -40,7 +27,7 @@ enum pwm_polarity {
  */
 struct pwm_args {
 	unsigned int period;
-	enum pwm_polarity polarity;
+	unsigned int polarity;
 };
 
 enum {
@@ -58,7 +45,7 @@ enum {
 struct pwm_state {
 	unsigned int period;
 	unsigned int duty_cycle;
-	enum pwm_polarity polarity;
+	unsigned int polarity;
 	bool enabled;
 };
 
@@ -135,7 +122,7 @@ static inline unsigned int pwm_get_duty_cycle(const struct pwm_device *pwm)
 	return state.duty_cycle;
 }
 
-static inline enum pwm_polarity pwm_get_polarity(const struct pwm_device *pwm)
+static inline unsigned int pwm_get_polarity(const struct pwm_device *pwm)
 {
 	struct pwm_state state;
 
@@ -268,7 +255,7 @@ struct pwm_ops {
 	int (*config)(struct pwm_chip *chip, struct pwm_device *pwm,
 		      int duty_ns, int period_ns);
 	int (*set_polarity)(struct pwm_chip *chip, struct pwm_device *pwm,
-			    enum pwm_polarity polarity);
+			    unsigned int polarity);
 	int (*enable)(struct pwm_chip *chip, struct pwm_device *pwm);
 	void (*disable)(struct pwm_chip *chip, struct pwm_device *pwm);
 };
@@ -391,7 +378,7 @@ int pwm_set_chip_data(struct pwm_device *pwm, void *data);
 void *pwm_get_chip_data(struct pwm_device *pwm);
 
 int pwmchip_add_with_polarity(struct pwm_chip *chip,
-			      enum pwm_polarity polarity);
+			      unsigned int polarity);
 int pwmchip_add(struct pwm_chip *chip);
 int pwmchip_remove(struct pwm_chip *chip);
 struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
@@ -471,7 +458,7 @@ static inline int pwmchip_add(struct pwm_chip *chip)
 	return -EINVAL;
 }
 
-static inline int pwmchip_add_inversed(struct pwm_chip *chip)
+static inline int pwmchip_add_inverted(struct pwm_chip *chip)
 {
 	return -EINVAL;
 }
@@ -569,7 +556,7 @@ struct pwm_lookup {
 	const char *dev_id;
 	const char *con_id;
 	unsigned int period;
-	enum pwm_polarity polarity;
+	unsigned int polarity;
 	const char *module; /* optional, may be NULL */
 };
 
diff --git a/include/trace/events/pwm.h b/include/trace/events/pwm.h
index cf243de41cc8..e3f40ba2ab9c 100644
--- a/include/trace/events/pwm.h
+++ b/include/trace/events/pwm.h
@@ -18,7 +18,7 @@ DECLARE_EVENT_CLASS(pwm,
 		__field(struct pwm_device *, pwm)
 		__field(u64, period)
 		__field(u64, duty_cycle)
-		__field(enum pwm_polarity, polarity)
+		__field(unsigned int, polarity)
 		__field(bool, enabled)
 	),
 
-- 
2.24.1
