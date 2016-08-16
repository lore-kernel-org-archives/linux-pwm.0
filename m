From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v4 02/17] ARM: dts: STiH407: Declare PWM Capture data lines via Pinctrl
Date: Tue, 16 Aug 2016 10:34:53 +0100
Message-ID: <20160816093508.28307-3-lee.jones@linaro.org>
References: <20160816093508.28307-1-lee.jones@linaro.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35599 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753387AbcHPJfl (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 16 Aug 2016 05:35:41 -0400
Received: by mail-wm0-f45.google.com with SMTP id f65so132120936wmi.0
        for <linux-pwm@vger.kernel.org>; Tue, 16 Aug 2016 02:35:40 -0700 (PDT)
In-Reply-To: <20160816093508.28307-1-lee.jones@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, patrice.chotard@st.com, thierry.reding@gmail.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-pinctrl.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
index a538ae5..bc22122 100644
--- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
@@ -289,10 +289,12 @@
 				pinctrl_pwm1_chan0_default: pwm1-0-default {
 					st,pins {
 						pwm-out = <&pio3 0 ALT1 OUT>;
+						pwm-capturein = <&pio3 2 ALT1 IN>;
 					};
 				};
 				pinctrl_pwm1_chan1_default: pwm1-1-default {
 					st,pins {
+						pwm-capturein = <&pio4 3 ALT1 IN>;
 						pwm-out = <&pio4 4 ALT1 OUT>;
 					};
 				};
@@ -1030,6 +1032,7 @@
 			pwm0 {
 				pinctrl_pwm0_chan0_default: pwm0-0-default {
 					st,pins {
+						pwm-capturein = <&pio31 0 ALT1 IN>;
 						pwm-out = <&pio31 1 ALT1 OUT>;
 					};
 				};
-- 
2.9.0
