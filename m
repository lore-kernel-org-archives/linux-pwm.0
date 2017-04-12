From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: [PATCH v3 0/1] pwm: pca9685: fix gpio-only operation.
Date: Wed, 12 Apr 2017 11:15:58 -0400
Message-ID: <1492010159-6050-1-git-send-email-svenv@arcx.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:36314 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752862AbdDLPQE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Apr 2017 11:16:04 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, clemens.gruber@pqgruber.com, mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com

Mika, I investigated what's required to suspend the device on remove,
by compiling as a module and running insmod/rmmod in various
circumstances.

As you suspected, pm_runtime_suspend() is unneccessary. I removed it,
and the chip is suspended ok when the module unloads. But this could be
because the pm_runtime refcnt is always zero when _remove() is called ?

When unloading the module (rmmod) :
If a gpio is still exported, the kernel unexports the gpio before calling
_remove().
If a pwm is still exported, the kernel refuses to rmmod the module. Even
'rmmod -f' does not work.

I am not sure if the kernel will ever call _unload() without releasing
the associated pwms/gpios. And if it ever does, I am also not sure how
we could convince pm_runtime to go to suspend.

v3:
	remove unnecessary call to pm_runtime_suspend()

	fix coding style for multi-line comment
	(checkpatch.pl should ideally catch this, but did not?)

v2:
	the pm_runtime framework controls the SLEEP bit, as suggested by
	Mika Westerberg.

v1:
	the SLEEP bit is always on.

Sven Van Asbroeck (1):
  pwm: pca9685: fix gpio-only operation.

 drivers/pwm/pwm-pca9685.c | 111 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 78 insertions(+), 33 deletions(-)

-- 
1.9.1
