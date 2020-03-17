From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 05/12] docs: dt: fix references to ap806-system-controller.txt
Date: Tue, 17 Mar 2020 14:10:44 +0100
Message-ID: <cf60ef88712e4f46f4e4bf40b2c646451d921827.1584450500.git.mchehab+huawei@kernel.org>
References: <cover.1584450500.git.mchehab+huawei@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <cover.1584450500.git.mchehab+huawei@kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@verdurent.com>, Ben Peled <bpeled@marvell.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

ap806-system-controller.txt was renamed to ap80x-system-controller.txt.

Update its references accordingly.

Fixes: 2537831bbc19 ("dt-bindings: ap80x: replace AP806 with AP80x")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/devicetree/bindings/gpio/gpio-mvebu.txt        | 2 +-
 Documentation/devicetree/bindings/thermal/armada-thermal.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt b/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
index 2e097b57f170..0fc6700ed800 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
@@ -14,7 +14,7 @@ Required properties:
 
     "marvell,armada-8k-gpio" should be used for the Armada 7K and 8K
     SoCs (either from AP or CP), see
-    Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
+    Documentation/devicetree/bindings/arm/marvell/ap80x-system-controller.txt
     for specific details about the offset property.
 
 - reg: Address and length of the register set for the device. Only one
diff --git a/Documentation/devicetree/bindings/thermal/armada-thermal.txt b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
index f3b441100890..b0bee7e42038 100644
--- a/Documentation/devicetree/bindings/thermal/armada-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
@@ -12,7 +12,7 @@ Required properties:
 
 Note: these bindings are deprecated for AP806/CP110 and should instead
 follow the rules described in:
-Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
+Documentation/devicetree/bindings/arm/marvell/ap80x-system-controller.txt
 Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
 
 - reg: Device's register space.
-- 
2.24.1
