Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AE4C433ED
	for <linux-pwm@archiver.kernel.org>; Thu, 15 Apr 2021 12:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47A9A61153
	for <linux-pwm@archiver.kernel.org>; Thu, 15 Apr 2021 12:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbhDOMPs (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Thu, 15 Apr 2021 08:15:48 -0400
Received: from mail.pqgruber.com ([52.59.78.55]:34772 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232771AbhDOMPs (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 15 Apr 2021 08:15:48 -0400
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 9C870C725D8;
        Thu, 15 Apr 2021 14:15:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1618488923;
        bh=F3hXPjM9wtbrWoMAGiw2fyCzbJmA6VnJB+0OF7F65tY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AqQ3olZyjCQYfsjVpd3xIG9dQEy9l/9Ga/mspDkEtI66pSBDKLSCBh4g9QKLvvEvg
         rDkaCBTJxKzscs6vcy9Tk1KMVufSEA3ww8INe7IU4cCW00WF/UJuHmZiDLZynG5SWj
         cJRdkkdfI154aBaVFvNMULVRjpd1HxifhSSzRs3c=
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH v9 3/8] pwm: pca9685: Improve runtime PM behavior
Date:   Thu, 15 Apr 2021 14:14:50 +0200
Message-Id: <20210415121455.39536-3-clemens.gruber@pqgruber.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210415121455.39536-1-clemens.gruber@pqgruber.com>
References: <20210415121455.39536-1-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The chip does not come out of POR in active state but in sleep state.
To be sure (in case the bootloader woke it up) we force it to sleep in
probe.

If runtime PM is disabled, we instead wake the chip in .probe and put it
to sleep in .remove.

Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
---
Changes since v8:
- Rebased

Changes since v7:
- Handle sysfs power control as well and not just CONFIG_PM

Changes since v6:
- Improved !CONFIG_PM handling (wake it up without putting it to sleep
  first)

 drivers/pwm/pwm-pca9685.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index aa48c45bd294..1b013d03f5d8 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -462,14 +462,20 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	/* The chip comes out of power-up in the active state */
-	pm_runtime_set_active(&client->dev);
-	/*
-	 * Enable will put the chip into suspend, which is what we
-	 * want as all outputs are disabled at this point
-	 */
 	pm_runtime_enable(&client->dev);
 
+	if (pm_runtime_enabled(&client->dev)) {
+		/*
+		 * Although the chip comes out of power-up in the sleep state,
+		 * we force it to sleep in case it was woken up before
+		 */
+		pca9685_set_sleep_mode(pca, true);
+		pm_runtime_set_suspended(&client->dev);
+	} else {
+		/* Wake the chip up if runtime PM is disabled */
+		pca9685_set_sleep_mode(pca, false);
+	}
+
 	return 0;
 }
 
@@ -481,7 +487,14 @@ static int pca9685_pwm_remove(struct i2c_client *client)
 	ret = pwmchip_remove(&pca->chip);
 	if (ret)
 		return ret;
+
+	if (!pm_runtime_enabled(&client->dev)) {
+		/* Put chip in sleep state if runtime PM is disabled */
+		pca9685_set_sleep_mode(pca, true);
+	}
+
 	pm_runtime_disable(&client->dev);
+
 	return 0;
 }
 
-- 
2.31.1

