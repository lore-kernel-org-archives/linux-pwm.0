From: Jitao Shi <jitao.shi@mediatek.com>
Subject: [v2 3/3] drm/mediatek: add mipi_tx driver for mt8183
Date: Tue, 16 Apr 2019 13:42:17 +0800
Message-ID: <20190416054217.75387-4-jitao.shi@mediatek.com>
References: <20190416054217.75387-1-jitao.shi@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190416054217.75387-1-jitao.shi@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-pwm@vger.kernel.org, David Airlie <airlied@linux.ie>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Jitao Shi <jitao.shi@mediatek.com>, Thierry Reding <treding@nvidia.com>, Ajay Kumar <ajaykumar.rs@samsung.com>, Inki Dae <inki.dae@samsung.com>, Rahul Sharma <rahul.sharma@samsung.com>, Sean Paul <seanpaul@chromium.org>, Vincent Palatin <vpalatin@chromium.org>, Andy Yan <andy.yan@rock-chips.com>, Philipp Zabel <p.zabel@pengutronix.de>, Russell King <rmk+kernel@arm.linux.org.uk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>, yingjoe.chen@mediatek.com, eddie.huang@mediatek.com, cawa.cheng@mediatek.com, bibby.hsieh@mediatek.com, ck.hu@mediate
List-Id: linux-pwm@vger.kernel.org

This patch add mt8183 mipi_tx driver.
And also support other chips that use the same binding and driver.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
---
 drivers/gpu/drm/mediatek/Makefile             |   1 +
 drivers/gpu/drm/mediatek/mtk_mipi_tx.c        |   2 +
 drivers/gpu/drm/mediatek/mtk_mipi_tx.h        |   1 +
 drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c | 154 ++++++++++++++++++
 4 files changed, 158 insertions(+)
 create mode 100644 drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c

diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediatek/Makefile
index 2c8de1f5a5ee..8067a4be8311 100644
--- a/drivers/gpu/drm/mediatek/Makefile
+++ b/drivers/gpu/drm/mediatek/Makefile
@@ -13,6 +13,7 @@ mediatek-drm-y := mtk_disp_color.o \
 		  mtk_dsi.o \
 		  mtk_mipi_tx.o \
 		  mtk_mt8173_mipi_tx.o \
+		  mtk_mt8183_mipi_tx.o \
 		  mtk_dpi.o
 
 obj-$(CONFIG_DRM_MEDIATEK) += mediatek-drm.o
diff --git a/drivers/gpu/drm/mediatek/mtk_mipi_tx.c b/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
index d832798598a6..6acef158ac2a 100644
--- a/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
+++ b/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
@@ -188,6 +188,8 @@ static const struct of_device_id mtk_mipi_tx_match[] = {
 	  .data = &mt2701_mipitx_data },
 	{ .compatible = "mediatek,mt8173-mipi-tx",
 	  .data = &mt8173_mipitx_data },
+	{ .compatible = "mediatek,mt8183-mipi-tx",
+	  .data = &mt8183_mipitx_data },
 	{ },
 };
 
diff --git a/drivers/gpu/drm/mediatek/mtk_mipi_tx.h b/drivers/gpu/drm/mediatek/mtk_mipi_tx.h
index 2d7f05b0d6a7..af83023e81cf 100644
--- a/drivers/gpu/drm/mediatek/mtk_mipi_tx.h
+++ b/drivers/gpu/drm/mediatek/mtk_mipi_tx.h
@@ -47,5 +47,6 @@ unsigned long mtk_mipi_tx_pll_recalc_rate(struct clk_hw *hw,
 
 extern const struct mtk_mipitx_data mt2701_mipitx_data;
 extern const struct mtk_mipitx_data mt8173_mipitx_data;
+extern const struct mtk_mipitx_data mt8183_mipitx_data;
 
 #endif
diff --git a/drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c b/drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c
new file mode 100644
index 000000000000..a1399568b8d5
--- /dev/null
+++ b/drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ * Author: jitao.shi <jitao.shi@mediatek.com>
+ */
+
+#include "mtk_mipi_tx.h"
+
+#define MIPITX_LANE_CON		0x000c
+#define RG_DSI_CPHY_T1DRV_EN		BIT(0)
+#define RG_DSI_ANA_CK_SEL		BIT(1)
+#define RG_DSI_PHY_CK_SEL		BIT(2)
+#define RG_DSI_CPHY_EN			BIT(3)
+#define RG_DSI_PHYCK_INV_EN		BIT(4)
+#define RG_DSI_PWR04_EN			BIT(5)
+#define RG_DSI_BG_LPF_EN		BIT(6)
+#define RG_DSI_BG_CORE_EN		BIT(7)
+#define RG_DSI_PAD_TIEL_SEL		BIT(8)
+
+#define MIPITX_PLL_PWR	0x0028
+#define MIPITX_PLL_CON0	0x002c
+#define MIPITX_PLL_CON1	0x0030
+#define MIPITX_PLL_CON2	0x0034
+#define MIPITX_PLL_CON3	0x0038
+#define MIPITX_PLL_CON4	0x003c
+#define RG_DSI_PLL_IBIAS		(3 << 10)
+
+#define MIPITX_D2_SW_CTL_EN	0x0144
+#define MIPITX_D0_SW_CTL_EN	0x0244
+#define MIPITX_CK_CKMODE_EN	0x0328
+#define DSI_CK_CKMODE_EN		BIT(0)
+#define MIPITX_CK_SW_CTL_EN	0x0344
+#define MIPITX_D1_SW_CTL_EN	0x0444
+#define MIPITX_D3_SW_CTL_EN	0x0544
+#define DSI_SW_CTL_EN			BIT(0)
+#define AD_DSI_PLL_SDM_PWR_ON		BIT(0)
+#define AD_DSI_PLL_SDM_ISO_EN		BIT(1)
+
+#define RG_DSI_PLL_EN			BIT(4)
+#define RG_DSI_PLL_POSDIV		(0x7 << 8)
+
+static int mtk_mipi_tx_pll_prepare(struct clk_hw *hw)
+{
+	struct mtk_mipi_tx *mipi_tx = mtk_mipi_tx_from_clk_hw(hw);
+	unsigned int txdiv, txdiv0;
+	u64 pcw;
+	int ret;
+
+	dev_dbg(mipi_tx->dev, "prepare: %u bps\n", mipi_tx->data_rate);
+
+	if (mipi_tx->data_rate >= 2000000000) {
+		txdiv = 1;
+		txdiv0 = 0;
+	} else if (mipi_tx->data_rate >= 1000000000) {
+		txdiv = 2;
+		txdiv0 = 1;
+	} else if (mipi_tx->data_rate >= 500000000) {
+		txdiv = 4;
+		txdiv0 = 2;
+	} else if (mipi_tx->data_rate > 250000000) {
+		txdiv = 8;
+		txdiv0 = 3;
+	} else if (mipi_tx->data_rate >= 125000000) {
+		txdiv = 16;
+		txdiv0 = 4;
+	} else {
+		return -EINVAL;
+	}
+
+	ret = clk_prepare_enable(mipi_tx->ref_clk);
+	if (ret < 0) {
+		dev_err(mipi_tx->dev,
+			"can't prepare and enable mipi_tx ref_clk %d\n", ret);
+		return ret;
+	}
+
+	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_PLL_CON4, RG_DSI_PLL_IBIAS);
+
+	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_PLL_PWR, AD_DSI_PLL_SDM_PWR_ON);
+	usleep_range(30, 100);
+	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_PLL_PWR, AD_DSI_PLL_SDM_ISO_EN);
+	pcw = div_u64(((u64)mipi_tx->data_rate * txdiv) << 24, 26000000);
+	writel(pcw, mipi_tx->regs + MIPITX_PLL_CON0);
+	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_PLL_CON1, RG_DSI_PLL_POSDIV,
+				txdiv0 << 8);
+	usleep_range(1000, 2000);
+	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_PLL_CON1, RG_DSI_PLL_EN);
+
+	return 0;
+}
+
+static void mtk_mipi_tx_pll_unprepare(struct clk_hw *hw)
+{
+	struct mtk_mipi_tx *mipi_tx = mtk_mipi_tx_from_clk_hw(hw);
+
+	dev_dbg(mipi_tx->dev, "unprepare\n");
+
+	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_PLL_CON1, RG_DSI_PLL_EN);
+
+	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_PLL_PWR, AD_DSI_PLL_SDM_ISO_EN);
+	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_PLL_PWR, AD_DSI_PLL_SDM_PWR_ON);
+	clk_disable_unprepare(mipi_tx->ref_clk);
+}
+
+static const struct clk_ops mtk_mipi_tx_pll_ops = {
+	.prepare = mtk_mipi_tx_pll_prepare,
+	.unprepare = mtk_mipi_tx_pll_unprepare,
+	.round_rate = mtk_mipi_tx_pll_round_rate,
+	.set_rate = mtk_mipi_tx_pll_set_rate,
+	.recalc_rate = mtk_mipi_tx_pll_recalc_rate,
+};
+
+static void mtk_mipi_tx_power_on_signal(struct phy *phy)
+{
+	struct mtk_mipi_tx *mipi_tx = phy_get_drvdata(phy);
+
+	/* BG_LPF_EN / BG_CORE_EN */
+	writel(RG_DSI_PAD_TIEL_SEL | RG_DSI_BG_CORE_EN,
+	       mipi_tx->regs + MIPITX_LANE_CON);
+	usleep_range(30, 100);
+	writel(RG_DSI_BG_CORE_EN | RG_DSI_BG_LPF_EN,
+	       mipi_tx->regs + MIPITX_LANE_CON);
+
+	/* Switch OFF each Lane */
+	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_D0_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_D1_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_D2_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_D3_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_CK_SW_CTL_EN, DSI_SW_CTL_EN);
+
+	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_CK_CKMODE_EN, DSI_CK_CKMODE_EN);
+}
+
+static void mtk_mipi_tx_power_off_signal(struct phy *phy)
+{
+	struct mtk_mipi_tx *mipi_tx = phy_get_drvdata(phy);
+
+	/* Switch ON each Lane */
+	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_D0_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_D1_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_D2_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_D3_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_CK_SW_CTL_EN, DSI_SW_CTL_EN);
+
+	writel(RG_DSI_PAD_TIEL_SEL | RG_DSI_BG_CORE_EN,
+	       mipi_tx->regs + MIPITX_LANE_CON);
+	writel(RG_DSI_PAD_TIEL_SEL, mipi_tx->regs + MIPITX_LANE_CON);
+}
+
+const struct mtk_mipitx_data mt8183_mipitx_data = {
+	.mipi_tx_clk_ops = &mtk_mipi_tx_pll_ops,
+	.mipi_tx_enable_signal = mtk_mipi_tx_power_on_signal,
+	.mipi_tx_disable_signal = mtk_mipi_tx_power_off_signal,
+};
-- 
2.21.0
