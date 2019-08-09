From: Thierry Reding <thierry.reding@gmail.com>
Subject: [GIT PULL] pwm: Fixes for v5.3-rc4
Date: Fri,  9 Aug 2019 15:48:48 +0200
Message-ID: <20190809134848.18297-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Linus,

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.3-rc4

for you to fetch changes up to 6cf9481b440da6d6d86bd8e4c99a8b553b9d1271:

  pwm: Fallback to the static lookup-list when acpi_pwm_get fails (2019-08-08 13:17:38 +0200)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Fixes for v5.3-rc4

This contains a single fix for a backlight brightness regression
introduced in v5.3-rc1.

----------------------------------------------------------------
Hans de Goede (1):
      pwm: Fallback to the static lookup-list when acpi_pwm_get fails

 drivers/pwm/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)
