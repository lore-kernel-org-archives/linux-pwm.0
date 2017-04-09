From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: [PATCH 0/1] pwm: pca9685: fix gpio-only operation.
Date: Sun,  9 Apr 2017 12:11:23 -0400
Message-ID: <1491754284-3870-1-git-send-email-svenv@arcx.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:35407 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752243AbdDIQL3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 9 Apr 2017 12:11:29 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, clemens.gruber@pqgruber.com, mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com

The solution to the bug presented here (always keep SLEEP cleared)
works for me, but perhaps other users might want to set SLEEP at
some point while the driver instance is still loaded ?

If so, I'd love to hear feedback, so we can find a solution which
works for all users.

Sven Van Asbroeck (1):
  pwm: pca9685: fix gpio-only operation.

 drivers/pwm/pwm-pca9685.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

-- 
1.9.1
