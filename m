From: Anson Huang <anson.huang@nxp.com>
Subject: [PATCH 1/5] dt-bindings: pwm: Add i.MX TPM PWM binding
Date: Mon, 11 Mar 2019 07:16:09 +0000
Message-ID: <1552288273-31028-2-git-send-email-Anson.Huang@nxp.com>
References: <1552288273-31028-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1552288273-31028-1-git-send-email-Anson.Huang@nxp.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "stefan@agner.ch" <stefan@agner.ch>, "otavio@ossystems.com.br" <otavio@ossystems.com.br>, Leonard Crestez <leonard.crestez@nxp.com>, "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>, "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>, Robin Gong <yibin.gong@nxp.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-pwm@vger.kernel.org

Add i.MX TPM(Low Power Timer/Pulse Width Modulation Module) PWM binding.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../devicetree/bindings/pwm/imx-tpm-pwm.txt        | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt

diff --git a/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt b/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
new file mode 100644
index 0000000..ebec313
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
@@ -0,0 +1,23 @@
+Freescale i.MX TPM PWM controller
+
+Required properties:
+- compatible : Should be "fsl,imx-tpm-pwm".
+- reg: Physical base address and length of the controller's registers.
+- #pwm-cells: Should be 2. See pwm.txt in this directory for a description of the cells format.
+- clocks : The clock provided by the SoC to drive the PWM.
+- interrupts: The interrupt for the pwm controller.
+
+Optional properties:
+- fsl,pwm-number : PWM channel number, if not defined, i.MX TPM PWM driver will use 2 by default.
+
+Example:
+
+pwm0: tpm@40250000 {
+	compatible = "fsl,imx-tpm-pwm";
+	reg = <0x40250000 0x1000>;
+	fsl,pwm-number = <6>;
+	assigned-clocks = <&clks IMX7ULP_CLK_LPTPM4>;
+	assigned-clock-parents = <&clks IMX7ULP_CLK_SOSC_BUS_CLK>;
+	clocks = <&clks IMX7ULP_CLK_LPTPM4>;
+	#pwm-cells = <2>;
+};
-- 
2.7.4
