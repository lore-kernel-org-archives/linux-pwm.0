From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 0/2] pwm: Add support for R-Car PWM Timer
Date: Tue, 19 May 2015 19:42:37 +0900
Message-ID: <1432032159-704-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:62620 "EHLO
	relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754556AbbESKmw (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 19 May 2015 06:42:52 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: linux-pwm@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch set is based on the linux-pwm.git / for-next branch.
(commit id = efb0de55b6a2ec15fc424e660601f22ae2fa487a)

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

 .../devicetree/bindings/pwm/renesas,pwm-rcar.txt   |  26 ++
 drivers/pwm/Kconfig                                |  11 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-rcar.c                             | 268 +++++++++++++++++++++
 4 files changed, 306 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
 create mode 100644 drivers/pwm/pwm-rcar.c

-- 
1.9.1
