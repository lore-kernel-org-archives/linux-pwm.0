From: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Subject: [PATCH v3 2/6] pwm: core: make the PWM_POLARITY flag in DTB optional
Date: Fri, 7 Oct 2016 20:41:25 +0530
Message-ID: <20161007151129.6043-3-bhuvanchandra.dv@toradex.com>
References: <20161007151129.6043-1-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161007151129.6043-1-bhuvanchandra.dv@toradex.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: shawnguo@kernel.org, thierry.reding@gmail.com
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org, l.majewski@samsung.com, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, stefan@agner.ch, robh+dt@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com, linux-arm-kernel@lists.infradead.org, Lothar Wassmann <LW@KARO-electronics.de>
List-Id: linux-pwm@vger.kernel.org

From: Lothar Wassmann <LW@KARO-electronics.de>

Change the pwm chip driver registration, so that a chip driver that
supports polarity inversion can still be used with DTBs that don't
provide the 'PWM_POLARITY' flag.

This is done to provide polarity inversion support for the pwm-imx
driver without having to modify all existing DTS files.

Signed-off-by: Lothar Wassmann <LW@KARO-electronics.de>
Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Suggested-by: Sascha Hauer <s.hauer at pengutronix.de>
---
 drivers/pwm/core.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 195373e..85cdda6 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -137,9 +137,14 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_args *args)
 {
 	struct pwm_device *pwm;
 
+	/* check, whether the driver supports a third cell for flags */
 	if (pc->of_pwm_n_cells < 3)
 		return ERR_PTR(-EINVAL);
 
+	/* flags in the third cell are optional */
+	if (args->args_count < 2)
+		return ERR_PTR(-EINVAL);
+
 	if (args->args[0] >= pc->npwm)
 		return ERR_PTR(-EINVAL);
 
@@ -148,11 +153,10 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_args *args)
 		return pwm;
 
 	pwm->args.period = args->args[1];
+	pwm->args.polarity = PWM_POLARITY_NORMAL;
 
-	if (args->args[2] & PWM_POLARITY_INVERTED)
+	if (args->args_count > 2 && args->args[2] & PWM_POLARITY_INVERTED)
 		pwm->args.polarity = PWM_POLARITY_INVERSED;
-	else
-		pwm->args.polarity = PWM_POLARITY_NORMAL;
 
 	return pwm;
 }
@@ -163,9 +167,14 @@ of_pwm_simple_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
 {
 	struct pwm_device *pwm;
 
+	/* sanity check driver support */
 	if (pc->of_pwm_n_cells < 2)
 		return ERR_PTR(-EINVAL);
 
+	/* all cells are required */
+	if (args->args_count != pc->of_pwm_n_cells)
+		return ERR_PTR(-EINVAL);
+
 	if (args->args[0] >= pc->npwm)
 		return ERR_PTR(-EINVAL);
 
@@ -672,13 +681,6 @@ struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id)
 		goto put;
 	}
 
-	if (args.args_count != pc->of_pwm_n_cells) {
-		pr_debug("%s: wrong #pwm-cells for %s\n", np->full_name,
-			 args.np->full_name);
-		pwm = ERR_PTR(-EINVAL);
-		goto put;
-	}
-
 	pwm = pc->of_xlate(pc, &args);
 	if (IS_ERR(pwm))
 		goto put;
-- 
2.10.0
