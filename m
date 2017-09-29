Return-Path: <jaho@arx-kt.lan>
Date: Fri, 29 Sep 2017 18:30:51 +0800
From: Hao Zhang <hao5781286@gmail.com>
Subject: [PATCH] pwm: There is a typo, fix it by modify curent to current.
Message-ID: <20170929103051.GA9134@arx-kt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-ID: <linux-pwm.vger.kernel.org>
To: thierry.reding@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, hao5781286@gmail.com

There is a typo, fix it by modify curent to current.

Signed-off-by: Hao Zhang <hao5781286@gmail.com>
---
 include/linux/pwm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 08fad7c..0ff9fbb 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -70,7 +70,7 @@ struct pwm_state {
  * @chip: PWM chip providing this PWM device
  * @chip_data: chip-private data associated with the PWM device
  * @args: PWM arguments
- * @state: curent PWM channel state
+ * @state: current PWM channel state
  */
 struct pwm_device {
 	const char *label;
-- 
2.7.4
