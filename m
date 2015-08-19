From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v6 0/2] pwm: Add support for R-Car PWM Timer
Date: Wed, 19 Aug 2015 13:13:57 +0900
Message-ID: <1439957639-4816-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:31926 "EHLO
	relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750833AbbHSEOJ (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Aug 2015 00:14:09 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: linux-pwm@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch set is based on the latest linux-pwm.git / for-next branch.
(commit id = 6e146f5c41da7e9601fe92fb4d06b45431dbf95b)

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
 drivers/pwm/pwm-rcar.c                             | 265 +++++++++++++++++++++
 4 files changed, 304 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
 create mode 100644 drivers/pwm/pwm-rcar.c

-- 
1.9.1
