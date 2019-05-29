Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relmlor1.renesas.com ([210.160.252.171]:25351 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725865AbfE2Hwz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 29 May 2019 03:52:55 -0400
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 29 May 2019 16:48:00 +0900
Message-Id: <1559116082-9851-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1559116082-9851-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1559116082-9851-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: [PATCH 2/4] pwm: sysfs: Switch to SPDX identifier
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pwm/sysfs.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 719f8fa..7eb4a13 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -1,19 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * A simple sysfs interface for the generic PWM framework
  *
  * Copyright (C) 2013 H Hartley Sweeten <hsweeten@visionengravers.com>
  *
  * Based on previous work by Lars Poeschel <poeschel@lemonage.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2, or (at your option)
- * any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/device.h>
-- 
2.7.4
