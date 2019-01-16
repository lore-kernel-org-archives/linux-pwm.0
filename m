From: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
Subject: [PATCH V2 4/4] ARM: dts: cygnus: Change pwm compatible to new version
Date: Thu, 17 Jan 2019 01:45:16 +0530
Message-ID: <1547669716-20070-5-git-send-email-sheetal.tigadoli@broadcom.com>
References: <1547669716-20070-1-git-send-email-sheetal.tigadoli@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1547669716-20070-1-git-send-email-sheetal.tigadoli@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Praveen Kumar B <praveen.b@broadcom.com>, Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
List-Id: linux-pwm@vger.kernel.org

From: Praveen Kumar B <praveen.b@broadcom.com>

Change pwm compatible to new version pwm-cygnus
Add new compatible to check pwm configure status

Signed-off-by: Praveen Kumar B <praveen.b@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 253df71..0a0ec5b 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -595,7 +595,7 @@
 		};
 
 		pwm: pwm@180aa500 {
-			compatible = "brcm,kona-pwm";
+			compatible = "brcm,cygnus-pwm";
 			reg = <0x180aa500 0xc4>;
 			#pwm-cells = <3>;
 			clocks = <&asiu_clks BCM_CYGNUS_ASIU_PWM_CLK>;
-- 
1.9.1
