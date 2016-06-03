From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 11/14] regulator: pwm: properly initialize the ->state field
Date: Fri,  3 Jun 2016 10:23:09 +0200
Message-ID: <1464942192-25967-12-git-send-email-boris.brezillon@free-electrons.com>
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

The ->state field is currently initialized to 0, thus referencing the
voltage selector at index 0, which might not reflect the current voltage
value.
If possible, retrieve the current voltage selector from the PWM state, else
return -EINVAL.

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
Heiko, Mark,

I know you already added your Tested-by/Acked-by tags on this patch
but this version has slightly change and is now making use of the
pwm_get_relative_duty_cycle() helper instead of manually converting
the absolute duty_cycle value into a relative one.
---
 drivers/regulator/pwm-regulator.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index bf033fd..8c56e16 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -48,10 +48,31 @@ struct pwm_voltages {
 /**
  * Voltage table call-backs
  */
+static void pwm_regulator_init_state(struct regulator_dev *rdev)
+{
+	struct pwm_regulator_data *drvdata = rdev_get_drvdata(rdev);
+	struct pwm_state pwm_state;
+	unsigned int dutycycle;
+	int i;
+
+	pwm_get_state(drvdata->pwm, &pwm_state);
+	dutycycle = pwm_get_relative_duty_cycle(&pwm_state, 100);
+
+	for (i = 0; i < rdev->desc->n_voltages; i++) {
+		if (dutycycle == drvdata->duty_cycle_table[i].dutycycle) {
+			drvdata->state = i;
+			return;
+		}
+	}
+}
+
 static int pwm_regulator_get_voltage_sel(struct regulator_dev *rdev)
 {
 	struct pwm_regulator_data *drvdata = rdev_get_drvdata(rdev);
 
+	if (drvdata->state < 0)
+		pwm_regulator_init_state(rdev);
+
 	return drvdata->state;
 }
 
@@ -203,6 +224,7 @@ static int pwm_regulator_init_table(struct platform_device *pdev,
 		return ret;
 	}
 
+	drvdata->state			= -EINVAL;
 	drvdata->duty_cycle_table	= duty_cycle_table;
 	memcpy(&drvdata->ops, &pwm_regulator_voltage_table_ops,
 	       sizeof(drvdata->ops));
-- 
2.7.4
