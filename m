Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2109.outbound.protection.partner.outlook.cn [139.219.146.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD47E3546E2;
	Mon, 10 Aug 2026 03:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786331267; cv=fail; b=phQY5ORvavr3iYGi/DjonY6pCW38js+jjHeh8B0JFcQRhrtObBffda0jT14i2vqL5F1Gd2uDy+I/T8FvnMbYhpCzDwd/t3ZzZrIJa5xp8Cym5S4JlpYpiE8upLwRCqfX88H5TopVMviT/gSrVyhuzN9Xs8jkY55W7910VDsISlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786331267; c=relaxed/simple;
	bh=xe2BokszOoLPsV55r1ZVt9wBoC217i40GFDl6hqtW/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=obatGTew6rpcmBp4zGRTohGcSWiN9XP9fCgTOFVSuJCPaFbZBYWVPtFJCqO6+rM1OpcmtnBkRAoAGxhaFNrfa9RtVJSGFW2Q+6xi8tvPyCcvbftaYxw6p2RssSSU+XggTiFiNb14dogrJVSWQpy7z60FW1IYC4J1LUkhCk1E+R4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVVczv/lRrOoGIZi2e3jDJyL18Rm4qYRK+f8GL1bNCPHm4w3dxXPajizgT6DMych5vevfM6XoohfaUcceXV7udpMsAooIVxndaXqoIdzoWZYJ+xdfDKwCLhZxWxYFwU6rWhtIAuiqETzU1yyfaq86CtPKwevmt/GZapUQTP9FKiYs3WW+w3u4d7bC+KtyO4ZSQ3t0cNGbHSPiFU84ul3RrMScr9+FV1YLO+fhZ2keI7v2/UKErD2G7JrQc0V6PSbioHC5923vc5N6yeUjssgPeCmirwFTu0XBm+kqoKKjUZowo7xuCf9Tx7icPBod6yEwOMJ8vq1C5zYgoFRrvXJtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WeDj00TOONfeQWtoVASJYWljf1b3PlepuVPybriBf8w=;
 b=T7AbvPlPshRcRjlsg0ipwW3IR4NoKh4EEInffyDBoGGyl7Er3hdkA2n1G56/cboz4lOlTD4rMIJ1tvUCn0LyMIeZBG2kVzarXBNNS73MJ0l/34yvCEy+rPK2W2USSQM4YFOs1bfsHj1CgXuF1dEcha1WgoeRIA6U1zcqFgI+oROf2W27D/dbKGhPpnCqOhry+fyd+YXETa+RzHtuGPLlkwR/8U27BfIcUc7oUZf/T9PgpoLL+PrzSMnEgKa7jwEDgfaB8xV164udtViHuxOcqCm/EZrDJFwbSnpamapcNU2hzytkwPMXL+8XxpJe2VDxWjL3E+iSGxpzswxexG5pjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1178.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 03:07:24 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::4386:5cc4:3bc4:4795]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::4386:5cc4:3bc4:4795%3])
 with mapi id 15.21.0292.024; Mon, 10 Aug 2026 03:07:24 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND v22 3/3] pwm: Add OpenCores PTC PWM driver
Date: Mon, 10 Aug 2026 11:07:14 +0800
Message-ID: <20260810030714.48100-4-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20260810030714.48100-1-hal.feng@starfivetech.com>
References: <20260810030714.48100-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0014.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::19) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1178:EE_
X-MS-Office365-Filtering-Correlation-Id: 10b36feb-0066-41a1-be4b-08def68c806d
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|23010399003|366016|1800799024|38350700014|13003099007|22082099003|18002099003|56012099006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	yQaFHtIzX6dPvLiiRNyzB9lQJpeFY5bJATInwwtwxf8ioFDVt325zE90GIYzqFZYR+YTy3W2eH8r5TH0brGwykwguzsmuvlJByrulVYoBGxL1HnQ870WKipxhw9+ObtKsYjDQNczuSEjxBewQPJXUfNj6lEG8S7SPvOLlYIjgdZ1M1Z6Nw1Y9p29vIbEZzdq39lXk7im6R0iLZj2D2MNUvTx96mZ6vfIpj5uVV0SLc+loKN5XVrPAKj0acTUQDRgxDfsDakT10LqzB7re7EXvebWQC0x9hmNCiS4dxZZznxxarkGPeIa0aQKifFn7mCG4WFD5S9Ga9Gs98U12Kz00ZxuDS2Qx523v07ZE47Npjz3C+OmA9cAYdo314ODQ3EJ0i9JjuRFKRodJEGFDErG75XSr0LOKvvC73MfXLYuFymQhAZEbhQtMoPqltA8deBPjNimZlCmAekMgYN73v1J0rpK1Of9f7eD7b+Ra9sANG0hFrTWb5/r13iY0Fhqn7zB2Dlaahjldn3VcVh7YEvDM3tM9L6cS20eyH+toSUizwioG4NVj2SApSpm4RrVTHCs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(23010399003)(366016)(1800799024)(38350700014)(13003099007)(22082099003)(18002099003)(56012099006)(10067099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?58J9T4AoJXHQLd0Wh362Zetul0oNP9GJGTOG5On52f9Ba1JLRAujvd6hbMIK?=
 =?us-ascii?Q?jOpMhUjucv7TCxuzjPCmn+D0oqwljkyJxS7bUUVkhrWUlbE3VrbLGXOyLXi7?=
 =?us-ascii?Q?eOQteUU531vGHtGCArHU9Y/EGjP4tM6TqTVSc2dcKS5T5o0WO78A0mBGiB/8?=
 =?us-ascii?Q?uCCM7S1hSharX5ZqNJlDPuvWxup3FMWGE0UJ5uvF7nfA24GOFWKQ7hwujEqz?=
 =?us-ascii?Q?aauv+5QA72hVdQeAjLasrTmN6dwhpxJ2Z0orrDBWLBuWQlWwQyChjZZDysI5?=
 =?us-ascii?Q?ahKps/fNLBwKO5PlweIIWM0lUSVq9Vjk2wtuv+Rlyq3TAH5KiQ13DtGV5dPh?=
 =?us-ascii?Q?FQ0hQkcARjSg3NmCLdRYj0sOjiqBbZARV8Np0qQSLKwArsv1HpDa5lxBgXyq?=
 =?us-ascii?Q?IdZKArL9Co7XRiptw0F8YEoCWd1oHkYgpCBRvtBm9D9fElUXxMaMG4CA4NPZ?=
 =?us-ascii?Q?PCz13s2GhAUjCeSlksi14sFfdgNRN0BIECdfyhJJfCABGHcc934QtY4/flCz?=
 =?us-ascii?Q?f7Zgk+mtOfklS52NzWz0WMESsdhmqUGvdtccd3XjGWr82+DeteWSMfUFYVvr?=
 =?us-ascii?Q?009r6t45rMrTC3CXWvW8Bc1x6Nefc3v3Be4HnoH4njcY7SzGYVMSWynaeDXa?=
 =?us-ascii?Q?SWL/86omMADgCKt8NrIcC+8PX/mXF7SfveTP57W1iCdtzUpHUi5/GAYLhQYe?=
 =?us-ascii?Q?FsBuhC5ed5O3o0m8SWlNLQ3haLZ9EZLR9g97NCFjnL/KjceNF+UU7WPySRAU?=
 =?us-ascii?Q?lBHKLC7kXXzJDIPnq07oY3QZoeE0ehsHtd+iBVlUAK62V0JabZN5ienztwOt?=
 =?us-ascii?Q?Rt5uKno6Bbu31gVWA9rvxzgpLRX3JNL7J7vUKLjTbbmefsNVVRZa5MF/PvVS?=
 =?us-ascii?Q?1KFvIxUOBxtE5CJI3PM4F/o9CnJMQHrCglAiGReaw3H0YiLoxo+pnTk/rEuU?=
 =?us-ascii?Q?AuKdykYO5SlvBsLyM85d9vtdipi3nfVPzLLVRJYF6Cy+Ll9qWIjxs8vbt2u+?=
 =?us-ascii?Q?ADnmBhv9DlJmmkqJKM3BiMvKluzjCzFV54s2OI81aALjK/ufFiaPrdJECawQ?=
 =?us-ascii?Q?LYz4g/FkrJghGGfY3FZTMhPkwaw8KD8KGrAwWNeArX90paAXw59O9ye4AgNq?=
 =?us-ascii?Q?1z9EbzHYyihwi9KN31J0ZeeoqdWXFkNOMBB7m/VTakdvvRWCq5H5p2E/1eJm?=
 =?us-ascii?Q?KLyTiIB44MXRwJR/hkBGX3uugpXnlSGTs0g7KP0Ag6CB8InSzwXsWEmRlhYB?=
 =?us-ascii?Q?apbbOIhivP36KpU3bcV2US/uv/cf6WdXLdcFB8h2YHJ3Rhld+4kqm56I4xMH?=
 =?us-ascii?Q?Yr0cWcz26eACIdsmjiTJMiwHlUHNawFPt6PWg4SIDHV2SnkLGc6QJY01Te1O?=
 =?us-ascii?Q?pmUwasr4n7WEZb6/uN4pxko/xpqnhjxJgzTYvSeUkVL1IFnF0HDzRuSjBDzP?=
 =?us-ascii?Q?mOnz6CxCb+as/zy1hepn59hG1CBRrX5E3IvwpIMENqnMCNiK+y6iVzbmeN3i?=
 =?us-ascii?Q?3xzTES13scGBRPaAhzF17axpUN/UGxTzAG2yZjHJsN0VTwRjWqaQvRIyZKY+?=
 =?us-ascii?Q?O2XEXFtDo85+6/RZQ3ewjcjs0oJnT2vM2ZjqToZs2oTNHo+AIQan3yLAEYku?=
 =?us-ascii?Q?VbyiMZi11haGGry52T6jctADo0Y+1wM7HEVk20G3FNoe3V3GAEtHsqHBBeFf?=
 =?us-ascii?Q?Jy9ucJWdWsoAnx0NSk2ZF+3nilR/4e9MsK7M4ZybC6Lpm7qN75QorRqAU90J?=
 =?us-ascii?Q?QN66t2lFEg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b36feb-0066-41a1-be4b-08def68c806d
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 03:07:24.4718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I4jBmxNq0Obh+c/qHOzOBMrY+ZZymfgSz6MQ3ng2uUJUXgKG+v/YJrWQgU2VUIGBNaR0WCpvVPz4BqGh6XE92SG3FDDqCwSYCnk+H8dwuMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1178

Add PWM driver for OpenCores PTC IP core.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 MAINTAINERS              |   6 +
 drivers/pwm/Kconfig      |  12 ++
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-ocores.c | 298 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 317 insertions(+)
 create mode 100644 drivers/pwm/pwm-ocores.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8014b9f8253e..7886fd9a4ac0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20273,6 +20273,12 @@ F:	Documentation/i2c/busses/i2c-ocores.rst
 F:	drivers/i2c/busses/i2c-ocores.c
 F:	include/linux/platform_data/i2c-ocores.h
 
+OPENCORES PWM DRIVER
+M:	Hal Feng <hal.feng@starfivetech.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
+F:	drivers/pwm/pwm-ocores.c
+
 OPENRISC ARCHITECTURE
 M:	Jonas Bonn <jonas@southpole.se>
 M:	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index e8886a9b64d9..1268c07d07f1 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -546,6 +546,18 @@ config PWM_NTXEC
 	  controller found in certain e-book readers designed by the original
 	  design manufacturer Netronix.
 
+config PWM_OCORES
+	tristate "OpenCores PTC PWM support"
+	depends on HAS_IOMEM && OF
+	depends on COMMON_CLK
+	depends on ARCH_STARFIVE || COMPILE_TEST
+	help
+	  PWM driver for OpenCores PTC IP core.
+	  For details see https://opencores.org/projects/ptc.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-ocores.
+
 config PWM_OMAP_DMTIMER
 	tristate "OMAP Dual-Mode Timer PWM support"
 	depends on OF
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 5630a521a7cf..4d2d14c4852f 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_PWM_MICROCHIP_CORE)	+= pwm-microchip-core.o
 obj-$(CONFIG_PWM_MTK_DISP)	+= pwm-mtk-disp.o
 obj-$(CONFIG_PWM_MXS)		+= pwm-mxs.o
 obj-$(CONFIG_PWM_NTXEC)		+= pwm-ntxec.o
+obj-$(CONFIG_PWM_OCORES)	+= pwm-ocores.o
 obj-$(CONFIG_PWM_OMAP_DMTIMER)	+= pwm-omap-dmtimer.o
 obj-$(CONFIG_PWM_PCA9685)	+= pwm-pca9685.o
 obj-$(CONFIG_PWM_PXA)		+= pwm-pxa.o
diff --git a/drivers/pwm/pwm-ocores.c b/drivers/pwm/pwm-ocores.c
new file mode 100644
index 000000000000..f873089a385b
--- /dev/null
+++ b/drivers/pwm/pwm-ocores.c
@@ -0,0 +1,298 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * OpenCores PTC PWM Driver
+ *
+ * https://opencores.org/projects/ptc
+ *
+ * Copyright (C) 2018-2026 StarFive Technology Co., Ltd.
+ *
+ * Limitations:
+ * - The hardware only supports inverted polarity.
+ * - The hardware minimum period / non-zero duty_cycle is (1 / pwm_apb clock frequency).
+ * - The hardware maximum period / duty_cycle of PWM is (U32_MAX / pwm_apb clock frequency).
+ * - The output is immediately set to low when the module is disabled.
+ */
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/pwm.h>
+#include <linux/reset.h>
+
+#define OCPWM_HRC	0x4
+#define OCPWM_LRC	0x8
+#define OCPWM_CTRL	0xC
+
+#define OCPWM_CTRL_EN	BIT(0)
+#define OCPWM_CTRL_OE	BIT(3)
+#define OCPWM_CTRL_RST	BIT(7)
+
+#define OCPWM_NUM_SAVED_REGS	3
+
+struct ocores_pwm_device {
+	void __iomem *base;
+	struct clk *clk;
+	unsigned long clk_rate;
+	struct reset_control *rst;
+	u32 saved_regs[OCPWM_NUM_SAVED_REGS];
+};
+
+static int ocores_pwm_get_state(struct pwm_chip *chip,
+				struct pwm_device *pwm,
+				struct pwm_state *state)
+{
+	struct ocores_pwm_device *ddata = pwmchip_get_drvdata(chip);
+	u32 period_data, duty_data, ctrl_data;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(pwmchip_parent(chip));
+	if (ret < 0)
+		return ret;
+
+	period_data = readl(ddata->base + OCPWM_LRC);
+	duty_data = readl(ddata->base + OCPWM_HRC);
+	ctrl_data = readl(ddata->base + OCPWM_CTRL);
+
+	state->period = DIV_ROUND_UP_ULL((u64)period_data * NSEC_PER_SEC, ddata->clk_rate);
+	state->duty_cycle = DIV_ROUND_UP_ULL((u64)duty_data * NSEC_PER_SEC, ddata->clk_rate);
+	if (state->duty_cycle > state->period)
+		state->duty_cycle = state->period;
+
+	state->polarity = PWM_POLARITY_INVERSED;
+	state->enabled = (ctrl_data & OCPWM_CTRL_EN) ? true : false;
+
+	pm_runtime_put(pwmchip_parent(chip));
+
+	return 0;
+}
+
+static int ocores_pwm_apply(struct pwm_chip *chip,
+			    struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	struct ocores_pwm_device *ddata = pwmchip_get_drvdata(chip);
+	bool was_enabled = pwm_is_enabled(pwm);
+	u64 period_data, duty_data;
+	int ret;
+
+	if (state->polarity != PWM_POLARITY_INVERSED)
+		return -EINVAL;
+
+	if (!state->enabled) {
+		if (was_enabled) {
+			writel(0, ddata->base + OCPWM_CTRL);
+			pm_runtime_put(pwmchip_parent(chip));
+		}
+		return 0;
+	}
+
+	period_data = mul_u64_u32_div(state->period, ddata->clk_rate, NSEC_PER_SEC);
+	if (period_data > U32_MAX)
+		period_data = U32_MAX;
+
+	duty_data = mul_u64_u32_div(state->duty_cycle, ddata->clk_rate, NSEC_PER_SEC);
+	if (duty_data > U32_MAX)
+		duty_data = U32_MAX;
+
+	if (!period_data)
+		return -EINVAL;
+
+	if (!was_enabled) {
+		ret = pm_runtime_resume_and_get(pwmchip_parent(chip));
+		if (ret < 0)
+			return ret;
+	}
+
+	writel(0, ddata->base + OCPWM_CTRL);
+	writel(OCPWM_CTRL_RST, ddata->base + OCPWM_CTRL);
+
+	writel(period_data, ddata->base + OCPWM_LRC);
+	writel(duty_data, ddata->base + OCPWM_HRC);
+	writel(OCPWM_CTRL_OE | OCPWM_CTRL_EN, ddata->base + OCPWM_CTRL);
+
+	return 0;
+}
+
+static const struct pwm_ops ocores_pwm_ops = {
+	.get_state = ocores_pwm_get_state,
+	.apply = ocores_pwm_apply,
+};
+
+static int ocores_pwm_runtime_suspend(struct device *dev)
+{
+	struct ocores_pwm_device *ddata = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(ddata->clk);
+
+	return 0;
+}
+
+static int ocores_pwm_runtime_resume(struct device *dev)
+{
+	struct ocores_pwm_device *ddata = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(ddata->clk);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable clock\n");
+
+	return 0;
+}
+
+static int __maybe_unused ocores_pwm_suspend(struct device *dev)
+{
+	struct ocores_pwm_device *ddata = dev_get_drvdata(dev);
+	int ret, i;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < OCPWM_NUM_SAVED_REGS; i++)
+		ddata->saved_regs[i] = readl(ddata->base + 4 + 4 * i);
+
+	pm_runtime_put_sync(dev);
+
+	return pm_runtime_force_suspend(dev);
+}
+
+static int __maybe_unused ocores_pwm_resume(struct device *dev)
+{
+	struct ocores_pwm_device *ddata = dev_get_drvdata(dev);
+	int ret, i;
+
+	ret = pm_runtime_force_resume(dev);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		return ret;
+
+	writel(0, ddata->base + OCPWM_CTRL);
+	writel(OCPWM_CTRL_RST, ddata->base + OCPWM_CTRL);
+	for (i = 0; i < OCPWM_NUM_SAVED_REGS; i++)
+		writel(ddata->saved_regs[i], ddata->base + 4 + 4 * i);
+
+	pm_runtime_put_sync(dev);
+
+	return 0;
+}
+
+static const struct dev_pm_ops ocores_pwm_pm_ops = {
+	RUNTIME_PM_OPS(ocores_pwm_runtime_suspend,
+		       ocores_pwm_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(ocores_pwm_suspend, ocores_pwm_resume)
+};
+
+static void ocores_pwm_pm_disable(void *data)
+{
+	struct device *dev = data;
+	struct ocores_pwm_device *ddata = dev_get_drvdata(dev);
+
+	pm_runtime_disable(dev);
+
+	if (!pm_runtime_status_suspended(dev)) {
+		/* Balance the reference held while the PWM is enabled. */
+		if (readl(ddata->base + OCPWM_CTRL) & OCPWM_CTRL_EN)
+			pm_runtime_put_noidle(dev);
+
+		ocores_pwm_runtime_suspend(dev);
+	}
+
+	reset_control_assert(ddata->rst);
+}
+
+static int ocores_pwm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ocores_pwm_device *ddata;
+	struct pwm_chip *chip;
+	int ret;
+
+	chip = devm_pwmchip_alloc(dev, 1, sizeof(*ddata));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	chip->ops = &ocores_pwm_ops;
+	ddata = pwmchip_get_drvdata(chip);
+
+	ddata->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ddata->base))
+		return dev_err_probe(dev, PTR_ERR(ddata->base),
+				     "Failed to map IO resources\n");
+
+	ddata->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(ddata->clk))
+		return dev_err_probe(dev, PTR_ERR(ddata->clk),
+				     "Failed to get clock\n");
+
+	ddata->clk_rate = clk_get_rate(ddata->clk);
+	if (!ddata->clk_rate || ddata->clk_rate > NSEC_PER_SEC)
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid clock rate: %lu\n", ddata->clk_rate);
+
+	ddata->rst = devm_reset_control_get_optional_shared(dev, NULL);
+	if (IS_ERR(ddata->rst))
+		return dev_err_probe(dev, PTR_ERR(ddata->rst),
+				     "Failed to get reset\n");
+
+	platform_set_drvdata(pdev, ddata);
+
+	ret = ocores_pwm_runtime_resume(dev);
+	if (ret)
+		return ret;
+
+	ret = reset_control_deassert(ddata->rst);
+	if (ret)
+		goto err_clk_disable;
+
+	ret = pm_runtime_set_active(dev);
+	if (ret)
+		goto err_reset_assert;
+
+	pm_runtime_get_noresume(dev);
+	pm_runtime_enable(dev);
+
+	if (!(readl(ddata->base + OCPWM_CTRL) & OCPWM_CTRL_EN))
+		pm_runtime_put_sync(dev);
+
+	ret = devm_add_action_or_reset(dev, ocores_pwm_pm_disable, dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add pm disable action\n");
+
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Could not register PWM chip\n");
+
+	return 0;
+
+err_reset_assert:
+	reset_control_assert(ddata->rst);
+err_clk_disable:
+	ocores_pwm_runtime_suspend(dev);
+	return dev_err_probe(dev, ret, "Failed to init pwm power\n");
+}
+
+static const struct of_device_id ocores_pwm_of_match[] = {
+	{ .compatible = "opencores,pwm-v1" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ocores_pwm_of_match);
+
+static struct platform_driver ocores_pwm_driver = {
+	.probe = ocores_pwm_probe,
+	.driver = {
+		.name = "ocores-pwm",
+		.of_match_table = ocores_pwm_of_match,
+		.pm = pm_ptr(&ocores_pwm_pm_ops),
+	},
+};
+module_platform_driver(ocores_pwm_driver);
+
+MODULE_AUTHOR("Jieqin Chen");
+MODULE_AUTHOR("Hal Feng <hal.feng@starfivetech.com>");
+MODULE_DESCRIPTION("OpenCores PTC PWM driver");
+MODULE_LICENSE("GPL");
-- 
2.43.2

