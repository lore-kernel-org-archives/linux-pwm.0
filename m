From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: [PATCH v2 0/1] pwm: pca9685: fix gpio-only operation.
Date: Tue, 11 Apr 2017 15:19:04 -0400
Message-ID: <1491938345-16933-1-git-send-email-svenv@arcx.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:36537 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752612AbdDKTTL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Apr 2017 15:19:11 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, clemens.gruber@pqgruber.com, mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com

v2:
	the pm_runtime framework controls the SLEEP bit, as suggested by
	Mika Westerberg.

v1:
	the SLEEP bit is always on.

Sven Van Asbroeck (1):
  pwm: pca9685: fix gpio-only operation.

 drivers/pwm/pwm-pca9685.c | 110 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 77 insertions(+), 33 deletions(-)

-- 
1.9.1
