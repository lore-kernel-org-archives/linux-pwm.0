Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.146.116
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794021198;
	b=XiYsz3/1XC0nQF4VZroeUveBKZJvzRIZ1CJBJyFCVQ7xqZIHeEeKBnMEd1XBefakJCJR
	 ffWZ9rKJolIW8u768uFVd4Q6i1ilRuDc2ZVwJX+4D1ID0bbeu/DeNGTR3LN7jaObdwEgi
	 OTEXzuLOhbRaEurSGRpcYw3XB4/pKnV/eupyJyuwavVr6ceM0nE7CJsrT4aGOuu40rLLx
	 Z9qqlDPzvXMH56UtfAfeXIBLWjJ1Za6Vdv5ptmnKYXMOlP0QhhVIecG79CaS7aKjxeXBH
	 riRiX8WN9Q/DBTj0LWbtUaUS4WCIfisCKb4bhyLIWkah9JGfN+8Ds63WzMX/ySeIWJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794021198;
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
	b=cFJ0CwhxluMzO8VVEF0FX4fSUfG9ddxz1iJquMrh7AvaFLYcXLhMoiCRz/PkkM74PvVa
	 4goqB3OuYDlLNb5Im0mOCZf7iyCsfLb/KZ/l7t1doV4N5rruZaUWKl3iAztTAEVteE9qr
	 3jlAvDtV6WVGBIu14OqSQwaykHBQ2WR1jNGZsIscC5ZgWu6nHaDDg2BMVBAw4FvKxhos7
	 RWCbtAi7E8kMXoDIChGcUFW03LooaHd8zs+SLD0lZIOkEmiqha2Gj0fNkvb6SSd8Pt8RI
	 LxcyUTTvErwlqiRgcxCEGFs+tFa8we7fTDnwLGdwyJRsbgs67r/fr3msjb2qzn0rxSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=starfivetech.com;
	spf=pass smtp.mailfrom=starfivetech.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.146.116
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2116.outbound.protection.partner.outlook.cn [139.219.146.116])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D1F606A32E;
	Sat,  7 Nov 2026 03:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38D1F606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eSxba/n1yyTnH0Fzb879nfKfzuurKfO4Pyx/C92WaHTLiRDCdjXEasJuUtUMVBnX8JFBqBWHRW3fatfkiEqqIbi0s7kO+1IKX5ux5zgUgwr+yebl7RqDOKWVW2g3MiVc3CDUw5zm8+IP1LmAWP81eO351POU27SNmn71fdgxju1oKPSfwxUEeT3b//WVfshF7rIlP2WLrJs2/Kg42utzm+3vBJjvcWHppEsEH9bCxkiWZqZkWck6k4XLjlON4ADvjsapKl2oUxVe1+v0PJPYVVuANx0yFhvUBlPJlwdrjJTTVfdN2pVJOwdoNFrinAMwk4W3qqdwJDw03AHEdqyYyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSd6C4xO1YZ395Te9Gzj1wSUeBxODnJJn+nUgxBV6c8=;
 b=YpJp3R9fNUsHdwdBBzwSCuD4VoSfNlDR5I22A5ua81y+WIDbobX/iekDlJgpV269fH+WPDml0Et/aoToKN98YGNPT/GXY6j4TNB4i12ZkVRqTnzltDCL11+ARlI5H+fNUOjmrdQI2PaGfa5D/XIHHhbxSsKBHI7CRKpBW3pcFd6/Pi8vqFUd5PSCamOmEshdG3ZBd+AaAZi6uG+A82YgJcmGvgEW7YtKDAz6MfM/innc4USIQS/063OzILvkmUoAsXhlUrY/iuHeoz7BMVMmhcP03rLZf/5H91LXbNtdVFEyQ8N9PKsljBVQTsKfJZp3CMhgIOYTbkM4qRT/P1WBbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:7::10) by NT0PR01MB1261.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 03:13:02 +0000
Received: from NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
 ([fe80::be4a:d29e:5188:b37e]) by
 NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn ([fe80::be4a:d29e:5188:b37e%3])
 with mapi id 15.21.0592.010; Sat, 7 Nov 2026 03:13:02 +0000
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
Subject: [PATCH v24 1/2] dt-bindings: pwm: opencores: Update compatibles, examples and maintainers
Date: Sat,  7 Nov 2026 11:12:50 +0800
Message-ID: <20261107031251.98972-2-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20261107031251.98972-1-hal.feng@starfivetech.com>
References: <20261107031251.98972-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0007.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::14) To NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
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
X-MS-TrafficTypeDiagnostic: NT0PR01MB1102:EE_|NT0PR01MB1261:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c934686-3380-4413-5b19-08df3c7d0867
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|23010399003|1800799024|376014|366016|261026140227099003|38350700014|260925021311599003|260925021911599003|260925022911599003|56012099006|261022105027099003|261021123027099003|261021121427099003|261009223027099003|261022075727099003|261026121527099003|261028144727099003|261102123227099003|22082099003|18002099003|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	AZJEYvxIAvo7phPSG+WwpCC/pS/9aqK4LTdvmvs8dX/66PlGo4R6wVE60EtY1KE83vsnZJ0Q9cumax2GpY5MeKQOmDpTJFekkmifuL0jttWwaBnTzqYizr7LhkrBiK2axQUsuXlCy2ihmSY7IOtAN2s2niBCJW6r8LrtIX6vclhYe/+rmFFbggFsm3sL/er3cl2jhmvAfjPRNEM14WyZ3Ep/wKqpp8Try6K7loeZRfpXx/Dhig0A8BzjC7cJ6LO2GOfx/71aKNXUyL3uG3yMQcCaNxa6cVD3PGyCdLzOIRjZvP7gzawHTNszthJmCHc1pDU9P6WEACOGiU2zaVsn54/pvzB19Kkq8B+aj58fS9fgS0d+uPORNGsxerLyLPROGvk9vWFRSmtuun0gWeZB0Wt3iqckp91UyBrSF/PnomeOiLfujuV4UA2PMkUYNwWGyBOpcME4z507N3ZXgLtya7PPfzksrFt8i08pocbfbdmtfvaulrz9aH+6Q6cTSLxT8qBFpKj6j0Vnuvvg7SK/88uWmiaZNggaSl6oGE6V0n/vZP8E8+9cGvpJnv9GkBfj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(23010399003)(1800799024)(376014)(366016)(261026140227099003)(38350700014)(260925021311599003)(260925021911599003)(260925022911599003)(56012099006)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003)(261022075727099003)(261026121527099003)(261028144727099003)(261102123227099003)(22082099003)(18002099003)(3023799007)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t4FAr4AWs8q3DmeMBYupzx7duhLMTb5hA7Wu7zkxGipHmahqnW6vCh0inxH1?=
 =?us-ascii?Q?uOMhqrt5PqraS2UC+8gMWT5lVjV8hQlJx/LhRnZIjlmfoFDXs1vb72U3WFKL?=
 =?us-ascii?Q?8d8EgygRuFDveexpW2mU8zj45dxbLH3nvK8WsNJDPm/8ppdPS1hKtEWQJgMp?=
 =?us-ascii?Q?X3deF+k00T17TSnU9MuC0EYjuNthHjKpuRxbdYC/1dSrjvU7eIsdT2vAFfXG?=
 =?us-ascii?Q?0naAfyyNTlY9WqDRkw58cbjum+jSAUYryL84bjFDwCsc6wO4iPjccysT1t56?=
 =?us-ascii?Q?PxDissQQx1P+jGjMNes2nd29+xWmGEHU1WUblz4/R3RA8k+AI86sYt6MI94F?=
 =?us-ascii?Q?Xho0GISg2P7BL5NyOtz55Te+26IKVryW1f9ix50KxDaugR/fPJ2e18HPqGZ/?=
 =?us-ascii?Q?4CyBQUsDE/P95JxAQIJNGZlolI1Vu9pzMNhCvOPgGg+QhzGPfdNrEwtQ6VxD?=
 =?us-ascii?Q?zIe+NcQyQOAPT1J5kYTlphBlJHCJREI4ZwGcSF1dDa3mVYI0LRH4V6/F18sk?=
 =?us-ascii?Q?TFDKrEt/Fx7VLNxMpwkie5PswAdCS5jNMqEblagU0lGo9nB2nvu0KZfEsYvI?=
 =?us-ascii?Q?rs54kbN5U/tE5/C+tXmMcCCyOKMG2J796X/g7PWgkJkX8MI9N4u3T5tlOmj5?=
 =?us-ascii?Q?OQgPmJrO5VbQ6bAG5ewxWF7+5Tq79tsehxAneUuHpJWeWc2sUiSgHRlzY+aM?=
 =?us-ascii?Q?45A1bEFgKPjdub/nrcFpAtkKVJ1uX22rR8U7SrdnEOIeikajttq8NjIk7Ra9?=
 =?us-ascii?Q?IWQ2tIU70S5bqOT6IeebI421uJMslNHXXEg21K7zI1hSk9yNYm0Hf5uRgSYK?=
 =?us-ascii?Q?7DwdxDjl/mVIySrwpvtDICiS5y/UwKkdna4K7nzwQShyNc+Lxy4tsf4Y8ySZ?=
 =?us-ascii?Q?bS7H7SCPk2aucSsE4PPAPkeojB7ik8gjw8/aJ6sw4oL5HIu+hlrwnMTCwJ2G?=
 =?us-ascii?Q?R9YU/hs6zclqWlb22Dbck+Yo6TBZmKV5FVhcoAd+kpjpNE1KntoiwUUd5BFJ?=
 =?us-ascii?Q?PNhWHDq9h214R+vDJL8TtEI/lw7gWl+KCQMjua0tky2PvRi4mD9HBi3wabke?=
 =?us-ascii?Q?6Ec7DvZL773r8DodoI5a+HM4/ymUlj60umDndxMUGOV/0Vfdx6Q6NCjX9N7d?=
 =?us-ascii?Q?yBYxXybrilxVrSqWQmQVNLPgQnw272K6V7hBaL1FclGqyMLG7TbtmhSPMMju?=
 =?us-ascii?Q?01pB9VWTlnhX9IJBO8fL39Hkxb/KD6Dxe7BFLj3iT6nA/kcXF7ddkA5Jssh6?=
 =?us-ascii?Q?4YcydwQ9P3Ex5SlNlQtI+LvozfdcCGCbHUihZaXC4wBtYYUvs6RVRbbIwEl8?=
 =?us-ascii?Q?FEkZh4TOW9u8XutsNHrDuXK3fuRBTjYY3ZAUOXMJEu9SIybC8U3iXgKIdD+J?=
 =?us-ascii?Q?LUxLtL/cYX6Yc/7fxkVozCj9sr2qMfXopCpgpA97R8EQUvIBORj7hAwE9ZRQ?=
 =?us-ascii?Q?HyMoAZtK84U99EB1qaGVagWwPbzTRHIB+yazpKA0oj1kH2jk7OeolJhED2KS?=
 =?us-ascii?Q?42lSsUUu5DcFX1psjhHBVEA5YkLa0ghWVuUOPL4fAth/FTO0UPE8iF2KOKYs?=
 =?us-ascii?Q?s0Kxk+g/8LXrb6Bj2ZRCzKrXysyQqtZRImM8DS1xU6eEL74jX2LV037GFfCx?=
 =?us-ascii?Q?NpFj6z0W4g+nN00U2Tc0/9QLphxfcHCnREqcOz4cjHl7YeUaGDB7jNUzTfFM?=
 =?us-ascii?Q?gX0r7k2gHww6QaMutm+jYXg1fyfQPDzB4n71VabWXqfNgWSrjdRuGIUOKJ3T?=
 =?us-ascii?Q?YPqhOPcgV3lCQGlW3WA1I9iVbQTQrcA=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c934686-3380-4413-5b19-08df3c7d0867
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 03:13:02.0690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GSWo3bpqO9JZ+0uQ5HqHWntrCv8fl2GewnR2krLfs1VX/mpLSNMAVJ654KNaQriSikRCL1DlaV/eg5obtbw4ekXmsCWo3b8+2gUIeb7uzqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1261

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

