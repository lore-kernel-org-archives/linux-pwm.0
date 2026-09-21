Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022133.outbound.protection.outlook.com [40.107.209.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F2C1C695;
	Mon, 21 Sep 2026 07:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789975453; cv=fail; b=G2uV3GY6WPmonzPeQMV6l+AYrrdvAEyooBVXVJ3lIUp3gb0hhswjATXTawdiJbtc7uhplihMQ3URqDB3U7Ig/zIfSQjy7LU8g4ZjAgKYpCO+c1Nmj5F4gLJ6mLkCDXuTldRtYU+8TX0EgKBsx3SSUN9r4oHrKit1n1qaCdrsy3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789975453; c=relaxed/simple;
	bh=eOgeguD312z3HoKatzxay+UYsN7l2zDIRm2dkxROxOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CmIcwtCtQ+EF3Tx+WFm53A3QArBdXsgGMUQm60YIEPDBQf+c/lqfPVTfRyKy5AbdtI9zkmC1NYjJxxbyp4925zXUEj1C4Tac5nd/BfaDmQZryh1vT0atVJYV+fpVhsbKV9dNrtVoxs/vyycHxoStEQ5x0fNdYTte6hzhP9pMJoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=b1Nh+Wdy; arc=fail smtp.client-ip=40.107.209.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="b1Nh+Wdy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdcjmvfP5Z9LybnRxEtC109PIPpmOIPf2EPpvGf2g3CJQObWLsk2EMOQbN4fUyKeNhz8Ck9Z2Q8lZXvo17jXhgHpAXfII+Nku9g8ujJOsU7cNeIGuyxWfltHb6T+oZd/R2cR1YG7jivoksc8Z8UmHff3hRLXQm53APHnb06WKOyoVVtXT3Oo/APw+m3gNtUT9bWkG2NjDvmDK3tQBvN7bVkoq8aMNy5WxYjihtF0WFl3ZX4TLX9nMzJU3VfOziHTXbdNLuhD7yw8E9xkQ+bK41vJIEv2JHsds7qROCQ3yC8L47v+j2Aa6Q4/79mLUh2yaHdiYvVbQC1F8/BxXLbBVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ayrkdKd8vhBSrdhbkpbmTc5ZXtotQlc97hxRwGPNmQ=;
 b=Yn5uGZxHKOymYY5WRGUh1z3bgrQN8/k9g6SmqBQ0Veb7UTTFv0KcliflRz3XVKCVnlHpksMKTdJN62y5FaeuLsRBdihmaQsWPdaA8wuVWbRL/rV6ncG3V8fDdOS2V91RxsyYenRJbOUUiIHvogBILMWsz3iQErx5twedLoWY4O/ive9cKUgVSorEIYwU0IcmT3WSVjvJglhsLwAuDK0/qvwQdOtuEQY3W29bED3bVsqHmAraU+EvnM6SsUpUHulcUXKa2ugrwNTHLNNqhHg4pNMZGnQvj8y0l1RUnl57RPkHvXMb4gvuYlbAPcQ/sxtUChNH7CPWS5t226Xhu8mXYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ayrkdKd8vhBSrdhbkpbmTc5ZXtotQlc97hxRwGPNmQ=;
 b=b1Nh+Wdyq/UGOLvvPBnVmcxounFwL4y8rIhs70eeTjn/o13jgLl55dNq9KmCbR1zLMr3/+27AOdjfzoscCKa1ztsTCwmS5e5fur8gAo/aWUQtiyFUs0eHrLOsXxSWWc4OGvH05ElYHkxJoDKPPlc8fKayFOm3a4s8i/X+ijdYzwlsHF47qqp5a1k5WGtqy4q+MLpeMLAfRgUS1vhBd06kPchCPXSxVblcaU0o2utG4JUdzDyOcbwAMmgQW7LEKcqTrbNzrVtKcwswoJl/gR0hgVCP50ZghzpQ/fMstdzzeAM5Eyv+Z+NNQrVh2SYyDNzb+/VR9uS4B1x2j77/TYVFg==
Received: from MW4PR04CA0035.namprd04.prod.outlook.com (2603:10b6:303:6a::10)
 by PH7PR18MB5646.namprd18.prod.outlook.com (2603:10b6:510:2ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 07:24:00 +0000
Received: from CO1PEPF00012E7D.namprd03.prod.outlook.com
 (2603:10b6:303:6a:cafe::69) by MW4PR04CA0035.outlook.office365.com
 (2603:10b6:303:6a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 07:24:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 CO1PEPF00012E7D.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Mon, 21 Sep 2026 07:23:59 +0000
Received: from axz-uw1-build-vm02.corp.axiado.com (unknown [10.14.1.22])
	by smtp.corp.axiado.com (Postfix) with ESMTP id 5CD6C40BFE04;
	Mon, 21 Sep 2026 00:23:59 -0700 (PDT)
From: Petar Stepanovic <pstepanovic@axiado.com>
Date: Mon, 21 Sep 2026 00:23:56 -0700
Subject: [PATCH v3 2/2] hwmon: add Axiado AX3000 and AX3005 PWM fan
 controller driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-axiado-ax3000-pwm-fan-v3-2-3def8b6ffec9@axiado.com>
References: <20260921-axiado-ax3000-pwm-fan-v3-0-3def8b6ffec9@axiado.com>
In-Reply-To: <20260921-axiado-ax3000-pwm-fan-v3-0-3def8b6ffec9@axiado.com>
To: Petar Stepanovic <pstepanovic@axiado.com>, 
 Akhila Kavi <akavi@axiado.com>, Prasad Bolisetty <pbolisetty@axiado.com>, 
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Tzu-Hao Wei <twei@axiado.com>, Karthikeyan Mitran <kmitran@axiado.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org, 
 openbmc@lists.ozlabs.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789975439; l=15656;
 i=pstepanovic@axiado.com; s=20250916; h=from:subject:message-id;
 bh=eOgeguD312z3HoKatzxay+UYsN7l2zDIRm2dkxROxOc=;
 b=43jgUTFzr2MQqVtlNUhXbClgaxNlGaG8WbaXVRmHw3vdH5JAnYCkcYIe7whJMQsg+h6Sh8IpO
 XPZxKFfB7hnBeRSjJXxvIPOLHSTQTQcqDg+/HoZGywa/o/oIASZX3bu
X-Developer-Key: i=pstepanovic@axiado.com; a=ed25519;
 pk=70f1UJOGT9U11ZK6o+ENXtv0I5wBE3e+Y9YWODzRsdI=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7D:EE_|PH7PR18MB5646:EE_
X-MS-Office365-Filtering-Correlation-Id: 0756e1a6-5aed-49f6-5f52-08df17b14e38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|23010399003|1800799024|10067099003|56012099006|3023799007|6133799003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	iDHCUzudWDLMRNNlSBQXdWwvgsYQFpHiQzT9zbzLoTpDwezDWeFNKxvxSkLIXGkO7z92WZBcqNgNqaMDODJKZ3DKXQAhfhSF4T51o1WuN8ijYmKiMY1TTzs80lJy9VX+etIucsBtbzBKniOEKmVpmwm7FlnWzMK9Px5/advmS4a+BgZ3f/Lv+PWtprEd+N/fx3jXw/d46V4kupRW2ZOr9EMz6xnnDhzXDT4K8DYPGMUNfUfOMt5jAm7+eQA0CHAR/TgkpaKRAO93up5H5VGHN0UsSeKmX1kcl/7IBhlwpQeJNLN1QAVMiUMoSHoYJeEiy4aiJRhgXdGP3OsmZMPObA4VhkMRzh3OxmOFiuQiEcr8W2tFldq8OGlt+8EVuPRboMOWAdsYdDGDYxCl3T8vi4fNv0ns4ihAzGkND4W9hfu55TVuud4+qN/wm8QQsdoRohSrRsoqp7yc6gYsMnrVEfzZZXQ3zIKohAAi8LXKRmtEj6/Bzk84OqIkAzu0SVdmGImwg4zi1Q4s3MFbb3R1vGotXhjW3hhCunbfvh/hb42CuEjaZUyRDBVB+hb771qONOJBFOS3piuZeYLCXVobKViyyysFXwPtf8ushtWhxZ7bm2i2L0bLJuu/cSaMoKa6oCzjQR2gGCPwY/AB+albckrfnzt0MPZwaboE9yTW1Z8FAlcTG4P8maTE4XSe0ce9NZ+Os6e85Q9zkMI7eMwg6rG0bYMlPTMVeO8yOtOpN/7rAvI2qI5FmzthbzqhbFEK
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(3023799007)(6133799003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	h81nfanoqc7GsDW7VjN9+uKtJQURb+iVmi95T2q9kJZRQhUQEEQDFHacNXgTjL6Fhl4gVNAmDJAzuVVeqj56qvIPyNLIdf5bwmAQTlvKw5lL0+tnfWOTadtBuGseeFu9Mf+OPMBJgveNtaIrCUg8HU6CDMrx5m+cIb5j0IkkqMww3ptv5SkJaDP3FDSmE7sr/W39aVqVsvE9NEDpw2tjuxipjqpdRmvTqQoRHUHTm1+na4ePEjIxE9QMKnUkn5H7L3DhNh+kWDXebkJFr7PSj9nysbJ1eIwQBqLz5KqKCr0WRSxh/+E9F6d8fRR/BTyM2v8u9MreAVRFERS0TLFfNqhxvp+GC187CKTEgyqa1AE5VfDPuANR6LFcC8eCP88kTZefidLCZg1RR+PYTrd+cpCENqkHViyGjfmJVhBRudM3AkAuckIdr0x88w8DL2vs
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 07:23:59.7987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0756e1a6-5aed-49f6-5f52-08df17b14e38
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E7D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5646

Add support for the PWM fan controller found on the Axiado AX3000 and
AX3005 SoCs.

The controller uses a hardware tachometer block and interrupt to measure
fan speed. Fan speed is controlled through a PWM signal supplied by an
external PWM controller.

Register the controller with the hwmon subsystem and expose the standard
fan1_input and pwm1 attributes. The physical fan is represented by a fan
child node containing the PWM specifier and the optional
pulses-per-revolution property. If pulses-per-revolution is not specified,
the driver uses two pulses per revolution.

The driver was tested on AX3000 and AX3005 boards.

Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>
---
 Documentation/hwmon/axiado-pwm-fan.rst |  38 +++
 Documentation/hwmon/index.rst          |   1 +
 MAINTAINERS                            |   2 +
 drivers/hwmon/Kconfig                  |  12 +
 drivers/hwmon/Makefile                 |   1 +
 drivers/hwmon/axiado-pwm-fan.c         | 416 +++++++++++++++++++++++++++++++++
 6 files changed, 470 insertions(+)

diff --git a/Documentation/hwmon/axiado-pwm-fan.rst b/Documentation/hwmon/axiado-pwm-fan.rst
new file mode 100644
index 000000000000..d110e170b0df
--- /dev/null
+++ b/Documentation/hwmon/axiado-pwm-fan.rst
@@ -0,0 +1,38 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Kernel driver axiado-pwm-fan
+============================
+
+Supported chips:
+
+  * Axiado AX3000
+  * Axiado AX3005
+
+    Datasheet: Not publicly available
+
+Author:
+
+  * Petar Stepanovic <pstepanovic@axiado.com>
+
+Description
+-----------
+
+The Axiado AX3000 and AX3005 PWM fan controllers measure the rotational
+speed of one fan using a hardware tachometer block. Fan speed is controlled
+through a PWM signal supplied by an external PWM controller.
+
+The number of tachometer pulses generated per fan revolution is configured
+through the ``pulses-per-revolution`` devicetree property. If the property
+is not specified, the driver uses two pulses per revolution.
+
+Sysfs attributes
+----------------
+
+The driver provides the following standard hwmon attributes:
+
+=============== ====== =====================================================
+fan1_input      RO     Fan speed in revolutions per minute (RPM).
+
+pwm1            RW     Relative PWM control value from 0 to 255. A value of
+                       255 selects the maximum PWM duty cycle.
+=============== ====== =====================================================
diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 29130df44d12..857924205861 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -51,6 +51,7 @@ Hardware Monitoring Kernel Drivers
    asus_ec_sensors
    asus_rog_ryujin
    asus_wmi_sensors
+   axiado-pwm-fan
    bcm54140
    bel-pfe
    bpa-rs600
diff --git a/MAINTAINERS b/MAINTAINERS
index f528b1a42e0f..61e7a0939002 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4464,6 +4464,8 @@ M:	Prasad Bolisetty <pbolisetty@axiado.com>
 L:	linux-hwmon@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/hwmon/axiado,ax3000-pwm-fan.yaml
+F:	Documentation/hwmon/axiado-pwm-fan.rst
+F:	drivers/hwmon/axiado-pwm-fan.c
 
 AXIADO SPI DB DRIVER
 M:	Vladimir Moravcevic <vmoravcevic@axiado.com>
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 2bfbcc033d59..161054ba7312 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -469,6 +469,18 @@ config SENSORS_ATXP1
 	  This driver can also be built as a module. If so, the module
 	  will be called atxp1.
 
+config SENSORS_AXIADO_PWM_FAN
+	tristate "Axiado PWM fan controller"
+	depends on ARCH_AXIADO || COMPILE_TEST
+	depends on PWM
+	help
+	  This driver supports the Axiado PWM fan controller. It uses a PWM
+	  output to control fan speed and a tachometer interrupt to report fan
+	  speed as RPM through the hardware monitoring sysfs interface.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called axiado-pwm-fan.
+
 config SENSORS_CGBC
 	tristate "Congatec Board Controller Sensors"
 	depends on MFD_CGBC
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 63effc0ab8d1..78fcb22a1777 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -58,6 +58,7 @@ obj-$(CONFIG_SENSORS_ASPEED)	+= aspeed-pwm-tacho.o
 obj-$(CONFIG_SENSORS_ASPEED_G6) += aspeed-g6-pwm-tach.o
 obj-$(CONFIG_SENSORS_ASUS_ROG_RYUJIN)	+= asus_rog_ryujin.o
 obj-$(CONFIG_SENSORS_ATXP1)	+= atxp1.o
+obj-$(CONFIG_SENSORS_AXIADO_PWM_FAN) += axiado-pwm-fan.o
 obj-$(CONFIG_SENSORS_AXI_FAN_CONTROL) += axi-fan-control.o
 obj-$(CONFIG_SENSORS_CGBC)	+= cgbc-hwmon.o
 obj-$(CONFIG_SENSORS_CHIPCAP2) += chipcap2.o
diff --git a/drivers/hwmon/axiado-pwm-fan.c b/drivers/hwmon/axiado-pwm-fan.c
new file mode 100644
index 000000000000..6fca5292eb25
--- /dev/null
+++ b/drivers/hwmon/axiado-pwm-fan.c
@@ -0,0 +1,416 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2021-2026 Axiado Corporation.
+ */
+
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/clk.h>
+#include <linux/hwmon.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/pwm.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#define AX_TACH_PWM_VAL_MAX	255
+
+/* TACH Register offsets */
+#define AX_TACH_CTRL_REG	0x00
+#define AX_TACH_TIMER_COUNT_REG	0x04
+#define AX_TACH_COUNT_REG	0x08
+#define AX_TACH_INT_STATUS_REG	0x0c
+
+#define AX_TACH_CTRL_ENABLE	BIT(0)
+#define AX_TACH_CTRL_INT_ENABLE	BIT(1)
+
+#define AX_TACH_INT_PENDING	BIT(0)
+
+struct axiado_pwm_fan_tach {
+	int irq;
+	u32 pulses_per_revolution;
+	u32 timer_count;
+	u32 count;
+};
+
+struct axiado_pwm_fan_ctx {
+	/* Serializes PWM updates with PM and shutdown operations. */
+	struct mutex pwm_lock;
+	/* Protects tachometer count updated from interrupt context. */
+	spinlock_t tach_lock;
+	struct pwm_device *pwm;
+	struct pwm_state pwm_state;
+	void __iomem *tach_base;
+	struct axiado_pwm_fan_tach tach;
+	unsigned int pwm_value;
+};
+
+static const struct hwmon_channel_info * const pwm_fan_info[] = {
+	HWMON_CHANNEL_INFO(pwm, HWMON_PWM_INPUT),
+	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT),
+	NULL
+};
+
+static irqreturn_t axiado_tach_irq_handler(int irq, void *dev)
+{
+	struct axiado_pwm_fan_ctx *ctx = dev;
+	u32 status;
+
+	status = ioread32(ctx->tach_base + AX_TACH_INT_STATUS_REG);
+
+	if (!(status & AX_TACH_INT_PENDING))
+		return IRQ_NONE;
+
+	scoped_guard(spinlock_irqsave, &ctx->tach_lock) {
+		ctx->tach.count = ioread32(ctx->tach_base + AX_TACH_COUNT_REG);
+	}
+
+	iowrite32(AX_TACH_INT_PENDING, ctx->tach_base + AX_TACH_INT_STATUS_REG);
+
+	return IRQ_HANDLED;
+}
+
+static int axiado_set_pwm(struct axiado_pwm_fan_ctx *ctx, unsigned int pwm)
+{
+	struct pwm_state state;
+	int ret;
+
+	guard(mutex)(&ctx->pwm_lock);
+
+	if (ctx->pwm_value == pwm)
+		return 0;
+
+	state = ctx->pwm_state;
+	state.duty_cycle = DIV_ROUND_UP_ULL((u64)pwm * state.period,
+					    AX_TACH_PWM_VAL_MAX);
+	/*
+	 * Keep the PWM enabled even at zero duty cycle so the output stays
+	 * driven low instead of being left floating by the PWM hardware.
+	 */
+	state.enabled = true;
+
+	ret = pwm_apply_might_sleep(ctx->pwm, &state);
+	if (ret)
+		return ret;
+
+	ctx->pwm_state = state;
+	ctx->pwm_value = pwm;
+
+	return 0;
+}
+
+static int axiado_pwm_fan_write(struct device *dev,
+				enum hwmon_sensor_types type, u32 attr,
+				int channel, long val)
+{
+	struct axiado_pwm_fan_ctx *ctx = dev_get_drvdata(dev);
+
+	if (type != hwmon_pwm || attr != hwmon_pwm_input)
+		return -EOPNOTSUPP;
+
+	if (val < 0 || val > AX_TACH_PWM_VAL_MAX)
+		return -EINVAL;
+
+	return axiado_set_pwm(ctx, val);
+}
+
+static unsigned int axiado_tach_get_rpm(struct axiado_pwm_fan_ctx *ctx)
+{
+	u32 pulses_per_revolution = ctx->tach.pulses_per_revolution;
+	u64 pulses, rpm;
+
+	scoped_guard(spinlock_irqsave, &ctx->tach_lock)
+		pulses = ctx->tach.count;
+
+	if (!pulses_per_revolution)
+		return 0;
+
+	rpm = pulses * 60;
+	do_div(rpm, pulses_per_revolution);
+
+	return rpm;
+}
+
+static int axiado_pwm_fan_read(struct device *dev, enum hwmon_sensor_types type,
+			       u32 attr, int channel, long *val)
+{
+	struct axiado_pwm_fan_ctx *ctx = dev_get_drvdata(dev);
+
+	switch (type) {
+	case hwmon_pwm:
+		if (attr != hwmon_pwm_input)
+			return -EOPNOTSUPP;
+
+		*val = ctx->pwm_value;
+
+		return 0;
+
+	case hwmon_fan:
+		if (attr != hwmon_fan_input)
+			return -EOPNOTSUPP;
+
+		*val = axiado_tach_get_rpm(ctx);
+
+		return 0;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static umode_t axiado_pwm_fan_is_visible(const void *data,
+					 enum hwmon_sensor_types type, u32 attr,
+					 int channel)
+{
+	if (type == hwmon_fan && attr == hwmon_fan_input)
+		return 0444;
+
+	if (type == hwmon_pwm && attr == hwmon_pwm_input)
+		return 0644;
+
+	return 0;
+}
+
+static const struct hwmon_ops pwm_fan_hwmon_ops = {
+	.is_visible = axiado_pwm_fan_is_visible,
+	.read = axiado_pwm_fan_read,
+	.write = axiado_pwm_fan_write,
+};
+
+static const struct hwmon_chip_info pwm_fan_chip_info = {
+	.ops = &pwm_fan_hwmon_ops,
+	.info = pwm_fan_info,
+};
+
+static int axiado_pwm_apply_disabled(struct axiado_pwm_fan_ctx *ctx)
+{
+	struct pwm_state state;
+
+	guard(mutex)(&ctx->pwm_lock);
+
+	if (!ctx->pwm_state.enabled)
+		return 0;
+
+	state = ctx->pwm_state;
+	state.duty_cycle = 0;
+	state.enabled = false;
+
+	return pwm_apply_might_sleep(ctx->pwm, &state);
+}
+
+static void axiado_pwm_disable(void *data)
+{
+	struct axiado_pwm_fan_ctx *ctx = data;
+
+	axiado_pwm_apply_disabled(ctx);
+}
+
+static void axiado_tach_enable(struct axiado_pwm_fan_ctx *ctx)
+{
+	iowrite32(AX_TACH_INT_PENDING,
+		  ctx->tach_base + AX_TACH_INT_STATUS_REG);
+	iowrite32(ctx->tach.timer_count,
+		  ctx->tach_base + AX_TACH_TIMER_COUNT_REG);
+	iowrite32(AX_TACH_CTRL_ENABLE | AX_TACH_CTRL_INT_ENABLE,
+		  ctx->tach_base + AX_TACH_CTRL_REG);
+}
+
+static void axiado_tach_disable(void *data)
+{
+	struct axiado_pwm_fan_ctx *ctx = data;
+
+	iowrite32(0, ctx->tach_base + AX_TACH_CTRL_REG);
+	iowrite32(AX_TACH_INT_PENDING,
+		  ctx->tach_base + AX_TACH_INT_STATUS_REG);
+}
+
+static int axiado_pwm_fan_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct fwnode_handle *fan_node;
+	struct axiado_pwm_fan_ctx *ctx;
+	unsigned long tach_clk_rate;
+	struct device *hwmon;
+	struct clk *tach_clk;
+	int ret;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	mutex_init(&ctx->pwm_lock);
+	spin_lock_init(&ctx->tach_lock);
+
+	ctx->tach_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ctx->tach_base))
+		return PTR_ERR(ctx->tach_base);
+
+	fan_node = device_get_named_child_node(dev, "fan");
+	if (!fan_node)
+		return dev_err_probe(dev, -EINVAL,
+				     "Missing fan child node\n");
+
+	ctx->pwm = devm_fwnode_pwm_get(dev, fan_node, NULL);
+	if (IS_ERR(ctx->pwm)) {
+		ret = dev_err_probe(dev, PTR_ERR(ctx->pwm),
+				    "Could not get PWM\n");
+		goto put_fan_node;
+	}
+
+	ctx->tach.pulses_per_revolution = 2;
+
+	ret = fwnode_property_read_u32(fan_node, "pulses-per-revolution",
+				       &ctx->tach.pulses_per_revolution);
+	if (ret && ret != -EINVAL) {
+		ret = dev_err_probe(dev, ret,
+				    "Failed to read pulses-per-revolution\n");
+		goto put_fan_node;
+	}
+
+	if (!ctx->tach.pulses_per_revolution) {
+		ret = dev_err_probe(dev, -EINVAL,
+				    "pulses-per-revolution cannot be zero\n");
+		goto put_fan_node;
+	}
+
+	fwnode_handle_put(fan_node);
+
+	platform_set_drvdata(pdev, ctx);
+
+	pwm_init_state(ctx->pwm, &ctx->pwm_state);
+
+	if (!ctx->pwm_state.period)
+		return dev_err_probe(dev, -EINVAL, "PWM period is zero\n");
+
+	tach_clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(tach_clk))
+		return dev_err_probe(dev, PTR_ERR(tach_clk),
+				     "Failed to get tachometer clock\n");
+
+	tach_clk_rate = clk_get_rate(tach_clk);
+	if (!tach_clk_rate || tach_clk_rate > U32_MAX)
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid tachometer clock rate: %lu\n",
+				     tach_clk_rate);
+
+	ctx->tach.timer_count = tach_clk_rate;
+
+	ctx->tach.irq = platform_get_irq(pdev, 0);
+	if (ctx->tach.irq < 0)
+		return dev_err_probe(dev, ctx->tach.irq,
+				     "Failed to get tachometer IRQ\n");
+
+	ret = devm_request_irq(dev, ctx->tach.irq, axiado_tach_irq_handler, 0,
+			       dev_name(dev), ctx);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to request tach IRQ\n");
+
+	ret = devm_add_action_or_reset(dev, axiado_tach_disable, ctx);
+	if (ret)
+		return ret;
+
+	dev_dbg(dev, "Fan tachometer: irq=%d, pulses_per_revolution=%u\n",
+		ctx->tach.irq, ctx->tach.pulses_per_revolution);
+
+	axiado_tach_enable(ctx);
+
+	ret = axiado_set_pwm(ctx, AX_TACH_PWM_VAL_MAX);
+
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to configure PWM\n");
+
+	ret = devm_add_action_or_reset(dev, axiado_pwm_disable, ctx);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to add PWM disable action\n");
+
+	hwmon = devm_hwmon_device_register_with_info(dev, "axpwmfan", ctx,
+						     &pwm_fan_chip_info, NULL);
+	if (IS_ERR(hwmon))
+		return dev_err_probe(dev, PTR_ERR(hwmon),
+				     "Failed to register hwmon device\n");
+
+	return 0;
+
+put_fan_node:
+	fwnode_handle_put(fan_node);
+
+	return ret;
+}
+
+static int axiado_pwm_fan_disable(struct device *dev)
+{
+	struct axiado_pwm_fan_ctx *ctx = dev_get_drvdata(dev);
+	int ret;
+
+	ret = axiado_pwm_apply_disabled(ctx);
+	if (ret)
+		return ret;
+
+	axiado_tach_disable(ctx);
+	synchronize_irq(ctx->tach.irq);
+
+	return 0;
+}
+
+static void axiado_pwm_fan_shutdown(struct platform_device *pdev)
+{
+	struct axiado_pwm_fan_ctx *ctx = platform_get_drvdata(pdev);
+
+	/* Best effort during shutdown. */
+	axiado_pwm_apply_disabled(ctx);
+
+	axiado_tach_disable(ctx);
+	synchronize_irq(ctx->tach.irq);
+}
+
+static int axiado_pwm_fan_suspend(struct device *dev)
+{
+	return axiado_pwm_fan_disable(dev);
+}
+
+static int axiado_pwm_fan_resume(struct device *dev)
+{
+	struct axiado_pwm_fan_ctx *ctx = dev_get_drvdata(dev);
+	int ret;
+
+	axiado_tach_enable(ctx);
+
+	scoped_guard(mutex, &ctx->pwm_lock)
+		ret = pwm_apply_might_sleep(ctx->pwm, &ctx->pwm_state);
+
+	if (ret)
+		axiado_tach_disable(ctx);
+
+	return ret;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(axiado_pwm_fan_pm,
+				axiado_pwm_fan_suspend,
+				axiado_pwm_fan_resume);
+
+static const struct of_device_id axiado_pwm_fan_match[] = {
+	{ .compatible = "axiado,ax3000-pwm-fan" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, axiado_pwm_fan_match);
+
+static struct platform_driver axiado_pwm_fan_driver = {
+	.probe		= axiado_pwm_fan_probe,
+	.shutdown	= axiado_pwm_fan_shutdown,
+	.driver	= {
+		.name		= "axiado-pwm-fan",
+		.pm		= pm_sleep_ptr(&axiado_pwm_fan_pm),
+		.of_match_table	= axiado_pwm_fan_match,
+	},
+};
+module_platform_driver(axiado_pwm_fan_driver);
+
+MODULE_AUTHOR("Axiado Corporation");
+MODULE_DESCRIPTION("Axiado PWM fan controller driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1

