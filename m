From: Sam Shih <sam.shih@mediatek.com>
Subject: [PATCH v2 8/10] pwm: mediatek: add new property and fix mt7628 pwm
Date: Wed, 14 Aug 2019 18:43:38 +0800
Message-ID: <1565779497-23621-1-git-send-email-sam.shih@mediatek.com>
References: <621e49c01b943edb6ddac9182f34719eb0727f01.1548313019.git.ryder.lee@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <621e49c01b943edb6ddac9182f34719eb0727f01.1548313019.git.ryder.lee@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, sam shih <sam.shih@mediatek.com>
List-Id: linux-pwm@vger.kernel.org

From: sam shih <sam.shih@mediatek.com>

This fix mt7628 pwm during configure from userspace. The SoC
is legacy MIPS and has no complex clock tree. This patch add property
clock-frequency to the SoC specific data and legacy MIPS SoC need to
configure it in DT. This property is use for period calculation.

Signed-off-by: Sam Shih <sam.shih@mediatek.com>
---
 drivers/pwm/pwm-mediatek.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index d696df7a58fa..922a7543a2b1 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -53,6 +53,7 @@ struct pwm_mediatek_chip {
 	struct clk *clk_top;
 	struct clk *clk_main;
 	struct clk **clk_pwms;
+	unsigned int clock_frequency;
 	const struct pwm_mediatek_of_data *soc;
 };
 
@@ -139,7 +140,10 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	/* Using resolution in picosecond gets accuracy higher */
 	resolution = (u64)NSEC_PER_SEC * 1000;
-	do_div(resolution, clk_get_rate(clk));
+	if (pc->soc->has_clks)
+		do_div(resolution, clk_get_rate(clk));
+	else
+		do_div(resolution, pc->clock_frequency);
 
 	cnt_period = DIV_ROUND_CLOSEST_ULL((u64)period_ns * 1000, resolution);
 	while (cnt_period > 8191) {
@@ -216,6 +220,7 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
 	struct pwm_mediatek_chip *pc;
 	struct resource *res;
 	unsigned int npwms;
+	unsigned int clock_frequency;
 	int ret;
 
 	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
@@ -265,6 +270,14 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
 			if (IS_ERR(pc->clk_pwms[i]))
 				return PTR_ERR(pc->clk_pwms[i]);
 		}
+	} else {
+		ret = of_property_read_u32(np, "clock-frequency",
+						&clock_frequency);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "failed to get clock_frequency\n");
+			return ret;
+		}
+		pc->clock_frequency = clock_frequency;
 	}
 
 	platform_set_drvdata(pdev, pc);
-- 
2.17.1
