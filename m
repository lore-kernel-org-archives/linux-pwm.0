From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RESEND] pwm: meson: Fix missing spin_lock_init
Date: Sun, 16 Oct 2016 15:40:12 +0800
Message-ID: <1476603612-15034-1-git-send-email-axel.lin@ingics.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36022 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753341AbcJPHkc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 16 Oct 2016 03:40:32 -0400
Received: by mail-pa0-f66.google.com with SMTP id os4so3890528pac.3
        for <linux-pwm@vger.kernel.org>; Sun, 16 Oct 2016 00:40:32 -0700 (PDT)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, linux-pwm@vger.kernel.org, Axel Lin <axel.lin@ingics.com>

The driver uses the spin_lock but not initialize it, fix it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
---
Hi Thierry,
Seems you did'nt pick up this patch.
This patch was sent on
http://www.spinics.net/lists/linux-pwm/msg04847.html
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
