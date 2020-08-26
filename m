Return-Path: <SRS0=dmxK=CE=vger.kernel.org=linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03191C433E1
	for <linux-pwm@archiver.kernel.org>; Wed, 26 Aug 2020 14:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D405C2078D
	for <linux-pwm@archiver.kernel.org>; Wed, 26 Aug 2020 14:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598453298;
	bh=zQ4wGhgAOWWJNtES+xKHpDaEtICXKkmp2wHN7FL1pdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Re/GV7gf1sqpNA6MozfCXJRPBii/uW+5kQlh04iMvGUZpgiqDC9TBGIioIs0ai5sY
	 e0RZ04zc79Vs71bPasymSnht3lXodS9meVCyWp5LyXDdNFP4rpWU/CfZ2StwKSRiN1
	 2prfmDyAlXdSB0LjJHeTVT4Q4VSKu+NIJqtYpovc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgHZOsR (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:48:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726843AbgHZOsO (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 26 Aug 2020 10:48:14 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30951221E2;
        Wed, 26 Aug 2020 14:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598453294;
        bh=zQ4wGhgAOWWJNtES+xKHpDaEtICXKkmp2wHN7FL1pdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gK150X70JBKf+I+P726abOJK3s7iZdBicWHGHWAiFXHp79cZa95M1ZNO87VXY7w2G
         EF3MQEaAUAItPSSvLpsYnmpVBrNGWmD9awuFTjVM1hn3c1NkrJ3PFp97aZIDMLyuz5
         ff/rhwwbnEFGMrQriWpK4oac3hlrbbCbgyG9m0YE=
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
Subject: [PATCH 2/6] pwm: jz4740: Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 16:47:43 +0200
Message-Id: <20200826144747.9436-2-krzk@kernel.org>
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
 drivers/pwm/pwm-jz4740.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 5830ac2bdf6a..00c642fa2eed 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -60,12 +60,9 @@ static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	snprintf(name, sizeof(name), "timer%u", pwm->hwpwm);
 
 	clk = clk_get(chip->dev, name);
-	if (IS_ERR(clk)) {
-		if (PTR_ERR(clk) != -EPROBE_DEFER)
-			dev_err(chip->dev, "Failed to get clock: %pe", clk);
-
-		return PTR_ERR(clk);
-	}
+	if (IS_ERR(clk))
+		return dev_err_probe(chip->dev, PTR_ERR(clk),
+				     "Failed to get clock\n");
 
 	err = clk_prepare_enable(clk);
 	if (err < 0) {
-- 
2.17.1

