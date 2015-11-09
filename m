From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH] pwm: rcar: Improve accuracy of frequency division setting
Date: Mon, 9 Nov 2015 09:42:25 +0900
Message-ID: <1447029745-3648-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: thierry.reding@gmail.com
Cc: ryo.kodama.vz@renesas.com, linux-pwm@vger.kernel.org, linux-sh@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-pwm@vger.kernel.org

From: Ryo Kodama <ryo.kodama.vz@renesas.com>

From: Ryo Kodama <ryo.kodama.vz@renesas.com>

When period_ns is set to the same value of RCAR_PWM_MAX_CYCLE in
rcar_pwm_get_clock_division(), this function should allow such value
for improving accuracy of frequency division setting.

Signed-off-by: Ryo Kodama <ryo.kodama.vz@renesas.com>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pwm/pwm-rcar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 6e99a63..7b8ac06 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -81,7 +81,7 @@ static int rcar_pwm_get_clock_division(struct rcar_pwm_chip *rp, int period_ns)
 		max = (unsigned long long)NSEC_PER_SEC * RCAR_PWM_MAX_CYCLE *
 			(1 << div);
 		do_div(max, clk_rate);
-		if (period_ns < max)
+		if (period_ns <= max)
 			break;
 	}
 
-- 
1.9.1

