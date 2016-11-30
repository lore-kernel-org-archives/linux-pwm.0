From: Thierry Reding <thierry.reding@gmail.com>
Subject: [GIT PULL] pwm: Fixes for v4.9
Date: Wed, 30 Nov 2016 19:47:10 +0100
Message-ID: <20161130184710.32278-1-thierry.reding@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33068 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752668AbcK3Sra (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 30 Nov 2016 13:47:30 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>, Johan Hovold <johan@kernel.org>

Hi Linus,

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-4.9

for you to fetch changes up to 0e1614ac84f1719d87bed577963bb8140d0c9ce8:

  pwm: Fix device reference leak (2016-11-29 16:43:24 +0100)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Fixes for v4.9

This contains two one-line fixes for issues that were introduced in
v4.9-rc1.

----------------------------------------------------------------
Axel Lin (1):
      pwm: meson: Add missing spin_lock_init()

Johan Hovold (1):
      pwm: Fix device reference leak

 drivers/pwm/pwm-meson.c | 1 +
 drivers/pwm/sysfs.c     | 2 ++
 2 files changed, 3 insertions(+)
