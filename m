From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH 4/8] mfd: stm32-timers: add support for dmas
Date: Tue, 16 Jan 2018 13:43:47 +0100
Message-ID: <1516106631-18722-5-git-send-email-fabrice.gasnier@st.com>
References: <1516106631-18722-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516106631-18722-1-git-send-email-fabrice.gasnier@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, thierry.reding@gmail.com, robh+dt@kernel.org, alexandre.torgue@st.com, benjamin.gaignard@linaro.org
Cc: mark.rutland@arm.com, linux@armlinux.org.uk, mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com, benjamin.gaignard@st.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

STM32 Timers can support up to 7 dma requests:
4 channels, update, compare and trigger.
Optionally request part, or all dmas from stm32-timers MFD core.
Also, keep reference of device's bus address to allow child drivers to
transfer data from/to device by using dma.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/mfd/stm32-timers.c       | 37 ++++++++++++++++++++++++++++++++++++-
 include/linux/mfd/stm32-timers.h | 14 ++++++++++++++
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/stm32-timers.c b/drivers/mfd/stm32-timers.c
index a6675a4..372b51e 100644
--- a/drivers/mfd/stm32-timers.c
+++ b/drivers/mfd/stm32-timers.c
@@ -29,6 +29,23 @@ static void stm32_timers_get_arr_size(struct stm32_timers *ddata)
 	regmap_write(ddata->regmap, TIM_ARR, 0x0);
 }
 
+static void stm32_timers_dma_probe(struct device *dev,
+				   struct stm32_timers *ddata)
+{
+	int i;
+	char name[4];
+
+	for (i = STM32_TIMERS_DMA_CH1; i <= STM32_TIMERS_DMA_CH4; i++) {
+		snprintf(name, ARRAY_SIZE(name), "ch%1d", i + 1);
+		ddata->dmas[i] = dma_request_slave_channel(dev, name);
+	}
+	ddata->dmas[STM32_TIMERS_DMA_UP] = dma_request_slave_channel(dev, "up");
+	ddata->dmas[STM32_TIMERS_DMA_TRIG] =
+		dma_request_slave_channel(dev, "trig");
+	ddata->dmas[STM32_TIMERS_DMA_COM] =
+		dma_request_slave_channel(dev, "com");
+}
+
 static int stm32_timers_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -44,6 +61,7 @@ static int stm32_timers_probe(struct platform_device *pdev)
 	mmio = devm_ioremap_resource(dev, res);
 	if (IS_ERR(mmio))
 		return PTR_ERR(mmio);
+	ddata->phys_base = res->start;
 
 	ddata->regmap = devm_regmap_init_mmio_clk(dev, "int", mmio,
 						  &stm32_timers_regmap_cfg);
@@ -56,9 +74,25 @@ static int stm32_timers_probe(struct platform_device *pdev)
 
 	stm32_timers_get_arr_size(ddata);
 
+	stm32_timers_dma_probe(dev, ddata);
+
 	platform_set_drvdata(pdev, ddata);
 
-	return devm_of_platform_populate(&pdev->dev);
+	return of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
+}
+
+static int stm32_timers_remove(struct platform_device *pdev)
+{
+	struct stm32_timers *ddata = platform_get_drvdata(pdev);
+	int i;
+
+	of_platform_depopulate(&pdev->dev);
+
+	for (i = 0; i < STM32_TIMERS_MAX_DMAS; i++)
+		if (ddata->dmas[i])
+			dma_release_channel(ddata->dmas[i]);
+
+	return 0;
 }
 
 static const struct of_device_id stm32_timers_of_match[] = {
@@ -69,6 +103,7 @@ static int stm32_timers_probe(struct platform_device *pdev)
 
 static struct platform_driver stm32_timers_driver = {
 	.probe = stm32_timers_probe,
+	.remove = stm32_timers_remove,
 	.driver	= {
 		.name = "stm32-timers",
 		.of_match_table = stm32_timers_of_match,
diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
index ce7346e..2b4ffb9 100644
--- a/include/linux/mfd/stm32-timers.h
+++ b/include/linux/mfd/stm32-timers.h
@@ -10,6 +10,7 @@
 #define _LINUX_STM32_GPTIMER_H_
 
 #include <linux/clk.h>
+#include <linux/dmaengine.h>
 #include <linux/regmap.h>
 
 #define TIM_CR1		0x00	/* Control Register 1      */
@@ -67,9 +68,22 @@
 #define TIM_BDTR_BKF_SHIFT	16
 #define TIM_BDTR_BK2F_SHIFT	20
 
+enum stm32_timers_dmas {
+	STM32_TIMERS_DMA_CH1,
+	STM32_TIMERS_DMA_CH2,
+	STM32_TIMERS_DMA_CH3,
+	STM32_TIMERS_DMA_CH4,
+	STM32_TIMERS_DMA_UP,
+	STM32_TIMERS_DMA_TRIG,
+	STM32_TIMERS_DMA_COM,
+	STM32_TIMERS_MAX_DMAS,
+};
+
 struct stm32_timers {
 	struct clk *clk;
 	struct regmap *regmap;
+	phys_addr_t phys_base;
 	u32 max_arr;
+	struct dma_chan *dmas[STM32_TIMERS_MAX_DMAS];
 };
 #endif
-- 
1.9.1
