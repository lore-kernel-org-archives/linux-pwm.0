Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020103.outbound.protection.outlook.com [52.101.85.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F18530DEA3;
	Thu,  6 Aug 2026 09:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786006901; cv=fail; b=VLUwRgC9HecwmnRl78GbQVQ7/tvlco3R7zVokRCiZo4gAnwG2jSxL/dyJ53HJ2fQ8k7+pOPkp0JBnwLyTWGU/zrMAQm20907SNQmBUifMiZiRhSWetVeCxyIUNSWnp1N9NLb989YBOwubMHdrHB0AOpB/7fM9RyADufTxKBLkNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786006901; c=relaxed/simple;
	bh=0AjNPWV5OPhrQhjPlrG6C5c7ICRCle76yQboEFhoosQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EFw3bdEV13duPo9QhILRqCsWqbdFidEtswRtH/8y/Bx6nL+nMtTGmi/GZF3NT6N8gg8wbRxRBc6XfxfWkB/2HzlFEIiw+7WVJ3d0RVVO2PMI3yRynaucekRCfFBfJ1yaXswzqjebzpbjxjXHgCA0nSvkwmdTEmP62XXt9BubpDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=bBONLShZ; arc=fail smtp.client-ip=52.101.85.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="bBONLShZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w84G5CqXi4g9q/JzACxj7A6qg2KGfyQ+IZrPrC9ZAccleRtzQ5Bl/fziJWCS1nIrft1u2DCY8+T/vwcjdp1y8EDs0/a0BI57Z6ENf/4VGm69EX71IjL9CaWtaDdk9jmhdSfuTEESg4/Uo57AC8/wOHzoixApOLTANM2OLiwVgz3+g0LNeKbcub9iQvEwZvw5J51ZEkieHC6a/BaeeUJe8mPF/7iep6YGHDYhH8kpVGfy1x1cuhDWTUXzxjck59uBEipT1wUMkd6a6RllxLDJtV2mXlLL9tTfEIfQh9sxbbWV+wQdxqJEROZRxxqQ5aW9aFRsYKGP04m6kjt8CeCpJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cumNkGH2fsBGNARNBjuk9zDJze4M94YJWYb1DucRGM=;
 b=GzTTDFHIF7Kl+09pBI2YoR5eB2PPePZm/kMv9ve7z3lYWITXq8yvXnUdx3ivu735tYz5fHpvWbOXhl8QUOSMjSm02umeFKpl5We3xdM0D8PyjccKurx7V1dxsVI1z4aDjT2XheIyvNLvLD6sL7xUCSyNL3ybP4BvuRlzyLlLBKcDO+Xo1AmwL9WtQIAx0N3KNKv2AWUNAomCLMX0NfdLeXFgft4dACLyEeO0p6OcZHYo9dfDyGffeAZEmxtlCN5ut57ERB7SklIyVi0RlyZN/a68afCXsIz4yBe0pR/iLfiPVWR3UI7Z3m/4yZzBeDZ03iLwBepLaO9p3350qSiaFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cumNkGH2fsBGNARNBjuk9zDJze4M94YJWYb1DucRGM=;
 b=bBONLShZYAvFGSEIYoE7y7k1ksFkvs72nc0CgHv5nO0C+PfIEe7THmdv8hocNkaVtJDeMTh07D/TpLp3drOyFT5Y+sYDNTkbqmhuVDr+qw94eYBZ3RBpXtBRB0SQ2ewbzu2m5Dy+G79iLfjdm49VpxxKMJIpXfJ82gYAey6yQggwQTqtxTkYLMwAS4XfacACpR3U1VmBsKt8TVouI/VqYHS5b0gZfYVz5uvngoUbjgYrtJestjqy1540PHPsgdcRewLDnKEh4FOfemS1GZoBhPaciJiaRgFP3XTSteP5SYtBm1XbvUzMNrluOm3Fkb4vWx29r3aDj3d0ueID1NeI2A==
Received: from SJ0PR03CA0196.namprd03.prod.outlook.com (2603:10b6:a03:2ef::21)
 by SA3PR18MB5391.namprd18.prod.outlook.com (2603:10b6:806:2f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 09:01:36 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::26) by SJ0PR03CA0196.outlook.office365.com
 (2603:10b6:a03:2ef::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.19 via Frontend Transport; Thu, 6
 Aug 2026 09:01:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.6
 via Frontend Transport; Thu, 6 Aug 2026 09:01:35 +0000
Received: from axz-uw1-build-vm02.corp.axiado.com (unknown [10.14.1.22])
	by smtp.corp.axiado.com (Postfix) with ESMTP id 8B4984186B58;
	Thu,  6 Aug 2026 02:01:35 -0700 (PDT)
From: Petar Stepanovic <pstepanovic@axiado.com>
Date: Thu, 06 Aug 2026 02:01:29 -0700
Subject: [PATCH 1/2] dt-bindings: hwmon: add Axiado AX3000 and AX3005 PWM
 fan controller
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-axiado-ax3000-pwm-fan-v1-1-f6db4cf2166b@axiado.com>
References: <20260806-axiado-ax3000-pwm-fan-v1-0-f6db4cf2166b@axiado.com>
In-Reply-To: <20260806-axiado-ax3000-pwm-fan-v1-0-f6db4cf2166b@axiado.com>
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
 linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786006895; l=3222;
 i=pstepanovic@axiado.com; s=20250916; h=from:subject:message-id;
 bh=0AjNPWV5OPhrQhjPlrG6C5c7ICRCle76yQboEFhoosQ=;
 b=ntmYImKE9EO1zK/rQXo5qJwdIotDKd1YGbfZWuzYV83+acbAYrKEilY/j9UPaLZkVL+pw+qPg
 XXea6ws0rygDhRMf/BNvfLFf14WLlYSNuToF/VLB6j+Z4i8OfybQq7t
X-Developer-Key: i=pstepanovic@axiado.com; a=ed25519;
 pk=70f1UJOGT9U11ZK6o+ENXtv0I5wBE3e+Y9YWODzRsdI=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|SA3PR18MB5391:EE_
X-MS-Office365-Filtering-Correlation-Id: 19e26bbb-3e39-4fe1-9d3f-08def399519c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|36860700016|82310400026|7416014|376014|10067099003|56012099006|3023799007|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	W3HMMw/e9KJQ7VZoDBXkUJxp/y7tVSmJqsxHKrcvU5pIJAy/ODDyF57Cwcv/I4Al9SHR3wuAhTrKuUU9Mvs4Shn1SvNE1tWEm0mzh6sx2kyBXgNn8jFtSnl24vgVx9WGtRHHrRIT3IuVn0iQCPhqE8rj8pjPXVCMidTBe8dAkaL8YYKtYImnnLn+xCABPvnG9TEylCvK54SR3E75IMy0nMPgZEvrmbJsGWM0OQoUlk+ddjyQuxhlaUFOQkDcwTCmvxhN7pvva+C/9WXqEHzdeiDvpzjb2qWYoCDl/p2lDdZivPcDVLNtQ1IkfzieIy0e6LXaJdiJVtsTYPMj5R+hBVG1uBAWwleN1qmQl2UO1Cg3D6c88a8jgsy5oa+5S0toi+DRuoDGXDjXwrs+zkh1xIPg+hOIwmGAr907VIT4094ySICpn3BYepDTqxI3av1SzMIBeV0k3eZiQU/ei5P5z7tpbr8YFXe6NsTZSGPoelTLaESmP+MjV1wTkyGsRnsT6B23GyEfit7C1+A/w8o6SC4XV+7ufDmgO06gzGvA55ZSZDzPloLGrOiamM4DdWyWgCScCTMqgRs8/tvJbi/YXyVOQoebx1/9FmY5WxdLe1MfOrHwV7Xdd733fl6k443CSx3gR3E835RBzaIv5K5FpdSIGQXfaw1WutjhjjRkSw44VwQ+ksjpJj4ujRRFcME6nfqg0wZ9fBw/XZuWoduk0cG77cHVVrBGqY2f7Ww5EU1jzoPmTgNhiXxMFTu+hm7b
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(7416014)(376014)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kWQDZBoAoJyWSShn8BRUsULSJEe6eEQjY5tSjaD0dATShEmgpQ2J68Nto11McmWaBm1+PxAgG8HH9AMK0E8qisxTobDq0iJm/+AWNJ/1eQCwcRQ8UQ+XB7PAJtdjwkcefII+TfrIy7x0yjsVw9ZYbjygf9olhdqGFNiwLx0b/DZ5/Rd/XiAvRKVl5afcu+Lib99kwwRQlIj6cQ30J6pyA9svAlObZuQHpRvFrPwV8gDQedQeTOLX5kHdYorDL66WprXX9Q1ySTYsROemrASpbwdHuOeulfEULUlbEyWxEQvR3IEssIWg+XADunDVmrcNGxyGdwKTbbpoLVf6Bav0YaRIetV7a45NM53lNbOt+4/VErQM8mHUzkN2JKidbYqf0WjqBEmmTuSFJ5pibUz1FXbc5Skt2L6T/beriMmxub2z4YOk2OvJQx5Q43kmyA1X
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 09:01:35.7482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e26bbb-3e39-4fe1-9d3f-08def399519c
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR18MB5391

Add a Devicetree binding for the PWM fan controller found on the
Axiado AX3000 and AX3005 SoCs.

The controller measures fan speed using a hardware tachometer block.
Fan speed is controlled through a PWM signal supplied by an external
PWM controller.

Add a MAINTAINERS entry for the binding.

Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>
---
 .../bindings/hwmon/axiado,ax3000-pwm-fan.yaml      | 68 ++++++++++++++++++++++
 MAINTAINERS                                        |  8 +++
 2 files changed, 76 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/axiado,ax3000-pwm-fan.yaml b/Documentation/devicetree/bindings/hwmon/axiado,ax3000-pwm-fan.yaml
new file mode 100644
index 000000000000..a985f49bbdcd
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/axiado,ax3000-pwm-fan.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/axiado,ax3000-pwm-fan.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Axiado AX3000 and AX3005 PWM Fan Controller
+
+maintainers:
+  - Petar Stepanovic <pstepanovic@axiado.com>
+  - Akhila Kavi <akavi@axiado.com>
+  - Prasad Bolisetty <pbolisetty@axiado.com>
+
+description:
+  The Axiado AX3000 and AX3005 fan controllers use a hardware tachometer
+  block to measure fan speed. Fan speed is controlled through a PWM signal
+  supplied by an external PWM controller.
+
+properties:
+  compatible:
+    oneOf:
+      - const: axiado,ax3000-pwm-fan
+      - items:
+          - const: axiado,ax3005-pwm-fan
+          - const: axiado,ax3000-pwm-fan
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  pwms:
+    maxItems: 1
+    description:
+      PWM specifier used to control fan speed.
+
+  pulses-per-revolution:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    default: 2
+    description:
+      Number of tachometer pulses generated per fan revolution.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - pwms
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    fan@33001400 {
+        compatible = "axiado,ax3000-pwm-fan";
+        reg = <0x0 0x33001400 0x0 0x400>;
+        interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clk>;
+        pwms = <&pwm0 0 400>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index a674e36529f7..f528b1a42e0f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4457,6 +4457,14 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
 F:	drivers/pwm/pwm-axi-pwmgen.c
 
+AXIADO PWM FAN CONTROLLER DRIVER
+M:	Petar Stepanovic <pstepanovic@axiado.com>
+M:	Akhila Kavi <akavi@axiado.com>
+M:	Prasad Bolisetty <pbolisetty@axiado.com>
+L:	linux-hwmon@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/hwmon/axiado,ax3000-pwm-fan.yaml
+
 AXIADO SPI DB DRIVER
 M:	Vladimir Moravcevic <vmoravcevic@axiado.com>
 M:	Tzu-Hao Wei <twei@axiado.com>

-- 
2.34.1

