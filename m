Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058E7C07E9D
	for <linux-pwm@archiver.kernel.org>; Mon, 26 Sep 2022 14:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbiIZO4g (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Mon, 26 Sep 2022 10:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235381AbiIZOz6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 26 Sep 2022 10:55:58 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACE6796AE;
        Mon, 26 Sep 2022 06:26:15 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Mbk3y4YlKzHpcc;
        Mon, 26 Sep 2022 21:23:58 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 21:26:13 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 26 Sep
 2022 21:26:13 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-fbdev@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <lee@kernel.org>, <daniel.thompson@linaro.org>
Subject: [PATCH -next] backlight: pwm_bl: Switch to use dev_err_probe() helper
Date:   Mon, 26 Sep 2022 21:32:58 +0800
Message-ID: <20220926133258.1104850-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

In the probe path, dev_err() can be replaced with dev_err_probe()
which will check if error code is -EPROBE_DEFER and prints the
error name. It also sets the defer probe reason which can be
checked later through debugfs. It's more simple in error path.
---
 drivers/video/backlight/pwm_bl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index c0523a0269ee..ae858e3bd38f 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -513,9 +513,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	}
 
 	if (IS_ERR(pb->pwm)) {
-		ret = PTR_ERR(pb->pwm);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "unable to request PWM\n");
+		ret = dev_err_probe(&pdev->dev, PTR_ERR(pb->pwm),
+				    "unable to request PWM\n");
 		goto err_alloc;
 	}
 
-- 
2.25.1

