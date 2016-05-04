Return-Path: <mtk07307@mhfsdccf11>
From: Weiqing Kong <weiqing.kong@mediatek.com>
Subject: [PATCH 0/3] Support Mediatek Soc MT2701 disp pwm
Date: Wed, 4 May 2016 14:53:24 +0800
Message-ID: <1462344807-6336-1-git-send-email-weiqing.kong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: mtk07307@mhfsdccf11
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, weiqing.kong@mediatek.com
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>, erin.lo@medaitek.com, yingjoe.chen@mediatek.com, yh.huang@mediatek.com

These series patches modify pwm-mtk-disp.c
and dts/dtsi config to support MT2701 disp pwm.

Weiqing Kong (3):
  dt-bindings: pwm: Add MediaTek display PWM bindings
  pwm: Add MediaTek MT2701 display PWM driver support
  dts: Add disp bls dsti and dts config for MT2701

 .../devicetree/bindings/pwm/pwm-mtk-disp.txt       |  5 +-
 arch/arm/boot/dts/mt2701-evb.dts                   | 29 +++++++
 arch/arm/boot/dts/mt2701.dtsi                      |  9 +++
 drivers/pwm/pwm-mtk-disp.c                         | 89 +++++++++++++++++-----
 4 files changed, 113 insertions(+), 19 deletions(-)

-- 
1.9.1
