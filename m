From: Rob Herring <robh@kernel.org>
Subject: [PATCH] dt-bindings: Remove redundant 'maxItems'
Date: Thu, 11 Jun 2020 13:47:38 -0600
Message-ID: <20200611194738.1480393-1-robh@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>, Anson Huang <Anson.Huang@nxp.com>, linux-clk@vger.kernel.org, linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

There's no need to specify 'maxItems' with the same value as the number
of entries in 'items'. A meta-schema update will catch future cases.

Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Anson Huang <Anson.Huang@nxp.com>
Cc: linux-clk@vger.kernel.org
Cc: linux-pwm@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/clock/imx6q-clock.yaml     | 1 -
 Documentation/devicetree/bindings/clock/imx6sl-clock.yaml    | 1 -
 Documentation/devicetree/bindings/clock/imx6sll-clock.yaml   | 1 -
 Documentation/devicetree/bindings/clock/imx6sx-clock.yaml    | 1 -
 Documentation/devicetree/bindings/clock/imx6ul-clock.yaml    | 1 -
 Documentation/devicetree/bindings/pwm/imx-pwm.yaml           | 2 --
 Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml | 2 --
 7 files changed, 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.yaml b/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
index 429e3b62b965..92a8e545e212 100644
--- a/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
@@ -23,7 +23,6 @@ properties:
     items:
       - description: CCM interrupt request 1
       - description: CCM interrupt request 2
-    maxItems: 2
 
   '#clock-cells':
     const: 1
diff --git a/Documentation/devicetree/bindings/clock/imx6sl-clock.yaml b/Documentation/devicetree/bindings/clock/imx6sl-clock.yaml
index 135568c46350..c97bf95b4150 100644
--- a/Documentation/devicetree/bindings/clock/imx6sl-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx6sl-clock.yaml
@@ -23,7 +23,6 @@ properties:
     items:
       - description: CCM interrupt request 1
       - description: CCM interrupt request 2
-    maxItems: 2
 
   '#clock-cells':
     const: 1
diff --git a/Documentation/devicetree/bindings/clock/imx6sll-clock.yaml b/Documentation/devicetree/bindings/clock/imx6sll-clock.yaml
index fa55f1ce3e57..de48924be191 100644
--- a/Documentation/devicetree/bindings/clock/imx6sll-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx6sll-clock.yaml
@@ -23,7 +23,6 @@ properties:
     items:
       - description: CCM interrupt request 1
       - description: CCM interrupt request 2
-    maxItems: 2
 
   '#clock-cells':
     const: 1
diff --git a/Documentation/devicetree/bindings/clock/imx6sx-clock.yaml b/Documentation/devicetree/bindings/clock/imx6sx-clock.yaml
index 982d698e8c54..e50cddee43c3 100644
--- a/Documentation/devicetree/bindings/clock/imx6sx-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx6sx-clock.yaml
@@ -23,7 +23,6 @@ properties:
     items:
       - description: CCM interrupt request 1
       - description: CCM interrupt request 2
-    maxItems: 2
 
   '#clock-cells':
     const: 1
diff --git a/Documentation/devicetree/bindings/clock/imx6ul-clock.yaml b/Documentation/devicetree/bindings/clock/imx6ul-clock.yaml
index 3c779eea6394..36ce7667c972 100644
--- a/Documentation/devicetree/bindings/clock/imx6ul-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx6ul-clock.yaml
@@ -23,7 +23,6 @@ properties:
     items:
       - description: CCM interrupt request 1
       - description: CCM interrupt request 2
-    maxItems: 2
 
   '#clock-cells':
     const: 1
diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
index 4b62af27d4b3..01df06777cba 100644
--- a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
@@ -30,13 +30,11 @@ properties:
     items:
       - description: SoC PWM ipg clock
       - description: SoC PWM per clock
-    maxItems: 2
 
   clock-names:
     items:
       - const: ipg
       - const: per
-    maxItems: 2
 
   interrupts:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml b/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml
index c4ddc0adf101..0073763a30d8 100644
--- a/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml
+++ b/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml
@@ -64,13 +64,11 @@ properties:
      - const: hs_src
 
   power-domains:
-    maxItems: 2
     items:
       - description: XUSBB(device) power-domain
       - description: XUSBA(superspeed) power-domain
 
   power-domain-names:
-    maxItems: 2
     items:
       - const: dev
       - const: ss
-- 
2.25.1
