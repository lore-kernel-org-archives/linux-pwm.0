From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 1/2] dt-bindings: pwm: tiecap: Add TI AM654 SoC specific compatible
Date: Wed, 3 Oct 2018 22:36:57 +0530
Message-ID: <20181003170658.3835-2-vigneshr@ti.com>
References: <20181003170658.3835-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181003170658.3835-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vignesh R <vigneshr@ti.com>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

Add a new compatible string "ti,am654-ecap" to support PWM ECAP IP of
TI AM654 SoC.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 Documentation/devicetree/bindings/pwm/pwm-tiecap.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt b/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
index 06a363d9ccef..b9a1d7402128 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
@@ -7,6 +7,7 @@ Required properties:
   for da850  - compatible = "ti,da850-ecap", "ti,am3352-ecap", "ti,am33xx-ecap";
   for dra746 - compatible = "ti,dra746-ecap", "ti,am3352-ecap";
   for 66ak2g - compatible = "ti,k2g-ecap", "ti,am3352-ecap";
+  for am654  - compatible = "ti,am654-ecap", "ti,am3352-ecap";
 - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
   the cells format. The PWM channel index ranges from 0 to 4. The only third
   cell flag supported by this binding is PWM_POLARITY_INVERTED.
-- 
2.19.0
