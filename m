From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH] Revert "pwm: jz4740: Enhance precision in calculation of duty cycle"
Date: Fri, 10 Jul 2020 09:24:45 +0200
Message-ID: <9335b924318fb36a882d5b46e8e9f2a10bb24daa.1594365885.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-mips-owner@vger.kernel.org>
Sender: linux-mips-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>, Thierry Reding <thierry.reding@gmail.com>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, linux-mips@vger.kernel.org, tsbogend@alpha.franken.de, "H. Nikolaus Schaller" <hns@goldelico.com>, stable@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

This reverts commit a6030d71e62d3e0e270bf3b7fb48d32a636732db.

which was applied to v5.4.49. This ends in a compile issue:

  CC      drivers/pwm/pwm-jz4740.o - due to target missing
drivers/pwm/pwm-jz4740.c: In function 'jz4740_pwm_apply':
drivers/pwm/pwm-jz4740.c:111:28: error: 'rate' undeclared (first use in this function)
  tmp = (unsigned long long)rate * state->duty_cycle;
                            ^
drivers/pwm/pwm-jz4740.c:111:28: note: each undeclared identifier is reported only once for each function it appears in
make[4]: *** [drivers/pwm/pwm-jz4740.o] Error 1

v5.5 and later include the required additional patches to define
the rate variable.

Fixes: a6030d71e62d ("pwm: jz4740: Enhance precision in calculation of duty cycle")
Cc: stable@vger.kernel.org # v5.4.49
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/pwm/pwm-jz4740.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index d0f5c69930d0d9..9d78cc21cb1279 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -108,8 +108,8 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (prescaler == 6)
 		return -EINVAL;
 
-	tmp = (unsigned long long)rate * state->duty_cycle;
-	do_div(tmp, NSEC_PER_SEC);
+	tmp = (unsigned long long)period * state->duty_cycle;
+	do_div(tmp, state->period);
 	duty = period - tmp;
 
 	if (duty >= period)
-- 
2.26.2
