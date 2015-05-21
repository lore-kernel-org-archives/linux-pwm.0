From: YH Huang <yh.huang@mediatek.com>
Subject: [PATCH v2 0/2] Add MediaTek display PWM driver
Date: Thu, 21 May 2015 21:29:22 +0800
Message-ID: <1432214964-40644-1-git-send-email-yh.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-pwm@vger.kernel.org

YH Huang (2):
  dt-bindings: pwm: add MediaTek display PWM bindings
  pwm: add MediaTek display PWM driver support

 .../devicetree/bindings/pwm/pwm-mtk-disp.txt       |  25 +++
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-mtk-disp.c                         | 228 +++++++++++++++++++++
 4 files changed, 264 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
 create mode 100644 drivers/pwm/pwm-mtk-disp.c

--
1.8.1.1.dirty
