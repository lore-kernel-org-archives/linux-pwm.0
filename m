Return-Path: <root@danube-imgworks.hb.imgtec.org>
From: Naidu.Tellapati@imgtec.com
Subject: [PATCH 2/4] DT: pwm: Add binding document for IMG PWM DAC
Date: Wed, 12 Nov 2014 18:07:51 +0530
Message-Id: <1415795873-4816-3-git-send-email-Naidu.Tellapati@imgtec.com>
In-Reply-To: <1415795873-4816-1-git-send-email-Naidu.Tellapati@imgtec.com>
References: <1415795873-4816-1-git-send-email-Naidu.Tellapati@imgtec.com>
List-ID: <linux-pwm.vger.kernel.org>
To: thierry.reding@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org, James.Hartley@imgtec.com, abrestic@chromium.org, Ezequiel.Garcia@imgtec.com
Cc: Arul.Ramasamy@imgtec.com, Sai.Masarapu@imgtec.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Naidu Tellapati <Naidu.Tellapati@imgtec.com>

From: Naidu Tellapati <Naidu.Tellapati@imgtec.com>

Add binding document for IMG Pulse Width Modulator (PWM) DAC present on the
Pistachio SOC. The PWM DAC has four channels.

Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
Signed-off-by: Sai Masarapu <Sai.Masarapu@imgtec.com>
---
 Documentation/devicetree/bindings/pwm/img-pwm.txt |   22 +++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/img-pwm.txt

diff --git a/Documentation/devicetree/bindings/pwm/img-pwm.txt b/Documentation/devicetree/bindings/pwm/img-pwm.txt
new file mode 100644
index 0000000..4f7f60c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/img-pwm.txt
@@ -0,0 +1,22 @@
+*Imagination Technologies PWM DAC driver
+
+Required properties:
+  - compatible: Should be "img,pistachio-pwm"
+  - reg: Should contain physical base address and length of pwm registers.
+  - clocks: phandle to input PWM clock.
+  - clock-names: input clock names.
+	Required elements: "pwm".
+  - #pwm-cells: Should be 2. See pwm.txt in this directory for the
+	description of the cells format.
+  - img,cr-periph: Must contain a phandle to the peripheral control
+	syscon node which contains PWM control registers.
+
+Example:
+	pwm: pwm@18101300 {
+		compatible = "img,pistachio-pwm";
+		reg = <0x18101300 0x14>;
+		clocks = <&pwm_clk_handle>;
+		clk-names = "pwm";
+		#pwm-cells = <2>;
+		img,cr-periph = <&cr_periph>;
+	};
-- 
1.7.0.4
