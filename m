From: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH 2/6] ARM: dts exynos5420 update the cooling cells for core cpu0
Date: Fri, 27 Mar 2015 03:09:11 +1030
Message-ID: <1427387955-5129-3-git-send-email-linux.amoon@gmail.com>
References: <1427387955-5129-1-git-send-email-linux.amoon@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34946 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310AbbCZQkZ (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 26 Mar 2015 12:40:25 -0400
In-Reply-To: <1427387955-5129-1-git-send-email-linux.amoon@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>, Eduardo Valentin <edubezval@gmail.com>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Russell King <linux@arm.linux.org.uk>, Kukjin Kim <kgene@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>

update the cooling level for cpu0 to avoid following message.

root@odroidxu3:~# dmesg | grep ther
[    0.241511] /thermal-zones/cpu-thermal/cooling-maps/map0:
			 could not get #cooling-cells for /cpus/cpu@0

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index c0e98cf..6b49f3c 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -61,6 +61,10 @@
 			reg = <0x0>;
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
+
+			cooling-min-level = <10>;
+			cooling-max-level = <7>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu1: cpu@1 {
-- 
1.9.1

