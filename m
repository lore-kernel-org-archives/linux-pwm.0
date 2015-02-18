From: Thierry Reding <thierry.reding@gmail.com>
Subject: [GIT PULL] pwm: Changes for v3.20-rc1
Date: Wed, 18 Feb 2015 09:43:50 +0100
Message-ID: <1424249030-9911-1-git-send-email-thierry.reding@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:49049 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbbBRInx (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Feb 2015 03:43:53 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-3.20-rc1

for you to fetch changes up to b65af27ad89de60ca55721f9368b18d49ba1f269:

  pwm: tegra: Use NSEC_PER_SEC (2015-02-18 08:40:29 +0100)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v3.20-rc1

This contains two new drivers, one for Allwinner SoCs and the other for
Imagination Technologies' Pistachio SoC.

Complementing this are a couple of fixes to the Atmel HLCDC PWM and STi
PWM drivers as well as minor cleanups to the core and the Tegra driver.

----------------------------------------------------------------
Ajit Pal Singh (1):
      pwm: sti: Maintain a bitmap of configured devices

Alexandre Belloni (2):
      pwm: Add Allwinner SoC support
      pwm: sunxi: document OF bindings

Boris BREZILLON (1):
      pwm: atmel-hlcdc: Prevent division by zero

Markus Elfring (1):
      pwm: Remove unnecessary check before of_node_put()

Naidu Tellapati (2):
      pwm: Imagination Technologies PWM DAC driver
      pwm: Add device tree binding document for IMG PWM DAC

Thierry Reding (2):
      pwm: atmel-hlcdc: Depend on HAVE_CLK
      pwm: tegra: Use NSEC_PER_SEC

 Documentation/devicetree/bindings/pwm/img-pwm.txt  |  24 ++
 .../devicetree/bindings/pwm/pwm-sun4i.txt          |  20 ++
 drivers/pwm/Kconfig                                |  24 ++
 drivers/pwm/Makefile                               |   2 +
 drivers/pwm/core.c                                 |   2 +-
 drivers/pwm/pwm-atmel-hlcdc.c                      |   6 +
 drivers/pwm/pwm-img.c                              | 249 ++++++++++++++
 drivers/pwm/pwm-sti.c                              |  30 +-
 drivers/pwm/pwm-sun4i.c                            | 366 +++++++++++++++++++++
 drivers/pwm/pwm-tegra.c                            |   2 +-
 10 files changed, 704 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/img-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
 create mode 100644 drivers/pwm/pwm-img.c
 create mode 100644 drivers/pwm/pwm-sun4i.c
