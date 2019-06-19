From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH 0/5] Add missing pwm-cells to STM32 timers PWM
Date: Wed, 19 Jun 2019 11:52:00 +0200
Message-ID: <1560937925-8990-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, alexandre.torgue@st.com
Cc: mark.rutland@arm.com, linux@armlinux.org.uk, mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, benjamin.gaignard@st.com, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-pwm@vger.kernel.org

This series adds missing generic 3-cells PWM to STM32 timers dt-bindings,
PWM driver, and the relevant dtsi files for STM32F4, STM32F7 and STM32MP1.

Fabrice Gasnier (5):
  dt-bindings: pwm-stm32: add #pwm-cells
  pwm: stm32: use 3 cells ->of_xlate()
  ARM: dts: stm32: add pwm cells to stm32mp157c
  ARM: dts: stm32: add pwm cells to stm32f429
  ARM: dts: stm32: add pwm cells to stm32f746

 Documentation/devicetree/bindings/pwm/pwm-stm32.txt |  3 +++
 arch/arm/boot/dts/stm32f429.dtsi                    | 12 ++++++++++++
 arch/arm/boot/dts/stm32f746.dtsi                    | 12 ++++++++++++
 arch/arm/boot/dts/stm32mp157c.dtsi                  | 12 ++++++++++++
 drivers/pwm/pwm-stm32.c                             |  2 ++
 5 files changed, 41 insertions(+)

-- 
2.7.4
