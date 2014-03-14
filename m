From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 2/2] PWM: atmel: correct CDTY calculation
Date: Fri, 14 Mar 2014 15:19:09 +0100
Message-ID: <1394806749-29778-3-git-send-email-alexandre.belloni@free-electrons.com>
References: <1394806749-29778-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1394806749-29778-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Bo Shen <voice.shen@atmel.com>, linux-pwm@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-pwm@vger.kernel.org

From the datasheet, the actual duty cycle is:
(period - (1/clk) * CDTY)/period

This actually correct the polarity of the PWM and solves the issue that pwm-leds
exhibits: when setting a duty cycle of 0 and then disabling a channel, the level
was wrong (1 when the polarity was normal and 0 when the polarity was inversed).

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/pwm/pwm-atmel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 2d69e9c431dd..0adc952cc4ef 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -133,7 +133,7 @@ static int atmel_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	prd = div;
 	div *= duty_ns;
 	do_div(div, period_ns);
-	dty = div;
+	dty = prd - div;
 
 	ret = clk_enable(atmel_pwm->clk);
 	if (ret) {
-- 
1.8.3.2
