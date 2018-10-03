From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 0/2] pwm-tiecap: Add support for AM654 SoCs
Date: Wed, 3 Oct 2018 22:36:56 +0530
Message-ID: <20181003170658.3835-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vignesh R <vigneshr@ti.com>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

Couple of patches to enable pwm-tiecap driver to be used with TI's new
AM654 platforms.

Vignesh R (2):
  dt-bindings: pwm: tiecap: Add TI AM654 SoC specific compatible
  pwm: Kconfig: Enable TI ECAP driver for ARCH_K3

 Documentation/devicetree/bindings/pwm/pwm-tiecap.txt | 1 +
 drivers/pwm/Kconfig                                  | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.19.0
