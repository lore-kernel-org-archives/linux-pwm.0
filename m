From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 01/11] ARM: stih407: Add DT nodes for for PWM
Date: Mon, 14 Jul 2014 15:33:22 +0100
Message-ID: <1405348412-7352-2-git-send-email-lee.jones@linaro.org>
References: <1405348412-7352-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:64416 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755442AbaGNOdq (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Jul 2014 10:33:46 -0400
Received: by mail-ie0-f171.google.com with SMTP id at1so3343407iec.30
        for <linux-pwm@vger.kernel.org>; Mon, 14 Jul 2014 07:33:45 -0700 (PDT)
In-Reply-To: <1405348412-7352-1-git-send-email-lee.jones@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, kernel@stlinux.com, thierry.reding@gmail.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com

Supply top level nodes for the STiH407 based development boards.
The Pinctrl configuration has already been applied, so the only
missing piece of the DT puzzle is for a board's DTB to enable
the nodes.

Signed-off-by: Ajit Pal Singh <ajitpal.singh@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/stih407.dtsi b/arch/arm/boot/dts/stih407.dtsi
index 4f9024f..dc58b34 100644
--- a/arch/arm/boot/dts/stih407.dtsi
+++ b/arch/arm/boot/dts/stih407.dtsi
@@ -259,5 +259,33 @@
 
 			status = "disabled";
 		};
+
+		/* COMMS PWM Module */
+		pwm0: pwm@9810000 {
+			compatible	= "st,sti-pwm";
+			status		= "disabled";
+			#pwm-cells	= <2>;
+			reg		= <0x9810000 0x68>;
+			pinctrl-names	= "default";
+			pinctrl-0	= <&pinctrl_pwm0_chan0_default>;
+			clock-names	= "pwm";
+			clocks		= <&clk_sysin>;
+		};
+
+		/* SBC PWM Module */
+		pwm1: pwm@9510000 {
+			compatible	= "st,sti-pwm";
+			status		= "disabled";
+			#pwm-cells	= <2>;
+			reg		= <0x9510000 0x68>;
+			pinctrl-names	= "default";
+			pinctrl-0	= <&pinctrl_pwm1_chan0_default
+					&pinctrl_pwm1_chan1_default
+					&pinctrl_pwm1_chan2_default
+					&pinctrl_pwm1_chan3_default>;
+			clock-names	= "pwm";
+			clocks		= <&clk_sysin>;
+			st,pwm-num-chan = <4>;
+		};
 	};
 };
-- 
1.8.3.2

