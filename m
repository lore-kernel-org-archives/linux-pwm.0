From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 13/17] pwm: bcm2835: Switch to SPDX identifier
Date: Sat, 10 Nov 2018 17:22:58 +0100
Message-ID: <1541866978-7943-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Anholt <eric@anholt.net>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>, Bart Tanghe <bart.tanghe@thomasmore.be>
List-Id: linux-pwm@vger.kernel.org

Adopt the SPDX license identifier headers to ease license compliance
management.

Cc: Bart Tanghe <bart.tanghe@thomasmore.be>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/pwm/pwm-bcm2835.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index db001cb..5652f46 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -1,9 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright 2014 Bart Tanghe <bart.tanghe@thomasmore.be>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2.
  */
 
 #include <linux/clk.h>
-- 
2.7.4
