From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH v3 0/6] R8A7795/Salvator-X PWM support
Date: Thu, 31 Mar 2016 13:39:10 +0200
Message-ID: <1459424356-26061-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34477 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771AbcCaLjz (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 31 Mar 2016 07:39:55 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, geert@linux-m68k.org
Cc: linux-pwm@vger.kernel.org, thierry.reding@gmail.com, magnus.damm@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Hi!

This revision adds the missing pwm0 node as well as Geert's endorsements.

CU
Uli

Changes since v2:
- add pwm0
- add Acked-By/Reviewed-By's

Changes since v1:
- drops the PFC driver bits that have been queued in sh-pfc-for-v4.6
- replaces ARCH_RCAR_GEN{1,2} with ARCH_RENESAS
- splits the DT patch in three
- enables only one pin group for each device
- describes what the PWM devices are used for
- adds the missing power domain entries
- adds module clock 523 to the MSSR driver


Harunobu Kurokawa (1):
  arm64: defconfig : add PWM driver support

Ryo Kodama (1):
  pwm: rcar: Use ARCH_RENESAS

Ulrich Hecht (4):
  arm64: dts: r8a7795: Add PWM device nodes
  arm64: dts: salvator-x: enable PWM
  pwm: add R-Car H3 device tree bindings
  clk: shmobile: r8a7795: add PWM clock

 .../devicetree/bindings/pwm/renesas,pwm-rcar.txt   |  1 +
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 23 ++++++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 63 ++++++++++++++++++++++
 arch/arm64/configs/defconfig                       |  2 +
 drivers/clk/renesas/r8a7795-cpg-mssr.c             |  1 +
 drivers/pwm/Kconfig                                |  2 +-
 6 files changed, 91 insertions(+), 1 deletion(-)

-- 
2.7.4
