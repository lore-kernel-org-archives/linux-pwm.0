From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 1/8] dt-bindings: pwm: samsung: Do not require interrupts on Exynos SoCs
Date: Thu,  2 Jul 2020 17:51:42 +0200
Message-ID: <20200702155149.12854-1-krzk@kernel.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbgGBPv6 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 2 Jul 2020 11:51:58 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Sylwester Nawrocki <snawrocki@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Pankaj Dubey <pankaj.dubey@samsung.com>

The bindings required interrupts for all SoCs but actually only the PWM
timer clocksource (for S3C/S5P SoCs) was using them.  This PWM timer
clocksource driver is not used on Exynos SoCs thus the interrupts can be
marked as optional.

Reported-by: Alim Akhtar <alim.akhtar@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. New patch
---
 .../devicetree/bindings/pwm/pwm-samsung.yaml  | 23 +++++++++++++++----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml b/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
index fc799b0577d4..188679cb8b8c 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
@@ -18,9 +18,6 @@ description: |+
 
   Be aware that the clocksource driver supports only uniprocessor systems.
 
-allOf:
-  - $ref: pwm.yaml#
-
 properties:
   compatible:
     enum:
@@ -63,7 +60,8 @@ properties:
 
   interrupts:
     description:
-      One interrupt per timer, starting at timer 0.
+      One interrupt per timer, starting at timer 0. Necessary only for SoCs which
+      use PWM clocksource.
     minItems: 1
     maxItems: 5
 
@@ -88,12 +86,27 @@ required:
   - clocks
   - clock-names
   - compatible
-  - interrupts
   - "#pwm-cells"
   - reg
 
 additionalProperties: false
 
+allOf:
+  - $ref: pwm.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,s3c2410-pwm
+              - samsung,s3c6400-pwm
+              - samsung,s5p6440-pwm
+              - samsung,s5pc100-pwm
+    then:
+      required:
+        - interrupts
+
 examples:
   - |
     pwm@7f006000 {
-- 
2.17.1
