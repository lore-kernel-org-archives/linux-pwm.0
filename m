From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 0/4] Add Allwinner SoCs PWM support
Date: Mon, 31 Mar 2014 14:07:25 +0200
Message-ID: <1396267649-18009-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-pwm@vger.kernel.org

Hi,

This patch set adds support for the PWM controller found on the Allwinner SoCs.

The first patch adds the driver itself.
The second patch adds the DT binding documentation
The third patch adds the bindings to the sun7i-a20 DTS include.
And finally, the la patch adds support for the PWMs to the cubietruck which is
the board I used to test.

Alexandre Belloni (4):
  pwm: Add Allwinner SoC support
  pwm: sunxi: document OF bindings
  ARM: sun7i: dt: add PWM support
  ARM: sunxi: dt: Add PWM support for the cubietruck

 .../devicetree/bindings/pwm/pwm-sunxi.txt          |  19 ++
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts         |   6 +
 arch/arm/boot/dts/sun7i-a20.dtsi                   |  22 ++
 drivers/pwm/Kconfig                                |   9 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-sunxi.c                            | 325 +++++++++++++++++++++
 6 files changed, 382 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sunxi.txt
 create mode 100644 drivers/pwm/pwm-sunxi.c

-- 
1.8.3.2

