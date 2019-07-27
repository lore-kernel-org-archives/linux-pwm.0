From: Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
Subject: [PATCH] pwm: avoid disabling clk twice
Date: Sat, 27 Jul 2019 15:09:16 +0800
Message-ID: <20190727070916.2960-1-xywang.sjtu@sjtu.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
Cc: linux-pwm@vger.kernel.org, Wang Xiayang <xywang.sjtu@sjtu.edu.cn>, palmer@sifive.com, thierry.reding@gmail.com, paul.walmsley@sifive.com, linux-riscv@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Similar to commit 63fd4b94b948 ("serial: imx: fix error handling
in console_setup"), as ddata->clk has been explicitly disabled two
lines above, it should avoid being disabled for the second time.
clk_unprepare() suits here better.

Signed-off-by: Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
---
 drivers/pwm/pwm-sifive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index a7c107f19e66..00f6fab5bd3b 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -312,7 +312,7 @@ static int pwm_sifive_remove(struct platform_device *dev)
 	if (is_enabled)
 		clk_disable(ddata->clk);
 
-	clk_disable_unprepare(ddata->clk);
+	clk_unprepare(ddata->clk);
 	ret = pwmchip_remove(&ddata->chip);
 	clk_notifier_unregister(ddata->clk, &ddata->notifier);
 
-- 
2.11.0
