Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:30814 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfFTJYq (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 20 Jun 2019 05:24:46 -0400
From: Mika Westerberg <mika.westerberg@linux.intel.com>
Date: Thu, 20 Jun 2019 12:24:43 +0300
Message-Id: <20190620092443.4854-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: [PATCH] pwm: lpss: Convert to use SPDX identifier
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-pwm@vger.kernel.org

This gets rid of the license boilerplate duplicated in each file.

No functional changes intended.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pwm/pwm-lpss-pci.c      | 5 +----
 drivers/pwm/pwm-lpss-platform.c | 5 +----
 drivers/pwm/pwm-lpss.c          | 5 +----
 drivers/pwm/pwm-lpss.h          | 5 +----
 4 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
index c1527cb645be..5e47d9bccf22 100644
--- a/drivers/pwm/pwm-lpss-pci.c
+++ b/drivers/pwm/pwm-lpss-pci.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Intel Low Power Subsystem PWM controller PCI driver
  *
  * Copyright (C) 2014, Intel Corporation
  *
  * Derived from the original pwm-lpss.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
index 757230e1f575..ce77539a0855 100644
--- a/drivers/pwm/pwm-lpss-platform.c
+++ b/drivers/pwm/pwm-lpss-platform.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Intel Low Power Subsystem PWM controller driver
  *
  * Copyright (C) 2014, Intel Corporation
  *
  * Derived from the original pwm-lpss.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/acpi.h>
diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 2ac3a2aa9e53..9a1b25926956 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Intel Low Power Subsystem PWM controller driver
  *
@@ -7,10 +8,6 @@
  * Author: Chang Rebecca Swee Fun <rebecca.swee.fun.chang@intel.com>
  * Author: Chew Chiau Ee <chiau.ee.chew@intel.com>
  * Author: Alan Cox <alan@linux.intel.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/delay.h>
diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
index 3236be835bd9..f47dede100f8 100644
--- a/drivers/pwm/pwm-lpss.h
+++ b/drivers/pwm/pwm-lpss.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Intel Low Power Subsystem PWM controller driver
  *
  * Copyright (C) 2014, Intel Corporation
  *
  * Derived from the original pwm-lpss.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef __PWM_LPSS_H
-- 
2.20.1
