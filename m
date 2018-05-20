Return-Path: <festevam@gmail.com>
Return-Path: <festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] pwm: imx: Switch to SPDX identifier
Date: Sun, 20 May 2018 12:40:15 -0300
Message-Id: <1526830815-15644-1-git-send-email-festevam@gmail.com>
List-ID: <linux-pwm.vger.kernel.org>
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>

From: Fabio Estevam <fabio.estevam@nxp.com>

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/pwm/pwm-imx.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 08cbe81..6ddd6fd 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -1,12 +1,8 @@
-/*
- * simple driver for PWM (Pulse Width Modulator) controller
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Derived from pxa PWM driver by eric miao <eric.miao@marvell.com>
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// simple driver for PWM (Pulse Width Modulator) controller
+//
+// Derived from pxa PWM driver by eric miao <eric.miao@marvell.com>
 
 #include <linux/module.h>
 #include <linux/kernel.h>
-- 
2.7.4
