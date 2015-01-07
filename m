From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Subject: [PATCH RESEND] pwm: samsung: Fix output race on disabling
Date: Wed,  7 Jan 2015 23:58:17 +0100
Message-ID: <1420671497-25270-1-git-send-email-sjoerd.simons@collabora.co.uk>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:39679 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbbAGW6V (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Jan 2015 17:58:21 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Ajay Kumar <ajaykumar.rs@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-samsung-soc@vger.kernel.org

When disabling the samsung PWM the output state remains at the level it
was in the end of a pwm cycle. In other words, calling pwm_disable when
at 100% duty will keep the output active, while at all other setting the
output will go/stay inactive. On top of that the samsung PWM settings are
double-buffered, which means the new settings only get applied at the
start of a new PWM cycle.

This results in a race if the PWM is at 100% duty and a driver calls:
  pwm_config (pwm, 0, period);
  pwm_disable (pwm);

In this case the PWMs output will unexpectedly stay active, unless a new
PWM cycle happened to start between the register writes in _config and
_disable. As far as i can tell this is a regression introduced by 3bdf878,
before that a call to pwm_config would call pwm_samsung_enable which,
while heavy-handed, made sure the expected settings were live.

To resolve this, while not re-introducing the issues 3bdf878 (flickering
as the PWM got reset while in a PWM cycle). Only force an update of the
settings when at 100% duty, which shouldn't have a noticeable effect on
the output but is enough to ensure the behaviour is as expected on
disable.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
---
 drivers/pwm/pwm-samsung.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index 3e9b583..3e252dc 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -335,6 +335,27 @@ static int pwm_samsung_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	writel(tcnt, our_chip->base + REG_TCNTB(pwm->hwpwm));
 	writel(tcmp, our_chip->base + REG_TCMPB(pwm->hwpwm));
 
+	/* In case the PWM is currently at 100% duty, trigger a manual update to
+	 * prevent unexpected results when disabling the pwm */
+	if (chan->period_ns/chan->tin_ns == chan->duty_ns/chan->tin_ns) {
+		unsigned int tcon_chan = to_tcon_channel(pwm->hwpwm);
+		u32 tcon;
+		unsigned long flags;
+
+		dev_dbg(our_chip->chip.dev, "Forcing manual update");
+
+		spin_lock_irqsave(&samsung_pwm_lock, flags);
+
+		tcon = readl(our_chip->base + REG_TCON);
+		tcon |= TCON_MANUALUPDATE(tcon_chan);
+		writel(tcon, our_chip->base + REG_TCON);
+
+		tcon &= ~TCON_MANUALUPDATE(tcon_chan);
+		writel(tcon, our_chip->base + REG_TCON);
+
+		spin_unlock_irqrestore(&samsung_pwm_lock, flags);
+	}
+
 	chan->period_ns = period_ns;
 	chan->tin_ns = tin_ns;
 	chan->duty_ns = duty_ns;
-- 
2.1.4

