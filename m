From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v10 16/18] counter: add FlexTimer Module Quadrature decoder counter driver
Date: Tue,  2 Apr 2019 15:30:51 +0900
Message-ID: <9add1082c3c63012a13a5f9af5c6454afed26918.1554184734.git.vilhelm.gray@gmail.com>
References: <cover.1554184734.git.vilhelm.gray@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1554184734.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jic23@kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, fabrice.gasnier@st.com, benjamin.gaignard@st.com, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, akpm@linux-foundation.org, david@lechnology.com, robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org, leoyang.li@nxp.com, daniel.lezcano@linaro.org, tglx@linutronix.de, thierry.reding@gmail.com, esben@haabendal.dk, linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, patrick.havelange@essensium.com, William Breathitt Gray <vilhelm.gray@gmail.com>
List-Id: linux-pwm@vger.kernel.org

From: Patrick Havelange <patrick.havelange@essensium.com>

This driver exposes the counter for the quadrature decoder of the
FlexTimer Module, present in the LS1021A soc.

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/Kconfig       |   9 +
 drivers/counter/Makefile      |   1 +
 drivers/counter/ftm-quaddec.c | 356 ++++++++++++++++++++++++++++++++++
 3 files changed, 366 insertions(+)
 create mode 100644 drivers/counter/ftm-quaddec.c

diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index 87c491a19c63..233ac305d878 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -48,4 +48,13 @@ config STM32_LPTIMER_CNT
 	  To compile this driver as a module, choose M here: the
 	  module will be called stm32-lptimer-cnt.
 
+config FTM_QUADDEC
+	tristate "Flex Timer Module Quadrature decoder driver"
+	help
+	  Select this option to enable the Flex Timer Quadrature decoder
+	  driver.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ftm-quaddec.
+
 endif # COUNTER
diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
index 5589976d37f8..0c9e622a6bea 100644
--- a/drivers/counter/Makefile
+++ b/drivers/counter/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_COUNTER) += counter.o
 obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
 obj-$(CONFIG_STM32_TIMER_CNT)	+= stm32-timer-cnt.o
 obj-$(CONFIG_STM32_LPTIMER_CNT)	+= stm32-lptimer-cnt.o
+obj-$(CONFIG_FTM_QUADDEC)	+= ftm-quaddec.o
diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
new file mode 100644
index 000000000000..c83c8875bf82
--- /dev/null
+++ b/drivers/counter/ftm-quaddec.c
@@ -0,0 +1,356 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Flex Timer Module Quadrature decoder
+ *
+ * This module implements a driver for decoding the FTM quadrature
+ * of ex. a LS1021A
+ */
+
+#include <linux/fsl/ftm.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/io.h>
+#include <linux/mutex.h>
+#include <linux/counter.h>
+#include <linux/bitfield.h>
+
+#define FTM_FIELD_UPDATE(ftm, offset, mask, val)			\
+	({								\
+		uint32_t flags;						\
+		ftm_read(ftm, offset, &flags);				\
+		flags &= ~mask;						\
+		flags |= FIELD_PREP(mask, val);				\
+		ftm_write(ftm, offset, flags);				\
+	})
+
+struct ftm_quaddec {
+	struct counter_device counter;
+	struct platform_device *pdev;
+	void __iomem *ftm_base;
+	bool big_endian;
+	struct mutex ftm_quaddec_mutex;
+};
+
+static void ftm_read(struct ftm_quaddec *ftm, uint32_t offset, uint32_t *data)
+{
+	if (ftm->big_endian)
+		*data = ioread32be(ftm->ftm_base + offset);
+	else
+		*data = ioread32(ftm->ftm_base + offset);
+}
+
+static void ftm_write(struct ftm_quaddec *ftm, uint32_t offset, uint32_t data)
+{
+	if (ftm->big_endian)
+		iowrite32be(data, ftm->ftm_base + offset);
+	else
+		iowrite32(data, ftm->ftm_base + offset);
+}
+
+/* Hold mutex before modifying write protection state */
+static void ftm_clear_write_protection(struct ftm_quaddec *ftm)
+{
+	uint32_t flag;
+
+	/* First see if it is enabled */
+	ftm_read(ftm, FTM_FMS, &flag);
+
+	if (flag & FTM_FMS_WPEN)
+		FTM_FIELD_UPDATE(ftm, FTM_MODE, FTM_MODE_WPDIS, 1);
+}
+
+static void ftm_set_write_protection(struct ftm_quaddec *ftm)
+{
+	FTM_FIELD_UPDATE(ftm, FTM_FMS, FTM_FMS_WPEN, 1);
+}
+
+static void ftm_reset_counter(struct ftm_quaddec *ftm)
+{
+	/* Reset hardware counter to CNTIN */
+	ftm_write(ftm, FTM_CNT, 0x0);
+}
+
+static void ftm_quaddec_init(struct ftm_quaddec *ftm)
+{
+	ftm_clear_write_protection(ftm);
+
+	/*
+	 * Do not write in the region from the CNTIN register through the
+	 * PWMLOAD register when FTMEN = 0.
+	 * Also reset other fields to zero
+	 */
+	ftm_write(ftm, FTM_MODE, FTM_MODE_FTMEN);
+	ftm_write(ftm, FTM_CNTIN, 0x0000);
+	ftm_write(ftm, FTM_MOD, 0xffff);
+	ftm_write(ftm, FTM_CNT, 0x0);
+	/* Set prescaler, reset other fields to zero */
+	ftm_write(ftm, FTM_SC, FTM_SC_PS_1);
+
+	/* Select quad mode, reset other fields to zero */
+	ftm_write(ftm, FTM_QDCTRL, FTM_QDCTRL_QUADEN);
+
+	/* Unused features and reset to default section */
+	ftm_write(ftm, FTM_POL, 0x0);
+	ftm_write(ftm, FTM_FLTCTRL, 0x0);
+	ftm_write(ftm, FTM_SYNCONF, 0x0);
+	ftm_write(ftm, FTM_SYNC, 0xffff);
+
+	/* Lock the FTM */
+	ftm_set_write_protection(ftm);
+}
+
+static void ftm_quaddec_disable(struct ftm_quaddec *ftm)
+{
+	ftm_clear_write_protection(ftm);
+	ftm_write(ftm, FTM_MODE, 0);
+	ftm_write(ftm, FTM_QDCTRL, 0);
+	/*
+	 * This is enough to disable the counter. No clock has been
+	 * selected by writing to FTM_SC in init()
+	 */
+	ftm_set_write_protection(ftm);
+}
+
+static int ftm_quaddec_get_prescaler(struct counter_device *counter,
+				     struct counter_count *count,
+				     size_t *cnt_mode)
+{
+	struct ftm_quaddec *ftm = counter->priv;
+	uint32_t scflags;
+
+	ftm_read(ftm, FTM_SC, &scflags);
+
+	*cnt_mode = FIELD_GET(FTM_SC_PS_MASK, scflags);
+
+	return 0;
+}
+
+static int ftm_quaddec_set_prescaler(struct counter_device *counter,
+				     struct counter_count *count,
+				     size_t cnt_mode)
+{
+	struct ftm_quaddec *ftm = counter->priv;
+
+	mutex_lock(&ftm->ftm_quaddec_mutex);
+
+	ftm_clear_write_protection(ftm);
+	FTM_FIELD_UPDATE(ftm, FTM_SC, FTM_SC_PS_MASK, cnt_mode);
+	ftm_set_write_protection(ftm);
+
+	/* Also resets the counter as it is undefined anyway now */
+	ftm_reset_counter(ftm);
+
+	mutex_unlock(&ftm->ftm_quaddec_mutex);
+	return 0;
+}
+
+static const char * const ftm_quaddec_prescaler[] = {
+	"1", "2", "4", "8", "16", "32", "64", "128"
+};
+
+static struct counter_count_enum_ext ftm_quaddec_prescaler_enum = {
+	.items = ftm_quaddec_prescaler,
+	.num_items = ARRAY_SIZE(ftm_quaddec_prescaler),
+	.get = ftm_quaddec_get_prescaler,
+	.set = ftm_quaddec_set_prescaler
+};
+
+enum ftm_quaddec_synapse_action {
+	FTM_QUADDEC_SYNAPSE_ACTION_BOTH_EDGES,
+};
+
+static enum counter_synapse_action ftm_quaddec_synapse_actions[] = {
+	[FTM_QUADDEC_SYNAPSE_ACTION_BOTH_EDGES] =
+	COUNTER_SYNAPSE_ACTION_BOTH_EDGES
+};
+
+enum ftm_quaddec_count_function {
+	FTM_QUADDEC_COUNT_ENCODER_MODE_1,
+};
+
+static const enum counter_count_function ftm_quaddec_count_functions[] = {
+	[FTM_QUADDEC_COUNT_ENCODER_MODE_1] =
+	COUNTER_COUNT_FUNCTION_QUADRATURE_X4
+};
+
+static int ftm_quaddec_count_read(struct counter_device *counter,
+				  struct counter_count *count,
+				  struct counter_count_read_value *val)
+{
+	struct ftm_quaddec *const ftm = counter->priv;
+	uint32_t cntval;
+
+	ftm_read(ftm, FTM_CNT, &cntval);
+
+	counter_count_read_value_set(val, COUNTER_COUNT_POSITION, &cntval);
+
+	return 0;
+}
+
+static int ftm_quaddec_count_write(struct counter_device *counter,
+				   struct counter_count *count,
+				   struct counter_count_write_value *val)
+{
+	struct ftm_quaddec *const ftm = counter->priv;
+	u32 cnt;
+	int err;
+
+	err = counter_count_write_value_get(&cnt, COUNTER_COUNT_POSITION, val);
+	if (err)
+		return err;
+
+	if (cnt != 0) {
+		dev_warn(&ftm->pdev->dev, "Can only accept '0' as new counter value\n");
+		return -EINVAL;
+	}
+
+	ftm_reset_counter(ftm);
+
+	return 0;
+}
+
+static int ftm_quaddec_count_function_get(struct counter_device *counter,
+					  struct counter_count *count,
+					  size_t *function)
+{
+	*function = FTM_QUADDEC_COUNT_ENCODER_MODE_1;
+
+	return 0;
+}
+
+static int ftm_quaddec_action_get(struct counter_device *counter,
+				  struct counter_count *count,
+				  struct counter_synapse *synapse,
+				  size_t *action)
+{
+	*action = FTM_QUADDEC_SYNAPSE_ACTION_BOTH_EDGES;
+
+	return 0;
+}
+
+static const struct counter_ops ftm_quaddec_cnt_ops = {
+	.count_read = ftm_quaddec_count_read,
+	.count_write = ftm_quaddec_count_write,
+	.function_get = ftm_quaddec_count_function_get,
+	.action_get = ftm_quaddec_action_get,
+};
+
+static struct counter_signal ftm_quaddec_signals[] = {
+	{
+		.id = 0,
+		.name = "Channel 1 Phase A"
+	},
+	{
+		.id = 1,
+		.name = "Channel 1 Phase B"
+	}
+};
+
+static struct counter_synapse ftm_quaddec_count_synapses[] = {
+	{
+		.actions_list = ftm_quaddec_synapse_actions,
+		.num_actions = ARRAY_SIZE(ftm_quaddec_synapse_actions),
+		.signal = &ftm_quaddec_signals[0]
+	},
+	{
+		.actions_list = ftm_quaddec_synapse_actions,
+		.num_actions = ARRAY_SIZE(ftm_quaddec_synapse_actions),
+		.signal = &ftm_quaddec_signals[1]
+	}
+};
+
+static const struct counter_count_ext ftm_quaddec_count_ext[] = {
+	COUNTER_COUNT_ENUM("prescaler", &ftm_quaddec_prescaler_enum),
+	COUNTER_COUNT_ENUM_AVAILABLE("prescaler", &ftm_quaddec_prescaler_enum),
+};
+
+static struct counter_count ftm_quaddec_counts = {
+	.id = 0,
+	.name = "Channel 1 Count",
+	.functions_list = ftm_quaddec_count_functions,
+	.num_functions = ARRAY_SIZE(ftm_quaddec_count_functions),
+	.synapses = ftm_quaddec_count_synapses,
+	.num_synapses = ARRAY_SIZE(ftm_quaddec_count_synapses),
+	.ext = ftm_quaddec_count_ext,
+	.num_ext = ARRAY_SIZE(ftm_quaddec_count_ext)
+};
+
+static int ftm_quaddec_probe(struct platform_device *pdev)
+{
+	struct ftm_quaddec *ftm;
+
+	struct device_node *node = pdev->dev.of_node;
+	struct resource *io;
+	int ret;
+
+	ftm = devm_kzalloc(&pdev->dev, sizeof(*ftm), GFP_KERNEL);
+	if (!ftm)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, ftm);
+
+	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!io) {
+		dev_err(&pdev->dev, "Failed to get memory region\n");
+		return -ENODEV;
+	}
+
+	ftm->pdev = pdev;
+	ftm->big_endian = of_property_read_bool(node, "big-endian");
+	ftm->ftm_base = devm_ioremap(&pdev->dev, io->start, resource_size(io));
+
+	if (!ftm->ftm_base) {
+		dev_err(&pdev->dev, "Failed to map memory region\n");
+		return -EINVAL;
+	}
+	ftm->counter.name = dev_name(&pdev->dev);
+	ftm->counter.parent = &pdev->dev;
+	ftm->counter.ops = &ftm_quaddec_cnt_ops;
+	ftm->counter.counts = &ftm_quaddec_counts;
+	ftm->counter.num_counts = 1;
+	ftm->counter.signals = ftm_quaddec_signals;
+	ftm->counter.num_signals = ARRAY_SIZE(ftm_quaddec_signals);
+	ftm->counter.priv = ftm;
+
+	mutex_init(&ftm->ftm_quaddec_mutex);
+
+	ftm_quaddec_init(ftm);
+
+	ret = counter_register(&ftm->counter);
+	if (ret)
+		ftm_quaddec_disable(ftm);
+
+	return ret;
+}
+
+static int ftm_quaddec_remove(struct platform_device *pdev)
+{
+	struct ftm_quaddec *ftm = platform_get_drvdata(pdev);
+
+	counter_unregister(&ftm->counter);
+
+	ftm_quaddec_disable(ftm);
+
+	return 0;
+}
+
+static const struct of_device_id ftm_quaddec_match[] = {
+	{ .compatible = "fsl,ftm-quaddec" },
+	{},
+};
+
+static struct platform_driver ftm_quaddec_driver = {
+	.driver = {
+		.name = "ftm-quaddec",
+		.of_match_table = ftm_quaddec_match,
+	},
+	.probe = ftm_quaddec_probe,
+	.remove = ftm_quaddec_remove,
+};
+
+module_platform_driver(ftm_quaddec_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Kjeld Flarup <kfa@deif.com");
+MODULE_AUTHOR("Patrick Havelange <patrick.havelange@essensium.com");
-- 
2.21.0
