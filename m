From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH 0/8] Add support for PWM input capture on STM32
Date: Tue, 16 Jan 2018 13:43:43 +0100
Message-ID: <1516106631-18722-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, thierry.reding@gmail.com, robh+dt@kernel.org, alexandre.torgue@st.com, benjamin.gaignard@linaro.org
Cc: mark.rutland@arm.com, linux@armlinux.org.uk, mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com, benjamin.gaignard@st.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

This series adds support for capture to stm32-pwm driver.
Capture is based on DMAs.
- First two patches are precursor patches
- Subsequent two patches add support for requesting DMAs to MFD core
- Next three patches add support for capture to stm32-pwm driver
- This has been tested on stm32429i-eval board.

Fabrice Gasnier (8):
  pwm: stm32: fix, remove unused struct device
  pwm: stm32: protect common prescaler for all channels
  dt-bindings: mfd: stm32-timers: add support for dmas
  mfd: stm32-timers: add support for dmas
  pwm: stm32: add capture support
  pwm: stm32: improve capture by tuning counter prescaler
  pwm: stm32: use input prescaler to improve period capture
  ARM: dts: stm32: Enable pwm3 input capture on stm32f429i-eval

 .../devicetree/bindings/mfd/stm32-timers.txt       |  20 +
 arch/arm/boot/dts/stm32429i-eval.dts               |   3 +
 drivers/mfd/stm32-timers.c                         |  37 +-
 drivers/pwm/pwm-stm32.c                            | 407 ++++++++++++++++++++-
 include/linux/mfd/stm32-timers.h                   |  31 ++
 5 files changed, 492 insertions(+), 6 deletions(-)

-- 
1.9.1
