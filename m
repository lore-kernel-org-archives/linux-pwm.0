From: Bo Shen <voice.shen@atmel.com>
Subject: [PATCH] pwm: atmel-pwm: clock can not unprepare after successfully register
Date: Thu, 19 Dec 2013 11:42:22 +0800
Message-ID: <1387424542-5864-1-git-send-email-voice.shen@atmel.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:20966 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140Ab3LSDn2 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Dec 2013 22:43:28 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com
Cc: nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, alexandre.belloni@free-electrons.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Bo Shen <voice.shen@atmel.com>

When the PWM controller is registered successfully, the clock can not
unprepare, so fix it.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 drivers/pwm/pwm-atmel.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 657e90a..bf4144a 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -362,6 +362,8 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, atmel_pwm);
 
+	return ret;
+
 unprepare_clk:
 	clk_unprepare(atmel_pwm->clk);
 	return ret;
-- 
1.7.9.5

