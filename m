From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 02/11] ARM: stih416: Add Pinctrl settings for PWM
Date: Mon, 14 Jul 2014 15:33:23 +0100
Message-ID: <1405348412-7352-3-git-send-email-lee.jones@linaro.org>
References: <1405348412-7352-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:45825 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755669AbaGNOdt (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Jul 2014 10:33:49 -0400
Received: by mail-ig0-f182.google.com with SMTP id c1so1782430igq.9
        for <linux-pwm@vger.kernel.org>; Mon, 14 Jul 2014 07:33:47 -0700 (PDT)
In-Reply-To: <1405348412-7352-1-git-send-email-lee.jones@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, kernel@stlinux.com, thierry.reding@gmail.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com

Supply the Pinctrl configuration to enable PWM{0,1} lines on STiH416
based development boards.

Signed-off-by: Ajit Pal Singh <ajitpal.singh@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih416-pinctrl.dtsi | 50 ++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm/boot/dts/stih416-pinctrl.dtsi b/arch/arm/boot/dts/stih416-pinctrl.dtsi
index ee6c119..04e61d6 100644
--- a/arch/arm/boot/dts/stih416-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih416-pinctrl.dtsi
@@ -207,6 +207,29 @@
 					};
 				};
 			};
+
+			pwm1 {
+				pinctrl_pwm1_chan0_default: pwm1-0-default {
+					st,pins {
+						pwm-out    = <&PIO3 0 ALT1 OUT>;
+					};
+				};
+				pinctrl_pwm1_chan1_default: pwm1-1-default {
+					st,pins {
+						pwm-out    = <&PIO4 4 ALT1 OUT>;
+					};
+				};
+				pinctrl_pwm1_chan2_default: pwm1-2-default {
+					st,pins {
+						pwm-out    = <&PIO4 6 ALT3 OUT>;
+					};
+				};
+				pinctrl_pwm1_chan3_default: pwm1-3-default {
+					st,pins {
+						pwm-out    = <&PIO4 7 ALT3 OUT>;
+					};
+				};
+			};
 		};
 
 		pin-controller-front {
@@ -301,6 +324,14 @@
 				st,bank-name	= "PIO31";
 			};
 
+			pwm0 {
+				pinctrl_pwm0_chan0_default: pwm0-0-default {
+					st,pins {
+						pwm-out    = <&PIO9 7 ALT2 OUT>;
+					};
+				};
+			};
+
 			serial2-oe {
 				pinctrl_serial2_oe: serial2-1 {
 					st,pins {
@@ -467,6 +498,25 @@
 					};
 				};
 			};
+
+			pwm0 {
+				pinctrl_pwm0_chan1_default: pwm0-1-default {
+					st,pins {
+						pwm-out    = <&PIO13 2 ALT2 OUT>;
+					};
+				};
+				pinctrl_pwm0_chan2_default: pwm0-2-default {
+					st,pins {
+						pwm-out    = <&PIO15 2 ALT4 OUT>;
+					};
+				};
+				pinctrl_pwm0_chan3_default: pwm0-3-default {
+					st,pins {
+						pwm-out    = <&PIO17 4 ALT1 OUT>;
+					};
+				};
+			};
+
 		};
 
 		pin-controller-fvdp-fe {
-- 
1.8.3.2

