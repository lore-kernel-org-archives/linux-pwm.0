Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2109.outbound.protection.partner.outlook.cn [139.219.146.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD153546EB;
	Mon, 10 Aug 2026 03:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786331264; cv=fail; b=op1TGWRm1HD3PFg4l5BCsa+nqwlBWhoCriJr5CVaqMgHgobuwgBUG/zdEM8Jv0j4aA1dgHwinlf1Tte8QX4BxaTiti9rY5MZgdotj3V74YWYSEIwl5KulQlaaNlU8X1AzfXgdkztrkToe7ZmSPi4G+56AbQ9UBvBiAeXyGhs/64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786331264; c=relaxed/simple;
	bh=mW3Obbi7ZNnF8KGepPlAyepjebbbRirAs1zV0C8olkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gNPy5DWmoZ8yczMh1pk1u8ftzuWvjaSjeZ8CwcsJQLEh1LXgzaVPSvSr8I41Qoihy1foRiIIq3EfR88CZqOxJ5xWozvQTeg7XKEZZhV79BrdNEVIGF7rHMQHmLd1Tf8jicFm4+OkR2E/CW5npgwDFHBhtSX8bGBvhfpOhHnMXUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wop1R04k2yrYcwlq0gyod2q6e6Gh+iGwexLncad6ZsnV0Hm0sEIiBdYLoB9yJn2NiOf2RWsmzhoennY2b1ak7mbunaSl7vy93NJ9IBo5pBHWW+XLAGa4+BUr60DMoEIgjqDCDeer8aPPv8u4YWA5bBf6Sn4wVFY89dDorF+kA/hgtr6ZVSnl9DuI7rDCp9Z8TutS3NV6ZSN8XX7LQOXkp4ycPy1dJsQ9FIAB5EjuP4zEBnaZKgeoErCW7tIkjrHjxpgLDUmJhUHLO2keOkHZYob4gZ6KHbXJk/R8u9Roz4dKEyXgSjtCWWkwnpkxgfY/bmghery4EKGe5MfM4txLQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YD3IboAnPkUzVxwkee6yCSeA50vzochcqZ48GkMsiXM=;
 b=g+irZI7dWCFCVeVf/lxgCHrMeyi11H7Yc1ANZSwcpUV8kXOR7wMQ+JS2HL6t9nUTV49Zfnc1kLYzGSlCRtzA3EOybK50695CS/0tuVHmOS1OxGsxEU05mFNAa6gI1iX3l1HdSzGSRl05/3iPi4onLatABs6WSbQN8SZBxFGvsxFEcaJR/5EFbnALc5xbxygmJ5wEg9D5Qk+E25lDC1XVdtlJfhR5l/G44PsjoEQDhPpk9YWFXQpmBSDBn71IT2p7GRIoom/3uBOligrpGomgBM5hyXvApDoW9xxB0zNjREkEhlFDNif3ObbZ8k7EufJq+gya7gQ0KYL//1aLNijFjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1178.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 03:07:23 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::4386:5cc4:3bc4:4795]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::4386:5cc4:3bc4:4795%3])
 with mapi id 15.21.0292.024; Mon, 10 Aug 2026 03:07:23 +0000
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
Subject: [RESEND v22 2/3] riscv: dts: starfive: Correct pwm nodes
Date: Mon, 10 Aug 2026 11:07:13 +0800
Message-ID: <20260810030714.48100-3-hal.feng@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 27ec4f70-5fac-4f55-8d8c-08def68c7fe5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|23010399003|366016|1800799024|38350700014|6133799003|22082099003|18002099003|56012099006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	KTc8+tz9sZ3pLzFnzPiJwlkbyFhMWwTZGiHzzPNDm9f7pu70gGJh/j8SKEUtWoKMc/ck0zRR8YAoxAxcN1nOkjyv0Qasnnu7UuMG9RX8FbVfSdn5L+8cmILdXo6J1mjtQCoxIHeUJx4EPg1G6tHRYAwrH02NM2STvc8722ck9EmrW9np62bzCbvRpNaLXOjPTceHoMjWUhuVBGcD6/LlNm4LafyS3mk9MYWwF2zZYPz0GG0JS2E2XIAGSWKtOO8iP3Ge9NndRJhKDOBiGXBUWWCOIV92423TzGX+gG1WUdkphCGDn54kqm2tj5v2qdAYCKoB1oVnjIOO6GfuzYVqNkrN9udXv/04Ky052f1xhgDajrL4W4X3281yt50ZtQFZkeFuvW3jvf6kq0njxTKV4x2iRzjefh2H7dEUo/MbZwgkJQAn1tqBvutyWmUSbxhOhiw7O3sYw74qD8GEHNdjJLa5RgeRWaLbFdaUE7DqHqtZuLdJ9n5MRzdbSq1SGn70Um+FKoOKPsF3K83YJ6JqR/GT+dbe9fzfooRLliDjQKktSt3uuXmmXtZ/ni7iQZEd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(23010399003)(366016)(1800799024)(38350700014)(6133799003)(22082099003)(18002099003)(56012099006)(10067099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a2gBiqISs+vB0IiDnfI8YVagi5f2gRDTtdVeR3SB6egcPzL3bRd2Y5Wrvd0I?=
 =?us-ascii?Q?DxWYxPqMlJcmxVWr9YRljMRwiKS5nAmPSZ3kDoWorsKnABQDwJ/5J+wpwDJu?=
 =?us-ascii?Q?+a0TZYgG/lOg6tOAjpvWfJ7ioMZ0SHQk9Iqn6sCYjA9xTbh3aT1ylmwkC1Ui?=
 =?us-ascii?Q?G0Iqoi4OH7x7oyIH5EauSP7h1d3J848pxJFqsjhT2Xm+tsw0fUIcADhEGuBz?=
 =?us-ascii?Q?OdGphYOZfsf/AevY4l9Djw4dS6GdmxsSUTOU5ckU67nxzlP5BSnjUshmguVs?=
 =?us-ascii?Q?kBCLAmTge8AMPFA1prv7JGOASKnKgY+8nvM5WBgC4AZGUkEyuctb5EXnUIO0?=
 =?us-ascii?Q?4YsRBekB5+Tt3qgB8oxCYLBWhwHDk66aoizLDLEjngLW82YbvBPRsqN+aQ+6?=
 =?us-ascii?Q?6OPwxUYGthoIXrTa+azpxtXW9xUNBZHDltpLVi0fC3ajlrIt6CGwxM5m5cbE?=
 =?us-ascii?Q?fogNLm+v7i2qvkZV4o5U9M8mH/vXRTOem1vKfvGBx6CzagC+hEjVAikrnUhd?=
 =?us-ascii?Q?aAVmC8+s1t+K3XHTBkbJmE4pTnszp74x/ZKvtQ8JycKS3REezsVfvFgEaqc6?=
 =?us-ascii?Q?rOpzweqI+Hjtc0CB2QtVqv3JQszKGMqtrcjrM2gMLSgvZ2OM/Bpc+i71rT8X?=
 =?us-ascii?Q?PUaYor12Is97D0qgNwYwsnq7qMd4lukI7iqlsllyK/khb4hAbr5vh2nNJeti?=
 =?us-ascii?Q?Gj2z5G6Axdasmpql2esMyQBh8RQTauCMW4Nk5D4fTR2J9V9DjAolSiTUZbU+?=
 =?us-ascii?Q?sCbMrmCKJGFZyB8qJMCdxnik0zqr8hKlQUCoIXFh/J3ZyOyQQFRdJjBxb6cM?=
 =?us-ascii?Q?VZ/zxdIPfIeumkm4bW0MiOZa+a/IxqOrsv6ONokr8qLQ+utSjGJPllpCVlou?=
 =?us-ascii?Q?HafxPcVR8aeNbWTfS/N9FW8uLHRXNNvyiVzyDG7mgkef6+/ezzFJaVZbQyTI?=
 =?us-ascii?Q?jiY93NO/GKe+lD4BBDKS919q6ilNSTmRUDnUKmznVLErpwd/VpgvV7IHvYFA?=
 =?us-ascii?Q?8M5TfHfgE4Cem8BCSg16wbW2zahT1YDgTzb3gc5/O5TDyKg7zFZkOi+1Z+xo?=
 =?us-ascii?Q?2HDD/mkCrZ1XRr9VOUC1Y1+JHEUvhghaLynJvYaPCZ+HZcZ0VVN/XL+4GwQU?=
 =?us-ascii?Q?Wpoia9Vx3wsCbUGAuwc2s+CzPQAtVnk5QA5qE5uhTabwY+3DSMAB4mdlj0gc?=
 =?us-ascii?Q?HyGXhSIYinHs+idw3bepaWJB2QE8Jzn0m5xEXfQV8lh1phrvzZVzM9iVxwt7?=
 =?us-ascii?Q?pYzXmgRlDJA2gI8gG3DDUumRZh9CNZXJstHw9DAEwLNh8upv+Gu4IE5lQMQo?=
 =?us-ascii?Q?psD0YgA9qGOVtUaIGsK7t11Ll//ND9HXzDy4dN7bc0CW48EmhvrP87sG8CuT?=
 =?us-ascii?Q?h92ceA5TuOU6E4fDDYEJjLByG+kpICw3e8fbJ//8VVZtRPJpJRtqdFm19Azc?=
 =?us-ascii?Q?5doJlM6MNe+jaJxrHCcC0f6jT3c7kFzQ8V6cReNDMEyfjdClbfcgNz3+619+?=
 =?us-ascii?Q?sRpJezamTDdrKq9A43XfXRJnYWU9EWUV6JDqey5rbzW8wH/8otvxviEwRETk?=
 =?us-ascii?Q?qMsS+kX3VRa8NsCAbTFAabY4FMm6LGO6g0J/jSGRs2l9i++wxWQPD0EujR9I?=
 =?us-ascii?Q?uInl9yhbHECRzPeGvx1+Mjb/aQmK5BdD+zfLkG25nVxyCPrPPjZgWa+B1VLP?=
 =?us-ascii?Q?clpAPWZUiADXs/yWwzO2Ik8mK7SJQXvDz0o4h5o8vyIRfVLt4h9rYSijVZTX?=
 =?us-ascii?Q?Lh4YvYvjIw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ec4f70-5fac-4f55-8d8c-08def68c7fe5
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 03:07:23.5837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GmQyekaExePElDaH1XFL67aznhBJl68TbJtf5/efuotIDTTSisr9OHMNhvzWS2e5civcgH0MUGndnaHGL4etukCnvYqFANLP1jX139yyHpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1178

Each of the StarFive JH7100/JH7110 SoCs has 8 OpenCores PTC IP
cores. One OpenCores PTC IP core can output one PWM channel.
Change the register size to 0x10, since an OpenCores PTC IP
has only 4 32-bit registers: CNTR, HRC, LRC and CTRL.

Fixes: 8d01f741a046 ("riscv: dts: starfive: jh7110: Add PWM node and pins configuration")
Fixes: 5e598b99fedf ("riscv: dts: starfive: jh7100: Add PWM node and pins configuration")
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../boot/dts/starfive/jh7100-common.dtsi      | 28 ++++++--
 arch/riscv/boot/dts/starfive/jh7100.dtsi      | 67 ++++++++++++++++++-
 .../boot/dts/starfive/jh7110-common.dtsi      | 27 ++++++--
 .../boot/dts/starfive/jh7110-milkv-mars.dts   |  6 +-
 .../dts/starfive/jh7110-milkv-marscm.dtsi     |  6 +-
 .../dts/starfive/jh7110-pine64-star64.dts     |  6 +-
 .../jh7110-starfive-visionfive-2-lite.dtsi    |  6 +-
 .../jh7110-starfive-visionfive-2.dtsi         |  6 +-
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 67 ++++++++++++++++++-
 9 files changed, 198 insertions(+), 21 deletions(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
index ae1a6aeb0aea..85106545090e 100644
--- a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
@@ -199,13 +199,23 @@ GPO_I2C2_PAD_SDA_OEN,
 		};
 	};
 
-	pwm_pins: pwm-0 {
-		pwm-pins {
+	pwm0_pins: pwm0-0 {
+		pwm0-pins {
 			pinmux = <GPIOMUX(7,
 				  GPO_PWM_PAD_OUT_BIT0,
 				  GPO_PWM_PAD_OE_N_BIT0,
-				  GPI_NONE)>,
-				 <GPIOMUX(5,
+				  GPI_NONE)>;
+			bias-disable;
+			drive-strength = <35>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+	};
+
+	pwm1_pins: pwm1-0 {
+		pwm1-pins {
+			pinmux =  <GPIOMUX(5,
 				  GPO_PWM_PAD_OUT_BIT1,
 				  GPO_PWM_PAD_OE_N_BIT1,
 				  GPI_NONE)>;
@@ -359,9 +369,15 @@ &osc_aud {
 	clock-frequency = <27000000>;
 };
 
-&pwm {
+&pwm0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm0_pins>;
+	status = "okay";
+};
+
+&pwm1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pwm_pins>;
+	pinctrl-0 = <&pwm1_pins>;
 	status = "okay";
 };
 
diff --git a/arch/riscv/boot/dts/starfive/jh7100.dtsi b/arch/riscv/boot/dts/starfive/jh7100.dtsi
index 7de0732b8eab..90438df1f74d 100644
--- a/arch/riscv/boot/dts/starfive/jh7100.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7100.dtsi
@@ -360,9 +360,72 @@ watchdog@12480000 {
 				 <&rstgen JH7100_RSTN_WDT>;
 		};
 
-		pwm: pwm@12490000 {
+		pwm0: pwm@12490000 {
 			compatible = "starfive,jh7100-pwm", "opencores,pwm-v1";
-			reg = <0x0 0x12490000 0x0 0x10000>;
+			reg = <0x0 0x12490000 0x0 0x10>;
+			clocks = <&clkgen JH7100_CLK_PWM_APB>;
+			resets = <&rstgen JH7100_RSTN_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm1: pwm@12490010 {
+			compatible = "starfive,jh7100-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x12490010 0x0 0x10>;
+			clocks = <&clkgen JH7100_CLK_PWM_APB>;
+			resets = <&rstgen JH7100_RSTN_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm2: pwm@12490020 {
+			compatible = "starfive,jh7100-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x12490020 0x0 0x10>;
+			clocks = <&clkgen JH7100_CLK_PWM_APB>;
+			resets = <&rstgen JH7100_RSTN_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm3: pwm@12490030 {
+			compatible = "starfive,jh7100-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x12490030 0x0 0x10>;
+			clocks = <&clkgen JH7100_CLK_PWM_APB>;
+			resets = <&rstgen JH7100_RSTN_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm4: pwm@12498000 {
+			compatible = "starfive,jh7100-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x12498000 0x0 0x10>;
+			clocks = <&clkgen JH7100_CLK_PWM_APB>;
+			resets = <&rstgen JH7100_RSTN_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm5: pwm@12498010 {
+			compatible = "starfive,jh7100-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x12498010 0x0 0x10>;
+			clocks = <&clkgen JH7100_CLK_PWM_APB>;
+			resets = <&rstgen JH7100_RSTN_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm6: pwm@12498020 {
+			compatible = "starfive,jh7100-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x12498020 0x0 0x10>;
+			clocks = <&clkgen JH7100_CLK_PWM_APB>;
+			resets = <&rstgen JH7100_RSTN_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm7: pwm@12498030 {
+			compatible = "starfive,jh7100-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x12498030 0x0 0x10>;
 			clocks = <&clkgen JH7100_CLK_PWM_APB>;
 			resets = <&rstgen JH7100_RSTN_PWM_APB>;
 			#pwm-cells = <3>;
diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
index a7a1c09a2c90..64de468f2c31 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
@@ -326,9 +326,14 @@ uboot@100000 {
 	};
 };
 
-&pwm {
+&pwm0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pwm_pins>;
+	pinctrl-0 = <&pwm0_pins>;
+};
+
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm1_pins>;
 };
 
 &spi0 {
@@ -528,12 +533,22 @@ GPOEN_ENABLE,
 		};
 	};
 
-	pwm_pins: pwm-0 {
-		pwm-pins {
+	pwm0_pins: pwm0-0 {
+		pwm0-pins {
 			pinmux = <GPIOMUX(46, GPOUT_SYS_PWM_CHANNEL0,
 					      GPOEN_SYS_PWM0_CHANNEL0,
-					      GPI_NONE)>,
-				 <GPIOMUX(59, GPOUT_SYS_PWM_CHANNEL1,
+					      GPI_NONE)>;
+			bias-disable;
+			drive-strength = <12>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+	};
+
+	pwm1_pins: pwm1-0 {
+		pwm1-pins {
+			pinmux = <GPIOMUX(59, GPOUT_SYS_PWM_CHANNEL1,
 					      GPOEN_SYS_PWM0_CHANNEL1,
 					      GPI_NONE)>;
 			bias-disable;
diff --git a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
index 21873612d993..54013c70f4b4 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
+++ b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
@@ -68,7 +68,11 @@ &phy0 {
 	motorcomm,tx-clk-adj-enabled;
 };
 
-&pwm {
+&pwm0 {
+	status = "okay";
+};
+
+&pwm1 {
 	status = "okay";
 };
 
diff --git a/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm.dtsi b/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm.dtsi
index 025471061d43..31afac27b86d 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm.dtsi
@@ -87,7 +87,11 @@ &phy0 {
 	motorcomm,tx-clk-adj-enabled;
 };
 
-&pwm {
+&pwm0 {
+	status = "okay";
+};
+
+&pwm1 {
 	status = "okay";
 };
 
diff --git a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
index aec7ae3d1f5b..a9e82f25efde 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
+++ b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
@@ -95,7 +95,11 @@ &phy1 {
 	motorcomm,tx-clk-100-inverted;
 };
 
-&pwm {
+&pwm0 {
+	status = "okay";
+};
+
+&pwm1 {
 	status = "okay";
 };
 
diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite.dtsi
index f8797a666dbf..85b56a72dff7 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite.dtsi
@@ -74,7 +74,11 @@ &phy0 {
 	tx-internal-delay-ps = <1500>;
 };
 
-&pwm {
+&pwm0 {
+	status = "okay";
+};
+
+&pwm1 {
 	status = "okay";
 };
 
diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index edc8f4588133..35208f95cd3d 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -73,7 +73,11 @@ &pcie1 {
 	status = "okay";
 };
 
-&pwm {
+&pwm0 {
+	status = "okay";
+};
+
+&pwm1 {
 	status = "okay";
 };
 
diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 9c3e4598747e..82ea63f715b0 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -846,9 +846,72 @@ i2stx1: i2s@120c0000 {
 			status = "disabled";
 		};
 
-		pwm: pwm@120d0000 {
+		pwm0: pwm@120d0000 {
 			compatible = "starfive,jh7110-pwm", "opencores,pwm-v1";
-			reg = <0x0 0x120d0000 0x0 0x10000>;
+			reg = <0x0 0x120d0000 0x0 0x10>;
+			clocks = <&syscrg JH7110_SYSCLK_PWM_APB>;
+			resets = <&syscrg JH7110_SYSRST_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm1: pwm@120d0010 {
+			compatible = "starfive,jh7110-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x120d0010 0x0 0x10>;
+			clocks = <&syscrg JH7110_SYSCLK_PWM_APB>;
+			resets = <&syscrg JH7110_SYSRST_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm2: pwm@120d0020 {
+			compatible = "starfive,jh7110-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x120d0020 0x0 0x10>;
+			clocks = <&syscrg JH7110_SYSCLK_PWM_APB>;
+			resets = <&syscrg JH7110_SYSRST_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm3: pwm@120d0030 {
+			compatible = "starfive,jh7110-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x120d0030 0x0 0x10>;
+			clocks = <&syscrg JH7110_SYSCLK_PWM_APB>;
+			resets = <&syscrg JH7110_SYSRST_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm4: pwm@120d8000 {
+			compatible = "starfive,jh7110-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x120d8000 0x0 0x10>;
+			clocks = <&syscrg JH7110_SYSCLK_PWM_APB>;
+			resets = <&syscrg JH7110_SYSRST_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm5: pwm@120d8010 {
+			compatible = "starfive,jh7110-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x120d8010 0x0 0x10>;
+			clocks = <&syscrg JH7110_SYSCLK_PWM_APB>;
+			resets = <&syscrg JH7110_SYSRST_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm6: pwm@120d8020 {
+			compatible = "starfive,jh7110-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x120d8020 0x0 0x10>;
+			clocks = <&syscrg JH7110_SYSCLK_PWM_APB>;
+			resets = <&syscrg JH7110_SYSRST_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm7: pwm@120d8030 {
+			compatible = "starfive,jh7110-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x120d8030 0x0 0x10>;
 			clocks = <&syscrg JH7110_SYSCLK_PWM_APB>;
 			resets = <&syscrg JH7110_SYSRST_PWM_APB>;
 			#pwm-cells = <3>;
-- 
2.43.2

