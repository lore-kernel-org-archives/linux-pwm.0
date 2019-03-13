From: Thierry Reding <thierry.reding@gmail.com>
Subject: [GIT PULL] pwm: Changes for v5.1-rc1
Date: Wed, 13 Mar 2019 15:51:18 +0100
Message-ID: <20190313145118.21818-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Linus,

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.1-rc1

for you to fetch changes up to d7d96312fe108d0df50898d212770b0a5b2d491e:

  pwm: atmel: Remove useless symbolic definitions (2019-03-04 12:52:49 +0100)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v5.1-rc1

The changes for this cycle are across the board. The bulk of it is
cleanups, but there's also new device support in some drivers as well as
more conversions to the atomic API.

----------------------------------------------------------------
Claudiu Beznea (5):
      pwm: atmel: Add struct atmel_pwm_data
      pwm: atmel: Add support for controllers with 32 bit counters
      pwm: atmel: Rename objects of type atmel_pwm_data
      pwm: atmel: Add PWM binding for SAM9X60
      pwm: atmel: Add support for SAM9X60's PWM controller

Dan Carpenter (1):
      pwm: imx: Signedness bug in imx_pwm_get_state()

Jitao Shi (1):
      pwm: Add MediaTek MT8183 display PWM driver support

Mathieu Othacehe (3):
      pwm: hibvt: Use individual struct per of-data
      dt-bindings: pwm: hibvt: Add hi3559v100 support
      pwm: hibvt: Add hi3559v100 support

Sheetal Tigadoli (1):
      pwm: bcm-kona: Update macros to remove braces around numbers

Thierry Reding (1):
      pwm: atmel: Remove useless symbolic definitions

Uwe Kleine-König (8):
      pwm: Don't use memcmp() to compare state variables
      pwm: Drop per-chip dbg_show callback
      pwm: Rearrange structures to group members by purpose
      pwm: imx: Remove if block where the condition is always wrong
      pwm: imx: Set driver data earlier simplifying the end of ->probe()
      pwm: imx: Don't print an error on -EPROBE_DEFER
      pwm: imx: Split into two drivers
      pwm: imx27: Only enable the clocks once in .get_state()

Yoshihiro Shimoda (4):
      pwm: rcar: Add support "atomic" API
      pwm: rcar: Use "atomic" API on rcar_pwm_resume()
      pwm: rcar: Remove legacy APIs
      pwm: rcar: Improve calculation of divider

 .../devicetree/bindings/pwm/atmel-pwm.txt          |   1 +
 .../devicetree/bindings/pwm/pwm-hibvt.txt          |   2 +
 drivers/pwm/Kconfig                                |  17 +-
 drivers/pwm/Makefile                               |   3 +-
 drivers/pwm/core.c                                 |  10 +-
 drivers/pwm/pwm-atmel.c                            | 111 ++++++----
 drivers/pwm/pwm-bcm-kona.c                         |  16 +-
 drivers/pwm/pwm-hibvt.c                            |  44 +++-
 drivers/pwm/pwm-imx1.c                             | 199 ++++++++++++++++++
 drivers/pwm/{pwm-imx.c => pwm-imx27.c}             | 224 ++++++---------------
 drivers/pwm/pwm-mtk-disp.c                         |  11 +
 drivers/pwm/pwm-rcar.c                             |  99 +++++----
 include/linux/pwm.h                                |  37 ++--
 13 files changed, 474 insertions(+), 300 deletions(-)
 create mode 100644 drivers/pwm/pwm-imx1.c
 rename drivers/pwm/{pwm-imx.c => pwm-imx27.c} (59%)
