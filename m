From: Thierry Reding <thierry.reding@gmail.com>
Subject: [GIT PULL] pwm: Fixes for v5.4-rc6
Date: Sat,  2 Nov 2019 14:48:00 +0100
Message-ID: <20191102134800.3847540-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Linus,

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.4-rc6

for you to fetch changes up to 40a6b9a00930fd6b59aa2eb6135abc2efe5440c3:

  Revert "pwm: Let pwm_get_state() return the last implemented state" (2019-10-21 16:48:52 +0200)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Fixes for v5.4-rc6

It turned out that relying solely on drivers storing all the PWM state
in hardware was a little premature and causes a number of subtle (and
some not so subtle) regressions. Revert the offending patch for now.

----------------------------------------------------------------
Thierry Reding (1):
      Revert "pwm: Let pwm_get_state() return the last implemented state"

 drivers/pwm/core.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)
