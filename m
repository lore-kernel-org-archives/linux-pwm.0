From: Rob Herring <robh@kernel.org>
Subject: [PATCH] dt-bindings: pwm: Fix cros-ec-pwm example dtc 'reg' warning
Date: Wed, 15 Apr 2020 13:26:39 -0500
Message-ID: <20200415182639.18534-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36866 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1416773AbgDOS0m (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 15 Apr 2020 14:26:42 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Benson Leung <bleung@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Guenter Roeck <groeck@chromium.org>, linux-pwm@vger.kernel.org

The example for the CrOS EC PWM is incomplete and now generates a dtc
warning:

Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.example.dts:17.11-23.11:
Warning (unit_address_vs_reg): /example-0/cros-ec@0: node has a unit name, but no reg or ranges property

Fixing this results in more warnings as a parent spi node is needed as
well.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Benson Leung <bleung@chromium.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: linux-pwm@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pwm/google,cros-ec-pwm.yaml        | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
index 24c217b76580..41ece1d85315 100644
--- a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
@@ -31,10 +31,17 @@ additionalProperties: false
 
 examples:
   - |
-    cros-ec@0 {
-        compatible = "google,cros-ec-spi";
-        cros_ec_pwm: ec-pwm {
-            compatible = "google,cros-ec-pwm";
-            #pwm-cells = <1>;
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        cros-ec@0 {
+            compatible = "google,cros-ec-spi";
+            reg = <0>;
+
+            cros_ec_pwm: ec-pwm {
+                compatible = "google,cros-ec-pwm";
+                #pwm-cells = <1>;
+            };
         };
     };
-- 
2.20.1
