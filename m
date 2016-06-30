From: Thierry Reding <thierry.reding@gmail.com>
Subject: [GIT PULL] pwm: Fixes for v4.7-rc6
Date: Thu, 30 Jun 2016 11:10:03 +0200
Message-ID: <20160630091003.411-1-thierry.reding@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Linus,

The following changes since commit cc51846ba81ca179a3be20f6313e3b72531888c1:

  pwm: atmel-hlcdc: Fix default PWM polarity (2016-06-14 10:51:45 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-4.7-rc6

for you to fetch changes up to 33cdcee04be3b4482be97393167e7561b2584e1e:

  pwm: Fix pwm_apply_args() (2016-06-23 18:37:05 +0200)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Fixes for v4.7-rc6

One more fix for some fallout observed after the introduction of the
atomic API.

----------------------------------------------------------------
Boris Brezillon (1):
      pwm: Fix pwm_apply_args()

 include/linux/pwm.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)
