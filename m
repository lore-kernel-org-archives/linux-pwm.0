From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 1/4] pwm: pwm-tiecap: Add TI 66AK2G SoC specific compatible
Date: Mon, 7 Aug 2017 17:19:40 +0530
Message-ID: <20170807114943.22612-2-vigneshr@ti.com>
References: <20170807114943.22612-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170807114943.22612-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: Vignesh R <vigneshr@ti.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Add a new compatible string "ti,k2g-ecap" to support PWM ECAP IP of
TI 66AK2G SoC.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 Documentation/devicetree/bindings/pwm/pwm-tiecap.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt b/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
index 8007e839a716..06a363d9ccef 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
@@ -6,6 +6,7 @@ Required properties:
   for am4372 - compatible = "ti,am4372-ecap", "ti,am3352-ecap", "ti,am33xx-ecap";
   for da850  - compatible = "ti,da850-ecap", "ti,am3352-ecap", "ti,am33xx-ecap";
   for dra746 - compatible = "ti,dra746-ecap", "ti,am3352-ecap";
+  for 66ak2g - compatible = "ti,k2g-ecap", "ti,am3352-ecap";
 - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
   the cells format. The PWM channel index ranges from 0 to 4. The only third
   cell flag supported by this binding is PWM_POLARITY_INVERTED.
-- 
2.13.3
