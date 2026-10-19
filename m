Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2117.outbound.protection.partner.outlook.cn [139.219.146.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6446D4E4C55;
	Mon, 19 Oct 2026 11:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792409063; cv=fail; b=Ry8RwR19l9eel2fNmmcro3ShY/0hb8ETZTbGXuwzSk0QBzM6IJq9n20DwCBAebtKosaHjbDDAH1hhzH6Y6UF+uwSEDqS/7GjjSKIOpqZLiznAyRDHIuippoAHYODHVBLgX/u0vC9ijni9560I8XjYGgjxwe/nGhFMsxP+Ll0vz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792409063; c=relaxed/simple;
	bh=1m8mYwTbumdI18giTwhjA5fOMsDBdJgAk52/aqLfEw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xj8nweKN7a4T3ZplQgAbGvKj5KbyEkknSPLlcqtC9ba1qr6rbTOE8aaasaGBq6Y3K8/ZOADGV9EjE1G3rxnuFrC2WQbGNHyC3gja/qFjTZivFWCVM6o1bHxg36m7O2r/MB1IwpiDy3ERIi7HyNKI1VAQoHQbPzKqAunK5LG8yI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBrfAPznN7Ir4ZpdfvYEkz03a5QrKjmvqb60AuKT9faszRrbxCLCDE/v/MXyJJfRbwQt2w2JwhUeRF1o+9hfmaPqHqQXZW7UcVQU/oY1XL37P9PLohcds7Iv0YG4eM0Rp3KWrI8vWaxJcroc8LFRDzN2Va4cwOBBsu/u+Flio1I0v1V+hrIzK9f56/tEKLd9CMsevibcuOARDAAOXOYtMvfhUumET91T2wqkBksrc/ZxXpZY3nAOrgj9dzZFIZAdgmuTUUhSuejd82/ZzT+J2Wiza//Zb65rtEluZE9UNKayyrDhNidQR9TrgTlPpAKBg0Ce7t/HEy9G3HPfQckyYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W16r8PZpQg2+vWaJzT5NGN8j/e2+wJLadk9HxeUkw38=;
 b=MtskUzmT36yTPi5pSRv2+prbwpZl8cGHGvAp/RCrNadawza0l7NGTUhxVG7pbaTwWkyPVqCo5EIrs0t9o3Z3QHDbQxoVtWMc1eHCXB/4fAzM2+T3+PcqV0i5F6fWsd84IkCgNJ3uYGjiAUNHbZ7LBP/bTRdm9ENs9RqgRve9nzJemE28Y2DIPaGOrKTj0uOMDibpqs6qh4nHW0VBgvv22zkoQoglOU9lMEUdhbkH/nEzvDIy8l/Wt05dmsMehNslxWkKNygiwVU6r85phMDrQgqNXEpHp+oiovk/o40MmTElCTfbWEUvXtyBTH5BNRo2+Wo9QqRfIRhCtJMc6E0t1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1331.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 11:09:08 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0522.017; Mon, 19 Oct 2026 11:09:08 +0000
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
Subject: [PATCH v1 2/2] pwm: ocores: Add support for StarFive JHB100 PWM polarity
Date: Mon, 19 Oct 2026 04:08:55 -0700
Message-Id: <20261019110855.52420-3-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9d7f9bc1-b0e7-4726-2664-08df2dd16578
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|52116014|22082099003|18002099003|10067099003|261009223027099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	HwoTbgBxFQOd6z0LBmb07HSlLUnOntpUKecRM/AqrUuKpmA3hmfWJ2tsEy1foBazp8lcTZ1rHQ0ltk1NMZnWLyU13CawMdYuGRuYc9AgQNYMmlKY4lmsfW1+QoYjOe7uTlqx3zzuym5mUckTuhyqk9VgO3ehQq7HuVnpTwtc7F3njQXS1o15YcBtOOO++xKV2jGR9xII6W8fjVCn099Ch8oXmaOmXIhlPZN8pV+Q8EU+qTx4gZEqdJ/3NWGW5eF5Fmok3OaM7j5Xer/0YIUzmYDRXCoBf8U+PT1Rvq9ATJTuNvwSYCidIPWHfkJkxZuoVlqLydftbDmKogThdCi20jAZO9kmV+6d+TunSCbgw23x//G8H2JzUDiutatAgSd9UZO7OWJEhciu6r+IpUSoylu5C4lKwKSsMtHs3zFsEXxm8D5ADj1isH1F6YSInbWLdrELavAHTp121k+YEUCI0K7+bUGKyohnmQSnYrWNzdVkGn1sKtSh/OAK8si7e1onCoDEQOJkLRZww55xkvunHz7MifijX85cRguTGYnF6f8Cpi/DG4YCFux/hr5O9l1h
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(52116014)(22082099003)(18002099003)(10067099003)(261009223027099003)(56012099006)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y5Hs74s6igH+/gYBDFpREqohKqOwh1Tug120QMBJlmTbFcfQ9aCOPC/1Rx1t?=
 =?us-ascii?Q?mELIgLNQgFT7/76R0HsFtxLBXGjCHuAgTrSSpjpnXtE075cXRGfEFPF6ZBVL?=
 =?us-ascii?Q?r02q+oeuKAHQje9BFLHinWS6JyQsRo4Oo32D51r60EmPTNl1fu0WhKnJ2vDM?=
 =?us-ascii?Q?zIjDmGG/FwA1NutOZkuF2RZc/aQFUwTPcR+b+i12ZvDGfI+CH5oMYfzeIxL9?=
 =?us-ascii?Q?w+jy9hDxeGeV1zQl/x58Df8YUC+ks5gk2eyfOoBqgsZRWf+OQSMlwy3DcGV2?=
 =?us-ascii?Q?uU8z5usWezQvXz5daGIWcPmXnPSwNWkOzIa/Y9mM9SYDVCZcDKmjDBzrrypn?=
 =?us-ascii?Q?YOwKdiDNsimVRhd+MSYdLWOKMggT5WSMZ0pS2gGWcWecMQEA+xdDwviQvx+e?=
 =?us-ascii?Q?7CKYCZ+uGAONwiQGF5ZRdgE3iuJt4R5XPDm5cYUpQrS79Q7DMeLtE5K1ssWd?=
 =?us-ascii?Q?QqQllotSuy0DEpjgfVWpebx+v0wtqwYK6pkWMAWQy6AXHfPq8LPDhqJhjIFw?=
 =?us-ascii?Q?St5i9aQzkVOOGstT76PdbwoXkoExil5Y8yjFUqtmWM/MR6VcpebQMnBGOwLH?=
 =?us-ascii?Q?FqW/MLLR6oHH//i8rf6MywlKHl86/l2tzAGRMszAnFiC0eFOIbE8EpDZuPqM?=
 =?us-ascii?Q?QEZGjANa5Yvdp0UrEAlGXqlj/nzCn4iK2ZIV4zFHRAMQBRayhAQgio0MCdqy?=
 =?us-ascii?Q?PU84IagrtoukDoSt0my/OYLu62sdELWueKk+K5DKja80gJgtKb6L+NjK8vZ4?=
 =?us-ascii?Q?v4gj8psRO+eGnPuLY50QNboyRKq85Z/g0XvjxXQ6FgR/tSI8C1UixN/gWkI7?=
 =?us-ascii?Q?21Ki3d7AuWb+bururI2FzWZyxHgbT/yU6AuVZQJjmt8IdDnIGi4eWD4xvKHv?=
 =?us-ascii?Q?sUmdZ+PilLpnHB1TTqwvpqrtkh02JfEnkWcMvxfh9hkB/iM4WQc5mqu2KIe/?=
 =?us-ascii?Q?Adr/j7tSdkDkA0iTv5Kg886nZr4jwXR5bYf0OG/gJbAD3sAOmC0d4Q42Ro6w?=
 =?us-ascii?Q?zT/VckIoh3pd7kg9hr0Y/l4HB1zZU6mvngK3YcaF+JKnVRfPjOw3/WydRqxN?=
 =?us-ascii?Q?69MZgPFrNb0ycXrYkcaOloR1ZBroIlgmTQvImC4FwTy3aUVlHFlcIhQOsgLV?=
 =?us-ascii?Q?juAHR/t1tANI8QNz8n5fdHC9Q57JYkutXrRrNPI1NgkaOZWbH+e1zURlkp1r?=
 =?us-ascii?Q?uPiS82v2LW7Bvj/YIvZY0Bj531l2W0bnt6UyW6NziFWTa9Rr+s4RzBY4bCFW?=
 =?us-ascii?Q?A/9ErDbZT8VK+s8HCLvXcX0rMKToPHzELYQdl/twGtdnTqVmdBE8jEe6i/mf?=
 =?us-ascii?Q?isBpgkEaUek59SYY5ktZbLEDOR+GfwlT4RQBs50APgxRnIuKeqKiF+GQKWZc?=
 =?us-ascii?Q?ToF7fVh39g3BTJZLLeQz5EC0oo6J+FFS5XBXRQNzSOmmucQfnWs6k6iGkuzc?=
 =?us-ascii?Q?gKhrAAc6xx6X36DnJdTnLn3RQgFXsJYesjjQgqvbxDFFUvinVrHYFCh7TEdk?=
 =?us-ascii?Q?LiSnktmhDQsj47X5RPdInIrRlEOgDce+NWvQndelSXHBO2KGRC+4EBeAGK8J?=
 =?us-ascii?Q?91MjiAaR6p2ob48Cjj7TmCZUQEXXZnzQaNU1oABLPD5+F0Eu8muYYHwoe4Ws?=
 =?us-ascii?Q?R60H8y0CGVwPXaT3FosSTAjL+q+jzXr7NI4XaSyLRVNwSYr5cdXOOiDfkeB8?=
 =?us-ascii?Q?xNT8YbolNTiC3huwMKRSY7f7M5zoUJlcPPhgL20VJnRpruAW1t0lpt1KYHz6?=
 =?us-ascii?Q?zm12rLOOZnsGVdDfwGVq3j4bLR5+bBwzAyZzTxSLAElMflMdUzI7?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7f9bc1-b0e7-4726-2664-08df2dd16578
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 11:09:08.5300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zFRkJBlCS35h1hDlF5p0gOLz+hzUNOSWUNNpAEpPHhhoaSRl8CXJ+9+dj24umq3yEtYMXeBRyCvgGX1SrKACJ6eqdKE4Gusz1wVWFSUDTADEQppwIgeqvqyWwJsU7xfB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1331

The StarFive JHB100 PWM is based on the OpenCores PWM v1 controller,
but its polarity has been changed from inverted to normal. The generic
opencores,pwm-v1 hardware only supports inverted polarity, so the
driver currently hardcodes PWM_POLARITY_INVERSED and rejects any other
polarity, which makes the JHB100 unusable.

Add a per-device OCPWM_FLAG_POLARITY_NORMAL flag to describe the
polarity capability of the hardware. Devices without this flag keep
the existing inverted-polarity behavior.

Use the flag in ocores_pwm_get_state() to report the polarity actually
supported by the device, and in ocores_pwm_apply() to validate the
requested polarity accordingly.

Finally, add the "starfive,jhb100-pwm" compatible with the normal
polarity flag set.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/pwm/pwm-ocores.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-ocores.c b/drivers/pwm/pwm-ocores.c
index 4c7e87cb009f..1c69b856bd80 100644
--- a/drivers/pwm/pwm-ocores.c
+++ b/drivers/pwm/pwm-ocores.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/pwm.h>
 #include <linux/reset.h>
 
@@ -31,12 +32,15 @@
 
 #define OCPWM_NUM_SAVED_REGS	3
 
+#define OCPWM_FLAG_POLARITY_NORMAL	BIT(0)
+
 struct ocores_pwm_device {
 	void __iomem *base;
 	struct clk *clk;
 	unsigned long clk_rate;
 	struct reset_control *rst;
 	u32 saved_regs[OCPWM_NUM_SAVED_REGS];
+	unsigned long flags;
 };
 
 static int ocores_pwm_get_state(struct pwm_chip *chip,
@@ -60,7 +64,11 @@ static int ocores_pwm_get_state(struct pwm_chip *chip,
 	if (state->duty_cycle > state->period)
 		state->duty_cycle = state->period;
 
-	state->polarity = PWM_POLARITY_INVERSED;
+	if (ddata->flags & OCPWM_FLAG_POLARITY_NORMAL)
+		state->polarity = PWM_POLARITY_NORMAL;
+	else
+		state->polarity = PWM_POLARITY_INVERSED;
+
 	state->enabled = (ctrl_data & OCPWM_CTRL_EN) ? true : false;
 
 	pm_runtime_put(pwmchip_parent(chip));
@@ -85,8 +93,13 @@ static int ocores_pwm_apply(struct pwm_chip *chip,
 		return 0;
 	}
 
-	if (state->polarity != PWM_POLARITY_INVERSED)
-		return -EINVAL;
+	if (ddata->flags & OCPWM_FLAG_POLARITY_NORMAL) {
+		if (state->polarity != PWM_POLARITY_NORMAL)
+			return -EINVAL;
+	} else {
+		if (state->polarity != PWM_POLARITY_INVERSED)
+			return -EINVAL;
+	}
 
 	period_data = mul_u64_u32_div(state->period, ddata->clk_rate, NSEC_PER_SEC);
 	if (period_data > U32_MAX)
@@ -218,6 +231,7 @@ static int ocores_pwm_probe(struct platform_device *pdev)
 
 	chip->ops = &ocores_pwm_ops;
 	ddata = pwmchip_get_drvdata(chip);
+	ddata->flags = (unsigned long)device_get_match_data(dev);
 
 	ddata->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ddata->base))
@@ -279,6 +293,10 @@ static int ocores_pwm_probe(struct platform_device *pdev)
 
 static const struct of_device_id ocores_pwm_of_match[] = {
 	{ .compatible = "opencores,pwm-v1" },
+	{
+		.compatible = "starfive,jhb100-pwm",
+		.data = (void *)OCPWM_FLAG_POLARITY_NORMAL
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, ocores_pwm_of_match);
-- 
2.25.1

