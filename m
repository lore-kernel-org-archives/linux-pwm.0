Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF786C433C1
	for <linux-pwm@archiver.kernel.org>; Mon, 29 Mar 2021 13:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D57261920
	for <linux-pwm@archiver.kernel.org>; Mon, 29 Mar 2021 13:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhC2M7e (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Mon, 29 Mar 2021 08:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbhC2M7J (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Mar 2021 08:59:09 -0400
Received: from mail.pqgruber.com (mail.pqgruber.com [IPv6:2a05:d014:575:f70b:4f2c:8f1d:40c4:b13e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23ABC061574;
        Mon, 29 Mar 2021 05:59:08 -0700 (PDT)
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 43436C72850;
        Mon, 29 Mar 2021 14:59:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1617022747;
        bh=uw06fKGhzNyZeekkFoiAIHG1nKO4El6D2kTF5dHnHfM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R5Kd4n0sIRUewbFHBSMbrWtVIvEQ24tfRgNKPVKxgJH57xa3IEV088b5zff4g8Ugz
         xNF8qX8ekFcAlZu3THeBc34npBFVTmeM5brUB6CGonNYGvdXVyANLlv03wqt9u5M8a
         d1qxTfBIWEhdH18QJNyZG7eITfANyNW//06IOliw=
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH v6 5/7] dt-bindings: pwm: pca9685: Add nxp,staggered-outputs property
Date:   Mon, 29 Mar 2021 14:57:05 +0200
Message-Id: <20210329125707.182732-5-clemens.gruber@pqgruber.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210329125707.182732-1-clemens.gruber@pqgruber.com>
References: <20210329125707.182732-1-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The pca9685 driver supports a new nxp,staggered-outputs property for
reduced current surges and EMI. This adds documentation for the new DT
property.

Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
---
 Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt b/Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt
index f21b55c95738..fafe954369dc 100644
--- a/Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt
@@ -12,6 +12,8 @@ Optional properties:
   - invert (bool): boolean to enable inverted logic
   - open-drain (bool): boolean to configure outputs with open-drain structure;
 		       if omitted use totem-pole structure
+  - nxp,staggered-outputs (bool): boolean to enable staggered output ON times to
+				  minimize current surges and EMI
 
 Example:
 
-- 
2.31.1

