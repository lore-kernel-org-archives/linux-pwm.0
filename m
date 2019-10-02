From: Colin King <colin.king@canonical.com>
Subject: [PATCH] pwm: sun4i: redundant assignment to variable pval
Date: Wed,  2 Oct 2019 11:08:44 +0100
Message-ID: <20191002100844.10490-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable pval is being assigned a value that is never read. The
assignment is redundant and hence can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/pwm/pwm-sun4i.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 6f5840a1a82d..53970d4ba695 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -156,7 +156,6 @@ static int sun4i_pwm_calculate(struct sun4i_pwm_chip *sun4i_pwm,
 	if (sun4i_pwm->data->has_prescaler_bypass) {
 		/* First, test without any prescaler when available */
 		prescaler = PWM_PRESCAL_MASK;
-		pval = 1;
 		/*
 		 * When not using any prescaler, the clock period in nanoseconds
 		 * is not an integer so round it half up instead of
-- 
2.20.1
