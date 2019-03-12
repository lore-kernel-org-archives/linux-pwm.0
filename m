From: Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 1/2] dt-bindings: pwm: tiehrpwm: Add TI AM654 SoC specific compatible
Date: Tue, 12 Mar 2019 14:46:28 +0530
Message-ID: <20190312091629.31701-2-vigneshr@ti.com>
References: <20190312091629.31701-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190312091629.31701-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

Add a new compatible string "ti,am654-ehrpwm" to support EHRPWM IP on
TI AM654 SoC.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
index 944fe356bb45..31c4577157dd 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible: Must be "ti,<soc>-ehrpwm".
   for am33xx  - compatible = "ti,am3352-ehrpwm", "ti,am33xx-ehrpwm";
   for am4372  - compatible = "ti,am4372-ehrpwm", "ti-am3352-ehrpwm", "ti,am33xx-ehrpwm";
+  for am654   - compatible = "ti,am654-ehrpwm", "ti-am3352-ehrpwm";
   for da850   - compatible = "ti,da850-ehrpwm", "ti-am3352-ehrpwm", "ti,am33xx-ehrpwm";
   for dra746 - compatible = "ti,dra746-ehrpwm", "ti-am3352-ehrpwm";
 - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
-- 
2.21.0
