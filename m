Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B366DC77B71
	for <linux-pwm@archiver.kernel.org>; Wed, 12 Apr 2023 11:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjDLL22 (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Wed, 12 Apr 2023 07:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjDLL2P (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Apr 2023 07:28:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F7F728A;
        Wed, 12 Apr 2023 04:28:05 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 72B416603D19;
        Wed, 12 Apr 2023 12:28:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681298883;
        bh=fXye3dLdrd01pW9dkK8SQo3s3rXAglHlbcKU/jyx0I0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ej6OkOeOtAUWnvV/z/G7eS/S0Cw+BAmPSrNTkwFSGZFaIysb5396dfynJAghUtK/y
         nhsRGbTG2MGS0RjjV4J0zm+UF0XkMAs4isip2S4VkgLK/4zRjYM5y02ULzC6WYQBV0
         zpn8Sz1d2NfRLK0MHvFa5XerUCPFlebhaQi5dOt1/PJvT7GQX8d8S9KabYzOFByr45
         EGVmZXukzKo7kVOkvSunIe+Wg6HazK4BxmfrYMeNkA6PPpo3O6iMV5IoxCY0My37d+
         2JSysFi39qmy+GE/ECFjnA91ZtghOFibEdqHSnfQMOiRGzqolI5KvS0+6v/PBIrEGD
         OS4NKIms3vDWA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, chunfeng.yun@mediatek.com,
        vkoul@kernel.org, kishon@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, chunkuang.hu@kernel.org,
        angelogioacchino.delregno@collabora.com, ck.hu@mediatek.com,
        jitao.shi@mediatek.com, xinlei.lee@mediatek.com,
        houlong.wei@mediatek.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@collabora.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH 13/27] dt-bindings: display: mediatek: ufoe: Add compatible for MediaTek MT6795
Date:   Wed, 12 Apr 2023 13:27:25 +0200
Message-Id: <20230412112739.160376-14-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
References: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add a compatible string for MediaTek Helio X10 MT6795's UFOE block: this
is the same as MT8173.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/display/mediatek/mediatek,ufoe.yaml    | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ufoe.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ufoe.yaml
index b8bb135fe96b..282925a73804 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ufoe.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ufoe.yaml
@@ -24,6 +24,9 @@ properties:
     oneOf:
       - items:
           - const: mediatek,mt8173-disp-ufoe
+      - items:
+          - const: mediatek,mt6795-disp-ufoe
+          - const: mediatek,mt8173-disp-ufoe
 
   reg:
     maxItems: 1
-- 
2.40.0

