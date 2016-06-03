From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 05/14] pwm: rockchip: Avoid glitches on already running PWMs
Date: Fri,  3 Jun 2016 10:23:03 +0200
Message-ID: <1464942192-25967-6-git-send-email-boris.brezillon@free-electrons.com>
References: <1464942192-25967-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1464942192-25967-1-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>, Doug Anderson <dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Milo Kim <milo.kim-l0cyMroinI0@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>, Stephen Barber <smbarber-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Ajit Pal Singh <ajitpal.singh-qxv4g6HH51o@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

The current logic will disable the PWM clk even if the PWM was left
enabled by the bootloader (because it's controlling a critical device
like a regulator for example).
Keep the PWM clk enabled if the PWM is enabled to avoid any glitches.

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/pwm/pwm-rockchip.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index dfacf7d..798a787 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -299,6 +299,7 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *id;
 	struct rockchip_pwm_chip *pc;
+	struct pwm_state state;
 	struct resource *r;
 	int ret;
 
@@ -319,7 +320,7 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(pc->clk))
 		return PTR_ERR(pc->clk);
 
-	ret = clk_prepare(pc->clk);
+	ret = clk_prepare_enable(pc->clk);
 	if (ret)
 		return ret;
 
@@ -342,12 +343,33 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
 	}
 
+	/* Keep the PWM clk enabled if the PWM appears to be up and running. */
+	pwm_get_state(pc->chip.pwms, &state);
+	if (!state.enabled)
+		clk_disable(pc->clk);
+
 	return ret;
 }
 
 static int rockchip_pwm_remove(struct platform_device *pdev)
 {
 	struct rockchip_pwm_chip *pc = platform_get_drvdata(pdev);
+	struct pwm_state state;
+
+	/*
+	 * Disable the PWM clk before unpreparing it if the PWM device is still
+	 * running. This should only happen when the last PWM user left it
+	 * enabled, or when nobody requested a PWM that was previously enabled
+	 * by the bootloader.
+	 *
+	 * FIXME: Maybe the core should disable all PWM devices in
+	 * pwmchip_remove(). In this case we'd only have to call
+	 * clk_unprepare() after pwmchip_remove().
+	 *
+	 */
+	pwm_get_state(pc->chip.pwms, &state);
+	if (state.enabled)
+		clk_disable(pc->clk);
 
 	clk_unprepare(pc->clk);
 
-- 
2.7.4
