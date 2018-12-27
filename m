From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v9 26/27] MIPS: GCW0: defconfig: Enable OST, watchdog, PWM drivers
Date: Thu, 27 Dec 2018 19:13:18 +0100
Message-ID: <20181227181319.31095-27-paul@crapouillou.net>
References: <20181227181319.31095-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181227181319.31095-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-pwm@vger.kernel.org

The OST driver provides a clocksource and sched_clock that are much more
accurate than the default ones.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
     v8: New patch

     v9: No change

 arch/mips/configs/gcw0_defconfig | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/mips/configs/gcw0_defconfig b/arch/mips/configs/gcw0_defconfig
index 99ac1fa3b35f..7116400e8cbf 100644
--- a/arch/mips/configs/gcw0_defconfig
+++ b/arch/mips/configs/gcw0_defconfig
@@ -1,14 +1,14 @@
+CONFIG_NO_HZ_IDLE=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT_VOLUNTARY=y
+CONFIG_EMBEDDED=y
 CONFIG_MACH_INGENIC=y
 CONFIG_JZ4770_GCW0=y
 CONFIG_HIGHMEM=y
-# CONFIG_BOUNCE is not set
-CONFIG_PREEMPT_VOLUNTARY=y
 # CONFIG_SECCOMP is not set
-CONFIG_NO_HZ_IDLE=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_EMBEDDED=y
-# CONFIG_BLK_DEV_BSG is not set
 # CONFIG_SUSPEND is not set
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_BOUNCE is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -20,8 +20,13 @@ CONFIG_SERIAL_8250=y
 # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_INGENIC=y
+CONFIG_WATCHDOG=y
+CONFIG_JZ4740_WDT=y
 CONFIG_USB=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_NOP_USB_XCEIV=y
+CONFIG_INGENIC_OST=y
+CONFIG_PWM=y
+CONFIG_PWM_JZ4740=y
 CONFIG_TMPFS=y
-- 
2.11.0
