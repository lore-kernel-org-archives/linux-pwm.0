From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [RESEND PATCH 3/3] ARM: dts: stm32: update pwm-cells for LPTimer on
 stm32h743
Date: Fri, 23 Feb 2018 14:36:05 +0100
Message-ID: <1519392965-28235-4-git-send-email-fabrice.gasnier@st.com>
References: <1519392965-28235-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1519392965-28235-1-git-send-email-fabrice.gasnier@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: thierry.reding@gmail.com, alexandre.torgue@st.com
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, benjamin.gaignard@linaro.org, linux-pwm@vger.kernel.org, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, robh+dt@kernel.org, mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

LPTimer pwm cells should be updated to 3, to allow initialization of
channel, period and polarity.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32h743.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
index bbfcbac..40d7d76 100644
--- a/arch/arm/boot/dts/stm32h743.dtsi
+++ b/arch/arm/boot/dts/stm32h743.dtsi
@@ -85,6 +85,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm-lp";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -238,6 +239,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm-lp";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -264,6 +266,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm-lp";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -285,6 +288,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm-lp";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 		};
@@ -300,6 +304,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm-lp";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 		};
-- 
1.9.1
