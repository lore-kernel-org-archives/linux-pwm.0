From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 05/29] pwm.txt: standardize document format
Date: Thu, 18 May 2017 22:25:49 -0300
Message-ID: <1eb33d27e057f4bdbd715fea8f03a9e7e3236b67.1495157082.git.mchehab@s-opensource.com>
References: <cover.1495157082.git.mchehab@s-opensource.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:43767
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932393AbdESB0V (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 18 May 2017 21:26:21 -0400
In-Reply-To: <cover.1495157082.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1495157082.git.mchehab@s-opensource.com>
References: <cover.1495157082.git.mchehab@s-opensource.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Cyrille Pitchen <cyrille.pitchen@atmel.com>, linux-mtd@lists.infradead.org, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org

Each text file under Documentation follows a different
format. Some doesn't even have titles!

Change its representation to follow the adopted standard,
using ReST markups for it to be parseable by Sphinx:

- mark document title;
- mark literal blocks;
- better format the parameters.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 Documentation/pwm.txt | 46 ++++++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/Documentation/pwm.txt b/Documentation/pwm.txt
index 789b27c6ec99..8fbf0aa3ba2d 100644
--- a/Documentation/pwm.txt
+++ b/Documentation/pwm.txt
@@ -1,4 +1,6 @@
+======================================
 Pulse Width Modulation (PWM) interface
+======================================
 
 This provides an overview about the Linux PWM interface
 
@@ -16,7 +18,7 @@ Users of the legacy PWM API use unique IDs to refer to PWM devices.
 
 Instead of referring to a PWM device via its unique ID, board setup code
 should instead register a static mapping that can be used to match PWM
-consumers to providers, as given in the following example:
+consumers to providers, as given in the following example::
 
 	static struct pwm_lookup board_pwm_lookup[] = {
 		PWM_LOOKUP("tegra-pwm", 0, "pwm-backlight", NULL,
@@ -40,9 +42,9 @@ New users should use the pwm_get() function and pass to it the consumer
 device or a consumer name. pwm_put() is used to free the PWM device. Managed
 variants of these functions, devm_pwm_get() and devm_pwm_put(), also exist.
 
-After being requested, a PWM has to be configured using:
+After being requested, a PWM has to be configured using::
 
-int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state);
+	int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state);
 
 This API controls both the PWM period/duty_cycle config and the
 enable/disable state.
@@ -72,11 +74,14 @@ interface is provided to use the PWMs from userspace. It is exposed at
 pwmchipN, where N is the base of the PWM chip. Inside the directory you
 will find:
 
-npwm - The number of PWM channels this chip supports (read-only).
+  npwm
+    The number of PWM channels this chip supports (read-only).
 
-export - Exports a PWM channel for use with sysfs (write-only).
+  export
+    Exports a PWM channel for use with sysfs (write-only).
 
-unexport - Unexports a PWM channel from sysfs (write-only).
+  unexport
+   Unexports a PWM channel from sysfs (write-only).
 
 The PWM channels are numbered using a per-chip index from 0 to npwm-1.
 
@@ -84,21 +89,26 @@ When a PWM channel is exported a pwmX directory will be created in the
 pwmchipN directory it is associated with, where X is the number of the
 channel that was exported. The following properties will then be available:
 
-period - The total period of the PWM signal (read/write).
-	Value is in nanoseconds and is the sum of the active and inactive
-	time of the PWM.
+  period
+    The total period of the PWM signal (read/write).
+    Value is in nanoseconds and is the sum of the active and inactive
+    time of the PWM.
 
-duty_cycle - The active time of the PWM signal (read/write).
-	Value is in nanoseconds and must be less than the period.
+  duty_cycle
+    The active time of the PWM signal (read/write).
+    Value is in nanoseconds and must be less than the period.
 
-polarity - Changes the polarity of the PWM signal (read/write).
-	Writes to this property only work if the PWM chip supports changing
-	the polarity. The polarity can only be changed if the PWM is not
-	enabled. Value is the string "normal" or "inversed".
+  polarity
+    Changes the polarity of the PWM signal (read/write).
+    Writes to this property only work if the PWM chip supports changing
+    the polarity. The polarity can only be changed if the PWM is not
+    enabled. Value is the string "normal" or "inversed".
 
-enable - Enable/disable the PWM signal (read/write).
-	0 - disabled
-	1 - enabled
+  enable
+    Enable/disable the PWM signal (read/write).
+
+	- 0 - disabled
+	- 1 - enabled
 
 Implementing a PWM driver
 -------------------------
-- 
2.9.4
