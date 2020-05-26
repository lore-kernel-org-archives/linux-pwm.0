From: Sandipan Patra <spatra-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2] arm64: tegra: Add pwm-fan profile settings
Date: Tue, 26 May 2020 10:36:05 +0530
Message-ID: <1590469565-14953-2-git-send-email-spatra@nvidia.com>
References: <1590469565-14953-1-git-send-email-spatra@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1590469565-14953-1-git-send-email-spatra-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, kamil-MZ2JYD8fkKLYtjvyW6yDsg@public.gmane.org, jdelvare-IBi9RG/b67k@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: bbasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, bbiswas-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sandipan Patra <spatra-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Add support for profiles in device tree to allow
different fan settings for trip point temp/hyst/pwm.

Signed-off-by: Sandipan Patra <spatra-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
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
