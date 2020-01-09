From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] pwm: sun4i: Fix inconsistent IS_ERR and PTR_ERR
Date: Thu, 9 Jan 2020 01:27:35 -0600
Message-ID: <20200109072735.GA22886@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>, Jernej Skrabec <jernej.skrabec@siol.net>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-pwm@vger.kernel.org

Fix inconsistent IS_ERR and PTR_ERR in sun4i_pwm_probe().

The proper pointers to be passed as arguments are pwm->clk and pwm->bus_clk.

This bug was detected with the help of Coccinelle.

Fixes: b8d74644f34a ("pwm: sun4i: Prefer "mod" clock to unnamed")
Fixes: 5b090b430d75 ("pwm: sun4i: Add an optional probe for bus clock")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
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
-- 
2.23.0
