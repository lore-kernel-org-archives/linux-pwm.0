From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 09/11] pwm: sti: Add PWM Capture call-back
Date: Wed, 10 Feb 2016 13:02:26 +0000
Message-ID: <1455109348-32767-10-git-send-email-lee.jones@linaro.org>
References: <1455109348-32767-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:33877 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489AbcBJNEp (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 10 Feb 2016 08:04:45 -0500
Received: by mail-wm0-f42.google.com with SMTP id 128so25914220wmz.1
        for <linux-pwm@vger.kernel.org>; Wed, 10 Feb 2016 05:04:44 -0800 (PST)
In-Reply-To: <1455109348-32767-1-git-send-email-lee.jones@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, thierry.reding@gmail.com, linux-pwm@vger.kernel.org, ajitpal.singh@st.com
Cc: kernel@stlinux.com, maxime.coquelin@st.com, Lee Jones <lee.jones@linaro.org>

Once a PWM Capture has been initiated, the capture call
enables a rising edge detection IRQ, then waits.  Once each
of the 3 phase changes have been recorded the thread then
wakes.  The remaining part of the call carries out the
relevant calculations and passes back a formatted string to
the caller.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pwm/pwm-sti.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index 82a69e4..8de9b4a 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -309,7 +309,79 @@ static void sti_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	clear_bit(pwm->hwpwm, &pc->configured);
 }
 
+static int sti_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
+			   int channel, char *buf)
+{
+	struct sti_pwm_chip *pc = to_sti_pwmchip(chip);
+	struct sti_pwm_compat_data *cdata = pc->cdata;
+	struct sti_cpt_data *d = pc->cpt_data[channel];
+	struct device *dev = pc->dev;
+	unsigned int f, dc;
+	unsigned int high, low;
+	bool level;
+	int ret;
+
+	if (channel > cdata->cpt_num_chan - 1) {
+		dev_err(dev, "Channel %d is not valid\n", channel);
+		return -EINVAL;
+	}
+
+	mutex_lock(&d->lock);
+
+	/* Prepare capture measurement */
+	d->index = 0;
+	regmap_write(pc->regmap, PWM_CPT_EDGE(channel), CPT_EDGE_RISING);
+	regmap_field_write(pc->pwm_cpt_int_en, BIT(channel));
+	ret = wait_event_interruptible_timeout(d->wait, d->index > 1, HZ);
+
+	/*
+	 * In case we woke up for another reason than completion
+	 * make sure to disable the capture.
+	 */
+	regmap_write(pc->regmap, PWM_CPT_EDGE(channel), CPT_EDGE_DISABLED);
+
+	if (ret == -ERESTARTSYS)
+		goto out;
+
+	switch (d->index) {
+	case 0:
+	case 1:
+		/*
+		 * Getting here could mean :
+		 *  - input signal is constant of less than 1Hz
+		 *  - there is no input signal at all
+		 *
+		 * In such case the frequency is rounded down to 0
+		 * level of the supposed constant signal is reported
+		 * using duty cycle min and max values.
+		 */
+		level = gpio_get_value(d->gpio);
+
+		ret = sprintf(buf, "0:%u\n", level ? CPT_DC_MAX : 0);
+		break;
+	case 2:
+		/* We have evertying we need */
+		high = d->snapshot[1] - d->snapshot[0];
+		low  = d->snapshot[2] - d->snapshot[1];
+
+		/* Calculate frequency in Hz */
+		f = clk_get_rate(pc->cpt_clk) / (1 * (high + low));
+
+		/* Calculate the duty cycle */
+		dc = CPT_DC_MAX * high / (high + low);
+
+		ret = sprintf(buf, "%u:%u\n", f, dc);
+	default:
+		dev_err(dev, "Internal error\n");
+	}
+
+out:
+	mutex_unlock(&d->lock);
+	return ret;
+}
+
 static const struct pwm_ops sti_pwm_ops = {
+	.capture = sti_pwm_capture,
 	.config = sti_pwm_config,
 	.enable = sti_pwm_enable,
 	.disable = sti_pwm_disable,
-- 
1.9.1
