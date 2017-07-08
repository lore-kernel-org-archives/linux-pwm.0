From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: [PATCH 2/2] pwm: bcm2835: Support for polarity setting via DT
Date: Sat,  8 Jul 2017 12:13:58 +0200
Message-ID: <1499508838-20715-3-git-send-email-stefan.wahren@i2se.com>
References: <1499508838-20715-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1499508838-20715-1-git-send-email-stefan.wahren-eS4NqCHxEME@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

This adds support for the third (optional) pwm cell to specify the
polarity, which is needed by display backlights for example.

Signed-off-by: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
