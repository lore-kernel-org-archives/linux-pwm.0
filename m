Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7FDC6FA8A
	for <linux-pwm@archiver.kernel.org>; Thu,  8 Sep 2022 13:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiIHN47 (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Thu, 8 Sep 2022 09:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbiIHN4y (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 8 Sep 2022 09:56:54 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1D6FD20E;
        Thu,  8 Sep 2022 06:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662645411; x=1694181411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3QJCpzgRCnUz4yyccAi/oO2t5HlZBvGdGKxNCfeQF40=;
  b=ZW2uyM3WbR9+gx3dazoo7IBbZk+JOxcKOfi2Ju6nX31HKCmIuhEeZ+hG
   EbEQHsHO93lj/vztD6vZvFg5A9fv81hnT/dCazKYinPkf2XBOWwQNNsu9
   xt7FTImK3B2UWbq7DMy4BcIerJGTQB2CebDe9A5g8KNpRbBCtsXGlF7YU
   E5hiKFpDJ2D+Gc88eq2Dtl/1uIx1xklwoXs4Wsqrbisfx3Tj5d1ZsTO5d
   LY3Nnk4UwucCYNSexG8DPLaXUTGvknWrG5+Xx6a5mU52CM9mG7CDKXC14
   lrpGLkQLQ4iS9ZV28LeI2AubXn5sMOmiNaJyhwVM3QpcLoaxuzvGX4UyH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="323366991"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="323366991"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 06:56:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="757207446"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Sep 2022 06:56:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9F71A5E4; Thu,  8 Sep 2022 16:57:02 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v2 6/9] pwm: lpss: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr() macros
Date:   Thu,  8 Sep 2022 16:56:55 +0300
Message-Id: <20220908135658.64463-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220908135658.64463-1-andriy.shevchenko@linux.intel.com>
References: <20220908135658.64463-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Using these new macros allows the compiler to remove the unused dev_pm_ops
structure and related functions if !CONFIG_PM without the need to mark
the functions __maybe_unused.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/pwm-lpss-pci.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
index f3367e844e61..98413d364338 100644
--- a/drivers/pwm/pwm-lpss-pci.c
+++ b/drivers/pwm/pwm-lpss-pci.c
@@ -48,7 +48,6 @@ static void pwm_lpss_remove_pci(struct pci_dev *pdev)
 	pm_runtime_get_sync(&pdev->dev);
 }
 
-#ifdef CONFIG_PM
 static int pwm_lpss_runtime_suspend_pci(struct device *dev)
 {
 	/*
@@ -62,12 +61,11 @@ static int pwm_lpss_runtime_resume_pci(struct device *dev)
 {
 	return 0;
 }
-#endif
 
-static const struct dev_pm_ops pwm_lpss_pci_pm = {
-	SET_RUNTIME_PM_OPS(pwm_lpss_runtime_suspend_pci,
-			   pwm_lpss_runtime_resume_pci, NULL)
-};
+static DEFINE_RUNTIME_DEV_PM_OPS(pwm_lpss_pci_pm,
+				 pwm_lpss_runtime_suspend_pci,
+				 pwm_lpss_runtime_resume_pci,
+				 NULL);
 
 static const struct pci_device_id pwm_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x0ac8), (unsigned long)&pwm_lpss_bxt_info},
@@ -89,7 +87,7 @@ static struct pci_driver pwm_lpss_driver_pci = {
 	.probe = pwm_lpss_probe_pci,
 	.remove = pwm_lpss_remove_pci,
 	.driver = {
-		.pm = &pwm_lpss_pci_pm,
+		.pm = pm_ptr(&pwm_lpss_pci_pm),
 	},
 };
 module_pci_driver(pwm_lpss_driver_pci);
-- 
2.35.1

