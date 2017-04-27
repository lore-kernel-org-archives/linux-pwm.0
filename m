From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH v2 2/8] clk: renesas: r8a7796: add PWM clock
Date: Thu, 27 Apr 2017 16:37:37 +0200
Message-ID: <1493303863-23719-3-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1493303863-23719-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1493303863-23719-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: geert@glider.be, horms@verge.net.au
Cc: linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com, Ryo Kodama <ryo.kodama.vz@renesas.com>, Takeshi Kihara <takeshi.kihara.df@renesas.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-pwm@vger.kernel.org

From: Ryo Kodama <ryo.kodama.vz@renesas.com>

This patch adds PWM clock for PWM.

Signed-off-by: Ryo Kodama <ryo.kodama.vz@renesas.com>
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[uli: changed from S3D4 to S0D12 in accordance with datasheet]
Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/clk/renesas/r8a7796-cpg-mssr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/renesas/r8a7796-cpg-mssr.c b/drivers/clk/renesas/r8a7796-cpg-mssr.c
index 9d114b3..3f1c5aa4 100644
--- a/drivers/clk/renesas/r8a7796-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7796-cpg-mssr.c
@@ -151,6 +151,7 @@ static const struct mssr_mod_clk r8a7796_mod_clks[] __initconst = {
 	DEF_MOD("hscif1",		 519,	R8A7796_CLK_S3D1),
 	DEF_MOD("hscif0",		 520,	R8A7796_CLK_S3D1),
 	DEF_MOD("thermal",		 522,	R8A7796_CLK_CP),
+	DEF_MOD("pwm",			 523,	R8A7796_CLK_S0D12),
 	DEF_MOD("fcpvd2",		 601,	R8A7796_CLK_S0D2),
 	DEF_MOD("fcpvd1",		 602,	R8A7796_CLK_S0D2),
 	DEF_MOD("fcpvd0",		 603,	R8A7796_CLK_S0D2),
-- 
2.7.4
