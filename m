Return-path: <kernel-bounces@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 3/4] pwm: rearrange structures to group members by purpose
Date: Mon,  7 Jan 2019 20:49:41 +0100
Message-Id: <20190107194938.3004-4-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20190107194938.3004-1-u.kleine-koenig@pengutronix.de>
References: <20190107194938.3004-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>

In pwm_ops there are a few callbacks that are not supposed to be used by
new drivers. Group them at the end of the structure and add a comment.

Similarily for struct pwm_chip group the members that drivers shouldn't
care about at the end and mark them as internal with another comment.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 include/linux/pwm.h | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 2730725f6d88..cc6ba326cc7a 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -242,11 +242,7 @@ pwm_set_relative_duty_cycle(struct pwm_state *state, unsigned int duty_cycle,
  * struct pwm_ops - PWM controller operations
  * @request: optional hook for requesting a PWM
  * @free: optional hook for freeing a PWM
- * @config: configure duty cycles and period length for this PWM
- * @set_polarity: configure the polarity of this PWM
  * @capture: capture and report PWM signal
- * @enable: enable PWM output toggling
- * @disable: disable PWM output toggling
  * @apply: atomically apply a new PWM config. The state argument
  *	   should be adjusted with the real hardware config (if the
  *	   approximate the period or duty_cycle value, state should
@@ -256,48 +252,55 @@ pwm_set_relative_duty_cycle(struct pwm_state *state, unsigned int duty_cycle,
  *	       registered.
  * @dbg_show: optional routine to show contents in debugfs
  * @owner: helps prevent removal of modules exporting active PWMs
+ * @config: configure duty cycles and period length for this PWM
+ * @set_polarity: configure the polarity of this PWM
+ * @enable: enable PWM output toggling
+ * @disable: disable PWM output toggling
  */
 struct pwm_ops {
 	int (*request)(struct pwm_chip *chip, struct pwm_device *pwm);
 	void (*free)(struct pwm_chip *chip, struct pwm_device *pwm);
-	int (*config)(struct pwm_chip *chip, struct pwm_device *pwm,
-		      int duty_ns, int period_ns);
-	int (*set_polarity)(struct pwm_chip *chip, struct pwm_device *pwm,
-			    enum pwm_polarity polarity);
 	int (*capture)(struct pwm_chip *chip, struct pwm_device *pwm,
 		       struct pwm_capture *result, unsigned long timeout);
-	int (*enable)(struct pwm_chip *chip, struct pwm_device *pwm);
-	void (*disable)(struct pwm_chip *chip, struct pwm_device *pwm);
 	int (*apply)(struct pwm_chip *chip, struct pwm_device *pwm,
 		     struct pwm_state *state);
 	void (*get_state)(struct pwm_chip *chip, struct pwm_device *pwm,
 			  struct pwm_state *state);
 	struct module *owner;
+
+	/* Only used by legacy drivers */
+	int (*config)(struct pwm_chip *chip, struct pwm_device *pwm,
+		      int duty_ns, int period_ns);
+	int (*set_polarity)(struct pwm_chip *chip, struct pwm_device *pwm,
+			    enum pwm_polarity polarity);
+	int (*enable)(struct pwm_chip *chip, struct pwm_device *pwm);
+	void (*disable)(struct pwm_chip *chip, struct pwm_device *pwm);
 };
 
 /**
  * struct pwm_chip - abstract a PWM controller
  * @dev: device providing the PWMs
- * @list: list node for internal use
  * @ops: callbacks for this PWM controller
  * @base: number of first PWM controlled by this chip
  * @npwm: number of PWMs controlled by this chip
- * @pwms: array of PWM devices allocated by the framework
  * @of_xlate: request a PWM device given a device tree PWM specifier
  * @of_pwm_n_cells: number of cells expected in the device tree PWM specifier
+ * @list: list node for internal use
+ * @pwms: array of PWM devices allocated by the framework
  */
 struct pwm_chip {
 	struct device *dev;
-	struct list_head list;
 	const struct pwm_ops *ops;
 	int base;
 	unsigned int npwm;
 
-	struct pwm_device *pwms;
-
 	struct pwm_device * (*of_xlate)(struct pwm_chip *pc,
 					const struct of_phandle_args *args);
 	unsigned int of_pwm_n_cells;
+
+	/* only used internally by the PWM framework */
+	struct list_head list;
+	struct pwm_device *pwms;
 };
 
 /**
-- 
2.20.1
