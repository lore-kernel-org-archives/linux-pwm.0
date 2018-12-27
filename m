From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v9 19/27] MIPS: Kconfig: Select TCU timer driver when MACH_INGENIC is set
Date: Thu, 27 Dec 2018 19:13:11 +0100
Message-ID: <20181227181319.31095-20-paul@crapouillou.net>
References: <20181227181319.31095-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181227181319.31095-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-pwm@vger.kernel.org

We cannot boot to userspace (not even initramfs) if the timer driver is
not present; so it makes sense to enable it unconditionally when
MACH_INGENIC is set.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
     v5: New patch
    
     v6: No change
    
     v7: No change

     v8: No change

     v9: No change

 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 8272ea4c7264..8bd53a4e871b 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -390,6 +390,7 @@ config MACH_INGENIC
 	select BUILTIN_DTB
 	select USE_OF
 	select LIBFDT
+	select INGENIC_TIMER
 
 config LANTIQ
 	bool "Lantiq based platforms"
-- 
2.11.0
