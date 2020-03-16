From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/3] pwm: renesas-tpu: Drop confusing registered message
Date: Mon, 16 Mar 2020 11:32:16 +0100
Message-ID: <20200316103216.29383-4-geert+renesas@glider.be>
References: <20200316103216.29383-1-geert+renesas@glider.be>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from andre.telenet-ops.be ([195.130.132.53]:54974 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730630AbgCPKcU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Mar 2020 06:32:20 -0400
In-Reply-To: <20200316103216.29383-1-geert+renesas@glider.be>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

During device probe, the message

    TPU PWM -1 registered

is printed.

While the "-1" looks suspicious, it is perfectly normal for a device
instantiated from DT.

Remove the message, as there are no non-DT users left, and other drivers
don't print such messages neither.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pwm/pwm-renesas-tpu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index 8032acc84161a9dd..81ad5a551455e4b8 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -424,8 +424,6 @@ static int tpu_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	dev_info(&pdev->dev, "TPU PWM %d registered\n", tpu->pdev->id);
-
 	return 0;
 }
 
-- 
2.17.1
