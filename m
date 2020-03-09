From: Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [PATCH v7 09/13] pwm: sti: Use 64-bit division macros for period and duty cycle
Date: Mon,  9 Mar 2020 12:35:12 -0700
Message-ID: <c3e233828023833744a69c75eb03f72885ee59d5.1583782035.git.gurus@codeaurora.org>
References: <cover.1583782035.git.gurus@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1583782035.git.gurus@codeaurora.org>
In-Reply-To: <cover.1583782035.git.gurus@codeaurora.org>
References: <cover.1583782035.git.gurus@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, linux-kernel@vger.kernel.org, Guru Das Srinagesh <gurus@codeaurora.org>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pwm@vger.kernel.org

Because period and duty cycle are defined in the PWM framework structs
as ints with units of nanoseconds, the maximum time duration that can be
set is limited to ~2.147 seconds. Redefining them as u64 values will
enable larger time durations to be set.

As a first step, prepare drivers to handle the switch to u64 period and
duty_cycle by replacing division operations involving pwm period and duty cycle
with their 64-bit equivalents as appropriate. The actual switch to u64 period
and duty_cycle follows as a separate patch.

Where the dividend is 64-bit but the divisor is 32-bit, use *_ULL
macros:
- DIV_ROUND_UP_ULL
- DIV_ROUND_CLOSEST_ULL
- div_u64

Where the divisor is 64-bit (dividend may be 32-bit or 64-bit), use
DIV64_* macros:
- DIV64_U64_ROUND_CLOSEST
- div64_u64

Cc: Lee Jones <lee.jones@linaro.org>

Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
---
 drivers/pwm/pwm-sti.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index 1508616..5a7f337 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -371,10 +371,11 @@ static int sti_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 		effective_ticks = clk_get_rate(pc->cpt_clk);
 
 		result->period = (high + low) * NSEC_PER_SEC;
-		result->period /= effective_ticks;
+		result->period = div_u64(result->period, effective_ticks);
 
 		result->duty_cycle = high * NSEC_PER_SEC;
-		result->duty_cycle /= effective_ticks;
+		result->duty_cycle = div_u64(result->duty_cycle,
+				effective_ticks);
 
 		break;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
