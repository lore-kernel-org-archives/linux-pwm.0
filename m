From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] pwm: meson: Fix missing spin_lock_init()
Date: Sat, 10 Sep 2016 06:38:38 +0000
Message-ID: <1473489518-17981-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36036 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750895AbcIJGit (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 10 Sep 2016 02:38:49 -0400
Received: by mail-pa0-f65.google.com with SMTP id ez1so4822799pab.3
        for <linux-pwm@vger.kernel.org>; Fri, 09 Sep 2016 23:38:48 -0700 (PDT)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org

From: Wei Yongjun <weiyongjun1@huawei.com>

The driver allocates the spinlock but not initialize it.
Use spin_lock_init() on it to initialize it correctly.

This is detected by Coccinelle semantic patch.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/pwm/pwm-meson.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index bfbbe7f..778d088 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -465,6 +465,7 @@ static int meson_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(meson->base))
 		return PTR_ERR(meson->base);
 
+	spin_lock_init(&meson->lock);
 	meson->chip.dev = &pdev->dev;
 	meson->chip.ops = &meson_pwm_ops;
 	meson->chip.base = -1;
