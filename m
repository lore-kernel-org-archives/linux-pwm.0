From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v2 0/2] Handle return value and remove unnecessary check
Date: Mon, 23 Mar 2020 14:54:22 +0530
Message-ID: <20200323092424.22664-1-rayagonda.kokatanur@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pl1-f170.google.com ([209.85.214.170]:37246 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727683AbgCWJYn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Mar 2020 05:24:43 -0400
Received: by mail-pl1-f170.google.com with SMTP id x1so1662029plm.4
        for <linux-pwm@vger.kernel.org>; Mon, 23 Mar 2020 02:24:43 -0700 (PDT)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

This patch series contains following changes,
1. Handle clk_get_rate() return
2. remove unnecessary check of 'duty'

Changes from v1:
-Address code review comments from Uwe Kleine-König,
 added more details to commit message 

Rayagonda Kokatanur (2):
  pwm: bcm-iproc: handle clk_get_rate() return
  pwm: bcm-iproc: remove unnecessary check of 'duty'

 drivers/pwm/pwm-bcm-iproc.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

-- 
2.17.1
