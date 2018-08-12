From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 3/7] mfd: add atmel-lcdc driver
Date: Sun, 12 Aug 2018 20:46:25 +0200
Message-ID: <20180812184629.3808-3-sam@ravnborg.org>
References: <20180812184152.GA22343@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180812184152.GA22343@ravnborg.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Boris Brezillon <boris.brezillon@bootlin.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: devicetree@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

The LCDC IP used by some Atmel SOC's have a
    multifunction device that include two sub-devices:
    - pwm
    - display controller

This mfd device provide a regmap that can be used by the
sub-devices to safely access the registers.
The mfd device also support the clock used by the
LCDC IP + a bus clock that in some cases are required.

The driver is based on the atmel-hlcdc driver.

The Atmel SOC's are at91sam9261, at91sam9263 etc.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mfd/Kconfig            |  10 +++
 drivers/mfd/Makefile           |   1 +
 drivers/mfd/atmel-lcdc.c       | 158 +++++++++++++++++++++++++++++++++++
 include/linux/mfd/atmel-lcdc.h | 184 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 353 insertions(+)
 create mode 100644 drivers/mfd/atmel-lcdc.c
 create mode 100644 include/linux/mfd/atmel-lcdc.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index b860eb5aa194..f4851f0f033f 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -121,6 +121,16 @@ config MFD_ATMEL_HLCDC
 	  additional drivers must be enabled in order to use the
 	  functionality of the device.
 
+config MFD_ATMEL_LCDC
+	tristate "Atmel LCDC (LCD Controller)"
+	select MFD_CORE
+	depends on OF
+	help
+	  If you say yes here you get support for the LCDC block.
+	  This driver provides common support for accessing the device,
+	  additional drivers must be enabled in order to use the
+	  functionality of the device.
+
 config MFD_ATMEL_SMC
 	bool
 	select MFD_SYSCON
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index e9fd20dba18d..dba8465e0d96 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -186,6 +186,7 @@ obj-$(CONFIG_MFD_TPS65090)	+= tps65090.o
 obj-$(CONFIG_MFD_AAT2870_CORE)	+= aat2870-core.o
 obj-$(CONFIG_MFD_ATMEL_FLEXCOM)	+= atmel-flexcom.o
 obj-$(CONFIG_MFD_ATMEL_HLCDC)	+= atmel-hlcdc.o
+obj-$(CONFIG_MFD_ATMEL_LCDC)	+= atmel-lcdc.o
 obj-$(CONFIG_MFD_ATMEL_SMC)	+= atmel-smc.o
 obj-$(CONFIG_MFD_INTEL_LPSS)	+= intel-lpss.o
 obj-$(CONFIG_MFD_INTEL_LPSS_PCI)	+= intel-lpss-pci.o
diff --git a/drivers/mfd/atmel-lcdc.c b/drivers/mfd/atmel-lcdc.c
new file mode 100644
index 000000000000..8928976bafca
--- /dev/null
+++ b/drivers/mfd/atmel-lcdc.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Sam Ravnborg
+ *
+ * Author: Sam Ravnborg <sam@ravnborg.org>
+ *
+ * Based on atmel-hlcdc.c wich is:
+ * Copyright (C) 2014 Free Electrons
+ * Copyright (C) 2014 Atmel
+ * Author: Boris BREZILLON <boris.brezillon@free-electrons.com>
+ */
+
+#include <linux/mfd/atmel-lcdc.h>
+#include <linux/mfd/core.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+
+#define ATMEL_LCDC_REG_MAX		(0x1000 - 0x4)
+
+struct lcdc_regmap {
+	void __iomem *regs;
+};
+
+static const struct mfd_cell lcdc_cells[] = {
+	{
+		.name = "atmel-lcdc-pwm",
+		.of_compatible = "atmel,lcdc-pwm",
+	},
+	{
+		.name = "atmel-lcdc-dc",
+		.of_compatible = "atmel,lcdc-display-controller",
+	},
+};
+
+static int regmap_lcdc_reg_write(void *context, unsigned int reg,
+				 unsigned int val)
+{
+	struct lcdc_regmap *regmap = context;
+
+	writel(val, regmap->regs + reg);
+
+	return 0;
+}
+
+static int regmap_lcdc_reg_read(void *context, unsigned int reg,
+				unsigned int *val)
+{
+	struct lcdc_regmap *regmap = context;
+
+	*val = readl(regmap->regs + reg);
+
+	return 0;
+}
+
+static const struct regmap_config lcdc_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = ATMEL_LCDC_REG_MAX,
+	.reg_write = regmap_lcdc_reg_write,
+	.reg_read = regmap_lcdc_reg_read,
+	.fast_io = true,
+};
+
+static int lcdc_probe(struct platform_device *pdev)
+{
+	struct atmel_mfd_lcdc *lcdc;
+	struct lcdc_regmap *regmap;
+	struct resource *res;
+	struct device *dev;
+	int ret;
+
+	dev = &pdev->dev;
+
+	regmap = devm_kzalloc(dev, sizeof(*regmap), GFP_KERNEL);
+	if (!regmap)
+		return -ENOMEM;
+
+	lcdc = devm_kzalloc(dev, sizeof(*lcdc), GFP_KERNEL);
+	if (!lcdc)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	regmap->regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(regmap->regs)) {
+		dev_err(dev, "Failed to allocate IO mem (%ld)\n",
+			PTR_ERR(regmap->regs));
+		return PTR_ERR(regmap->regs);
+	}
+
+	lcdc->irq = platform_get_irq(pdev, 0);
+	if (lcdc->irq < 0) {
+		dev_err(dev, "Failed to get irq (%d)\n", lcdc->irq);
+		return lcdc->irq;
+	}
+
+	lcdc->lcdc_clk = devm_clk_get(dev, "lcdc_clk");
+	if (IS_ERR(lcdc->lcdc_clk)) {
+		dev_err(dev, "failed to get lcdc clock (%ld)\n",
+			PTR_ERR(lcdc->lcdc_clk));
+		return PTR_ERR(lcdc->lcdc_clk);
+	}
+
+	lcdc->bus_clk = devm_clk_get(dev, "hclk");
+	if (IS_ERR(lcdc->bus_clk)) {
+		dev_err(dev, "failed to get bus clock (%ld)\n",
+			PTR_ERR(lcdc->bus_clk));
+		return PTR_ERR(lcdc->bus_clk);
+	}
+
+	lcdc->regmap = devm_regmap_init(dev, NULL, regmap,
+					 &lcdc_regmap_config);
+	if (IS_ERR(lcdc->regmap)) {
+		dev_err(dev, "Failed to init regmap (%ld)\n",
+			PTR_ERR(lcdc->regmap));
+		return PTR_ERR(lcdc->regmap);
+	}
+
+	dev_set_drvdata(dev, lcdc);
+
+	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
+				   lcdc_cells, ARRAY_SIZE(lcdc_cells),
+				   NULL, 0, NULL);
+	if (ret < 0)
+		dev_err(dev, "Failed to add %d mfd devices (%d)\n",
+			ARRAY_SIZE(lcdc_cells), ret);
+
+	return ret;
+}
+
+static const struct of_device_id lcdc_match[] = {
+	{ .compatible = "atmel,at91sam9261-lcdc-mfd" },
+	{ .compatible = "atmel,at91sam9263-lcdc-mfd" },
+	{ .compatible = "atmel,at91sam9g10-lcdc-mfd" },
+	{ .compatible = "atmel,at91sam9g45-lcdc-mfd" },
+	{ .compatible = "atmel,at91sam9g46-lcdc-mfd" },
+	{ .compatible = "atmel,at91sam9m10-lcdc-mfd" },
+	{ .compatible = "atmel,at91sam9m11-lcdc-mfd" },
+	{ .compatible = "atmel,at91sam9rl-lcdc-mfd" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, lcdc_match);
+
+static struct platform_driver lcdc_driver = {
+	.probe = lcdc_probe,
+	.driver = {
+		.name = "atmel-lcdc",
+		.of_match_table = lcdc_match,
+	},
+};
+module_platform_driver(lcdc_driver);
+
+MODULE_ALIAS("platform:atmel-lcdc");
+MODULE_AUTHOR("Sam Ravnborg <sam@ravnborg.org>");
+MODULE_DESCRIPTION("Atmel LCDC mfd driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/atmel-lcdc.h b/include/linux/mfd/atmel-lcdc.h
new file mode 100644
index 000000000000..fdab269baa8e
--- /dev/null
+++ b/include/linux/mfd/atmel-lcdc.h
@@ -0,0 +1,184 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 Sam Ravnborg
+ *
+ * Author: Sam Ravnborg <sam@ravnborg.org>
+ */
+
+#ifndef __LINUX_MFD_LCDC_H
+#define __LINUX_MFD_LCDC_H
+
+#include <linux/regmap.h>
+#include <linux/clk.h>
+
+/**
+ * Structure shared by the Atmel LCD Controller device and its sub-devices.
+ *
+ * @regmap: register map used to access LCDC IP registers
+ * @lcdc_clk: the lcd controller peripheral clock
+ * @bus_clk: the bus clock clock (often the same as lcdc_clk)
+ * @irq: the lcdc irq
+ */
+struct atmel_mfd_lcdc {
+	struct regmap *regmap;
+	struct clk *lcdc_clk;
+	struct clk *bus_clk;
+	int irq;
+};
+
+#define ATMEL_LCDC_DMABADDR1	0x00
+#define ATMEL_LCDC_DMABADDR2	0x04
+#define ATMEL_LCDC_DMAFRMPT1	0x08
+#define ATMEL_LCDC_DMAFRMPT2	0x0c
+#define ATMEL_LCDC_DMAFRMADD1	0x10
+#define ATMEL_LCDC_DMAFRMADD2	0x14
+
+#define ATMEL_LCDC_DMAFRMCFG	0x18
+#define	ATMEL_LCDC_FRSIZE	(0x7fffff <<  0)
+#define	ATMEL_LCDC_BLENGTH_OFFSET	24
+#define	ATMEL_LCDC_BLENGTH	(0x7f     << ATMEL_LCDC_BLENGTH_OFFSET)
+
+#define ATMEL_LCDC_DMACON	0x1c
+#define	ATMEL_LCDC_DMAEN	(0x1 << 0)
+#define	ATMEL_LCDC_DMARST	(0x1 << 1)
+#define	ATMEL_LCDC_DMABUSY	(0x1 << 2)
+#define		ATMEL_LCDC_DMAUPDT	(0x1 << 3)
+#define		ATMEL_LCDC_DMA2DEN	(0x1 << 4)
+
+#define ATMEL_LCDC_DMA2DCFG	0x20
+#define		ATMEL_LCDC_ADDRINC_OFFSET	0
+#define		ATMEL_LCDC_ADDRINC		(0xffff)
+#define		ATMEL_LCDC_PIXELOFF_OFFSET	24
+#define		ATMEL_LCDC_PIXELOFF		(0x1f << 24)
+
+#define ATMEL_LCDC_LCDCON1	0x0800
+#define	ATMEL_LCDC_BYPASS	(1     <<  0)
+#define	ATMEL_LCDC_CLKVAL_OFFSET	12
+#define	ATMEL_LCDC_CLKVAL	(0x1ff << ATMEL_LCDC_CLKVAL_OFFSET)
+#define	ATMEL_LCDC_LINCNT	(0x7ff << 21)
+
+#define ATMEL_LCDC_LCDCON2	0x0804
+#define	ATMEL_LCDC_DISTYPE	(3 << 0)
+#define		ATMEL_LCDC_DISTYPE_STNMONO	(0 << 0)
+#define		ATMEL_LCDC_DISTYPE_STNCOLOR	(1 << 0)
+#define		ATMEL_LCDC_DISTYPE_TFT		(2 << 0)
+#define	ATMEL_LCDC_SCANMOD	(1 << 2)
+#define		ATMEL_LCDC_SCANMOD_SINGLE	(0 << 2)
+#define		ATMEL_LCDC_SCANMOD_DUAL		(1 << 2)
+#define	ATMEL_LCDC_IFWIDTH	(3 << 3)
+#define		ATMEL_LCDC_IFWIDTH_4		(0 << 3)
+#define		ATMEL_LCDC_IFWIDTH_8		(1 << 3)
+#define		ATMEL_LCDC_IFWIDTH_16		(2 << 3)
+#define	ATMEL_LCDC_PIXELSIZE	(7 << 5)
+#define		ATMEL_LCDC_PIXELSIZE_1		(0 << 5)
+#define		ATMEL_LCDC_PIXELSIZE_2		(1 << 5)
+#define		ATMEL_LCDC_PIXELSIZE_4		(2 << 5)
+#define		ATMEL_LCDC_PIXELSIZE_8		(3 << 5)
+#define		ATMEL_LCDC_PIXELSIZE_16		(4 << 5)
+#define		ATMEL_LCDC_PIXELSIZE_24		(5 << 5)
+#define		ATMEL_LCDC_PIXELSIZE_32		(6 << 5)
+#define	ATMEL_LCDC_INVVD	(1 << 8)
+#define		ATMEL_LCDC_INVVD_NORMAL		(0 << 8)
+#define		ATMEL_LCDC_INVVD_INVERTED	(1 << 8)
+#define	ATMEL_LCDC_INVFRAME	(1 << 9)
+#define		ATMEL_LCDC_INVFRAME_NORMAL	(0 << 9)
+#define		ATMEL_LCDC_INVFRAME_INVERTED	(1 << 9)
+#define	ATMEL_LCDC_INVLINE	(1 << 10)
+#define		ATMEL_LCDC_INVLINE_NORMAL	(0 << 10)
+#define		ATMEL_LCDC_INVLINE_INVERTED	(1 << 10)
+#define	ATMEL_LCDC_INVCLK	(1 << 11)
+#define		ATMEL_LCDC_INVCLK_NORMAL	(0 << 11)
+#define		ATMEL_LCDC_INVCLK_INVERTED	(1 << 11)
+#define	ATMEL_LCDC_INVDVAL	(1 << 12)
+#define		ATMEL_LCDC_INVDVAL_NORMAL	(0 << 12)
+#define		ATMEL_LCDC_INVDVAL_INVERTED	(1 << 12)
+#define	ATMEL_LCDC_CLKMOD	(1 << 15)
+#define		ATMEL_LCDC_CLKMOD_ACTIVEDISPLAY	(0 << 15)
+#define		ATMEL_LCDC_CLKMOD_ALWAYSACTIVE	(1 << 15)
+#define	ATMEL_LCDC_MEMOR	(1 << 31)
+#define		ATMEL_LCDC_MEMOR_BIG		(0 << 31)
+#define		ATMEL_LCDC_MEMOR_LITTLE		(1 << 31)
+
+#define ATMEL_LCDC_TIM1		0x0808
+#define	ATMEL_LCDC_VFP_OFFSET		0
+#define	ATMEL_LCDC_VFP		(0xffU <<  0)
+#define	ATMEL_LCDC_VBP_OFFSET		8
+#define	ATMEL_LCDC_VBP		(0xffU <<  ATMEL_LCDC_VBP_OFFSET)
+#define	ATMEL_LCDC_VPW_OFFSET		16
+#define	ATMEL_LCDC_VPW		(0x3fU << ATMEL_LCDC_VPW_OFFSET)
+#define	ATMEL_LCDC_VHDLY_OFFSET		24
+#define	ATMEL_LCDC_VHDLY	(0xfU  << ATMEL_LCDC_VHDLY_OFFSET)
+
+#define ATMEL_LCDC_TIM2		0x080c
+#define	ATMEL_LCDC_HBP_OFFSET		0
+#define	ATMEL_LCDC_HBP		(0xffU  <<  0)
+#define	ATMEL_LCDC_HPW_OFFSET		8
+#define	ATMEL_LCDC_HPW		(0x3fU  <<  ATMEL_LCDC_HPW_OFFSET)
+#define	ATMEL_LCDC_HFP_OFFSET		21
+#define	ATMEL_LCDC_HFP		(0x7ffU << ATMEL_LCDC_HFP_OFFSET)
+
+#define ATMEL_LCDC_LCDFRMCFG	0x0810
+#define	ATMEL_LCDC_LINEVAL	(0x7ff <<  0)
+#define	ATMEL_LCDC_HOZVAL_OFFSET	21
+#define	ATMEL_LCDC_HOZVAL	(0x7ff << ATMEL_LCDC_HOZVAL_OFFSET)
+
+#define ATMEL_LCDC_FIFO		0x0814
+#define	ATMEL_LCDC_FIFOTH	(0xffff)
+
+#define ATMEL_LCDC_MVAL		0x0818
+
+#define ATMEL_LCDC_DP1_2	0x081c
+#define ATMEL_LCDC_DP4_7	0x0820
+#define ATMEL_LCDC_DP3_5	0x0824
+#define ATMEL_LCDC_DP2_3	0x0828
+#define ATMEL_LCDC_DP5_7	0x082c
+#define ATMEL_LCDC_DP3_4	0x0830
+#define ATMEL_LCDC_DP4_5	0x0834
+#define ATMEL_LCDC_DP6_7	0x0838
+#define	ATMEL_LCDC_DP1_2_VAL	(0xff)
+#define	ATMEL_LCDC_DP4_7_VAL	(0xfffffff)
+#define	ATMEL_LCDC_DP3_5_VAL	(0xfffff)
+#define	ATMEL_LCDC_DP2_3_VAL	(0xfff)
+#define	ATMEL_LCDC_DP5_7_VAL	(0xfffffff)
+#define	ATMEL_LCDC_DP3_4_VAL	(0xffff)
+#define	ATMEL_LCDC_DP4_5_VAL	(0xfffff)
+#define	ATMEL_LCDC_DP6_7_VAL	(0xfffffff)
+
+#define ATMEL_LCDC_PWRCON	0x083c
+#define	ATMEL_LCDC_PWR		(1    <<  0)
+#define	ATMEL_LCDC_GUARDT_OFFSET	1
+#define	ATMEL_LCDC_GUARDT	(0x7f <<  ATMEL_LCDC_GUARDT_OFFSET)
+#define	ATMEL_LCDC_BUSY		(1    << 31)
+
+#define ATMEL_LCDC_CONTRAST_CTR	0x0840
+#define	ATMEL_LCDC_PS		(3 << 0)
+#define		ATMEL_LCDC_PS_DIV1		(0 << 0)
+#define		ATMEL_LCDC_PS_DIV2		(1 << 0)
+#define		ATMEL_LCDC_PS_DIV4		(2 << 0)
+#define		ATMEL_LCDC_PS_DIV8		(3 << 0)
+#define	ATMEL_LCDC_POL		(1 << 2)
+#define		ATMEL_LCDC_POL_NEGATIVE		(0 << 2)
+#define		ATMEL_LCDC_POL_POSITIVE		(1 << 2)
+#define	ATMEL_LCDC_ENA		(1 << 3)
+#define		ATMEL_LCDC_ENA_PWMDISABLE	(0 << 3)
+#define		ATMEL_LCDC_ENA_PWMENABLE	(1 << 3)
+
+#define ATMEL_LCDC_CONTRAST_VAL	0x0844
+#define	ATMEL_LCDC_CVAL	(0xff)
+
+#define ATMEL_LCDC_IER		0x0848
+#define ATMEL_LCDC_IDR		0x084c
+#define ATMEL_LCDC_IMR		0x0850
+#define ATMEL_LCDC_ISR		0x0854
+#define ATMEL_LCDC_ICR		0x0858
+#define	ATMEL_LCDC_LNI		(1 << 0)
+#define	ATMEL_LCDC_LSTLNI	(1 << 1)
+#define	ATMEL_LCDC_EOFI		(1 << 2)
+#define	ATMEL_LCDC_UFLWI	(1 << 4)
+#define	ATMEL_LCDC_OWRI		(1 << 5)
+#define	ATMEL_LCDC_MERI		(1 << 6)
+
+#define ATMEL_LCDC_LUT(n)	(0x0c00 + ((n)*4))
+#define ATMEL_LCDC_LUT_SIZE	256
+
+#endif /* __LINUX_MFD_LCDC_H */
-- 
2.12.0
