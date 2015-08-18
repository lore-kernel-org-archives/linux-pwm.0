From: YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v7 0/3] Add MediaTek display PWM driver
Date: Tue, 18 Aug 2015 15:27:52 +0800
Message-ID: <1439882875-19596-1-git-send-email-yh.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

This patch series add the use of display PWM driver, documentation 
and device tree for Mediatek SoCs. The driver is used to support 
the backlight of the panel. This is based on v4.2-rc1.

The clock definitions (CLK_MM_DISP_PWM*) are added by James Liao's patch: 
clk: mediatek: Add subsystem clocks of MT8173

Change in v7:
1. Add the dependency HAS_IOMEM in Kconfig.
2. Revise misprints and coding style for readability.

Change in v6:
1. Enable clocks in the pwm_enable function.
2. Remove suspend/resume code since pwm-backlight driver has done the
same things.
3. Revise some code to make it easier to read.

Change in v5:
1. Configure PWM output via pinctrl.
2. Fix the parameter name in dtsi.

Change in v4:
1. Codebase is on v4.2-rc1.
2. Add the PWM node in dtsi.
3. Change the dependency in Kconfig.
4. Rewrite some code for readability.

Change in v3:
1. Add suspend/resume function.
2. Fix the formula for high_width calculation.
3. Rewrite some code to make it easier to read.
4. Add more information in the commit message.

Change in v2:
1. Rewrite descriptions for driver in kconfig to make it much clear.
2. Rename the driver from "pwm-mediatek-disp" to "pwm-mtk-disp".
3. Disable clocks in the error path.
4. Change the shift values in decimal instead of hex.
5. Rename and add some variables or function name for consistency and
readability.
6. Drop unnecessary parentheses, spaces, variables and add newlines to
make the code easiler to read.

YH Huang (3):
  dt-bindings: pwm: add MediaTek display PWM bindings
  pwm: add MediaTek display PWM driver support
  arm64: dts: mt8173: add MT8173 display PWM driver support node

 .../devicetree/bindings/pwm/pwm-mtk-disp.txt       |   42 ++++
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts        |   13 ++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |   22 ++
 drivers/pwm/Kconfig                                |   11 +
 drivers/pwm/Makefile                               |    1 +
 drivers/pwm/pwm-mtk-disp.c                         |  232 ++++++++++++++++++++
 6 files changed, 321 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
 create mode 100644 drivers/pwm/pwm-mtk-disp.c

--
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
