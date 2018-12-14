From: Yash Shah <yash.shah@sifive.com>
Subject: [RFC v2 0/2] PWM support for HiFive Unleashed
Date: Fri, 14 Dec 2018 11:50:40 +0530
Message-ID: <1544768442-12530-1-git-send-email-yash.shah@sifive.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: palmer@sifive.com, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sachin.ghadi@sifive.com, paul.walmsley@sifive.com, Yash Shah <yash.shah@sifive.com>
List-Id: linux-pwm@vger.kernel.org

This patch series adds PWM drivers and DT documentation for 
HiFive Unleashed board. The patches are mostly based on Wesley's patch.
V2 of this patchset incorporates below items pointed out in v1.

V2 changed from V1:
  1. Remove inclusion of dt-bindings/pwm/pwm.h
  2. Remove artificial alignments
  3. Replace ioread32/iowrite32 with readl/writel
  4. Remove camelcase
  5. Change dev_info to dev_dbg for unnecessary log
  6. Correct typo in driver name
  7. Remove use of of_match_ptr macro
  8. Update the DT compatible strings and Add reference to a common
     versioning document

Yash Shah (2):
  pwm: sifive: Add DT documentation for SiFive PWM Controller
  pwm: sifive: Add a driver for SiFive SoC PWM

 .../devicetree/bindings/pwm/pwm-sifive.txt         |  44 ++++
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-sifive.c                           | 229 +++++++++++++++++++++
 4 files changed, 284 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
 create mode 100644 drivers/pwm/pwm-sifive.c

-- 
1.9.1
