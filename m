From: YH Huang <yh.huang@mediatek.com>
Subject: Re: [PATCH v7 0/3] Add MediaTek display PWM driver
Date: Tue, 15 Sep 2015 11:52:53 +0800
Message-ID: <1442289173.11445.5.camel@mtksdaap41>
References: <1439882875-19596-1-git-send-email-yh.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:41966 "EHLO
	mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751633AbbIODw7 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Sep 2015 23:52:59 -0400
In-Reply-To: <1439882875-19596-1-git-send-email-yh.huang@mediatek.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, srv_heupstream <srv_heupstream@mediatek.com>, Pawel Moll <pawel.moll@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>, Yingjoe Chen =?UTF-8?Q?=28=E9=99=B3=E8=8B=B1=E6=B4=B2=29?= <Yingjoe.Chen@mediatek.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, 2015-08-18 at 15:27 +0800, YH Huang wrote:
> This patch series add the use of display PWM driver, documentation
> and device tree for Mediatek SoCs. The driver is used to support
> the backlight of the panel. This is based on v4.2-rc1.
> 
> The clock definitions (CLK_MM_DISP_PWM*) are added by James Liao's patch:
> clk: mediatek: Add subsystem clocks of MT8173
> 
> Change in v7:
> 1. Add the dependency HAS_IOMEM in Kconfig.
> 2. Revise misprints and coding style for readability.
> 
> Change in v6:
> 1. Enable clocks in the pwm_enable function.
> 2. Remove suspend/resume code since pwm-backlight driver has done the
> same things.
> 3. Revise some code to make it easier to read.
> 
> Change in v5:
> 1. Configure PWM output via pinctrl.
> 2. Fix the parameter name in dtsi.
> 
> Change in v4:
> 1. Codebase is on v4.2-rc1.
> 2. Add the PWM node in dtsi.
> 3. Change the dependency in Kconfig.
> 4. Rewrite some code for readability.
> 
> Change in v3:
> 1. Add suspend/resume function.
> 2. Fix the formula for high_width calculation.
> 3. Rewrite some code to make it easier to read.
> 4. Add more information in the commit message.
> 
> Change in v2:
> 1. Rewrite descriptions for driver in kconfig to make it much clear.
> 2. Rename the driver from "pwm-mediatek-disp" to "pwm-mtk-disp".
> 3. Disable clocks in the error path.
> 4. Change the shift values in decimal instead of hex.
> 5. Rename and add some variables or function name for consistency and
> readability.
> 6. Drop unnecessary parentheses, spaces, variables and add newlines to
> make the code easiler to read.
> 
> YH Huang (3):
>   dt-bindings: pwm: add MediaTek display PWM bindings
>   pwm: add MediaTek display PWM driver support
>   arm64: dts: mt8173: add MT8173 display PWM driver support node
> 
>  .../devicetree/bindings/pwm/pwm-mtk-disp.txt       |   42 ++++
>  arch/arm64/boot/dts/mediatek/mt8173-evb.dts        |   13 ++
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi           |   22 ++
>  drivers/pwm/Kconfig                                |   11 +
>  drivers/pwm/Makefile                               |    1 +
>  drivers/pwm/pwm-mtk-disp.c                         |  232 ++++++++++++++++++++
>  6 files changed, 321 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
>  create mode 100644 drivers/pwm/pwm-mtk-disp.c
> 
> --
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Hi Thierry,

Will you please pick up these patches in your pwm tree?
Should I rebase to 4.3-rc1?

Regards,
YH Huang
