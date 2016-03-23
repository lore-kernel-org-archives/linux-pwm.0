From: Thierry Reding <thierry.reding@gmail.com>
Subject: [GIT PULL] pwm: Changes for v4.6-rc1
Date: Wed, 23 Mar 2016 17:13:37 +0100
Message-ID: <1458749617-21602-1-git-send-email-thierry.reding@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34254 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753493AbcCWQNm (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Mar 2016 12:13:42 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-4.6-rc1

for you to fetch changes up to 922201d129c8f9d0c3207dca90ea6ffd8e2242f0:

  pwm: omap-dmtimer: Add debug message for effective period and duty cycle (2016-03-23 17:11:48 +0100)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v4.6-rc1

No new drivers this time around, but a handful of cleanups and fixes.

----------------------------------------------------------------
David Rivshin (4):
      pwm: omap-dmtimer: Fix inaccurate period and duty cycle calculations
      pwm: omap-dmtimer: Add sanity checking for load and match values
      pwm: omap-dmtimer: Round load and match values rather than truncate
      pwm: omap-dmtimer: Add debug message for effective period and duty cycle

Simon Horman (1):
      pwm: rcar: Depend on ARCH_RENESAS instead of ARCH_SHMOBILE

Vladimir Zapolskiy (1):
      pwm: brcmstb: Fix check of devm_ioremap_resource() return code

Wolfram Sang (2):
      pwm: img: Test clock rate to avoid division by 0
      pwm: lpc18xx-sct: Test clock rate to avoid division by 0

 drivers/pwm/Kconfig            |  2 +-
 drivers/pwm/pwm-brcmstb.c      |  4 +--
 drivers/pwm/pwm-img.c          |  5 +++
 drivers/pwm/pwm-lpc18xx-sct.c  |  5 +++
 drivers/pwm/pwm-omap-dmtimer.c | 74 +++++++++++++++++++++++++++++++++---------
 5 files changed, 71 insertions(+), 19 deletions(-)
