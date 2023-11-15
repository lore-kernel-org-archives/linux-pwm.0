Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DDFC47076
	for <linux-pwm@archiver.kernel.org>; Wed, 15 Nov 2023 03:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbjKODkQ (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Tue, 14 Nov 2023 22:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbjKODkO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Nov 2023 22:40:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07370C5;
        Tue, 14 Nov 2023 19:40:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F43C433C7;
        Wed, 15 Nov 2023 03:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700019611;
        bh=gQ5KILeP6bV8XrVW/NZfv9Zzt6DOblD0JZHZD5ms09k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ff+azlkSOo3c9rX4AzDgCxw+IkQZm79Lp+cw75IyiUtNIEEUxCNFCwbpeoFYK6Umr
         cGKNkJ8tv1sTE9v22peDF3u1bEPXcLfVGu2Vm9MMNtXEEuySB5r/qcbJQgUx+YLZ8Z
         fnnvcc8X77Aw2V8YXCD1iFTQu2E3a2w6T61uKkTPw6jxhfwilCKKD7O+RTLVWb9hJx
         rs/977hsj6rShK4dGuCzyEVdgYv3EbU4KThWW1F++PXqbWvht1hPzYPYn0Gpi9EcSz
         m2y/lvldsJVpPOQqeo6knwEP87D1lRkgUJveIRb9LoeuJ5jUwT2cRToR2N7uc2Xnm3
         mle2KbPY3rUWw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-pwm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 6/6] pwm: Fix double shift bug
Date:   Tue, 14 Nov 2023 22:36:00 -0500
Message-ID: <20231115033608.1229058-6-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115033608.1229058-1-sashal@kernel.org>
References: <20231115033608.1229058-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.62
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
index 161e91167b9c0..5e88f1b591832 100644
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

