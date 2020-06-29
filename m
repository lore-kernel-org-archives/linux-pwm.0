From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4/4] pwm: omap-dmtimer: Repair pwm_omap_dmtimer_chip's broken kerneldoc header
Date: Mon, 29 Jun 2020 13:47:52 +0100
Message-ID: <20200629124752.1018358-5-lee.jones@linaro.org>
References: <20200629124752.1018358-1-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbgF2Shr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Jun 2020 14:37:47 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE0DC00F835
        for <linux-pwm@vger.kernel.org>; Mon, 29 Jun 2020 05:48:00 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r12so16359429wrj.13
        for <linux-pwm@vger.kernel.org>; Mon, 29 Jun 2020 05:48:00 -0700 (PDT)
In-Reply-To: <20200629124752.1018358-1-lee.jones@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>, Joachim Eastwood <manabian@gmail.com>, NeilBrown <neilb@suse.de>, Grant Erickson <marathon96@gmail.com>

Argument descriptions must be prepended with a '@' to be understood
by the kerneldoc tooling/parsers/validators.

Fixes the following W=1 warning:

  drivers/pwm/pwm-omap-dmtimer.c:70: warning: Function parameter or member 'dm_timer_pdev' not described in 'pwm_omap_dmtimer_chip'

Cc: Tony Lindgren <tony@atomide.com>
Cc: Joachim Eastwood <manabian@gmail.com>
Cc: NeilBrown <neilb@suse.de>
Cc: Grant Erickson <marathon96@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pwm/pwm-omap-dmtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 0d31833db2e2c..75cea7f2aff5e 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -58,7 +58,7 @@
  * @mutex:		Mutex to protect pwm apply state
  * @dm_timer:		Pointer to omap dm timer.
  * @pdata:		Pointer to omap dm timer ops.
- * dm_timer_pdev:	Pointer to omap dm timer platform device
+ * @dm_timer_pdev:	Pointer to omap dm timer platform device
  */
 struct pwm_omap_dmtimer_chip {
 	struct pwm_chip chip;
-- 
2.25.1
