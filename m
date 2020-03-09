From: Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [PATCH v7 08/13] pwm: sifive: Use 64-bit division macros for period
 and duty cycle
Date: Mon,  9 Mar 2020 12:35:11 -0700
Message-ID: <4212f82b8711b2b33f0e71142526d5a7575564e9.1583782035.git.gurus@codeaurora.org>
References: <cover.1583782035.git.gurus@codeaurora.org>
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <cover.1583782035.git.gurus@codeaurora.org>
In-Reply-To: <cover.1583782035.git.gurus@codeaurora.org>
References: <cover.1583782035.git.gurus@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
To: linux-pwm@vger.kernel.org
Cc: Guru Das Srinagesh <gurus@codeaurora.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, linux-kernel@vger.kernel.org, Atish Patra <atish.patra@wdc.com>, Yash Shah <yash.shah@sifive.com>, Thierry Reding <thierry.reding@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, linux-riscv@lists.infradead.org
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

Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: linux-riscv@lists.infradead.org
Cc: Yash Shah <yash.shah@sifive.com>
Cc: Atish Patra <atish.patra@wdc.com>

Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
---
 drivers/pwm/pwm-sifive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index cc63f9b..62de0bb 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -181,7 +181,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * consecutively
 	 */
 	num = (u64)duty_cycle * (1U << PWM_SIFIVE_CMPWIDTH);
-	frac = DIV_ROUND_CLOSEST_ULL(num, state->period);
+	frac = DIV64_U64_ROUND_CLOSEST(num, state->period);
 	/* The hardware cannot generate a 100% duty cycle */
 	frac = min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
