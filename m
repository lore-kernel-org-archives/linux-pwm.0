Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37559 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfCDLMp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 4 Mar 2019 06:12:45 -0500
Received: by mail-wr1-f65.google.com with SMTP id w6so5065896wrs.4
        for <linux-pwm@vger.kernel.org>; Mon, 04 Mar 2019 03:12:44 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
Date: Mon,  4 Mar 2019 12:12:42 +0100
Message-Id: <20190304111242.6545-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: [PATCH] pwm: atmel: Remove useless symbolic definitions
To: Thierry Reding <thierry.reding@gmail.com>, Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: linux-pwm@vger.kernel.org

The values that these symbols define are only assigned to the per-SoC
structure where the context is clear, so there's no need for the extra
symbolic name.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/pwm/pwm-atmel.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index b1473ed55110..a9fd6f0d408c 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -48,14 +48,6 @@
 #define PWMV2_CPRD		0x0C
 #define PWMV2_CPRDUPD		0x10
 
-/* Max values for period and prescaler */
-
-/* Only the LSB 16 bits are significant. */
-#define PWM_MAXV1_PRD		0xFFFF
-/* All 32 bits are significant. */
-#define PWM_MAXV2_PRD		0xFFFFFFFF
-#define PRD_MAXV1_PRES		10
-
 struct atmel_pwm_registers {
 	u8 period;
 	u8 period_upd;
@@ -294,8 +286,8 @@ static const struct atmel_pwm_data atmel_sam9rl_pwm_data = {
 	},
 	.cfg = {
 		/* 16 bits to keep period and duty. */
-		.max_period	= PWM_MAXV1_PRD,
-		.max_pres	= PRD_MAXV1_PRES,
+		.max_period	= 0xffff,
+		.max_pres	= 10,
 	},
 };
 
@@ -308,8 +300,8 @@ static const struct atmel_pwm_data atmel_sama5_pwm_data = {
 	},
 	.cfg = {
 		/* 16 bits to keep period and duty. */
-		.max_period	= PWM_MAXV1_PRD,
-		.max_pres	= PRD_MAXV1_PRES,
+		.max_period	= 0xffff,
+		.max_pres	= 10,
 	},
 };
 
@@ -322,8 +314,8 @@ static const struct atmel_pwm_data mchp_sam9x60_pwm_data = {
 	},
 	.cfg = {
 		/* 32 bits to keep period and duty. */
-		.max_period	= PWM_MAXV2_PRD,
-		.max_pres	= PRD_MAXV1_PRES,
+		.max_period	= 0xffffffff,
+		.max_pres	= 10,
 	},
 };
 
-- 
2.20.1
