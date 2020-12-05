Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FF5C2BBCA
	for <linux-pwm@archiver.kernel.org>; Sat,  5 Dec 2020 18:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 504BA22E00
	for <linux-pwm@archiver.kernel.org>; Sat,  5 Dec 2020 18:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgLESnk (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Sat, 5 Dec 2020 13:43:40 -0500
Received: from antares.kleine-koenig.org ([94.130.110.236]:50776 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbgLEQxA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 5 Dec 2020 11:53:00 -0500
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 28A60A97ED2; Sat,  5 Dec 2020 17:51:49 +0100 (CET)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org
Subject: [PATCH 1/3] pwm: bcm-kona: Use pwmchip_add() instead of pwmchip_add_with_polarity()
Date:   Sat,  5 Dec 2020 17:51:44 +0100
Message-Id: <20201205165146.3866846-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The only side effect of this change is that pwm->state.polarity is
initialized to PWM_POLARITY_NORMAL instead of PWM_POLARITY_INVERSED.
However all other members of pwm->state are uninitialized and consumers
are expected to provide the right polarity (either by setting it explicitly
or by using a helper like pwm_init_state() that overwrites .polarity
anyhow with a value independent of the initial value).

The eventual goal is to remove pwmchip_add_with_polarity() and so simplify
the data flow in the PWM core.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/pwm/pwm-bcm-kona.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index 16c5898b934a..40ecfb2bb632 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -303,7 +303,7 @@ static int kona_pwmc_probe(struct platform_device *pdev)
 
 	clk_disable_unprepare(kp->clk);
 
-	ret = pwmchip_add_with_polarity(&kp->chip, PWM_POLARITY_INVERSED);
+	ret = pwmchip_add(&kp->chip);
 	if (ret < 0)
 		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
 
-- 
2.29.2

