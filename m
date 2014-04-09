From: Tim Kryger <tim.kryger@linaro.org>
Subject: [RESEND PATCH v5 3/5] ARM: dts: Declare the PWM for bcm11351 (bcm281xx)
Date: Wed, 9 Apr 2014 09:23:09 -0700
Message-ID: <1397060591-5060-4-git-send-email-tim.kryger@linaro.org>
References: <1397060591-5060-1-git-send-email-tim.kryger@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1397060591-5060-1-git-send-email-tim.kryger@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Matt Porter <mporter@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rob Landley <rob@landley.net>, Christian Daudt <bcm@fixthebug.org>, Grant Likely <grant.likely@linaro.org>
Cc: Tim Kryger <tim.kryger@linaro.org>, Linux PWM List <linux-pwm@vger.kernel.org>, Device Tree List <devicetree@vger.kernel.org>, Linux Doc List <linux-doc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Broadcom Kernel Feedback List <bcm-kernel-feedback-list@broadcom.com>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

Add the device tree node for the PWM on bcm11351 SoCs.

Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
Reviewed-by: Alex Elder <elder@linaro.org>
Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
---
 arch/arm/boot/dts/bcm11351.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
index 64d069b..6b05ae6 100644
--- a/arch/arm/boot/dts/bcm11351.dtsi
+++ b/arch/arm/boot/dts/bcm11351.dtsi
@@ -193,6 +193,14 @@
 		status = "disabled";
 	};
 
+	pwm: pwm@3e01a000 {
+		compatible = "brcm,bcm11351-pwm", "brcm,kona-pwm";
+		reg = <0x3e01a000 0xcc>;
+		clocks = <&slave_ccu BCM281XX_SLAVE_CCU_PWM>;
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
 	clocks {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.7.9.5
