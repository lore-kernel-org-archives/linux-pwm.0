From: Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH] pwm: imx27: Eliminate error message for defer probe
Date: Mon, 30 Dec 2019 11:02:40 +0800
Message-ID: <1577674960-12011-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Linux-imx@nxp.com
List-Id: linux-pwm@vger.kernel.org

For defer probe error, no need to output error message which
will cause confusion.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/pwm/pwm-imx27.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 59d8b12..35a7ac42 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -319,9 +319,13 @@ static int pwm_imx27_probe(struct platform_device *pdev)
 
 	imx->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(imx->clk_ipg)) {
-		dev_err(&pdev->dev, "getting ipg clock failed with %ld\n",
-				PTR_ERR(imx->clk_ipg));
-		return PTR_ERR(imx->clk_ipg);
+		int ret = PTR_ERR(imx->clk_ipg);
+
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev,
+				"getting ipg clock failed with %d\n",
+				ret);
+		return ret;
 	}
 
 	imx->clk_per = devm_clk_get(&pdev->dev, "per");
-- 
2.7.4
