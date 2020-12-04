Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13669C433FE
	for <linux-pwm@archiver.kernel.org>; Fri,  4 Dec 2020 18:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF84D22582
	for <linux-pwm@archiver.kernel.org>; Fri,  4 Dec 2020 18:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387879AbgLDSeY (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Fri, 4 Dec 2020 13:34:24 -0500
Received: from antares.kleine-koenig.org ([94.130.110.236]:48046 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387873AbgLDSeY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Dec 2020 13:34:24 -0500
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 68167A96D72; Fri,  4 Dec 2020 19:33:42 +0100 (CET)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org
Subject: [PATCH] greybus: Add TODO item about modernizing the pwm code
Date:   Fri,  4 Dec 2020 19:33:35 +0100
Message-Id: <20201204183335.3839726-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

drivers/staging/greybus/pwm.c uses the old style PWM callbacks, new drivers
should stick to the atomic API instead.
---
 drivers/staging/greybus/TODO | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/greybus/TODO b/drivers/staging/greybus/TODO
index 31f1f2cb401c..6461e0132fe3 100644
--- a/drivers/staging/greybus/TODO
+++ b/drivers/staging/greybus/TODO
@@ -1,3 +1,5 @@
 * Convert all uses of the old GPIO API from <linux/gpio.h> to the
   GPIO descriptor API in <linux/gpio/consumer.h> and look up GPIO
   lines from device tree or ACPI.
+* Make pwm.c use the struct pwm_ops::apply instead of ::config, ::set_polarity,
+  ::enable and ::disable.
-- 
2.29.2

