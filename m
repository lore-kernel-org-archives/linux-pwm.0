From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH -next] pwm: sun4i: Fix wrong pointer passed to PTR_ERR()
Date: Fri, 10 Jan 2020 01:25:15 +0000
Message-ID: <20200110012515.32965-1-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:8688 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730567AbgAJB3g (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 9 Jan 2020 20:29:36 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, mripard@kernel.org, wens@csie.org, p.zabel@pengutronix.de, Jernej Skrabec <jernej.skrabec@siol.net>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-janitors@vger.kernel.org

PTR_ERR should access the value just tested by IS_ERR, otherwise
the wrong error code will be returned.

Fixes: 5b090b430d75 ("pwm: sun4i: Add an optional probe for bus clock")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/pwm/pwm-sun4i.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 1afd41ebd3fd..a805c347ee84 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -423,7 +423,7 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	 */
 	pwm->clk = devm_clk_get_optional(&pdev->dev, "mod");
 	if (IS_ERR(pwm->clk)) {
-		if (PTR_ERR(pwm->rst) != -EPROBE_DEFER)
+		if (PTR_ERR(pwm->clk) != -EPROBE_DEFER)
 			dev_err(&pdev->dev, "get mod clock failed %pe\n",
 				pwm->clk);
 		return PTR_ERR(pwm->clk);
@@ -432,7 +432,7 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	if (!pwm->clk) {
 		pwm->clk = devm_clk_get(&pdev->dev, NULL);
 		if (IS_ERR(pwm->clk)) {
-			if (PTR_ERR(pwm->rst) != -EPROBE_DEFER)
+			if (PTR_ERR(pwm->clk) != -EPROBE_DEFER)
 				dev_err(&pdev->dev, "get unnamed clock failed %pe\n",
 					pwm->clk);
 			return PTR_ERR(pwm->clk);
@@ -441,7 +441,7 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 
 	pwm->bus_clk = devm_clk_get_optional(&pdev->dev, "bus");
 	if (IS_ERR(pwm->bus_clk)) {
-		if (PTR_ERR(pwm->rst) != -EPROBE_DEFER)
+		if (PTR_ERR(pwm->bus_clk) != -EPROBE_DEFER)
 			dev_err(&pdev->dev, "get bus clock failed %pe\n",
 				pwm->bus_clk);
 		return PTR_ERR(pwm->bus_clk);
