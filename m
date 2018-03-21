From: Rajkumar Rampelli <rrajk@nvidia.com>
Subject: [PATCH V2 2/9] arm64: tegra: Add PWM controller on Tegra186 soc
Date: Wed, 21 Mar 2018 10:10:37 +0530
Message-ID: <1521607244-29734-3-git-send-email-rrajk@nvidia.com>
References: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com, jonathanh@nvidia.com, jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net, catalin.marinas@arm.com, will.deacon@arm.com, kstewart@linuxfoundation.org, gregkh@linuxfoundation.org, pombredanne@nexb.com, mmaddireddy@nvidia.com, mperttunen@nvidia.com, arnd@arndb.de, timur@codeaurora.org, andy.gross@linaro.org, xuwei5@hisilicon.com, elder@linaro.org, heiko@sntech.de, krzk@kernel.org, ard.biesheuvel@linaro.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ldewangan@nvidia.com, rrajk@nvidia.com
List-Id: linux-pwm@vger.kernel.org

The NVIDIA Tegra186 SoC has a PWM controller which is
used in FAN control use case.

Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
---

V2: no changes in this patch

 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index b762227..731cd01 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -1031,4 +1031,15 @@
 				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 		interrupt-parent = <&gic>;
 	};
+
+	pwm@c340000 {
+		compatible = "nvidia,tegra186-pwm";
+		reg = <0x0 0xc340000 0x0 0x10000>;
+		clocks = <&bpmp TEGRA186_CLK_PWM4>;
+		clock-names = "pwm";
+		#pwm-cells = <2>;
+		resets = <&bpmp TEGRA186_RESET_PWM4>;
+		reset-names = "pwm";
+		status = "disabled";
+	};
 };
-- 
2.1.4
