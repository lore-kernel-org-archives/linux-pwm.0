From: Thierry Reding <thierry.reding@gmail.com>
Subject: [GIT PULL] pwm: Changes for v4.2-rc1
Date: Fri, 12 Jun 2015 16:56:14 +0200
Message-ID: <1434120974-4057-1-git-send-email-thierry.reding@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:35197 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753665AbbFLO4x (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 12 Jun 2015 10:56:53 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-4.2-rc1

for you to fetch changes up to 361c1066c939a88e3bb59364f47055b2a5fb3fd4:

  pwm: lpss: pci: Add support for Broxton platform (2015-06-12 12:46:50 +0200)

I'm sending this before the merge window opens because I'll be on
vacation for the better part of it. The set of changes below is rather
small and I don't expect any surprises. I should be back from vacation
shortly before the merge window closes, so in the unlikely event that
something comes up I should still have the time to fix it up.

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v4.2-rc1

This has a couple of fixes for Atmel, Samsung and Broadcom drivers. Some
preparatory patches for more upcoming Intel work is included as well.

----------------------------------------------------------------
Alexandre Belloni (2):
      pwm: atmel: Fix incorrect CDTY value after enabling
      pwm: atmel: Fix incorrect CDTY value after disabling

Arun Ramamurthy (1):
      pwm: bcm-kona: Don't set polarity in probe

Javier Martinez Canillas (1):
      pwm: samsung: Use MODULE_DEVICE_TABLE() to include OF modalias

Qipeng Zha (1):
      pwm: lpss: pci: Add support for Broxton platform

Shobhit Kumar (1):
      pwm: Add support to remove registered consumer lookup tables

Tim Kryger (1):
      pwm: Add pwmchip_add_with_polarity() API

 drivers/pwm/core.c         | 40 ++++++++++++++++++++++++++---
 drivers/pwm/pwm-atmel.c    | 63 +++++++++++++++++++++++++++++++++-------------
 drivers/pwm/pwm-bcm-kona.c |  9 +++----
 drivers/pwm/pwm-lpss-pci.c |  2 ++
 drivers/pwm/pwm-samsung.c  |  1 +
 include/linux/pwm.h        | 12 +++++++++
 6 files changed, 101 insertions(+), 26 deletions(-)
