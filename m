From: Sam Shih <sam.shih@mediatek.com>
Subject: [PATCH v4 2/10] pwm: mediatek: droping the check for of_device_get_match_data
Date: Tue, 20 Aug 2019 09:40:17 +0800
Message-ID: <1566265225-27452-3-git-send-email-sam.shih@mediatek.com>
References: <1566265225-27452-1-git-send-email-sam.shih@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1566265225-27452-1-git-send-email-sam.shih@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, sam shih <sam.shih@mediatek.com>
List-Id: linux-pwm@vger.kernel.org

From: sam shih <sam.shih@mediatek.com>

This patch drop the check for of_device_get_match_data.
Due to the only way call driver probe is compatible match,
In this case, the platform data should never be NULL.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Sam Shih <sam.shih@mediatek.com>
---
Used:
https://patchwork.kernel.org/patch/11096905/
Changes since v4:
Follow reviewer's comments:
Move the changes of droping the check for of_device_get_match_data
returning non-NULL to this patch
---
 drivers/pwm/pwm-mediatek.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 287fda3674ce..f9d67fb66adb 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -236,10 +236,7 @@ static int mtk_pwm_probe(struct platform_device *pdev)
 	if (!pc)
 		return -ENOMEM;
 
-	data = of_device_get_match_data(&pdev->dev);
-	if (data == NULL)
-		return -EINVAL;
-	pc->soc = data;
+	pc->soc = of_device_get_match_data(&pdev->dev);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pc->regs = devm_ioremap_resource(&pdev->dev, res);
-- 
2.17.1
