Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C3AC433FE
	for <linux-pwm@archiver.kernel.org>; Tue,  3 May 2022 10:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbiECK6B (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Tue, 3 May 2022 06:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbiECK6A (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 3 May 2022 06:58:00 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADCC38183;
        Tue,  3 May 2022 03:54:16 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 639F41F43E28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651575252;
        bh=8SQUMn7/rW2ARSTN1rfGHqVZlZic7Iz6w4XuPwEGq+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XHgq1XW164qqqodKIoQVx4LNEUC3DuvrjCnn5OuM4qU3AV9g6gUPmgUaCFTRcLtjx
         VbFX6xg8y3af8biyZlM5zlCmY2BPXHcp36EN6x9uBZ3O0FIiOWxxw8WTlj+HP9Pg9R
         7Wa/YDZ4z9XwFRbvL46sPwdbfSg7UwVi1W9sCvFmJtm0Abl8ow/0g0+mhJA7/PcpZR
         ZXS2sfGOeGAVji0QK9Kvilew5NyJ7vPikTCv9XfqT1HSHz4LmuWZkjYwwYs1TrOoks
         STteOLz+60eqlKSnG/WWEvoh7JMwxWnS7DtAxJvDSRLIn0WwRXMGvNEzPukfgtYOup
         nQqNsRDUVqopg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        nfraprado@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 2/2] dt-bindings: pwm: pwm-mediatek: Add documentation for MT6795 SoC
Date:   Tue,  3 May 2022 12:54:05 +0200
Message-Id: <20220503105405.54832-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503105405.54832-1-angelogioacchino.delregno@collabora.com>
References: <20220503105405.54832-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add binding documentation for the MT6795 Helio X10 SoC.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
index 25ed214473d7..033d1fc0f405 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
@@ -3,6 +3,7 @@ MediaTek PWM controller
 Required properties:
  - compatible: should be "mediatek,<name>-pwm":
    - "mediatek,mt2712-pwm": found on mt2712 SoC.
+   - "mediatek,mt6795-pwm": found on mt6795 SoC.
    - "mediatek,mt7622-pwm": found on mt7622 SoC.
    - "mediatek,mt7623-pwm": found on mt7623 SoC.
    - "mediatek,mt7628-pwm": found on mt7628 SoC.
-- 
2.35.1

