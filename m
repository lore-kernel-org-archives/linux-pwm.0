From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v2 0/2] pwm-tiecap: Add support for AM654 SoCs
Date: Tue, 16 Oct 2018 11:34:00 +0530
Message-ID: <20181016060402.18756-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vignesh R <vigneshr@ti.com>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, Andrew Davis <afd@ti.com>
List-Id: linux-pwm@vger.kernel.org

Couple of patches to enable pwm-tiecap driver to be used with TI's new
AM654 platforms.

Vignesh R (2):
  dt-bindings: pwm: tiecap: Add TI AM654 SoC specific compatible
  pwm: Kconfig: Enable TI ECAP driver for ARCH_K3

 Documentation/devicetree/bindings/pwm/pwm-tiecap.txt | 1 +
 drivers/pwm/Kconfig                                  | 5 ++---
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.19.1
