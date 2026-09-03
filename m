Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022104.outbound.protection.outlook.com [40.107.200.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1584457D8;
	Thu,  3 Sep 2026 08:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788424738; cv=fail; b=K174rUXxY738E5omtr0KOt6KjmgqMvT160JSecCh7KVn+EPXvSu5rAkHm8S8knvkyJES3FH+CAcsqA2Wez0AoVesQZIolBUfdfbTyJweM8uUl8ArQ838cc2vDVUHgfa37BWGTT845ZRcYnq68ypiPi6mrXeoi3kfLm70dopyDEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788424738; c=relaxed/simple;
	bh=dMwJtonUPElVkcUPOu9lfYnn24781MxEWWK058jeL7A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jt8Omm00DO8kvOL80I0AFs1Pu/izhNGXMuTvIcuYRy7vrBqEbYNTsKlF6521N9+p3UJ9EiFQwV4yonDtPRo0l81H/QVusLqZGOztsbmlh9GQUC+dXCI0BktLx2dnBa3n9XJu2/basGT2w177EqOPl32i4S8Voi+nBjnalqIMcdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=T9Y4Hn8I; arc=fail smtp.client-ip=40.107.200.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="T9Y4Hn8I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jh40OIOQcJ/x603R2UGzxmQy05kl2ZXGWQ+O8pDBPfbBUmyVxLhsq1uHYEdCLkm49VaaY/mKhscrwqWaI7KeTzrk6j+A2b8bOTOp1Y64O+3x08vqmJusfxjtwzXp9aZ7lXbL++FMSRjyTU+/SNwBx0wxB9koGX9Z3ePikKHGMJ8fQnbdWxgPU0YnlNQ/7aVu1UX5eTa+PDQFHx02HDOf4f6PnGeJ+fjniQ5ZFIcz3E1YwtMHgr3x1Cp8VfUBxjvpa18apVTQ5B1ORXnYkIBmcXpQ77knfK5SZuBPuniFALSOVsAlk6vvxmd8kr4h+RjlnrZDiVqVUOkymrKZ8Ns9eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZ24K9IFn5HgSdYf1dSCxlnN9j0nm44w4OWs3q5YCk0=;
 b=etaQVVAggD4gf/YrgGjfsq9U9fIHbVGYGIbs7t/rL9hxJwTH23n2PNrBTQpn6eDf85m/1JKZUfngIalqgDmLYFluyQI3Q5AEi+ZGpPjrzbdqFC4zh8FEFg2mSEuax4lxCprAL4B0flfBTLOCOJ8SO4N/ndJAnObHMWu35JTHq8hRWksUMbKvc2hm2zDQpU4setxiHkuCzgvm1eeuQv5Dmd/GdJSQyv7OSPqvAgOAbi421teqmpBYUlfzJCYHxqohEZIqQaHZioK2pCk1Kv2jp77smZyz0SbGUUWOGaNuK0s4/n8EGoqKkz9ShNTX7STLZ7xpXpIhYPkB/Ke8U1ahRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZ24K9IFn5HgSdYf1dSCxlnN9j0nm44w4OWs3q5YCk0=;
 b=T9Y4Hn8IJrh2mBoJJ9OpXy5VzvSBBJMTT6ZzSDDeaylKG+GE3p0bGkwaFB31VaQ1B0fz5J45/Pp0pczcDDjcbwnvBbaZWZvbdOSbx2DCEmgmjy63O0D0QdKAVq3OBvpl787MmgBrMfuyYCh5Mcyklh+y24Ql7LZfTNIkLJvNsBXWY3sQEZzNDxxVD1zHw3qIcU3euz5xq4OVbsHuCGasrBSA9+ZRYaf/a9z5q6CLinzkOY1BXAJTW+Oq1QYxRvy8osLtGdSrhrAnjcqvlsVgFZQh6hnh5+2jzdfZtlTcT+c8drAw+NmRvcrz5c020ytYJdwekIDQuEnSXNMUjIv1uA==
Received: from SJ0PR05CA0030.namprd05.prod.outlook.com (2603:10b6:a03:33b::35)
 by LV3PR18MB6258.namprd18.prod.outlook.com (2603:10b6:408:272::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 08:38:49 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::30) by SJ0PR05CA0030.outlook.office365.com
 (2603:10b6:a03:33b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Thu, 3
 Sep 2026 08:38:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Thu, 3 Sep 2026 08:38:49 +0000
Received: from axz-uw1-build-vm02.corp.axiado.com (unknown [10.14.1.22])
	by smtp.corp.axiado.com (Postfix) with ESMTP id D268D40BFE04;
	Thu,  3 Sep 2026 01:38:48 -0700 (PDT)
From: Petar Stepanovic <pstepanovic@axiado.com>
Date: Thu, 03 Sep 2026 01:38:40 -0700
Subject: [PATCH v2 2/2] hwmon: add Axiado AX3000 and AX3005 PWM fan
 controller driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-axiado-ax3000-pwm-fan-v2-2-ef43df46163e@axiado.com>
References: <20260903-axiado-ax3000-pwm-fan-v2-0-ef43df46163e@axiado.com>
In-Reply-To: <20260903-axiado-ax3000-pwm-fan-v2-0-ef43df46163e@axiado.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788424727; l=15474;
 i=pstepanovic@axiado.com; s=20250916; h=from:subject:message-id;
 bh=dMwJtonUPElVkcUPOu9lfYnn24781MxEWWK058jeL7A=;
 b=k+/7Fh4G4T7aQSqjvIf/CXTYgwPB6D+sAQymHjMOfo4XmG0oF9+0eYkdU/+BsdKX5Hfk4L6Qo
 v+IIky9a+/EDfR89UOyqHUZo1sHt2+pqsObQ9aCdRdYZnGlHGfVSS54
X-Developer-Key: i=pstepanovic@axiado.com; a=ed25519;
 pk=70f1UJOGT9U11ZK6o+ENXtv0I5wBE3e+Y9YWODzRsdI=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|LV3PR18MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: adcded16-89bf-4bc9-1a1d-08df0996c6a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|23010399003|36860700016|6133799003|3023799007|18002099003|22082099003|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	3FBzOtaRTPVhAGvdRyIVm0NDIescJZSLzu7KlylJ/Yk2HZcK+nMx+/hEghC+i/eWMkqIJ9pzEpHDRo2oLgavwfJOlVCAfzsqhDnsaawyRdP8AJpl4SvbacP0oYy+ZIz9wvS8zaFpLOMRzBgCEk7F+9P/prQ0/BlKOAoU0X8Mx304FygVsMoe7DHGgTbzLqRFcOqDcXnoJe5acSUtHaWdICoSR1S94S/iOXSGP42tzDhZcTqmLfjINesqMAfAqgPmiwFyG9ixGhn7TAL6WPxOS9j9g2U5+0JveEbbcQ+9EOusPZgvHNb/yVyEwnvK8hUz3ZI01MCb92ggEvoguqa/0goFFoEX7yGjZkDRlGgy3bA/85c360UPBImL4VCJnguDJft+14KPk7SLbUG/HXwy9pdn9S5UyLD45YYIEvPh+kAufpXSu19E9i2fgO4aLRHVYcoZbXeGdbMTSumauc9HwE37iR9BVzMpE0mhX6bOqNUaWbvhiKXdKYk/ABlR5GiJCP3JY7M0IQegWiWtoWb+esMb6FiTnbqTxzj1U3Ozk6QbQ7oHYVkydF1CgZuvr2tRyR+lCJsf/GPyOy6XTsVvHKk4L+i5QgFhjZSgWqz6FFh36Ca9/cXCC77VxZbeIhNAI62FCjNWmCyhzWazqSDwZpkIWCSNH0yb1n9iByezCmK5guH4YCnrDuiDAFwTbhPbi0dcWkzo37rXKuj8R2auco/nbnBGwAYN7muYRdom0ye0SJhwi1iAQWTD8T3y1rcl
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(23010399003)(36860700016)(6133799003)(3023799007)(18002099003)(22082099003)(56012099006)(10067099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QK+xPWhC3bU/avik6vRgVe6lu0kYZE27ZKYeGHkvi69dfJImrRRb0hyU8hYp/Or3rM7eYHEYadiSeaRUmEc6mmJpQSh4QdQpAlmPaKhUfj/n3w/ab9OBBfOvbeh46zp4VSzEf672qIb0WUc0wDcEf8vJvTBTqbw8I+AYLkM/IMYE332A3eQtWbthuIqBhQZJv7A0yy0lMBV27FVtfNNUmDlIHZ4rojHZmKG3D7BCgUvoeo2el3uCMbzcjWUs/J7TFV5k2ZeYv5EiSDnwaA6UC2IdQ6fkitLk8I6p8f1s4TsHvv/xDsKsqsJlZk1/W4R1XQbGIiuX1rphWM7hb0UXNpX322C0PydQ6BqNw0dPsVGZkLqpP219xGrV5qVi6mo2gpsuZj0GgroStlJh2FcxOyHsM8bS/DeMe6PY9SehCOsVvjb0XzIAoREF9lapNjdO
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 08:38:49.1745
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adcded16-89bf-4bc9-1a1d-08df0996c6a4
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB6258

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
 drivers/hwmon/axiado-pwm-fan.c         | 412 +++++++++++++++++++++++++++++++++
 6 files changed, 466 insertions(+)

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
index 000000000000..ac153afded47
--- /dev/null
+++ b/drivers/hwmon/axiado-pwm-fan.c
@@ -0,0 +1,412 @@
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
+	if (!status)
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
+	state.enabled = pwm > 0;
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
+	if (!ctx->pwm_value)
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

