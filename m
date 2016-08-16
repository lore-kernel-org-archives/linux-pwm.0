From: Seung-Woo Kim <sw0312.kim@samsung.com>
Subject: [PATCH v2] pwm: samsung: fix to use lowest div for large enough modulation bits
Date: Tue, 16 Aug 2016 23:22:01 +0900
Message-ID: <20160816142201.12672-1-sw0312.kim@samsung.com>
References: <1470133006-4272-1-git-send-email-sw0312.kim@samsung.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35896 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbcHPOWL (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 16 Aug 2016 10:22:11 -0400
In-Reply-To: <1470133006-4272-1-git-send-email-sw0312.kim@samsung.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, k.kozlowski@samsung.com, thierry.reding@gmail.com, linux-pwm@vger.kernel.org
Cc: tomasz.figa@gmail.com, sw0312.kim@samsung.com, jy0922.shim@samsung.com, krzk@kernel.org

From pwm_samsung_calc_tin(), there is routine to find the lowest
divider possible to generate lower frequency than requested one.
But it is always possible to generate requested frequency with
large enough modulation bits except s3c24xx, so this patch fixes
to use lowest div for the case. This patch removes following UBSAN
warning:

   UBSAN: Undefined behaviour in drivers/pwm/pwm-samsung.c:197:13
   shift exponent 32 is too large for 32-bit type 'long unsigned int'
   [...]
   [<c0670248>] (ubsan_epilogue) from [<c06707b4>] (__ubsan_handle_shift_out_of_bounds+0xd8/0x120)
   [<c06707b4>] (__ubsan_handle_shift_out_of_bounds) from [<c0694b28>] (pwm_samsung_config+0x508/0x6a4)
   [<c0694b28>] (pwm_samsung_config) from [<c069286c>] (pwm_apply_state+0x174/0x40c)
   [<c069286c>] (pwm_apply_state) from [<c0b2e070>] (pwm_fan_probe+0xc8/0x488)
   [<c0b2e070>] (pwm_fan_probe) from [<c07ba8b0>] (platform_drv_probe+0x70/0x150)
   [...]

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
---
Changes from v1
 * Remove too complex condition, instead, just checking simple variant->bits as Krzysztof's suggestion
 * Add comment from Tomasz

The UBSAN warning from ARM is reported with the patch in following link:
https://patchwork.kernel.org/patch/9189575/
---
 drivers/pwm/pwm-samsung.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index ada2d32..f113cda 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -193,9 +193,18 @@ static unsigned long pwm_samsung_calc_tin(struct samsung_pwm_chip *chip,
 	 * divider settings and choose the lowest divisor that can generate
 	 * frequencies lower than requested.
 	 */
-	for (div = variant->div_base; div < 4; ++div)
-		if ((rate >> (variant->bits + div)) < freq)
-			break;
+	if (variant->bits < 32) {
+		/* Only for s3c24xx */
+		for (div = variant->div_base; div < 4; ++div)
+			if ((rate >> (variant->bits + div)) < freq)
+				break;
+	} else {
+		/*
+		 * Other variants have enough counter bits to generate any
+		 * requested rate, so no need to check higher divisors.
+		 */
+		div = variant->div_base;
+	}
 
 	pwm_samsung_set_divisor(chip, chan, BIT(div));
 
-- 
2.9.2
