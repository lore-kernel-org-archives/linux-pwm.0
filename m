Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021128.outbound.protection.outlook.com [52.101.52.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6613517B418;
	Mon, 21 Sep 2026 07:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789975299; cv=fail; b=GawwLSpB/Q3Biu2PamAewZLJ0A2CwSGaCxMCFWSMohZgcaXRmHBLL7PpDF8NDHPoI1nf7kCPW7b+xZ7TgHjqMGroJ2ipHUbjwRG2wn6iKMC2McTpG2F2PlTTllaEPnaK/swymWlMC9YUXrfBMSqhFkokL9dbJb1Uw5zEbtwHoaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789975299; c=relaxed/simple;
	bh=OQkxqF6UeFBxUXfdTICQmGuOPXaTRJvQkCssJGkectE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mpTY5TLjs3lCy+/Pj8RB/Fat9LvKVk/ssNGlYyK3/IVpoSdWcRJHE622MDcYMIdGUTGMN5zO/E9DnL3jnRBqqovtgU9c6PBJ1sTsvNbI7TWawz5mam528xJB1/9utyGHV+NbgmTCm5SNFWtbfxpBQq8a9G/bcKYkUr2lZRep35M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=C19DWTDq; arc=fail smtp.client-ip=52.101.52.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="C19DWTDq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBmLjR2flStwAFjntbE74Iz8LNBywmwmsYUvhyWg+odLmcu2aCxxAbcf6NjyKYQtdz1eq94h3VEA7R0RXakLkY0o2R8r1WWR2DL0TLlLz0wTHaOsV89DLaqIcxcMzeL5GJU96NAbUaokavfr6vfQfrkRe8zuSRZkFICHrreKDIaHGYo6ZArA4clz+8LQu1svLZJoEAApZBu8DkHHcaH2R5U7K/wnmUVMb/nGIn47WoMOJxncBmJ8pkQ4qUIoyIWEavTdMKkyI6k2w8iOrCmRcZJFHJP4QV1tW/YQgB0WnoIPeqBSAaVzdWpLMC6J1lp+RRAK2rNOeVlOsSsAXWCA1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4f3nxdIOSGwPCTreuY+4Bp87hnO7UHsX6uQuJLST4A=;
 b=X/vFnuqm9WIlgVN6b8pWsq87QcphVcbWOVcD2NpPq/6EdvMRtY2LSTpfM7ATQFDpUMjPO6Txol3DazijM+iWsDrzhNwgJHA446MdcM9SPqyj3jEWo6RgIN2M/w/RhYnvfPsygB+tZQoXELmMv24bCHhJ4FC06upYKDi5xSQT1DZzF3OUCUPZQHIdRaLBigzIcm3zqz6W/8vjoKLhfSSVKKp8C/DYFyzzTvWFgV0m3jcHaNI50KsW4OpsBncTIGX2y3vZOJz/meBAK+O/6K7MwgknGpJijxlJCEy51JcpbIGL1xyCnW35U2XqSHW0hP5dXbEI9qGFJUVT/L3q2nHgxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4f3nxdIOSGwPCTreuY+4Bp87hnO7UHsX6uQuJLST4A=;
 b=C19DWTDqgiNnbenX7LVqnxUKMzGQxaC80ktmQEB2WbohiN/2st62V9dm0PLXL/d1bQdoUF6CKlY86kd/3gSdGz28UcFyllxHJPEJjfiOnL52vetpgVf4cf9YB1R6Jcdx+ogGW7fBAoHs2HZGsSp7sG5AfE6DnpknGHlj61T7pHuWilLvDAIllTS94hCvjWoPC7A8OYttQ8hGMucl2czRKdf72kwGi8eS8W3OGUbXSuZyrc0CawWypOLjLMbHXV+DOGjCHnxmpaT8Vw0eoPkv9AbC7POENYOO41hci7BsaiqOjW41oS5zmLpPhPxXpoB1+HflNR+ZOcxydjleiGWm7A==
Received: from BY3PR04CA0018.namprd04.prod.outlook.com (2603:10b6:a03:217::23)
 by DS0PR18MB988643.namprd18.prod.outlook.com (2603:10b6:8:432::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 07:21:33 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::8f) by BY3PR04CA0018.outlook.office365.com
 (2603:10b6:a03:217::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 07:21:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Mon, 21 Sep 2026 07:21:32 +0000
Received: from axz-uw1-build-vm02.corp.axiado.com (unknown [10.14.1.22])
	by smtp.corp.axiado.com (Postfix) with ESMTP id 21A3A40BFE04;
	Mon, 21 Sep 2026 00:21:32 -0700 (PDT)
From: Petar Stepanovic <pstepanovic@axiado.com>
Date: Mon, 21 Sep 2026 00:21:31 -0700
Subject: [PATCH v5 2/2] pwm: add Axiado AX3000 PWM driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-axiado-ax3000-pwm-v5-2-202aad28e129@axiado.com>
References: <20260921-axiado-ax3000-pwm-v5-0-202aad28e129@axiado.com>
In-Reply-To: <20260921-axiado-ax3000-pwm-v5-0-202aad28e129@axiado.com>
To: Akhila Kavi <akavi@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 openbmc@lists.ozlabs.org, Petar Stepanovic <pstepanovic@axiado.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789975291; l=10672;
 i=pstepanovic@axiado.com; s=20250916; h=from:subject:message-id;
 bh=OQkxqF6UeFBxUXfdTICQmGuOPXaTRJvQkCssJGkectE=;
 b=53UVB+XLqJBzl80UDVs1FGfM7quhBtlQUn9ple5J7FKm9Ye4k56b5VVjj8wXf+ABJAdo+SGaw
 Ezyr1dHubcKBUNHa9qw2wmP4xiaxOn7O9XNinwXVZmtdaozzK6WgiVa
X-Developer-Key: i=pstepanovic@axiado.com; a=ed25519;
 pk=70f1UJOGT9U11ZK6o+ENXtv0I5wBE3e+Y9YWODzRsdI=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|DS0PR18MB988643:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b2c9c5c-5cbb-4c07-0244-08df17b0f67b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|10067099003|6133799003|3023799007|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	wSmUzTSb1hbC7nLBIwSErjuXuSyXEVQ3zjQQJnFU41BAeJ9qsRzxiv8u97aBIZKRzpsf0cYI5rH2OQ/6wuZ/a2oe4L8brKdLHQ7rH49yL9bg7htqI6G04GPMZPYFwY+d+voWHy4Vqm7GtjDM6k0HHw2hcmuOinJYy9t7oSFG6G8jYBTb5KdD+CxFt5QZ69d+5py4tOXuvyMGDgD2gfEqKUI1anF4tYdJW/46sUsZIHuTe7i1l4ezx2tp7SG81b8l1QIlffLVJlvi7dDzb4xJs3g4aNPM5ijmJSGvLGT8z994tKm0tDEgzQjIC0dwZVEDUpERNjAR26c2lYC1dE5Li2t7LbJPLaDydBKakWGO9XxSTeNKwLOC1mU3K/6Whpeoit/UX9ejUGhohyiO/EDkT3WCsunE4MuVfLqIVdjuMEcPpIp7QANagVAHPUrT7/+TpaCU0Z+hBIXyEqWrVvdxOLacz8daAkD2DTaDb18xwSoT8YgA1ZKYyBbMQzdzDSZWH8tJ7aa52g5tDVkiWNwfJwzDuD+DjOFQqEky/e8O29OGX8SaAtlU8YHzShLlq9Q/8yawtAOZCxyxwZ4RTsXPsMf0Gcs5k7Ew8sYzSlHKFoCyzN3ddGldpU2ebZ13hfqKg6lyU8WwgiFVGFT5GgW4+zFg+5w4EDXQ0JXOaum6RtFwy51t9Lh8F4GMcTEN8YUKM1Te3Hd7U29yY+Zz6hCu4A==
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lGiwtwsVtdOYzdQmWET7ecxzV9CnrqRRnnJqpkZRcpuTBTF9MFa54s5vreCpy+B/alNKYBRoz0ZnukHMLc2e32/j+YJlRWkD5BDZ74W8Yb0FgFijAkJpWnVWO1H17P6kzIJrKuS7Ay/84iWG92NNB7mSA4cJXcj8oxVt9pOCn0PgdQT1TMlKsbApiG1hsxJLgLVSezcWCWJRNaw+KNEHGpNKOWO/+b949rXTue5Q2ZWagmtMFTiPf5wMt8WVqRWe8wMPfO8la76skoqkC1NiARO0VCzEfv/ZauN6U/9XRsTmi/+VqfHv+UpDPSFTOaxTEJWlYywKvpvEiaWoWPzdJQN8+8PSHXZwOqWW3nBUadj+gnKpUSwSMn6DB+kaM6BFuY/9qu5Mf1W2CcPVOIZ5F8h9AlrnTeMSagx50h/IlV8gv5ioZs8MKD0sBFo/GCvt
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 07:21:32.5958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b2c9c5c-5cbb-4c07-0244-08df17b0f67b
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR18MB988643

The Axiado AX3000 and AX3005 SoCs include a single-channel PWM
controller.

Add a driver supporting period, duty-cycle, and enable-state
configuration through the Linux PWM framework.

Disabling the hardware controller drives its output high. A 0% duty
cycle is implemented using the controller's constant-low encoding,
because a zero high time is interpreted by the hardware as a
constant-high output. The constant-low state is reported as a 0% duty
cycle with a one-clock-cycle period on readback.

AX3005 uses the same programming model as AX3000 and is supported
through the axiado,ax3000-pwm fallback compatible.

Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>
---
 MAINTAINERS              |   1 +
 drivers/pwm/Kconfig      |  11 ++
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-axiado.c | 277 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 290 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9999480376cc..14eea3bc4d4d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4319,6 +4319,7 @@ M:	Prasad Bolisetty <pbolisetty@axiado.com>
 L:	linux-pwm@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/pwm/axiado,ax3000-pwm.yaml
+F:	drivers/pwm/pwm-axiado.c
 
 AXIS ARTPEC ARM64 SoC SUPPORT
 M:	Jesper Nilsson <jesper.nilsson@axis.com>
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 6f3147518376..76f6c04b0e23 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -129,6 +129,17 @@ config PWM_ATMEL_TCB
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-atmel-tcb.
 
+config PWM_AXIADO
+	tristate "Axiado PWM support"
+	depends on ARCH_AXIADO || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  PWM framework driver for the PWM controller found on Axiado
+	  AX3000 and AX3005 SoCs.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-axiado.
+
 config PWM_AXI_PWMGEN
 	tristate "Analog Devices AXI PWM generator"
 	depends on MICROBLAZE || NIOS2 || ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTEL_SOCFPGA || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 0dc0d2b69025..4466a29e780a 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_PWM_ARGON_FAN_HAT)	+= pwm-argon-fan-hat.o
 obj-$(CONFIG_PWM_ATMEL)		+= pwm-atmel.o
 obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+= pwm-atmel-hlcdc.o
 obj-$(CONFIG_PWM_ATMEL_TCB)	+= pwm-atmel-tcb.o
+obj-$(CONFIG_PWM_AXIADO)	+= pwm-axiado.o
 obj-$(CONFIG_PWM_AXI_PWMGEN)	+= pwm-axi-pwmgen.o
 obj-$(CONFIG_PWM_BCM2835)	+= pwm-bcm2835.o
 obj-$(CONFIG_PWM_BCM_IPROC)	+= pwm-bcm-iproc.o
diff --git a/drivers/pwm/pwm-axiado.c b/drivers/pwm/pwm-axiado.c
new file mode 100644
index 000000000000..781053e255f0
--- /dev/null
+++ b/drivers/pwm/pwm-axiado.c
@@ -0,0 +1,277 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * SPDX-FileCopyrightText: 2021-2026 Axiado Corporation.
+ */
+
+/*
+ * Limitations:
+ * - Only normal polarity is supported.
+ * - The hardware has no shadow registers, so configuration changes take
+ *   effect immediately without waiting for the current period to complete.
+ * - The output is driven high while the hardware is disabled.
+ * - Supported period range: 2 through 0xfffffffe PWM input clock cycles;
+ *   0xffffffff is reserved by the hardware for a constant low output.
+ *   Longer periods are clamped to the maximum.
+ * - A 0% duty cycle is emitted using the constant low encoding because the
+ *   hardware interprets a zero high time as a constant high output. The
+ *   requested period is lost in that case and is reported as a single clock
+ *   cycle.
+ * - A 100% duty cycle is supported and emits a constant high output.
+ */
+
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+
+/* Register offsets */
+#define AXIADO_PWM_CTRL_REG	0x0000
+#define AXIADO_PWM_PERIOD_REG	0x0004
+#define AXIADO_PWM_HIGH_REG	0x0008
+
+/* Period and duty cycle limits */
+#define AXIADO_PWM_PERIOD_MIN	2
+#define AXIADO_PWM_PERIOD_MAX	0xfffffffe
+#define AXIADO_PWM_PERIOD_CONST_LOW	0xffffffff
+#define AXIADO_PWM_DUTY_MIN	1
+
+/* Control register bits */
+#define AXIADO_PWM_CTRL_ENABLE	BIT(0)
+
+struct axiado_pwm_chip {
+	void __iomem *base;
+	unsigned long rate;
+};
+
+struct axiado_pwm_waveform {
+	u32 period;
+	u32 duty;
+	bool enabled;
+};
+
+static int
+axiado_pwm_round_waveform_tohw(struct pwm_chip *chip,
+			       struct pwm_device *pwm,
+			       const struct pwm_waveform *wf,
+			       void *_wfhw)
+{
+	struct axiado_pwm_chip *axpwm = pwmchip_get_drvdata(chip);
+	struct axiado_pwm_waveform *wfhw = _wfhw;
+	u64 period;
+	u64 duty;
+	int ret = 0;
+
+	/* Encode a disabled request as a zeroed hardware waveform. */
+	if (!wf->period_length_ns) {
+		*wfhw = (struct axiado_pwm_waveform) { };
+
+		return 0;
+	}
+
+	period = mul_u64_u64_div_u64(wf->period_length_ns, axpwm->rate,
+				     NSEC_PER_SEC);
+	duty = mul_u64_u64_div_u64(wf->duty_length_ns, axpwm->rate,
+				   NSEC_PER_SEC);
+
+	if (!duty) {
+		/*
+		 * A zero high time makes the hardware emit a constant high
+		 * output, so use the constant low period encoding for a 0%
+		 * duty cycle. The high time must stay non-zero because it
+		 * takes precedence over that encoding. The requested period
+		 * is lost, .round_waveform_fromhw() reports a single clock
+		 * cycle instead.
+		 */
+		*wfhw = (struct axiado_pwm_waveform) {
+			.period = AXIADO_PWM_PERIOD_CONST_LOW,
+			.duty = AXIADO_PWM_DUTY_MIN,
+			.enabled = true,
+		};
+
+		/* That single cycle is longer than a sub-cycle request. */
+		return period ? 0 : 1;
+	}
+
+	if (period < AXIADO_PWM_PERIOD_MIN) {
+		period = AXIADO_PWM_PERIOD_MIN;
+		ret = 1;
+	} else if (period > AXIADO_PWM_PERIOD_MAX) {
+		period = AXIADO_PWM_PERIOD_MAX;
+	}
+
+	/*
+	 * Period clamping can leave the converted duty greater than the
+	 * final hardware period. In that case, clamp it to 100% duty.
+	 */
+	if (duty > period)
+		duty = period;
+
+	*wfhw = (struct axiado_pwm_waveform) {
+		.period = period,
+		.duty = duty,
+		.enabled = true,
+	};
+
+	return ret;
+}
+
+static int
+axiado_pwm_round_waveform_fromhw(struct pwm_chip *chip,
+				 struct pwm_device *pwm,
+				 const void *_wfhw,
+				 struct pwm_waveform *wf)
+{
+	struct axiado_pwm_chip *axpwm = pwmchip_get_drvdata(chip);
+	const struct axiado_pwm_waveform *wfhw = _wfhw;
+	u32 period = wfhw->period;
+	u32 duty = wfhw->duty;
+
+	if (!wfhw->enabled) {
+		*wf = (struct pwm_waveform) {
+			.period_length_ns = 0,
+		};
+
+		return 0;
+	}
+
+	/*
+	 * The constant low encoding doesn't hold a period. Report the
+	 * shortest one, the output is low for all of it either way.
+	 */
+	if (period == AXIADO_PWM_PERIOD_CONST_LOW) {
+		period = 1;
+		duty = 0;
+	} else if (duty > period) {
+		duty = period;
+	}
+
+	*wf = (struct pwm_waveform) {
+		.period_length_ns =
+			mul_u64_u64_div_u64_roundup(period, NSEC_PER_SEC,
+						    axpwm->rate),
+		.duty_length_ns =
+			mul_u64_u64_div_u64_roundup(duty, NSEC_PER_SEC,
+						    axpwm->rate),
+		.duty_offset_ns = 0,
+	};
+
+	return 0;
+}
+
+static int axiado_pwm_read_waveform(struct pwm_chip *chip,
+				    struct pwm_device *pwm,
+				    void *_wfhw)
+{
+	struct axiado_pwm_chip *axpwm = pwmchip_get_drvdata(chip);
+	struct axiado_pwm_waveform *wfhw = _wfhw;
+	u32 ctrl;
+
+	ctrl = readl(axpwm->base + AXIADO_PWM_CTRL_REG);
+
+	*wfhw = (struct axiado_pwm_waveform) {
+		.period = readl(axpwm->base + AXIADO_PWM_PERIOD_REG),
+		.duty = readl(axpwm->base + AXIADO_PWM_HIGH_REG),
+		.enabled = !!(ctrl & AXIADO_PWM_CTRL_ENABLE),
+	};
+
+	return 0;
+}
+
+static int axiado_pwm_write_waveform(struct pwm_chip *chip,
+				     struct pwm_device *pwm,
+				     const void *_wfhw)
+{
+	struct axiado_pwm_chip *axpwm = pwmchip_get_drvdata(chip);
+	const struct axiado_pwm_waveform *wfhw = _wfhw;
+
+	if (!wfhw->enabled) {
+		writel(0, axpwm->base + AXIADO_PWM_CTRL_REG);
+
+		return 0;
+	}
+
+	/*
+	 * The hardware has no shadow registers. These writes may alter the
+	 * active waveform before the current period has completed.
+	 */
+	writel(wfhw->period, axpwm->base + AXIADO_PWM_PERIOD_REG);
+	writel(wfhw->duty, axpwm->base + AXIADO_PWM_HIGH_REG);
+	writel(AXIADO_PWM_CTRL_ENABLE, axpwm->base + AXIADO_PWM_CTRL_REG);
+
+	return 0;
+}
+
+static const struct pwm_ops axiado_pwm_ops = {
+	.sizeof_wfhw = sizeof(struct axiado_pwm_waveform),
+	.round_waveform_tohw = axiado_pwm_round_waveform_tohw,
+	.round_waveform_fromhw = axiado_pwm_round_waveform_fromhw,
+	.read_waveform = axiado_pwm_read_waveform,
+	.write_waveform = axiado_pwm_write_waveform,
+};
+
+static int axiado_pwm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct axiado_pwm_chip *axpwm;
+	struct pwm_chip *chip;
+	struct clk *clk;
+	int ret;
+
+	chip = devm_pwmchip_alloc(dev, 1, sizeof(*axpwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	axpwm = pwmchip_get_drvdata(chip);
+
+	axpwm->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(axpwm->base))
+		return dev_err_probe(dev, PTR_ERR(axpwm->base),
+				     "Failed to map registers\n");
+
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk),
+				     "Failed to get/enable clock\n");
+
+	ret = devm_clk_rate_exclusive_get(dev, clk);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to lock clock rate\n");
+
+	axpwm->rate = clk_get_rate(clk);
+	if (!axpwm->rate)
+		return dev_err_probe(dev, -EINVAL,
+				     "Failed to get clock rate\n");
+
+	chip->ops = &axiado_pwm_ops;
+	chip->atomic = true;
+
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add PWM chip\n");
+
+	return 0;
+}
+
+static const struct of_device_id axiado_pwm_match[] = {
+	{ .compatible = "axiado,ax3000-pwm" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, axiado_pwm_match);
+
+static struct platform_driver axiado_pwm_driver = {
+	.driver = {
+		.name = "axiado-pwm",
+		.of_match_table = axiado_pwm_match,
+	},
+	.probe = axiado_pwm_probe,
+};
+module_platform_driver(axiado_pwm_driver);
+
+MODULE_AUTHOR("Axiado Corporation");
+MODULE_DESCRIPTION("Axiado PWM driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1

