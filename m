Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117A9C47077
	for <linux-pwm@archiver.kernel.org>; Wed, 15 Nov 2023 03:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbjKODmr (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Tue, 14 Nov 2023 22:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbjKODme (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Nov 2023 22:42:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCD1106;
        Tue, 14 Nov 2023 19:42:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98DC1C433C9;
        Wed, 15 Nov 2023 03:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700019748;
        bh=jvWDU+FAJOXh6D4nGqE8N4TLYqxyh6hJc7rowQPp0Bk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vLDeZG2OuaEu8hAMwK5/ibZevNMyduS3hweBgdnGfxxE++tK953kRsjsxQISd8zwO
         2B7y6zWNn4hChjYAXxZ4CRwxRcuoel2aj7mmQKBFRfWaGfsq/sm/fsnEhMCtr7rYla
         iV3CaWJQ4w6We8cPi7v/TRFEEaa+Jmpe0wKQVmbIaa6xCVYk4AQ6Jxp+3+lYAFAhEA
         8PUFZMrvxPjLUTLCXrxeWOXUviX5dsvJEdzWmpXVGDB37P+sN1xiIYfsSrVK+qliTO
         xTEv3TYQfZlR7zbEeql3L4NhkWVqDFO9tajAqtLayS17g6vK6Fz2L7J8gat66aXYhs
         /tkhPH0CmKoSQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-pwm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 2/2] pwm: Fix double shift bug
Date:   Tue, 14 Nov 2023 22:41:54 -0500
Message-ID: <20231115034155.1241251-2-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115034155.1241251-1-sashal@kernel.org>
References: <20231115034155.1241251-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.260
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
index b2c9c460947d1..d1c26f5174e53 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -44,8 +44,8 @@ struct pwm_args {
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

