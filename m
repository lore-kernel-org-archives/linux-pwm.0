From: Rajkumar Rampelli <rrajk@nvidia.com>
Subject: [PATCH V2 3/9] dt-bindings: Tegra186 tachometer device tree bindings
Date: Wed, 21 Mar 2018 10:10:38 +0530
Message-ID: <1521607244-29734-4-git-send-email-rrajk@nvidia.com>
References: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com, jonathanh@nvidia.com, jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net, catalin.marinas@arm.com, will.deacon@arm.com, kstewart@linuxfoundation.org, gregkh@linuxfoundation.org, pombredanne@nexb.com, mmaddireddy@nvidia.com, mperttunen@nvidia.com, arnd@arndb.de, timur@codeaurora.org, andy.gross@linaro.org, xuwei5@hisilicon.com, elder@linaro.org, heiko@sntech.de, krzk@kernel.org, ard.biesheuvel@linaro.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ldewangan@nvidia.com, rrajk@nvidia.com
List-Id: linux-pwm@vger.kernel.org

Supply Device tree binding documentation for the NVIDIA
Tegra186 SoC's Tachometer Controller

Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
---

V2: Renamed compatible string to "nvidia,tegra186-pwm-tachometer"
    Renamed dt property values of clock-names and reset-names to "tachometer"
    from "tach"

 .../bindings/pwm/pwm-tegra-tachometer.txt          | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-tegra-tachometer.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-tegra-tachometer.txt b/Documentation/devicetree/bindings/pwm/pwm-tegra-tachometer.txt
new file mode 100644
index 0000000..4a7ead4
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-tegra-tachometer.txt
@@ -0,0 +1,31 @@
+Bindings for a PWM based Tachometer driver
+
+Required properties:
+- compatible: Must be "nvidia,tegra186-pwm-tachometer"
+- reg: physical base addresses of the controller and length of
+  memory mapped region.
+- #pwm-cells: should be 2. See pwm.txt in this directory for a
+  description of the cells format.
+- clocks: phandle list of tachometer clocks
+- clock-names: should be "tachometer". See clock-bindings.txt in documentations
+- resets: phandle to the reset controller for the Tachometer IP
+- reset-names: should be "tachometer". See reset.txt in documentations
+- nvidia,pulse-per-rev: Integer, pulses per revolution of a Fan. This value
+  obtained from Fan specification document.
+- nvidia,capture-window-len: Integer, window of the Fan Tach monitor, it indicates
+  that how many period of the input fan tach signal will the FAN TACH logic
+  monitor. Valid values are 1, 2, 4 and 8 only.
+
+Example:
+	tegra_tachometer: tachometer@39c0000 {
+		compatible = "nvidia,tegra186-pwm-tachometer";
+		reg = <0x0 0x039c0000 0x0 0x10>;
+		#pwm-cells = <2>;
+		clocks = <&tegra_car TEGRA186_CLK_TACH>;
+		clock-names = "tachometer";
+		resets = <&tegra_car TEGRA186_RESET_TACH>;
+		reset-names = "tachometer";
+		nvidia,pulse-per-rev = <2>;
+		nvidia,capture-window-len = <2>;
+		status = "disabled";
+	};
-- 
2.1.4
