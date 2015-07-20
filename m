From: YH Huang <yh.huang@mediatek.com>
Subject: [PATCH v6 0/3] Add MediaTek display PWM driver
Date: Mon, 20 Jul 2015 16:17:14 +0800
Message-ID: <1437380237-28961-1-git-send-email-yh.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:47752 "EHLO
	mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754908AbbGTIRZ (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jul 2015 04:17:25 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, yingjoe.chen@mediatek.com

This patch series add the use of display PWM driver, documentation 
and device tree for Mediatek SoCs. The driver is used to support 
the backlight of the panel. This is based on v4.2-rc1.

The clock definitions (CLK_MM_DISP_PWM*) are added by James Liao's patch: 
clk: mediatek: Add subsystem clocks of MT8173

Change in v6:
1. Enable clocks in the pwm_enable function
2. Remove suspend/resume code since pwm-backlight driver has done the same things
3. Revise some code to make it easier to read

YH Huang (3):
  dt-bindings: pwm: add MediaTek display PWM bindings
  pwm: add MediaTek display PWM driver support
  arm64: dts: mt8173: add MT8173 display PWM driver support node

 .../devicetree/bindings/pwm/pwm-mtk-disp.txt       |  42 ++++
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts        |  15 ++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  22 ++
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-mtk-disp.c                         | 232 +++++++++++++++++++++
 6 files changed, 322 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
 create mode 100644 drivers/pwm/pwm-mtk-disp.c

--
1.8.1.1.dirty
