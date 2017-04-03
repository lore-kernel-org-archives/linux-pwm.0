From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 1/3] pwm: pwm-samsung: remove redundant checks from
 pwm_samsung_config()
Date: Mon, 03 Apr 2017 15:47:04 +0200
Message-ID: <1491227226-12972-2-git-send-email-b.zolnierkie@samsung.com>
References: <1491227226-12972-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20170403134735epcas5p252798426964621f81114614c525f38ba@epcas5p2.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1491227226-12972-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Kamil Debski <kamil@wypas.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, linux-pwm@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pwm@vger.kernel.org

If the requested period_ns and duty_ns values are identical to
the last programmed ones pwm_samsung_config() returns early and
skips the hardware configuration. The same checks are now done
by the PWM core so the driver specific ones can be removed.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/pwm/pwm-samsung.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index f113cda..9ea7638 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -312,9 +312,6 @@ static int pwm_samsung_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (period_ns > NSEC_PER_SEC)
 		return -ERANGE;
 
-	if (period_ns == chan->period_ns && duty_ns == chan->duty_ns)
-		return 0;
-
 	tcnt = readl(our_chip->base + REG_TCNTB(pwm->hwpwm));
 	oldtcmp = readl(our_chip->base + REG_TCMPB(pwm->hwpwm));
 
-- 
1.9.1
