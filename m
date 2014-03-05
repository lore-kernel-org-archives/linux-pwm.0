From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH v4 3/4] ARM: dts: sirf: fix the pwm-cells and clocks for pwm
Date: Wed,  5 Mar 2014 18:01:16 +0800
Message-ID: <1394013677-6423-1-git-send-email-21cnbao@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:47318 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754120AbaCEKBi (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 5 Mar 2014 05:01:38 -0500
Received: by mail-pd0-f179.google.com with SMTP id w10so850953pde.24
        for <linux-pwm@vger.kernel.org>; Wed, 05 Mar 2014 02:01:38 -0800 (PST)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, workgroup.linux@csr.com, Barry Song <Baohua.Song@csr.com>

From: Barry Song <Baohua.Song@csr.com>

this patch adds missed pwm-cells, clock-names and signal source clock for
PWM module.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas6.dtsi |    5 +++--
 arch/arm/boot/dts/prima2.dtsi |    6 ++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
index f8674bc..18090bc 100644
--- a/arch/arm/boot/dts/atlas6.dtsi
+++ b/arch/arm/boot/dts/atlas6.dtsi
@@ -612,10 +612,11 @@
                                 };
 			};
 
-			pwm@b0130000 {
+			pwm: pwm@b0130000 {
 				compatible = "sirf,prima2-pwm";
 				reg = <0xb0130000 0x10000>;
-				clocks = <&clks 21>;
+				clocks = <&clks 21>, <&clks 1>;
+				clock-names = "pwmc", "sigsrc0";
 			};
 
 			efusesys@b0140000 {
diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
index 0e21993..ed49c00 100644
--- a/arch/arm/boot/dts/prima2.dtsi
+++ b/arch/arm/boot/dts/prima2.dtsi
@@ -640,10 +640,12 @@
                                 };
 			};
 
-			pwm@b0130000 {
+			pwm: pwm@b0130000 {
 				compatible = "sirf,prima2-pwm";
+				#pwm-cells = <2>;
 				reg = <0xb0130000 0x10000>;
-				clocks = <&clks 21>;
+				clocks = <&clks 21>, <&clks 1>;
+				clock-names = "pwmc", "sigsrc0";
 			};
 
 			efusesys@b0140000 {
-- 
1.7.5.4

