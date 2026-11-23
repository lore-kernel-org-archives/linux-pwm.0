Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.97
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795403690;
	b=WUOPritrT30GP6/QME7LRpf0voaA1bPqA9IpK8Ow3Amq0iLW+lkz2ApYggJwHGduhPqM
	 on0gZpjdBROCX5StSVt0FzdVZryXlFFi4WG5vGb9cSHYSRs2yjlWqRUmLG62cLbAv+tVD
	 UzTM5GIIEevDNHHAYK4qV5bLcX4+6s5boG3tBoOZI1pvwiH6C4J/7e8QH4UPoz73097Zs
	 jGxBR/keN78Vv95FefPPvfEiptrqhqv6F3zgCC2eZaumbOV8FbWu7gZfOCruymkEKg44r
	 7LQ04GYJNvWC6nFOLN9dR2ud9ay3tHXFqMuCk+ex02bQ/4+CzD23WwqkvVN76TZEpzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795403690;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=XcWwqrktm4W1F4ZYHJVDIN8O0jmKzyqGHtrZhdKSctM=;
	b=VTYs5x3FSVdzXkm78e2qM5kf3Y6un2UuJ8TwKHHGAXK40q9oF71G/3xXHNWoSCb5zmp5
	 8rGkybpX8gWaXeE7FnCRZv2MKaiRdKGKwAKAq/wREyJ80PBcLwVuidccxlsoVHcn2nnFM
	 Hcc25uKhkRs1AEf75k1fBlsANbshDAaSdnHMbHFbIlTSZmOePcwGoxrGk7Wm4Pv/lHjME
	 O7tQo4xi9KpvBrAo7JQ3gMHbFqOGIMEg61/QUWqjrGlJYOmeihsYwwql2qA0QaDNxoCqg
	 b26BINEYywQlzdjqj4JLi6OqwpV3n54G/zp+yerVT2816DyVdA+4csE+JXm02bjarsA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=starfivetech.com;
	spf=pass smtp.mailfrom=starfivetech.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.97
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2097.outbound.protection.partner.outlook.cn [139.219.17.97])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BEF606A683;
	Mon, 23 Nov 2026 03:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1BEF606A683
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PB4hIK6sR6MG3b0WBfqDc39f7Te/IV4lDaspd2YD5Sg16VYl/kzBQ8QIul1XzPe0xWrvYL4Cmc3FjX9wKJeOyOhoNkxyzIdBFd84z5XISmEeOFkGMpiR8EGc3MCz5yQ0kRr4gMIn/EpiFIgPYKE6+vUrVdiuS/qPpyHGAlNjI2JDwCl6mQX4Qy99sbVNnip0RUkZPHZVphAs2xs5wqERwhS4dMxYL47tOyMzhCao+E7Tnoc/yiqXcVRvNacwfDHR5MwHqkFS2rBhgbqpe7IuVLs+o589n4kYQorwyL0lq5ustap64CY0u3MN3T2LJwDJdbJgyqwqYenVHSd5OA/eAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcWwqrktm4W1F4ZYHJVDIN8O0jmKzyqGHtrZhdKSctM=;
 b=UFSTqcsH4YCOnngoKk5UFa4X2gNKYjlQ6K+Qqas/d8kYG9ZBeht4ccZeXJRBHv2U1IiWEvGQUM7TsjYU+XMokejew1qGjdD4nGDuwbwJ+A7eb4sMwco6lrXMzGV4lTGhCJDCtcmVhwCpUY7l01KgiRsh1uNhCtmc1xRs05gixZL7C1lUUxU8Kylq9cNqngifKoy6hmS9Bb+tf7v3ofmQSUe6W0jYkEuMaeoWIa5RmQkjmElnq8lHMfYqZN94YbAS8lTnKl91XDLf4CJBnFnqmuAAy1yRyreJN5dSBPezgVNH1bwJdXAYAgmOlNf3hxKYEWR1lnypovN0VqiObymfFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:7::10) by NT0PR01MB1040.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.19; Mon, 23 Nov
 2026 03:14:37 +0000
Received: from NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
 ([fe80::be4a:d29e:5188:b37e]) by
 NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn ([fe80::be4a:d29e:5188:b37e%6])
 with mapi id 15.21.0615.017; Mon, 23 Nov 2026 03:14:37 +0000
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
Cc: Maud Spierings <maud_spierings@hotmail.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v25 2/2] pwm: Add OpenCores PTC PWM driver
Date: Mon, 23 Nov 2026 11:14:28 +0800
Message-ID: <20261123031428.20536-3-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20261123031428.20536-1-hal.feng@starfivetech.com>
References: <20261123031428.20536-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0021.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::9) To NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:7::10)
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1102:EE_|NT0PR01MB1040:EE_
X-MS-Office365-Filtering-Correlation-Id: e65ad2c8-2741-4257-cb15-08df490fe7a8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|52116014|18002099003|261009223027099003|261009221227099003|22082099003|3023799007|13003099007|56012099006|261102123227099003|261028144727099003|261022105027099003|261026121527099003|261022075727099003|261021121427099003|261026140227099003|38350700014|10067099003;
X-Microsoft-Antispam-Message-Info:
	BnJGYKopLAkL/4tDRFVOjTaBFczkw/8+7QdUvTFviGUhjvuM460UkOfiPkQTwQphPDVdc8pM7Q3W21BPGcRJqcmfa2DDHh3m+TYoTJc0EwshKyQhKLUszAvpREQ6wGUKE3kByxRmP15G00LTgjEAeDH3TQeODd2Hg8dgRsdD0DSnzDAH2XbzmzKMNW04w8wAEVLg1xCCLMLsSLJf+dFJqouDWYgAMB7TSMKqurmSDfr/039VpN5P9BgzKfiMbFGzoN4xgIhJElbElzxTZz7y7LMEJKpJ4smOoqTEedZJMbXojQrU0iwIRJRIaRUl0mSGynE/DrFXij8huEswiIECGlaQwIM6WgIMLOH632LS5HjiQByIexI8ogYcUom3bxPYJuqszBRA/i8DauZnVS5C1tdNF3C0rJv3tgT9a0v2nUCTjLjXIC8GvdEEqH2aauPCDq5uoDsV+jsytArtIzExDTe5pzzzvtc4ijq7TtS+C9O2tq31wJENn0CNsHH7SaU9gmQ8pdtvc59odvjg/KiMNrKyv+NInyskN4O43/WnbzZ3aKbaVuUZpQVBtKVSIsmY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(52116014)(18002099003)(261009223027099003)(261009221227099003)(22082099003)(3023799007)(13003099007)(56012099006)(261102123227099003)(261028144727099003)(261022105027099003)(261026121527099003)(261022075727099003)(261021121427099003)(261026140227099003)(38350700014)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OhbYSuef8X+nF4+3I5pkalVrT5iRNpCz1eqMlKVWtvxe97/TcwP7QBJ1OhxU?=
 =?us-ascii?Q?woeUkag6eRP/62obDVQJbUkF6V884JzhLgsAcd6oewk/pdeamMFY1NXFBcjH?=
 =?us-ascii?Q?0a36JHP1umq9TPDnKRsnQ465Uqfv7nrlcazIpPD105BNsKkYJG4O7Z1t/960?=
 =?us-ascii?Q?oOyfsGeAi4EuyhpiUAo0k2i6brNbA7nqxAr11qJy4uzgoEo2xc91nMnMfMZj?=
 =?us-ascii?Q?5Jgmwf7LhSZ2jZA+AwDSri0KsNcALX1bXXQ7gtnZ8PNzR6JjuwBi9h4/rLiU?=
 =?us-ascii?Q?QQndKlmKklRzhAjjonOr2zcAXQ1VEteuW4Owz0zNm5EEkG9VKHjb5nIfSKVP?=
 =?us-ascii?Q?KXHwwfP8Ja22Euz9NdiCBYh51UAr41X7+I0DvG6PapwWx1NwNIqtKVlxBHGl?=
 =?us-ascii?Q?ouyd2bSZqpvjgApEBEez+OKpVJBU0bpVYQ1a+ofDFw9Y+EFjmMwsxCBfB3x8?=
 =?us-ascii?Q?yv6+aQtHzoG0kkwBx8JyYyT+iaOAz6lLIrmQeLjXcoFyRxhH/w1j0WsAzFx8?=
 =?us-ascii?Q?lf8edXz/hOPY/HgynpHaMhC9AALHny5dxZO38pMbmoyS9zQ6/zxpUtoLKBsT?=
 =?us-ascii?Q?j4kcXblaYGw93e0t7yALj/SbAe5IXojquepBk9s7PQkrEg0M+UupYDguMXVF?=
 =?us-ascii?Q?hHha/r88e+zmpB6OYTsaXckhPNQ3uCf78GqNNPlW4VCIUipCFwh8Jd9XuVJS?=
 =?us-ascii?Q?7+MtkbelSC5ldyrExRvSn7X7zJi7Fj7e96e5wQhXCzXIAz74UKY0SstjDCkj?=
 =?us-ascii?Q?e7iIDgGVrTVUZIvxqy1V1XyZSldHXlIA+hNI/xck75cTotEB9v75vO1qbucz?=
 =?us-ascii?Q?0E7K/1DTl0UeVTxd4Hp8oyo6HbV7nXwb5QFg21pV+xroKCs3ONexq1YIt3MG?=
 =?us-ascii?Q?qXNmOjsqjWNG5M5SAOZVNKqHFNpBJIUaKL3w8hrRfTmLWPmxViQSzAXIHudW?=
 =?us-ascii?Q?HK0kKRHClYIn4W6JZfYloHjn6JoF7AxXmjD0VrjaAKIUNAPHsEBzPpJcR+PN?=
 =?us-ascii?Q?zlrNscOfncL9SGfHtnmEYEJ10+4rhpIHmcJ32Sphoczy0r93mKZYc1jfZDUu?=
 =?us-ascii?Q?Z/eifqJUMfS+lbNR+dTgDtUht1UZXm5C5jiQ8pZxVGfmLh2GXFNPKa01scYe?=
 =?us-ascii?Q?1ZumtykD87zMSdXtSrwMfCWdkttSuAU0eU8oKZjpas36NA9A0DPZIFJVnRl/?=
 =?us-ascii?Q?hZbeCRz4sqHOAnNZOKiUUWVzKGm0/2gwGP3tYwZRu5H7xd+0qDaw6YW6td7S?=
 =?us-ascii?Q?huL3EJ5l7fi0MCYSYrlg7qaFvQl6yitsN7XRkW2KUkF3OJ7CZo1q2PCuRoR1?=
 =?us-ascii?Q?SEmnUAzvi9kQIBJH+6rY0BL5itceGJUBKCdAZUr1ui9AR8XUmCKeYxrfR/t6?=
 =?us-ascii?Q?gz39UeUVRpCEO+hr0ggbQXuHmKvgM8qgvTmVkcKhCS6gFwbTQWCZkqFAsj0u?=
 =?us-ascii?Q?E9Vy0Dkt1bSQvfVngP/yRaYpGVyb0c1vqsWNBrrsHwj02PmqpcXsZ8dtqWjV?=
 =?us-ascii?Q?mVfbHz4x1ktZBKZmsLHTVAAxPt/b2jzdvEwgOiDj9mIu6LALrlC8aNqzDCT1?=
 =?us-ascii?Q?U7ruxPVBH8NUplVxndfwAYUEZcy1EQ3j8jyDxrSsTOgo6DD4VgbeDXI55w30?=
 =?us-ascii?Q?7jdhnUbxrm8rbH6ZG6PsRKMq4G9+VHt3259pX4xcoDxYNuECS2YeWKp+skQx?=
 =?us-ascii?Q?RKXVGmpFtkfCeI8JAxNz+PlXv5x3YslVJFZWzJ8EAmz2HQmPkUC+aV+nfbkM?=
 =?us-ascii?Q?JFnHzqpQh/T8ySQ8NO98G0Vld3dKFpw=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e65ad2c8-2741-4257-cb15-08df490fe7a8
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 03:14:37.0677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5gGiF/WMnO6jm17P5pOf54gcORChda/lbJXvZOrn97hH9CbIEWvhG3m1Dj05PZXqOEmAtGw2xTxsFdb0Tf/pCVTnaffdjIvHPwhABNw8O4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1040

Add PWM driver for OpenCores PTC IP core.

Tested-by: Maud Spierings <maud_spierings@hotmail.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 MAINTAINERS              |   6 +
 drivers/pwm/Kconfig      |  12 ++
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-ocores.c | 305 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 324 insertions(+)
 create mode 100644 drivers/pwm/pwm-ocores.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 44540a1eb2b8..fb4c5e9f3bf6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21081,6 +21081,12 @@ F:	Documentation/i2c/busses/i2c-ocores.rst
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
index 000000000000..567239a330f0
--- /dev/null
+++ b/drivers/pwm/pwm-ocores.c
@@ -0,0 +1,305 @@
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
+	ret = devm_clk_rate_exclusive_get(dev, ddata->clk);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to lock clock rate\n");
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
+	ddata->clk_rate = clk_get_rate(ddata->clk);
+	if (!ddata->clk_rate || ddata->clk_rate > NSEC_PER_SEC) {
+		ocores_pwm_runtime_suspend(dev);
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid clock rate: %lu\n", ddata->clk_rate);
+	}
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

