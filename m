From: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] Replace HTTP links with HTTPS ones: PWM SUBSYSTEM
Date: Wed,  8 Jul 2020 19:59:24 +0200
Message-ID: <20200708175924.15554-1-grandmaster@al2klimov.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgGHR7h (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 8 Jul 2020 13:59:37 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, lee.jones@linaro.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.
 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
 (Actually letting a shell for loop submit all this stuff for me.)

 If there are any URLs to be removed completely or at least not HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.


 drivers/pwm/pwm-omap-dmtimer.c | 2 +-
 drivers/pwm/pwm-tiecap.c       | 2 +-
 drivers/pwm/pwm-tiehrpwm.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 0d31833db2e2..344c78f72051 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -14,7 +14,7 @@
  *   with a timer counter that goes up. When it overflows it gets
  *   reloaded with the load value and the pwm output goes up.
  *   When counter matches with match register, the output goes down.
- *   Reference Manual: http://www.ti.com/lit/ug/spruh73q/spruh73q.pdf
+ *   Reference Manual: https://www.ti.com/lit/ug/spruh73q/spruh73q.pdf
  *
  * Limitations:
  * - When PWM is stopped, timer counter gets stopped immediately. This
diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index ab38c8203b79..683804c7d26c 100644
--- a/drivers/pwm/pwm-tiecap.c
+++ b/drivers/pwm/pwm-tiecap.c
@@ -2,7 +2,7 @@
 /*
  * ECAP PWM driver
  *
- * Copyright (C) 2012 Texas Instruments, Inc. - http://www.ti.com/
+ * Copyright (C) 2012 Texas Instruments, Inc. - https://www.ti.com/
  */
 
 #include <linux/module.h>
diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 7b4c770ce9d6..0846917ff2d2 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -2,7 +2,7 @@
 /*
  * EHRPWM PWM driver
  *
- * Copyright (C) 2012 Texas Instruments, Inc. - http://www.ti.com/
+ * Copyright (C) 2012 Texas Instruments, Inc. - https://www.ti.com/
  */
 
 #include <linux/module.h>
-- 
2.27.0
