From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH 0/3] Add pwm-cells on STM32 LPTimer
Date: Thu, 1 Feb 2018 14:44:35 +0100
Message-ID: <1517492678-767-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, alexandre.torgue@st.com
Cc: mark.rutland@arm.com, linux@armlinux.org.uk, mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Add missing generic #pwm-cells on STM32 LPTimer to allow initialization
of channel, period and polarity.

Fabrice Gasnier (1):
  ARM: dts: stm32: update pwm-cells for LPTimer on stm32h743

Gerald Baeza (2):
  dt-bindings: pwm-stm32-lp: add #pwm-cells
  pwm: stm32: LPTimer: use 3 cells xlate

 Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt | 3 +++
 arch/arm/boot/dts/stm32h743.dtsi                       | 5 +++++
 drivers/pwm/pwm-stm32-lp.c                             | 2 ++
 3 files changed, 10 insertions(+)

-- 
1.9.1
