From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v3 11/12] regulator: pwm: implement ->enable(),
 ->disable() and ->is_enabled methods
Date: Mon, 21 Sep 2015 11:33:28 +0200
Message-ID: <1442828009-6241-12-git-send-email-boris.brezillon@free-electrons.com>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBK4676XQKGQEJH43HHQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1442828009-6241-1-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Doug Anderson <dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Implement the ->enable(), ->disable() and ->is_enabled methods and remove
the PWM call in ->set_voltage_sel().
This is particularly important for critical regulators tagged as always-on,
because not claiming the PWM (and its dependencies) might lead to
unpredictable behavior (like a system hang because the PWM clk is only
claimed when the PWM device is enabled).

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/regulator/pwm-regulator.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index cc549b7..9ffdbd6 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -69,12 +69,6 @@ static int pwm_regulator_set_voltage_sel(struct regulator_dev *rdev,
 
 	drvdata->state = selector;
 
-	ret = pwm_enable(drvdata->pwm);
-	if (ret) {
-		dev_err(&rdev->dev, "Failed to enable PWM\n");
-		return ret;
-	}
-
 	return 0;
 }
 
@@ -89,6 +83,29 @@ static int pwm_regulator_list_voltage(struct regulator_dev *rdev,
 	return drvdata->duty_cycle_table[selector].uV;
 }
 
+static int pwm_regulator_enable(struct regulator_dev *dev)
+{
+	struct pwm_regulator_data *drvdata = rdev_get_drvdata(dev);
+
+	return pwm_enable(drvdata->pwm);
+}
+
+static int pwm_regulator_disable(struct regulator_dev *dev)
+{
+	struct pwm_regulator_data *drvdata = rdev_get_drvdata(dev);
+
+	pwm_disable(drvdata->pwm);
+
+	return 0;
+}
+
+static int pwm_regulator_is_enabled(struct regulator_dev *dev)
+{
+	struct pwm_regulator_data *drvdata = rdev_get_drvdata(dev);
+
+	return pwm_is_enabled(drvdata->pwm);
+}
+
 /**
  * Continuous voltage call-backs
  */
@@ -144,11 +161,17 @@ static struct regulator_ops pwm_regulator_voltage_table_ops = {
 	.get_voltage_sel = pwm_regulator_get_voltage_sel,
 	.list_voltage    = pwm_regulator_list_voltage,
 	.map_voltage     = regulator_map_voltage_iterate,
+	.enable          = pwm_regulator_enable,
+	.disable         = pwm_regulator_disable,
+	.is_enabled      = pwm_regulator_is_enabled,
 };
 
 static struct regulator_ops pwm_regulator_voltage_continuous_ops = {
 	.get_voltage = pwm_regulator_get_voltage,
 	.set_voltage = pwm_regulator_set_voltage,
+	.enable          = pwm_regulator_enable,
+	.disable         = pwm_regulator_disable,
+	.is_enabled      = pwm_regulator_is_enabled,
 };
 
 static struct regulator_desc pwm_regulator_desc = {
-- 
1.9.1
