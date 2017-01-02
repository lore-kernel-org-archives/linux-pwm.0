From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/4] pwm: lpss: clean up series
Date: Mon,  2 Jan 2017 11:16:43 +0200
Message-ID: <20170102091647.86910-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:58606 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755156AbdABJQw (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 2 Jan 2017 04:16:52 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ilkka Koskinen <ilkka.koskinen@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

There are clean ups and switch to new atomic API (would be considered as an
improvement).

The series tested on various Intel platforms, such as Edison and Minnowboard
MAX.

And the part I like most is -2 lines statistics!

Thierry, what should we do to get this series in? It was already more than 2
months of waiting for response from you. Two pings went to black hole.
So, Cc'ing to Linus directly this time, sorry.

Since v1:
- rebase on top of v4.10-rc2
- fix typo in commit message of patch 1
- add Mika's tag

Andy Shevchenko (3):
  pwm: lpss: Avoid potential overflow of base_unit
  pwm: lpss: Allow duty cycle to be 0
  pwm: lpss: Switch to new atomic API

Mika Westerberg (1):
  pwm: lpss: Do not export board infos for different PWM types

 drivers/pwm/pwm-lpss-pci.c      |  20 +++----
 drivers/pwm/pwm-lpss-platform.c |  10 ++--
 drivers/pwm/pwm-lpss.c          | 120 +++++++++++++++++++++-------------------
 drivers/pwm/pwm-lpss.h          |  14 ++---
 4 files changed, 81 insertions(+), 83 deletions(-)

-- 
2.11.0
