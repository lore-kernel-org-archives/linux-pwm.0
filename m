From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v11 15/27] pwm: jz4740: Allow selection of PWM channels 0 and 1
Date: Thu, 28 Mar 2019 00:16:19 +0100
Message-ID: <20190327231631.15708-16-paul@crapouillou.net>
References: <20190327231631.15708-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327231631.15708-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Mathieu Malaterre <malat@debian.org>, od@zcrc.me, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-pwm@vger.kernel.org

The TCU channels 0 and 1 were previously reserved for system tasks, and
thus unavailable for PWM.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---
 drivers/pwm/pwm-jz4740.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index b55ee879e23d..c874a387c1d9 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -42,11 +42,7 @@ static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	char clk_name[16];
 	int ret;
 
-	/*
-	 * Timers 0 and 1 are used for system tasks, so they are unavailable
-	 * for use as PWMs.
-	 */
-	if (pwm->hwpwm < 2)
+	if (!ingenic_tcu_pwm_can_use_chn(chip->dev, pwm->hwpwm))
 		return -EBUSY;
 
 	snprintf(clk_name, sizeof(clk_name), "timer%u", pwm->hwpwm);
-- 
2.11.0
