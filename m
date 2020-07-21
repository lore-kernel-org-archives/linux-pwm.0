From: Alexandru Stan <amstan@chromium.org>
Subject: [PATCH 2/3] backlight: pwm_bl: Artificially add 0% during interpolation
Date: Mon, 20 Jul 2020 21:25:21 -0700
Message-ID: <20200720212502.2.Iab4d2192e4cf50226e0a58d58df7d90ef92713ce@changeid>
References: <20200721042522.2403410-1-amstan@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbgGUE1U (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 21 Jul 2020 00:27:20 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAA9C0619D6
        for <linux-pwm@vger.kernel.org>; Mon, 20 Jul 2020 21:27:20 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u5so10124096pfn.7
        for <linux-pwm@vger.kernel.org>; Mon, 20 Jul 2020 21:27:20 -0700 (PDT)
In-Reply-To: <20200721042522.2403410-1-amstan@chromium.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc: Matthias Kaehlcke <mka@chromium.org>, Douglas Anderson <dianders@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Alexandru Stan <amstan@chromium.org>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org

Some displays need the low end of the curve cropped in order to make
them happy. In that case we still want to have the 0% point, even though
anything between 0% and 5%(example) would be skipped.

Signed-off-by: Alexandru Stan <amstan@chromium.org>
---

 drivers/video/backlight/pwm_bl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 5193a72305a2..b24711ddf504 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -349,6 +349,14 @@ static int pwm_backlight_parse_dt(struct device *dev,
 			/* Fill in the last point, since no line starts here. */
 			table[x2] = y2;
 
+			/*
+			 * If we don't start at 0 yet we're increasing, assume
+			 * the dts wanted to crop the low end of the range, so
+			 * insert a 0 to provide a display off mode.
+			 */
+			if (table[0] > 0 && table[0] < table[num_levels - 1])
+				table[0] = 0;
+
 			/*
 			 * As we use interpolation lets remove current
 			 * brightness levels table and replace for the
-- 
2.27.0
