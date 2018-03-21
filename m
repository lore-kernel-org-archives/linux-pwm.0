From: Rajkumar Rampelli <rrajk@nvidia.com>
Subject: [PATCH V2 4/9] arm64: tegra: Add Tachometer Controller on Tegra186
Date: Wed, 21 Mar 2018 10:10:39 +0530
Message-ID: <1521607244-29734-5-git-send-email-rrajk@nvidia.com>
References: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com, jonathanh@nvidia.com, jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net, catalin.marinas@arm.com, will.deacon@arm.com, kstewart@linuxfoundation.org, gregkh@linuxfoundation.org, pombredanne@nexb.com, mmaddireddy@nvidia.com, mperttunen@nvidia.com, arnd@arndb.de, timur@codeaurora.org, andy.gross@linaro.org, xuwei5@hisilicon.com, elder@linaro.org, heiko@sntech.de, krzk@kernel.org, ard.biesheuvel@linaro.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ldewangan@nvidia.com, rrajk@nvidia.com
List-Id: linux-pwm@vger.kernel.org

The NVIDIA Tegra186 SoC has a Tachometer Controller that analyzes the
PWM signal of a Fan and reports the period value through pwm interface.

Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
---

V2: Renamed clock-names/reset-names dt properties values to "tachometer"
    Renamed compatible property value to "nvidia-tegra186-pwm-tachometer"

 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts |  5 +++++
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
index bd5305a..13c3e59 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
@@ -172,4 +172,9 @@
 			vin-supply = <&vdd_5v0_sys>;
 		};
 	};
+
+	tachometer@39c0000 {
+		nvidia,pulse-per-rev = <2>;
+		nvidia,capture-window-len = <2>;
+	};
 };
diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 731cd01..19e1afc 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -1042,4 +1042,15 @@
 		reset-names = "pwm";
 		status = "disabled";
 	};
+
+	tegra_tachometer: tachometer@39c0000 {
+		compatible = "nvidia,tegra186-pwm-tachometer";
+		reg = <0x0 0x039c0000 0x0 0x10>;
+		#pwm-cells = <2>;
+		clocks = <&bpmp TEGRA186_CLK_TACH>;
+		clock-names = "tachometer";
+		resets = <&bpmp TEGRA186_RESET_TACH>;
+		reset-names = "tachometer";
+		status = "disabled";
+	};
 };
-- 
2.1.4
