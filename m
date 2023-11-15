Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2291C07548
	for <linux-pwm@archiver.kernel.org>; Wed, 15 Nov 2023 03:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbjKODfA (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Tue, 14 Nov 2023 22:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbjKODex (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Nov 2023 22:34:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450DA100;
        Tue, 14 Nov 2023 19:34:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75775C433C7;
        Wed, 15 Nov 2023 03:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700019288;
        bh=IvPtG4JimuGVOxflIU6ai2dyzli2L+gKRHKcyvCn6z0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m5nLmtGIaIhg34Up4maTe7hmjs+3Ba+Q2qpXPGZLV6Ou8Ghnlp03h0KsKPfh65IIi
         XsAbfNI/BEJ1qptFVYs9Zp2zMgkrr6RGfsHIpMPLStX+WW91pbn8tvuhwtXpauDfxX
         POI3ALBwhVxE8IMZMH0JYBIAhJ7NF/IqCFTUuhiZwCocq1RuqZ8LI5/j2xjDKUbBHf
         gfavPPuSLc6BO0l5ycfR3SnnSnUGNLF1Oii+Fie/qaJjF/LkzaaznBep7dOI0Bplww
         CS7m1TWzGyEMlu5c3RtGsu2iTf3m7Ng4jPnOy1QMJNo8BSee8xVXOziK5q0s7Dk8FS
         HghEI9+y+ioOA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-pwm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 6/6] pwm: Fix double shift bug
Date:   Tue, 14 Nov 2023 22:33:40 -0500
Message-ID: <20231115033350.1228588-6-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115033350.1228588-1-sashal@kernel.org>
References: <20231115033350.1228588-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.1
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit d27abbfd4888d79dd24baf50e774631046ac4732 ]

These enums are passed to set/test_bit().  The set/test_bit() functions
take a bit number instead of a shifted value.  Passing a shifted value
is a double shift bug like doing BIT(BIT(1)).  The double shift bug
doesn't cause a problem here because we are only checking 0 and 1 but
if the value was 5 or above then it can lead to a buffer overflow.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/pwm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index d2f9f690a9c14..fe0f38ce1bdee 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -41,8 +41,8 @@ struct pwm_args {
 };
 
 enum {
-	PWMF_REQUESTED = 1 << 0,
-	PWMF_EXPORTED = 1 << 1,
+	PWMF_REQUESTED = 0,
+	PWMF_EXPORTED = 1,
 };
 
 /*
-- 
2.42.0

