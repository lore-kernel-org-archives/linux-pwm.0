From: Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v5 02/11] pwm: imx: remove ipg clock and enable per clock when required
Date: Sun, 29 Jan 2017 22:54:06 +0100
Message-ID: <1485726855-16236-3-git-send-email-lukma@denx.de>
References: <1485726855-16236-1-git-send-email-lukma@denx.de>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:41916 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbdA2VzI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Jan 2017 16:55:08 -0500
In-Reply-To: <1485726855-16236-1-git-send-email-lukma@denx.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Stefan Agner <stefan@agner.ch>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org
Cc: Lothar Wassmann <LW@karo-electronics.de>, kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>, Philipp Zabel <p.zabel@pengutronix.de>

From: Sascha Hauer <s.hauer@pengutronix.de>

The use of the ipg clock was introduced with commit 7b27c160c681
("pwm: i.MX: fix clock lookup").
In the commit message it was claimed that the ipg clock is enabled for
register accesses. This is true for the ->config() callback, but not
for the ->set_enable() callback. Given that the ipg clock is not
consistently enabled for all register accesses we can assume that either
it is not required at all or that the current code does not work.
Remove the ipg clock code for now so that it's no longer in the way of
refactoring the driver.

On the other hand, the imx7 IP requires the peripheral clock to be
enabled before accessing its registers. Since ->config() can be called
when the PWM is disabled (in which case, the peripheral clock is also
disabled), we need to surround the imx->config() with
clk_prepare_enable(per_clk)/clk_disable_unprepare(per_clk) calls.

Note that the driver was working fine for the i.MX 7 IP so far because
the ipg and peripheral clock use the same hardware clock gate, which
guaranteed peripheral clock activation even when ->config() was called
when the PWM was disabled.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Stefan Agner <stefan@agner.ch>
Tested-by: Stefan Agner <stefan@agner.ch>
---
Changes in v5:
- Minor edit of commmit message

Changes in v4:
- Enable per clk before calling imx->config()

Changes in v3:
- New patch
---
 drivers/pwm/pwm-imx.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index d600fd5..b1d1e50 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -49,7 +49,6 @@
 
 struct imx_chip {
 	struct clk	*clk_per;
-	struct clk	*clk_ipg;
 
 	void __iomem	*mmio_base;
 
@@ -206,13 +205,13 @@ static int imx_pwm_config(struct pwm_chip *chip,
 	struct imx_chip *imx = to_imx_chip(chip);
 	int ret;
 
-	ret = clk_prepare_enable(imx->clk_ipg);
+	ret = clk_prepare_enable(imx->clk_per);
 	if (ret)
 		return ret;
 
 	ret = imx->config(chip, pwm, duty_ns, period_ns);
 
-	clk_disable_unprepare(imx->clk_ipg);
+	clk_disable_unprepare(imx->clk_per);
 
 	return ret;
 }
@@ -293,13 +292,6 @@ static int imx_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(imx->clk_per);
 	}
 
-	imx->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
-	if (IS_ERR(imx->clk_ipg)) {
-		dev_err(&pdev->dev, "getting ipg clock failed with %ld\n",
-				PTR_ERR(imx->clk_ipg));
-		return PTR_ERR(imx->clk_ipg);
-	}
-
 	imx->chip.ops = &imx_pwm_ops;
 	imx->chip.dev = &pdev->dev;
 	imx->chip.base = -1;
-- 
2.1.4
