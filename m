From: YH Huang <yh.huang@mediatek.com>
Subject: [PATCH 0/2] Add Mediatek display PWM driver
Date: Mon, 11 May 2015 17:26:20 +0800
Message-ID: <1431336382-13167-1-git-send-email-yh.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-pwm@vger.kernel.org

This patch series add the use of display PWM driver and documentation 
for Mediatek SoCs. The driver is used to support the backlight of 
the panel. This is based on v4.1-rc1. 

YH Huang (2):
  dt-bindings: pwm: add Mediatek display PWM bindings
  pwm: add Mediatek display PWM driver support

 .../devicetree/bindings/pwm/pwm-disp-mediatek.txt  |  25 +++
 drivers/pwm/Kconfig                                |   9 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-disp-mediatek.c                    | 225 +++++++++++++++++++++
 4 files changed, 260 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-disp-mediatek.txt
 create mode 100644 drivers/pwm/pwm-disp-mediatek.c
