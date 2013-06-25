Return-Path: <weiyj.lk@gmail.com>
MIME-Version: 1.0
Date: Tue, 25 Jun 2013 10:09:57 +0800
Message-ID: <CAPgLHd8x180B9OxscFeiLrnYT4dUf66hZCxSJO_1E+uE5udx0A@mail.gmail.com>
Subject: [PATCH -next] pwm: renesas-tpu: fix return value check in tpu_probe()
From: Wei Yongjun <weiyj.lk@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-pwm.vger.kernel.org>
To: thierry.reding@gmail.com, laurent.pinchart+renesas@ideasonboard.com, axel.lin@ingics.com
Cc: yongjun_wei@trendmicro.com.cn, linux-pwm@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function devm_ioremap_resource() returns ERR_PTR()
and never returns NULL. The NULL test in the return value check should
be replaced with IS_ERR().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/pwm/pwm-renesas-tpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index 96e0cc4..70950e5 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -410,9 +410,9 @@ static int tpu_probe(struct platform_device *pdev)
 	}
 
 	tpu->base = devm_ioremap_resource(&pdev->dev, res);
-	if (tpu->base == NULL) {
+	if (IS_ERR(tpu->base)) {
 		dev_err(&pdev->dev, "failed to remap I/O memory\n");
-		return -ENXIO;
+		return PTR_ERR(tpu->base);
 	}
 
 	tpu->clk = devm_clk_get(&pdev->dev, NULL);
