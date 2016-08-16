From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v4 06/17] ARM: dts: STiH416: Define the number of PWM Capture
 channels
Date: Tue, 16 Aug 2016 10:34:57 +0100
Message-ID: <20160816093508.28307-7-lee.jones@linaro.org>
References: <20160816093508.28307-1-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160816093508.28307-1-lee.jones@linaro.org>
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
Cc: linux-pwm@vger.kernel.org, kernel@stlinux.com, devicetree@vger.kernel.org, patrice.chotard@st.com, thierry.reding@gmail.com, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pwm@vger.kernel.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih416.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/stih416.dtsi
index bf15a32..422f9bd 100644
--- a/arch/arm/boot/dts/stih416.dtsi
+++ b/arch/arm/boot/dts/stih416.dtsi
@@ -487,6 +487,7 @@
 			clocks		= <&clk_sysin>, <&clk_s_a0_ls CLK_ICN_REG>;
 
 			st,pwm-num-chan = <4>;
+			st,capture-num-chan = <2>;
 		};
 
 		/* SBC PWM Module */
-- 
2.9.0
