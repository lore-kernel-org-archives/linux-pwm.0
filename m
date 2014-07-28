From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 0/2] pwm: lpss: split driver to core and probe drivers
Date: Mon, 28 Jul 2014 18:03:10 +0300
Message-ID: <1406559792-30652-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:59583 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752552AbaG1PEN (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Mon, 28 Jul 2014 11:04:13 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This small series makes the architecture of pwm-lpss driver cleaner.

Since v2:
- fix one more typo in Kconfig (tested with one line removed in my config now)

Since v1:
- hide struct definition in the core part
- rename pwm-lpss-plat to pwm-lpss-platform
- fix Kconfig dependencies and other typos
- add Mika's Reviewed-by tag
- fix spelling in the commit messages

Andy Shevchenko (2):
  pwm: lpss: properly split driver to parts
  pwm: lpss: pci: move to use pcim_enable_device()

 drivers/pwm/Kconfig             |  21 ++++++-
 drivers/pwm/Makefile            |   2 +
 drivers/pwm/pwm-lpss-pci.c      |  68 ++++++++++++++++++++++
 drivers/pwm/pwm-lpss-platform.c |  61 ++++++++++++++++++++
 drivers/pwm/pwm-lpss.c          | 125 ++--------------------------------------
 drivers/pwm/pwm-lpss.h          |  29 ++++++++++
 6 files changed, 186 insertions(+), 120 deletions(-)
 create mode 100644 drivers/pwm/pwm-lpss-pci.c
 create mode 100644 drivers/pwm/pwm-lpss-platform.c
 create mode 100644 drivers/pwm/pwm-lpss.h

-- 
2.0.1

