From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 1/2] pwm/doc: Clearify that the pin state after pwm_disable is undefined
Date: Thu, 12 Feb 2015 10:44:49 +0100
Message-ID: <1423734290-19750-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1423734290-19750-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58640 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755409AbbBLJpL (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Feb 2015 04:45:11 -0500
In-Reply-To: <1423734290-19750-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, linux-leds@vger.kernel.org
Cc: kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>

This makes assumptions on the behaviour of the pwm API explicit.

Note that there are drivers that assume that pwm_disable does result in
a stable output matching the last pwm_config; leds-pwm is an example
that is fixed in a followup patch.

On arm/i.MX28 it can really happen that after

	pwm_config(led_dat->pwm, 0, 100);
	pwm_disable(led_dat->pwm);

the output is stuck at 1. That's because the pwm only works with the
newly configured config when a period is over for the previously
configured setting to prevent spikes.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 Documentation/pwm.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/pwm.txt b/Documentation/pwm.txt
index ca895fd211e4..abdd21d047ca 100644
--- a/Documentation/pwm.txt
+++ b/Documentation/pwm.txt
@@ -46,6 +46,11 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, =
int period_ns);
=20
 To start/stop toggling the PWM output use pwm_enable()/pwm_disable().
=20
+Note that after calling pwm_disable() it's undefined if the output sto=
ps in a
+high or low state, even if the duty cycle is set to 0% or 100%. So don=
't call
+pwm_disable() if there is a need for a specific level. The same applie=
s when
+pwm_enable() was called, but pwm_config() was not.
+
 Using PWMs with the sysfs interface
 -----------------------------------
=20
--=20
2.1.4

