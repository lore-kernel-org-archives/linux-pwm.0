From: YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v5 1/3] dt-bindings: pwm: add MediaTek display PWM bindings
Date: Mon, 13 Jul 2015 17:04:52 +0800
Message-ID: <1436778294-47635-2-git-send-email-yh.huang@mediatek.com>
References: <1436778294-47635-1-git-send-email-yh.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1436778294-47635-1-git-send-email-yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Document the device-tree binding of MediatTek display PWM.
The PWM has one channel to control the backlight brightness for display.
It supports MT8173 and MT6595.

Signed-off-by: YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 .../devicetree/bindings/pwm/pwm-mtk-disp.txt       | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
new file mode 100644
index 0000000..aac29dc
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
@@ -0,0 +1,29 @@
+MediaTek display PWM controller
+
+Required properties:
+ - compatible: should be "mediatek,<name>-disp-pwm":
+   - "mediatek,mt8173-disp-pwm": found on mt8173 SoC.
+   - "mediatek,mt6595-disp-pwm": found on mt6595 SoC.
+ - reg: physical base address and length of the controller's registers.
+ - #pwm-cells: must be 2. See pwm.txt in this directory for a description of
+   the cell format.
+ - clocks: phandle and clock specifier of the PWM reference clock.
+ - clock-names: must contain the following:
+   - "main": clock used to generate PWM signals.
+   - "mm": sync signals from the modules of mmsys.
+ - pinctrl-names: Must contain a "default" entry.
+ - pinctrl-0: One property must exist for each entry in pinctrl-names.
+   See pinctrl/pinctrl-bindings.txt for details of the property values.
+
+Example:
+	pwm0: pwm@1401e000 {
+		compatible = "mediatek,mt8173-disp-pwm",
+			     "mediatek,mt6595-disp-pwm";
+		reg = <0 0x1401e000 0 0x1000>;
+		#pwm-cells = <2>;
+		clocks = <&mmsys CLK_MM_DISP_PWM026M>,
+			 <&mmsys CLK_MM_DISP_PWM0MM>;
+		clock-names = "main", "mm";
+		pinctrl-names = "default";
+		pinctrl-0 = <&disp_pwm0_pins>;
+	};
-- 
1.8.1.1.dirty
