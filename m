From: LABBE Corentin <clabbe.montjoie@gmail.com>
Subject: [PATCH v2 1/1] pwm: sun4i: fix a possible NULL dereference
Date: Tue, 16 Aug 2016 15:18:06 +0200
Message-ID: <1471353486-11514-2-git-send-email-clabbe.montjoie@gmail.com>
References: <1471353486-11514-1-git-send-email-clabbe.montjoie@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471353486-11514-1-git-send-email-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: maxime.ripard@free-electrons.com, thierry.reding@gmail.com, wens@csie.org
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, LABBE Corentin <clabbe.montjoie@gmail.com>
List-Id: linux-pwm@vger.kernel.org

of_match_device could return NULL, and so cause a NULL pointer
dereference later.

For fixing this problem, we use of_device_get_match_data(), this will
simplify the code a little by using a standard function for
getting the match data.

Reported-by: coverity (CID 1324139)
Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 drivers/pwm/pwm-sun4i.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 03a99a5..72f0060 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -309,9 +309,6 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	struct resource *res;
 	u32 val;
 	int i, ret;
-	const struct of_device_id *match;
-
-	match = of_match_device(sun4i_pwm_dt_ids, &pdev->dev);
 
 	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
 	if (!pwm)
@@ -326,7 +323,7 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(pwm->clk))
 		return PTR_ERR(pwm->clk);
 
-	pwm->data = match->data;
+	pwm->data = of_device_get_match_data(&pdev->dev);
 	pwm->chip.dev = &pdev->dev;
 	pwm->chip.ops = &sun4i_pwm_ops;
 	pwm->chip.base = -1;
-- 
2.7.3
