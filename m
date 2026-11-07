Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.146.116
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794021196;
	b=t5Z/MHexyihV9SqsuTW/GhblRmoXrkFbRYc2yL8nErjRoKn1dMV/+PyT/qG66yfeEtAw
	 JOteRK4eEHyloZS6HHo1wGIaQyTWhhBznJttZ6ff/plYvQ0DGm320zBDw0w5Bh6JT1Al9
	 4GSoHXqLr/slMXBjBJJ1BEkfOWxwZYpUK4ATFhljtuL5vF8s6OH2Hlk+cBdjJ85v7qI+8
	 0vfr+nMDqi7S9g5ezTPmMa/2pWb86IrBNaDbbBEUibQSFwHBxFuv0V54WwTl7vTb+Y3gx
	 8ZB05AnZW4CwzcoDrYZNWrG7HKx2UpDYIsEDN4iIEm4f1c2ABuHr8FmIdWAY3nUdJ5w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794021196;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=bo/Tes2xcYfXAlGyDrW4jGQyky6Sv4aVFFc0VxLtbr4=;
	b=GJv3Et5Vnan/efU2FFRX0DxoZf/LKbW8vqu18za2CgZUCgPijBIJiGfPdUus4sps/5zH
	 h+Vp8/3nlTMV0URQoC9GxRa2Lb0uiYLyxhtCsodajYgm1raQbhj93f5K/YG/o8XSHySOR
	 j6/cg1dg0zJa6EN31EkktFiU87qrkFUr9P3+KXemLxisNRBKOyk0JqGALOWkKVrYS3MPC
	 hoW2S3TmMISaY0dwUvrTFhZD/tRGIIhokylOmrV9H/SjlBmjebc0qaE7ZWVF1akzNzS9T
	 aj9SE3HB6Jst+cU0CvqsMK6GYt8kMCWonQgu/6Cn/sulmjmcxZgo6/JlzxCiXCU+79Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=starfivetech.com;
	spf=pass smtp.mailfrom=starfivetech.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.146.116
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2116.outbound.protection.partner.outlook.cn [139.219.146.116])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5C0606A326;
	Sat,  7 Nov 2026 03:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE5C0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jmczVPkNfoYsic0DEExHQ3ltq7g4fP8Tc9kp04W22EOvp+8Tf2yY7qUEQk51ecqMwXvN80Oo8k8RB00u7uH5gNwc4dzxiiU6qsW8L7++TH9xSwtAHK83+qJ/lr5WMkrUJv23w6PbF3TsGs1gupqpxv2v80TjL5PEnuA3d5lXKi/jwWyhUepHAALgw1kJitJjF2sh3+4fkjVydvqVvjWmy4Yx1JHVrckN4lS/daqYDJWcHUSmu8wXxXgz2zHBieY1LU09BcSOOdEHJZTGDdzaP4xSXDTr7ZTXnAG9Du1cl8W/ARyFMo3UVFnSsNPFju0fFhHtqda0uc4LUUYsXISWHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bo/Tes2xcYfXAlGyDrW4jGQyky6Sv4aVFFc0VxLtbr4=;
 b=Pym0m512FN30QcgIb3CeLfT1sn2YNsTSFqVAw9X3/T7iAuzrY/0PwgJoHukgcmL3HLvACo4Hj61A8Tj79JntHfHJo+8Flj2OvZYSuRkNWQJo5vAGRqFGw7TCuat4aOmtKn+lMkf8KkxjMQDg/bud2BxWlbWTC0b57anYP+GxBkrbj9S0SoMuIFfn7dwXKrnpvno/tICj4aVjZe32tBrvSYCFSXXLVzSoKvXhVNMK66DXZIgeHQ7NUvIjgQJN/VlvUiKmg/r5OWSDGptfKquHh2fS6/yLHXNn0lqFaPuzu8qQJAjMvDMsrO32648Gw5vxHwS9BCfJxVYeFnpAgjwREQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:7::10) by NT0PR01MB1261.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 03:13:01 +0000
Received: from NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
 ([fe80::be4a:d29e:5188:b37e]) by
 NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn ([fe80::be4a:d29e:5188:b37e%3])
 with mapi id 15.21.0592.010; Sat, 7 Nov 2026 03:13:01 +0000
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
Subject: [PATCH v24 0/2] Add OpenCores PTC PWM support
Date: Sat,  7 Nov 2026 11:12:49 +0800
Message-ID: <20261107031251.98972-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
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
X-MS-Office365-Filtering-Correlation-Id: 8f81ab1b-ac1e-41f9-436d-08df3c7d07ef
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|23010399003|1800799024|376014|366016|261026140227099003|38350700014|56012099006|261022105027099003|261021123027099003|261021121427099003|261009223027099003|261022075727099003|261026121527099003|261028144727099003|261102123227099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	+Ne01/veRTgpzYM1FyW0BdsyZ47OBHa8gsTLS0BKpeTHiA1CXOaO/RQnwlKMq5aTw393PCKdGWPWFXFjQ8YA0/xu9O1b7lCa3vblGvaRkScu/jUFw/YWgojjDuRV9Djgpbve4wfDn8ErHE8cf+ECkNQZRNL+i3cR4k2v/yIPbTYUnTcZ/hjxbTFWjCvX/AVJWeaiJ0xgKHgFLkbgGHCNw977nZxYzMBblnyuvxX4eYfD7neRgFGLAy4jWzlT1JzABMGyyCq+rWpyMjcUt9D5drYbyUMQQdVPaq5UJYmyParlc4W9Duh0aSruNOaCu0X1Ewf9GvUCrz9PNv8jkI/kwmZXq/OEvQWpvARVudCVbjt9g0uByMyblwAWBhZ/Ik6w41bFjzSVaE/9zPr+5+cDVH0CslHjM/vwUfiHqwKWR9giimWj+guHhegwBxsyhMM4L1qllFG48WCCCsIZv+qlr0HHzl8qsoNhfOfauewRr/+yXHw4dWffGXSO336L1Xmx8YwIw3mbQJDa7d332JoEq4vo+Gg8Yi7TMPklEd0V/I+K6YSLtOvO149brwP4S4k7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(23010399003)(1800799024)(376014)(366016)(261026140227099003)(38350700014)(56012099006)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003)(261022075727099003)(261026121527099003)(261028144727099003)(261102123227099003)(18002099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8ZTm54q4xZg2HUiGhsrICNrIlGAsLnM+X3qxTSO91xXQVh64EM6WP8JAFx4n?=
 =?us-ascii?Q?1wtFZBAvuzmllzgxPKagI0qimaR8U+QNyKmEgvq8UAkw7dng8EPpQwGuw2H1?=
 =?us-ascii?Q?/xtmL1/KkPnwbm2Eubh5uHkNbfeTWdNy0HyVMpLGVgciG3n+Qit7HE65+QkG?=
 =?us-ascii?Q?KP43DZQdtb1mrav/aIlJG4Hdr5h/XAVgsLmAfHPiwpw1REfwR4/Ep0pPno8b?=
 =?us-ascii?Q?joSZn0pYVcfjEVHlbL5OfPEG5DlZNcrt6U8PEy6nYW+J5Js1/qDKyXVLwV6A?=
 =?us-ascii?Q?WjEo9NqzehnkKCBAtD1M1rUdiT1g51LX4ZI6uukpnZz4lvKlflFgJRLx8rqT?=
 =?us-ascii?Q?HtEg7CsazdJo0Lo7nY4IM2RBZ8zGSCyS8meixqRhQcyN0X5luM4WJ9NYwezH?=
 =?us-ascii?Q?xTXQub+Y+eZlwgJ9UQpVmpe9JcDQmaiYfEveKo6CYCtF/zOTT3EP48ZQ/7ud?=
 =?us-ascii?Q?Ahj7iz/2Njla0V1RUHtkrLM8/nGr4Zr9CkHtUsEoIdCRVv5SJnZ6FmluzAWe?=
 =?us-ascii?Q?ereQk1FSA1kF1PDxh1FHWpBJJ57pqsEziIIfLCf3wDIZ9OZkc/ubkRaOPLu2?=
 =?us-ascii?Q?LVo++XYPoIjcsa6wvRr316uL31RpOIaoLe+8aoKlUE57mSS6WIRjE73rDAGe?=
 =?us-ascii?Q?v04HDmFtV/WCxECW3v1eWbtkM0qrsr+7leXBnIzGSkhMMEB+/e2ZEJ1sj1J3?=
 =?us-ascii?Q?jmWYouv4jaRLzZ7k+NX+J6iVTqwOWmfQ2e52ZHgGoxH751RRghwVFisXB3/j?=
 =?us-ascii?Q?KKUWO8fmgAULOknXPvmv6H6UilxbYOAjzt4PhQ5aoxFC0SikAZoaGKJgqdTi?=
 =?us-ascii?Q?iWegTdf0/lSbDlT7Utiqgy+7Mzq7pATLWiPq1LaC9FgayxVb7au8eg5WCE9q?=
 =?us-ascii?Q?HNmfC0yqdH/vc1fvpGs/lgr9YnUaMDHn4Ac+OKDj26oJm7htSYpy2h4pkSUw?=
 =?us-ascii?Q?BHXq+liyndOmRiGpykWBO6nQTqUbnOp00L/hCGjsw/Sap8fRyP/Vs9iQDV0x?=
 =?us-ascii?Q?amm6r0nLZQgXedJIQiKZEoabzxPyu9OqUBKIWWaNGG4gGo1P02XxkjdI7oWf?=
 =?us-ascii?Q?HVx84IJrC3g45kq75iceX5cpIhC12JSEBpU6OHP47SmbgVcMQI+oPXJRQ+lc?=
 =?us-ascii?Q?hu+tQLGPUVDnmFxdD2hljCQtZA4DVpGfyvimQzRxSjkOiiFWBrutMdlI7vMm?=
 =?us-ascii?Q?gTCck3l7zqah/2Pl5G8a7d1o75jhXq8kAluJKiBEDr2w3Q004UvNwuXZ9zA5?=
 =?us-ascii?Q?HxN9dv70G+y9bNB85BCjUo7fggz+DNKZ3IlUKRJ+CltARvlJokhA8qN/AMXW?=
 =?us-ascii?Q?oeD7O+xQlK1qVqtxL7Y4J/JS+KFTtjgtgqyS97HPGDlnhXpOdtt++3jMaWag?=
 =?us-ascii?Q?hug+L3Ie9o0ehNm56jIheEFtmRqNViiyxAmpGlxbmfuAzFC07M+gHcijfyx8?=
 =?us-ascii?Q?ylapX72DQ2xvKsusLOHhDHFBRNNPSyTmjlKX+gAYjxuvKJPfLpa5JaklSu7+?=
 =?us-ascii?Q?xs/gg+kI4ZIrk52Ehj8rX/s6wZ3ZZTCmGohFGCDVXqmcEx6hbNDD6MLjt2kz?=
 =?us-ascii?Q?YLpaN/2UwWBXDpLIGZjhS751R2EyCPedonss1EuOjtFl6LgJZ659Hss7jPU5?=
 =?us-ascii?Q?MoHZbxy+E6vdgMx8ddcgagxuVa0uE6JuCBTbP1KFCYa2Zwk5a3Lv9aR9BF9K?=
 =?us-ascii?Q?+5APFKh9JDnNO9a1v2/GdJhXGTLxvX6QL52IaTAfRgOrKWUAcp8iHWITVnrT?=
 =?us-ascii?Q?KILODC4L/tQyqxoZB0A01h8PCO8wdj0=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f81ab1b-ac1e-41f9-436d-08df3c7d07ef
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 03:13:01.3272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kso1DsazM++sajzyk0RXG1oR9C4dclg1s7zXSSNRXQCAFavB542+V/XOCn45v1SRSArWMpUt5gFQdE+NCM4H5GQJQZ1CYOWW6iZfDpfGMlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1261

Add OpenCores PTC PWM driver which is used in StarFive
JH7100/JH7110/JHB100 SoC.

I will maintain this pwm module in place of William.

Changes since v23:
- Drop the Tested-by tag for the dt-bindings patch.

Changes since v22:
- Drop patch 2 since it is already merged.
- Drop the starfive,jhb100-pwm compatible from the dt-bindings, as the pwm
  module of JHB100 SoC differs slightly from the OpenCores PTC PWM module
  in polarity handling. The support for JHB100 SoC will be added in a
  separate patch.
- Move the polarity check later in .apply().
- Add comments for keeping the reference when the pwm is already enabled.
- Rebase on linux-next.

Changes since v21:
- Allow non-zero duty cycles shorter than one clock tick to round down to
  zero.
- Drop the .free() callback to preserve the PWM hardware state after
  pwm_put().
- Update the comment.

Changes since v20:
- Fix 0% duty cycle support.

Changes since v19:
- Drop the oneOf construct in dt-bindings.
- Address Sashiko AI review comments for the OpenCores PWM driver.
  In ocores_pwm_apply(), handling disable requests first, then calculating
  and validating period/duty for enable requests before taking a runtime
  PM reference or touching the hardware registers.

Changes since v18:
- Address Sashiko AI review comments for the OpenCores PWM driver.
- Fix runtime PM usage count handling on probe, error paths, PWM release
  and driver teardown.
- Reject period or duty cycle values below the hardware minimum.
- Restore PWM registers across system sleep resume.
- Return the real error from devm_pwmchip_alloc().
- Preserve bootloader-configured PWM state during probe and keep runtime
  PM active if the PWM is already enabled.
- Use synchronous runtime PM put before possible teardown.

Changes since v17:
- Simplify the code. Make it more readable.
- Restructure the driver to register the pwm chip for one pwm channel,
  because each OpenCores PTC IP core only supports one PWM channel.
  Drop starfive compatibles.
  Add patches to fix the dt-bindings and device tree.
- Support runtime pm and system sleep pm.
- Disable the pwm module and reset the pwm counter before updating the
  period and duty cycle.
- Improve the descriptions.
- Update the dt-bindings maintainer to Hal Feng.

History:
v23: https://lore.kernel.org/all/20261014110429.52762-1-hal.feng@starfivetech.com/
v22: https://lore.kernel.org/all/20260810030714.48100-1-hal.feng@starfivetech.com/
v21: https://lore.kernel.org/all/20260701074442.7714-1-hal.feng@starfivetech.com/
v20: https://lore.kernel.org/all/20260629063601.63917-1-hal.feng@starfivetech.com/
v19: https://lore.kernel.org/all/20260615155759.129210-1-hal.feng@starfivetech.com/
v18: https://lore.kernel.org/all/20260515054723.25024-1-hal.feng@starfivetech.com/
v17: https://lore.kernel.org/all/20250106103540.10079-1-william.qiu@starfivetech.com/

Hal Feng (2):
  dt-bindings: pwm: opencores: Update compatibles, examples and
    maintainers
  pwm: Add OpenCores PTC PWM driver

 .../bindings/pwm/opencores,pwm.yaml           |   5 +-
 MAINTAINERS                                   |   6 +
 drivers/pwm/Kconfig                           |  12 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-ocores.c                      | 299 ++++++++++++++++++
 5 files changed, 320 insertions(+), 3 deletions(-)
 create mode 100644 drivers/pwm/pwm-ocores.c


base-commit: d48723711bae9b8cdc56719c448ba42fef28cbee
-- 
2.43.2

