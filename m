From: Huayi Li <huayi.li@csr.com>
Subject: [PATCH v5 3/4] ARM: dts: sirf: fix the pwm-cells and clocks
Date: Wed, 16 Jul 2014 09:55:13 +0800
Message-ID: <1405475714-10006-4-git-send-email-huayi.li@csr.com>
References: <1405475714-10006-1-git-send-email-huayi.li@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1405475714-10006-1-git-send-email-huayi.li@csr.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: rongjun.ying@csr.com, Huayi Li <huayi.li@csr.com>, barry.song@csr.com, workgroup.linux@csr.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

This patch adds missed pwm-cells, clock-names and signal source
clock for PWM module.

Signed-off-by: Huayi Li <huayi.li@csr.com>
---
 arch/arm/boot/dts/atlas6.dtsi | 8 ++++++--
 arch/arm/boot/dts/prima2.dtsi | 8 ++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
index bb22842..d424a69 100644
--- a/arch/arm/boot/dts/atlas6.dtsi
+++ b/arch/arm/boot/dts/atlas6.dtsi
@@ -638,10 +638,14 @@
                                 };
 			};
 
-			pwm@b0130000 {
+			pwm: pwm@b0130000 {
 				compatible = "sirf,prima2-pwm";
+				#pwm-cells = <2>;
 				reg = <0xb0130000 0x10000>;
-				clocks = <&clks 21>;
+				clocks = <&clks 21>, <&clks 1>, <&clks 2>,
+					<&clks 3>, <&clks 0>, <&clks 4>;
+				clock-names = "pwmc", "sigsrc0", "sigsrc1",
+					"sigsrc2", "sigsrc3", "sigsrc4";
 			};
 
 			efusesys@b0140000 {
diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
index 963b7e5..68bb0c4 100644
--- a/arch/arm/boot/dts/prima2.dtsi
+++ b/arch/arm/boot/dts/prima2.dtsi
@@ -646,10 +646,14 @@
                                 };
 			};
 
-			pwm@b0130000 {
+			pwm: pwm@b0130000 {
 				compatible = "sirf,prima2-pwm";
+				#pwm-cells = <2>;
 				reg = <0xb0130000 0x10000>;
-				clocks = <&clks 21>;
+				clocks = <&clks 21>, <&clks 1>, <&clks 2>,
+					<&clks 3>, <&clks 0>, <&clks 4>;
+				clock-names = "pwmc", "sigsrc0", "sigsrc1",
+					"sigsrc2", "sigsrc3", "sigsrc4";
 			};
 
 			efusesys@b0140000 {
-- 
1.9.3



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
