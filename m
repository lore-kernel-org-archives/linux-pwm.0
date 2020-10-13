Return-Path: <SRS0=BtHE=DU=vger.kernel.org=linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EC4C433DF
	for <linux-pwm@archiver.kernel.org>; Tue, 13 Oct 2020 08:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AAA0207C3
	for <linux-pwm@archiver.kernel.org>; Tue, 13 Oct 2020 08:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbgJMIN1 (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Tue, 13 Oct 2020 04:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391031AbgJMIN0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Oct 2020 04:13:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D686BC0613D0
        for <linux-pwm@vger.kernel.org>; Tue, 13 Oct 2020 01:13:25 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kSFQy-0001aR-4K; Tue, 13 Oct 2020 10:13:24 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kSFQx-0004nK-Ec; Tue, 13 Oct 2020 10:13:23 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org
Subject: [PATCH] pwm: zx: Add missing cleanup in error path
Date:   Tue, 13 Oct 2020 10:13:21 +0200
Message-Id: <20201013081321.660884-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

zx_pwm_probe() called clk_prepare_enable() before; this must be undone
in the error path.

Fixes: 4836193c435c ("pwm: Add ZTE ZX PWM device driver")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-zx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-zx.c b/drivers/pwm/pwm-zx.c
index e2c21cc34a96..3763ce5311ac 100644
--- a/drivers/pwm/pwm-zx.c
+++ b/drivers/pwm/pwm-zx.c
@@ -238,6 +238,7 @@ static int zx_pwm_probe(struct platform_device *pdev)
 	ret = pwmchip_add(&zpc->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
+		clk_disable_unprepare(zpc->pclk);
 		return ret;
 	}
 
-- 
2.28.0

