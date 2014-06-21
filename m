From: Beniamino Galvani <b.galvani@gmail.com>
Subject: [PATCH v2 2/3] pwm: rockchip: document device tree bindings
Date: Sat, 21 Jun 2014 16:22:07 +0200
Message-ID: <1403360528-12757-3-git-send-email-b.galvani@gmail.com>
References: <1403360528-12757-1-git-send-email-b.galvani@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1403360528-12757-1-git-send-email-b.galvani@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Beniamino Galvani <b.galvani@gmail.com>
List-Id: linux-pwm@vger.kernel.org

This adds binding documentation for Rockchip SoC PWM driver.

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 .../devicetree/bindings/pwm/pwm-rockchip.txt          |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-rockchip.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt b/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
new file mode 100644
index 0000000..3182126
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
@@ -0,0 +1,17 @@
+Rockchip PWM controller
+
+Required properties:
+ - compatible: should be "rockchip,rk2928-pwm"
+ - reg: physical base address and length of the controller's registers
+ - clocks: phandle and clock specifier of the PWM reference clock
+ - #pwm-cells: should be 2. See pwm.txt in this directory for a
+   description of the cell format.
+
+Example:
+
+	pwm0: pwm@20030000 {
+		compatible = "rockchip,rk2928-pwm";
+		reg = <0x20030000 0x10>;
+		clocks = <&cru PCLK_PWM01>;
+		#pwm-cells = <2>;
+	};
-- 
1.7.10.4
