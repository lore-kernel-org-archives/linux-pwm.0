Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013068.outbound.protection.outlook.com [40.93.196.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA794766B3;
	Wed,  7 Oct 2026 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791364231; cv=fail; b=qHDZ7hdK97qlNcPBGK9WT1/5aHRbDzbaInRg0+M9CcdMu1cTcnVbJXZ7pVcTP8jtb9F3mkuw6XWLL97o68ILcZu5PFuPt401P0FaRTv+cyx5cuoRW3DrHF8WelLD7noKASj1kPijR2TVy33rG8c0MJ/AnShrXwBw99U3/tSY9RY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791364231; c=relaxed/simple;
	bh=rToWPD5wwETIobBg0yof37gHpuAtOC+KPohxLMhFP0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=R3ISaOkRaFTuXPn92mp9OvN0+iIrqU9yV+Y+OIGaDMDISMZSVlDdNVpLK3ZDC5qOc+4HTc2JBN/SC9iGcPYX1FU19z/u40P/uSuCUpB9ZzuDkmxFAgOv9BO13XfPHuPSbP979a1Gm8LSiWPnVscDVc9NQI/Wbj+AWAIqXIxU5eQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V6tX+OYY; arc=fail smtp.client-ip=40.93.196.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V6tX+OYY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KK1d3r624jzx5GZ6OudRawKCUu0wa5yLDBnJswJf7a7oQOQFXAxntgMIzIZgkDr1iPpx+vHjd76cLp3bFxDCfh9UL1fhjRxVZlbTIwYlb+Vc66W+HMgLxlI85h9qDbZRqpzXE8CXflCJqTZrXW3HkhLSDiNRdP+LNtQMJHKN9Kg+erLFiBjXdLQ5APpSbi3xXYcObfLA/255suqEzB4b2RWNvHStV33sP79X4WGOp9BNHAj4bvn9SGt4ex9h78PFfZ4suCNAg8+vWCHqUqaYByRxz3eIExgqpIGYKAXNC3xzKfnxteAgGDXwDGfeOEKeyrKRG/nw80fedWFCwQBLFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+w2phfdtLcCJLHaAE+n2Zq3g9XTdzkYs9l7f80JIWI=;
 b=w68hDazkJ/smFRWj1Mkk1EDeTnbo0asjdCwDc7elbbq6pr6EvR80v5g5+hvwC/FwTVkifUvxPNzSZKys7emZXM2vvWqxHbGeIf79M4IX04fHIUJVo771TDHw+92HdFw2JsKM6WRxnvLLL49anMZu0bn99tTvErikqGhzRFBu1wZQZfk9JQTBW2YlM1YCiPrbacohxtauC+564vFHPSMq/OTEjPMMUaHNn55Wzm98S0rgFlSy39PTQODJnd8m2IJKyrw3G9ZAnOoig7yFOsdCAbNPk7GTNpL+hDRCtZ/w6DrbVNaOeldOGWuuzcBY6ij2CXT4kbeqWUXFcDMZ86H8rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+w2phfdtLcCJLHaAE+n2Zq3g9XTdzkYs9l7f80JIWI=;
 b=V6tX+OYYESNYLLtcVikooCB/tirJWevv9WPcgTlAwNZKjcZ+k7s8ubyA8elN0HL/qG7zFollIi2mb6EMvSEB7N1X6DNDWQMyOTVe8TzFNUdk1ir1B+wSUtSL3i17F7XZuM1/5ZPZMAd/QzAlvwdOlrgBwV2PuVoXLL6hRj4kBBA=
Received: from MN2PR18CA0014.namprd18.prod.outlook.com (2603:10b6:208:23c::19)
 by CY3PR12MB9629.namprd12.prod.outlook.com (2603:10b6:930:101::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 09:07:42 +0000
Received: from MN1PEPF000793FB.namprd05.prod.outlook.com
 (2603:10b6:208:23c:cafe::8b) by MN2PR18CA0014.outlook.office365.com
 (2603:10b6:208:23c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 09:07:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF000793FB.mail.protection.outlook.com (10.167.249.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 09:07:41 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 04:07:37 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 04:07:36 -0500
Received: from xhdtunimkar40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 7 Oct 2026 04:07:34 -0500
From: Meher Thanmaiee <meherthanmaiee.vanukuri@amd.com>
Date: Wed, 7 Oct 2026 14:37:02 +0530
Subject: [PATCH 4/5] pwm: cadence: Add TTC PWM driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261007-cadence-ttc-pwm-v1-4-52a95a8d98b1@amd.com>
References: <20261007-cadence-ttc-pwm-v1-0-52a95a8d98b1@amd.com>
In-Reply-To: <20261007-cadence-ttc-pwm-v1-0-52a95a8d98b1@amd.com>
To: <michal.simek@amd.com>, <tglx@kernel.org>, <ukleinek@kernel.org>,
	<daniel.lezcano@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, <meherthanmaiee.vanukuri@amd.com>, <linux-pwm@vger.kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791364043; l=12289;
 i=meherthanmaiee.vanukuri@amd.com; s=20261007; h=from:subject:message-id;
 bh=rToWPD5wwETIobBg0yof37gHpuAtOC+KPohxLMhFP0o=;
 b=F+Wqdx0tfZ7pa4vtkTRzp9RVzaR41Dk1W6zY0+kq0OP6f3uaA9he3hFNcIpenDI4T4ENfNfCb
 dkGq1UoyRsaChClfNq0bifWnJ4ru+FwcHeloy/+WWbqyNAhk6btm5hM
X-Developer-Key: i=meherthanmaiee.vanukuri@amd.com; a=ed25519;
 pk=m/+ON8/+ewj5VLb55p7J9gAopkLKj2mp7iobBZdhi0Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF000793FB:EE_|CY3PR12MB9629:EE_
X-MS-Office365-Filtering-Correlation-Id: 3831c74c-251b-401c-36a5-08df24527154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|22082099003|18002099003|11063799006|3023799007|6133799003|10067099003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	Y5cyumZgv7cxfcZ+z/aE+jQa07Rk0jEDmVn/wyLpqAq2EkdS45lLtLosjelXW2ZqETzXfs4Ccmnx7oYFB/LkN9okCDN5czrhjGOkSHYyFnrElCQ4zx/hy+awhNj2LYNYFG8+Yq3HzwDRFPp6depwJgjrT+21T24Imavy3M51PcRR0Prp6zlJdbVlliL1XIuYZ/5w8oBTv0hCipjDEpqzQAdIwHf+PNPsMSp76EEEvahSUzsmZmG4dcXwOfZz/5kRrUJIkQ8O+5vgbiFvYSnDcnXbY/CX+N8ooEYM9A2vxmoZ4e791YQSq98yO5n0rZm49V0jOn3bXZ/xeB0TD6ubOrC1ffjelj56za+hkkzPovku8a/yYrtMIJs8f/Ti1LLKNdQu9MyytU6pFfvjyFPtBLNptddFhppkFhFnQ0H2LcCK8dER739JbF9EPOi2Hj+7LwwTaTR/Xq9qxqyE9pe+6Zwg605TkY/WyYGKt8cv4sHToDnS4J//kPNrW8Ddpxft825/Jm6vCIDx1Z+8g23a4SSSZq7Mmyw5O2ZygbKYRaaD8AJxWvfh9qFNsP7xZnyPpLqqTKcCFwlM9yKI2A2Be4x8Dicilun6y+9XQ8/lz3LppeOtNZY05aWwUBiebx+WPTd769AThreYZESVkj4N2bI2EzQamY3ViOmdkj/Wjc/0ruKmhRCYGZ8FNu3LBCmp/7SUiiTmO7Vuh3PepILXeA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(22082099003)(18002099003)(11063799006)(3023799007)(6133799003)(10067099003)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XXLApFMV8zh8G8OAdyWfu/JtEXBk4LQbzQE0gu9OUNkswDV6uS9wRsU50H/drG3vpzLOG9phfxqS1SUNFM7CeaNyx5O9JYOnFHObTWBBFZ86jrzVHpd8l5ZPknggIJESx7j9EboQlYSApgLF7FzP4KjfVXqC+uSCjkfCTqzXy+0PK2J1Ls4+nYpV2pOcMb8vlqfq7QG5tTyJawJbQkQRhwHd2dp+VIi/CMBLAEwmHv7BIWZ59apHjANx2wdFEQcKo1JX1om1Z0Y9uvc5JjU/HxvmFdrdVIujrfYWvBTEzlgkKBNTaeB1BXDp9Ie8FZBhvRG2HeQhz4nddWU2bVtd6w7ts0P0RrKNC8P54Dhi4Hcn+Dga4JEuM8b8ekCp7MSmRJUz88f9BQo6D0EvZgBtEYYK8aZrdJOCoBuhosRAO6ePDl7xE63vTF1cysrLr2IM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 09:07:41.6731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3831c74c-251b-401c-36a5-08df24527154
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF000793FB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9629

Add a PWM driver for the Cadence Triple Timer Counter (TTC) IP found
on Xilinx Zynq, ZynqMP, and Versal SoCs.

The driver binds to auxiliary-bus devices created by the TTC timer
driver when #pwm-cells is present in the device tree, and exposes the
three TTC channels as PWM outputs. The PWM period is programmed
through the interval counter and the duty cycle through the match
counter.

Add the PWM-specific TTC register definitions, shared data structure,
and per-channel access helpers to the shared TTC header so the driver
can access the parent-provided MMIO base, clock, rate, and timer width.

Co-developed-by: Mubin Sayyed <mubin.sayyed@amd.com>
Signed-off-by: Mubin Sayyed <mubin.sayyed@amd.com>
Signed-off-by: Meher Thanmaiee <meherthanmaiee.vanukuri@amd.com>
---
 MAINTAINERS                       |   1 +
 drivers/pwm/Kconfig               |  13 +++
 drivers/pwm/Makefile              |   1 +
 drivers/pwm/pwm-cadence.c         | 231 ++++++++++++++++++++++++++++++++++++++
 include/linux/timer-cadence-ttc.h |  40 +++++++
 5 files changed, 286 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b25ad0c18ffd..071290662523 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3922,6 +3922,7 @@ F:	drivers/edac/synopsys_edac.c
 F:	drivers/i2c/busses/i2c-cadence.c
 F:	drivers/i2c/busses/i2c-xiic.c
 F:	drivers/mmc/host/sdhci-of-arasan.c
+F:	drivers/pwm/pwm-cadence.c
 F:	include/linux/timer-cadence-ttc.h
 N:	zynq
 N:	xilinx
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 729776086879..a267a15a9685 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -196,6 +196,19 @@ config PWM_BRCMSTB
 	  To compile this driver as a module, choose M Here: the module
 	  will be called pwm-brcmstb.c.
 
+config PWM_CADENCE
+	tristate "Cadence TTC PWM support"
+	depends on CADENCE_TTC_TIMER
+	help
+	  PWM framework driver for the Cadence TTC IP found on Xilinx
+	  Zynq/ZynqMP/Versal SoCs. Binds to auxiliary-bus devices
+	  created by the TTC clocksource driver when a TTC node
+	  contains the #pwm-cells property. Each TTC provides up to
+	  3 PWM channels.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called pwm-cadence.
+
 config PWM_CLK
 	tristate "Clock based PWM support"
 	depends on HAVE_CLK || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 5630a521a7cf..f116b9629eee 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_PWM_BCM_IPROC)	+= pwm-bcm-iproc.o
 obj-$(CONFIG_PWM_BCM_KONA)	+= pwm-bcm-kona.o
 obj-$(CONFIG_PWM_BERLIN)	+= pwm-berlin.o
 obj-$(CONFIG_PWM_BRCMSTB)	+= pwm-brcmstb.o
+obj-$(CONFIG_PWM_CADENCE)	+= pwm-cadence.o
 obj-$(CONFIG_PWM_CLK)		+= pwm-clk.o
 obj-$(CONFIG_PWM_CLPS711X)	+= pwm-clps711x.o
 obj-$(CONFIG_PWM_CRC)		+= pwm-crc.o
diff --git a/drivers/pwm/pwm-cadence.c b/drivers/pwm/pwm-cadence.c
new file mode 100644
index 000000000000..f02f37ccb741
--- /dev/null
+++ b/drivers/pwm/pwm-cadence.c
@@ -0,0 +1,231 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Cadence TTC PWM driver
+ *
+ * Configures Cadence Triple Timer Counter channels as PWM outputs.
+ * Binds to auxiliary-bus devices created by the TTC clocksource driver.
+ *
+ * Limitations:
+ * - When PWM is stopped, timer counter gets stopped immediately. This
+ *   doesn't allow the current PWM period to complete and stops abruptly.
+ * - Disabled PWM emits inactive level.
+ * - When user requests a change in any parameter of PWM (period/duty cycle/polarity)
+ *   while PWM is in enabled state:
+ *	- PWM is stopped abruptly.
+ *	- Requested parameter is changed.
+ *	- Fresh PWM cycle is started.
+ *
+ * Copyright (C) 2026, Advanced Micro Devices, Inc.
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/log2.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/pwm.h>
+#include <linux/timer-cadence-ttc.h>
+
+struct cdns_ttc_pwm {
+	const struct ttc_shared_data	*sd;
+	u32				max_count;
+};
+
+static inline struct cdns_ttc_pwm *to_cdns_ttc_pwm(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
+
+static void cdns_ttc_pwm_enable(struct cdns_ttc_pwm *priv, unsigned int hwpwm)
+{
+	u32 ctrl;
+
+	ctrl = ttc_ch_readl(priv->sd, hwpwm, TTC_CNT_CNTRL_OFFSET);
+	ctrl |= TTC_CNT_CNTRL_INT | TTC_CNT_CNTRL_MATCH | TTC_CNT_CNTRL_RST;
+	ctrl &= ~(TTC_CNT_CNTRL_DISABLE_MASK | TTC_CNT_CNTRL_WAVE_EN);
+	ttc_ch_writel(priv->sd, hwpwm, TTC_CNT_CNTRL_OFFSET, ctrl);
+}
+
+static void cdns_ttc_pwm_disable(struct cdns_ttc_pwm *priv, unsigned int hwpwm)
+{
+	u32 ctrl;
+
+	ctrl = ttc_ch_readl(priv->sd, hwpwm, TTC_CNT_CNTRL_OFFSET);
+	ctrl |= TTC_CNT_CNTRL_DISABLE_MASK;
+	ttc_ch_writel(priv->sd, hwpwm, TTC_CNT_CNTRL_OFFSET, ctrl);
+}
+
+static int cdns_ttc_pwm_apply(struct pwm_chip *chip,
+			      struct pwm_device *pwm,
+			      const struct pwm_state *state)
+{
+	struct cdns_ttc_pwm *priv = to_cdns_ttc_pwm(chip);
+	unsigned long rate = priv->sd->rate;
+	unsigned int hwpwm = pwm->hwpwm;
+	u64 period_cycles, duty_cycles;
+	bool use_prescaler = false;
+	u32 ctrl, psv;
+
+	if (!state->enabled) {
+		cdns_ttc_pwm_disable(priv, hwpwm);
+		return 0;
+	}
+
+	period_cycles = mul_u64_u64_div_u64(state->period, rate, NSEC_PER_SEC);
+
+	if (period_cycles > priv->max_count) {
+		unsigned int shift;
+
+		/*
+		 * Prescaler divides input clock by 2^(psv+1).
+		 * Calculate required shift and derive PSV register value.
+		 */
+		shift = order_base_2(DIV_ROUND_UP_ULL(period_cycles,
+						      priv->max_count));
+		if (shift > TTC_CLK_CNTRL_PSV_MAX + 1)
+			return -ERANGE;
+
+		use_prescaler = true;
+		psv = shift - 1;
+
+		period_cycles = mul_u64_u64_div_u64(state->period, rate,
+						    (u64)NSEC_PER_SEC << shift);
+	}
+
+	if (!period_cycles)
+		return -EINVAL;
+
+	cdns_ttc_pwm_disable(priv, hwpwm);
+
+	ctrl = ttc_ch_readl(priv->sd, hwpwm, TTC_CNT_CNTRL_OFFSET);
+	if (state->polarity == PWM_POLARITY_NORMAL)
+		ctrl |= TTC_CNT_CNTRL_WAVE_POL;
+	else
+		ctrl &= ~TTC_CNT_CNTRL_WAVE_POL;
+	ttc_ch_writel(priv->sd, hwpwm, TTC_CNT_CNTRL_OFFSET, ctrl);
+
+	if (use_prescaler) {
+		duty_cycles = mul_u64_u64_div_u64(state->duty_cycle, rate,
+						  (u64)NSEC_PER_SEC << (psv + 1));
+	} else {
+		duty_cycles = mul_u64_u64_div_u64(state->duty_cycle, rate,
+						  NSEC_PER_SEC);
+	}
+
+	ttc_ch_writel(priv->sd, hwpwm, TTC_INTR_VAL_OFFSET, (u32)period_cycles);
+	ttc_ch_writel(priv->sd, hwpwm, TTC_MATCH_CNT_VAL_OFFSET, (u32)duty_cycles);
+
+	ctrl = ttc_ch_readl(priv->sd, hwpwm, TTC_CLK_CNTRL_OFFSET);
+	if (use_prescaler) {
+		ctrl &= ~TTC_CLK_CNTRL_PSV_MASK;
+		ctrl |= FIELD_PREP(TTC_CLK_CNTRL_PSV_MASK, psv);
+		ctrl |= TTC_CLK_CNTRL_PS_EN;
+	} else {
+		ctrl &= ~TTC_CLK_CNTRL_PS_EN;
+	}
+	ttc_ch_writel(priv->sd, hwpwm, TTC_CLK_CNTRL_OFFSET, ctrl);
+
+	cdns_ttc_pwm_enable(priv, hwpwm);
+
+	return 0;
+}
+
+static int cdns_ttc_pwm_get_state(struct pwm_chip *chip,
+				  struct pwm_device *pwm,
+				  struct pwm_state *state)
+{
+	struct cdns_ttc_pwm *priv = to_cdns_ttc_pwm(chip);
+	unsigned long rate = priv->sd->rate;
+	unsigned int hwpwm = pwm->hwpwm;
+	u32 ctrl, clk_ctrl, pres;
+	u64 tmp;
+
+	ctrl = ttc_ch_readl(priv->sd, hwpwm, TTC_CNT_CNTRL_OFFSET);
+
+	state->polarity = (ctrl & TTC_CNT_CNTRL_WAVE_POL) ?
+			  PWM_POLARITY_NORMAL : PWM_POLARITY_INVERSED;
+
+	if (ctrl & TTC_CNT_CNTRL_DISABLE_MASK) {
+		state->enabled = false;
+		state->period = 0;
+		state->duty_cycle = 0;
+		return 0;
+	}
+
+	state->enabled = true;
+
+	clk_ctrl = ttc_ch_readl(priv->sd, hwpwm, TTC_CLK_CNTRL_OFFSET);
+	pres = 0;
+	if (clk_ctrl & TTC_CLK_CNTRL_PS_EN)
+		pres = FIELD_GET(TTC_CLK_CNTRL_PSV_MASK, clk_ctrl) + 1;
+
+	tmp = (u64)ttc_ch_readl(priv->sd, hwpwm, TTC_INTR_VAL_OFFSET) << pres;
+	state->period = mul_u64_u64_div_u64(tmp, NSEC_PER_SEC, rate);
+	if (mul_u64_u64_div_u64(state->period, rate, NSEC_PER_SEC) < tmp)
+		state->period++;
+
+	tmp = (u64)ttc_ch_readl(priv->sd, hwpwm, TTC_MATCH_CNT_VAL_OFFSET) << pres;
+	state->duty_cycle = mul_u64_u64_div_u64(tmp, NSEC_PER_SEC, rate);
+	if (mul_u64_u64_div_u64(state->duty_cycle, rate, NSEC_PER_SEC) < tmp)
+		state->duty_cycle++;
+
+	return 0;
+}
+
+static const struct pwm_ops cdns_ttc_pwm_ops = {
+	.apply = cdns_ttc_pwm_apply,
+	.get_state = cdns_ttc_pwm_get_state,
+};
+
+static int cdns_ttc_pwm_probe(struct auxiliary_device *auxdev,
+			      const struct auxiliary_device_id *id)
+{
+	const struct ttc_shared_data *sd = dev_get_platdata(&auxdev->dev);
+	struct device *dev = &auxdev->dev;
+	struct cdns_ttc_pwm *priv;
+	struct pwm_chip *chip;
+	int ret;
+
+	if (!sd)
+		return -EINVAL;
+
+	chip = devm_pwmchip_alloc(dev, TTC_NUM_CHANNELS, sizeof(*priv));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	priv = to_cdns_ttc_pwm(chip);
+	priv->sd = sd;
+	priv->max_count = BIT_ULL(sd->timer_width) - 1;
+
+	ret = devm_clk_rate_exclusive_get(dev, sd->clk);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to lock clock rate\n");
+
+	chip->ops = &cdns_ttc_pwm_ops;
+
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret)
+		return dev_err_probe(dev, ret, "could not register PWM chip\n");
+
+	return 0;
+}
+
+static const struct auxiliary_device_id cdns_ttc_pwm_id_table[] = {
+	{ .name = "timer_cadence_ttc.pwm" },
+	{},
+};
+MODULE_DEVICE_TABLE(auxiliary, cdns_ttc_pwm_id_table);
+
+static struct auxiliary_driver cdns_ttc_pwm_driver = {
+	.name     = "cdns_ttc_pwm",
+	.probe    = cdns_ttc_pwm_probe,
+	.id_table = cdns_ttc_pwm_id_table,
+};
+module_auxiliary_driver(cdns_ttc_pwm_driver);
+
+MODULE_AUTHOR("Mubin Sayyed <mubin.sayyed@amd.com>");
+MODULE_AUTHOR("Meher Thanmaiee <meherthanmaiee.vanukuri@amd.com>");
+MODULE_DESCRIPTION("Cadence TTC PWM driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/timer-cadence-ttc.h b/include/linux/timer-cadence-ttc.h
index 37ac775d6d50..05b7edd88626 100644
--- a/include/linux/timer-cadence-ttc.h
+++ b/include/linux/timer-cadence-ttc.h
@@ -10,24 +10,64 @@
 #define _LINUX_TIMER_CADENCE_TTC_H
 
 #include <linux/bits.h>
+#include <linux/io.h>
+#include <linux/types.h>
+
+struct clk;
 
 #define TTC_DEFAULT_TIMER_WIDTH		16
 
 /* Per-channel register offset stride */
 #define TTC_CH_OFFSET			0x04
 
+#define TTC_NUM_CHANNELS		3
+
 /* Timer Register Offset Definitions of Timer 1 */
 #define TTC_CLK_CNTRL_OFFSET		0x00 /* Clock Control Reg, RW */
 #define TTC_CNT_CNTRL_OFFSET		0x0C /* Counter Control Reg, RW */
 #define TTC_COUNT_VAL_OFFSET		0x18 /* Counter Value Reg, RO */
 #define TTC_INTR_VAL_OFFSET		0x24 /* Interval Count Reg, RW */
+#define TTC_MATCH_CNT_VAL_OFFSET	0x30 /* Match 1 Count Reg, RW */
 #define TTC_ISR_OFFSET			0x54 /* Interrupt Status Reg, RO */
 #define TTC_IER_OFFSET			0x60 /* Interrupt Enable Reg, RW */
 
 #define TTC_CNT_CNTRL_DISABLE_MASK	BIT(0)
+#define TTC_CNT_CNTRL_INT		BIT(1)
+#define TTC_CNT_CNTRL_MATCH		BIT(3)
+#define TTC_CNT_CNTRL_RST		BIT(4)
+#define TTC_CNT_CNTRL_WAVE_EN		BIT(5)
+#define TTC_CNT_CNTRL_WAVE_POL		BIT(6)
 
+#define TTC_CLK_CNTRL_PS_EN		BIT(0)
 #define TTC_CLK_CNTRL_CSRC_MASK		BIT(5) /* clock source */
 #define TTC_CLK_CNTRL_PSV_MASK		GENMASK(4, 1)
 #define TTC_CLK_CNTRL_PSV_SHIFT		1
+#define TTC_CLK_CNTRL_PSV_MAX		15 /* 4-bit prescaler field */
+
+/**
+ * struct ttc_shared_data - Data passed from parent to auxiliary device
+ * @base:		MMIO base address
+ * @clk:		Input clock
+ * @rate:		Input clock rate in Hz
+ * @timer_width:	Counter width in bits (16 or 32)
+ */
+struct ttc_shared_data {
+	void __iomem		*base;
+	struct clk		*clk;
+	unsigned long		rate;
+	u32			timer_width;
+};
+
+static inline u32 ttc_ch_readl(const struct ttc_shared_data *sd,
+			       unsigned int ch, u32 reg)
+{
+	return readl_relaxed(sd->base + reg + TTC_CH_OFFSET * ch);
+}
+
+static inline void ttc_ch_writel(const struct ttc_shared_data *sd,
+				 unsigned int ch, u32 reg, u32 val)
+{
+	writel_relaxed(val, sd->base + reg + TTC_CH_OFFSET * ch);
+}
 
 #endif /* _LINUX_TIMER_CADENCE_TTC_H */

-- 
2.34.1

