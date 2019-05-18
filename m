From: Jitao Shi <jitao.shi@mediatek.com>
Subject: [v4 3/5] drm/mediatek: add mt8183 dpi dual edge support
Date: Sat, 18 May 2019 17:56:16 +0800
Message-ID: <20190518095618.18454-4-jitao.shi@mediatek.com>
References: <20190518095618.18454-1-jitao.shi@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190518095618.18454-1-jitao.shi@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-pwm@vger.kernel.org, David Airlie <airlied@linux.ie>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Jitao Shi <jitao.shi@mediatek.com>, Thierry Reding <treding@nvidia.com>, Ajay Kumar <ajaykumar.rs@samsung.com>, Inki Dae <inki.dae@samsung.com>, Rahul Sharma <rahul.sharma@samsung.com>, Sean Paul <seanpaul@chromium.org>, Vincent Palatin <vpalatin@chromium.org>, Andy Yan <andy.yan@rock-chips.com>, Philipp Zabel <p.zabel@pengutronix.de>, Russell King <rmk+kernel@arm.linux.org.uk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>, yingjoe.chen@mediatek.com, eddie.huang@mediatek.com, cawa.cheng@mediatek.com, bibby.hsieh@mediatek.com, ck.hu@mediate
List-Id: linux-pwm@vger.kernel.org

Add mt8183 dual edge support.
DPI sample the data both rising and falling edge.
It can reduce half data io pins.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index ccef3ac1c560..77e6e0f99188 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -682,6 +682,16 @@ static unsigned int mt2701_calculate_factor(int clock)
 		return 2;
 }
 
+static unsigned int mt8183_calculate_factor(int clock)
+{
+	if (clock <= 27000)
+		return 8;
+	else if (clock <= 167000)
+		return 4;
+	else
+		return 2;
+}
+
 static const struct mtk_dpi_conf mt8173_conf = {
 	.cal_factor = mt8173_calculate_factor,
 	.reg_h_fre_con = 0xe0,
@@ -693,6 +703,12 @@ static const struct mtk_dpi_conf mt2701_conf = {
 	.edge_sel_en = true,
 };
 
+static const struct mtk_dpi_conf mt8183_conf = {
+	.cal_factor = mt8183_calculate_factor,
+	.reg_h_fre_con = 0xe0,
+	.dual_edge = true,
+};
+
 static int mtk_dpi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -788,6 +804,9 @@ static const struct of_device_id mtk_dpi_of_ids[] = {
 	{ .compatible = "mediatek,mt8173-dpi",
 	  .data = &mt8173_conf,
 	},
+	{ .compatible = "mediatek,mt8183-dpi",
+	  .data = &mt8183_conf,
+	},
 	{ },
 };
 
-- 
2.21.0
