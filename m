Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relmlor1.renesas.com ([210.160.252.171]:16431 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727761AbfE3KVB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 30 May 2019 06:21:01 -0400
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 30 May 2019 19:16:04 +0900
Message-Id: <1559211367-25106-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1559211367-25106-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1559211367-25106-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: [PATCH v2 1/4] pwm: Add power management descriptions
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch adds power management descriptions that consumers should
implement it.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Documentation/pwm.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/pwm.txt b/Documentation/pwm.txt
index 8fbf0aa..996e5ea 100644
--- a/Documentation/pwm.txt
+++ b/Documentation/pwm.txt
@@ -65,6 +65,10 @@ period). struct pwm_args contains 2 fields (period and polarity) and should
 be used to set the initial PWM config (usually done in the probe function
 of the PWM user). PWM arguments are retrieved with pwm_get_args().
 
+All consumers should really be reconfiguring the PWM upon resume as
+appropriate. This is the only way to ensure that everything is resumed in
+the proper order.
+
 Using PWMs with the sysfs interface
 -----------------------------------
 
@@ -141,6 +145,9 @@ The implementation of ->get_state() (a method used to retrieve initial PWM
 state) is also encouraged for the same reason: letting the PWM user know
 about the current PWM state would allow him to avoid glitches.
 
+Drivers should not implement any power management. In other words,
+consumers should implement it as described as the "Using PWMs" section.
+
 Locking
 -------
 
-- 
2.7.4
