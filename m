From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v2 6/8] pwm: cros-ec: Switch to SPDX identifier.
Date: Tue,  5 Jun 2018 19:54:27 +0200
Message-ID: <20180605175429.9072-7-enric.balletbo@collabora.com>
References: <20180605175429.9072-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180605175429.9072-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com, linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>
List-Id: linux-pwm@vger.kernel.org

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v2: None

 drivers/pwm/pwm-cros-ec.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 9c13694eaa24..9bf4cde86765 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -1,12 +1,7 @@
-/*
- * Copyright (C) 2016 Google, Inc
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2, as published by
- * the Free Software Foundation.
- *
- * Expose a PWM controlled by the ChromeOS EC to the host processor.
- */
+// SPDX-License-Identifier: GPL-2.0
+// Expose a PWM controlled by the ChromeOS EC to the host processor.
+//
+// Copyright (C) 2016 Google, Inc.
 
 #include <linux/module.h>
 #include <linux/mfd/cros_ec.h>
-- 
2.17.1
