From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH v2 1/3] dt-bindings: mfd: update STM32 timers clock names
Date: Wed, 14 Jun 2017 17:13:14 +0200
Message-ID: <1497453196-31470-2-git-send-email-fabrice.gasnier@st.com>
References: <1497453196-31470-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1497453196-31470-1-git-send-email-fabrice.gasnier@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: lee.jones@linaro.org, benjamin.gaignard@linaro.org, jic23@kernel.org, thierry.reding@gmail.com, robh+dt@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.torgue@st.com, linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com, linux-arm-kernel@lists.infradead.org, benjamin.gaignard@st.com
List-Id: linux-pwm@vger.kernel.org

Clock name has been updated during driver/DT binding review:
https://lkml.org/lkml/2016/12/13/718
Update DT binding doc to reflect this.

Fixes: 8f9359c6c6a0 (dt-bindings: mfd: Add bindings for STM32 Timers driver)
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Acked-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 Documentation/devicetree/bindings/mfd/stm32-timers.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/stm32-timers.txt b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
index bbd083f..1db6e00 100644
--- a/Documentation/devicetree/bindings/mfd/stm32-timers.txt
+++ b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
@@ -31,7 +31,7 @@ Example:
 		compatible = "st,stm32-timers";
 		reg = <0x40010000 0x400>;
 		clocks = <&rcc 0 160>;
-		clock-names = "clk_int";
+		clock-names = "int";
 
 		pwm {
 			compatible = "st,stm32-pwm";
-- 
1.9.1
