Return-Path: <SRS0=2R+9=BQ=vger.kernel.org=linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C918BC433E4
	for <linux-pwm@archiver.kernel.org>; Thu,  6 Aug 2020 18:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2315D23128
	for <linux-pwm@archiver.kernel.org>; Thu,  6 Aug 2020 18:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbgHFSdd (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:33:33 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:18484 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728381AbgHFScK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Aug 2020 14:32:10 -0400
X-IronPort-AV: E=Sophos;i="5.75,441,1589209200"; 
   d="scan'208";a="54073239"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 07 Aug 2020 03:32:03 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id E662F400C0A8;
        Fri,  7 Aug 2020 03:32:00 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 2/5] dt-bindings: pwm: renesas,pwm-rcar: Add r8a7742 support
Date:   Thu,  6 Aug 2020 19:31:49 +0100
Message-Id: <20200806183152.11809-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806183152.11809-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20200806183152.11809-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Document RZ/G1H (R8A7742) SoC bindings.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
index daadde9ff9c4..8b22cb110f3f 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
+++ b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
@@ -13,6 +13,7 @@ properties:
   compatible:
     items:
       - enum:
+          - renesas,pwm-r8a7742   # RZ/G1H
           - renesas,pwm-r8a7743   # RZ/G1M
           - renesas,pwm-r8a7744   # RZ/G1N
           - renesas,pwm-r8a7745   # RZ/G1E
-- 
2.17.1

