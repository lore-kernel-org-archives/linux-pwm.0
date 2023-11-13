Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5D0C4332F
	for <linux-pwm@archiver.kernel.org>; Mon, 13 Nov 2023 16:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjKMQ5e (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Mon, 13 Nov 2023 11:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMQ5d (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 13 Nov 2023 11:57:33 -0500
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Nov 2023 08:57:31 PST
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B600D53;
        Mon, 13 Nov 2023 08:57:31 -0800 (PST)
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id C1557C0000E8;
        Mon, 13 Nov 2023 08:47:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com C1557C0000E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1699894050;
        bh=6/JLDQZPDBH2aFK3yzNfKgCy/0JwglECNuOR5JcF6tQ=;
        h=From:To:Cc:Subject:Date:From;
        b=tKfbEOR6o4g2ykzQO/Bj2MIgOKxlaBb7cMcJKlocj+up4z2qfRjaDtVbFfETCrBgF
         R8R59/u2oIR8iJzSPQ0GFA2HtpTN/voYh3+1MC+YW6xpZaF/mnyafk6njFNQwom6CD
         NpDSDbzsPoiUfMO6mCAXT2lFSFBTeraHMTpFLK/k=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 666BE18041CAC4;
        Mon, 13 Nov 2023 08:47:29 -0800 (PST)
From:   Florian Fainelli <florian.fainelli@broadcom.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-pwm@vger.kernel.org (open list:PWM SUBSYSTEM),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE)
Subject: [PATCH] pwm: bcm2835: Fix NPD in suspend/resume
Date:   Mon, 13 Nov 2023 08:46:32 -0800
Message-Id: <20231113164632.2439400-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

When 119a508c4dc9 ("pwm: bcm2835: Add support for suspend/resume") was
sent out on October 11th,, there was still a call to
platform_set_drvdata() which would ensure that the driver private data
structure could be used in bcm2835_pwm_{suspend,resume}.

A cleanup now merged as commit commit 2ce7b7f6704c ("pwm: bcm2835:
Simplify using devm functions") removed that call which would now cause
a NPD in bcm2835_pwm_{suspend,resume} as a consequence.

Fixes: 119a508c4dc9 ("pwm: bcm2835: Add support for suspend/resume")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/pwm/pwm-bcm2835.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index 9777babd5b95..ab30667f4f95 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -155,6 +155,8 @@ static int bcm2835_pwm_probe(struct platform_device *pdev)
 	pc->chip.ops = &bcm2835_pwm_ops;
 	pc->chip.npwm = 2;
 
+	platform_set_drvdata(pdev, pc);
+
 	ret = devm_pwmchip_add(&pdev->dev, &pc->chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret,
-- 
2.34.1

