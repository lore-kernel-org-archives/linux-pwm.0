From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH v3 0/6] Add support for PWM input capture on STM32
Date: Fri, 30 Mar 2018 12:01:18 +0200
Message-ID: <1522404084-24903-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, thierry.reding@gmail.com, alexandre.torgue@st.com
Cc: benjamin.gaignard@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com, benjamin.gaignard@st.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

This series adds support for capture to stm32-pwm driver.
Capture is based on DMAs.
- First two patches add support for requesting DMAs to MFD core
- Next three patches add support for capture to stm32-pwm driver
- This has been tested on stm32429i-eval board.

---
Changes in v3:
- Dropped 2 precusor patches applied by Thierry in pwm tree:
  "pwm: stm32: fix, remove unused struct device"
  "pwm: stm32: protect common prescaler for all channels"
- Note: this series applies on top on pwm tree
- Implements Lee's comments on MFD part: rework stm32_timers_dma struct,
  exported routine prototype now use generic device struct, more
  various comments (see patch 2 changelog).

Resend v2:
- Add collected Acks

Changes in v2:
- Abstract DMA handling from child driver: move it to MFD core
- Rework pwm capture routines to adopt this change
- Comment on optional dma support, beautify DMAs probe

Fabrice Gasnier (6):
  dt-bindings: mfd: stm32-timers: add support for dmas
  mfd: stm32-timers: add support for dmas
  pwm: stm32: add capture support
  pwm: stm32: improve capture by tuning counter prescaler
  pwm: stm32: use input prescaler to improve period capture
  ARM: dts: stm32: Enable pwm3 input capture on stm32f429i-eval

 .../devicetree/bindings/mfd/stm32-timers.txt       |  20 ++
 arch/arm/boot/dts/stm32429i-eval.dts               |   3 +
 drivers/mfd/stm32-timers.c                         | 219 +++++++++++++++++-
 drivers/pwm/pwm-stm32.c                            | 257 +++++++++++++++++++++
 include/linux/mfd/stm32-timers.h                   |  44 ++++
 5 files changed, 541 insertions(+), 2 deletions(-)

-- 
1.9.1
