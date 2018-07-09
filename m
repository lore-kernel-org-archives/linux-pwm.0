Return-Path: <festevam@gmail.com>
Return-Path: <festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] pwm: mxs: Switch to SPDX identifier
Date: Mon,  9 Jul 2018 14:55:58 -0300
Message-Id: <1531158958-11053-1-git-send-email-festevam@gmail.com>
List-ID: <linux-pwm.vger.kernel.org>
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>

From: Fabio Estevam <fabio.estevam@nxp.com>

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/pwm/pwm-mxs.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
index a6017ad..04c0f6b 100644
--- a/drivers/pwm/pwm-mxs.c
+++ b/drivers/pwm/pwm-mxs.c
@@ -1,12 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright 2012 Freescale Semiconductor, Inc.
- *
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
  */
 
 #include <linux/clk.h>
-- 
2.7.4
