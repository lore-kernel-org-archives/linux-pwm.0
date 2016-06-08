From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v3 20/20] dt-bindings: pwm: sti: Update DT bindings with recent changes
Date: Wed,  8 Jun 2016 10:21:35 +0100
Message-ID: <20160608092135.21184-21-lee.jones@linaro.org>
References: <20160608092135.21184-1-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160608092135.21184-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, maxime.coquelin@st.com, patrice.chotard@st.com, thierry.reding@gmail.com, robh+dt@kernel.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pwm@vger.kernel.org

We're renaming the 'st,pwm-num-chan' binding to 'st,pwm-num-devs' to
be more inline with the naming conventions of the subsystem.  Where
we used to treat each line as a channel, the PWM convention is to
describe them as devices.

The second documentation adaption entails adding support for PWM
capture devices.  A new clock is required as well as an IRQ line.
We're also adding a new property similar to the one described
above, but for capture channels.  Typically, there will be less
capture channels than PWM-out, since all channels have the latter
capability, but only some have capture support.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/devicetree/bindings/pwm/pwm-st.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-st.txt b/Documentation/devicetree/bindings/pwm/pwm-st.txt
index 84d2fb8..b09f3a4 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-st.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-st.txt
@@ -13,13 +13,14 @@ Required parameters:
 - pinctrl-0: 		List of phandles pointing to pin configuration nodes
 			for PWM module.
 			For Pinctrl properties, please refer to [1].
-- clock-names: 		Set to "pwm".
+- clock-names: 		Valid entries are "pwm" and/or "capture".
 - clocks: 		phandle of the clock used by the PWM module.
 			For Clk properties, please refer to [2].
+- interrupts:		IRQ for the Capture device
 
 Optional properties:
-- st,pwm-num-chan:	Number of available channels. If not passed, the driver
-			will consider single channel by default.
+- st,pwm-num-devs:	Number of available PWM channels.  Default is 0.
+- st,capture-num-devs:	Number of available Capture channels.  Default is 0.
 
 [1] Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
 [2] Documentation/devicetree/bindings/clock/clock-bindings.txt
@@ -37,5 +38,6 @@ pwm1: pwm@fe510000 {
 		     &pinctrl_pwm1_chan3_default>;
 	clocks = <&clk_sysin>;
 	clock-names = "pwm";
-	st,pwm-num-chan = <4>;
+	st,pwm-num-devs = <4>;
+	st,capture-num-devs = <2>;
 };
-- 
2.8.3
