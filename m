From: YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 1/2] dt-bindings: pwm: add Mediatek display PWM bindings
Date: Mon, 11 May 2015 17:26:21 +0800
Message-ID: <1431336382-13167-2-git-send-email-yh.huang@mediatek.com>
References: <1431336382-13167-1-git-send-email-yh.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1431336382-13167-1-git-send-email-yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Document the device-tree binding of Mediatek display PWM.

Signed-off-by: YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 .../devicetree/bindings/pwm/pwm-disp-mediatek.txt  | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-disp-mediatek.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-disp-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-disp-mediatek.txt
new file mode 100644
index 0000000..ef54e9d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-disp-mediatek.txt
@@ -0,0 +1,25 @@
+Mediatek display PWM controller
+
+Required properties:
+ - compatible: should be "mediatek,<name>-disp-pwm"
+   - "mediatek,mt8173-disp-pwm": found on mt8173 SoC
+   - "mediatek,mt6595-disp-pwm": found on mt6595 SoC
+ - reg: physical base address and length of the controller's registers
+ - #pwm-cells: must be 2. See pwm.txt in this directory
+   for a description of the cell format
+ - clocks: phandle and clock specifier of the PWM reference clock
+ - clock-names: must contain the following
+   - "main": clock used to generate PWM signals
+   - "mm": sync signals from the modules of mmsys
+
+Example:
+	pwm0: pwm@1401e000 {
+		compatible = "mediatek,mt8173-disp-pwm",
+			     "mediatek,mt6595-disp-pwm";
+		reg = <0 0x1401e000 0 0x1000>;
+		#pwm-cells = <2>;
+		clocks = <&mmsys MM_DISP_PWM026M>,
+			 <&mmsys MM_DISP_PWM0MM>;
+		clock-names = "main",
+			      "mm";
+	};
-- 
1.8.1.1.dirty

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
