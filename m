From: Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH 6/8] LS1021A: dtsi: add ftm quad decoder entries
Date: Mon, 18 Feb 2019 15:03:19 +0100
Message-ID: <20190218140321.19166-6-patrick.havelange@essensium.com>
References: <20190218140321.19166-1-patrick.havelange@essensium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190218140321.19166-1-patrick.havelange@essensium.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Thierry Reding <thierry.reding@gmail.com>, Esben Haabendal <esben@haabendal.dk>, William Breathitt Gray <vilhelm.gray@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Patrick Havelange <patrick.havelange@essensium.com>
List-Id: linux-pwm@vger.kernel.org

Add the 4 Quadrature counters for this board.

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Reviewed-by: Esben Haabendal <esben@haabendal.dk>
---
 arch/arm/boot/dts/ls1021a.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index ed0941292172..0168fb62590a 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -433,6 +433,34 @@
 			status = "disabled";
 		};
 
+		counter0: counter@29d0000 {
+			compatible = "fsl,ftm-quaddec";
+			reg = <0x0 0x29d0000 0x0 0x10000>;
+			big-endian;
+			status = "disabled";
+		};
+
+		counter1: counter@29e0000 {
+			compatible = "fsl,ftm-quaddec";
+			reg = <0x0 0x29e0000 0x0 0x10000>;
+			big-endian;
+			status = "disabled";
+		};
+
+		counter2: counter@29f0000 {
+			compatible = "fsl,ftm-quaddec";
+			reg = <0x0 0x29f0000 0x0 0x10000>;
+			big-endian;
+			status = "disabled";
+		};
+
+		counter3: counter@2a00000 {
+			compatible = "fsl,ftm-quaddec";
+			reg = <0x0 0x2a00000 0x0 0x10000>;
+			big-endian;
+			status = "disabled";
+		};
+
 		gpio0: gpio@2300000 {
 			compatible = "fsl,ls1021a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2300000 0x0 0x10000>;
-- 
2.17.1
