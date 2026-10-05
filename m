Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020107.outbound.protection.outlook.com [52.101.85.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF13830F958;
	Mon,  5 Oct 2026 07:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791186446; cv=fail; b=FxFVMkO57nj7fY0IVcDK0eQzH7pI4Pgshile8+J6Cf+bjxoWh53QHRhiwozyIW+TUsFYQQGOv9jXE30nc9x/X1EQiqM/QOtP3SmsODxBe7A+NcbqghAURkx2DCxPUKieqmL0CACmQA9oyIbkAZK+dOJx1AGg30WlEarqVoc1Dmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791186446; c=relaxed/simple;
	bh=DFJLmKx0f/mjLfXXD69Um/nN1GSR3JcyN3JjiLmQups=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Axm+e28O+ItfNDPL9WBlX8F6Fpz4fmyd7Il7+BAvoflFpYwQhcFD7zkbQ2MPYiMSTVQaZHI4zSjrZRe9RC+Hxwn46cDf1pQkhyhBU1U/GdJy9w4E+gmfNTC8cZFCUibMjfG6kRaeCkE4sq6HjR8JOaQmxYLjmw+HGKLxLDczaho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=Spi7KV3P; arc=fail smtp.client-ip=52.101.85.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="Spi7KV3P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlX3r6e/c312mrxinR6zIq6EcazcZaNDkxy1DgN05CSVWtiaL7hGlRpzulZDPC7cOhqvhvUT6pn+lm+1VrfC2nyrMfI4+9pSJb9ile0LDChnrflZGiBIBnGctgTc4d+UMfBFL2U7KmuHUBl02FYs1Bm5SMxNb8Ed2MO3g3tRYJ3hqKrxDZzxRpVjX06LPu6SckU4cmucmQy0K1PsSunx33fbOhDZZeVZC88KXrBzF9gdN/hCBsbe+txi6DqTq3322unYwT6yivALOch2qrylwjReMUb95pLxp3T/o7YEpvpzdFAzF3hZA7Ttxzx+mAE2iYi2fN3fQ51BGhZpRNrqIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJWgUCsqljP0ol08yXGs+3jDabtC5gQtc88IKgNrPgw=;
 b=Y13RrUdaHRzOmDPJWRjH7yijWqF9TV1ChdF2cKn+T176m/H2YcZu5cHJxFSRF52uv0oqqu8D8vDRrelPstLLKmxzHwlOlPVigz0C7dOmWEKdH+vGSk2UEDqT8GJar/5MZnNwmeaNoQpOpCVnM61UWaxVF5ByIEPZeOZW7fhy8sdJOzjXcfP4eV3iLqfXr4sWGsYwwWkb9nj97JOlWqBG68Pb9VuRuvja2y5ZIeyR60uUT6a28/OsLyFMWE3YBX+IxRCeflSjUAcYtmfaWDjQauRIRMmVWpD6CPJmYqnezHCrcybY2bvky7a2MkWZgU9mhGzWHUQEg/cToYj6m7tZYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJWgUCsqljP0ol08yXGs+3jDabtC5gQtc88IKgNrPgw=;
 b=Spi7KV3PX38m/CoVM0KngE1d5lviFG3nc5GWsWjLVgsTPmOcIdbER7uJOazHtXMUrgrIJZFCdeBGw3/p/65soXdNclSIvMPttu5sam+mqk6QCuNM0j99dhVGJwGlC6wUSJNcyWfmFCzbcyu8EkjdtQym9H7z4OCpe0aqjMJ5Dc7T6t8whGB7klKrEMyF1OGFuNavFHLCfm/A35kLN5KBNNRD7ONAAx72bBptIRgzkTFlJnq782AQ8bkTHUZbrxwMP04sjNxn6Qq9GWSIQIv4Z6HHK+YvjWinfssaS3OtlFlayiawPqwJ2uKnnVhVaujELF0ujjrl09sNHW4az2DZwA==
Received: from DS1PR04CA0020.namprd04.prod.outlook.com (2603:10b6:8:243::14)
 by CY2PR18MB287616.namprd18.prod.outlook.com (2603:10b6:930:117::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Mon, 5 Oct
 2026 07:47:20 +0000
Received: from DS1PEPF00053450.namprd04.prod.outlook.com
 (2603:10b6:8:243:cafe::70) by DS1PR04CA0020.outlook.office365.com
 (2603:10b6:8:243::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 07:47:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 64.62.143.114) smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 DS1PEPF00053450.mail.protection.outlook.com (10.167.23.232) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Mon, 5 Oct 2026 07:47:20 +0000
Received: from axz-uw1-build-vm02.corp.axiado.com (unknown [10.14.1.22])
	by smtp.corp.axiado.com (Postfix) with ESMTP id 64E044186B59;
	Mon,  5 Oct 2026 00:47:19 -0700 (PDT)
From: Petar Stepanovic <pstepanovic@axiado.com>
Date: Mon, 05 Oct 2026 00:46:10 -0700
Subject: [PATCH v6 2/2] pwm: add Axiado AX3000 PWM driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-axiado-ax3000-pwm-v6-2-7feecd0087e4@axiado.com>
References: <20261005-axiado-ax3000-pwm-v6-0-7feecd0087e4@axiado.com>
In-Reply-To: <20261005-axiado-ax3000-pwm-v6-0-7feecd0087e4@axiado.com>
To: Akhila Kavi <akavi@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 openbmc@lists.ozlabs.org, Petar Stepanovic <pstepanovic@axiado.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791186439; l=10801;
 i=pstepanovic@axiado.com; s=20250916; h=from:subject:message-id;
 bh=DFJLmKx0f/mjLfXXD69Um/nN1GSR3JcyN3JjiLmQups=;
 b=HdjLAI9HPvwhdbIp3CwsMQqVb0m26PYEFc2QZYc5yhHEodch7VoTAIcE76TGOOKLdnW+tbWmo
 gMHEKi6uq4RAavcj2dE3TKHxOiDzOBMqPTHzNNpxCiIC2ZXPtHg+ktV
X-Developer-Key: i=pstepanovic@axiado.com; a=ed25519;
 pk=70f1UJOGT9U11ZK6o+ENXtv0I5wBE3e+Y9YWODzRsdI=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00053450:EE_|CY2PR18MB287616:EE_
X-MS-Office365-Filtering-Correlation-Id: 06352697-cafa-4aaa-07df-08df22b4e2e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|6133799003|56012099006|10067099003|3023799007|22082099003|18002099003|260925021311599003|260925022911599003|260925021911599003;
X-Microsoft-Antispam-Message-Info:
	ac6Z2op0VrfKMSjBQtuvOLJBluB9z/8r7AS56wyEpnAj3kzLQHDHOVPCcrWPW9Tns/OADSAzssszNqlKI2lzTjXpDigRHPQ5RzVAsysxHgb/JK1Jf/x13Wa/MWEbOrYGa9Q53L8aejPL0esusAbNXUZfeqBpLyrMSx/hHzHewiZ7+3Oy/WguzSHiu7CpM4FmNmD0NThm4KZWgjKfBcX+NHMUx48Onx4AwHqXw+Sw8yisq9RVIg1D2Fx/9ZsGcLZtJ1mlt7k3SCtvL4dlvTn2rEj3LswT5kHPYJqZ6l9ifuw3jPOJK+g8mww4NrfIkUKY/QsBUW1WOnZnUrr5mGdixQ4qacEQjXmiFmBENcHWG9rnXSNgEJrGKwadtVPTyzINoAIUSBYCxT8Q89PqBSFXua97EUG0t7KGXZ1TcxnGXDqRBkvG6lR1NilmQiEB96bjfBwX3/aEAWIfA5LkrKW50BNA5/FRtxinw6Ulp4R8H2Od+kS9S/bbSkGnL5XizjM7qMg9JRxQ27dp9Xg/8iSzvDs08rnQqc6Z6GOgsbzQdRawFFfRSBzxvKZJaNQc/l1T9r4QbCjUpv4gdWW3lvOrCuTktx1aZbaliO5S9P4cynjdZxlgk+a7eYSt7tu0pLesMRUOHuhzDAJUhUflvl5rw/OPVvZJwacHhIlSSbQF06hD9JBDxkfLM8XNR2tq0vlH43S5rIBccwSJDy/m+8s3UQ==
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(6133799003)(56012099006)(10067099003)(3023799007)(22082099003)(18002099003)(260925021311599003)(260925022911599003)(260925021911599003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PsY6wKWnDVXKzrF6PeYu5Gx/F17ts/q9VSbAuyOOfABbVIM5aekp/C7W/XKGd4EBQjtW9g75mz5WwGyeSPIpl8NUcpXqnXeFTbqUneg4leaauR2WdCFqgNNQqjDXv/9MR+h2T89ZTC7UP7e5T0HECmf7jRhuG/vKmuJMuKgu4+8mx2efyxXKDtLrB3c+jFwZXsyYJua85zwYBhiKzIKfty8/0s3iqic0b0yox4srOOA58OehXMFG4pKO/jO229r0fG75GewQEhjdFVXHHSdJ07N1iB+HDIyl4UXrAFXfULHonA9IS2gL3wiX7DXTk/InMCBGrUIVOXunghE46pfmh1bfMpx/TrNohsAZmG21TvAEZ0cCzite0EKxfimpgQmbFRc+G7XlCW09LzZH976F85MkhIFykzRef/OsmYjCnj3eR3lpFCpt4u8nPbJ6eyy2
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 07:47:20.2004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06352697-cafa-4aaa-07df-08df22b4e2e5
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00053450.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY2PR18MB287616

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
 drivers/pwm/pwm-axiado.c | 282 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 295 insertions(+)

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
index 000000000000..08ae3d8ed4bb
--- /dev/null
+++ b/drivers/pwm/pwm-axiado.c
@@ -0,0 +1,282 @@
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
+	if (!duty) {
+		if (period == AXIADO_PWM_PERIOD_CONST_LOW)
+			period = AXIADO_PWM_PERIOD_MAX;
+
+		duty = period;
+	} else if (period == AXIADO_PWM_PERIOD_CONST_LOW) {
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

