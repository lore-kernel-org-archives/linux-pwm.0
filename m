From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 0/6] pwm: lpss: Fix and clean up series
Date: Sat, 28 Jan 2017 17:10:38 +0200
Message-ID: <20170128151044.87572-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:2813 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751697AbdA1PO3 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 28 Jan 2017 10:14:29 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, Ilkka Koskinen <ilkka.koskinen@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

There are clean ups and switch to new atomic API (would be considered as
an improvement).

The series tested on various Intel platforms, such as Edison and
Minnowboard MAX.

Since v2:
- rebase on top of v4.10-rc5
- replace patch 3 with duplicating board info files in bus drivers
- eliminate reminders of legacy API
- incorporate Mika's Gemini Lake patch
- add new patch from Ilkka

Since v1:
- rebase on top of v4.10-rc2
- fix typo in commit message of patch 1
- add Mika's tag

Andy Shevchenko (4):
  pwm: lpss: Avoid potential overflow of base_unit
  pwm: lpss: Allow duty cycle to be 0
  pwm: lpss: Switch to new atomic API
  pwm: lpss: Do not export board infos for different PWM types

Ilkka Koskinen (1):
  pwm: lpss: Avoid reconfiguring while UPDATE bit is still enabled

Mika Westerberg (1):
  pwm: lpss: Add Intel Gemini Lake PCI ID

 drivers/pwm/pwm-lpss-pci.c      |  22 +++++++
 drivers/pwm/pwm-lpss-platform.c |  21 +++++++
 drivers/pwm/pwm-lpss.c          | 132 ++++++++++++++++++++--------------------
 drivers/pwm/pwm-lpss.h          |   4 --
 4 files changed, 110 insertions(+), 69 deletions(-)

-- 
2.11.0
