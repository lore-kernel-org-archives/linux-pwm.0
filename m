From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH] dt-bindings: pwm: allwinner: Fix missing header in H6 example
Date: Tue, 10 Dec 2019 18:47:10 +0100
Message-ID: <20191210174710.10649-1-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Maxime Ripard <maxime@cerno.tech>
Cc: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-pwm@vger.kernel.org

Latest linux-next doesn't build due to the following error:

Error: Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.example.dts:35.37-38
syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.example.dt.yaml]
Error 1

This is due to missing header in the device-tree yaml example.

Fix this by adding the missing headers.

Fixes: 4ee929b3f08e ("dt-bindings: pwm: allwinner: Add H6 PWM description")
Reported-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 .../devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml       | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
index a7dc19fc347a..fab89f052450 100644
--- a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
@@ -93,6 +93,9 @@ examples:
     };
 
   - |
+    #include <dt-bindings/clock/sun50i-h6-ccu.h>
+    #include <dt-bindings/reset/sun50i-h6-ccu.h>
+
     pwm@300a000 {
       compatible = "allwinner,sun50i-h6-pwm";
       reg = <0x0300a000 0x400>;
-- 
2.20.1
