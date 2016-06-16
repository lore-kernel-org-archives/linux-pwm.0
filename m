From: Thierry Reding <thierry.reding@gmail.com>
Subject: [GIT PULL] pwm: Fixes for v4.7-rc4
Date: Thu, 16 Jun 2016 18:25:19 +0200
Message-ID: <20160616162519.14243-1-thierry.reding@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35394 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752615AbcFPQZY (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 16 Jun 2016 12:25:24 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-4.7-rc4

for you to fetch changes up to cc51846ba81ca179a3be20f6313e3b72531888c1:

  pwm: atmel-hlcdc: Fix default PWM polarity (2016-06-14 10:51:45 +0200)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Fixes for v4.7-rc4

These changes fix a bit of fallout from the introduction of the atomic
API.

----------------------------------------------------------------
Boris Brezillon (1):
      pwm: atmel-hlcdc: Fix default PWM polarity

Brian Norris (1):
      pwm: Improve args checking in pwm_apply_state()

Ryo Kodama (1):
      pwm: sysfs: Get return value from pwm_apply_state()

 drivers/pwm/core.c            | 3 ++-
 drivers/pwm/pwm-atmel-hlcdc.c | 2 +-
 drivers/pwm/sysfs.c           | 2 +-
 include/linux/pwm.h           | 3 +++
 4 files changed, 7 insertions(+), 3 deletions(-)
