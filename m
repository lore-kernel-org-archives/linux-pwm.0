From: Ulf Magnusson <ulfalizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] video: console: kconfig: Remove AVR32 dep. from VGA_CONSOLE
Date: Tue,  6 Feb 2018 23:52:46 +0100
Message-ID: <20180206225254.20036-1-ulfalizer@gmail.com>
References: <20180206120825.GF5681@sirena.org.uk>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180206120825.GF5681-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, daniel.vetter-/w4YWyX8dFk@public.gmane.org, christophe.leroy-GgN8y9CXRhA@public.gmane.org, seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Magnusson <ulfalizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

The AVR32 symbol was removed in commit 26202873bb51 ("avr32: remove
support for AVR32 architecture").

Signed-off-by: Ulf Magnusson <ulfalizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/video/console/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 7f1f1fbcef9e..be63759b6027 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -7,7 +7,7 @@ menu "Console display driver support"
 config VGA_CONSOLE
 	bool "VGA text console" if EXPERT || !X86
 	depends on !4xx && !PPC_8xx && !SPARC && !M68K && !PARISC && !FRV && \
-		!SUPERH && !BLACKFIN && !AVR32 && !MN10300 && !CRIS && \
+		!SUPERH && !BLACKFIN && !MN10300 && !CRIS && \
 		(!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER) && \
 		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC
 	default y
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
