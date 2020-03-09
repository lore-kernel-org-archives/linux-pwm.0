From: Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [PATCH v7 04/13] ir-rx51: Use 64-bit division macros for period and duty cycle
Date: Mon,  9 Mar 2020 12:35:07 -0700
Message-ID: <22ae6da55c914f9434fc7871a51524d03317646f.1583782035.git.gurus@codeaurora.org>
References: <cover.1583782035.git.gurus@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1583782035.git.gurus@codeaurora.org>
In-Reply-To: <cover.1583782035.git.gurus@codeaurora.org>
References: <cover.1583782035.git.gurus@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, linux-kernel@vger.kernel.org, Guru Das Srinagesh <gurus@codeaurora.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Richard Fontana <rfontana@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, Allison Randal <allison@lohutok.net>, linux-media@vger.kernel.org
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

Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Richard Fontana <rfontana@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Allison Randal <allison@lohutok.net>
Cc: linux-media@vger.kernel.org

Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
---
 drivers/media/rc/ir-rx51.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/rc/ir-rx51.c b/drivers/media/rc/ir-rx51.c
index 8574eda..9a5dfd7 100644
--- a/drivers/media/rc/ir-rx51.c
+++ b/drivers/media/rc/ir-rx51.c
@@ -241,7 +241,8 @@ static int ir_rx51_probe(struct platform_device *dev)
 	}
 
 	/* Use default, in case userspace does not set the carrier */
-	ir_rx51.freq = DIV_ROUND_CLOSEST(pwm_get_period(pwm), NSEC_PER_SEC);
+	ir_rx51.freq = DIV_ROUND_CLOSEST_ULL(pwm_get_period(pwm),
+			NSEC_PER_SEC);
 	pwm_put(pwm);
 
 	hrtimer_init(&ir_rx51.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
