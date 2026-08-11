Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023114.outbound.protection.outlook.com [40.107.201.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9286840DB55;
	Tue, 11 Aug 2026 09:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438958; cv=fail; b=tlKLnKqGdzMnIjUy8HmBm56jyXi/tU/4m/4QPOYb8araS55Kw3aev2gLFPC1U4obM9yhaI5kRbD25j3kifE91vimntPzwaYIZT5F/814o7P02EzDmbsDuMlt52foEKpGnRp8uycrL/7BBx1PW4axdehM1dxuYscuGeGIkJn3KtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438958; c=relaxed/simple;
	bh=F0PWHlmVXkFgnIZrHGa0HtMtZLYXJg4GHtKQ4/93trY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S7Djq2RHOh5h6x50jGss6dAlr3l2V88/9tnQhlx836+yquO2/UYN80acvinQ5x8ypxu4LpJKdpYfVRdQhbO2ZpcfFRbbDoZn3jH6cOurNOOSFDv7K/9NcWhgu2aSd+1OwkrM6ksXscHO8ha4E2HXHUm60wZ6ookwzuVDiAQD+yY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=ZFJ8yLTt; arc=fail smtp.client-ip=40.107.201.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="ZFJ8yLTt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NbHXCRDKFi/7IY4Ez0+F8SchYfr90lm31kj6kxdtag2T0wY6X1Dfx538if5Ri0JyNSCKJtEAH0P3zeB5qsAsQVrFg72tiuQGdq4rjy/D7WrE7IHZd79gJ/Qu/eXQzPFTTlEnJkLMuovqEkjOl+GEmXvm7RamJe2ZqMc/a5PaUyO96cbIW0b+KWdDo9QP+qiyisgP3s5rrJ5Ch41wGW1mG1p9tZR9M9Cmx8WPaSXZ6M+6ncnmK5v9znW1QMYiyWyCV6rkjRHrVfRZXa7W7zK14wtGRm02QzofwJZV01Oc6yvqpd3Kj8zSOKAt00o+wuX4kPJzmIc3n/JCGeSGYZFi3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+H3u1U0Bokja27RcgG6yExMsX7BU1o+vfXzxXK6tbpc=;
 b=QF17r5cN3tkHPFF89r9yr+70ELwJuiO0s3RUPsfgAuacu1GNPbVheOe+jUiqpdPwi6fmVrSiFEjJ6JFiFcEVUrPZen9edcimFJ+CWNbre1E+eT27n7jAR04eTm+xTL6uKUVDR1mlYpBeY0STVPOHV7dte67ns9yORRFZUulWDm+DItPpqOOQkurxUUW7Lh6gwW+tJPZa8Msy5CyZg2FoBSTgoC0EnAlOmInV6O88d7VxSAz5tOxCLbW5L+gfGnrMEvzW4/D1lm99DnrlFXMMggIXmqhNYTBYMlH27F13q5ftfLsyyvoolCqWknLxWk0f7Zkua6NgdsDaUL/35NVYqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+H3u1U0Bokja27RcgG6yExMsX7BU1o+vfXzxXK6tbpc=;
 b=ZFJ8yLTtZdUN9j5N5IC8L1TNMk/5NRrpXMM6lqacaTTbDY5aQG73XYqVecaIbHR9Rmo3ZHWns3P0PiMJIDbv52vpoxrW7k+EQihIOV/2pZa5TqWq8PkW0CJVUOUPV8evCFaerKId9Ntqz5gvWT5/DUPnZL4BVPYbPJoc6oRKG8KA8rQuryIM7cOP2N405uoPEoRx8kN/blIqZjzI+kTehsCr9+Wm5kNQh7DqFkBL7xvw6VF34uA7a1qkyii/+AeGplv/9RCFRaGJlOLcMNXBXa0JrsiRAJcC79/b8/gnMliX1/c3ygBZ7lwD66qMtTKhdw/9vvPROyg3VwLm36jQQA==
Received: from BL1PR13CA0397.namprd13.prod.outlook.com (2603:10b6:208:2c2::12)
 by IA5PR18MB988654.namprd18.prod.outlook.com (2603:10b6:208:608::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 09:02:32 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:2c2:cafe::6c) by BL1PR13CA0397.outlook.office365.com
 (2603:10b6:208:2c2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.11 via Frontend Transport; Tue,
 11 Aug 2026 09:02:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.6
 via Frontend Transport; Tue, 11 Aug 2026 09:02:32 +0000
Received: from axz-uw1-build-vm02.corp.axiado.com (unknown [10.14.1.22])
	by smtp.corp.axiado.com (Postfix) with ESMTP id 770304186B58;
	Tue, 11 Aug 2026 02:02:31 -0700 (PDT)
From: Petar Stepanovic <pstepanovic@axiado.com>
Date: Tue, 11 Aug 2026 02:01:50 -0700
Subject: [PATCH v3 1/2] dt-bindings: pwm: add Axiado AX3000 PWM
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-axiado-ax3000-pwm-v3-1-6ceaccd812cf@axiado.com>
References: <20260811-axiado-ax3000-pwm-v3-0-6ceaccd812cf@axiado.com>
In-Reply-To: <20260811-axiado-ax3000-pwm-v3-0-6ceaccd812cf@axiado.com>
To: Akhila Kavi <akavi@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Petar Stepanovic <pstepanovic@axiado.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786438951; l=2395;
 i=pstepanovic@axiado.com; s=20250916; h=from:subject:message-id;
 bh=F0PWHlmVXkFgnIZrHGa0HtMtZLYXJg4GHtKQ4/93trY=;
 b=rVCPovhR7MF5hc4NoRcb2/lAvlPQJ7ZNNPokBxVk3bF1gMTmh1sASqkSdi1LrFXNG/iZ3R6i4
 VcGxi9d04p5DG8C0sj/o1xOVkxYA0BfDXKg1vatm37CYFM/pgm07vgG
X-Developer-Key: i=pstepanovic@axiado.com; a=ed25519;
 pk=70f1UJOGT9U11ZK6o+ENXtv0I5wBE3e+Y9YWODzRsdI=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|IA5PR18MB988654:EE_
X-MS-Office365-Filtering-Correlation-Id: c1154d09-ab4c-42da-560a-08def787475d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|10067099003|56012099006|18002099003|22082099003|3023799007|13003099007;
X-Microsoft-Antispam-Message-Info:
	wjfr9yN0X5agUmmsRtlkD6QAZdJmHWktyigQ5aWFfN2rUxW+eDfe4UgdtdL/9tRxHK1UEcwtsxaXyfCxEQX1QLWr3Xc4rBRUBtFRLC2GLdXj4OlidbLggPAPUiC4w2Wt+xxoSlpzSZYJ1g+8edTRjMosBhw3+LRuPyEPCTuQft/u90ZLcgCIm5z4HDUnEZOxiVS0ddI0V7RgdTum765SJMkeAC1wZTzTDPNffZnnf5EEPPbCZOvymLuV7fwOeAOGNbIjO6CrkMU529euMT2vXj8VcH94DZjB8YiDaw10ywsep5HQLfWn/RuNDbRQgffGuGayfGFeaS+tGtjp0jB+uuhh0yc/xcqdGYyPEFd14qIfQLBcFt/vNVrVNNKR1uSQhCMIcHTV8qwRWz5KXJYE0VJ49u+l4yPQeDQcGakpHzC5yyEaP9e9juRkR+2OcL27WKO3Iw3vrebBp7KTnRRMuZMOxwyb9436CwwosB7oDdRvJgm9q2kq0UL7kMjtAS8t2Y0fjz92XZiyn6qZSJKEXCPbR3RAqq2bGYxyPC9c2WDg1tvFICutYni8BJbJnLwjEgrrfxbHdYtpUFf0WqdEpVR7CUCer6WdoMid4OvAQU7M84tqPmgUwMeK3poNVf+Tw2Lb5dgf/M3FLtV64sIMhw==
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	P7/pY+xiT36l4kEKuwNIO+FkGGa/gt2yirq4+Q+OjHK0p5j5kSqdNLrHDzesolh88a/acZ4cOPJyuHfZ6dgbKV+8XdPhGcKN2STtQv1l5/jurXweFlWFN7nCpo/di4MQy5N5HTaNiYBDU25konf/LYGD5xJM9zR9bENVDsybffmr8tzyd2ADHojaL9gyH6tzclVrpwT036zBbhTQiD943K2/0dOAIRG3EKzTl5fzlSsf4dtqIEy8nojY5oekK/fev434DKWYjhh6MMI0DjOWjXmZU3Nl7JOd2FuXP9H2hPr+Fhz1QrtVeKKKWj/3SLK0zeL78mAT2zjXRCKXRnuIMh0jI8rRsLyusQf4cOti1LlqbMZGD78Mdf9PB6hvM50F6nM52ATSECgzcm1su+YW24wltp5v3aTvRisD4x68qDzbxpb4R7HJAnVRXWL7p+2a
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 09:02:32.1446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1154d09-ab4c-42da-560a-08def787475d
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR18MB988654

The Axiado AX3000 and AX3005 SoCs include PWM controllers that can be
used to generate configurable PWM output signals.

Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>
---
 .../devicetree/bindings/pwm/axiado,ax3000-pwm.yaml | 53 ++++++++++++++++++++++
 MAINTAINERS                                        |  8 ++++
 2 files changed, 61 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/axiado,ax3000-pwm.yaml b/Documentation/devicetree/bindings/pwm/axiado,ax3000-pwm.yaml
new file mode 100644
index 000000000000..7297abccbc24
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
+          - const: axiado,ax3000-pwm
+          - const: axiado,ax3005-pwm
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

