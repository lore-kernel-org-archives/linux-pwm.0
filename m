Return-Path: <>
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH] dt-bindings: pwm: rcar: Add bindings for R-Car E3 support
Date: Mon, 30 Jul 2018 20:49:51 +0900
Message-Id: <1532951391-28792-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pwm.vger.kernel.org>
To: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch adds bindings for R-Car E3. No driver update is needed.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
index 35a3b97..e1ef6af 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
+++ b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
@@ -12,6 +12,7 @@ Required Properties:
  - "renesas,pwm-r8a7795": for R-Car H3
  - "renesas,pwm-r8a7796": for R-Car M3-W
  - "renesas,pwm-r8a77965": for R-Car M3-N
+ - "renesas,pwm-r8a77990": for R-Car E3
  - "renesas,pwm-r8a77995": for R-Car D3
 - reg: base address and length of the registers block for the PWM.
 - #pwm-cells: should be 2. See pwm.txt in this directory for a description of
-- 
1.9.1
