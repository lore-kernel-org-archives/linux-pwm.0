From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH] pwm: atmel-hlcdc: Implement the suspend/resume hooks
Date: Wed,  1 Mar 2017 15:52:27 +0100
Message-ID: <1488379947-13123-1-git-send-email-boris.brezillon@free-electrons.com>
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
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-arm-kernel@lists.infradead.org, Boris Brezillon <boris.brezillon@free-electrons.com>
List-Id: linux-pwm@vger.kernel.org

Implement the suspend/resume hooks to make sure the PWM device is
restored to a correct state after a suspend.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
This patch depends on the atomic conversion patch [1].

[1]https://patchwork.ozlabs.org/patch/734251/

 drivers/pwm/pwm-atmel-hlcdc.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index a3c65a165a52..e432f4d3d8d4 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -191,6 +191,38 @@ static const struct atmel_hlcdc_pwm_errata atmel_hlcdc_pwm_sama5d3_errata = {
 	.div1_clk_erratum = true,
 };
 
+static int atmel_hlcdc_pwm_suspend(struct device *dev)
+{
+	struct atmel_hlcdc_pwm *chip = dev_get_drvdata(dev);
+
+	/* Keep the periph clock enabled if the PWM is still running. */
+	if (pwm_is_enabled(&chip->chip.pwms[0]))
+		clk_disable_unprepare(chip->hlcdc->periph_clk);
+
+	return 0;
+}
+
+static int atmel_hlcdc_pwm_resume(struct device *dev)
+{
+	struct atmel_hlcdc_pwm *chip = dev_get_drvdata(dev);
+	struct pwm_state state;
+	int ret;
+
+	pwm_get_state(&chip->chip.pwms[0], &state);
+
+	/* Re-enable the periph clock it was stopped during suspend. */
+	if (!state.enabled) {
+		ret = clk_prepare_enable(chip->hlcdc->periph_clk);
+		if (ret)
+			return ret;
+	}
+
+	return atmel_hlcdc_pwm_apply(&chip->chip, &chip->chip.pwms[0], &state);
+}
+
+static SIMPLE_DEV_PM_OPS(atmel_hlcdc_pwm_pm_ops,
+			 atmel_hlcdc_pwm_suspend, atmel_hlcdc_pwm_resume);
+
 static const struct of_device_id atmel_hlcdc_dt_ids[] = {
 	{
 		.compatible = "atmel,at91sam9n12-hlcdc",
@@ -281,6 +313,7 @@ static struct platform_driver atmel_hlcdc_pwm_driver = {
 	.driver = {
 		.name = "atmel-hlcdc-pwm",
 		.of_match_table = atmel_hlcdc_pwm_dt_ids,
+		.pm = &atmel_hlcdc_pwm_pm_ops,
 	},
 	.probe = atmel_hlcdc_pwm_probe,
 	.remove = atmel_hlcdc_pwm_remove,
-- 
2.7.4
