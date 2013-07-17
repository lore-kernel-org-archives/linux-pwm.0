Return-Path: <laurent.pinchart+renesas@ideasonboard.com>
From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 0/4] Add PWM polarity flag macro for DT
Date: Thu, 18 Jul 2013 00:54:20 +0200
Message-Id: <1374101664-21112-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Boris BREZILLON <linux-arm@overkiz.com>, Shawn Guo <shawn.guo@linaro.org>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Stephen Warren <swarren@wwwdotorg.org>, Tomasz Figa <t.figa@samsung.com>

Hello,

Here's a small patch set that replaces PWM polarity numerical constants with
macros in DT.

The series is the result of splitting the original patch into four patches
that

- add the flag macro (both in a header file and in the PWM DT binding core
  documentation)
- use the macro in the PWM core code
- update existing DT bindings to refer to the PWM DT bindings core
  documentation
- update existing DT sources to use the new macro

I believe I've taken all comments received so far into account. Most notable
changes include

- splitting the original patch
- removing the PWM_POLARITY_NORMAL flag, which wasn't a flag but was defined
  as 0
- renaming the PWM_POLARITY_INVERSED DT flag to PWM_POLARITY_INVERTED
- not relying on DT flags and PWM C flags having identical names and values

Laurent Pinchart (4):
  pwm: Add PWM polarity flag macro for DT
  pwm: Use the DT macro directly when parsing PWM DT flags
  pwm: Update DT bindings to reference pwm.txt for cells documentation
  ARM: dts: Use the PWM polarity flags

 Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt    |  8 +++-----
 Documentation/devicetree/bindings/pwm/imx-pwm.txt          |  4 ++--
 Documentation/devicetree/bindings/pwm/mxs-pwm.txt          |  4 ++--
 .../devicetree/bindings/pwm/nvidia,tegra20-pwm.txt         |  5 ++---
 Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt  |  4 ++--
 Documentation/devicetree/bindings/pwm/pwm-samsung.txt      | 10 +++-------
 Documentation/devicetree/bindings/pwm/pwm-tiecap.txt       |  8 +++-----
 Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt     |  8 +++-----
 Documentation/devicetree/bindings/pwm/pwm.txt              |  7 ++++---
 Documentation/devicetree/bindings/pwm/spear-pwm.txt        |  5 ++---
 Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt       |  4 ++--
 Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt    |  4 ++--
 Documentation/devicetree/bindings/pwm/vt8500-pwm.txt       |  8 +++-----
 arch/arm/boot/dts/am335x-evmsk.dts                         |  3 ++-
 arch/arm/boot/dts/wm8850-w70v2.dts                         |  3 ++-
 drivers/pwm/core.c                                         |  7 +++----
 include/dt-bindings/pwm/pwm.h                              | 14 ++++++++++++++
 17 files changed, 54 insertions(+), 52 deletions(-)
 create mode 100644 include/dt-bindings/pwm/pwm.h

-- 
Regards,

Laurent Pinchart
