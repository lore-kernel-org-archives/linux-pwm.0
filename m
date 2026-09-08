Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020083.outbound.protection.outlook.com [40.93.198.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8BA434E5F;
	Tue,  8 Sep 2026 08:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788856129; cv=fail; b=lKxEkVr0jNiKMohHs7nBzG1DOGlvbc0cUI1Kt1Ms5VNjEA8VjmLWqetqnk+UwzVCQQTUxMWgggaZrn7uI1qw+7EJ3gYBdQrgAGquLOfsfFHYR5Oif13t6fGw/nKtalA+iMWVvjlF5C2591CFGEo232dJI/OJ2EEtAtoI3mIVgMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788856129; c=relaxed/simple;
	bh=6pfwkUarUCb3gzJ63Zcspm+3oWHggZhK8WjqgQjx8fU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IwZu4At3zehy5jxl4C9SfA8Y4YylhZXB2nk6Hna6nt/XibHlaeFQwj2pI1ie2aSiTw5PYHJlah7Ba1iMAZiV7wruk3rGV/ibhwPKMN+G4nYkpQmYNrXjbq4CRgW439BV47ZGxYgRGbYBXAgOQIjJhAT4yymSt/xG6kRARw04I5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=jyhLthcb; arc=fail smtp.client-ip=40.93.198.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="jyhLthcb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tDsRLYE3lQhm9yw6vfU6bIfUXiWDz1UZQqx0/6p19/OZ06GNiwMZJIq9QVFnUB/c+aXYTlss96ApdZtXcRM+mcOFIJj8qLJCQhaKJjFB+b5NHes4YPrKQz1ToqMSoWtD6epeBTp4mj30vBCQ9G97mbVge8dWZmOyIwb+ESXc3QQd5ZTxgY5WeSfIBEheLDy1r3dETAsyNAY905j9SmkVJt3O2ZJJNmNt3/mHsFaMeMdpoeLRr8EBqYEUbUOb0fT36ISwB9Q5laVNlaRNGuqLcTLrRu+h9PiYGVhFQ+KPBWMZ7DxBuwJoSvYrUilKKcZeVtpw/oRKLsfqNcadfZVluA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNKB0qvsMCjr+ibrMp9Y1VW6wlLfG2e8zCw4E9cQBPE=;
 b=EGt8bQ6Yl3UqHWa9Ob0gw8gMZ9IrrRPTI5tTjJvviU8HWLWf4RLRoRr6W/KACCVLuhS3LiG5YC9qtu8M8FClg4S4e6jpTxnshn7Zq7wSNzV6CwhyCngI6FVPtjreD4DCn5hS6o6LYv/HmEzN0mR50HoYrZg36ouYOMASwS+hdyDe/TDnjBjPyl/uxT5s4BPOhIAe2J9S74iu79Ai68eJVcJ+9uYpK8wC9ifLd/bRL2psemqFEAKSd8BiupdjlGTgLoa+yznyK4PfkRCuj7Fx9DIyAnOP5Rgcp837RBvCkUHID/zeZPfKHoTShpUcDx1r++UREC6TkdnH5NJ2dD9ZmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNKB0qvsMCjr+ibrMp9Y1VW6wlLfG2e8zCw4E9cQBPE=;
 b=jyhLthcb110uaPepxmHwEh8EsK+E1yv5u5p/a8ijvof3+xl1S7YDOLaqqghNf4zU8az/sIg8bIoXDDpwQxl/4gTOF+uvThvpkbkks/BPidv8QmEhFp9X2GCGjkMCNutWwl/zOuSEcOlwIrKhC36HMO6Fzn0Lmen7W36X/y8Yfw/9P3j4DJuvCMC44ULgbBpuQbYny0oLPbEkU6lpnOWl1T5SidFnaE3dXXg/J3Y2FtT3PgittUjeXAABjcD33Lb02mq7fMt+XPHMfIyfLlSav+/hqAYbt/+LriCuSh+GZpit2xPkQtG5HUArEYzgn0fPWeAIn43sstL4ePadOrpZyQ==
Received: from SJ0PR05CA0188.namprd05.prod.outlook.com (2603:10b6:a03:330::13)
 by SA3PR18MB235022.namprd18.prod.outlook.com (2603:10b6:806:510::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 08:28:43 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::8) by SJ0PR05CA0188.outlook.office365.com
 (2603:10b6:a03:330::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Tue, 8
 Sep 2026 08:28:43 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Tue, 8 Sep 2026 08:28:43 +0000
Received: from axz-uw1-build-vm02.corp.axiado.com (unknown [10.14.1.22])
	by smtp.corp.axiado.com (Postfix) with ESMTP id 3CA1C4186B5D;
	Tue,  8 Sep 2026 01:28:43 -0700 (PDT)
From: Petar Stepanovic <pstepanovic@axiado.com>
Date: Tue, 08 Sep 2026 01:28:34 -0700
Subject: [PATCH v4 1/2] dt-bindings: pwm: add Axiado AX3000 PWM
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-axiado-ax3000-pwm-v4-1-19a03671cd5b@axiado.com>
References: <20260908-axiado-ax3000-pwm-v4-0-19a03671cd5b@axiado.com>
In-Reply-To: <20260908-axiado-ax3000-pwm-v4-0-19a03671cd5b@axiado.com>
To: Akhila Kavi <akavi@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 openbmc@lists.ozlabs.org, Petar Stepanovic <pstepanovic@axiado.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788856122; l=2395;
 i=pstepanovic@axiado.com; s=20250916; h=from:subject:message-id;
 bh=6pfwkUarUCb3gzJ63Zcspm+3oWHggZhK8WjqgQjx8fU=;
 b=OKcIof9UtYiAnxr+tzOGMtK342ArbfnAO5gmYi0lKRUUVStoea6LXoKsgDW0tQO4vqpm6mkJ/
 EgjXSHB4dkICekd9PvY/JnG8c6uHTCf+MN/e4paZ2jIVR1guYv1cHZZ
X-Developer-Key: i=pstepanovic@axiado.com; a=ed25519;
 pk=70f1UJOGT9U11ZK6o+ENXtv0I5wBE3e+Y9YWODzRsdI=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|SA3PR18MB235022:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b0320a6-8bdf-4578-4191-08df0d8331af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|10067099003|3023799007|56012099006|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	lovVl1ohG0xT3npvhdXUQVOZksoD8q9LkKFbQV/5+b3v7li4qWDXmabzqOLchmp/UqXlENm2CA3XTKRM5hGxhLgpJLO4f4vNJ1TD8DOyxJ829xDnc0pGYXV8Q5w6bH7zGm0aZLj5lBrspK/k7Smts/dB6bXC1wzgyxwmD8uE2VAXX0CWbuJn/VKZ0a+sEuCby6mVGHSZ9McMLaCTcSql2mNkXJcFi0aibbcR4oywH/KwkEwj84MYzCwU3nfWuXa+EJIFI8JaV0klZYXz8yfwUIzQvdmPZf4AwR+MStHdkVzE/kxgZNQ/oWuJL7Yco8jytV9aQsY12jTmFWuLGmBvX1biqlV1fGQPS3E7L2y2w7jFDfidi54GT2oCElqIR4XKnUVWtaF+WT2k3u0pC5bgusru2RquqngXDrduVFwl4dYAApANKqQIKpjUEtraaLj6A3tHceBzAp6hGwO3yyI96n4sOe5ILQiHoDsz1Rt5Tobv3idzao/hwr4/8TxvOU7qOK+hwJ0L7trp7EHKRw+FQHbD+nluWiKWISXFT1HOip+p3uei+ZVv/cbjekyVg4U6+hlK8xV2spEPKQJdrjntWH90RWDbe0a0GLT6FWgQhSY3M6al97KLnjHdeEEqqfBj2CHim8hXZz0A9y88U51XUg==
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(10067099003)(3023799007)(56012099006)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pSpQ1MgeV3sSoeLsIRnSA065t2Cbp2iVfJ/XQQM4JxfkASIyefs36py5HIkMTm1j5ZUDlDKUtAlfZJoMZnQIoo4xzJunqfFnqolpLmECC59m0ku8DXx/rvTSW2rHH0Tw1D79mpxhJXe/1fZK6ExwqmxYEVHp6bUv4QrH1Ds12zERv5SDNJqigPwh0uHi1NNVq1M4A3YIUaluKuwxByUAANlvoidBjLtPtjlLBBwLVfewdNtsYZEy+KYqf6YOZ6soECgcLccA+oaO1wrUtdUP531xOfk97IwsNPNOOtysogBhqG41WAADmpA1W8bELLddQTUqkWoco20qNqReQVGHc1hRxQXKU9i6v2hM3Gw6UkwLYt6UMgeJRiTTwmwKDNcwBik00IcsXRE6Mh6OGqWxK5JFnrPoVDxDRugEnkTF3pNItT8ZDt6zAxTn5+vJlmYE
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 08:28:43.4394
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0320a6-8bdf-4578-4191-08df0d8331af
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR18MB235022

The Axiado AX3000 and AX3005 SoCs include PWM controllers that can be
used to generate configurable PWM output signals.

Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>
---
 .../devicetree/bindings/pwm/axiado,ax3000-pwm.yaml | 53 ++++++++++++++++++++++
 MAINTAINERS                                        |  8 ++++
 2 files changed, 61 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/axiado,ax3000-pwm.yaml b/Documentation/devicetree/bindings/pwm/axiado,ax3000-pwm.yaml
new file mode 100644
index 000000000000..3b73b233da86
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
+    const: 2
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
+      #pwm-cells = <2>;
+      clocks = <&clk>;
+    };
+
diff --git a/MAINTAINERS b/MAINTAINERS
index b2040011a386..9999480376cc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4312,6 +4312,14 @@ S:	Orphan
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
 AXIS ARTPEC ARM64 SoC SUPPORT
 M:	Jesper Nilsson <jesper.nilsson@axis.com>
 M:	Lars Persson <lars.persson@axis.com>

-- 
2.34.1

