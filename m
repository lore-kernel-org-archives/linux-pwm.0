Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F8BC4361A
	for <linux-pwm@archiver.kernel.org>; Sat,  5 Dec 2020 18:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 271AD229C4
	for <linux-pwm@archiver.kernel.org>; Sat,  5 Dec 2020 18:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgLES3L (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Sat, 5 Dec 2020 13:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728611AbgLES3J (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 5 Dec 2020 13:29:09 -0500
Received: from antares.kleine-koenig.org (antares.kleine-koenig.org [IPv6:2a01:4f8:c0c:3a97::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC5BC09424D
        for <linux-pwm@vger.kernel.org>; Sat,  5 Dec 2020 08:53:35 -0800 (PST)
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 4DD89A97ED4; Sat,  5 Dec 2020 17:51:49 +0100 (CET)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org
Subject: [PATCH 2/3] pwm: atmel-hlcdc: Use pwmchip_add() instead of pwmchip_add_with_polarity()
Date:   Sat,  5 Dec 2020 17:51:45 +0100
Message-Id: <20201205165146.3866846-2-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201205165146.3866846-1-uwe@kleine-koenig.org>
References: <20201205165146.3866846-1-uwe@kleine-koenig.org>
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

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/pwm/pwm-atmel-hlcdc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index dcbc0489dfd4..4551aa2c484c 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -270,7 +270,7 @@ static int atmel_hlcdc_pwm_probe(struct platform_device *pdev)
 	chip->chip.of_xlate = of_pwm_xlate_with_flags;
 	chip->chip.of_pwm_n_cells = 3;
 
-	ret = pwmchip_add_with_polarity(&chip->chip, PWM_POLARITY_INVERSED);
+	ret = pwmchip_add(&chip->chip);
 	if (ret) {
 		clk_disable_unprepare(hlcdc->periph_clk);
 		return ret;
-- 
2.29.2

