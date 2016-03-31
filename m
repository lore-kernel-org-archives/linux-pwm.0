From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH v3 1/6] pwm: rcar: Use ARCH_RENESAS
Date: Thu, 31 Mar 2016 13:39:11 +0200
Message-ID: <1459424356-26061-2-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1459424356-26061-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1459424356-26061-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, geert@linux-m68k.org
Cc: linux-pwm@vger.kernel.org, thierry.reding@gmail.com, magnus.damm@gmail.com, Ryo Kodama <ryo.kodama.vz@renesas.com>, Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-pwm@vger.kernel.org

From: Ryo Kodama <ryo.kodama.vz@renesas.com>

Replace ARCH_RCAR_GEN{1,2} with ARCH_RENESAS in order to support R-Car Gen3.

Signed-off-by: Ryo Kodama <ryo.kodama.vz@renesas.com>
Signed-off-by: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pwm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index c182efc..3a2e232 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -305,7 +305,7 @@ config PWM_PXA
 
 config PWM_RCAR
 	tristate "Renesas R-Car PWM support"
-	depends on ARCH_RCAR_GEN1 || ARCH_RCAR_GEN2 || COMPILE_TEST
+	depends on ARCH_RENESAS || COMPILE_TEST
 	depends on HAS_IOMEM
 	help
 	  This driver exposes the PWM Timer controller found in Renesas
-- 
2.7.4
