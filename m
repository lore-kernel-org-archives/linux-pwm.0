Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020091.outbound.protection.outlook.com [52.101.61.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E31241F7F2;
	Tue,  8 Sep 2026 08:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788856131; cv=fail; b=YADxGrwnwJ7K8B1zs1SWGdh4PfPdgDChPmaA/twH7vDFdrj3UBv+LPWeaDEsV28c6ya+hZNEIU9dWHLKPAqpoHVpN1MVbWQIABKkZdJnNNXV94H2hnm9lfHk/8KEwIMoDddvXPv7oMerjv2aqPkPUGbq0yk1+BCjWjjeqs/o57g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788856131; c=relaxed/simple;
	bh=VgZFAlq1hMfocvVjmhFoe7x3ZbeOhcdDSvcz+46uKIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qALIe0tQqL+HeUShOjBOhJ6piorpANgey6ctSmSGt8gK3SWS8gDOUO05gFQNQRBRe+iLHKLkRWPyznMDNw1PqzAhSguiYGF4diqaaFBNFVpnZBXw9kzPzsnt38rFNJQ11/f5QGyTSIN1WS4xwuaQFtV01O0azOLi6sHuKuChSxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=rPsKCK+s; arc=fail smtp.client-ip=52.101.61.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="rPsKCK+s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYh/4CWR1Bbtvbq5jRNpW7bWYudLNFuHOdF+jFrikZADnliORA/tiMQOvp9VnQrTQVw5oXOj0ByDOcP3tOkdLXgaDCHUT2uD/aU9Tg9c9/dxfCD1J8bDJK6BkAgKoTPH/+ypn+lHE6edNswxqSSRTVxcdnR8069wverTB0o7Mh8utO1oh7rv7CmsOQTvlvx/RTAcbBWtNiEytFL7c+ZdEe4VWaV39R4m3M9b+HRJwISjGNFc9H5pL1G5XcNpUC4sXIaY0q1hmKMNVIwSV/lUgxjOeXOnMNs+c2Q7BS5Ms9RSJZSxX8Pj4sI0yoKeTTp7ntleRe8IR+322kvoa1K9Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u82ReZq3dG7kCyoli0Un9t5WJ+5zruByQTQoHEQUxoI=;
 b=Ms70LnkB+2yKRsYTIa54xSavmiiKdich0429Dd0RgKJHQ/ptnKY2Tn47/jrukEPyCiC8VlmCdXWOVrVin6bZ/L9ZfdsrvUyJAeDJrDqzPwhgVGwm894PfwDJsgojJcmngD6L0eiMQ8Q+akSbICFzdxt2dYp4T4bbND94cDvHk7L+x8+3Wpo3eS8P3IdxtwRxVk+FrYuh0zLyZND/Xy6Q1edd7VR3OCZyG4eNfpLAr4A1BFihoNy61jpvToWcK/TkX7FKjv1tTgVptmcqmyg5ubbBdOy3DCYwmTznj5sJcxdVvbsqusYSh13HfSj0Yk0u7wwdV/F8en2Vaf/6ptJosg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u82ReZq3dG7kCyoli0Un9t5WJ+5zruByQTQoHEQUxoI=;
 b=rPsKCK+sthtAYb4pw/GowAZaMkQr5MjLjrdiJ+0z7wnhJrQ7XbCbl+xv87pgVjdHHPYL4gYk+Gofaw+zzKeKX+OuO5+l7jGDhqbmV2a/2aVP1E0TGun+MsYxbl5eFJviGqFzNtxQnnUCVL+VDzTDccC5tPTgERYWX5yCh3mfgouxxjKaExJFbxZ4CmETU2boxoUHpU/zkmjwx3Q/i75jE6f+OXOyzIprRl/rmf0/otjBEihACFGaYGolwaHu/JQtmuUsWtCSDLJCTVdWo/9ifo9BBIks8HhZlzWX6Ny2S3g6dw/Onpt3EFiTrFhOxDGjb0nCSbo94e/h8771n4OyeQ==
Received: from BY3PR10CA0025.namprd10.prod.outlook.com (2603:10b6:a03:255::30)
 by LV8PR18MB5884.namprd18.prod.outlook.com (2603:10b6:408:22c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 08:28:43 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::20) by BY3PR10CA0025.outlook.office365.com
 (2603:10b6:a03:255::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 08:28:43 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Tue, 8 Sep 2026 08:28:43 +0000
Received: from axz-uw1-build-vm02.corp.axiado.com (unknown [10.14.1.22])
	by smtp.corp.axiado.com (Postfix) with ESMTP id 4596F40BFE04;
	Tue,  8 Sep 2026 01:28:43 -0700 (PDT)
From: Petar Stepanovic <pstepanovic@axiado.com>
Date: Tue, 08 Sep 2026 01:28:35 -0700
Subject: [PATCH v4 2/2] pwm: add Axiado AX3000 PWM driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-axiado-ax3000-pwm-v4-2-19a03671cd5b@axiado.com>
References: <20260908-axiado-ax3000-pwm-v4-0-19a03671cd5b@axiado.com>
In-Reply-To: <20260908-axiado-ax3000-pwm-v4-0-19a03671cd5b@axiado.com>
To: Akhila Kavi <akavi@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 openbmc@lists.ozlabs.org, Petar Stepanovic <pstepanovic@axiado.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788856122; l=12164;
 i=pstepanovic@axiado.com; s=20250916; h=from:subject:message-id;
 bh=VgZFAlq1hMfocvVjmhFoe7x3ZbeOhcdDSvcz+46uKIM=;
 b=V9Vt03cEt+hqUOESmo7sPqqgjo1lEMxtAzfg0tqkBSE/6+saWdPHdlnFSE9y6gVrEi9L1yGm+
 jyqiuIp95rrBAILhPCjhwL59rDp2DZHcNIKXLxLDi/UduJdyalfBthU
X-Developer-Key: i=pstepanovic@axiado.com; a=ed25519;
 pk=70f1UJOGT9U11ZK6o+ENXtv0I5wBE3e+Y9YWODzRsdI=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|LV8PR18MB5884:EE_
X-MS-Office365-Filtering-Correlation-Id: d27900b7-0c79-4664-4aa6-08df0d8331bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|6133799003|18002099003|22082099003|3023799007|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	XkA9oZhbNAOAgSEqKpvNg9etv3KNATpN/P6949Zl+EHf1LEhuql1Ng4FjKzKzGX3o9ownZLQUEvXgpzXltk5lZKYc9ZP27cbZhZpNAX0yVVTKMvFyHZjb7+yLP8cD8hYV8EBuPrDk9J/ebWtheLwUUG7lOJ9uDtBiwlhvmrDwaY5UsSqsUu5rj/nSnc/9mIOx/tCLuymyggcktuW6R/ZkMCrzt3GLXHZeGDo6UsycKuvrRKoB8eURBc0hFnziIT4pogc8QaZ80i+KbIbctiuQA3doj9V3oHzuXk7I7IslmJpmod5AJJJo+u0ddckbofpN8AYmP0OvpHrT9xcsoAooKuoo4+hvlQ85yyIn7wdwkgm972AHQhuc2AYhQLykiL5CLlI6Qcd/ZHpXWg8SI832u/+unrVT6nWFrH+YaYyhjMFjhwWmEhL5LYeF1D+VSLyG++KkabYwGCB7S3E29xqU2gi/7Plw8dpJ3xZqLfvr4NibzynpZuJn7oOTV/YX5lpm+kSPeGQ/cNoSsHe8HG+fFIro9n2bVeEyN7glpeTSNnrW1795Ji/Hw4/68m/G3NHDgG+38e5nBbxSTuFDHYXH/HNMKWFzmIBa+bj0c7DFsSWkGwYCW0P9gEbqIZbZ5jKd5mcz3UTkGXpSEXeayO987rL3ZuFgEGiA2BzocDNUEaITRvWwNVgP+iPtf+1wcF10jy/ontJ/Tfhqla+1I+l0Q==
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(3023799007)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FapakIDHUK1tW7Y7sWSd1fnESDHPBq0g9iRDD4+fmyit17WSWqVsGisk9Djw93LeXh+V/AND1eKvgGpFDfieQ4PA4p0RG1t2mUx09yRt5L6PbFDJLY5SxrS6xLADx+oL5jd/CzrjRPtEs4FJ6bcVg8KhvrMyrk+0Io9ZBzx67ZwIePErn9G69R2CW5HWu1qb00WYhuPz74Ns1kqnkTobF/ZP1SbkAp31h/f18vYjRVte2ldsefpfByaBuwkHZg07fyc3A9DQM7deGSYngQT+BlUC45MsQvPtSbsJ2snkM3xxZcLhFzyWdgPHwEYUdZN7jS6ZQtDyHTQbNet3BxD2lF6d6pQeAkeg2FeJ1Ezsd/gpikv7YkFPamf60kPBt49fdFTANL2fPmpQbdELGSyhxv3ZM1BrF3Ec8GXeCpp5cYkQIC3Fn/S1Uy0zx4pQrF+s
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 08:28:43.5741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d27900b7-0c79-4664-4aa6-08df0d8331bd
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5884

The Axiado AX3000 and AX3005 SoCs include a single-channel PWM
controller.

Add a driver supporting period, duty-cycle, and enable-state
configuration through the Linux PWM framework.

Disabling the hardware controller drives its output high. Implement a
logically disabled PWM using the controller's constant-low encoding
instead. The same encoding is used for an enabled PWM with a 0% duty
cycle, so cache the logical state and requested period for readback.

AX3005 uses the same programming model as AX3000 and is supported
through the axiado,ax3000-pwm fallback compatible.

Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>
---
 MAINTAINERS              |   1 +
 drivers/pwm/Kconfig      |  11 ++
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-axiado.c | 332 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 345 insertions(+)

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
index 000000000000..e1d408809694
--- /dev/null
+++ b/drivers/pwm/pwm-axiado.c
@@ -0,0 +1,332 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021-2026 Axiado Corporation.
+ */
+
+/*
+ * - Supports normal polarity. Configuration changes take effect immediately
+ *   without waiting for the current period to complete.
+ * - The hardware output remains high when the controller is disabled.
+ *   Therefore, a logically disabled PWM is implemented using the hardware
+ *   constant-low representation.
+ * - Supported period range: 2 through 0xfffffffe PWM input clock cycles;
+ *   0xffffffff is reserved by the hardware for a constant-low output.
+ *   Longer periods are clamped to the maximum.
+ * - 0% duty cycle: Programmed as a constant-low period because the
+ *   hardware interprets a zero high time as a constant-high output.
+ *   Consequently, the requested period cannot be read back while the
+ *   duty cycle is 0%.
+ * - 100% duty cycle: Fully supported and produces a constant-high output.
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
+	u32 cached_period;
+	bool logically_disabled;
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
+		*wfhw = (struct axiado_pwm_waveform) {};
+
+		return 0;
+	}
+
+	/* Only an edge-aligned waveform starting at offset zero is supported. */
+	if (wf->duty_offset_ns)
+		return -EINVAL;
+
+	if (wf->duty_length_ns > wf->period_length_ns)
+		return -EINVAL;
+
+	period = mul_u64_u64_div_u64(wf->period_length_ns, axpwm->rate,
+				     NSEC_PER_SEC);
+
+	if (period < AXIADO_PWM_PERIOD_MIN) {
+		period = AXIADO_PWM_PERIOD_MIN;
+		ret = 1;
+	} else if (period > AXIADO_PWM_PERIOD_MAX) {
+		period = AXIADO_PWM_PERIOD_MAX;
+	}
+
+	/*
+	 * Keep the rounded period for a 0% duty cycle. .write_waveform()
+	 * translates it to the hardware constant-low representation.
+	 */
+	if (!wf->duty_length_ns) {
+		*wfhw = (struct axiado_pwm_waveform) {
+			.period = period,
+			.duty = 0,
+			.enabled = true,
+		};
+
+		return ret;
+	}
+
+	duty = mul_u64_u64_div_u64(wf->duty_length_ns, axpwm->rate,
+				   NSEC_PER_SEC);
+
+	/*
+	 * Preserve an exact 100% duty request when the hardware period has
+	 * been clamped.
+	 */
+	if (wf->duty_length_ns == wf->period_length_ns)
+		duty = period;
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
+
+	if (!wfhw->enabled) {
+		*wf = (struct pwm_waveform) {
+			.period_length_ns = 0,
+			.duty_length_ns = 0,
+			.duty_offset_ns = 0,
+		};
+
+		return 0;
+	}
+
+	*wf = (struct pwm_waveform) {
+		.period_length_ns =
+			mul_u64_u64_div_u64_roundup(wfhw->period, NSEC_PER_SEC,
+						    axpwm->rate),
+		.duty_length_ns =
+			mul_u64_u64_div_u64_roundup(wfhw->duty, NSEC_PER_SEC,
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
+	u32 period;
+	u32 duty;
+	u32 ctrl;
+
+	/*
+	 * A logically disabled request is implemented as a constant-low
+	 * hardware waveform because disabling the controller drives the
+	 * output high.
+	 */
+	if (axpwm->logically_disabled) {
+		*wfhw = (struct axiado_pwm_waveform) {};
+		return 0;
+	}
+
+	ctrl = readl(axpwm->base + AXIADO_PWM_CTRL_REG);
+	period = readl(axpwm->base + AXIADO_PWM_PERIOD_REG);
+	duty = readl(axpwm->base + AXIADO_PWM_HIGH_REG);
+
+	/* The constant-low encoding doesn't hold the period, so restore it. */
+	if (period == AXIADO_PWM_PERIOD_CONST_LOW) {
+		period = axpwm->cached_period;
+		duty = 0;
+	} else if (duty > period) {
+		duty = period;
+	}
+
+	*wfhw = (struct axiado_pwm_waveform) {
+		.period = period,
+		.duty = duty,
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
+	u32 period = wfhw->period;
+	u32 duty = wfhw->duty;
+
+	if (!wfhw->enabled) {
+		/*
+		 * Disabling the controller drives its output high. Implement
+		 * the logically disabled state using the constant-low hardware
+		 * representation instead.
+		 */
+		writel(AXIADO_PWM_PERIOD_CONST_LOW,
+		       axpwm->base + AXIADO_PWM_PERIOD_REG);
+		writel(AXIADO_PWM_DUTY_MIN,
+		       axpwm->base + AXIADO_PWM_HIGH_REG);
+		writel(AXIADO_PWM_CTRL_ENABLE,
+		       axpwm->base + AXIADO_PWM_CTRL_REG);
+		axpwm->logically_disabled = true;
+
+		return 0;
+	}
+
+	/*
+	 * A zero high time produces a constant high output, so use the
+	 * constant-low period encoding for a 0% duty cycle. Keep the high time
+	 * non-zero because a zero value takes precedence over that encoding.
+	 * Cache the requested period for .read_waveform().
+	 */
+	if (!duty) {
+		axpwm->cached_period = period;
+		period = AXIADO_PWM_PERIOD_CONST_LOW;
+		duty = AXIADO_PWM_DUTY_MIN;
+	}
+
+	/*
+	 * The hardware has no shadow registers. These writes may alter the
+	 * active waveform before the current period has completed.
+	 */
+	writel(period, axpwm->base + AXIADO_PWM_PERIOD_REG);
+	writel(duty, axpwm->base + AXIADO_PWM_HIGH_REG);
+	writel(AXIADO_PWM_CTRL_ENABLE, axpwm->base + AXIADO_PWM_CTRL_REG);
+	axpwm->logically_disabled = false;
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
+	/*
+	 * Provide a valid fallback period if the bootloader left the
+	 * constant-low encoding programmed.
+	 */
+	axpwm->cached_period = AXIADO_PWM_PERIOD_MIN;
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

