Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E34AC4338F
	for <linux-pwm@archiver.kernel.org>; Mon, 26 Jul 2021 09:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DED3A60F46
	for <linux-pwm@archiver.kernel.org>; Mon, 26 Jul 2021 09:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbhGZIXg (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Mon, 26 Jul 2021 04:23:36 -0400
Received: from gloria.sntech.de ([185.11.138.130]:33066 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231779AbhGZIXg (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 26 Jul 2021 04:23:36 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1m7wWk-0001LU-Lc; Mon, 26 Jul 2021 11:03:58 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     thierry.reding@gmail.com, lee.jones@linaro.org
Cc:     u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        cl@rock-chips.com, pgwipeout@gmail.com, xxm@rock-chips.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 1/2] dt-bindings: pwm: rockchip: add description for rk3568
Date:   Mon, 26 Jul 2021 11:03:54 +0200
Message-Id: <20210726090355.1548483-1-heiko@sntech.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Liang Chen <cl@rock-chips.com>

add "rockchip,rk3568-pwm", "rockchip,rk3328-pwm" for pwm nodes on
a rk3568 platform to pwm-rockchip.yaml.

Signed-off-by: Liang Chen <cl@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
The core rk3568 support was mostly applied, leaving out the pwm
parts. So I've separated the binding and dtsi patch out
into its owm series, so it can be better reviewed.

 Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml b/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
index 5596bee70509..81a54a4e8e3e 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
@@ -29,6 +29,7 @@ properties:
           - enum:
               - rockchip,px30-pwm
               - rockchip,rk3308-pwm
+              - rockchip,rk3568-pwm
           - const: rockchip,rk3328-pwm
 
   reg:
-- 
2.29.2

