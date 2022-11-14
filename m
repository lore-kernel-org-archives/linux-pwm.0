Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D010C4332F
	for <linux-pwm@archiver.kernel.org>; Mon, 14 Nov 2022 16:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237954AbiKNQzh (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Mon, 14 Nov 2022 11:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237484AbiKNQz1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Nov 2022 11:55:27 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7236FCE6;
        Mon, 14 Nov 2022 08:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668444927; x=1699980927;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/5ATWhqQrc1DZJ4f0j7ZyUNBHQXbdLiioN7qk5/mljI=;
  b=WaN+xPZKEgkBTdTvXGn9VV+GSrKD5o19L+Z8GkL4UwSgzvxTfCPcaBvw
   DMhQYzCHMNnYh7al1jAwWZvdw2996ww0R++Z8oN+qoLAZBeiZsAfWEQt+
   0YsS9UDAlFTdQH0f0dpbD9T9go4k79SOYfNUEBJ9Lb+rrnWw+IfN7csz6
   c1QuCW6vU1z+vu5k2fH1bJ1erRG02+ykPw6PUveEpzm+Lo7f0aFLYvtUF
   7lImpXUjSlT8xjx2ugFrd4QBkm2UPui1JT1LxqqYie/vzNUvTDPW3mPmN
   cIZOQkY/if5JUhR9NjiAOJNkBOK/JntLH60pUGAelsU8kTgOm+8hH1iHw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="295382829"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="295382829"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 08:55:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="727593541"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="727593541"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Nov 2022 08:55:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DC9A3B7; Mon, 14 Nov 2022 18:55:46 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v4 1/7] pwm: Add a stub for devm_pwmchip_add()
Date:   Mon, 14 Nov 2022 18:55:39 +0200
Message-Id: <20221114165545.56088-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221114165545.56088-1-andriy.shevchenko@linux.intel.com>
References: <20221114165545.56088-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The devm_pwmchip_add() can be called by a module that optionally
instantiates PWM chip. In the case of CONFIG_PWM=n, the compilation
can't be performed. Hence, add a necessary stub.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 include/linux/pwm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index d70c6e5a839d..bba492eea96c 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -478,6 +478,11 @@ static inline int pwmchip_remove(struct pwm_chip *chip)
 	return -EINVAL;
 }
 
+static inline int devm_pwmchip_add(struct device *dev, struct pwm_chip *chip)
+{
+	return -EINVAL;
+}
+
 static inline struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
 						       unsigned int index,
 						       const char *label)
-- 
2.35.1

