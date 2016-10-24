From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/4] pwm: lpss: clean up series
Date: Mon, 24 Oct 2016 17:43:21 +0300
Message-ID: <20161024144325.130353-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:12069 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757556AbcJXOna (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 24 Oct 2016 10:43:30 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

There are clean ups and switch to new atomic API (would be considered as an
improvement).

The series tested on various Intel platforms, such as Edison and Minnowboard
MAX.

And the part I like most is -2 lines statistics!

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
2.9.3
