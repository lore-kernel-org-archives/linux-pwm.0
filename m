From: Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [PATCH v16 02/11] hwmon: pwm-fan: Use 64-bit division macro
Date: Tue,  2 Jun 2020 15:31:06 -0700
Message-ID: <f0a2b661910e5079f2ccf843350aa420f62fc027.1591136989.git.gurus@codeaurora.org>
References: <cover.1591136989.git.gurus@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <cover.1591136989.git.gurus@codeaurora.org>
In-Reply-To: <cover.1591136989.git.gurus@codeaurora.org>
References: <cover.1591136989.git.gurus@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, Guru Das Srinagesh <gurus@codeaurora.org>, Daniel Thompson <daniel.thompson@linaro.org>, Arnd Bergmann <arnd@arndb.de>, David Collins <collinsd@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Dan Carpenter <dan.carpenter@oracle.com>, Joe Perches <joe@perches.com>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-pwm@vger.kernel.org

Since the PWM framework is switching struct pwm_args.period's datatype
to u64, prepare for this transition by using DIV_ROUND_UP_ULL to handle
a 64-bit dividend.

Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pwm-fan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 30b7b3e..17bb642 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -447,7 +447,7 @@ static int pwm_fan_resume(struct device *dev)
 		return 0;
 
 	pwm_get_args(ctx->pwm, &pargs);
-	duty = DIV_ROUND_UP(ctx->pwm_value * (pargs.period - 1), MAX_PWM);
+	duty = DIV_ROUND_UP_ULL(ctx->pwm_value * (pargs.period - 1), MAX_PWM);
 	ret = pwm_config(ctx->pwm, duty, pargs.period);
 	if (ret)
 		return ret;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
