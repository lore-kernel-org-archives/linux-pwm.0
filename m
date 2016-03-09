From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH 6/6] clk: shmobile: r8a7795: add PWM clock
Date: Wed,  9 Mar 2016 17:56:02 +0100
Message-ID: <1457542562-7880-7-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1457542562-7880-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1457542562-7880-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, geert@linux-m68k.org
Cc: linux-pwm@vger.kernel.org, magnus.damm@gmail.com, thierry.reding@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-pwm@vger.kernel.org

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
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
2.6.4
