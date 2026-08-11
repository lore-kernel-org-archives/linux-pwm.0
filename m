Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021120.outbound.protection.outlook.com [52.101.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9392DEA6B;
	Tue, 11 Aug 2026 09:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438959; cv=fail; b=ZU5/wN+GCygMtIq0qq/xq7JUsgjXY/lFe3kPqI1liT02Atqmr6PzKEeWPCCrACndGIXx7Fq/yY/zehqJOnjkt0FNZDyS4wef19TSKW/TuQZqhem0Yf4Hx7HJK2exbNzC6zs8uLiRqzDfMkGuoykQh9AcSIF/KqV9XfheTbfHXg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438959; c=relaxed/simple;
	bh=5lKeCfNkgVOGImhDdRmmNBGC/YUkoZXY+c/Z5sDNXdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W4PQwq88GjNZduHy+nVYqX/YBvfZk62RU6NMfarQwaullQ1WBzPxABYjXXzccsjcd9hkkqgw7byEryHFCFn1aX2l/JYVV9EioFcSbxoRgFbS0r2182Q6hTLB9/JTYl85sM33gICWrLcEhrmH6oZfcZfq4QiwULRqtOB0rrCkdg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=Z6r1CeSP; arc=fail smtp.client-ip=52.101.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="Z6r1CeSP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8TcHVOeue4mxuaCos5ZjheW89p/3Iwg6dD9W/ln4m4thE4YX0nfkOVthtOYOWqZVYGmrfPzGxu8XncLqNSw9MoV+c+rVMiOIhHtxf8E2JvNQ9EEDAaX8hOfhX4lr2DQYOzh0LJp1Rl/kIEGDSQ3hW6Z0Y/FP++d+vhrY+acbhdP5qQ0W4G/IuoCfPqcrsBjVGtrqdCYshr876kY1gtMfGBJCwLjn1skmowtKymDvV04AcmAjylj0shpasr9m0Kh4lDvzsGqgErg/yFVlnqp4jqF2fwSv0AQvjFw2+55Qsl6TbUd5GT6bgJAf/PA8dLShC7JXtQyzyFNy/hHrWyMYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSz5fp8A+4Oz/rfxGdk8BgRi5I8WhH3kRTjUpjFeckU=;
 b=N66SfIExJIwUmqsUK20V8TExdqP4k9ykjfnsm3aoIzAko5FfoTSTC6uri8pNQ4EhJZ7rQSfXoxJxB02WCRZQOgzeuUKWI3wPigaMZXa0UZGBCBf3H+Dk/zTlbZtf1mcm+S8PelYU4wPtWcqJS5Yj6azLIhX8F8JmfU8kGQmxRlWxaDB6heRd0hcUknfZe3ubG3hslH4nI6I4j2mnwjr7ZL+m5/SX0QeWgqy5dlgopA7k/qTDDHHWnMlIVGrt7WT9s3BEe3JWX3IEEvMGMcL3N/6XTbijCSvJy/N4Gzsw45aHodAgSzmAKT7CocNgki4r+C5GeMX8/0hhZ9FdmQTq/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSz5fp8A+4Oz/rfxGdk8BgRi5I8WhH3kRTjUpjFeckU=;
 b=Z6r1CeSPpIIN5HEGztzgx8WVPKyTzgaaHJTwM9xZQon4Fqy2gc7mMZdh76tY6O/LPPM71OTIeeFS8Z112gXeXlEgRFqCMSLzh6FIjz2uFrEoBEIfcmcWfje1jlTm5HVZyALJNpD9WTKlKdZ3GxMyL6w5cBJL7sVdfEGIHvw/8Iu65JpQDw3tyRkqOzpFSA8o/0IbUo8XcHhkB0/aszPFBVuZr5rN0yUxmsRzLdaaz0mCtq0TaaVrIT5a3+DJyZzTPxYqicmoRfhSZWj8oEXwMtPDbPsH1xpsIRO670XsEbMEZJgDADvMks2b1T3jyRvqAEY7ZEE4Zr8beFF8xj4fEw==
Received: from DS7PR06CA0025.namprd06.prod.outlook.com (2603:10b6:8:54::31) by
 CH3PR18MB6005.namprd18.prod.outlook.com (2603:10b6:610:1e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 09:02:32 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:8:54:cafe::12) by DS7PR06CA0025.outlook.office365.com
 (2603:10b6:8:54::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Tue,
 11 Aug 2026 09:02:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.6
 via Frontend Transport; Tue, 11 Aug 2026 09:02:32 +0000
Received: from axz-uw1-build-vm02.corp.axiado.com (unknown [10.14.1.22])
	by smtp.corp.axiado.com (Postfix) with ESMTP id 84E674186B59;
	Tue, 11 Aug 2026 02:02:31 -0700 (PDT)
From: Petar Stepanovic <pstepanovic@axiado.com>
Date: Tue, 11 Aug 2026 02:01:51 -0700
Subject: [PATCH v3 2/2] pwm: add Axiado AX3000 PWM driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-axiado-ax3000-pwm-v3-2-6ceaccd812cf@axiado.com>
References: <20260811-axiado-ax3000-pwm-v3-0-6ceaccd812cf@axiado.com>
In-Reply-To: <20260811-axiado-ax3000-pwm-v3-0-6ceaccd812cf@axiado.com>
To: Akhila Kavi <akavi@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Petar Stepanovic <pstepanovic@axiado.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786438951; l=11123;
 i=pstepanovic@axiado.com; s=20250916; h=from:subject:message-id;
 bh=5lKeCfNkgVOGImhDdRmmNBGC/YUkoZXY+c/Z5sDNXdc=;
 b=apf/cMLxKuOPoElxiQvfsmvObBMnF0SIwKMAQVAyjGK23ohlB4GcZYvegeV/YrIrFbRc9s4VS
 rjlYWzTplOvASITSukMihlr9I+T30HdlhYOZ4RYuRABTKBHcaKh16Bm
X-Developer-Key: i=pstepanovic@axiado.com; a=ed25519;
 pk=70f1UJOGT9U11ZK6o+ENXtv0I5wBE3e+Y9YWODzRsdI=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|CH3PR18MB6005:EE_
X-MS-Office365-Filtering-Correlation-Id: 6196d801-833d-41ba-8a81-08def7874743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|6133799003|56012099006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	QIWXGrzP8ghVPuvAbJSRtffvFn9g/r5g1930zs4R4yO2NGVHkFZ9PMJZZIwpEKPgXBklAJDolxT75HiZ5DgPh7bCL7M6Sr+CSOcHbJUsbDgZWnaRyuu0wb7odVbbeF1mKSif+b/1zky1H4T6HVQRTG1RL82PG+znMz1htgSvPgPPDFRcHEsyPFCQ6D1xBy2ipKFdwukcTkG89r3dV3tLqm1yzr6iCzzpAzPOeVb9lhpL8RU1ZksYm1VjbVZRimjQuAuZALSRZiMZjIkRGjWdmSvjEn9QoziTHn4gC+u8IOi1DnePIFR9TM2kF5cwom6dgQmJjMzptfqUX3uEg+sT3QfLXHf0bgdFkPCbaGM4wAGptAgLbFvyjvEq64pXUCGuw40PnTvP7QQWPiK/MlpQgBOR7yXBx1A5SlD3+TCif836DQ74oblF+e8of3QoxIZ8AkVWW7cHEyByoWc+tNgMwyOU+lziLxgZB/LcrLs9t0/C6qqAC2UwLaZ1fFjtVoEvAccLliLpnQgVKrqsjhNCF9FZ+/LoxI08aJVdUO+WLm4JzFnjzLUjF4L9Lp5rpC8nhjQjF1Bkl3hHjRDHPipRhiSmmZy37hfDK5nLdYHB0P6FijVKRd5NNLVw96dvyuI9RhTo5QgA1lcl5xeG83LOOFIyUCY6jV2Pd3kQqyLH8xH7z+wRelYxkjvLkp9JTOtIRHX3NV4ZwvqSuXUnZ8H84A==
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	b9VBo5tWvhiaHgpDdKNZrpJYfnJtHvJYS3gct1W3rgZEY74KS/TaE8iQtK2fFAiB5tnXQsJsha+PP7SNrCGRTpuRMsZGJosPL5k1+jst4oPEZn/mvIOAmd+sXzfAcMj4gJcP0m7t1iqHHeIsptbaddxHBWvgpzw3OJB3ZhewjkxQKd6F/PtsE7qGRxrIaWmgCKtKB28Jot5a3MrPuByaMt46UK7+cdZZHYJ1LiFoQI/HQu46FKniqr2SFEamQnhbvayRBwoxbkVm8iT/Vj0p/bB3A2fv/s9BHv+iwsxlWYDVhaYWiqp4o2sQOupqfcITHup7bq7fl1X6XxT1YIYV4Wu3kbMg84Vy/d5Tvuuw478A+oHg4iA92CgBRL8TsUZ/7AOekGOyZO1G1oGyE2s/xDAeLKTDrhQGpY6TjCRSKNL9Y1F/um8boQ5CYcxp+yEC
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 09:02:32.0185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6196d801-833d-41ba-8a81-08def7874743
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB6005

The Axiado AX3000 and AX3005 SoCs include PWM controllers that can be
used to generate configurable PWM output signals.

Add a PWM driver with support for configuring period, duty cycle, and
enable state through the Linux PWM framework.

Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>
---
 MAINTAINERS              |   1 +
 drivers/pwm/Kconfig      |  11 ++
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-axiado.c | 310 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 323 insertions(+)

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
index 000000000000..4815d34b907e
--- /dev/null
+++ b/drivers/pwm/pwm-axiado.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021-2026 Axiado Corporation.
+ */
+
+/*
+ * Limitations:
+ * - Only normal polarity is supported.
+ * - Configuration changes take effect immediately; the current period is
+ *   not guaranteed to complete.
+ * - Disable operations take effect immediately; the current period is not
+ *   guaranteed to complete.
+ * - When disabled, the output remains high.
+ * - The supported period range is 2 through 0xfffffffe PWM input clock
+ *   cycles; 0xffffffff is reserved by the hardware for a constant-low
+ *   output. Longer periods are rounded down to the maximum.
+ * - The hardware interprets a zero high time as a constant high output, so
+ *   a 0% duty cycle is programmed as a constant-low period instead. That
+ *   encoding does not hold the requested period, so the period cannot be
+ *   read back from the hardware while the duty cycle is 0%.
+ * - A 100% duty cycle is supported and produces a constant high output.
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
+		writel(0, axpwm->base + AXIADO_PWM_CTRL_REG);
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
+		.name =  "axiado-pwm",
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

