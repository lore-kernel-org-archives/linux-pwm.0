From: Ryder Lee <ryder.lee@mediatek.com>
Subject: [resend PATCH 2/3] pwm: mediatek: add pwm support for MT7629 SoC
Date: Tue, 13 Nov 2018 10:08:23 +0800
Message-ID: <9043534495d49c532bdb0b904344b77faeb41359.1542074855.git.ryder.lee@mediatek.com>
References: <4c9044427b1aab373acd6ac76f0c905e2be79784.1542074855.git.ryder.lee@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4c9044427b1aab373acd6ac76f0c905e2be79784.1542074855.git.ryder.lee@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org, Weijie Gao <weijie.gao@mediatek.com>, Roy Luo <cheng-hao.luo@mediatek.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Ryder Lee <ryder.lee@mediatek.com>
List-Id: linux-pwm@vger.kernel.org

This adds pwm controller support for MT7629 SoC.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pwm/pwm-mediatek.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 9400c41..4ed95e5 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -292,11 +292,16 @@ static int mtk_pwm_remove(struct platform_device *pdev)
 	.pwm45_fixup = true,
 };
 
+static const struct mtk_pwm_platform_data mt7629_pwm_data = {
+	.num_pwms = 1,
+};
+
 static const struct of_device_id mtk_pwm_of_match[] = {
 	{ .compatible = "mediatek,mt2712-pwm", .data = &mt2712_pwm_data },
 	{ .compatible = "mediatek,mt7622-pwm", .data = &mt7622_pwm_data },
 	{ .compatible = "mediatek,mt7623-pwm", .data = &mt7623_pwm_data },
 	{ .compatible = "mediatek,mt7628-pwm", .data = &mt7628_pwm_data },
+	{ .compatible = "mediatek,mt7629-pwm", .data = &mt7629_pwm_data },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, mtk_pwm_of_match);
-- 
1.9.1
