From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] pwm: sun4i: add NULL check on of_match_device() return value
Date: Fri, 7 Jul 2017 01:39:39 -0500
Message-ID: <20170707063939.GA20510@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: linux-pwm@vger.kernel.org

Check return value from call to of_match_device()
in order to prevent a NULL pointer dereference.

In case of NULL print error message and return -ENODEV

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/pwm/pwm-sun4i.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 1284ffa..295ca19 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -321,6 +321,10 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 
 	match = of_match_device(sun4i_pwm_dt_ids, &pdev->dev);
+	if (!match) {
+		dev_err(&pdev->dev, "failed to match device\n");
+		return -ENODEV;
+	}
 
 	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
 	if (!pwm)
-- 
2.5.0
