Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023122.outbound.protection.outlook.com [40.93.196.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8840441F375;
	Thu, 23 Jul 2026 09:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784799160; cv=fail; b=f0LzGE1w7o+NfvJdPRM6NPUFwK2gL17aL0/lbJ+cvkgTqb2HGgQeXt6oatLzuFhoVXDTYajL6H8X3v6lexqiWIxcAX/sbe/jymIsvlQHDOVcQwMQU9/Ozncz/6dXxGuwJrPDBEksx5X4yOzdgG8HOjfZLcElE9A6C7FxdmIJ24o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784799160; c=relaxed/simple;
	bh=CrM9KcdTYuwGYQ9WJlE26qPNJiZO6cBuRg88p8mavlg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iAj0RVn4nFeg8gadt55n3L+svG767D39Txoy012h9Sy3URaLgavKPfX6J70JYwPIt0TgZsMX+EjIKu7PhPKT6iSmpua7LR6GXYPxwOd7p+tXXTWXmjiny0DzVfvQxuzAVNFTbwV0PH2/2aY5BWNjt8RA7qtuYO92keiOuY/qfow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=v/xuoLN8; arc=fail smtp.client-ip=40.93.196.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="v/xuoLN8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7WxZCE8sMDQYi3qx2qbh0O0GjH0KQXUMf0OfwfM2e00JwyoZNop+/NN91Y+eaMTqXiolTldARqLk/gESvEg3cKPZjWBj3kQofoyT9dlsm6yeoZLs66Q81rGFUcM3HgPlFNgmXzukRMOrit1XqMO/HcAEElhRCJemYv6grjqBvkGY0IMetw5slk/SJJvDb776AoPC7AlrfjWy1f0X9eMYF1f4QuNMOzEulhi90azqZcplTr21W1307NX8mpbqr8sSZzxNVMG95/4Znm48sIOaBB9dDCCjC3GvGxiwlTxi9H1m0abzqEfV9/OjrcZZ7LQaSszasth3ruAqlDHJOYEJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fb9v+58VYqfu5j0ZTAc6ZUpL5aul4K4dCH3ti6OXA+8=;
 b=M7Frvp58OuWYaJveoRJQEemNAJ3cSNjGpVkiZEHPok9zh9NwoUxRgGY8rcSlmpErbk3B68XNovBluR6gc1x6gUmkBdFJTTwFyd1LuI6inGIpYlh9D6lLd7ipv6O0HWqAKaqo0zgH8RDSwGzKw2JEdyaIuER4q/Y/GNah18t7+mqzGKmpPaNeGovgatR33IKdVoIpTLfdSQTV6/LmhO2aWucddr52Ai1eZMKWyGLSwS3EHsRU+m6g3f/KdnGnfXnUrwOcnBnVH4OyRGmaQV8X155yiYjRrXou20h3WKdvGBReo5Vjx/rMeJHchXRWehz2QrD+xSNVcs++22VthJMQ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fb9v+58VYqfu5j0ZTAc6ZUpL5aul4K4dCH3ti6OXA+8=;
 b=v/xuoLN8kVrWHsbdoWS8FCd4ReqC6anY/yMu+qFcUjW7gN12C4XEdds4eC8xXFxpF8SoQr7dVMieKxg3/Mxlz+tgtLobs2RRs3GFDwzl7zSAN8U4N8kqYa46+CnlCRb/J1kinZsHmZH8ZYA7uLhrTGOpNesEqMsQI6S9Ngw32mmeshaFXurOIkQVjeFg14ekZTSwPQ4/ZUyDHf5CupYCR0naT7ReRta8j7hjI9EjD1hTqReHl6OHoQa7kSznxsBdPBeLb1qrk382kAX2YM0pbQCUaDEpcs+v17CCHRsd9XOp8kRaL2COF1jcm+4K6ap7SxJSp4YS9lFsRBCHhS/uOA==
Received: from BN9PR03CA0143.namprd03.prod.outlook.com (2603:10b6:408:fe::28)
 by DM4PR18MB5428.namprd18.prod.outlook.com (2603:10b6:8:18d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 09:32:34 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:fe:cafe::5a) by BN9PR03CA0143.outlook.office365.com
 (2603:10b6:408:fe::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 09:32:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5
 via Frontend Transport; Thu, 23 Jul 2026 09:32:33 +0000
Received: from axz-uw1-build-vm02.corp.axiado.com (unknown [10.14.1.22])
	by smtp.corp.axiado.com (Postfix) with ESMTP id 353A34186B58;
	Thu, 23 Jul 2026 02:32:33 -0700 (PDT)
From: Petar Stepanovic <pstepanovic@axiado.com>
Date: Thu, 23 Jul 2026 02:32:18 -0700
Subject: [PATCH v2 1/2] dt-bindings: pwm: add Axiado AX3000 PWM
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-axiado-ax3000-pwm-v2-1-22002f0b281d@axiado.com>
References: <20260723-axiado-ax3000-pwm-v2-0-22002f0b281d@axiado.com>
In-Reply-To: <20260723-axiado-ax3000-pwm-v2-0-22002f0b281d@axiado.com>
To: Akhila Kavi <akavi@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Petar Stepanovic <pstepanovic@axiado.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784799153; l=2320;
 i=pstepanovic@axiado.com; s=20250916; h=from:subject:message-id;
 bh=CrM9KcdTYuwGYQ9WJlE26qPNJiZO6cBuRg88p8mavlg=;
 b=rs9+ixrP7K4rNMdJOiNmWEdLzxbzGara+7+T2jeOY+BQXuu/CEmfzWIFWvFwPP3YPkFKByHdM
 bek2ud+yH1pBTmzi9sxj5l3sZLpECcbWHQ5gSOW8DO04PUpKx4UvqY1
X-Developer-Key: i=pstepanovic@axiado.com; a=ed25519;
 pk=70f1UJOGT9U11ZK6o+ENXtv0I5wBE3e+Y9YWODzRsdI=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|DM4PR18MB5428:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d1d5ff2-809d-4486-29d3-08dee89d5379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|13003099007|10067099003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	sfgryO4YgCPvmkP22L9yWaD6J6/ZO0f8PM3FwRb93xzJBdqPvB72ViG6FMqKRxq/2gO+p9g1mMvlzUJD5Vma8BDO110dSi/Ekx4EkZMrEs3nc5PUiGu5ScSGC2hRrFA01euO06CXce8+A/CPzVx2CkCelJ2emRQQ3DJEXZKh0ZZwGSZ7m8og1zVC6GxyN9mgkk8Cre6F8zP+qaR89mSUR5z/hZKZVovY5ufABHJIAPlD26HhZaDbHp8U4puSjN/NsSo/dgICOCwoKPHYTeeSqkA4IVSE7BxD1kRTMWQcsz77gzIgLU/7dXaGnsk6NYqLCMWIx0e15H4EhMUVXntQwQXwGepaQRxjV0mYlrSrbTG5YPI4mQZCuED2p7/7YGRG648obRbY3wYAcHnqwR3xE/m6/XdsHOnE+QSW8jUy+Scm23FaIfvyq9S6Ur1ba2QIQjTLUHnU91ZNr24ousB0ManbUZrNSoIp3mDzHF1o4nS8ILcEYdG1zGRK6w5yg6Ln6XOSFn1tvjfQjaK1ncGrfi+wSUGYxhpLjoAPXcrAW+SbHw+0bdVYN/ibzr1nzOK52UxNcoN1ezG4XkTWdnmTOzWgp/rah/LyxszytnC5xaM8iBNGyLo41F1LoiPxq4b5SFK8vxgkttHp1343YQPG8g==
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(13003099007)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OQKYQ64rQfamWGFWmgynqyc/TFvetqW2t+DQQ3z8n+cRPhfN6mz9iTfhkI1n3gfdMWSesV7oa/4D1o2H99NataCLMJ5a1l/nAmRgQ66q+Pla8C/Mtp3kzjCBBXuSLC+gMGjddHg+5pVvyxRNDlNJ4F14goMWSqL0SLqlls7GbqYIEWFtQX+YuiyaC6LhTgivXql9TvmCRyyi1TEg7iF1YN+LUvmKBfCyRsPa9SM1PW2QL87KDELP6kkUxcYbGslM22MM0mizv8Cxiqc1XN1Bzoq5qoj/DMJNX8Y670NPS/mlXqMjHPlRlYi2l+CWyo4cLyISFYOAvV+SaZg3hbGxpNP+JheBsKIIbB6Eh/Vns/NQCIDzGiFu8EH4gyXgbQwJSoR8GBOL2wWGk5fp7CZRViNB+ZoOQ9isa8dV1CySPDYn9HneFbSH2DWrYpwa5o3g
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 09:32:33.9401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d1d5ff2-809d-4486-29d3-08dee89d5379
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB5428

The Axiado AX3000 and AX3005 SoCs include PWM controllers that can be
used to generate configurable PWM output signals.

Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>
---
 .../devicetree/bindings/pwm/axiado,ax3000-pwm.yaml | 51 ++++++++++++++++++++++
 MAINTAINERS                                        |  8 ++++
 2 files changed, 59 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/axiado,ax3000-pwm.yaml b/Documentation/devicetree/bindings/pwm/axiado,ax3000-pwm.yaml
new file mode 100644
index 000000000000..02da1cedad24
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/axiado,ax3000-pwm.yaml
@@ -0,0 +1,51 @@
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
+    enum:
+      - axiado,ax3000-pwm
+      - axiado,ax3005-pwm
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

