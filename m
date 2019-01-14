From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] pwm: imx: Fix undefined symbol
Date: Mon, 14 Jan 2019 02:15:58 -0600
Message-ID: <20190114081558.GA7897@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-pwm@vger.kernel.org

Fix the following compile error:

drivers/pwm/pwm-imx27.c:292:25: error: 'imx_pwm_dt_ids' undeclared
here (not in a function); did you mean 'pwm_imx27_dt_ids'?

Fixes: 5a309d380019 ("pwm: imx: Split into two drivers")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/pwm/pwm-imx27.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 8997c4c1bd03..55666cca4cee 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -289,7 +289,7 @@ static const struct of_device_id pwm_imx27_dt_ids[] = {
 	{ .compatible = "fsl,imx27-pwm", },
 	{ /* sentinel */ }
 };
-MODULE_DEVICE_TABLE(of, imx_pwm_dt_ids);
+MODULE_DEVICE_TABLE(of, pwm_imx27_dt_ids);
 
 static int pwm_imx27_probe(struct platform_device *pdev)
 {
-- 
2.20.1
