From: Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [PATCH v13 05/11] pwm: pwm-imx-tpm: Use 64-bit division macro
Date: Tue, 21 Apr 2020 19:57:17 -0700
Message-ID: <1ccedbe1aa8978348a2867a5037486b6c130a566.1587523702.git.gurus@codeaurora.org>
References: <cover.1587523702.git.gurus@codeaurora.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:9502 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726476AbgDVC53 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 21 Apr 2020 22:57:29 -0400
In-Reply-To: <cover.1587523702.git.gurus@codeaurora.org>
In-Reply-To: <cover.1587523702.git.gurus@codeaurora.org>
References: <cover.1587523702.git.gurus@codeaurora.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, David Collins <collinsd@codeaurora.org>, linux-kernel@vger.kernel.org, Guru Das Srinagesh <gurus@codeaurora.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>

Since the PWM framework is switching struct pwm_state.period's datatype
to u64, prepare for this transition by using DIV64_U64_ROUND_CLOSEST to
handle a 64-bit divisor.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>

Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
---
 drivers/pwm/pwm-imx-tpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index 5f3d7f7..fcdf6be 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -124,7 +124,7 @@ static int pwm_imx_tpm_round_state(struct pwm_chip *chip,
 		real_state->duty_cycle = state->duty_cycle;
 
 	tmp = (u64)p->mod * real_state->duty_cycle;
-	p->val = DIV_ROUND_CLOSEST_ULL(tmp, real_state->period);
+	p->val = DIV64_U64_ROUND_CLOSEST(tmp, real_state->period);
 
 	real_state->polarity = state->polarity;
 	real_state->enabled = state->enabled;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
