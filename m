From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V2 2/2] pwm: bcm2835: Support for polarity setting via DT
Date: Sat, 12 Aug 2017 12:19:44 +0200
Message-ID: <1502533184-15765-3-git-send-email-stefan.wahren@i2se.com>
References: <1502533184-15765-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:57841 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750811AbdHLKUd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 12 Aug 2017 06:20:33 -0400
In-Reply-To: <1502533184-15765-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>

This adds support for the third (optional) pwm cell to specify the
polarity, which is needed by display backlights for example.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
---
 drivers/pwm/pwm-bcm2835.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index c5dbf16..db001cb 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -167,6 +167,8 @@ static int bcm2835_pwm_probe(struct platform_device *pdev)
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &bcm2835_pwm_ops;
 	pc->chip.npwm = 2;
+	pc->chip.of_xlate = of_pwm_xlate_with_flags;
+	pc->chip.of_pwm_n_cells = 3;
 
 	platform_set_drvdata(pdev, pc);
 
-- 
2.7.4
