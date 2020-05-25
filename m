From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 1/4] pwm: jz4740: Drop dependency on MACH_INGENIC
Date: Mon, 25 May 2020 14:57:19 +0200
Message-ID: <20200525125722.36447-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from outils.crapouillou.net ([89.234.176.41]:47036 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388757AbgEYM5m (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 May 2020 08:57:42 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: od@zcrc.me, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>

Depending on MACH_INGENIC prevent us from creating a generic kernel that
works on more than one MIPS board. Instead, we just depend on MIPS being
set.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---

Notes:
    v2: No change

 drivers/pwm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index eebbc917ac97..7814e5b2cad7 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -234,7 +234,7 @@ config PWM_IMX_TPM
 
 config PWM_JZ4740
 	tristate "Ingenic JZ47xx PWM support"
-	depends on MACH_INGENIC
+	depends on MIPS
 	depends on COMMON_CLK
 	select MFD_SYSCON
 	help
-- 
2.26.2
