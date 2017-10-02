From: Ed Blake <ed.blake@sondrel.com>
Subject: [PATCH 0/2] pwm: img: Add power management
Date: Mon,  2 Oct 2017 10:51:46 +0100
Message-ID: <1506937908-360-1-git-send-email-ed.blake@sondrel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-eopbgr40072.outbound.protection.outlook.com ([40.107.4.72]:40578
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750984AbdJBJwD (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 2 Oct 2017 05:52:03 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, Ed Blake <ed.blake@sondrel.com>

This patch set adds power managment to the pwm-img driver.  The first
patch adds system PM suspend / resume handling and the second patch
adds runtime PM.

Ed Blake (2):
  pwm: img: Add suspend / resume handling
  pwm: img: Add runtime PM

 drivers/pwm/pwm-img.c | 160 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 141 insertions(+), 19 deletions(-)

-- 
1.9.1
