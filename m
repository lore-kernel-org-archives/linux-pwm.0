From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH v3 6/6] clk: shmobile: r8a7795: add PWM clock
Date: Thu, 31 Mar 2016 13:39:16 +0200
Message-ID: <1459424356-26061-7-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1459424356-26061-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33989 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753785AbcCaLkF (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 31 Mar 2016 07:40:05 -0400
In-Reply-To: <1459424356-26061-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, geert@linux-m68k.org
Cc: linux-pwm@vger.kernel.org, thierry.reding@gmail.com, magnus.damm@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/renesas/r8a7795-cpg-mssr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/renesas/r8a7795-cpg-mssr.c b/drivers/clk/renesas/r8a7795-cpg-mssr.c
index b2198aef..9de458a 100644
--- a/drivers/clk/renesas/r8a7795-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7795-cpg-mssr.c
@@ -148,6 +148,7 @@ static const struct mssr_mod_clk r8a7795_mod_clks[] __initconst = {
 	DEF_MOD("hscif2",		 518,	R8A7795_CLK_S3D1),
 	DEF_MOD("hscif1",		 519,	R8A7795_CLK_S3D1),
 	DEF_MOD("hscif0",		 520,	R8A7795_CLK_S3D1),
+	DEF_MOD("pwm",			 523,	R8A7795_CLK_S3D4),
 	DEF_MOD("fcpvd3",		 600,	R8A7795_CLK_S2D1),
 	DEF_MOD("fcpvd2",		 601,	R8A7795_CLK_S2D1),
 	DEF_MOD("fcpvd1",		 602,	R8A7795_CLK_S2D1),
-- 
2.7.4
