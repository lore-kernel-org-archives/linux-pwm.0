Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FC0C43217
	for <linux-pwm@archiver.kernel.org>; Tue,  8 Feb 2022 19:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385860AbiBHTMq (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Tue, 8 Feb 2022 14:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385605AbiBHTMq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Feb 2022 14:12:46 -0500
Received: from mail.schwermer.no (mail.schwermer.no [49.12.228.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FA8C0612C1;
        Tue,  8 Feb 2022 11:12:44 -0800 (PST)
From:   sven@svenschwermer.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=svenschwermer.de;
        s=mail; t=1644347562;
        bh=E5Mjzcx7TcRpavxHfUVu1DRhUdZbJJ+Z2ZMtNaxolVk=;
        h=From:To:Cc:Subject;
        b=ifp9+D/DHgpfn2/2EE7eKxFWHYtVRDk4RO/88/3PeaaZnemtAPx/n1TxEJQG+WEVk
         NY5j2vHcaxfq5K8QREG0P4Ft63cqOVAqiKQbIPeUVL+SLLo8/8s9tcY6gW74Y9FNfl
         +oS2dpNbO9jRow3r2cc9+wV/DD4LW4tzy9r994tSETfjTmjlum+w6+Gg/GOgor0f3J
         48VK+1UcHR3EqbS70vQhS5L7Q9wuPKTM5efLkfKd4tZXm302UiN4+uHocv2HUAbzXp
         9vQcxnvciLgbbxTPypVMb04fzbeQl49lHK/nTbgOplxwOP6Frozbskm3QGM+g01+gX
         c058+v6EYIwpQ==
To:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        pavel@ucw.cz, robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        post@lespocky.de, andy.shevchenko@gmail.com, robh@kernel.org
Subject: [PATCH v6 1/3] dt-bindings: leds: Optional multi-led unit address
Date:   Tue,  8 Feb 2022 20:12:34 +0100
Message-Id: <20220208191236.660172-1-sven@svenschwermer.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Sven Schwermer <sven.schwermer@disruptive-technologies.com>

The unit address does not make sense in all cases the multi-led node is
used, e.g. for the upcoming PWM multi-color LED driver.

Signed-off-by: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
---

Notes:
    Added in v6

 .../devicetree/bindings/leds/leds-class-multicolor.yaml         | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml b/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml
index 37445c68cdef..f41d021ed677 100644
--- a/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml
@@ -20,7 +20,7 @@ description: |
   within this documentation directory.
 
 patternProperties:
-  "^multi-led@([0-9a-f])$":
+  "^multi-led(@[0-9a-f])?$":
     type: object
     description: Represents the LEDs that are to be grouped.
     properties:
-- 
2.35.1

