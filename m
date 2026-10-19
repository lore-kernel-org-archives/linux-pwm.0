Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2099.outbound.protection.partner.outlook.cn [139.219.146.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7A03F3260;
	Mon, 19 Oct 2026 11:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792409090; cv=fail; b=YEfdgnT8++v5Cs8HMY1k2hEGVwKpjZVepxhaeyJzWEd17vaIYYdCLddwUOshpT+YqjUhDXRPGZk2pM2/cLbe0/dAiXIaoe0+ETmLSoeDAe6eP7ysgyhp3nenvuPuOpxI46vbV36hWprAQj/gTV7nalwwg6nCnOIFV1Ig3l7KBCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792409090; c=relaxed/simple;
	bh=p1CXKLHFro5m8ljG7Fx2jPDdFUfR0uhf85Xb27esmHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LOGzbq23atVGdl/BK5pq4uY1/7EKtRYoP+xDHoC8I3JuLRKv2+sD4cJSlztMpkfjGG4vsNdBcikwulu6Bv1ICo5Tj5mfqJ5VyC8W1dOoCbl0M52Ap8KZ0VjI9lX7b80niLCu+UTG2mAu40M7afQgEjYzfzzdsW28Irm9T/OwNiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEmJr5iG8N1vubBvxbjQO35w27s3Yz/oSiTDUIv3539ssJKiKDGIADRy5szo2GVa+MZ+WtRRzIHzdVft1GfhhL82r5aXNL+6s7OuHZhTWs9oF+pDLulsPuXh6Ab3rWePAmKFLUyGAdv8xwC4OKo1z3TpSik4W6KT4bNIDoRwjhjp0nPsjxwiMFQ/pT1ZhG5pC72lOFR3oLvksnU3qAR8XphlpyOE9olP3tPAkFhXAvnJV2389WF8nBRRZRoL7HNxC/zeJo6D44Sy78/PjbqbUcGyfxz6Jb/P1xedspfzWWlIBmsvupaSUT0tqHDqew5t4SfY3x7kBVcEwu20Ce64JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWDersttTYJd5xUAnNVqGVftKy/HtoohmrjNXKzCURY=;
 b=PhOziR34eA/lNZqU/8RBl0ADcerQGS4HmWBQdQ6C6U0MFmhxf22z4fE/3SUBVlrdfcO0OC5soKLPv3lje8OAkrCuZDQNaq/JtiB+w/HxQYM0Z88KZpDEsSYVxkpew+JWC1YEFYqWj7IRiCpxbzNIhIHvDMsJUzzfdd5dAYrGCCZubp5qgJ8tjDkJ+4lZL4mWIFGKiEB++PQg7dcSEy4ydsVGxnYuYUT/6HZJVgTXHyqMN1sWgu68FU0cQhyjaNGeSh8HgqWRlFkiGllbyVqLhIaFC+U5P4pY/Zjtk239tZmABlzv/Mbe05MLEv/1wD1htHIlRh4sgF6Ik7/EVla+Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1331.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 11:09:07 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0522.017; Mon, 19 Oct 2026 11:09:07 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Hal Feng <hal.feng@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v1 1/2] dt-bindings: pwm: opencores: Add starfive,jhb100-pwm
Date: Mon, 19 Oct 2026 04:08:54 -0700
Message-Id: <20261019110855.52420-2-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261019110855.52420-1-changhuang.liang@starfivetech.com>
References: <20261019110855.52420-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0032.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::6) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1331:EE_
X-MS-Office365-Filtering-Correlation-Id: 15dbe08c-68d5-411b-7764-08df2dd16500
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|52116014|22082099003|18002099003|10067099003|261009223027099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	Elc8vr8J6o2yKLngvNTFvlNCMdir6e0JKAzzkefPc3AgRBrlvB0OdeBIISLIquesCI35aWqKb7G/cIm8a7+WRJX3T8VR9Sqgkgbjs92qWYkDqQbE7T4j/GxULBK552i3sWxSINLByCyPowRz1c3JVd0mKG+dQ0TRHikNmrfSOrw229cr5CxiC+7X29lG4kVvu5zn4r31FEBsKtBpAxQtLMRim66WQzAe9M8A0E+kms6xyoynHXojUDr30A1iUScjPjyYWG+holIpr6kyZXnZk4v3jczaPZvVbt9h9J7oJFqoCpnpSuibPM1g/8h68k4nAPKmsFWLopR9ov6riYvD+t+zREi82oTCW19snjF8D+GZmNQyko/dloOggONHHZACUnW8ODiT15GsZvHxTYoio29AQE/o2CHJ0kDvWf8Mh6adufA0+mKPf5v7Xo7hfZFapzvuakn4Dpi262/x0MGR6uRoRuNlaH2yyJnFAUuiLZq88AeYyUgOvic7Y3/dRjaSmc/zhnXb0b8VHcjFdykmot+PrWkMN7Va0Abvd8FFPSw0NiPNHAOWRhfAMZxT5FSA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(52116014)(22082099003)(18002099003)(10067099003)(261009223027099003)(56012099006)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VwaoA1NZ1627XZs4qFWDE4BDbqljIDO15jEqrvf6hhsWXG35WAmMAO3gqwIN?=
 =?us-ascii?Q?vMhW+V4cWbsP+ZqFIHkaZkOXhlsNDz3CJwrdTGcCYMKtgEWQWcA4dd5hs/U7?=
 =?us-ascii?Q?9VOc4yxqXux24poCPoDT2y/kVLF6hP/LHfyHsQiuP+FybAuWYL34W1hxhT1w?=
 =?us-ascii?Q?oEfL5KNlORKVssdfPQTHxyEcZ/c42L2w3V/6uN2Sdf7KF9Gs4IQ7YREvnSUD?=
 =?us-ascii?Q?eHqgGTC3Cvn0oF+KkgCDI9Ky/bOedFH9p78RuhB/3c4GFLDP0y3Hm7ksQm50?=
 =?us-ascii?Q?yWiTIDpspQJh2jkLZaIqvAXz6Vr5Q9zApgqUIiRfCGWEqYIUPxVUdaDVKCYX?=
 =?us-ascii?Q?yx10W/vmwxhmRlGKPu7LNfbzGQO4m4e8ejrwAs2nADT2e2kFr+4Kp279FYqR?=
 =?us-ascii?Q?yCUiafzINqOO4r8dXjoQLlrm5mTsZK8ExuljvGP9hm/rJpn7SvMMKWLPvkRG?=
 =?us-ascii?Q?u/c9cPbf247khabkhYUQQSJlIid+nxMsWtCHRaeGR+SSZUesFngP/uy0FD+4?=
 =?us-ascii?Q?09ZiGKa8bA74pGkuyz7a0bDsURf8SS90FJkR7A1nMkLjon2ZausuxWK6hoJx?=
 =?us-ascii?Q?YQHFAgValiSt+2bP1R9DgX5u/1DFnsTqhEyscgB2ewsNs20Lje+mxHi8AKEe?=
 =?us-ascii?Q?FizTiy6KQ6i6wXqylkXDTPJ0EcyfOBYCYtsd519G/okEuMVSu98sRJM8BNHd?=
 =?us-ascii?Q?af68SsuyGoDOn/cAR0aFxECFB9xNLgend1/uKkxQcN9+LWLY/dCEPRnFfJQe?=
 =?us-ascii?Q?G7XMIEo0yLqB1wh5c0y+hlbPqc1hD6ou0XtJVlLFDhXR3lbXs0cEtYd22MWv?=
 =?us-ascii?Q?5/pZ4RQ5tZVIXx/jl2NYMtELoByOA/rBw/9zEaIiup1chs09F0ViwpA64TVB?=
 =?us-ascii?Q?8UIjRLU41EIBx8C0gIr0/qFXUfDT1hp8RbNg9F0dCMxXzknkqUojsQ/H/2IK?=
 =?us-ascii?Q?Zo8+Y/zqqcgPzLrL1AJ4a/m4Ge0qsEXQIAJ5Sk+rrxhT2SFY0xedjg9Q442u?=
 =?us-ascii?Q?VqIisXtZ2a//MeAD6UIXnK5Evk+FnIV7NP8+kt68a8hzpnuS+J2DW1/2kFXF?=
 =?us-ascii?Q?AwS/C8jX6vBrSDus99Gv+fvz36d3XFwMOcGXtpEP1MEYtvI4k3Xx/UuWP5SX?=
 =?us-ascii?Q?UcIbua2St6V47Q6Vnb2GrfFw3xCLP2ZUKElc88rJeOh++5QXMCkwkB3msa2j?=
 =?us-ascii?Q?OG/UzjFfb6NT74z1l+lTgNhuSI+i85TwA6SPvDVSfa1PGHy8GQNJGbKIVOtc?=
 =?us-ascii?Q?OqvyZJSN6fFXkaDy0XffsTq4oeSS+8x5cxYMq8AvwdJusCkeE52pelpYdzdu?=
 =?us-ascii?Q?ebhmUZML5qaaZURD0DZnLlklyyeMsm+0QbOhg6FjJiUtXeg7GSpJRndGBkGL?=
 =?us-ascii?Q?9/k5eX4+AiLqTg8IWhLpLmKw7YjZiqqNN+NBON3Cpl3jWZNP5MkcybJ0Kn2U?=
 =?us-ascii?Q?eMbZNPX63RcCGLoZZgqqywiMy5eGwOCM4u0+IgKFGjhkB8U0nLSV0QPnL7JT?=
 =?us-ascii?Q?4nLLJZWsZBx17Ue/jQ7jnobtkV9bW/xS8GtK1PUp5EOHqWTw5GeHHlwwr0Gz?=
 =?us-ascii?Q?P4CmxK9dJOoWKDkNeRdjntb07gipjsEZL/u/mpL2SKm5ZcLCR2SvZ/HbAHyt?=
 =?us-ascii?Q?bB8BpKsKyLERFGGvE7cRFGx8XTJJsMjUHfpXlcUYbGx8Trb9rU2izt8hypsV?=
 =?us-ascii?Q?w4yA8L0OM4cSBLni6ZLFTCNYRZUenxntEqJ918rTZZWVGuWHFWiDm50SxHZD?=
 =?us-ascii?Q?CcQs2ifym9SBYhbYjivuqVk2AN0cV9L6hudPXOp3JyhWe7GLQg9r?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15dbe08c-68d5-411b-7764-08df2dd16500
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 11:09:07.7037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4F9eIDuX7Cg2LGFR61fpWlz+vIcRRkBvgIpvqhjF5TDcK2mR6bGk76OnWJH1NDpY7aomQnTTAMWG4JH5vURsfwXFZmr32ztIDFwBfJDYF6MSO+SKc7o1xQExRnqeORpZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1331

Add a new compatible string "starfive,jhb100-pwm" for the PWM
controller found on the StarFive JHB100 SoC.

The StarFive JHB100 PWM is based on the OpenCores PWM v1 controller
but with a modification: the polarity has been changed from inverted
to normal. The generic opencores,pwm-v1 hardware only supports
inverted polarity, so the JHB100 variant cannot reuse the
"opencores,pwm-v1" fallback and must be described with a standalone
compatible string.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../devicetree/bindings/pwm/opencores,pwm.yaml       | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml b/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
index b15468f97b59..a7798310d350 100644
--- a/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
@@ -19,11 +19,13 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - starfive,jh7100-pwm
-          - starfive,jh7110-pwm
-      - const: opencores,pwm-v1
+    oneOf:
+      - items:
+          - enum:
+              - starfive,jh7100-pwm
+              - starfive,jh7110-pwm
+          - const: opencores,pwm-v1
+      - const: starfive,jhb100-pwm
 
   reg:
     maxItems: 1
-- 
2.25.1

