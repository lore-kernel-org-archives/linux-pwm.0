From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH 0/6] R8A7795/Salvator-X PWM support
Date: Wed,  9 Mar 2016 17:55:56 +0100
Message-ID: <1457542562-7880-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, geert@linux-m68k.org
Cc: linux-pwm@vger.kernel.org, magnus.damm@gmail.com, thierry.reding@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-pwm@vger.kernel.org

Hi!

This revision of the PWM for Salvator-X integration series attempts to address the
issues found in Geert's review (thanks for that).  Specifically, it

- drops the PFC driver bits that have been queued in sh-pfc-for-v4.6
- replaces ARCH_RCAR_GEN{1,2} with ARCH_RENESAS
- splits the DT patch in three
- enables only one pin group for each device
- describes what the PWM devices are used for
- adds the missing power domain entries
- adds module clock 523 to the MSSR driver

CU
Uli


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
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 23 +++++++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 54 ++++++++++++++++++++++
 arch/arm64/configs/defconfig                       |  2 +
 drivers/clk/renesas/r8a7795-cpg-mssr.c             |  1 +
 drivers/pwm/Kconfig                                |  2 +-
 6 files changed, 82 insertions(+), 1 deletion(-)

-- 
2.6.4
