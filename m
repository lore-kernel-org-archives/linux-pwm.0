Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.97
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795403688;
	b=Vf0WIVpzVtcvYetZoleYiVlcIjUlOK2z1IS97xnnpwkQBfgoxDvm3nZDu1eEfbcO8sLs
	 HPcAtq3qiEvbUi0AabYNw8/oeKOt8aDd1ClrM9C2uYw50LzCTbmi3Fggjzfs/4OTwjEat
	 Pzn5oIHZZRp6YUHf86xBwzwekOMgVA9czlD4YJPU8pPnzAwM/JpqdSn5UXFqPKwibs0LV
	 QAY1PJRBGrnrsEfUiAMB/ctICwaUhol61tVWq2/+mOBdFyjrVOVv39iwPnvetGYBrjfHV
	 MrkopDlLCwBWfmICcYAlGsniS7X+Rbn4OMoC1/STdxChN4KSMrx8GIjLcKasN8Pq8fA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795403688;
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
	bh=rSd6C4xO1YZ395Te9Gzj1wSUeBxODnJJn+nUgxBV6c8=;
	b=BCpP7GRf4GKj4/PzvCQnU4+ReXxTGrDnc+K6+0bYBbjj5z5w26HVCuPyEpzYQOsdtj9O
	 uvPgq26tqsmYGQNucjGo783+ubVE+mrC7kqm+EIJ7wr+v6jdZzcmw+Ha5onAS9fRcUWaX
	 kJRaRAqpEGMCQaak8tJdhgFOH96dt+2zZZPQbohSLgcv41E2MNmFWQBiMp0CeJ2yOkw52
	 wZguOtiW6cZpmmPRvLwAG2piMYVFrSQG42Qgrc67hJsqaV5y0w+b3slxjsi2ybMYJ0KhU
	 +dOrO/XPFiygv8LtB8KG5qa1XAJ6G40IRbGkFx8e7ZOv4iyYbxY1NUCTFZxJaCn+4cA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=starfivetech.com;
	spf=pass smtp.mailfrom=starfivetech.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.97
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2097.outbound.protection.partner.outlook.cn [139.219.17.97])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEF9606A31A;
	Mon, 23 Nov 2026 03:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BEF9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVvSFzgPetammyBwlevfr16HVaiB53mX9gyvEu+SN/tp69ADcy9TyvPHswv6ozMkSNW+/2EzamVsAUqTAzMpnmzvIHbWY8zTdFQXaMuXHb79NXkeVA7PZnU3F7A3mQP5uZ73DlD92XToYBSWVnp4wOAZ/uo5tu9FjKHuiMUHFIatrIInaCFWa5xJjlwrlgOjJBl9XGqLo0ukpmbADAtGyk/b9wfOtwcY62Sixb2ix5Qs+G91SnfKyP/TWEDBTgDx/HC0cicqeKD/IBuIF5/OM7H/CITJ3QGvAmV5Uq6wEJ8zZ0ye5K47vHcFTLEeyLYBmAm18go0rWXVjKZPzNZMLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSd6C4xO1YZ395Te9Gzj1wSUeBxODnJJn+nUgxBV6c8=;
 b=dFCfrixqrGfkOjlff67cu9ghc+wqAHOYof2TsNBoIpPrNnLFkFZA9nZQHWvypaXI9hSAAkX0/wg4RqbPpP5Ts07BiJp9Ug8wsN9w6yR54ykH2WafTDlRd4Gto7IUCaGHHLY9JYojEbx7XmV1gkzqbiztXYRofQmWJuJ+DOSKq6oHlYnZ3jzuV6Tm8336nUAJGYAGZ4NuFy3IYlwwJFgCH0if1yVKdrJPnhfsHbU+bKe0KDWxtwsy6oHU30/VGkK77/Olsn6+ML++q5zbb2nny9iO0kGIPY6agxtgELzUzLhrmEVPmVT9HLiRe09Lwx8TJNoms8bNX5b7nVycJ0BFug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:7::10) by NT0PR01MB1040.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.19; Mon, 23 Nov
 2026 03:14:36 +0000
Received: from NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
 ([fe80::be4a:d29e:5188:b37e]) by
 NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn ([fe80::be4a:d29e:5188:b37e%6])
 with mapi id 15.21.0615.017; Mon, 23 Nov 2026 03:14:36 +0000
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
Subject: [PATCH v25 1/2] dt-bindings: pwm: opencores: Update compatibles, examples and maintainers
Date: Mon, 23 Nov 2026 11:14:27 +0800
Message-ID: <20261123031428.20536-2-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20261123031428.20536-1-hal.feng@starfivetech.com>
References: <20261123031428.20536-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0021.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::9) To NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
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
X-MS-TrafficTypeDiagnostic: NT0PR01MB1102:EE_|NT0PR01MB1040:EE_
X-MS-Office365-Filtering-Correlation-Id: db8f30fe-10bc-4c0b-57c5-08df490fe73b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|52116014|18002099003|261009223027099003|22082099003|3023799007|260925021911599003|260925021311599003|260925022911599003|56012099006|261102123227099003|261028144727099003|261021123027099003|261022105027099003|261026121527099003|261022075727099003|261021121427099003|261026140227099003|38350700014|10067099003;
X-Microsoft-Antispam-Message-Info:
	YRHZgGfJzIAkyQNbrFlDG2xD+isBqvN1WBKxFBhWC3CWUJ06e9TU+pBgL0q3W7ftcFOIUG6gTidHAtYX0Zo5bZvoEL3Tk405DpK/0x+0MV2YBEWyRMXZY7GibbxiSHP6j9SBTKCyGLQVf4nHDV9lEeu8urRKa83K8Ipjlq4ZpwT3d8Jfh9UbRbDfRl6GxmAQMJAaSKlabm6KDfASXIyYta/KNR22sOwIDETFvpyZQQe+GqhD1zk981jgrLsWgho3yXlfcATERjnVYk/kwHc/fcGSUYySKtielItihEdLTa9RrW83G5A1vA8kBGJ0e9ZVBOsQvnrVRMbm4+YgxUtkRDig/VegKdaLTq/+8Y2S5u37yEnZCYLXqhTEz9IRAIwLOURYLUSTt01C/WrjUmSA/z+G/aCIP0gL2po524l1z07d0Gppv5o9QRCbuvuCDfGaiq6aReFwKEpEN/R4vB/oIdVwfOlAq6YMZK4kYH/ok/2P7hUnioqdC+SqEQzvwNNKebfKITw1aoNL5JyfayjxU9LIZAoKoH+d9vlo+NuAggPWcpNWoPvEaw7i1+H2+L9A
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(52116014)(18002099003)(261009223027099003)(22082099003)(3023799007)(260925021911599003)(260925021311599003)(260925022911599003)(56012099006)(261102123227099003)(261028144727099003)(261021123027099003)(261022105027099003)(261026121527099003)(261022075727099003)(261021121427099003)(261026140227099003)(38350700014)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WCtCmNNBENo2AYtNmtawgEUuNqmFxBwqIxKaFPfafFybgeKUPD8DX5+NkoAA?=
 =?us-ascii?Q?WVwlIXc/rW1V5IDvkVR8SP85kFRwrY1KJOrD0jWBZtecUVJgUatnL4JgDBxu?=
 =?us-ascii?Q?SG0z4F9US3eahOUF+Q/1enVX6UxvvZU9rw0gHmkMHkgGzu0WpdTLV5p6ccw3?=
 =?us-ascii?Q?WfC82KhJc9GKk5yS4PPtGxKZ1DRFbNs/gaGOUTWTwimboyJAm+6m2YxRhMY9?=
 =?us-ascii?Q?yu05cZk9T1sB0jqyYjPQSxNPxEkDbQ+k/nlMdjsx7hO0cmussMewm5lGGkm6?=
 =?us-ascii?Q?FYdrwSSoZEXsexdRdm8BiSSlmbQWIBZXFY6qsi8feVf+ZAuawRiIZzFv5Z1B?=
 =?us-ascii?Q?cHPJ7dm4R3ss3OrxknBjClkWVlNQT+19BonbEVgR4AgDzGHqWUfsu8yEpI+h?=
 =?us-ascii?Q?ZlKrFQBzqHiSea9+VgKRsKLXrtoC5+2NC/YLKvfhyaJkUaN1yaJXkQTOiDZF?=
 =?us-ascii?Q?3A6woC6ulv96hGHWBNHVtOb98y/ZuZsd0/8aiXErOayDuz38hproDQaC+SFM?=
 =?us-ascii?Q?rjSj/zzmKKW4F9Pjn/jL8gJLg2kyjp9tVxgmXMO5rCyaGnsy7dmsRD/1EpE2?=
 =?us-ascii?Q?k3G0fxWgri56KT6s+9S4pFB83N2oVOofnFj7A4LVl1MYHjBXe65ecLHF+Pbm?=
 =?us-ascii?Q?eAyVYbf82g0+Cw74KSxJVRRHgkUFy7jxIG5ouVFCVMLaR5FaOQAb6O+0HTce?=
 =?us-ascii?Q?nDIcO6NGa6udUo1GUaJiBZbpoY1MvHVUgwQiiKTKRcyvippkC4mYdV48caHw?=
 =?us-ascii?Q?XErlTdHeljdLsnXjNMKnSi1HsdCfzO8/sG0pjyT/KyJLXnFGyoU9NMb3MM8Z?=
 =?us-ascii?Q?g0pP7+5cBFpkIcPbHZrq1dVwm2DxEwMOgIqwgh3uzmgZrGUISWaQSNMwASdi?=
 =?us-ascii?Q?RMfggbBMOBxvsG1vqxnZYoaALtuAClw42tIyEv0Xx7kKSpJgjOSvTTTSI2d1?=
 =?us-ascii?Q?x2qISQaS3ufrxRnUaXHqjSUm34C2XJPG6PyogM3BalYfoY6bBscCpPsk4o7c?=
 =?us-ascii?Q?UDagbXgWJm99CvQst88gyibc4wdx7xeDl23vpQGqEyxGbpET2J+mLad+GtKQ?=
 =?us-ascii?Q?cTdE7z+jyulIGqIXgWGqO962t2uBH7Cbo0/Gveamt181pQ3ht01p2A+KGBKN?=
 =?us-ascii?Q?K2DLTP++DfGMpoK6Ibp607f4Q+sp8T4S4tT4Byk3zA5sENbteUlJx1BeNp21?=
 =?us-ascii?Q?J0ZkPG99ThGIJP3vzME67rpN7ELlCPjUGEXGScrHPOf/y/6ylkhC/5mgbMmI?=
 =?us-ascii?Q?Ag81EJpDOvEvxAigJ3fE0ZvSudR7NC5PMiNVZF8vVeqP10JJwojjlADhcjtX?=
 =?us-ascii?Q?izmupnudC3T68sER+FJSEFIFQEpzMqEMj4OJqTR9MWumExRIqm/IVaIIXYjf?=
 =?us-ascii?Q?8CdITD65kSvmfIcFzrw+OngO1U28+WBViWdW8zyrKWiD9TDUCW95pvQEX3CT?=
 =?us-ascii?Q?YcpvI5ZNVt/wR2LNSYGhuIHuLChQi+g5/+8cmbeUkWtC6+igLZ9fResAJi2U?=
 =?us-ascii?Q?LrfCUDXcmYbTsininn/+mOHOcbH01X8EzO7gSkyC7csQoyOTp/Smr2tj/J4Z?=
 =?us-ascii?Q?d/87PQHn+4B9dRnNMSqo6r1iaJ0EB5dydDIfottCcbU97v1izDBxysDWuwJr?=
 =?us-ascii?Q?PKfnuEHG1omlMRaY0jG/Je2grOGxq/YCY5Med/GZf1QvATO1EIQxVs4k1WZn?=
 =?us-ascii?Q?qp+Yow3OwXn2xih/VyAP51NzENu2yvLkFeNg7tjMt8QAuQVuDnK3eeh/eHFE?=
 =?us-ascii?Q?cNgkj5ooSbWz8B/lUnMDakiZ4rJ58V0=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db8f30fe-10bc-4c0b-57c5-08df490fe73b
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 03:14:36.3725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJvRADYq8hkpOVcCTPJdD13KakhxtXHx7KJBpnjR2cIJA0OKkB5gWXNObSuJmVg0IpS2AYjC3Kx/o9oZfmTtQ2oueZ7ApJmwRo5tSSlTe7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1040

Remove the jh8100 compatible since the JH8100 SoC has been canceled and
will not be released.

Change the register size in examples to 0x10, since an OpenCores PTC IP
has only 4 32-bit registers: CNTR, HRC, LRC and CTRL.

I will maintain this pwm module in place of William.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Fixes: 2529085831b0 ("dt-bindings: pwm: Add bindings for OpenCores PWM Controller")
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 Documentation/devicetree/bindings/pwm/opencores,pwm.yaml | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml b/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
index 52a59d245cdb..b15468f97b59 100644
--- a/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: OpenCores PWM controller
 
 maintainers:
-  - William Qiu <william.qiu@starfivetech.com>
+  - Hal Feng <hal.feng@starfivetech.com>
 
 description:
   The OpenCores PTC ip core contains a PWM controller. When operating in PWM
@@ -23,7 +23,6 @@ properties:
       - enum:
           - starfive,jh7100-pwm
           - starfive,jh7110-pwm
-          - starfive,jh8100-pwm
       - const: opencores,pwm-v1
 
   reg:
@@ -49,7 +48,7 @@ examples:
   - |
     pwm@12490000 {
         compatible = "starfive,jh7110-pwm", "opencores,pwm-v1";
-        reg = <0x12490000 0x10000>;
+        reg = <0x12490000 0x10>;
         clocks = <&clkgen 181>;
         resets = <&rstgen 109>;
         #pwm-cells = <3>;
-- 
2.43.2

