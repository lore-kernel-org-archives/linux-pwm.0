Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.146.116
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794021200;
	b=F6JSEnic6FMwRgRKZLuuwhqr83RkaI4ErQn+enUbIlhmrVxP5QM1K9l8hdhclxokbrBw
	 QXWp9RLdJIUfqX8fMIyHkPFZM2bnLQStXti3/uy2+VkeuzEDBgQPEJCDV4MZbJZ8amvLk
	 ihmRTkI0K+2mJyyrQ6zyFFnvjTqV5yFwSCMvy9oI6OBiUYdklntD5SX6TGK8cTRrEd9fN
	 wjPVy8C/dV4j4ozr4R/XHqVpPRgnMeKP2Md8q8HVqvpwDM8VR9LUSxwRiJCP2Z05IEOTT
	 EjONvxZLWucWg+dQDrcDQCl56fYZcgOJiabnGHb/5xUYo9zO/6lkGaDYYOAoFQamvOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794021200;
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
	bh=SHAzL+eNDi8il9BCB8sIWw0OBMqm6rq051HBYUDpF+I=;
	b=kS0NGwpht/zKdYzdE7SHl+QhP4Wy+ZfwvSfAVdHmsCAyp6oM26xI0u9bup5WW3bHqKnj
	 TcPVWtWN1tDK+rflyY9QlXHT6/zxc+PDeOa+UJm4lpcreYDOxonuN7akXOXK6QheImPZv
	 zaIwvd+Y2IAPzJaetBLXseDGrIDLnpxsJuZS6fkUDOQ7puOfoQBsnP/l3D2cnASLTln9t
	 6kCMmTl+NK9stSQGH8wLXzFXOtj/VmHdok2/b9sIOhNecANbSJ+lkvDp3yPQkatnHEt33
	 ZkPBGOM9QEVx3Wc6LymO/94uSer1zlEGP1UjgeRX7+9rbRVGbDOAVgkMgFqSv4B1o7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=starfivetech.com;
	spf=pass smtp.mailfrom=starfivetech.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.146.116
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2116.outbound.protection.partner.outlook.cn [139.219.146.116])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9E1606A32C;
	Sat,  7 Nov 2026 03:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B9E1606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxulMbm4+u6wLJU9yfTtEcNRTQ8cn6Pkj8gTgwQsOXg6gmdpwZdMHAGDHcWaeFiTYhPpqv9/dOlbIIxOuXigFrD52e1m5Z/w1bHseMNIAjLZIFmOeUL+XQtUfQT6fONuOsiEZaAfrLvM4KI8B0E4JIFQdpiuT/ea7Rf8Kn0Rj+FEJqLI/+ZnAMO41eVoyU7Q79Kz6xyBcuwI1M+RhiRtuAAo6NKRNY20H/27SfjunlhuHSp1JGMM9Fo/oEA1qZMv2+XlX4eW0/HbBOsMZ6+lCdoBqJSY89LzzRpShaCvp4IPKhAXYD6tJrEFG9M3dpX50suwoC8yarO2tW5tPFv6IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHAzL+eNDi8il9BCB8sIWw0OBMqm6rq051HBYUDpF+I=;
 b=NGsYvXD2nAIGd8d1JzkHYJglT/1FXRjPzlPgirWCQzzxvNCP+SKjGZ3qQ7SHL3eem7tNgQusY2j+sqohdIMlaAcdq1EQ90xvQ9sGeMirWGoZRM7gocEpZE28c6aSbPgbJhEQnktp1eNvaBKMjwYlIZfrL3NBDcOotV5xMYqh8pUe9xD+TlQJ+4OfyvW/tUlWH3UWeyN6fuYgI9ItKo2N0iejEv0lWxauu6GRfHi/grQLRmV6jnW3aGG1XQ9DLPQQ8V/ioAkKx8NtQywqXdxhMomq0CQuXeL5pSeAspJsHxUXuk1qflQJdD998kqu0919iBU5tRiJ4Inow2yoHHgASg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:7::10) by NT0PR01MB1261.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 03:13:02 +0000
Received: from NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
 ([fe80::be4a:d29e:5188:b37e]) by
 NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn ([fe80::be4a:d29e:5188:b37e%3])
 with mapi id 15.21.0592.010; Sat, 7 Nov 2026 03:13:02 +0000
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
Subject: [PATCH v24 2/2] pwm: Add OpenCores PTC PWM driver
Date: Sat,  7 Nov 2026 11:12:51 +0800
Message-ID: <20261107031251.98972-3-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20261107031251.98972-1-hal.feng@starfivetech.com>
References: <20261107031251.98972-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0007.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::14) To NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
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
X-MS-TrafficTypeDiagnostic: NT0PR01MB1102:EE_|NT0PR01MB1261:EE_
X-MS-Office365-Filtering-Correlation-Id: faa3366a-09b1-4ea1-81de-08df3c7d08d9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|23010399003|1800799024|376014|366016|13003099007|261026140227099003|38350700014|56012099006|261022105027099003|261021121427099003|261009221227099003|261009223027099003|261022075727099003|261026121527099003|261028144727099003|261102123227099003|22082099003|18002099003|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	+G4XqqnxaurnTuS4lOxXQ2V1T+xwwgSZ4RpFEHSExOD88z1vB7ZDx0ZGObj4/RATvhhkHeej+WPuDsTUSh9WDPOwxirnE+vGgvhPj0JVllp5OPnBaWxm/F56lh3RbIds91A9iR5IPjkRbOOOOG7+quVFm68xIDvmdhKURDh4I4wy/skGIES6ORPuUZmImvDWnHRKQZp+Fh4kYpRuUCxMksNjXlOlee0bwzD9fgNMRXSU6uYdJAJKXN2hpEjq2+qfPOmMXcUvJAExKb2bFq0YVMyA3GwZU8uA83DJbqFovv/JKYko0XEuK/PpOxkRshHf9rAGs9gZiLd9Djm/zDQ4GmSUQ2Z6inaNGDFDHuLZJa4HRCxaMxE2BJLK+IWRLVmYsqC7gW/BPV6XJzOVwhUypCPzknFr6TeMLH+GvREsY8Xcy2XlszFdYBeZc0vV2tDHDiVj46apleiYZUiTDAEUbDEK6VyM3ePsBG6ks4m/NXd1AQoiqv/d0KJMLNA3HWRKa2ESPLlksSCA4lRBwtM6/Bv244utO2NttRuLymVokGGRYHZzqioHeM5fj1+RyuEe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(23010399003)(1800799024)(376014)(366016)(13003099007)(261026140227099003)(38350700014)(56012099006)(261022105027099003)(261021121427099003)(261009221227099003)(261009223027099003)(261022075727099003)(261026121527099003)(261028144727099003)(261102123227099003)(22082099003)(18002099003)(3023799007)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cg8jnZpD0I8I0YXN79ODiRxswkKWxhXuNiP357VsjvFuiQRewiXXtYPLqqEH?=
 =?us-ascii?Q?dfvnwn5jRza9m30Qy40Ia4mVEQ8+7hppYo5OVpy+ggEkG8Bc3f4uYGhVMMUr?=
 =?us-ascii?Q?GKN3B8SqvNi6AYvMe+DRHMdePuWKtH9Yx2jxBynuAs+dY7OoxXddBxVoos1m?=
 =?us-ascii?Q?a2ao4rcI4Q3ARHXW4WPr532rPxdHyxZD58DgXHoWHYSFM/a0GtWXaNKspUxK?=
 =?us-ascii?Q?cZuHG6Xm3GktEnCU85bZe56nY2Y3axW8+Wgqv8YMXMSvGDHDMBKsPSdoJORM?=
 =?us-ascii?Q?3E6Kqql82B9BDK74VRJ/O2pL5fJNnENz1qNmEocIiAqkngU2KUoiuOqEh51e?=
 =?us-ascii?Q?0zdJdELd9BtYFQ1r7ysIOkCuE2SBCKf+KIkf70ru/yWY+6Zd/psSLlBkbESv?=
 =?us-ascii?Q?TkwuCyCeMG+FyDM3g8rtwwfNFHOBWX4bZnwuQOWHwiEpCLXKd4UZyeQNXoh6?=
 =?us-ascii?Q?7iXfBjkb3/EHZY9b5biBu2XB3uewycDQQ0MId3uIdK5YZU+WgTGOosYSOHXb?=
 =?us-ascii?Q?aQNVA3BhX20a19pXSA5+cZvz4pCtwypoiGChOuBNy0UfYua7NS9ebfeVpQ4K?=
 =?us-ascii?Q?nqZO7vJHmjL82sAQs5g/MTCt/LlJjM7Gqzdg3V4Au54dtHXEDrfidLPM++NR?=
 =?us-ascii?Q?sf2Ow7F9V1wgcUOmeyzbJ2R9O1U40RjCVkL9vBL4tbf4ojA4NNK5azttjRS/?=
 =?us-ascii?Q?OQLhlDgwAwYiIbgI4CDxuUYsynAxceF4k22Fp/DaqiR9zNMoH1iytbc2uWz7?=
 =?us-ascii?Q?UAfZAoZa5SaS2dXtHnQGkzxVpzjNd6UL8nCiD7jaCC7YSQPWFK5zy2Fs7HNA?=
 =?us-ascii?Q?7dEA3JClNCugZk8mp0tDMQKpH+ojIl2L3/5XD8tkZ19eWRDpbOrYTgjIVYef?=
 =?us-ascii?Q?OlZl6rQG/TAtDpRXLGQWu5sNb5c3SjuP364SJrmOYyvFAw2121cScBQQGyZa?=
 =?us-ascii?Q?rZ6TiaQ5rQBmPe03DS8x09Mh+hz5gmiwtKYIIDCvMmDHJ2TlNIGH0KGgXOGn?=
 =?us-ascii?Q?ccYxISY6k791dRa8efQd2w46/BRk3GmiyGRVXV74e9jxhtTQzXAP3x2gOkRw?=
 =?us-ascii?Q?sX5Dm6bEICCBWqvdNLzggbmxWP4sLqy54skX9pD7BmFfLkfmmnrjmpQCxmDb?=
 =?us-ascii?Q?Ev7x5jPRuWgQjca9RReHhMQNx9olnQiqMpe6GTNcMtsR23ZeNwfexy/Fwt/C?=
 =?us-ascii?Q?MlP1uHWw8mZWAO7zdTDRK2k9eYoUAF7idOtjPP72TAOE2SOr7pZ3wcaPxQrk?=
 =?us-ascii?Q?OyLhsoHPXtco5ZjaEfma0FaXn2JR3V0ZICDRpWkPJB7FpGK990zwtKdZ0PbY?=
 =?us-ascii?Q?0X5mnYhjRfSYLMeNt5Mu6Uw0a0bZoxCWso+e5HUxnevckJfYpwIpluTtM2NF?=
 =?us-ascii?Q?GDWYhcncttFs9J7vfVEhVoj010vCHKOK65VZwNC8F+knE5bzTO6ovI9Zv0sH?=
 =?us-ascii?Q?Vz8Wqearsx3hvOJ9oxdt7hBHvza7bhRtAzFgZLEVIfGChleIcCldhD/9LhjN?=
 =?us-ascii?Q?YzshMAnRrUssPTEKclL8MQKrCfTi2u07MVE1AU+f5ns4ecmEjCzedZElWBFC?=
 =?us-ascii?Q?20GqrIkzJPJhVRqZSJGJ6d90+djKFuXsYWIid1Khl5rM7+LtSJqT1jXmb+oO?=
 =?us-ascii?Q?Ni9J5kLGYApBRDcedmFx2XEV3u/zju+MVx3TSIuxrAsbmzJlQ4D+Z2yaSZW2?=
 =?us-ascii?Q?mEC1kiV76gfI1QOtvWkkfK8qMedzDZ0FNcn/WIM2s/WNG/Yej2nNrsP5HpA5?=
 =?us-ascii?Q?rCOgeUZQJ8Iy+2TR4RcC0Hjj+k5J9w8=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faa3366a-09b1-4ea1-81de-08df3c7d08d9
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 03:13:02.7991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vSEsaARGC6rcoHmzFIUIUPz2ElHRC4ghBA3aMgMFdqL0ZcpvwgjPZCeUYANhPnMtxnOxDz8tIzuRqZiD+oXLUngGs9TZTRtCTXfX67x2MEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1261

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
index b2eaee98852f..7935ff64b95e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21082,6 +21082,12 @@ F:	Documentation/i2c/busses/i2c-ocores.rst
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

