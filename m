Return-Path: <sachin.kamat@linaro.org>
Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] pwm: samsung: avoid setting manual update bit unnecessarily
Date: Wed, 30 Oct 2013 10:21:44 +0530
Message-Id: <1383108704-3297-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-pwm.vger.kernel.org>
To: linux-pwm@vger.kernel.org
Cc: thierry.reding@gmail.com, linux-samsung-soc@vger.kernel.org, tomasz.figa@gmail.com, sachin.kamat@linaro.org, Andrew Bresticker <abrestic@chromium.org>

From: Andrew Bresticker <abrestic@chromium.org>

When possible, avoid setting the manual update bit and starting/stopping
the PWM when adjusting the PWM as it causes noticable flickering when
setting the backlight brightness.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/pwm/pwm-samsung.c |   23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index b59639e..6d23eb3 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -34,6 +34,7 @@
 
 #define REG_TCNTB(chan)			(0x0c + ((chan) * 0xc))
 #define REG_TCMPB(chan)			(0x10 + ((chan) * 0xc))
+#define REG_TCNTO(chan)			(0x14 + ((chan) * 0xc))
 
 #define TCFG0_PRESCALER_MASK		0xff
 #define TCFG0_PRESCALER1_SHIFT		8
@@ -234,15 +235,29 @@ static int pwm_samsung_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct samsung_pwm_chip *our_chip = to_samsung_pwm_chip(chip);
 	unsigned int tcon_chan = to_tcon_channel(pwm->hwpwm);
 	unsigned long flags;
-	u32 tcon;
+	u32 tcon, tcnt, tcnt_o;
 
 	spin_lock_irqsave(&samsung_pwm_lock, flags);
 
 	tcon = readl(our_chip->base + REG_TCON);
+	tcnt = readl(our_chip->base + REG_TCNTB(pwm->hwpwm));
+	tcnt_o = readl(our_chip->base + REG_TCNTO(pwm->hwpwm));
 
-	tcon &= ~TCON_START(tcon_chan);
-	tcon |= TCON_MANUALUPDATE(tcon_chan);
-	writel(tcon, our_chip->base + REG_TCON);
+	/*
+	 * If we've got a big value stuck in the PWM we need to adjust it using
+	 * manualupdate.  The start bit needs to be off for that to work
+	 * properly so we only do this if strictly necessary since it can cause
+	 * the PWM to blink.
+	 *
+	 * We will also use manualupdate if we find that the autoreload bit
+	 * wasn't set previously since the very first time the timer is
+	 * configured we seem to need to kickstart the PWM.
+	 */
+	if ((tcnt_o > tcnt) || !(tcon & TCON_AUTORELOAD(tcon_chan))) {
+		tcon &= ~TCON_START(tcon_chan);
+		tcon |= TCON_MANUALUPDATE(tcon_chan);
+		writel(tcon, our_chip->base + REG_TCON);
+	}
 
 	tcon &= ~TCON_MANUALUPDATE(tcon_chan);
 	tcon |= TCON_START(tcon_chan) | TCON_AUTORELOAD(tcon_chan);
-- 
1.7.9.5
