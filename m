From: Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [RESEND PATCH v14 09/11] backlight: pwm_bl: Use 64-bit division function
Date: Tue, 12 May 2020 17:39:43 -0700
Message-ID: <24d6ba7dec636cdc67f089891ab8f830ba83d3ae.1589330178.git.gurus@codeaurora.org>
References: <cover.1589330178.git.gurus@codeaurora.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:62913 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731806AbgEMAjt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 12 May 2020 20:39:49 -0400
In-Reply-To: <cover.1589330178.git.gurus@codeaurora.org>
In-Reply-To: <cover.1589330178.git.gurus@codeaurora.org>
References: <cover.1589330178.git.gurus@codeaurora.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Subbaraman Narayanamurthy <subbaram@codeaurora.org>, David Collins <collinsd@codeaurora.org>, linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>, Stephen Boyd <sboyd@kernel.org>, Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Guenter Roeck <linux@roeck-us.net>, Daniel Thompson <daniel.thompson@linaro.org>, Dan Carpenter <dan.carpenter@oracle.com>, linux-arm-kernel@lists.infradead.org, Guru Das Srinagesh <gurus@codeaurora.org>

Since the PWM framework is switching struct pwm_state.period's datatype
to u64, prepare for this transition by using div_u64 to handle a 64-bit
dividend instead of a straight division operation.

Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/backlight/pwm_bl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 82b8d75..464baad 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -606,7 +606,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 		pb->scale = data->max_brightness;
 	}
 
-	pb->lth_brightness = data->lth_brightness * (state.period / pb->scale);
+	pb->lth_brightness = data->lth_brightness * (div_u64(state.period,
+				pb->scale));
 
 	props.type = BACKLIGHT_RAW;
 	props.max_brightness = data->max_brightness;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
