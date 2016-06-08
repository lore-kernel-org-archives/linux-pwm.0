From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v3 04/20] ARM: dts: STiH416: Supply PWM Capture IRQs
Date: Wed,  8 Jun 2016 10:21:19 +0100
Message-ID: <20160608092135.21184-5-lee.jones@linaro.org>
References: <20160608092135.21184-1-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160608092135.21184-1-lee.jones@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: linux-pwm@vger.kernel.org, kernel@stlinux.com, devicetree@vger.kernel.org, patrice.chotard@st.com, robh+dt@kernel.org, thierry.reding@gmail.com, Lee Jones <lee.jones@linaro.org>, maxime.coquelin@st.com
List-Id: linux-pwm@vger.kernel.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih416.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/stih416.dtsi
index 82091072..28d84c71 100644
--- a/arch/arm/boot/dts/stih416.dtsi
+++ b/arch/arm/boot/dts/stih416.dtsi
@@ -475,6 +475,7 @@
 			status		= "okay";
 			#pwm-cells	= <2>;
 			reg		= <0xfed10000 0x68>;
+			interrupts      = <GIC_SPI 200 IRQ_TYPE_NONE>;
 
 			pinctrl-names	= "default";
 			pinctrl-0 = 	<&pinctrl_pwm0_chan0_default
@@ -494,6 +495,7 @@
 			status		= "disabled";
 			#pwm-cells	= <2>;
 			reg		= <0xfe510000 0x68>;
+			interrupts      = <GIC_SPI 202 IRQ_TYPE_NONE>;
 
 			pinctrl-names	= "default";
 			pinctrl-0	= <&pinctrl_pwm1_chan0_default
-- 
2.8.3
