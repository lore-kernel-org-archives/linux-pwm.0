From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 0/4] K2G: Add support for PWM ECAP
Date: Mon, 7 Aug 2017 17:19:39 +0530
Message-ID: <20170807114943.22612-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: Vignesh R <vigneshr@ti.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

This series adds support for TI ECAP PWM IP present in 66AK2G SoC.
Based on linux-next.

Vignesh R (4):
  pwm: pwm-tiecap: Add TI 66AK2G SoC specific compatible
  ARM: dts: keystone-k2g: Add ECAP PWM DT nodes
  ARM: dts: keystone-k2g-evm: Enable PWM ECAP0
  ARM: configs: keystone: Enable TIECAP PWM driver

 Documentation/devicetree/bindings/pwm/pwm-tiecap.txt |  1 +
 arch/arm/boot/dts/keystone-k2g-evm.dts               | 12 ++++++++++++
 arch/arm/boot/dts/keystone-k2g.dtsi                  | 20 ++++++++++++++++++++
 arch/arm/configs/keystone_defconfig                  |  2 ++
 4 files changed, 35 insertions(+)

-- 
2.13.3
