From: Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH 4/8] dt-bindings: iio/counter: ftm-quaddec
Date: Mon, 18 Feb 2019 15:03:17 +0100
Message-ID: <20190218140321.19166-4-patrick.havelange@essensium.com>
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

FlexTimer quadrature decoder driver.

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Reviewed-by: Esben Haabendal <esben@haabendal.dk>
---
 .../bindings/iio/counter/ftm-quaddec.txt       | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/counter/ftm-quaddec.txt

diff --git a/Documentation/devicetree/bindings/iio/counter/ftm-quaddec.txt b/Documentation/devicetree/bindings/iio/counter/ftm-quaddec.txt
new file mode 100644
index 000000000000..4d18cd722074
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/counter/ftm-quaddec.txt
@@ -0,0 +1,18 @@
+FlexTimer Quadrature decoder counter
+
+This driver exposes a simple counter for the quadrature decoder mode.
+
+Required properties:
+- compatible:		Must be "fsl,ftm-quaddec".
+- reg:			Must be set to the memory region of the flextimer.
+
+Optional property:
+- big-endian:		Access the device registers in big-endian mode.
+
+Example:
+		counter0: counter@29d0000 {
+			compatible = "fsl,ftm-quaddec";
+			reg = <0x0 0x29d0000 0x0 0x10000>;
+			big-endian;
+			status = "disabled";
+		};
-- 
2.17.1
