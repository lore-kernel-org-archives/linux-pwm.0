From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v11 06/27] MAINTAINERS: Add myself as maintainer for Ingenic TCU drivers
Date: Thu, 28 Mar 2019 00:16:10 +0100
Message-ID: <20190327231631.15708-7-paul@crapouillou.net>
References: <20190327231631.15708-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327231631.15708-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Mathieu Malaterre <malat@debian.org>, od@zcrc.me, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-pwm@vger.kernel.org

Add myself as maintainer for the ingenic-timer and ingenic-ost drivers.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e5a5d263f29..da25d99d81aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7665,6 +7665,15 @@ L:	linux-mtd@lists.infradead.org
 S:	Maintained
 F:	drivers/mtd/nand/raw/jz4780_*
 
+INGENIC TCU driver
+M:	Paul Cercueil <paul@crapouillou.net>
+S:	Maintained
+F:	drivers/clocksource/ingenic-ost.c
+F:	drivers/clocksource/ingenic-timer.c
+F:	drivers/clocksource/ingenic-timer.h
+F:	include/linux/mfd/ingenic-tcu.h
+F:	include/dt-bindings/clock/ingenic,tcu.h
+
 INOTIFY
 M:	Jan Kara <jack@suse.cz>
 R:	Amir Goldstein <amir73il@gmail.com>
-- 
2.11.0
