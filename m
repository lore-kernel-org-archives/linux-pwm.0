Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B18C4361A
	for <linux-pwm@archiver.kernel.org>; Sat,  5 Dec 2020 16:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B55422EBF
	for <linux-pwm@archiver.kernel.org>; Sat,  5 Dec 2020 16:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgLEQyY (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Sat, 5 Dec 2020 11:54:24 -0500
Received: from antares.kleine-koenig.org ([94.130.110.236]:50788 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgLEQxR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 5 Dec 2020 11:53:17 -0500
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 709BFA97ED6; Sat,  5 Dec 2020 17:51:49 +0100 (CET)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org
Subject: [PATCH 3/3] pwm: Drop function pwmchip_add_with_polarity()
Date:   Sat,  5 Dec 2020 17:51:46 +0100
Message-Id: <20201205165146.3866846-3-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201205165146.3866846-1-uwe@kleine-koenig.org>
References: <20201205165146.3866846-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

pwmchip_add() only calls pwmchip_add_with_polarity() and nothing else. All
other users of pwmchip_add_with_polarity() are gone. So drop
pwmchip_add_with_polarity() and move the code instead to pwmchip_add().

The initial assignment to pwm->state.polarity is dropped. In every correct
usage of the PWM API this value is overwritten later anyhow.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 include/linux/pwm.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index e4d84d4db293..8f4eefd129aa 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -392,8 +392,6 @@ int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
 int pwm_set_chip_data(struct pwm_device *pwm, void *data);
 void *pwm_get_chip_data(struct pwm_device *pwm);
 
-int pwmchip_add_with_polarity(struct pwm_chip *chip,
-			      enum pwm_polarity polarity);
 int pwmchip_add(struct pwm_chip *chip);
 int pwmchip_remove(struct pwm_chip *chip);
 struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
-- 
2.29.2

