From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] pwm: fsl-ftm: set pwm_chip can_sleep flag
Date: Thu, 22 May 2014 08:05:20 +0800
Message-ID: <1400717120.23867.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-vc0-f172.google.com ([209.85.220.172]:60850 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbaEVAF0 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 21 May 2014 20:05:26 -0400
Received: by mail-vc0-f172.google.com with SMTP id ik5so132356vcb.3
        for <linux-pwm@vger.kernel.org>; Wed, 21 May 2014 17:05:25 -0700 (PDT)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Xiubo Li <Li.Xiubo@freescale.com>, linux-pwm@vger.kernel.org

The implementation of .config(), .enable() and .disable() operations in this
driver may sleep, thus set pwm_chip can_sleep flag.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/pwm/pwm-fsl-ftm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index 420169e..a18bc8f 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -454,6 +454,7 @@ static int fsl_pwm_probe(struct platform_device *pdev)
 	fpc->chip.of_pwm_n_cells = 3;
 	fpc->chip.base = -1;
 	fpc->chip.npwm = 8;
+	fpc->chip.can_sleep = true;
 
 	ret = pwmchip_add(&fpc->chip);
 	if (ret < 0) {
-- 
1.8.3.2



