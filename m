Return-Path: <SRS0=b+St=CG=vger.kernel.org=linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0ABC433E2
	for <linux-pwm@archiver.kernel.org>; Fri, 28 Aug 2020 12:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0CF92086A
	for <linux-pwm@archiver.kernel.org>; Fri, 28 Aug 2020 12:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbgH1MOl (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Fri, 28 Aug 2020 08:14:41 -0400
Received: from protonic.xs4all.nl ([83.163.252.89]:52842 "EHLO
        protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729123AbgH1MOd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Aug 2020 08:14:33 -0400
Received: from erd988.prtnl (erd988.prtnl [192.168.224.30])
        by sparta.prtnl (Postfix) with ESMTP id 1F26D44ACC18;
        Fri, 28 Aug 2020 14:14:30 +0200 (CEST)
From:   David Jander <david@protonic.nl>
To:     Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: [PATCH v2 2/3] drivers: pwm: pwm-pca9685.c: Use BIT() macro instead of shift
Date:   Fri, 28 Aug 2020 14:14:14 +0200
Message-Id: <20200828121415.1292388-3-david@protonic.nl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828121415.1292388-1-david@protonic.nl>
References: <20200828121415.1292388-1-david@protonic.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/pwm/pwm-pca9685.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 0f1a3e07e501..9d1d9dece0c0 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -57,10 +57,10 @@
 #define PCA9685_NUMREGS		0xFF
 #define PCA9685_MAXCHAN		0x10
 
-#define LED_FULL		(1 << 4)
-#define MODE1_SLEEP		(1 << 4)
-#define MODE2_INVRT		(1 << 4)
-#define MODE2_OUTDRV		(1 << 2)
+#define LED_FULL		BIT(4)
+#define MODE1_SLEEP		BIT(4)
+#define MODE2_INVRT		BIT(4)
+#define MODE2_OUTDRV		BIT(2)
 
 #define LED_N_ON_H(N)	(PCA9685_LEDX_ON_H + (4 * (N)))
 #define LED_N_ON_L(N)	(PCA9685_LEDX_ON_L + (4 * (N)))
-- 
2.25.1

