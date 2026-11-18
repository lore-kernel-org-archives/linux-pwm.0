Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.135
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795005743;
	b=dj6y0U6i4O7aZPr7IChDN1j1fieCkaJzMtNMWY8i9FCW+wm7ugX/h/E+imOsFuGHEb4C
	 ST5C69VTn0gifN9kGX54rM1Jn6hn/V6Zyu6oUkiGodXhGLTgy5SUlKfKHCg1GhLRohCyd
	 Y5v/Lr8AO1nof3b5TbQpu6W02uf1c9qHm9fnzVj3j4fph30v0iAGfxPuIRWgCP4SsItmv
	 b2KSkwhmiHJUIeAPvuJvd8yUCoFzRzCBvfDWmdOOEcX7M4QkvC6xUza6VfCGPyCSKDUuE
	 cHrrXNjetd2ueaW6oZXD+cX7SV2c+vrrgqZX62xUg+iBgzCtsFAcQ1PmygqMw/P9OYg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005743;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=pbHIj214Hk02i60FxDGc0rIbuGw9Ckkid9eISLKfVhI=;
	b=ck4YMPk7Jw06IXgwlxP/A/2H388C6apGXKOygCwKK8R/5jBXOO4dA3g0S3IEzn+BnGDe
	 WAsWdbwmJjK+FT0vRIqoVCwpz93v0znj6gmzzpBADJ2LjgzOh1KPbsAEpH84jF4IaS5aU
	 jYOVyh8r6oN9q6dtw73RLrCsGthEHIY4p071IBaXDZ0ZP3J/maB5lUWfnI8VdT8tC6gXr
	 JFI1ZRhjxSWI0MPZQE8vphY78WaOnHe76DxtWWsdU8U60DgZBNCh2/A10PJE24W2mtxbO
	 JmlcWFWvVZP5ur8CsurlqM3kmBU//ECljF2r8LfaIjKKVDOjr1hGuMUUZHvB67faHXw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=axiado.com;
	spf=pass smtp.mailfrom=axiado.com;
	dkim=pass header.d=axiado.com header.i=@axiado.com header.a=rsa-sha256 header.s=selector1 header.b=hyBSGB+V;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.135
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021135.outbound.protection.outlook.com [40.93.194.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA29060A2619;
	Wed, 18 Nov 2026 12:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA29060A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=axiado.com header.i=@axiado.com header.a=rsa-sha256 header.s=selector1 header.b=hyBSGB+V
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMZcx6Bn14Q2RxnUUvpylh6XJtF7rPTBRmwRTJb5xmdM8MNGLKhM5y0UCkvNnaMNcl9xeb7crCfqeF0cRIYa9nLFXXu9lIKgq9PNfMDU8ioDO2cGvrsGFDtrxIXZfWPw6NEw6psXKoAH0Jhw8hNVPx+seGOllkuLajXT63hQGoPvbXTGLHDYY7QV41hl9BKed8yH+pEykDGTpFB1cP6In0JlXzj0HRxzodI+ElSfWUfASr+Bp30VzuyptucoLLrOPemwvZEp+/AdMtGDPE7FD5vYN5GlGY2acTHgbSZ2NMaM7+LzjJsqDDkprQJxPuxrRE+6izcNxOyeE9njQnGUQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbHIj214Hk02i60FxDGc0rIbuGw9Ckkid9eISLKfVhI=;
 b=r4yYRgAY1NNES0Q1dlk+BuyCm5/x1j4tX3tbxsZZQJsHrhfUURQMC2ACKnuhjGU6M8LXIrjyqGHII/fVvDW+iLEcCKNbP10wXRZce+Kdy13J/gIUK7eyLjY8UX080saKpc7qfoxCFKa8M6eaTxjChy/29Qbn7fzj66xUeS3hVMMu+E8Rxy92Isc8JTpZqqp4M6sLVwMRAjuumm5J1/uayNVm5o5ps28PiXfJsyWRYRDOvjff5P3k44AHlfqys5ObcDZAhXiEQcKGQorST6iOPSn/Dw3ocOEpWvhKrPLJEDxAhx0oKTh25aL/M1tA6g+9XtKU2hO4HiaWVpdNbHfsZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbHIj214Hk02i60FxDGc0rIbuGw9Ckkid9eISLKfVhI=;
 b=hyBSGB+Vf0ReXo9O7BodjF/W3Ps3AmB7VcNGwUbttxeq6EgG0IvBp2KDjuMydALW5aUETt9zrK+MV+M036dwj5Lj4FxSaLvlzj+THNY/rZNOwf5uPMOOnWQGRIyJ7mOQZHSERGjLpEtwkH/vxjLW+sYG/I9tgYNs1g9moVqqynm0AC3J35V0Kdva8lk03iPvvxSEY0SJ9h8d58wmAvMO1Fmhm33iMP+S/IPr2YB6ofYvNho/MUdD2GtriGieCNDd9UUKwxMwU/RBM4v7EvvtHw8JBTGqS7A/RiPmWtJfxcHEyDCD19nsPw/Y5m8ew5VuyudDmkzC11Y7GZs65caZZw==
Received: from SJ0PR13CA0161.namprd13.prod.outlook.com (2603:10b6:a03:2c7::16)
 by PH0PR18MB4591.namprd18.prod.outlook.com (2603:10b6:510:c2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 12:42:16 +0000
Received: from BY1PEPF0002696A.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::90) by SJ0PR13CA0161.outlook.office365.com
 (2603:10b6:a03:2c7::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.8 via Frontend Transport; Wed, 18
 Nov 2026 12:42:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 64.62.143.114) smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BY1PEPF0002696A.mail.protection.outlook.com (10.167.244.154) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 18 Nov 2026 12:42:15 +0000
Received: from axz-uw1-build-vm02.corp.axiado.com (unknown [10.14.1.22])
	by smtp.corp.axiado.com (Postfix) with ESMTP id A38974186B58;
	Wed, 18 Nov 2026 04:42:15 -0800 (PST)
From: Petar Stepanovic <pstepanovic@axiado.com>
Date: Wed, 18 Nov 2026 04:42:14 -0800
Subject: [PATCH v7 1/2] dt-bindings: pwm: add Axiado AX3000 PWM
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-axiado-ax3000-pwm-v7-1-bbd21a8cf861@axiado.com>
References: <20261118-axiado-ax3000-pwm-v7-0-bbd21a8cf861@axiado.com>
In-Reply-To: <20261118-axiado-ax3000-pwm-v7-0-bbd21a8cf861@axiado.com>
To: Akhila Kavi <akavi@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>, 
 Tzu-Hao Wei <twei@axiado.com>, Karthikeyan Mitran <kmitran@axiado.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 openbmc@lists.ozlabs.org, Petar Stepanovic <pstepanovic@axiado.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795005735; l=2434;
 i=pstepanovic@axiado.com; s=20250916; h=from:subject:message-id;
 bh=Ovyp0lmVWDOK8u38msydnUtLEbKhOScK8qjkDwjN1xI=;
 b=SsHinR3KE2b59M8qelHKG9FT65I+TNI11AplZC/eku5cyf7R0Lezesm9aKeXqpHC8//I2RlZY
 IwuO8nIZPIaDHLwAf+XHjXXjhOkQ3DspoGeksDTMaMGXbEUbX3/JhrK
X-Developer-Key: i=pstepanovic@axiado.com; a=ed25519;
 pk=70f1UJOGT9U11ZK6o+ENXtv0I5wBE3e+Y9YWODzRsdI=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0002696A:EE_|PH0PR18MB4591:EE_
X-MS-Office365-Filtering-Correlation-Id: b105cdba-1045-413d-d5ed-08df45716049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|82310400026|1800799024|36860700016|376014|261102123227099003|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261022105027099003|56012099006|10067099003|22082099003|18002099003|261009223027099003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info:
	jBtb6P/P3N/8iTq7VojaEakV3RAPGYTbnLaW4Q58DftPMFdEk1nsVDyZ9Dr6RiahUBwqnSTcVWAlGIQdad68tJFhoguQgzyynZZ5H4iVObPk8LDzZaAp6b6sDHYQ8CpfCZAKWAJE4/drSOK2opGdX3CRd+1mMiZY9zMIw15sEa2nsMdwPHnGMbqd28XUie9wR81Qbg6Cg/oKNiZMZxXXj8rzqizXK8vex61F5WxnU94pl/gy9QMYvRwIeDIUBuWcQvpSiST0DgBgS4A67bzu1sn2gkiIubzUvbT0dE21+rJa5KoAo2qcs3R1Eh2cE6otAIMnGdBV1p8hw/NbegnY3Wxy2nsrVw++WRHQZ8pDWKORDf5GXBT3cS+J54Jio19NScdfgyGMmZHNyHcmcBiyCqm4j10t6bn1tiOci61isk8TUZVBlRyCqf8zwjlAFU8BN4+RcYLXmtRJ46OzTUjtpFAU8DNVeOB67lUEulqWsQ/LOLy7NYg+wHwyKhx43aj5UnlkJb30n4/mSlzr5pJNAyoirLVMogWd0Kkw3kYnK3B+aqxOPKThJs8RMZ1uOqDbyKE+JVchR6tZsQUMOReiFCdLDqwTQI6k2yn6zKHaUfbrvxmVymJ4XJL8jMBm0j9zDvODd4RkZ5Hj5wPsorWFmg==
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(82310400026)(1800799024)(36860700016)(376014)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261022105027099003)(56012099006)(10067099003)(22082099003)(18002099003)(261009223027099003)(13003099007)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	d7s00itYJ9OR87pcvgumWIPx9xMwrUfUktk+zSZwccvjPLosdQVOYq3negvnVv/z0Ksf9msFOROIN6BJ5mFEu+t4L1lABdbzQHA89xjZH9+FsGMJ8FvUM1vNjvwVQi3rWqemrJ/4/PTf3+q1IcTRm3KAQ4XlTE3AqKbdl9BjRrTSzWhMaFZJJ2pESMqWidFdUjAduW5Dpb6kOS20f7NbvpOwHY/6swFHeLaNfXNT38p7nusKqp34wuaT7B41gqIrUI7WV3uhMI0vetvbmiUcDSABXK79Bqu6DHE/pg8WvGM4jcBLfl2zSjkwt+fgstVA/Jun1W3dXVJhFLD/l1Cnjwt96gN1LlCKZejfcdQEFOS4wFQK1ysOML/FgRP83I9s753rCFG+Aa4i4NX16wM/2wSbM8ffeJlBvmlik0R4ErpakBBThHx+1g5WnmVlQxrl
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 12:42:15.8261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b105cdba-1045-413d-d5ed-08df45716049
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0002696A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4591

The Axiado AX3000 and AX3005 SoCs include PWM controllers that can be
used to generate configurable PWM output signals.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>
---
 .../devicetree/bindings/pwm/axiado,ax3000-pwm.yaml | 53 ++++++++++++++++++++++
 MAINTAINERS                                        |  8 ++++
 2 files changed, 61 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/axiado,ax3000-pwm.yaml b/Documentation/devicetree/bindings/pwm/axiado,ax3000-pwm.yaml
new file mode 100644
index 000000000000..f0d5a3dd70e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/axiado,ax3000-pwm.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/axiado,ax3000-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Axiado AX3000 PWM controller
+
+maintainers:
+  - Petar Stepanovic <pstepanovic@axiado.com>
+  - Akhila Kavi <akavi@axiado.com>
+  - Prasad Bolisetty <pbolisetty@axiado.com>
+
+description:
+  The Axiado PWM controller found on the AX3000 and AX3005 SoCs.
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: axiado,ax3000-pwm
+      - items:
+          - const: axiado,ax3005-pwm
+          - const: axiado,ax3000-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 3
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - "#pwm-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    pwm@80801c00 {
+      compatible = "axiado,ax3000-pwm";
+      reg = <0x80801c00 0x1000>;
+      #pwm-cells = <3>;
+      clocks = <&clk>;
+    };
+
diff --git a/MAINTAINERS b/MAINTAINERS
index 222b7fc2c3aa..fe85aaa5a7eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4555,6 +4555,14 @@ S:	Orphan
 F:	Documentation/devicetree/bindings/sound/axentia,*
 F:	sound/soc/atmel/tse850-pcm5142.c
 
+AXIADO AX3000 PWM DRIVER
+M:	Petar Stepanovic <pstepanovic@axiado.com>
+M:	Akhila Kavi <akavi@axiado.com>
+M:	Prasad Bolisetty <pbolisetty@axiado.com>
+L:	linux-pwm@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/pwm/axiado,ax3000-pwm.yaml
+
 AXIADO SARADC DRIVER
 M:	Petar Stepanovic <pstepanovic@axiado.com>
 M:	Akhila Kavi <akavi@axiado.com>

-- 
2.34.1

