From: Shawn Guo <shawn.guo@freescale.com>
Subject: [PATCH] pwm: imx: set can_sleep flag for imx_pwm_v2
Date: Fri, 23 May 2014 13:48:34 +0800
Message-ID: <1400824114-27148-1-git-send-email-shawn.guo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bn1lp0141.outbound.protection.outlook.com ([207.46.163.141]:38179
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751944AbaEWFsq (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Fri, 23 May 2014 01:48:46 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Shawn Guo <shawn.guo@freescale.com>

The .config() hook of imx_pwm_data_v2 calls clk_get_rate() which might
sleep, so we need to set can_sleep flag on it.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 drivers/pwm/pwm-imx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index d797c7b84c3f..ab3809fb36a7 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -272,6 +272,9 @@ static int imx_pwm_probe(struct platform_device *pdev)
 	imx->config = data->config;
 	imx->set_enable = data->set_enable;
 
+	if (data == &imx_pwm_data_v2)
+		imx->chip.can_sleep = true;
+
 	ret = pwmchip_add(&imx->chip);
 	if (ret < 0)
 		return ret;
-- 
1.8.3.2

