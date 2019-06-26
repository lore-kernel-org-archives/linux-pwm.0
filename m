Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43817 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfFZJkU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Jun 2019 05:40:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id p13so1886075wru.10
        for <linux-pwm@vger.kernel.org>; Wed, 26 Jun 2019 02:40:18 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
Date: Wed, 26 Jun 2019 11:40:15 +0200
Message-Id: <20190626094015.16540-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: [PATCH] pwm: fsl-ftm: Make sure to unlock mutex on failure
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, kbuild test robot <lkp@intel.com>, Julia Lawall <julia.lawall@lip6.fr>, Patrick Havelange <patrick.havelange@essensium.com>

Upon failure to enable clocks while trying to enable the PWM, make sure
to unlock the mutex that was taken to avoid a deadlock during subsequent
operations.

Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Cc: Patrick Havelange <patrick.havelange@essensium.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/pwm/pwm-fsl-ftm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index 6a4106c65cb4..efc226bda214 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -342,12 +342,12 @@ static int fsl_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (!oldstate->enabled) {
 		ret = clk_prepare_enable(fpc->clk[fpc->period.clk_select]);
 		if (ret)
-			return ret;
+			goto end_mutex;
 
 		ret = clk_prepare_enable(fpc->clk[FSL_PWM_CLK_CNTEN]);
 		if (ret) {
 			clk_disable_unprepare(fpc->clk[fpc->period.clk_select]);
-			return ret;
+			goto end_mutex;
 		}
 
 		regmap_update_bits(fpc->regmap, FTM_OUTMASK, BIT(pwm->hwpwm),
-- 
2.21.0
