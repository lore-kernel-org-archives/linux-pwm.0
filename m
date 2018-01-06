From: Paul Cercueil <paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org>
Subject: [PATCH 2/4] pwm: pwm-jz4740: Implement set_polarity
Date: Sat,  6 Jan 2018 17:58:41 +0100
Message-ID: <20180106165843.3461-2-paul@crapouillou.net>
References: <20180106165843.3461-1-paul@crapouillou.net>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180106165843.3461-1-paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Cercueil <paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

This permits clients of this driver to specify the polarity to use for
their PWM channel.

Signed-off-by: Paul Cercueil <paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org>
---
 drivers/pwm/pwm-jz4740.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 2e41ba213f39..6539c001fe32 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -130,10 +130,29 @@ static int jz4740_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	return 0;
 }
 
+static int jz4740_pwm_set_polarity(struct pwm_chip *chip,
+		struct pwm_device *pwm, enum pwm_polarity polarity)
+{
+	uint32_t ctrl = jz4740_timer_get_ctrl(pwm->pwm);
+
+	switch (polarity) {
+	case PWM_POLARITY_NORMAL:
+		ctrl &= ~JZ_TIMER_CTRL_PWM_ACTIVE_LOW;
+		break;
+	case PWM_POLARITY_INVERSED:
+		ctrl |= JZ_TIMER_CTRL_PWM_ACTIVE_LOW;
+		break;
+	}
+
+	jz4740_timer_set_ctrl(pwm->hwpwm, ctrl);
+	return 0;
+}
+
 static const struct pwm_ops jz4740_pwm_ops = {
 	.request = jz4740_pwm_request,
 	.free = jz4740_pwm_free,
 	.config = jz4740_pwm_config,
+	.set_polarity = jz4740_pwm_set_polarity,
 	.enable = jz4740_pwm_enable,
 	.disable = jz4740_pwm_disable,
 	.owner = THIS_MODULE,
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
