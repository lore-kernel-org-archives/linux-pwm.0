Return-Path: <sachin.kamat@linaro.org>
Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] Documentation/pwm: Update supported SoC name for pwm-samsung
Date: Wed, 30 Oct 2013 10:09:41 +0530
Message-Id: <1383107981-6638-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-pwm.vger.kernel.org>
To: linux-pwm@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com

Updated supported SoC name for pwm-samsung.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 .../devicetree/bindings/pwm/pwm-samsung.txt        |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-samsung.txt b/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
index d61fccd..5538de9 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
@@ -15,7 +15,7 @@ Required properties:
     samsung,s5pc100-pwm - for 32-bit timers present on S5PC100, S5PV210,
 			  Exynos4210 rev0 SoCs
     samsung,exynos4210-pwm - for 32-bit timers present on Exynos4210,
-                          Exynos4x12 and Exynos5250 SoCs
+                          Exynos4x12, Exynos5250 and Exynos5420 SoCs
 - reg: base address and size of register area
 - interrupts: list of timer interrupts (one interrupt per timer, starting at
   timer 0)
-- 
1.7.9.5
