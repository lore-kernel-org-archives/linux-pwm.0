From: Sandipan Patra <spatra@nvidia.com>
Subject: [PATCH V2 2/2] arm64: tegra: Add pwm-fan profile settings
Date: Mon, 1 Jun 2020 11:49:14 +0530
Message-ID: <1590992354-12623-2-git-send-email-spatra@nvidia.com>
References: <1590992354-12623-1-git-send-email-spatra@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-hwmon-owner@vger.kernel.org>
In-Reply-To: <1590992354-12623-1-git-send-email-spatra@nvidia.com>
Sender: linux-hwmon-owner@vger.kernel.org
To: treding@nvidia.com, jonathanh@nvidia.com, linux@roeck-us.net, kamil@wypas.org, jdelvare@suse.com, robh+dt@kernel.org, u.kleine-koenig@pengutronix.de
Cc: bbasu@nvidia.com, bbiswas@nvidia.com, kyarlagadda@nvidia.com, linux-pwm@vger.kernel.org, linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Sandipan Patra <spatra@nvidia.com>
List-Id: linux-pwm@vger.kernel.org

Add support for profiles in device tree to allow
different fan settings for trip point temp/hyst/pwm.

Signed-off-by: Sandipan Patra <spatra@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
index e15d1ea..ff2b980 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
@@ -219,10 +219,19 @@
 
 	fan: fan {
 		compatible = "pwm-fan";
-		pwms = <&pwm4 0 45334>;
-
-		cooling-levels = <0 64 128 255>;
 		#cooling-cells = <2>;
+		pwms = <&pwm4 0 45334>;
+		profiles {
+			default = "quiet";
+			quiet {
+				state_cap = <4>;
+				cooling-levels = <0 77 120 160 255 255 255 255 255 255>;
+			};
+			cool {
+				state_cap = <4>;
+				cooling-levels = <0 77 120 160 255 255 255 255 255 255>;
+			};
+		};
 	};
 
 	gpio-keys {
-- 
2.7.4
