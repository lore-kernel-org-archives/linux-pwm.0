Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020085.outbound.protection.outlook.com [52.101.193.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AED38B14F;
	Thu, 23 Jul 2026 09:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784799161; cv=fail; b=JmtuzldRB0aOIBANT0NF8D6dyj0Bgvdvk2KegAmz4APhiFS3+6M26DC+Z73qfkk8d5f7EnxD3Hb5d55LWKoTJJT57ouaUG1ilDdC4BMBoZSwQmQqYeHTJBq27qDyLz3A9O5QaPlUy4hSrf8CNY5tvmvgyv8ar37bw3pn3Xm+XRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784799161; c=relaxed/simple;
	bh=W37xQPVulbP9rcXA0r/phSaj7uYYnRvIEWgM94VOzgs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=unsNiwQE7qaUq/YDWJM+OT3/wj6qDEP9O+F79kVydIhoyx6dtGrPAP6n/MmEwpGiVvuatwASCakucbJBR00NgCUQ7+KBVoDi4sAvLjqAE0tOktT4cUjIFzqkUamyb4109+7ubgm4lL2365IyKEUo6Vl0VzSs91eVk71oEUJV+gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=pkSoTHR8; arc=fail smtp.client-ip=52.101.193.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="pkSoTHR8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GW7dGeIWCc4kYrVlS76OcrXeuWtsqDP/avEj1+PW+It+A/5mxDNErdLFyjlf8f1ygExDkWEHfW34QeP/SE8LNdgPjczx222yMforZwvPjN5qyZ2O9NlSnEwAXpI8l3BRvBg7n7zBBlpO4ji3CD4rXBCPyNBrHL/uLk5THrZuaJ1fyFS/E01bLAMR3wlLO1A8xf/gntVFM/sefDV43yR9LoIypHysZDNFjLcG9ky83ETnXx2ouDTQr8+xoapoB//CNGzkqw7q9ikMfTLYG5wtg/6VBQbpUAteKn4x8/G83YvazSjdTQCrBVIVP+3dwqsRZyqJ7BxWIdJp/D/x1g0Bmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rw4RCblj0J1ioFipbty0zY5pA+JDxHgEZFRSzvGtEE8=;
 b=IcJpiSZu6gS7PPyUs/2OZpjSMkVM32KYumG9DPc/NVxOIdEG+p9sOgIlz84i2QwYne/RYFx1IAR5bCtjeBNmuOOORa5k9lAVbFzYKJnS+jlnCBoOCj67TY9Yx1ZFsywqooTtuVfh6adwSN6PAwvBHrLS6dotGns3TEkrgE6HhnpI92332HGsqnIcxxw4Nt+6rE+KtIQKnDvODWj0CG9VIuo0p99zklXVJlJM4tjUKsvTYU0AMcr2qiDS88Y4hFjVroCibsdBWOGufjN4z2JdfFkyAQUYABQApgyfl6BBs7Sn2t7yxZh23JER+ZmIr0iRv3ZGyKTHixD60jG3lIj3Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rw4RCblj0J1ioFipbty0zY5pA+JDxHgEZFRSzvGtEE8=;
 b=pkSoTHR8uxsGWGf+6WZV+2Kl3YRKcAXJUY6/ckMXmefosBgtN55RQSOFIx2l9Iyf7FQ54PsAho0AT5/P5hKn4GUkho25TnaWNouvze6K+pgb0eZLemNMjj0nLMV74Bft958T+/WFhNTqOrfzGI68BsMr+hdGDE+kme+y3E27LLYafMyf/I4HfSGcWKZaEXS7+FvSJx4eP3Jpb59/UvAV6hvioujkmYkK9KCex5ZI/lq1r5+5XgVrjvdiT5FjOME5YWfcO9JPBCDbNQrNo4kxEt/ab9yQOemnIKR0Qukf+mxWXAw+CNA3quLc3+HMnwqf0a2EJNSNtwUoK5IlKJ1V0A==
Received: from DM6PR03CA0099.namprd03.prod.outlook.com (2603:10b6:5:333::32)
 by DM4PR18MB5425.namprd18.prod.outlook.com (2603:10b6:8:17e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 09:32:34 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:5:333:cafe::3c) by DM6PR03CA0099.outlook.office365.com
 (2603:10b6:5:333::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend
 Transport; Thu, 23 Jul 2026 09:32:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5
 via Frontend Transport; Thu, 23 Jul 2026 09:32:33 +0000
Received: from axz-uw1-build-vm02.corp.axiado.com (unknown [10.14.1.22])
	by smtp.corp.axiado.com (Postfix) with ESMTP id 509DE4186B59;
	Thu, 23 Jul 2026 02:32:33 -0700 (PDT)
From: Petar Stepanovic <pstepanovic@axiado.com>
Date: Thu, 23 Jul 2026 02:32:19 -0700
Subject: [PATCH v2 2/2] pwm: add Axiado AX3000 PWM driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-axiado-ax3000-pwm-v2-2-22002f0b281d@axiado.com>
References: <20260723-axiado-ax3000-pwm-v2-0-22002f0b281d@axiado.com>
In-Reply-To: <20260723-axiado-ax3000-pwm-v2-0-22002f0b281d@axiado.com>
To: Akhila Kavi <akavi@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Petar Stepanovic <pstepanovic@axiado.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784799153; l=9950;
 i=pstepanovic@axiado.com; s=20250916; h=from:subject:message-id;
 bh=W37xQPVulbP9rcXA0r/phSaj7uYYnRvIEWgM94VOzgs=;
 b=bg1pSz1/WDZmb+IINErqorlDFkhFR1BI0/qrrwaYfczaxTHON1nxp/L2NHha0ARlCrF07x4xP
 Eh7Gh15XcFHCEaHSJ7cYzm93Ngyp65hGC7hIeuIPsL59xBGDiR81TrZ
X-Developer-Key: i=pstepanovic@axiado.com; a=ed25519;
 pk=70f1UJOGT9U11ZK6o+ENXtv0I5wBE3e+Y9YWODzRsdI=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|DM4PR18MB5425:EE_
X-MS-Office365-Filtering-Correlation-Id: b3f2a9ef-ae73-4529-7137-08dee89d5376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|6133799003|56012099006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	/uRgpHETDxRmGU1WgJm4l1YjPd1dL5EHnwdWeOOIkYX/fx/ivMv8AOCm4+OCKyWz/ChNE+eTWE2+DcAuZzMzCHMSlnapTW65P2BjeqtHPNu7a2VCksSk21mllqpK1I7oi6loRX79lRKXzF15gtgllrr1rWowa+MaGPEUyMY1rIHn1v2MctOB1YETuXs8ZZnoXuIzhFclPPMIxLRVUOrq2ZWp76ZrHy1Clo0ck+C9bWC6Ea7+ODl6egag3EhQPLcb5dZDmPk/V+RJdGEyFU1B2f4E4ZG+Qa8bPfVmKFh3v8HyF2akOMYEnxCMcKMtBKWMTLF9gfDyRyj6ZKy2wAoJ3qrThwXr3M4bs1TudeA7veNkKxNkFnKtswSm4H5BbhFO53i89aGTIFD3Y9MJWausJb5A2jIwFkLRjlGez5UqptPau/NaZqxU27xPTpZpB4NnWOVEHBnHOPf6BpxbxS9hmpqPiXsvaWXmRdF2opYexutgbXYmYM9hf18xp4n+oAX4tUUNEzEIxgvP7S/9T7i3/VSOuGbTamaAiLBR9sylwaQspuvcvFsXMrH7tFnW/VmBWRyFVCc4z65/vzMYyxL5dRuZ2SOrPV3D//Pi/bgvWQHOMtL+nj541qPmdxWCpP7TlgZ7GnUz+00qw9zIVRxlZ1DI0eMbhZ/yoCAkmqIs8YYtcmGGPuGUjP62270mncyqVoXIL+9Daxa8CjOHGp7Dhw==
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	agvS0OopIFnxz88WAdvssj1JQj2C8kfdh8xzTyJATlYNaeyTxuqgIfSfjCBM+odkGHcUkFMVMq7uyB4BGnz6DsP6YLCes0zQGbpwsKp4zddeSSXtMc+qo2k+oodEMlpthA6tFMVFpWq7nk1M8ifaC2sybaRTjtW0/QrGcTDQPl6RQNIbiFVAAABxIciH+ko66EtDxCRuxLmRzsXyrMIuS0QrM0fkSPLU9P4nRL/9MwpmcF142JicmDs8oB3I6Rhqac5jwXjg/hPPW0OnlU6yt/ZbbQ+y/arMyAuee73uEpzkiUSrIlOT6pRROAlKgD54iJqDyTgG16fmZTbNp/m6E/k1eRVDwuojcO0BwhLRgMvLms9a1Wwtm+4ONrakfBVvwWEMU7qnbvTHRzc7N/sFN2w18rDsY594PqN7ziVwFY4SQQnd8AJlsw8TtXuNyIcO
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 09:32:33.9712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f2a9ef-ae73-4529-7137-08dee89d5376
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB5425

The Axiado AX3000 and AX3005 SoCs include PWM controllers that can be
used to generate configurable PWM output signals.

Add a PWM driver with support for configuring period, duty cycle, and
enable state through the Linux PWM framework.

Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>
---
 MAINTAINERS              |   1 +
 drivers/pwm/Kconfig      |  11 ++
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-axiado.c | 272 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 285 insertions(+)

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
index 000000000000..f9932646ae04
--- /dev/null
+++ b/drivers/pwm/pwm-axiado.c
@@ -0,0 +1,272 @@
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
+ *   cycles. Longer periods are rounded down to the maximum.
+ * - A 0% duty cycle is not supported. Programming a zero high time produces
+ *   a constant high output, so the driver rejects 0% duty-cycle requests.
+ * - A 100% duty cycle is supported and produces a constant high output.
+ */
+
+#include <linux/bits.h>
+#include <linux/clk.h>
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
+		*wfhw = (struct axiado_pwm_waveform) {};
+
+		return 0;
+	}
+
+	/* The hardware cannot generate a 0% duty cycle. */
+	if (!wf->duty_length_ns)
+		return -EINVAL;
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
+	 * A positive duty request can round down to zero clock cycles.
+	 * Round it up to the minimum supported high time.
+	 */
+	if (duty < AXIADO_PWM_DUTY_MIN) {
+		duty = AXIADO_PWM_DUTY_MIN;
+		ret = 1;
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
+	{ .compatible = "axiado,ax3005-pwm" },
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
+
+module_platform_driver(axiado_pwm_driver);
+MODULE_AUTHOR("Axiado Corporation");
+MODULE_DESCRIPTION("Axiado PWM driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1

