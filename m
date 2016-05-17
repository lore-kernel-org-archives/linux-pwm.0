From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH] pwm: atmel-hlcdc: Fix default PWM polarity
Date: Tue, 17 May 2016 11:12:32 +0200
Message-ID: <1463476352-7485-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:56727 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755112AbcEQJMj (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 17 May 2016 05:12:39 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Boris Brezillon <boris.brezillon@free-electrons.com>

The PWM device exposed by the HLCDC IP is configured with an inverted
polarity by default. Registering the PWM chip with the normal polarity
was not a problem before commit 42e8992c58d4 ("pwm: Add core
infrastructure to allow atomic updates") because the ->set_polarity()
hook was called no matter the current polarity state, but this is no longer
the case.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Fixes: 42e8992c58d4 ("pwm: Add core infrastructure to allow atomic updates")
---
 drivers/pwm/pwm-atmel-hlcdc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index f994c7e..14fc011 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -272,7 +272,7 @@ static int atmel_hlcdc_pwm_probe(struct platform_device *pdev)
 	chip->chip.of_pwm_n_cells = 3;
 	chip->chip.can_sleep = 1;
 
-	ret = pwmchip_add(&chip->chip);
+	ret = pwmchip_add_with_polarity(&chip->chip, PWM_POLARITY_INVERSED);
 	if (ret) {
 		clk_disable_unprepare(hlcdc->periph_clk);
 		return ret;
-- 
2.7.4
