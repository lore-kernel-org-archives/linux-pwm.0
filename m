From: Thierry Reding <thierry.reding@gmail.com>
Subject: [GIT PULL] pwm: Fixes for v5.4-rc7
Date: Fri,  8 Nov 2019 18:42:20 +0100
Message-ID: <20191108174220.3384630-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Linus,

The following changes since commit 40a6b9a00930fd6b59aa2eb6135abc2efe5440c3:

  Revert "pwm: Let pwm_get_state() return the last implemented state" (2019-10-21 16:48:52 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.4-rc7

for you to fetch changes up to 24906a41eecb73d51974ade0847c21e429beec60:

  pwm: bcm-iproc: Prevent unloading the driver module while in use (2019-11-08 18:38:06 +0100)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Fixes for v5.4-rc7

Here's one more fix to keep a reference to the driver's module as long
as there are users of the PWM exposed by the driver.

----------------------------------------------------------------
Uwe Kleine-König (1):
      pwm: bcm-iproc: Prevent unloading the driver module while in use

 drivers/pwm/pwm-bcm-iproc.c | 1 +
 1 file changed, 1 insertion(+)
