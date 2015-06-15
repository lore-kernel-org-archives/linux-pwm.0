From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v5 0/2] pwm: Add support for R-Car PWM Timer
Date: Mon, 15 Jun 2015 18:08:42 +0900
Message-ID: <1434359324-2964-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: linux-pwm@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-pwm@vger.kernel.org

This patch set is based on the linux-pwm.git / for-next branch.
(commit id = 361c1066c939a88e3bb59364f47055b2a5fb3fd4)

Changes from v4:
 - Clean up coding style and typo in patch 2.
 - Change to_rcar_pwm_chip() macro to static inline function in patch 2.
 - Use writel()/readl() instead of iowrite32()/ioread32() in patch 2.
 - Add an error handling in rcar_pwm_config() to avoid silent in patch 2.
 - Remove success message in rcar_pwm_probe() in patch 2.
 - Change rcar_pwm_remove() to always call pm_runtime_disable() in patch 2.

Changes from v3:
 - Fix register size in patch 1.
 - Add "Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>" in patch 1
 - Remove an unnecessary definition in patch 2.
 - Use "ULL" to avoid overflow in patch 2.
 - Remove unnecessary casts in patch 2.

Changes from v2:
 - Add compatible string "renesas,pwm-rcar".
 - Remove compatible strings "renesas,pwm-r8a77xx" in rcar_pwm_of_table.
 - Fix build error.

Changes from v1:
 - Change compatible string to SoC-specific compatible values.
 - Fix #pwm-call value to 2 in the device tree document.
 - Fix "depends on" value in Kconfig.
 - Fix help explanation in Kconfig.
 - Remove an unnecessary member in rcar_pwm_chip.
 - Remove hardcoded number of channels and change chip.npwm value to 1.
 - Fix formulas for clock calculation to improve accuracy.

Yoshihiro Shimoda (2):
  pwm: Add device tree binding document for R-Car PWM Timer
  pwm: Add support for R-Car PWM Timer

 .../devicetree/bindings/pwm/renesas,pwm-rcar.txt   |  27 +++
 drivers/pwm/Kconfig                                |  11 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-rcar.c                             | 263 +++++++++++++++++++++
 4 files changed, 302 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
 create mode 100644 drivers/pwm/pwm-rcar.c

-- 
1.9.1

