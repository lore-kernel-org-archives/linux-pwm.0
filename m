From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v5 20/21] MIPS: CI20: defconfig: enable OST driver
Date: Wed, 25 Jul 2018 01:19:57 +0200
Message-ID: <20180724231958.20659-21-paul@crapouillou.net>
References: <20180724231958.20659-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180724231958.20659-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Jonathan Corbet <corbet@lwn.net>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc: Paul Cercueil <paul@crapouillou.net>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

The OST driver provides a clocksource and sched_clock that are much more
accurate than the default ones.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/configs/ci20_defconfig | 1 +
 1 file changed, 1 insertion(+)

 v5: New patch

diff --git a/arch/mips/configs/ci20_defconfig b/arch/mips/configs/ci20_defconfig
index be23fd25eeaa..e56dc5c024b9 100644
--- a/arch/mips/configs/ci20_defconfig
+++ b/arch/mips/configs/ci20_defconfig
@@ -109,6 +109,7 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_JZ4740=y
 CONFIG_DMADEVICES=y
 CONFIG_DMA_JZ4780=y
+CONFIG_INGENIC_OST=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_MEMORY=y
 CONFIG_EXT4_FS=y
-- 
2.11.0
