From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH v2 8/8] ARM: dts: stm32: Enable pwm3 input capture on stm32f429i-eval
Date: Fri, 26 Jan 2018 16:11:39 +0100
Message-ID: <1516979499-3665-9-git-send-email-fabrice.gasnier@st.com>
References: <1516979499-3665-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516979499-3665-1-git-send-email-fabrice.gasnier@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, thierry.reding@gmail.com, robh+dt@kernel.org, alexandre.torgue@st.com, benjamin.gaignard@linaro.org
Cc: mark.rutland@arm.com, linux@armlinux.org.uk, mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com, benjamin.gaignard@st.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Enable pwm3 input capture on stm32f429i-eval, by using DMA.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32429i-eval.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index 293ecb9..d5498dd 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -271,6 +271,9 @@
 &timers3 {
 	status = "okay";
 
+	/* Enable PWM input capture by using dma */
+	dmas = <&dma1 4 5 0x400 0x0>;
+	dma-names = "ch1";
 	pwm {
 		pinctrl-0 = <&pwm3_pins>;
 		pinctrl-names = "default";
-- 
1.9.1
