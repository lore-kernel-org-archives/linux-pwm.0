From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: [PATCH v4 0/1] pwm: pca9685: fix gpio-only operation.
Date: Thu, 13 Apr 2017 08:58:10 -0400
Message-ID: <1492088291-5215-1-git-send-email-svenv@arcx.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:35487 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750773AbdDMM6Q (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 13 Apr 2017 08:58:16 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, clemens.gruber@pqgruber.com, mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com

v4:
	fix coding style for multi-line comment
	added Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

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

 drivers/pwm/pwm-pca9685.c | 112 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 79 insertions(+), 33 deletions(-)

-- 
1.9.1
