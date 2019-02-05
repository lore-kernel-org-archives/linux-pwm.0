From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH 0/4] Add PM support to STM32 LP Timer drivers
Date: Tue, 5 Feb 2019 13:40:25 +0100
Message-ID: <1549370429-19116-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jic23@kernel.org, thierry.reding@gmail.com, robh+dt@kernel.org
Cc: mark.rutland@arm.com, alexandre.torgue@st.com, mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, vilhelm.gray@gmail.com, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-pwm@vger.kernel.org

This patch series adds power management support for STM32 LP Timer
drivers:
- PWM driver
- IIO counter driver
- Document the pinctrl states for sleep mode

Fabrice Gasnier (4):
  dt-bindings: pwm-stm32-lp: document pinctrl sleep state
  pwm: stm32-lp: Add power management support
  dt-bindings: iio: stm32-lptimer-counter: document pinctrl sleep state
  iio: counter: stm32-lptimer: Add power management support

 .../bindings/iio/counter/stm32-lptimer-cnt.txt     |  8 ++--
 .../devicetree/bindings/pwm/pwm-stm32-lp.txt       |  9 ++--
 drivers/iio/counter/stm32-lptimer-cnt.c            | 55 ++++++++++++++++++++++
 drivers/pwm/pwm-stm32-lp.c                         | 38 +++++++++++++++
 4 files changed, 104 insertions(+), 6 deletions(-)

-- 
1.9.1
