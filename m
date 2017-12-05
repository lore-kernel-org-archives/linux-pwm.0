From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: [PATCH] pwn: stm32: Adopt SPDX identifier
Date: Tue,  5 Dec 2017 15:57:21 +0100
Message-ID: <20171205145721.20403-1-benjamin.gaignard@st.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:45941 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752370AbdLEO53 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Dec 2017 09:57:29 -0500
Received: by mail-wm0-f65.google.com with SMTP id 9so1800642wme.4
        for <linux-pwm@vger.kernel.org>; Tue, 05 Dec 2017 06:57:29 -0800 (PST)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, alexandre.torgue@st.com
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Benjamin Gaignard <benjamin.gaignard@st.com>

Add SPDX identifer

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/pwm/pwm-stm32-lp.c | 3 +--
 drivers/pwm/pwm-stm32.c    | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index 1ac9e4384142..cbd271e80c3c 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * STM32 Low-Power Timer PWM driver
  *
@@ -5,8 +6,6 @@
  *
  * Author: Gerald Baeza <gerald.baeza@st.com>
  *
- * License terms: GNU General Public License (GPL), version 2
- *
  * Inspired by Gerald Baeza's pwm-stm32 driver
  */
 
diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 6139512aab7b..be56d7af89c9 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -1,10 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) STMicroelectronics 2016
  *
  * Author: Gerald Baeza <gerald.baeza@st.com>
  *
- * License terms: GNU General Public License (GPL), version 2
- *
  * Inspired by timer-stm32.c from Maxime Coquelin
  *             pwm-atmel.c from Bo Shen
  */
-- 
2.15.0
