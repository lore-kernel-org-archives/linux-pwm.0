From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v7 0/2] pwm: Add support for R-Car PWM Timer
Date: Wed, 30 Sep 2015 17:47:51 +0900
Message-ID: <1443602873-4316-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: linux-pwm@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-pwm@vger.kernel.org

This patch set is based on the latest linux-pwm.git / for-next branch.
(commit id = a83a6a82250fe900be85c8e142f5cb504d9482bd)

Changes from v6:
 - Modify rcar_pwm_set_counter() to be readable code.
 - Add a condition not to call rcar_pwm_set_clock_control() in rcar_pwm_config.
 - Remove chip.of_xlate setting to use of_pwm_simple_xlate().

Changes from v5:
 - Fix coding style and unreadable code in patch 2.
 - Add "Reviewed-by: Simon Horman <horms+renesas@verge.net.au>".

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
 drivers/pwm/pwm-rcar.c                             | 266 +++++++++++++++++++++
 4 files changed, 305 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
 create mode 100644 drivers/pwm/pwm-rcar.c

-- 
1.9.1

