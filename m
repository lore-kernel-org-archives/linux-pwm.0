Return-Path: <SRS0=dmxK=CE=vger.kernel.org=linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5B4C433E1
	for <linux-pwm@archiver.kernel.org>; Wed, 26 Aug 2020 14:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA2662078D
	for <linux-pwm@archiver.kernel.org>; Wed, 26 Aug 2020 14:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598453304;
	bh=cabo5bmKA9S3Z+5Um9Eh1dxwPh2SCuYG74GJw0p4rDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uuxX3Qbm2AHY8s0zxFkkp/1dcp/aW+IJzAAGzCuGkQsbwaiSF+m3fiLRfa3GfQjVo
	 DOj+QgjNKkDzA1LDmaKCoJ8K5ipxHgFjjtt2OxiVrjrrFBuwmO+9CbiSKXMafcHzh8
	 uEZlxb1yY7IcJTTx/1/5D+91bk8xR4g1/QOcY9Lk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgHZOsV (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:48:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbgHZOsU (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 26 Aug 2020 10:48:20 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9ED42177B;
        Wed, 26 Aug 2020 14:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598453299;
        bh=cabo5bmKA9S3Z+5Um9Eh1dxwPh2SCuYG74GJw0p4rDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zsdBJajz8wmzsUOxsIodz7vIvPB/ZBznlGLnIsKgNBBa3GWHti1ZqtGAllBtLnH4X
         JEP2pBzOPmHv1xubmR+XvhnIj61z8JpLf9HoxkYCxL92cpUa5Slmy7/SPtGXwmBybz
         rPGCt5qFkAURoM+CzgC8RK33ZqP1XzK5f8teQ6h0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Paul Cercueil <paul@crapouillou.net>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 3/6] pwm: rockchip: Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 16:47:44 +0200
Message-Id: <20200826144747.9436-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826144747.9436-1-krzk@kernel.org>
References: <20200826144747.9436-1-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/pwm/pwm-rockchip.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index eb8c9cb645a6..4773969346e0 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -306,13 +306,9 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 	pc->clk = devm_clk_get(&pdev->dev, "pwm");
 	if (IS_ERR(pc->clk)) {
 		pc->clk = devm_clk_get(&pdev->dev, NULL);
-		if (IS_ERR(pc->clk)) {
-			ret = PTR_ERR(pc->clk);
-			if (ret != -EPROBE_DEFER)
-				dev_err(&pdev->dev, "Can't get bus clk: %d\n",
-					ret);
-			return ret;
-		}
+		if (IS_ERR(pc->clk))
+			return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk),
+					     "Can't get bus clk\n");
 	}
 
 	count = of_count_phandle_with_args(pdev->dev.of_node,
-- 
2.17.1

