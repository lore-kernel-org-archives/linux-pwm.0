From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH] pwm: pwm-rcar: Revise the device tree binding document about compatible
Date: Tue, 6 Oct 2015 20:28:28 +0900
Message-ID: <1444130908-8180-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: linux-pwm@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-pwm@vger.kernel.org

The compatible should be "renesas,pwm-rcar", and one the the SoC
specific string. So, this patch revises the documentation.

Reported-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
index ea0a27b..0822a08 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
+++ b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
@@ -1,8 +1,7 @@
 * Renesas R-Car PWM Timer Controller
 
 Required Properties:
-- compatible: should be one of the following.
- - "renesas,pwm-rcar": for generic R-Car compatible PWM Timer
+- compatible: should be "renesas,pwm-rcar" and one of the following.
  - "renesas,pwm-r8a7778": for R-Car M1A
  - "renesas,pwm-r8a7779": for R-Car H1
  - "renesas,pwm-r8a7790": for R-Car H2
-- 
1.9.1

