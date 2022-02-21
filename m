Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC92C433EF
	for <linux-pwm@archiver.kernel.org>; Mon, 21 Feb 2022 16:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbiBUQ2p (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Mon, 21 Feb 2022 11:28:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiBUQ2o (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Feb 2022 11:28:44 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4571D0C5
        for <linux-pwm@vger.kernel.org>; Mon, 21 Feb 2022 08:28:20 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:49dc:a1b5:3fe0:3d2b])
        by michel.telenet-ops.be with bizsmtp
        id xsUJ2600b3YJRAw06sUJ9o; Mon, 21 Feb 2022 17:28:18 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nMBXu-001Tix-4U; Mon, 21 Feb 2022 17:28:18 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nMBXt-006G6H-GL; Mon, 21 Feb 2022 17:28:17 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] pwm: rcar: Simplify multiplication/shift logic
Date:   Mon, 21 Feb 2022 17:28:16 +0100
Message-Id: <4ddca410da1f52a8e2049e0f51f14196cc797200.1645460845.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

  - Remove the superfluous cast; the multiplication will yield a 64-bit
    result due to the "100ULL" anyway,
  - "a * (1 << b)" == "a << b".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pwm/pwm-rcar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index b437192380e23520..55f46d09602b1907 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -110,7 +110,7 @@ static int rcar_pwm_set_counter(struct rcar_pwm_chip *rp, int div, int duty_ns,
 	unsigned long clk_rate = clk_get_rate(rp->clk);
 	u32 cyc, ph;
 
-	one_cycle = (unsigned long long)NSEC_PER_SEC * 100ULL * (1 << div);
+	one_cycle = NSEC_PER_SEC * 100ULL << div;
 	do_div(one_cycle, clk_rate);
 
 	tmp = period_ns * 100ULL;
-- 
2.25.1

