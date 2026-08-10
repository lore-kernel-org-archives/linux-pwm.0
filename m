Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2109.outbound.protection.partner.outlook.cn [139.219.146.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BE2346A0C;
	Mon, 10 Aug 2026 03:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786331257; cv=fail; b=k5YV5Mg0FjpEMkkaMMS3rkuihCBD0kxNSm5F4bqfYyNObEP56eaTrFNkesIfmKdzq2RvxRK+wPK2ip97uBgD8kBMnB4MUHX6iIy2CV/zZWSRo3Rpli+5hQM61qFUWcZkFUOWtLpY6PlvAWyIN7/pCCkXiz6vWD7Vjaotkvx3NDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786331257; c=relaxed/simple;
	bh=11LLsd8v/iKCSo4bV2NQM8dnGyS+MLkzJp81qnhMwdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FfCUrLAW1a4NQwFIWeRgFOLklyHcSd6+R4FprPOSbiicGWZ7/J+utoduNT76QMV4IQg0dk6Zly4XMktlDC+N4s+mr4Spok5YGGvn9zfnYd77d7hIfp4pGK3IGLTLA2ZvaYrJMs8K2z3xVsssRc85PrTqyc7cD4L+riaR7UcCIRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djZnycunyTY2kfYRcdIDPxtUce3lnB1L79sqmv2iw4vMJLVGJ1Ny1RhjIL+J0omHmKMJKppVmVphEanmqhHOZevAVJI5wNZsDP//24MFjrKult13+BjwTYL1kZeG/Kr9g96LS0d/GkKE6SUSjm5Cmy54v7Wp8W3ofY/CW6xLqglDN7anz9Y7OyYrORAb2BrUxm3HyVBx0jGo9/jFV6g/Fpioz78nfj1JDzw0SMh5KTD8COQm9MBGe7tgjhc9wYg5uAzhOtD+LulOLsSI03Duibh9kZOg5Rgsm3vYKDVwLDKJU+3FAzimiIMMn85w5+3Zrd+Y4kx4PkdwWG/YowQquQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YBV86v3nflUO674Q+hvLcTmmy+Ukq1Nv/1bEE7q5W8=;
 b=NZmg+UPPUtIU9uapQ1aQpruyMhul97qy2HC3UJayzLlhTTo1u9mBp+xxoe9VuAGJ+k+EOBvqqfSDYb1aCv1o57zdoqiqz8dvfsYCjhlRbA+E1tUl3BOruzXvT4MpL13BN4tle1NwC5vzBVDTBCTWVKycs2vYTv5/gMbp7gF+6mZmZsATg1TTqPzu1Vkd9mGSkeF5xevY+j0c28LEnBogKqYvJEftUUrQC0v86kI9aZXldpr4aIJzUm92TIVwik4Tdf/bYYrU9LOvvDekHdQqy0IH0LVH0Qw8B0oR95UvHByfH96QmPXilUHZ0ihGPVvDwGTAne2lDOOeJGO6lIkKTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1178.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 03:07:22 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::4386:5cc4:3bc4:4795]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::4386:5cc4:3bc4:4795%3])
 with mapi id 15.21.0292.024; Mon, 10 Aug 2026 03:07:22 +0000
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
Cc: Hal Feng <hal.feng@starfivetech.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND v22 1/3] dt-bindings: pwm: opencores: Update compatibles, examples and maintainers
Date: Mon, 10 Aug 2026 11:07:12 +0800
Message-ID: <20260810030714.48100-2-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20260810030714.48100-1-hal.feng@starfivetech.com>
References: <20260810030714.48100-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0014.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::19) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1178:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d14d7d5-a137-4ee8-d142-08def68c7f5e
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|23010399003|366016|1800799024|38350700014|22082099003|18002099003|56012099006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	oGhdc8y/kfA7YRoTreLfL5x6lpzawXLk7ILrRl90Io+BUctzPm1ekLub/06vvhk+GOtQnnEe7axqHff5ke5KD+cIsevbRjZOgfbB5LCVf8goEUY1iyFEZ6QvpyE/gm4NHXTOl3WeKSKhHB/UL9pOLyjv/Yfl+f+tzdt1vgGjODGqsaqbKcRofUG6K7ktc6k05oF7RR1VaNHrScCx8h0UJDNLD1gHFTFcoyXOR3oafRbMf4BFMU98U9mYk/51jNZWiP6i2gpgNeb/J0LOnidJqL11O+zNJh5xy94hi1LpRweXZX6k89TckvheyKv8Djyx37a+LpEoFyGkNyfOhdJLWMbaUuKjrsxLx21UD/G6YtM2Ops5/I6htumjJ8bz0e9P1+myEuYd7eOLR8TLt/q/KjaA8EjiltBXn6doGE7yqfaP+4xO/M/x3wCFVubRpzHxv/F7NPwB6DKL5XH+gJLRhr5jYZPlytJNPoWWr8MtMN8XSdEId7HkfPeFGGYu1OZYfH/ovstjZDF+NYQn8rZdbllNz2KP1nRyhWXv83ef24syQqNw8LDUQaOnUikiJOPb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(23010399003)(366016)(1800799024)(38350700014)(22082099003)(18002099003)(56012099006)(10067099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iCM6aFnd/SXZxDliZToxQ5oHLdq5DBXalXOtn1hOVxq6PFKKqj74MT0HHIPN?=
 =?us-ascii?Q?3CJyukGlFFzws6fHdKrMqaJRtLMvlyrD9kriS5n18ig2NNomN1MbUHZEaPlL?=
 =?us-ascii?Q?ql+G30aMWfOzk0AfGI2C/CFPxxFVqOK08ZynxyyMhQ+3K1p5JXN12o2dm4O4?=
 =?us-ascii?Q?gp098EbbyX1I+jyvUOQ/w8UG46mcUG/od/GuZCZiuSCoYng3XzyyoK3RiD+M?=
 =?us-ascii?Q?CipFX9qF4BPjPl/MRntzh3EpNYljC9t2ytDZCA8M+bQFCMb9WCfHAzG1bwX+?=
 =?us-ascii?Q?TXxZvxO6A+N/ZeRCJLnQvHwnR+Lq48CMIPrK7JrPPaEfaKvZfg/wZqb7tDmv?=
 =?us-ascii?Q?AEH6U/dBoWKSPRSKnHZvMLm6ci6dxHQljWX06H1/1uCgoqLsCKi78Ds9qEsl?=
 =?us-ascii?Q?WrDsXBksveD4Q+Ulcc+36lPOKUk6EbeJwtWlfzArph45FajR+ky0H2aRL1fV?=
 =?us-ascii?Q?M9VPw8zIo3EWkFxMF+i0gUmm9heQmka2aKSDphyxjYpdqzeFfMNl/SD8IFBC?=
 =?us-ascii?Q?pzA0D85NhHEPH5sTwXoof5d1IWBJrqrqBt/oylOr57LBevxsgxKKJu7i9WqP?=
 =?us-ascii?Q?yCMEfbxpcyrQb9+UaTurKzVDc+wqBXNwkUDkj9lP+YOHkygSOchznzYFZyO7?=
 =?us-ascii?Q?SI67/dkkzRP9FP32ESpdFt8XuSqEPYuY4CeL+D5zNy3KERbPB2tPJtlau4qB?=
 =?us-ascii?Q?QGZrqLCnV8aLNiN+opxlsWi3dm+pNl5/j2cs5C6r6XSrmN26wQE/I4H/YPKv?=
 =?us-ascii?Q?4eCZBMeql+/J8iguGW6aXxQBwRWcaUMgCJLStyT8X5zH5bRJRIOLdMvLqTgx?=
 =?us-ascii?Q?HMAaexn0Z9usVuaEOAbXfR8RF8Lywo8lZ+wVUKYWmYhvuJ5AMeUrt2NpNYKC?=
 =?us-ascii?Q?Laby5PRKWLbmuA3wB6+D/U9ItfMO0GdODcwZgV/cELNk5qbsI3e/WnTCc+Sj?=
 =?us-ascii?Q?L3Xhqns0IBN5aBr/PoEB65wXVPNYcoKUFw7xtVkjY6G/+DK5G8mlcEBszpVW?=
 =?us-ascii?Q?ydHW4xjR4N6iWIdpW+v2ZhgNQTawKL3IAYNjbSKUeHqQa8osBovXuW9aBJwo?=
 =?us-ascii?Q?wH6YqN994C/Cr6N6mvlaVZ8JKt0ZMI06IEGPZQR6ihy+7dTr31ASR+qFrVBr?=
 =?us-ascii?Q?R3SMh7glvy+iTOJoPHWdPx9Q2WuQAz8ON0bG3euJmsNgisiroBuwNZvh2m5B?=
 =?us-ascii?Q?3hG9hAv+hp/hOx9eWfBhveIaqTp0m28+lzMlPJTSEqV7dt8mrwB+qrrKOR+q?=
 =?us-ascii?Q?DTVsbp5EwMflglWocyR7LpVOUE+klKayFAK6GvkigS96D5Tn2rIX7nWV0g3h?=
 =?us-ascii?Q?VhzvCRQ6a1fgO7XrcrqMPvm0pK7X2GEtv3FKQ/1H+cQciYwG1kE34WxSLRSo?=
 =?us-ascii?Q?vlvhLsDtu3eI0LxlCBWg5XTQ2BFNQ5+6dXBERxaR8PzGpABQDHJEpbQR7kBr?=
 =?us-ascii?Q?KbJXtSA7srNATQ4JSJMdElErNwqn3DBFAdIHKMf4VkVPZawgdrIUhMjOdzC0?=
 =?us-ascii?Q?i1/OQHaO+Y+/PthQ7M0bS3fFubBre7iGpukVQ+se1wSKqEflzrB8JMFhfY/x?=
 =?us-ascii?Q?2ig1RBbJwhKkBlmYODwKqvpcvdZazdeUrn0Oj18TDZg5TwnB90Rxdke+UrCI?=
 =?us-ascii?Q?CQ9ff9Z0BAtT+N4PxmIAV2ZCBszfralnJMcdKfh5dpokGS5NPfE0jAYF7M9R?=
 =?us-ascii?Q?V5NVDnf5F4+pmPjeoJSWwRy2VfiB0Cz6s4GdIr+BT+AZGzyEaSHmseBLC77v?=
 =?us-ascii?Q?4JSqjqGWAA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d14d7d5-a137-4ee8-d142-08def68c7f5e
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 03:07:22.6672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vOmgADD2SG0vsyqTKjLxLUvtHmjnB3JEG58y9giXQoH94k4FaZRfr142Bi3F3y4eIPhjpcXOReo+L8vdjrSzbW2ZSfXoCIYaQKrabXp8cjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1178

Remove the jh8100 compatible since the JH8100 SoC has been canceled and
will not be released. Add the jhb100 compatible to replace it.

Change the register size in examples to 0x10, since an OpenCores PTC IP
has only 4 32-bit registers: CNTR, HRC, LRC and CTRL.

I will maintain this pwm module in place of William.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Fixes: 2529085831b0 ("dt-bindings: pwm: Add bindings for OpenCores PWM Controller")
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 Documentation/devicetree/bindings/pwm/opencores,pwm.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml b/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
index 52a59d245cdb..42c5d2b6326d 100644
--- a/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: OpenCores PWM controller
 
 maintainers:
-  - William Qiu <william.qiu@starfivetech.com>
+  - Hal Feng <hal.feng@starfivetech.com>
 
 description:
   The OpenCores PTC ip core contains a PWM controller. When operating in PWM
@@ -23,7 +23,7 @@ properties:
       - enum:
           - starfive,jh7100-pwm
           - starfive,jh7110-pwm
-          - starfive,jh8100-pwm
+          - starfive,jhb100-pwm
       - const: opencores,pwm-v1
 
   reg:
@@ -49,7 +49,7 @@ examples:
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

