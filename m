From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH] pwm: atmel-hlcdc: add errata handling for sama5d4
Date: Fri, 20 Feb 2015 16:58:18 +0100
Message-ID: <1424447898-2791-1-git-send-email-nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, thierry.reding@gmail.com, linux-pwm@vger.kernel.org
Cc: Boris BREZILLON <boris.brezillon@free-electrons.com>, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nicolas Ferre <nicolas.ferre@atmel.com>
List-Id: linux-pwm@vger.kernel.org

sama5d4 SoC also has an errata on the HLCDC PWM. It is the same as the sama5d3
that is forbidding the use of div1 prescaler.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/pwm/pwm-atmel-hlcdc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index 522f7075bb1a..fa5feaba25a5 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -225,6 +225,10 @@ static const struct of_device_id atmel_hlcdc_dt_ids[] = {
 		.compatible = "atmel,sama5d3-hlcdc",
 		.data = &atmel_hlcdc_pwm_sama5d3_errata,
 	},
+	{
+		.compatible = "atmel,sama5d4-hlcdc",
+		.data = &atmel_hlcdc_pwm_sama5d3_errata,
+	},
 	{ /* sentinel */ },
 };
 
-- 
2.1.3
