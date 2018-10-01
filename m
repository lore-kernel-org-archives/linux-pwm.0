From: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH 1/3] pwm: imx: Sort include files
Date: Mon,  1 Oct 2018 16:19:46 +0200
Message-ID: <1538403588-68850-1-git-send-email-michal.vokac@ysoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
List-Id: linux-pwm@vger.kernel.org

Sort included header files alphabetically.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 drivers/pwm/pwm-imx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 1d5242c..bcbcac4 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -5,17 +5,17 @@
  * Derived from pxa PWM driver by eric miao <eric.miao@marvell.com>
  */
 
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/err.h>
 #include <linux/io.h>
-#include <linux/pwm.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/slab.h>
 
 /* i.MX1 and i.MX21 share the same PWM function block: */
 
-- 
2.1.4
