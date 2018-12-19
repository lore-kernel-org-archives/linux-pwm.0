Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from fallback18.mail.ru ([185.5.136.250]:46858 "EHLO
        fallback18.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbeLSKji (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Dec 2018 05:39:38 -0500
Received: from [10.161.64.55] (port=45458 helo=smtp47.i.mail.ru)
        by fallback18.m.smailru.net with esmtp (envelope-from <shc_work@mail.ru>)
        id 1gZZGJ-0000m6-Ow
        for linux-pwm@vger.kernel.org; Wed, 19 Dec 2018 13:39:36 +0300
From: Alexander Shiyan <shc_work@mail.ru>
Date: Wed, 19 Dec 2018 13:39:25 +0300
Message-Id: <20181219103925.28360-2-shc_work@mail.ru>
In-Reply-To: <20181219103925.28360-1-shc_work@mail.ru>
References: <20181219103925.28360-1-shc_work@mail.ru>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: [PATCH 2/2] pwm: clps711x: Switch to SPDX identifier
To: linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, Alexander Shiyan <shc_work@mail.ru>

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/pwm/pwm-clps711x.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
index 7e16b7def0dc..924d39a797cf 100644
--- a/drivers/pwm/pwm-clps711x.c
+++ b/drivers/pwm/pwm-clps711x.c
@@ -1,12 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Cirrus Logic CLPS711X PWM driver
- *
- * Copyright (C) 2014 Alexander Shiyan <shc_work@mail.ru>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
+ * Author: Alexander Shiyan <shc_work@mail.ru>
  */
 
 #include <linux/clk.h>
-- 
2.13.0
