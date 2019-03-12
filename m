From: Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 0/2] pwm: tiehrpwm: Enable EHRPWM for AM654 SoCs
Date: Tue, 12 Mar 2019 14:46:27 +0530
Message-ID: <20190312091629.31701-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

This series adds support for EHRPWM IP on TI AM654 SoC

Vignesh Raghavendra (2):
  dt-bindings: pwm: tiehrpwm: Add TI AM654 SoC specific compatible
  pwm: Kconfig: Enable ehrpwm driver to be compiled for ARCH_K3

 Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt | 1 +
 drivers/pwm/Kconfig                                    | 5 ++---
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.21.0
