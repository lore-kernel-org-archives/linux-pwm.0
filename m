From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] mfd: stmpe: add the proper PWM resources
Date: Sun, 14 Feb 2016 14:07:07 +0100
Message-ID: <1455455227-16848-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:34793 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbcBNNHP (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sun, 14 Feb 2016 08:07:15 -0500
Received: by mail-lf0-f49.google.com with SMTP id j78so74954773lfb.1
        for <linux-pwm@vger.kernel.org>; Sun, 14 Feb 2016 05:07:14 -0800 (PST)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>

This adds the PWM resources to the STMPE MFD driver, so that
it can properly grab and use them.

Cc: linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog: split this patch off from the PWM driver and sent
separately. This can be merged separately too so we need no
criss-cross between MFD and PWM anymore, Lee: this one is for
you if it looks all right, excess newlines are gone too.
---
 drivers/mfd/stmpe.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
index 8222e374e4b1..fb8f9e8b75df 100644
--- a/drivers/mfd/stmpe.c
+++ b/drivers/mfd/stmpe.c
@@ -334,6 +334,31 @@ static const struct mfd_cell stmpe_keypad_cell = {
 };
 
 /*
+ * PWM (1601, 2401, 2403)
+ */
+static struct resource stmpe_pwm_resources[] = {
+	{
+		.name	= "PWM0",
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.name	= "PWM1",
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.name	= "PWM2",
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static const struct mfd_cell stmpe_pwm_cell = {
+	.name		= "stmpe-pwm",
+	.of_compatible  = "st,stmpe-pwm",
+	.resources	= stmpe_pwm_resources,
+	.num_resources	= ARRAY_SIZE(stmpe_pwm_resources),
+};
+
+/*
  * STMPE801
  */
 static const u8 stmpe801_regs[] = {
@@ -537,6 +562,11 @@ static struct stmpe_variant_block stmpe1601_blocks[] = {
 		.irq	= STMPE1601_IRQ_KEYPAD,
 		.block	= STMPE_BLOCK_KEYPAD,
 	},
+	{
+		.cell	= &stmpe_pwm_cell,
+		.irq	= STMPE1601_IRQ_PWM0,
+		.block	= STMPE_BLOCK_PWM,
+	},
 };
 
 /* supported autosleep timeout delay (in msecs) */
@@ -771,6 +801,11 @@ static struct stmpe_variant_block stmpe24xx_blocks[] = {
 		.irq	= STMPE24XX_IRQ_KEYPAD,
 		.block	= STMPE_BLOCK_KEYPAD,
 	},
+	{
+		.cell	= &stmpe_pwm_cell,
+		.irq	= STMPE24XX_IRQ_PWM0,
+		.block	= STMPE_BLOCK_PWM,
+	},
 };
 
 static int stmpe24xx_enable(struct stmpe *stmpe, unsigned int blocks,
-- 
2.4.3
