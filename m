Return-Path: <SRS0=hzoi=EM=vger.kernel.org=linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1589C388F2
	for <linux-pwm@archiver.kernel.org>; Fri,  6 Nov 2020 17:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89DA822202
	for <linux-pwm@archiver.kernel.org>; Fri,  6 Nov 2020 17:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbgKFRPv (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Fri, 6 Nov 2020 12:15:51 -0500
Received: from antares.kleine-koenig.org ([94.130.110.236]:58002 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727557AbgKFRPv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Nov 2020 12:15:51 -0500
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 7D25BA72D1E; Fri,  6 Nov 2020 18:15:49 +0100 (CET)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] pwm: ab8500: Explicitly allocate pwm chip base dynamically
Date:   Fri,  6 Nov 2020 18:15:47 +0100
Message-Id: <20201106171547.50669-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The ab8500 driver is the last one which doesn't (explicitly) use dynamic
allocation of the pwm id. Looking through the kernel sources I didn't
find a place that relies on this id. And with the device probed from
device tree pdev->id is -1 anyhow; making this explicit looks
beneficial, too.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/pwm/pwm-ab8500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-ab8500.c b/drivers/pwm/pwm-ab8500.c
index b1e1d747cbaa..e6eda26b3418 100644
--- a/drivers/pwm/pwm-ab8500.c
+++ b/drivers/pwm/pwm-ab8500.c
@@ -104,7 +104,7 @@ static int ab8500_pwm_probe(struct platform_device *pdev)
 
 	ab8500->chip.dev = &pdev->dev;
 	ab8500->chip.ops = &ab8500_pwm_ops;
-	ab8500->chip.base = pdev->id;
+	ab8500->chip.base = -1;
 	ab8500->chip.npwm = 1;
 
 	err = pwmchip_add(&ab8500->chip);
-- 
2.28.0

