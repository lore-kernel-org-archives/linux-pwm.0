From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 0/2] pwm: lpss: split driver to core and probe drivers
Date: Tue, 19 Aug 2014 19:17:34 +0300
Message-ID: <1408465056-8605-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:24445 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751741AbaHSQTn (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Tue, 19 Aug 2014 12:19:43 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Alan Cox <alan@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This small series makes the architecture of pwm-lpss driver cleaner.

Since v3:
- rebased on top of recent linux-next
- rebased on top of Alan's patch for Braswell

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
 drivers/pwm/pwm-lpss-pci.c      |  65 +++++++++++++++++++
 drivers/pwm/pwm-lpss-platform.c |  69 ++++++++++++++++++++
 drivers/pwm/pwm-lpss.c          | 136 +++-------------------------------------
 drivers/pwm/pwm-lpss.h          |  32 ++++++++++
 6 files changed, 198 insertions(+), 127 deletions(-)
 create mode 100644 drivers/pwm/pwm-lpss-pci.c
 create mode 100644 drivers/pwm/pwm-lpss-platform.c
 create mode 100644 drivers/pwm/pwm-lpss.h

-- 
2.1.0

