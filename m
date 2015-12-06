From: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 6/6] pwm: lpc32xx: return ERANGE, if requested period is not supported
Date: Sun,  6 Dec 2015 13:32:02 +0200
Message-ID: <1449401522-22590-7-git-send-email-vz@mleia.com>
References: <1449401522-22590-1-git-send-email-vz@mleia.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1449401522-22590-1-git-send-email-vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Instead of silent acceptance of unsupported requested configuration
for PWM period and setting the boundary supported value, return
-ERANGE to a caller.

Duty period value equal to 0 or period is still accepted to allow
configuration by PWM sysfs interface, when it is set to 0 by default.

For reference this is a list of restrictions on period_ns == 1/freq:

  | PWM parent clock | parent clock divisor | max freq | min freq |
  +------------------+----------------------+----------+----------+
  |   HCLK == 13 MHz |      1 (min)         | 50.7 KHz | 198.3 Hz |
  |   HCLK == 13 MHz |     15 (max)         | 3.38 KHz | 13.22 Hz |
  |  RTC == 32.7 KHz |      1 (min)         |   128 Hz |   0.5 Hz |
  |  RTC == 32.7 KHz |     15 (max)         | 8.533 Hz | 0.033 Hz |

Note that PWM sysfs interface does not support setting of period more
than NSEC_PER_SEC / MAX_INT32 ~ 2 seconds, however this PWM controller
supports a period up to 30 seconds.

Signed-off-by: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
---
Changes from v1 to v2:
- none

 drivers/pwm/pwm-lpc32xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-lpc32xx.c b/drivers/pwm/pwm-lpc32xx.c
index 294a68f..4d470c1 100644
--- a/drivers/pwm/pwm-lpc32xx.c
+++ b/drivers/pwm/pwm-lpc32xx.c
@@ -41,9 +41,9 @@ static int lpc32xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	/* The highest acceptable divisor is 256, which is represented by 0 */
 	period_cycles = div64_u64(c * period_ns,
 			       (unsigned long long)NSEC_PER_SEC * 256);
-	if (!period_cycles)
-		period_cycles = 1;
-	if (period_cycles > 255)
+	if (!period_cycles || period_cycles > 256)
+		return -ERANGE;
+	if (period_cycles == 256)
 		period_cycles = 0;
 
 	/* Compute 256 x #duty/period value and care for corner cases */
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
