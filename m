Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2098.outbound.protection.partner.outlook.cn [139.219.17.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EC64FD798;
	Wed, 14 Oct 2026 11:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791975911; cv=fail; b=j1bD7fJekFD4N0CMRmNBYanW7+MbREuG5ETera6Bb71onItZ/1eO3d/09OqVEtAXe4asjYFWwr5AQtJ5Pppbjx7SD0vjFRMu8sHyaCLULU+AFtB3LV17CinAGryARgDC+GBegDP+MPYU4a02WMTewO888YrHLONiwqaAKBO6XRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791975911; c=relaxed/simple;
	bh=oYHTZHDkoWgP4Yw1fVH59n331sOSQyEWXe1uZSgardM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FSL6uDptIg8GMBYYzN6BPizGCIQ/mVsgvMHRxXS/qA4bOKrPFK2Pr3U1OBQausO27tGwa2SFBKyqKf8bWrLinkQARbULBDV5NCMnCzPrv1pNjvLucF58rJaIUwg3AEcYFE69Hyknk9uB2wL7k75B5aGwpFredLdMexINj+wK63Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n38zWkH4H63SF3x15c22TeL0W8LkxJaGRYq5c2asNgat/D17siyotgnNV9r6WWYQQN2yWnurXSGsWFIqsVm+KJjyhA/nPWJ9PhEO0kNXaj7kwJL2xDP3Yp1F82IGAQDhqpEmNWV+ieC6lXzzXqs2BxyfUsuqP8BhKaM1mMkLQ8BIaJeCPRWXvDCW8F+v5ORlK0Mcw5eh0WKxwb8OBdmWe9FnJgpgIgBif97ECVoWlDZdnWBlcQbZ5Yjxa1N6lJn4LeW3Puc6fu7gNVdg3JKf6rywna63X+K03IxzBW/aSbY9O23tY7sq8PwEMvUpcRde8EyDNVTY7Np3vrvWnFdxsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKQhdrARnYOPZxQLNWq5j8gQNNoUJaB+QRa4rD5zB5U=;
 b=L2g0NQsvMHwmRAHaBUanfgv70YlnuaQ//YDX3MAfLrMZqylAs/X/dCn4x8gXka68jA50oZMaKuF3uoHv03vu+k/CWVyBR/fTeSwX9EJglv9t2Xyl2daDSeAT3CTSyJp/E+rHNaxAnV1SEURlWIyIurxlNjMjgJDU5I2RDw+9ZCN2ww4tOsQXqc+tDjvhkwluUUO+GJADf4XKKmvqw/uIHki5RfO+UTLgPe4I2/hDtGS26DSSalVwHLYpAG3HBkA1Dhe7dR9YM1lVATGisZC30kPw+T8Y9wSy6XfB79Zmw3UlDv2dJbJ0JQ4D9pXNrkuWGEHnp7u79IhjvWBqrfOsjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:7::10) by NT0PR01MB1069.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 11:04:38 +0000
Received: from NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
 ([fe80::be4a:d29e:5188:b37e]) by
 NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn ([fe80::be4a:d29e:5188:b37e%3])
 with mapi id 15.21.0522.012; Wed, 14 Oct 2026 11:04:37 +0000
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
Subject: [PATCH v23 2/2] pwm: Add OpenCores PTC PWM driver
Date: Wed, 14 Oct 2026 19:04:29 +0800
Message-ID: <20261014110429.52762-3-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20261014110429.52762-1-hal.feng@starfivetech.com>
References: <20261014110429.52762-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0020.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::16) To NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:7::10)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1102:EE_|NT0PR01MB1069:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e01a7c2-7653-4cbc-585e-08df29e2f022
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|52116014|23010399003|38350700014|56012099006|13003099007|261009223027099003|261009221227099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	fIMC6ldWJOQg1SDVfF87kBmXm3IX8LT44KdUEJ3a+HA/Vi1EQQI+nPGWqpudxXfCAiTmpDqtgXlFR9SaRDdocNA1ZHgA15d4X21sibvMGqL1x/tVwU5nlsK+Zz/49SxliPTj3TisgO/6x+yiVriiV3nS7WmAgLsaVsHuwDZaIPlm6gqT7rQo2nLnKjmOdnH3dqTmhSYw0+FRkODuFSOJxfhivnApeYeU0gAm5HAd4hrxqZoSfttIsYFegZQUQxTYUWGDKc7TN6QXqz8xQnBA2CANjqAFbZMK2iG8hU91/wjezw9XhfYTeOoSbDM7qZF45Abk43edbBhRnMcKfSrpU2Swt39+TS1eAlKQyQEYUUu4zC8QUH9Vnwxhd+EuqREed2m7UpcFGdpgXh10HgEDVkyxpERlXhYTKhgFoRP+bobKht/0X/gfY3iHsN/UjpRdCYYnpaNyclvlEfG8N5TgQ7EKiQd6ymYDfC+s196UzKo2HPYC994TnNJOQoQ158LEsq3fGhlfLgw0FFnY8vpdeeRsiVj4QqXTXTscwmZ7uilWnUJg8GRvwFvBplBy5fJz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(52116014)(23010399003)(38350700014)(56012099006)(13003099007)(261009223027099003)(261009221227099003)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j9GvGyqj3bMe9JVe7PqeeltZNHmecUJPhExc8TuS+EGM+U1rZZ9ZwhvDwqt+?=
 =?us-ascii?Q?ND70W16HgVVW/+6KjKffUqgiqF3JK0Tl9j3x/mCogX0beocP/5Xwe2CXj7M/?=
 =?us-ascii?Q?ObGkfoAd+Ezid+Xegd+M4ccW3DSKTtRhAnflqI8teHPWZepBxWvzHJte+Qkb?=
 =?us-ascii?Q?uLZORrD6oR1iigSpKEdanhWyf563YQoL/6I/L/bwdp/GuZBowvc6KMgAwrYt?=
 =?us-ascii?Q?tqEZVTSqhpBpkZ9U7QnDwNg+WbBTSwUTNHh0g4Igu53X249MAsxDD4wJDr+/?=
 =?us-ascii?Q?yOZXOJjmmxfJRRSlFla++H/I415pMCDqMWzTTA20rVLZ/Watn/HQLp/DGyGR?=
 =?us-ascii?Q?ncU9lZWsDiePVSCe6JqSABC9w2/0YjXvqtOqzP9SqfXEWHpU9xmuRHfj0oDA?=
 =?us-ascii?Q?u6THegAGHbKDY7PKp2kigyejCaU7lJ9OyiU7s0E840vuDXTq8EdNwbcOkPbg?=
 =?us-ascii?Q?b98dAEUDVXyDSawDZtxrbwtfafH8GKrco4Yu7PjQo+Coyx7QXeXhkFR2zuM7?=
 =?us-ascii?Q?EiEf4uK+9Cipb8cBSux+jeJGSxDy3UgQ2Idq78f6avOBd6L4qUH4A0R7quCI?=
 =?us-ascii?Q?oV/xyN+l9GiB5lw71n+eXaOxBdlkgZkCewhUBGjVuercAxY3ycb6Sl5kroxH?=
 =?us-ascii?Q?qHOQfXLS/OB9e0UbGmV2mbJ01FoPHTTK7GjwR85ph/5vsPo9M0HOVHMhrRCj?=
 =?us-ascii?Q?OSFGgui6ZZv2w+7O58RhdohPjOozG5W/sLRl2//gtKsLJ3a7sFj2WZe2IMaB?=
 =?us-ascii?Q?7qSHtrSFq5yB28lrd1iGAcIOy4pJ/WLOkdiU9ekIY0bl2ZZuNLPBdc9c9f/y?=
 =?us-ascii?Q?TKG3OS7s/7qxqsTHkziLMoD+lQ+aZvkLNuqT2ANkqenPw7Ra5C6DQuVzih9h?=
 =?us-ascii?Q?XY9G1NVI7gpEwHZVIo3mWHSJok9Ty6V0iW18XzrzpqCFeB/iQfzikjOuk4Nc?=
 =?us-ascii?Q?f74Y3hA3EWbTy2GpPqCIVYVRf93rReCWe0lxy6wwBn8B/9It0YxH6viwFpN+?=
 =?us-ascii?Q?CgAqDbZ4DaRIEOya+dzHzXAQsapgeI9hBvD1BcM84YEudOkwLhLX0BG/EFcf?=
 =?us-ascii?Q?b9ENSOJkuU6EalqQwuxYEeJXkel9zcGtLFnKGeSx1L9OONt0VnExvBlO4+Uk?=
 =?us-ascii?Q?DT8JOwtK1vXXMh2mGn1NMq/GsccYRIU236qXAjfioFMpnEaTsdB64Pe47jaa?=
 =?us-ascii?Q?NnZt5X4xY9rpLCOxtn8Od7HwNdz9uDRY+DtTMe44fPP6BQPX88Qe+M6Uruep?=
 =?us-ascii?Q?H8vvsySAu4Aex11GfTZTQyLFa4KXVX6wq0ibK9r0pf8DSel9S+J7z9RbkUPY?=
 =?us-ascii?Q?zoVQqnfjtJdCkzLSeEJtowVm5sKYrN5l+dHFrS7pNiIBXVeSHcO0g+AcD95C?=
 =?us-ascii?Q?tUTCCdjxTl7wcavNUprgULapkGvNTTT/gllkjo7dStk9I2R6lyCCoQXYSABJ?=
 =?us-ascii?Q?OFvaN2lpVCmWhr64cLg/k6KfHijfIEcaKYFC5kNvjWhkP/yM+LAyn/1WK1+z?=
 =?us-ascii?Q?8qP85Vb18oWp36FvQ7a6abU2/E7k/OCQOPLlemCjyF2RYVNRU29Ak8Rsoa/+?=
 =?us-ascii?Q?BZBWvxabDsLjVKsCuq9s2T0rcH7nj8PSkgGefc+v2yl+KmYJVaoSOjXVzf6C?=
 =?us-ascii?Q?y6O1QSHB3I9qwCouzxwO/fPSEGnmFZM/W0QZjwsWiZEUpLh5hWGOq/R3AVm3?=
 =?us-ascii?Q?lSoYeKsG4GLtT5NDYIupjGw4up3VnyhcNQfy59C/om2hH7Nd0ORAQ0GQLVno?=
 =?us-ascii?Q?9r5gA7AvVS4TqRfZztDPqTUiuk4z36Q=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e01a7c2-7653-4cbc-585e-08df29e2f022
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 11:04:37.9122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3vuu3n9GwOAqDSuDBEfCZeIQlPVIE1teXBF4GS7VbczLntK/I5h7mfsoYj5iBnTAXdJKFD31WAd0lA+nDOCCbADMJSzaCQud6zDXyx5SOn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1069

Add PWM driver for OpenCores PTC IP core.

Tested-by: Maud Spierings <maud_spierings@hotmail.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 MAINTAINERS              |   6 +
 drivers/pwm/Kconfig      |  12 ++
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-ocores.c | 299 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 318 insertions(+)
 create mode 100644 drivers/pwm/pwm-ocores.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1da3623e77ce..f4237ec609fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20928,6 +20928,12 @@ F:	Documentation/i2c/busses/i2c-ocores.rst
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
index 729776086879..138e7cd6e991 100644
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
index 000000000000..4c7e87cb009f
--- /dev/null
+++ b/drivers/pwm/pwm-ocores.c
@@ -0,0 +1,299 @@
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
+	if (!state->enabled) {
+		if (was_enabled) {
+			writel(0, ddata->base + OCPWM_CTRL);
+			pm_runtime_put(pwmchip_parent(chip));
+		}
+		return 0;
+	}
+
+	if (state->polarity != PWM_POLARITY_INVERSED)
+		return -EINVAL;
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
+	/* Keep the reference only if the PWM is already enabled. */
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

