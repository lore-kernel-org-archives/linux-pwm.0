From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH 0/2] Add PM support to STM32 Timer PWM
Date: Mon, 30 Sep 2019 17:39:09 +0200
Message-ID: <1569857951-20007-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org
Cc: alexandre.torgue@st.com, mark.rutland@arm.com, mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, benjamin.gaignard@st.com, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-pwm@vger.kernel.org

This patch series adds power management support for STM32 Timer PWM:
- Document the pinctrl sleep state for STM32 Timer PWM
- STM32 Timer PWM driver

Fabrice Gasnier (2):
  dt-bindings: pwm-stm32: document pinctrl sleep state
  pwm: stm32: add power management support

 .../devicetree/bindings/pwm/pwm-stm32.txt          |  8 ++-
 drivers/pwm/pwm-stm32.c                            | 82 ++++++++++++++++------
 2 files changed, 67 insertions(+), 23 deletions(-)

-- 
2.7.4
