Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8973C4167B
	for <linux-pwm@archiver.kernel.org>; Mon,  7 Dec 2020 19:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E336238A1
	for <linux-pwm@archiver.kernel.org>; Mon,  7 Dec 2020 19:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgLGThx (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Mon, 7 Dec 2020 14:37:53 -0500
Received: from mail.pqgruber.com ([52.59.78.55]:35196 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbgLGThw (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 7 Dec 2020 14:37:52 -0500
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 921A6C8926C;
        Mon,  7 Dec 2020 20:37:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1607369830;
        bh=ShuICKLZBVI5ErEI1/41Y2BY3Y2fl8W0JkwcIOrl/JY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rh71cuWLJ6yoKVtlaSv2+4mPyT///9Jkn48WuhA97VyHaY03Ad0yGYSGBstew26R7
         i8QbKNHls2M7hrHEEA264ZBqz6Z3nka/Hsz5Z8qm4EKdyCyl9fC/YiYb/Ypu+Q7lB6
         e/c/cVtQ9vhPUNQoS1XQKbSUBpzOoJkT25Ew+Ppo=
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        u.kleine-koenig@pengutronix.de, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>,
        Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH v4 2/4] pwm: pca9685: Set full OFF bits in probe
Date:   Mon,  7 Dec 2020 20:36:28 +0100
Message-Id: <20201207193629.493241-2-clemens.gruber@pqgruber.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201207193629.493241-1-clemens.gruber@pqgruber.com>
References: <20201207193629.493241-1-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The full OFF bits are set by default in the PCA9685 LEDn_OFF_H
registers at POR. LEDn_ON_L/H and LEDn_OFF_L default to 0.

The datasheet states that LEDn_OFF and LEDn_ON should never be both set
to the same values.

This patch removes the clearing of the full OFF bit in the probe
function. We still clear the rest of the OFF regs but now we set the
full OFF bit to avoid having both OFF and ON registers set to 0 and
start up in a safe default state.

Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
---
Changes since v1:
- Rebased

 drivers/pwm/pwm-pca9685.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 0425e0bcb81e..fdce5fb9f41e 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -486,9 +486,9 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 	reg &= ~(MODE1_ALLCALL | MODE1_SUB1 | MODE1_SUB2 | MODE1_SUB3);
 	regmap_write(pca->regmap, PCA9685_MODE1, reg);
 
-	/* Clear all "full off" bits */
+	/* Reset OFF registers to HW default (only full OFF bit is set) */
 	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_L, 0);
-	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_H, 0);
+	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_H, LED_FULL);
 
 	pca->chip.ops = &pca9685_pwm_ops;
 	/* Add an extra channel for ALL_LED */
-- 
2.29.2

