From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v4 4/4] misc: atmel_tclib: get and use slow clock
Date: Sun, 16 Aug 2015 11:23:46 +0200
Message-ID: <1439717026-30634-5-git-send-email-alexandre.belloni@free-electrons.com>
References: <1439717026-30634-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1439717026-30634-1-git-send-email-alexandre.belloni@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pwm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

From: Boris Brezillon <boris.brezillon@free-electrons.com>

Commit dca1a4b5ff6e ("clk: at91: keep slow clk enabled to prevent system
hang") added a workaround for the slow clock as it is not properly handled
by its users.

Get and use the slow clock as it is necessary for the timer counters.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org
 drivers/clocksource/tcb_clksrc.c | 10 +++++++++-
 drivers/misc/atmel_tclib.c       |  4 ++++
 drivers/pwm/pwm-atmel-tcb.c      | 26 +++++++++++++++++++-------
 include/linux/atmel_tc.h         |  1 +
 4 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
index b9b7277173c2..ba1e5d55d3bf 100644
--- a/drivers/clocksource/tcb_clksrc.c
+++ b/drivers/clocksource/tcb_clksrc.c
@@ -184,10 +184,17 @@ static int __init setup_clkevents(struct atmel_tc *tc, int clk32k_divisor_idx)
 	struct clk *t2_clk = tc->clk[2];
 	int irq = tc->irq[2];
 
+	ret = clk_prepare_enable(tc->slow_clk);
+	if (ret)
+		return ret;
+
 	/* try to enable t2 clk to avoid future errors in mode change */
 	ret = clk_prepare_enable(t2_clk);
-	if (ret)
+	if (ret) {
+		clk_disable_unprepare(tc->slow_clk);
 		return ret;
+	}
+
 	clk_disable(t2_clk);
 
 	clkevt.regs = tc->regs;
@@ -200,6 +207,7 @@ static int __init setup_clkevents(struct atmel_tc *tc, int clk32k_divisor_idx)
 	ret = request_irq(irq, ch2_irq, IRQF_TIMER, "tc_clkevt", &clkevt);
 	if (ret) {
 		clk_unprepare(t2_clk);
+		clk_disable_unprepare(tc->slow_clk);
 		return ret;
 	}
 
diff --git a/drivers/misc/atmel_tclib.c b/drivers/misc/atmel_tclib.c
index 0ca05c3ec8d6..ac24a4bd63f7 100644
--- a/drivers/misc/atmel_tclib.c
+++ b/drivers/misc/atmel_tclib.c
@@ -125,6 +125,10 @@ static int __init tc_probe(struct platform_device *pdev)
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
+	tc->slow_clk = devm_clk_get(&pdev->dev, "slow_clk");
+	if (IS_ERR(tc->slow_clk))
+		return PTR_ERR(tc->slow_clk);
+
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	tc->regs = devm_ioremap_resource(&pdev->dev, r);
 	if (IS_ERR(tc->regs))
diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index d14e0677c92d..f64ee392f620 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -305,7 +305,7 @@ static int atmel_tcb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 */
 	if (i == 5) {
 		i = slowclk;
-		rate = 32768;
+		rate = clk_get_rate(tc->slow_clk);
 		min = div_u64(NSEC_PER_SEC, rate);
 		max = min << tc->tcb_config->counter_width;
 
@@ -387,9 +387,9 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 
 	tcbpwm = devm_kzalloc(&pdev->dev, sizeof(*tcbpwm), GFP_KERNEL);
 	if (tcbpwm == NULL) {
-		atmel_tc_free(tc);
+		err = -ENOMEM;
 		dev_err(&pdev->dev, "failed to allocate memory\n");
-		return -ENOMEM;
+		goto err_free_tc;
 	}
 
 	tcbpwm->chip.dev = &pdev->dev;
@@ -400,17 +400,27 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 	tcbpwm->chip.npwm = NPWM;
 	tcbpwm->tc = tc;
 
+	err = clk_prepare_enable(tc->slow_clk);
+	if (err)
+		goto err_free_tc;
+
 	spin_lock_init(&tcbpwm->lock);
 
 	err = pwmchip_add(&tcbpwm->chip);
-	if (err < 0) {
-		atmel_tc_free(tc);
-		return err;
-	}
+	if (err < 0)
+		goto err_disable_clk;
 
 	platform_set_drvdata(pdev, tcbpwm);
 
 	return 0;
+
+err_disable_clk:
+	clk_disable_unprepare(tcbpwm->tc->slow_clk);
+
+err_free_tc:
+	atmel_tc_free(tc);
+
+	return err;
 }
 
 static int atmel_tcb_pwm_remove(struct platform_device *pdev)
@@ -418,6 +428,8 @@ static int atmel_tcb_pwm_remove(struct platform_device *pdev)
 	struct atmel_tcb_pwm_chip *tcbpwm = platform_get_drvdata(pdev);
 	int err;
 
+	clk_disable_unprepare(tcbpwm->tc->slow_clk);
+
 	err = pwmchip_remove(&tcbpwm->chip);
 	if (err < 0)
 		return err;
diff --git a/include/linux/atmel_tc.h b/include/linux/atmel_tc.h
index b87c1c7c242a..468fdfa643f0 100644
--- a/include/linux/atmel_tc.h
+++ b/include/linux/atmel_tc.h
@@ -67,6 +67,7 @@ struct atmel_tc {
 	const struct atmel_tcb_config *tcb_config;
 	int			irq[3];
 	struct clk		*clk[3];
+	struct clk		*slow_clk;
 	struct list_head	node;
 	bool			allocated;
 };
-- 
2.1.4
