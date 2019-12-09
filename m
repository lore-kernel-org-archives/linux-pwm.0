Return-path: <kernel-bounces@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 1/2] docs: pwm split out pwm-sysfs description from the
 generic pwm documentation
Date: Mon,  9 Dec 2019 22:32:32 +0100
Message-Id: <20191209213233.29574-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>

The two are related but still disjoint enough to justify two documents.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 Documentation/driver-api/index.rst     |  1 +
 Documentation/driver-api/pwm-sysfs.rst | 44 +++++++++++++++++++++++++
 Documentation/driver-api/pwm.rst       | 45 --------------------------
 3 files changed, 45 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/driver-api/pwm-sysfs.rst

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 0ebe205efd0c..3e0230df2d64 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -91,6 +91,7 @@ available subsections can be seen below.
    phy/index
    pti_intel_mid
    pwm
+   pwm-sysfs
    rfkill
    serial/index
    sm501
diff --git a/Documentation/driver-api/pwm-sysfs.rst b/Documentation/driver-api/pwm-sysfs.rst
new file mode 100644
index 000000000000..e7da67940648
--- /dev/null
+++ b/Documentation/driver-api/pwm-sysfs.rst
@@ -0,0 +1,44 @@
+Using PWMs with the sysfs interface
+-----------------------------------
+
+If CONFIG_SYSFS is enabled in your kernel configuration a simple sysfs
+interface is provided to use the PWMs from userspace. It is exposed at
+/sys/class/pwm/. Each probed PWM controller/chip will be exported as
+pwmchipN, where N is the base of the PWM chip. Inside the directory you
+will find:
+
+  npwm
+    The number of PWM channels this chip supports (read-only).
+
+  export
+    Exports a PWM channel for use with sysfs (write-only).
+
+  unexport
+   Unexports a PWM channel from sysfs (write-only).
+
+The PWM channels are numbered using a per-chip index from 0 to npwm-1.
+
+When a PWM channel is exported a pwmX directory will be created in the
+pwmchipN directory it is associated with, where X is the number of the
+channel that was exported. The following properties will then be available:
+
+  period
+    The total period of the PWM signal (read/write).
+    Value is in nanoseconds and is the sum of the active and inactive
+    time of the PWM.
+
+  duty_cycle
+    The active time of the PWM signal (read/write).
+    Value is in nanoseconds and must be less than the period.
+
+  polarity
+    Changes the polarity of the PWM signal (read/write).
+    Writes to this property only work if the PWM chip supports changing
+    the polarity. The polarity can only be changed if the PWM is not
+    enabled. Value is the string "normal" or "inversed".
+
+  enable
+    Enable/disable the PWM signal (read/write).
+
+	- 0 - disabled
+	- 1 - enabled
diff --git a/Documentation/driver-api/pwm.rst b/Documentation/driver-api/pwm.rst
index ab62f1bb0366..8f31bcdbb631 100644
--- a/Documentation/driver-api/pwm.rst
+++ b/Documentation/driver-api/pwm.rst
@@ -69,51 +69,6 @@ All consumers should really be reconfiguring the PWM upon resume as
 appropriate. This is the only way to ensure that everything is resumed in
 the proper order.
 
-Using PWMs with the sysfs interface
------------------------------------
-
-If CONFIG_SYSFS is enabled in your kernel configuration a simple sysfs
-interface is provided to use the PWMs from userspace. It is exposed at
-/sys/class/pwm/. Each probed PWM controller/chip will be exported as
-pwmchipN, where N is the base of the PWM chip. Inside the directory you
-will find:
-
-  npwm
-    The number of PWM channels this chip supports (read-only).
-
-  export
-    Exports a PWM channel for use with sysfs (write-only).
-
-  unexport
-   Unexports a PWM channel from sysfs (write-only).
-
-The PWM channels are numbered using a per-chip index from 0 to npwm-1.
-
-When a PWM channel is exported a pwmX directory will be created in the
-pwmchipN directory it is associated with, where X is the number of the
-channel that was exported. The following properties will then be available:
-
-  period
-    The total period of the PWM signal (read/write).
-    Value is in nanoseconds and is the sum of the active and inactive
-    time of the PWM.
-
-  duty_cycle
-    The active time of the PWM signal (read/write).
-    Value is in nanoseconds and must be less than the period.
-
-  polarity
-    Changes the polarity of the PWM signal (read/write).
-    Writes to this property only work if the PWM chip supports changing
-    the polarity. The polarity can only be changed if the PWM is not
-    enabled. Value is the string "normal" or "inversed".
-
-  enable
-    Enable/disable the PWM signal (read/write).
-
-	- 0 - disabled
-	- 1 - enabled
-
 Implementing a PWM driver
 -------------------------
 
-- 
2.24.0
