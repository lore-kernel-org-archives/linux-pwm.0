Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022080.outbound.protection.outlook.com [40.93.195.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217D6375F88;
	Mon, 21 Sep 2026 07:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789975451; cv=fail; b=mqMNiB7Mq9fbdpMmPEMTZR18KUO1mO6QA6tnHe7K49YMtnQsUZz/cJOgfqkaD90xlaES3tfd3704N11KUmO4kF+JYmZqhswAU9z0i5VM7seL6mWgwvnZZGDVNdmqBR7VsIddc9bO1dvRAqpoVYe7KH3X8+LcZ2hCqxPBNML/ZxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789975451; c=relaxed/simple;
	bh=/C+3DY2QC/MKypn1jRw/8OfYIULH6NJLlhrksy7SNoI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WQq6dXLXzTrZ6cT64Kh5S89P4DHsWMy9LCumRC9bDdoBKZ/XOzzuFTCaiVqD37oKzkLTflEIhwJCU+wt9YsZBlVddPSEJ0bJMm9+EFyuKCVMpsiyg2rjOzozUMYPfdDWGk2ULDcU6yHZxJN5n1EeZV4RKtmgmv+z3+zlt9dhz/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=a+4pC3iG; arc=fail smtp.client-ip=40.93.195.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="a+4pC3iG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gt4LLjXUMMHTsZ51+0bXi9cedpIe7q9978sICMqFmhdreET2k77AjtfwbtVXVmY9Ah2ov+T9PxhCGQPwrpBSkbA3uEEQ7AcTCo8wDbVsfPId68eN+NH0jHyEUTWqSnu0zPIGA4toBTbjiLHgTJZulggtlKzn1Ohyv3gm+kPxyZpv3q5lCQsBcFBxtIbEgQaBFjhBHm+yPezRpzYNNWpdoIex5lcGToclMNOgYqveasbzifXxWhRxrcP3XzRTkbG4tM6BZl5Mv4Togj/1yg7DJ4yRkbxIJJxNOKJbY6rXOEVnhJV/tVVBHdDWFrUJJsoZ5g4fZgs3kgGHzvkqLw/VOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEsJe0rB7vD6kWBWGUoDf7qmKv4QbuQgnSwqHKHqF34=;
 b=kXmJg98fN3BBteE2BN8rXpXguvebsMjHYr2dNXfZ/cbJVYqUElhGemJEcOYQvtwkB7LoxwsdgUZ1+k22hJYOCkzPNh3+WarLflkCiSWcjvH1uKT4mWNfK48gnbXF2fKogqMYUI8qO5iFjD50q/stoEJXkJIXMUwKKxc/k0OLK/U+erNjUZIFP6JaFFACjnA+uC7AP85RcUxY0BL12MaLwdsD1gr/slW+onqGnEvXwyCDvBXFVCUjVbSgGIcx9UAS2yDQmiI0NUCyJQTc5ynR9gS2HSImiS/g9q1Zr5NfWv566VsP4T+JVWlEsuBo2c+ft6E6EOJGl44HFJUZZm3ZsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEsJe0rB7vD6kWBWGUoDf7qmKv4QbuQgnSwqHKHqF34=;
 b=a+4pC3iGOBo7d7u7qjgMBBSGQQ5KHQUKnFsl2J+wG/z/U64mjdkQK+ttcLcR6h6HDPwqgtRRcMfXG0pd5sKJ9S/zyr/l8SCad4fAtA2MIsklXG2APhiQ0IYpR1wlpEeOJYeVcr8j0yU1HMd7cZgOqvHV2aUPKx2BfZELYfXc9UOFa07zPgPXElWD1ufwuwzbe6z6ak76uF/CS+brncvN5j4M8tukDDvf94wiIdb6nljGhEXt7CBU45PiweqjiFxqArGvJWsGrqxgC4O0DVR7pHpt9TulG54z3oYzgcr5EuMRTpcVqz97vKtm2YzPwRnQRy0g4TNALrLNIOE5FZdkvQ==
Received: from MW4PR03CA0044.namprd03.prod.outlook.com (2603:10b6:303:8e::19)
 by MW3PR18MB3628.namprd18.prod.outlook.com (2603:10b6:303:55::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 07:23:59 +0000
Received: from CO1PEPF00012E83.namprd03.prod.outlook.com
 (2603:10b6:303:8e:cafe::1c) by MW4PR03CA0044.outlook.office365.com
 (2603:10b6:303:8e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 07:23:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 CO1PEPF00012E83.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Mon, 21 Sep 2026 07:23:59 +0000
Received: from axz-uw1-build-vm02.corp.axiado.com (unknown [10.14.1.22])
	by smtp.corp.axiado.com (Postfix) with ESMTP id 4FA504186B5D;
	Mon, 21 Sep 2026 00:23:59 -0700 (PDT)
From: Petar Stepanovic <pstepanovic@axiado.com>
Date: Mon, 21 Sep 2026 00:23:55 -0700
Subject: [PATCH v3 1/2] dt-bindings: hwmon: add Axiado AX3000 and AX3005
 PWM fan controller
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-axiado-ax3000-pwm-fan-v3-1-3def8b6ffec9@axiado.com>
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
 openbmc@lists.ozlabs.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789975439; l=3296;
 i=pstepanovic@axiado.com; s=20250916; h=from:subject:message-id;
 bh=/C+3DY2QC/MKypn1jRw/8OfYIULH6NJLlhrksy7SNoI=;
 b=/1shnajBbq1wesHzVKEcV2hXa8uBrtof0jefZeJtIAXZl371CcnumR7xZjEauam1QV7XDtSpW
 BMsW5RhgFXpCxN8JKXLy7tc1URSMMpKYpvgNIaeZ2sBcMu+k9fr4bRQ
X-Developer-Key: i=pstepanovic@axiado.com; a=ed25519;
 pk=70f1UJOGT9U11ZK6o+ENXtv0I5wBE3e+Y9YWODzRsdI=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E83:EE_|MW3PR18MB3628:EE_
X-MS-Office365-Filtering-Correlation-Id: fd5133f4-635a-48b2-06f1-08df17b14e29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|23010399003|1800799024|10067099003|56012099006|3023799007|22082099003|18002099003|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	6PdU3rxI4NBLMigXnvgVhdvYzaiw3Ho4wJFeFn8iMU79X1XabS27LF8T0TpbF4W3u/JXM5Y2eaOD6OEeLos40EeOuH9iY/5ixkSo8I0+j4ZJiwsyeLePbaxSI3gbIpg1b2V3JBBXZj7XiVgOM3uKw9SHhIpNezG8wN8cOmRCywAkYSUyxr+fDD9zNReOmXDaMbiU0sLGaZITkan2P4RsNTvgMcJhJmvQc9uvzwOeRSbS36eLchLoLL70ApCyIrl/O56/UVPBSbx/o0I1vjlNpQLwQGwJyN2+Sdn34YSMUH3KhNjy6XDCzINplWcx23LnEzv3qTnrSXs7KDFdjVwv4EOjhih67Kf+qIdhTAJCltH2y4rz2Tv7EjizJAYcIRURI71AW1moEf1atT/6CDU/tuhwaqHWJLs18qsWrBz7LsNYp2oBHL9uWvOQXQ8u185ej0Wmin9vziQ9hovOkCqaTUrQ54gxI/Dma9YTg/+4Q8+SRh4ZsqsH6mUkVxZ2Mv7a5yu1qnisQcQ1hibqFM1gJIiRaeiWR2YCYAe0WEmc3CTHm6J+KNrd0yUaNI5V8q3mDi5rgcP+QFozwAv3FBfXNFaIgsQIzWQ17SRLhaGg+NyzjRTPIC3EGGBK9s01xovtHOtJw/C206ukWRXUTUev0EVvc+qGmVncY/SJ4JazEgP16SsP/sDCYtKCIgLEjJUs
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(3023799007)(22082099003)(18002099003)(13003099007)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EV855VNtszpT5XFAlF/YNQ/JnCMl/Chm+szSAyk5Itv8JuektFbs36fk7OvknpuAwnGCqdL/OnYYFEuBd/qBjVFt70HinJhdR0IAOeM4nrHq4R5N9UiWhFRhUcGszl/lApxlJQkMrBNi3+yVniLKF1tWxMmB1xmGQ2HXnTxATy0r6JPUDUwCLa++MuPkQLzqywexRjrLi9KH22VNk+TjLtf95/h+Xpco+J+LphfxetkEVuw1pwuAvm+DCKKSMQuYQbEmOs/bSlwlIx9ExWYLTNhEBykXanWm/1zT7EFxsZ89VDKuv6AdxbFQQqCgeivoJuGoaFzoYlk9MiQ0G2UTg+Q//tu2+6pqWo5VYqCyWR8pfgBEAkryKnraN8njy+laMWQYvvMmJhfdpjXLpV+PzdQyLvFIW+OCYKrw1i2jFaLrhcSN5Y5gCPoOeT/H98Jy
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 07:23:59.6978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5133f4-635a-48b2-06f1-08df17b14e29
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E83.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3628

Add a Devicetree binding for the PWM fan controller found on the
Axiado AX3000 and AX3005 SoCs.

The controller measures fan speed using a hardware tachometer block.
Fan speed is controlled through a PWM signal supplied by an external
PWM controller.

Add a MAINTAINERS entry for the binding.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>
---
 .../bindings/hwmon/axiado,ax3000-pwm-fan.yaml      | 72 ++++++++++++++++++++++
 MAINTAINERS                                        |  8 +++
 2 files changed, 80 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/axiado,ax3000-pwm-fan.yaml b/Documentation/devicetree/bindings/hwmon/axiado,ax3000-pwm-fan.yaml
new file mode 100644
index 000000000000..76a3e12fc656
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/axiado,ax3000-pwm-fan.yaml
@@ -0,0 +1,72 @@
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
+  fan:
+    type: object
+    $ref: fan-common.yaml#
+    unevaluatedProperties: false
+    properties:
+      pulses-per-revolution:
+        minimum: 1
+        default: 2
+
+    required:
+      - pwms
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - fan
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    fan-controller@33001400 {
+        compatible = "axiado,ax3000-pwm-fan";
+        reg = <0x33001400 0x400>;
+        interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clk>;
+
+        fan {
+            pwms = <&pwm0 0 400>;
+            pulses-per-revolution = <2>;
+        };
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

