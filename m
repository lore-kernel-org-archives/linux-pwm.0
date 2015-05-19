From: Thierry Reding <thierry.reding@gmail.com>
Subject: [GIT PULL] pwm: Fixes for v4.1-rc5
Date: Tue, 19 May 2015 16:13:22 +0200
Message-ID: <1432044802-27375-1-git-send-email-thierry.reding@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36196 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932811AbbESON2 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 19 May 2015 10:13:28 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Naidu Tellapati <naidu.tellapati@imgtec.com>, Ezequiel Garcia <ezequiel.garcia@imgtec.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-4.1-rc5

for you to fetch changes up to 1e70897d0e20f988abedcf73b33684ecd2be9511:

  pwm: img: Impose upper and lower timebase steps value (2015-05-19 16:07:40 +0200)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Fixes for v4.1-rc5

A single fix to make the Pistachio driver respect the limits imposed by
hardware.

----------------------------------------------------------------
Naidu Tellapati (1):
      pwm: img: Impose upper and lower timebase steps value

 drivers/pwm/pwm-img.c | 76 +++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 64 insertions(+), 12 deletions(-)
