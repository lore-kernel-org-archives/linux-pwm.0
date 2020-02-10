From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 2/3] pwm: imx27: Don't disable clks at device remove time
Date: Mon, 10 Feb 2020 22:22:39 +0100
Message-ID: <20200210212240.25513-3-u.kleine-koenig@pengutronix.de>
References: <20200209213106.5067-1-u.kleine-koenig@pengutronix.de>
 <20200210212240.25513-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34323 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbgBJVXC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 10 Feb 2020 16:23:02 -0500
In-Reply-To: <20200210212240.25513-1-u.kleine-koenig@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org

The .remove() callback is not supposed to modify hardware state. This is
in the responsibility of the PWM consumer.

After the PWM was disabled the clks are off (apart from a bug that is
fixed in the next patch), so unbinding the driver either stops the PWM
(which it should not) or disables already disabled clks yielding
warnings from the clk core.

So just drop the call to disable the clocks. (Which BTW was also in the
wrong order because the call makes the PWM unfunctional and so should
have come only after pwmchip_remove().

Fixes: 9f4c8f9607c3 ("pwm: imx: Add ipg clock operation")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-imx27.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index e04ae566bbf9..fb142813d455 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -358,8 +358,6 @@ static int pwm_imx27_remove(struct platform_device *pdev)
 
 	imx = platform_get_drvdata(pdev);
 
-	pwm_imx27_clk_disable_unprepare(imx);
-
 	return pwmchip_remove(&imx->chip);
 }
 
-- 
2.24.0
