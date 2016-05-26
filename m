From: Brian Norris <briannorris@chromium.org>
Subject: [PATCH] pwm: don't allow duty cycle higher than period
Date: Thu, 26 May 2016 14:05:30 -0700
Message-ID: <1464296730-121773-1-git-send-email-briannorris@chromium.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33353 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755117AbcEZVFl (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 26 May 2016 17:05:41 -0400
Received: by mail-pf0-f170.google.com with SMTP id b124so34377105pfb.0
        for <linux-pwm@vger.kernel.org>; Thu, 26 May 2016 14:05:41 -0700 (PDT)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Doug Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>

It doesn't make sense to allow the duty cycle to be larger than the
period. I can see this behavior by, e.g.:

  # echo 1 > /sys/class/pwm/pwmchip0/export
  # cat /sys/class/pwm/pwmchip0/pwm1/period
  100
  # echo 101 > /sys/class/pwm/pwmchip0/pwm1/duty_cycle
  [... driver may or may not reject the value, or trigger some logic bug ...]

It's better to see:

  # echo 1 > /sys/class/pwm/pwmchip0/export
  # cat /sys/class/pwm/pwmchip0/pwm1/period
  100
  # echo 101 > /sys/class/pwm/pwmchip0/pwm1/duty_cycle
  -bash: echo: write error: Invalid argument

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/pwm/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index dba3843c53b8..9246b60f894a 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -463,6 +463,9 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
 	if (!memcmp(state, &pwm->state, sizeof(*state)))
 		return 0;
 
+	if (state->duty_cycle > state->period)
+		return -EINVAL;
+
 	if (pwm->chip->ops->apply) {
 		err = pwm->chip->ops->apply(pwm->chip, pwm, state);
 		if (err)
-- 
2.8.0.rc3.226.g39d4020
