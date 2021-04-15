Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20468C433ED
	for <linux-pwm@archiver.kernel.org>; Thu, 15 Apr 2021 08:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED782601FD
	for <linux-pwm@archiver.kernel.org>; Thu, 15 Apr 2021 08:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhDOIgZ (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Thu, 15 Apr 2021 04:36:25 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:51448 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230090AbhDOIgY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 15 Apr 2021 04:36:24 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UVdfZCq_1618475754;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UVdfZCq_1618475754)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 15 Apr 2021 16:36:00 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        matthias.bgg@gmail.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] pwm: mediatek: remove unused function
Date:   Thu, 15 Apr 2021 16:35:53 +0800
Message-Id: <1618475753-102123-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Fix the following clang warning:

drivers/pwm/pwm-mediatek.c:110:19: warning: unused function
'pwm_mediatek_readl' [-Wunused-function].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/pwm/pwm-mediatek.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index fcfc3b1..cae0f48 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -107,12 +107,6 @@ static void pwm_mediatek_clk_disable(struct pwm_chip *chip,
 	clk_disable_unprepare(pc->clk_top);
 }
 
-static inline u32 pwm_mediatek_readl(struct pwm_mediatek_chip *chip,
-				     unsigned int num, unsigned int offset)
-{
-	return readl(chip->regs + pwm_mediatek_reg_offset[num] + offset);
-}
-
 static inline void pwm_mediatek_writel(struct pwm_mediatek_chip *chip,
 				       unsigned int num, unsigned int offset,
 				       u32 value)
-- 
1.8.3.1

