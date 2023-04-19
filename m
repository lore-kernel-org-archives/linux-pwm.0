Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C698C6FD18
	for <linux-pwm@archiver.kernel.org>; Wed, 19 Apr 2023 19:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjDSTZN (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Wed, 19 Apr 2023 15:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjDSTZM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Apr 2023 15:25:12 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CDF6A5B;
        Wed, 19 Apr 2023 12:25:03 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1ppDQM-0003x2-0p;
        Wed, 19 Apr 2023 21:25:02 +0200
Date:   Wed, 19 Apr 2023 20:24:57 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        John Crispin <john@phrozen.org>
Subject: [PATCH 1/2] dt-bindings: pwm: mediatek: Add mediatek,mt7981
 compatible
Message-ID: <4877689269af862ea9ddd199d8aa96b2d7fcf6fe.1681932165.git.daniel@makrotopia.org>
References: <cover.1681932165.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1681932165.git.daniel@makrotopia.org>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add compatible string for the PWM unit found of the MediaTek MT7981 SoC.
This is in preparation to adding support in the pwm-mediatek.c driver.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml b/Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml
index 8e176ba7a525f..0fbe8a6469eb2 100644
--- a/Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml
@@ -22,6 +22,7 @@ properties:
           - mediatek,mt7623-pwm
           - mediatek,mt7628-pwm
           - mediatek,mt7629-pwm
+          - mediatek,mt7981-pwm
           - mediatek,mt7986-pwm
           - mediatek,mt8183-pwm
           - mediatek,mt8365-pwm
-- 
2.40.0

