Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94231C4332B
	for <linux-pwm@archiver.kernel.org>; Mon, 11 Jan 2021 11:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4233220729
	for <linux-pwm@archiver.kernel.org>; Mon, 11 Jan 2021 11:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbhAKLsE (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Mon, 11 Jan 2021 06:48:04 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:43451 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730171AbhAKLsE (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 11 Jan 2021 06:48:04 -0500
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 8768D440CD1;
        Mon, 11 Jan 2021 13:47:13 +0200 (IST)
From:   Baruch Siach <baruch@tkos.co.il>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Baruch Siach <baruch@tkos.co.il>, Rob Herring <robh@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v7 3/3] dt-bindings: ap806: document gpio marvell,pwm-offset property
Date:   Mon, 11 Jan 2021 13:46:29 +0200
Message-Id: <5e1b119a51df19ead32561e87ce2ee1441b67154.1610364681.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610364681.git.baruch@tkos.co.il>
References: <cover.1610364681.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Update the example as well. Add the '#pwm-cells' and 'clocks' properties
for a complete working example.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 .../bindings/arm/marvell/ap80x-system-controller.txt      | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/ap80x-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/ap80x-system-controller.txt
index e31511255d8e..052a967c1f28 100644
--- a/Documentation/devicetree/bindings/arm/marvell/ap80x-system-controller.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/ap80x-system-controller.txt
@@ -80,6 +80,11 @@ Required properties:
 
 - offset: offset address inside the syscon block
 
+Optional properties:
+
+- marvell,pwm-offset: offset address of PWM duration control registers inside
+  the syscon block
+
 Example:
 ap_syscon: system-controller@6f4000 {
 	compatible = "syscon", "simple-mfd";
@@ -101,6 +106,9 @@ ap_syscon: system-controller@6f4000 {
 		gpio-controller;
 		#gpio-cells = <2>;
 		gpio-ranges = <&ap_pinctrl 0 0 19>;
+		marvell,pwm-offset = <0x10c0>;
+		#pwm-cells = <2>;
+		clocks = <&ap_clk 3>;
 	};
 };
 
-- 
2.29.2

