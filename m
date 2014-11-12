Return-Path: <root@danube-imgworks.hb.imgtec.org>
From: Naidu.Tellapati@imgtec.com
Subject: [PATCH 4/4] DT: pdm: Add binding document for IMG PDM DAC
Date: Wed, 12 Nov 2014 18:07:53 +0530
Message-Id: <1415795873-4816-5-git-send-email-Naidu.Tellapati@imgtec.com>
In-Reply-To: <1415795873-4816-1-git-send-email-Naidu.Tellapati@imgtec.com>
References: <1415795873-4816-1-git-send-email-Naidu.Tellapati@imgtec.com>
List-ID: <linux-pwm.vger.kernel.org>
To: thierry.reding@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org, James.Hartley@imgtec.com, abrestic@chromium.org, Ezequiel.Garcia@imgtec.com
Cc: Arul.Ramasamy@imgtec.com, Sai.Masarapu@imgtec.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Naidu Tellapati <Naidu.Tellapati@imgtec.com>

From: Naidu Tellapati <Naidu.Tellapati@imgtec.com>

Add binding document for the Pulse Density Modulator (PDM) DAC present on the
Pistachio SOC.

Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
Signed-off-by: Arul Ramasamy <Arul.Ramasamy@imgtec.com>
---
 Documentation/devicetree/bindings/misc/img-pdm.txt |   54 ++++++++++++++++++++
 1 files changed, 54 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/img-pdm.txt

diff --git a/Documentation/devicetree/bindings/misc/img-pdm.txt b/Documentation/devicetree/bindings/misc/img-pdm.txt
new file mode 100644
index 0000000..b536f0a
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/img-pdm.txt
@@ -0,0 +1,54 @@
+*Imagination Technologies Pulse Density Modulator (PDM) DAC.
+
+Required properties:
+- compatible: Must be "img,pistachio-pdm"
+- clocks: phandle to input PDM clock
+- clock-names: Must include the following entry:
+  - pdm: input clock to pdm block.
+- img,cr-periph: Must contain a phandle to the peripheral control
+  syscon node which contains PDM control registers.
+- #pdm-cells: Must be 2.
+- The first cell is the PDM channel number (valid values: 0, 1, 2, 3)
+- The second cell is 12-bit pulse-in value
+
+Specifying PDM information for devices
+======================================
+
+1. PDM User nodes
+
+PDM properties should be named "pdms". The exact meaning of each pdms property
+is described above.
+
+	pdm-specifier : array of #pdm-cells specifying the given PDM
+						(controller specific)
+
+The following example could be used to describe a PDM-based backlight device:
+
+	pdm: pdm {
+		#pdm-cells = <2>;
+	};
+
+	[...]
+
+	bl: backlight {
+		pdms = <&pdm 2 0>;
+	};
+
+pdm-specifier typically encodes the chip-relative PDM channel number and the
+12-bit pulse-in value.
+
+2. PDM Controller nodes
+
+PDM controller nodes must specify the number of cells used for the specifier
+using the '#pdm-cells' property.
+
+An example PDM controller might look like this:
+
+Example:
+	pdm: pdm@18148000 {
+		compatible = "img,pistachio-pdm";
+		clocks = <&pdm_clk_handle>;
+		clk-names = "pdm";
+		img,cr-periph = <&cr_periph>;
+		#pdm-cells = <2>;
+	};
-- 
1.7.0.4
