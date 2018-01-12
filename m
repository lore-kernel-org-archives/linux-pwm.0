From: Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: [PATCH v2 13/16] drivers: pwm: core: add push-pull mode support
Date: Fri, 12 Jan 2018 16:23:00 +0200
Message-ID: <1515766983-15151-14-git-send-email-claudiu.beznea@microchip.com>
References: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1515766983-15151-1-git-send-email-claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org, haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robert.jarzmik-GANU6spQydw@public.gmane.org, corbet-T1hC0tSOHrs@public.gmane.org, nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Add push-pull mode support in PWM code. In push-pull mode the channels
outputs has same polarity and the edges are complementary delayed for one
period.

Signed-off-by: Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
---
 drivers/pwm/sysfs.c | 2 ++
 include/linux/pwm.h | 9 +++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 7d111ab17e43..5052bdec7ad6 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -249,6 +249,8 @@ static ssize_t mode_store(struct device *child,
 		mode = PWM_MODE_NORMAL;
 	else if (sysfs_streq(buf, pwm_get_mode_desc(PWM_MODE_COMPLEMENTARY)))
 		mode = PWM_MODE_COMPLEMENTARY;
+	else if (sysfs_streq(buf, pwm_get_mode_desc(PWM_MODE_PUSH_PULL)))
+		mode = PWM_MODE_PUSH_PULL;
 	else
 		return -EINVAL;
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 2e8dfc3ea516..a4ad3b7a5317 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -29,13 +29,16 @@ enum pwm_polarity {
  * enum pwm_mode - PWM working modes
  * PWM_MODE_NORMAL: PWM has one output per channel
  * PWM_MODE_COMPLEMENTARY: PWM has 2 outputs per channel with opposite polarity
+ * PWM_MODE_PUSH_PULL: PWM has 2 outputs per channel with same polarity and
+ * the edges are complementary delayed for one period
  * PWM_MODE_MAX: Used to get the defined PWM modes mask (PWM_MODE_MAX - 1)
  * phase-shifted
  */
 enum pwm_mode {
 	PWM_MODE_NORMAL		= BIT(0),
 	PWM_MODE_COMPLEMENTARY	= BIT(1),
-	PWM_MODE_MAX		= BIT(2),
+	PWM_MODE_PUSH_PULL	= BIT(2),
+	PWM_MODE_MAX		= BIT(3),
 };
 
 /**
@@ -478,7 +481,9 @@ static inline void pwm_disable(struct pwm_device *pwm)
 
 static inline const char * const pwm_get_mode_desc(enum pwm_mode mode)
 {
-	static const char * const modes[] = { "normal", "complementary" };
+	static const char * const modes[] = {
+		"normal", "complementary", "push-pull"
+	};
 
 	return mode ? modes[ffs(mode) - 1] : "invalid";
 }
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
