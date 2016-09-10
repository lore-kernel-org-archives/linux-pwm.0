From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] pwm: meson: Fix missing spin_lock_init
Date: Sat, 10 Sep 2016 09:55:49 +0800
Message-ID: <1473472549-20140-1-git-send-email-axel.lin@ingics.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:36837 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751014AbcIJB4E (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Sep 2016 21:56:04 -0400
Received: by mail-pa0-f67.google.com with SMTP id ez1so4539154pab.3
        for <linux-pwm@vger.kernel.org>; Fri, 09 Sep 2016 18:56:03 -0700 (PDT)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, linux-pwm@vger.kernel.org, Axel Lin <axel.lin@ingics.com>

The driver uses the spin_lock but not initialize it, fix it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/pwm/pwm-meson.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 381871b..9d5bd7d 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -474,6 +474,7 @@ static int meson_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(meson->base))
 		return PTR_ERR(meson->base);
 
+	spin_lock_init(&meson->lock);
 	meson->chip.dev = &pdev->dev;
 	meson->chip.ops = &meson_pwm_ops;
 	meson->chip.base = -1;
-- 
2.7.4
