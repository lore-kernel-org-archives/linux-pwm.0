From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] pwm: stm32: enforce dependency on CONFIG_MFD_STM32_TIMERS
Date: Fri, 25 May 2018 18:04:54 +0200
Message-ID: <20180525160523.29124-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Benjamin Gaignard <benjamin.gaignard@st.com>, Arnd Bergmann <arnd@arndb.de>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

When compile-testing the pwm driver without also enabling the
stm32_timers MFD, we run into a link error:

drivers/pwm/pwm-stm32.o: In function `stm32_pwm_raw_capture.isra.6':
pwm-stm32.c:(.text+0xcb0): undefined reference to `stm32_timers_dma_burst_read'

We don't need the '|| COMPILE_TEST' here, since stm32_timers itself
can be built with CONFIG_COMPILE_TEST on all architectures, so we do
get the coverage through allmodconfig and randconfig builds even
when we make it a hard dependency.

Fixes: 7edf7369205b ("pwm: Add driver for STM32 plaftorm")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pwm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 4635cb35008c..a4d262db9945 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -401,7 +401,7 @@ config PWM_STI
 
 config PWM_STM32
 	tristate "STMicroelectronics STM32 PWM"
-	depends on MFD_STM32_TIMERS || COMPILE_TEST
+	depends on MFD_STM32_TIMERS
 	help
 	  Generic PWM framework driver for STM32 SoCs.
 
-- 
2.9.0
