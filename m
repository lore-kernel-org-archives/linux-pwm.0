From: kbuild test robot <fengguang.wu@intel.com>
Subject: [pwm:for-4.12/drivers 6/11] drivers/pwm/pwm-mediatek.c:210:3-8: No
 need to set .owner here. The core will do it.
Date: Thu, 13 Apr 2017 04:54:42 +0800
Message-ID: <201704130438.qZYSDVF1%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:22070 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752851AbdDLUyw (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 12 Apr 2017 16:54:52 -0400
Content-Disposition: inline
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: John Crispin <john@phrozen.org>
Cc: kbuild-all@01.org, linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git for-4.12/drivers
head:   de758fcd8e31fa308bfb80e7bfd19f81e0c05967
commit: caf065f8fd583b43a3f95d84c8a0a0d07597963b [6/11] pwm: Add MediaTek PWM support


coccinelle warnings: (new ones prefixed by >>)

>> drivers/pwm/pwm-mediatek.c:210:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
