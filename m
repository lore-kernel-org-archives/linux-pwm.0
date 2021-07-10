Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB172C07E9E
	for <linux-pwm@archiver.kernel.org>; Sat, 10 Jul 2021 23:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1C0F613DA
	for <linux-pwm@archiver.kernel.org>; Sat, 10 Jul 2021 23:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbhGJXxI (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Sat, 10 Jul 2021 19:53:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:39696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232663AbhGJXws (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 10 Jul 2021 19:52:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E308761057;
        Sat, 10 Jul 2021 23:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625961002;
        bh=LxSPGIXCoUoXoH4lz4COo8zDTaCjoAW3Y2wmkzoz96Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cw9quK/pH5OnrOA5Gv50xNMxGKNJKD9lQF+EEvXtvJ0UtZkdt7GFrXLHmd3OyN1VM
         NIJ1lyLuGhd2AYnxgo3R8lXnwN26yoK8WZIf8zsblrhBRcHn85m8IY6T9ZmYj2CGry
         guDbzZ01qi8iGRaAcdLCn0lP1YKHRDHAvBiWp1WaCKFHen8GEIpVRgNQRZnx8ndrh+
         LqprN/MRJm7kewedVjHiP2HwS/36YUv9brJFMquyFHs63VScrvpAIQ1BjnTzwmS7Gh
         2O5uxel+cRatk8rtj05MW8naPE+qnzshgGn+YaVThSaF6uO1EWKwFH6D/pL+KOU824
         OdB/li1WUxjHg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zou Wei <zou_wei@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-pwm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.12 33/43] pwm: img: Fix PM reference leak in img_pwm_enable()
Date:   Sat, 10 Jul 2021 19:49:05 -0400
Message-Id: <20210710234915.3220342-33-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710234915.3220342-1-sashal@kernel.org>
References: <20210710234915.3220342-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Zou Wei <zou_wei@huawei.com>

[ Upstream commit fde25294dfd8e36e4e30b693c27a86232864002a ]

pm_runtime_get_sync will increment pm usage counter even it failed.
Forgetting to putting operation will result in reference leak here.
Fix it by replacing it with pm_runtime_resume_and_get to keep usage
counter balanced.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-img.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
index 6faf5b5a5584..37200850cdc6 100644
--- a/drivers/pwm/pwm-img.c
+++ b/drivers/pwm/pwm-img.c
@@ -156,7 +156,7 @@ static int img_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct img_pwm_chip *pwm_chip = to_img_pwm_chip(chip);
 	int ret;
 
-	ret = pm_runtime_get_sync(chip->dev);
+	ret = pm_runtime_resume_and_get(chip->dev);
 	if (ret < 0)
 		return ret;
 
-- 
2.30.2

