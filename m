Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22666C433FE
	for <linux-pwm@archiver.kernel.org>; Mon, 14 Feb 2022 14:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354853AbiBNOD5 (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Mon, 14 Feb 2022 09:03:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbiBNODz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Feb 2022 09:03:55 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE6F49FB4;
        Mon, 14 Feb 2022 06:03:47 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id AABB41F437CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644847426;
        bh=+h64QsZ/rfjOYapg2dVyfjUfA0g+jFxUuPrgfX0vMwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kz+56Zkseu07eayLKtzfXRGwHhVVEPtMd7EfOzaTCgNvS/tlR0YB5ZLzumqNbL72C
         KpK2z0JdkUaHFbs6Y6k4Rj8oHK1SEcrYanrMYLzmXWq71AYXHvcVrKtdCGFAksQ2Gg
         GcROODf6knMnMYyFdKtY9b56jbg2tpjb/VRiFAJKH66skWbfiIQcE4IY/IIooDVPTU
         gtr9A3VpWetF7MHF7wXfwmT9DEuG3cO0QcqkRFSRl9nCobdmBKCjIeLgDj+e+CFJ8O
         V4SUKYSbubs7FVq4PigtyYUnIvTw0CWmSsGBZi3M0KAb59PcpXRWqShWGoYyirgoBS
         rfNDOnI0eh9tg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        matthias.bgg@gmail.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 2/3] pwm: pwm-mediatek: Allocate clk_pwms with devm_kmalloc_array
Date:   Mon, 14 Feb 2022 15:03:38 +0100
Message-Id: <20220214140339.112500-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220214140339.112500-1-angelogioacchino.delregno@collabora.com>
References: <20220214140339.112500-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Switch from devm_kcalloc to devm_kmalloc_array when allocating clk_pwms,
as this structure is being filled right after allocating it, hence
there is no need to zero it out beforehand.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pwm/pwm-mediatek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index c7d5ca09a684..6b39f3d69e41 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -221,7 +221,7 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
 	if (IS_ERR(pc->regs))
 		return PTR_ERR(pc->regs);
 
-	pc->clk_pwms = devm_kcalloc(&pdev->dev, pc->soc->num_pwms,
+	pc->clk_pwms = devm_kmalloc_array(&pdev->dev, pc->soc->num_pwms,
 				    sizeof(*pc->clk_pwms), GFP_KERNEL);
 	if (!pc->clk_pwms)
 		return -ENOMEM;
-- 
2.33.1

