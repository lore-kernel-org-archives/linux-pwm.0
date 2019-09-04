From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH -next] pwm: sifive: Remove redundant dev_err call in
 pwm_sifive_probe()
Date: Wed, 4 Sep 2019 11:18:36 +0000
Message-ID: <20190904111836.122616-1-weiyongjun1@huawei.com>
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
To: Thierry Reding <thierry.reding@gmail.com>, Palmer Dabbelt <palmer@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>
Cc: kernel-janitors@vger.kernel.org, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, Wei Yongjun <weiyongjun1@huawei.com>
List-Id: linux-pwm@vger.kernel.org

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/pwm/pwm-sifive.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index a7c107f19e66..8fcd05e74581 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -250,10 +250,8 @@ static int pwm_sifive_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	ddata->regs = devm_ioremap_resource(dev, res);
-	if (IS_ERR(ddata->regs)) {
-		dev_err(dev, "Unable to map IO resources\n");
+	if (IS_ERR(ddata->regs))
 		return PTR_ERR(ddata->regs);
-	}
 
 	ddata->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(ddata->clk)) {
