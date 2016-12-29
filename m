From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH] pwm: imx: keep peripheral clock enabled during register access
Date: Thu, 29 Dec 2016 15:10:41 +0100
Message-ID: <20161229141041.16369-1-stefan@agner.ch>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.kmu-office.ch ([178.209.48.109]:55315 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752311AbcL2OKL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 29 Dec 2016 09:10:11 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: l.majewski@majess.pl, thierry.reding@gmail.com
Cc: s.hauer@pengutronix.de, linux-pwm@vger.kernel.org, bhuvanchandra.dv@toradex.com, linux-kernel@vger.kernel.org, fabio.estevam@nxp.com, boris.brezillon@free-electrons.com, LW@karo-electronics.de, kernel@pengutronix.de, shawnguo@kernel.org, Stefan Agner <stefan@agner.ch>

On some platforms (i.MX 7) the peripheral clock is required during
register access. Make sure that the clock is kept enabled when
accessing registers.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Hi Thierry, hi Lukasz,

This patch applies ontop of Lukasz "pwm: imx: Provide atomic operation
for IMX PWM driver" patchset. With that, my expressed concern to patch
2 is solved.

--
Stefan

 drivers/pwm/pwm-imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index a21463436aa4..fbd997514a87 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -192,7 +192,7 @@ static int imx_pwm_apply_v2(struct pwm_chip *chip, struct pwm_device *pwm,
 		period_cycles = 0;
 
 	/* Enable the clock if the PWM is being enabled. */
-	if (state->enabled && !cstate.enabled) {
+	if (!cstate.enabled) {
 		ret = clk_prepare_enable(imx->clk_per);
 		if (ret)
 			return ret;
@@ -223,7 +223,7 @@ static int imx_pwm_apply_v2(struct pwm_chip *chip, struct pwm_device *pwm,
 	writel(cr, imx->mmio_base + MX3_PWMCR);
 
 	/* Disable the clock if the PWM is being disabled. */
-	if (!state->enabled && cstate.enabled)
+	if (!state->enabled)
 		clk_disable_unprepare(imx->clk_per);
 
 	return 0;
-- 
2.11.0
