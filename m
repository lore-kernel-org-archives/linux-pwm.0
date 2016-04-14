From: Thierry Reding <thierry.reding@gmail.com>
Subject: [GIT PULL] pwm: Fixes for v4.6-rc4
Date: Thu, 14 Apr 2016 17:18:56 +0200
Message-ID: <1460647136-3268-1-git-send-email-thierry.reding@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
List-Id: linux-pwm@vger.kernel.org

Hi Linus,

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-4.6-rc4

for you to fetch changes up to ad06fdeeef1cbadf86ebbe510e8079abada8b44e:

  pwm: fsl-ftm: Use flat regmap cache (2016-04-14 16:54:00 +0200)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Fixes for v4.6-rc4

A single one-line fix to turn the regmap cache from an RB-tree to a flat
cache to avoid lockdep and abort issues.

----------------------------------------------------------------
Stefan Agner (1):
      pwm: fsl-ftm: Use flat regmap cache

 drivers/pwm/pwm-fsl-ftm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
