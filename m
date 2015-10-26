From: Olliver Schinagl <o.schinagl@ultimaker.com>
Subject: [PATCH 09/10] pwm: pwm_gpio: add pulse option
Date: Mon, 26 Oct 2015 22:32:40 +0100
Message-ID: <1445895161-2317-10-git-send-email-o.schinagl@ultimaker.com>
References: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Olliver Schinagl <oliver@schinagl.nl>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Joachim Eastwood <manabian@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Olliver Schinagl <oliver+list@schinagl.nl>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

From: Olliver Schinagl <oliver@schinagl.nl>

With the newly added pwm_pulse option added to the PWM framework, this
patch adds the pulse functionality to the gpio_pwm driver.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
---
 drivers/pwm/pwm-gpio.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/pwm/pwm-gpio.c b/drivers/pwm/pwm-gpio.c
index cf4b170..24c27b1 100644
--- a/drivers/pwm/pwm-gpio.c
+++ b/drivers/pwm/pwm-gpio.c
@@ -40,6 +40,8 @@ struct gpio_pwm_data {
 	bool pin_on;
 	int on_time;
 	int off_time;
+	unsigned int count;
+	bool pulse;
 	bool run;
 };
 
@@ -80,6 +82,16 @@ enum hrtimer_restart gpio_pwm_timer(struct hrtimer *timer)
 		gpio_data->pin_on = false;
 	}
 
+	if (gpio_data->count > 0)
+		gpio_data->count--;
+	if (!gpio_data->count && gpio_data->pulse) {
+		struct pwm_device *pwm = container_of((void *)gpio_data,
+						      struct pwm_device,
+						      chip_data);
+		pwm_pulse_done(pwm);
+		return HRTIMER_NORESTART;
+	}
+
 	return HRTIMER_RESTART;
 }
 
@@ -88,6 +100,10 @@ static int gpio_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct gpio_pwm_data *gpio_data = pwm_get_chip_data(pwm);
 
+	/* A full pulse is both the on and off time, and since counting each
+	 * iteration of the timer is easy and clean, we need double the count.
+	 */
+	gpio_data->count = count * 2;
 	gpio_data->on_time = duty_ns;
 	gpio_data->off_time = period_ns - duty_ns;
 
@@ -111,6 +127,9 @@ static int gpio_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	if (gpio_data->run)
 		return -EBUSY;
 
+	if (pwm->pulse_count)
+		gpio_data->pulse = true;
+	gpio_data->count = pwm->pulse_count;
 	gpio_data->run = true;
 	if (gpio_data->off_time) {
 		hrtimer_start(&gpio_data->timer, ktime_set(0, 0),
@@ -130,6 +149,7 @@ static void gpio_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct gpio_pwm_data *gpio_data = pwm_get_chip_data(pwm);
 
 	gpio_data->run = false;
+	gpio_data->pulse = false;
 	if (!gpio_data->off_time)
 		gpio_pwm_off(gpio_data);
 }
@@ -196,6 +216,8 @@ static int gpio_pwm_probe(struct platform_device *pdev)
 		gpio_data->timer.function = &gpio_pwm_timer;
 		gpio_data->gpiod = gpiod;
 		gpio_data->pin_on = false;
+		gpio_data->count = 0;
+		gpio_data->pulse = false;
 		gpio_data->run = false;
 
 		if (hrtimer_is_hres_active(&gpio_data->timer))
-- 
2.6.1
