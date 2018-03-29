From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v4 4/9] pwm: pxa: populate PWM mode in of_xlate function
Date: Thu, 29 Mar 2018 14:10:30 +0300
Message-ID: <1522321835-6460-5-git-send-email-claudiu.beznea@microchip.com>
References: <1522321835-6460-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1522321835-6460-1-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, shc_work@mail.ru, robh+dt@kernel.org, mark.rutland@arm.com, corbet@lwn.net, nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Claudiu Beznea <claudiu.beznea@microchip.com>
List-Id: linux-pwm@vger.kernel.org

Populate PWM mode in of_xlate function to avoid pwm_apply_state() failure.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/pwm-pxa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index 4143a46684d2..4c88cb47d6ba 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -161,6 +161,7 @@ pxa_pwm_of_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
 		return pwm;
 
 	pwm->args.period = args->args[0];
+	pwm->args.mode = pwm_mode_get_valid(pc, pwm);
 
 	return pwm;
 }
-- 
2.7.4
