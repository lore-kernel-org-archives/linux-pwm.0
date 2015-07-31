From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH] ARM: at91: pwm: atmel-hlcdc: add at91sam9n12 entry for the errata
Date: Fri, 31 Jul 2015 18:51:20 +0200
Message-ID: <1438361480-10898-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:49770 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751791AbbGaQvY (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 31 Jul 2015 12:51:24 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Josh Wu <josh.wu@atmel.com>

From: Josh Wu <josh.wu@atmel.com>

The errata for pwm hlcdc of at91sam9n12 is same as at91sam9x5.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
 drivers/pwm/pwm-atmel-hlcdc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index fa5feab..3f76d77 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -218,6 +218,11 @@ static const struct atmel_hlcdc_pwm_errata atmel_hlcdc_pwm_sama5d3_errata = {
 
 static const struct of_device_id atmel_hlcdc_dt_ids[] = {
 	{
+		.compatible = "atmel,at91sam9n12-hlcdc",
+		/* 9n12 has same errata as 9x5 pwm */
+		.data = &atmel_hlcdc_pwm_at91sam9x5_errata,
+	},
+	{
 		.compatible = "atmel,at91sam9x5-hlcdc",
 		.data = &atmel_hlcdc_pwm_at91sam9x5_errata,
 	},
-- 
1.9.1
