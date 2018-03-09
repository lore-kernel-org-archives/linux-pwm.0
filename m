From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH] pwm: rcar: fix a condition to prevent mismatch value setting to duty
Date: Fri,  9 Mar 2018 20:24:21 +0900
Message-ID: <1520594661-6897-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: thierry.reding@gmail.com
Cc: ryo.kodama.vz@renesas.com, linux-pwm@vger.kernel.org, stable@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-pwm@vger.kernel.org

From: Ryo Kodama <ryo.kodama.vz@renesas.com>

This patch fixes an issue that is possible to set mismatch value
to duty for R-Car PWM if we input the following commands:

 # cd /sys/class/pwm/<pwmchip>/
 # echo 0 > export
 # cd pwm0
 # echo 30 > period
 # echo 30 > duty_cycle
 # echo 0 > duty_cycle
 # cat duty_cycle
 0
 # echo 1 > enable
 --> Then, the actual duty_cycle is 30, not 0.

So, this patch adds a condition into rcar_pwm_config() to fix
this issue.

Signed-off-by: Ryo Kodama <ryo.kodama.vz@renesas.com>
[shimoda: revise the commit log and add Fixes and Cc tags]
Fixes: ed6c1476bf7f ("pwm: Add support for R-Car PWM Timer")
Cc: Cc: <stable@vger.kernel.org> # v4.4+
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pwm/pwm-rcar.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 1c85ecc..0fcf94f 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -156,8 +156,12 @@ static int rcar_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (div < 0)
 		return div;
 
-	/* Let the core driver set pwm->period if disabled and duty_ns == 0 */
-	if (!pwm_is_enabled(pwm) && !duty_ns)
+	/*
+	 * Let the core driver set pwm->period if disabled and duty_ns == 0.
+	 * But, this driver should prevent to set the new duty_ns if current
+	 * duty_cycle is not set
+	 */
+	if (!pwm_is_enabled(pwm) && !duty_ns && !pwm->state.duty_cycle)
 		return 0;
 
 	rcar_pwm_update(rp, RCAR_PWMCR_SYNC, RCAR_PWMCR_SYNC, RCAR_PWMCR);
-- 
1.9.1
