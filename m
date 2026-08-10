Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2109.outbound.protection.partner.outlook.cn [139.219.146.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3DC353A62;
	Mon, 10 Aug 2026 03:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786331261; cv=fail; b=Bjh8Y4otdEBnJAAvSINgMIegZgCILLw2RsmzEJklR1avTcJNGKRlKZjCszQMQucb9IITuqVxiy3FUIBOi7m5AAuiBi9wTeFx5JZRa82rGKErje1UnaCD9n0QKrNe9PnS9+crRHf8p3tA25mO7g5Iv6GuU24Mn9vqafPhA6e1JG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786331261; c=relaxed/simple;
	bh=4zNe6YEN62J0vM12ufUqlbkLXHldxUjZ63pqXzJ/Tes=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XRxlgLul8RDORPg2pZz4WJfM8RmIwuP99OVVDWsYCqH/oGAYxzqtnSLkZ+pnIapwVyMqgBBW05M/wuA6/RP8pmmvX3AhY6lx54if4xSxvkmC3dEJHivDS6pRF0tIqzGZx4DbX0IZmlOr37EezDCGoFsx86IgxUxqRoOhZM95j+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0AJ9S+OdB2QuYQO/d3RNOsgRTwHKGlSlSuRhu9QKi+ZffLCACJV4IQ4fjVOQZAIRxwXdAFvKq4s7yanf+cNtSkQMLqm0V7KrNYyPAxsOdg+UyMmB9ZFG9TwgOG6W+yJeLKbfp4vez761NUYjElGwadRumlMjrjI5PtMkvBBahtj0smz25Z0l7fxY61cPISUueiM3Z0OQIlBPPayl1C8VPsJ8TutvPwyc9nQtPp5opKLEBdAOW3xmZuCDM4Cb/+b9dqwTJpyKj3LPS7WCpLU34fhGCKCnlWZzRciy0yRKh+FzuWzy7kpG4YM0AMjMO6QuOzb2+VGMtrH84G4FGquTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7iYPUjw+wSCmBtfpYu/nvTETiXpeXZIeqMXvbcIG0k=;
 b=jKslvHKwS8Lj8h8sj0KJZ+3rLSfQyPVgBQGOiWlZNZUSV32I8XFIUJFdoJ/xxdkO5YYdnwmWa0gqLaLREuuN1qVJOgzm1veKfEUYp/6zqrLHk45yaWAF/D5sqENeYhwFDj/waYfve/KL0kNvhuqHuk53pw2EFibeUH6RaxQXsBYR/6JXEOKvNp8I/QtUI7EsGsfLS5D6sm71EG2HN5bHJL5zNGbrGPZY6cQLI4so4z/beJlKRyac2OTXCsarvnJ4rbfHQruHh6kZnGy6VY5cI8Dw008qYPIYtptXZOdIKvAwGqJiJUoqkUkU5ZrIlX3JmACcmc2aabj0RNlVX+wfTw==
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
 with mapi id 15.21.0292.024; Mon, 10 Aug 2026 03:07:21 +0000
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
Subject: [RESEND v22 0/3] Add OpenCores PTC PWM support
Date: Mon, 10 Aug 2026 11:07:11 +0800
Message-ID: <20260810030714.48100-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
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
X-MS-Office365-Filtering-Correlation-Id: 2ccc0b59-d686-4e28-022b-08def68c7ece
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|23010399003|366016|1800799024|38350700014|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	SKhpnZ/KnAfl1U21qN34sTW8UUwLOjOZakWYst8NeTuo5lI0rmPcy30mkOv1bkGqLC+1uyxJ/uMrjLGZbTqY8VYA9WGYQaU7b1vav25wH/0aSSde8bIxhjTJUj9EBZJAlDqlLxxOdPwWkC2PoVEXylWz/AYq0n973+n0+uLXG6509r39aXzeWv4MH9UEHrAtEwiIy+MHiw2WHwNR+VAsYhA7LVuKCfzPiT8cdX1jrcfxDnG1EjV+/83VR8Zfagdxg/yutI6dk7VfRpaGeFPqEYpOdvfOOaVCiskuynjIiGUSXt8yP+V3DJdluIwn0iti5b1U13ETsXg2UDjxko9gyokU64YOFOcHmxyYkeyxrQx/LtVbw0rcBnHyFmUodecsFKt9omfRkFn9OtU7eCvPQ4Ip4fkuQxQNyAfXfM6GVyzrMfBIAb8UPQirlyVdrCi8sojajqOmhoLYbW/vpEKPiM6KryBtVl0RppFUHlON/LRzInWS/kBUNxX9LiuDiQCBEVbI262wPdpMSE57Ya1oY7R9Qzq8Movjk1Q4psEzAz2bH/wUftvGGHXrcdpTWeJ7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(23010399003)(366016)(1800799024)(38350700014)(18002099003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AAgbnCbYc5qi8tvi+zMblTE+zZpA5kfTP9RLHSfiuGJJHE3mZ1Q3KIpp+U53?=
 =?us-ascii?Q?L3Qk7B75fEr4UNU8tkYBRi6eg7ZYtWgC/OFsoshVpIXzCj8xIWVp7zFoxGN4?=
 =?us-ascii?Q?UnoVH7yzPn2lPQggsTQGwlTCVsW9t2zzwNq+r+P7GvkoUKNCnCMBOr7Z7i0h?=
 =?us-ascii?Q?5ABZpNzVEsfZAe9IpJljyJVp81hpNP4du17aarhTO0rw2RI32c393wrEU/de?=
 =?us-ascii?Q?Ab33bGWjXs11gGOp8GbRhKPsZQ3tRqmhw/5c2/fSJssqSkEpKvKY8XKR10n4?=
 =?us-ascii?Q?dszvgntjv8DdcvC6V3CdHe3vyuQnjFX+iReOFckIs/xr8SguTHJ0UI2kEOqd?=
 =?us-ascii?Q?b5nqfzEJVwtSta8XvoaulYM5fFWstwKUzc6TPAh1o1jHj3HbofjE0Ass8Hjk?=
 =?us-ascii?Q?3wx/q96+BTgnZ8TUbv9rl5XxJo6v6Rb28prknfE2+FhQvNjFXm9jIG1EdPDr?=
 =?us-ascii?Q?UmAXV2lU/X96/wmlZZbMA+80eWy2y5T0MZdbcFBMeQb5U+gz0aIRfxSyi6+i?=
 =?us-ascii?Q?8DdINDCspm95O+iRqBwmiu4MaEs4G4ljZc+vqbj9Ov95zl3WzAuVB6E3Vz5G?=
 =?us-ascii?Q?ZxrWJoGvYn3IlzTUbj7sTxEGePVTxPgfcTrjvgfmJvXOT8YEqbMHQX3OPksW?=
 =?us-ascii?Q?V947/F7FqhgH7hEUeXQNdC8i632AKbREwiyPVY+nw0hzsWArv7Fb/n/mi+ax?=
 =?us-ascii?Q?yyKNmcZH5ylYMylwFIwo9XziCgEtWMZkq7mO8qKumoPrHOTlzDrbwtI939zG?=
 =?us-ascii?Q?4325y4+/lg24UdC/rT6YeNTMiiF7ic0pXe9Yd/GsdCtZ85cezKMmuEZV9Thv?=
 =?us-ascii?Q?b5+zwsgc5xMboBSVVYsy/AsOLlW3oYMQrXACZSGLViomng82/1eZf3NACoTv?=
 =?us-ascii?Q?6DSsUJoO4vsDWsAtDg8M2xRWcLaa6nF9GgyFM0Ga7bS55UfPtZlZwytorh1G?=
 =?us-ascii?Q?nS63NZ33KFqloRVmLEXZ17YE2xdt1HYb7IFnamKuj4gh1TMlkO2mgXji3R3z?=
 =?us-ascii?Q?rtMbunED3a203Yu8Hhe4qhYDwO9erDhkZk++9hE6D/I4v3BrRb+7uI0gDDjV?=
 =?us-ascii?Q?lo5FkUrBo9uSFL8hD0cRyhP2ze7FAwbDD9V/oSQg5AvxM04rhIfa1IrMX4oH?=
 =?us-ascii?Q?WTKevXah9KVX+Ox0u84dyk4crc0BnlJBCLxR83CJU1U7pOONM4WAuRyP9OOz?=
 =?us-ascii?Q?lPU4gWMdQqsyArSgpHf1zVPhWSis7rVU2CUU1oO79QaejEJ11IGwJNZmxXft?=
 =?us-ascii?Q?ZW3gzB4XmRRM/wQjLeRKv6A2AjYCcVqKR5I6qUeGN/1JkjboifQfHRYsLeWT?=
 =?us-ascii?Q?JRW4lSexLw/Wl7R/lcfdiZ5aNBGfyT7LTPOf4+t3jdoRwOQoP1YHa9+tSHAu?=
 =?us-ascii?Q?9hMsvVPddhFjeTuzT6DWJ8HEvA7+3Z/wTt6ItI/SeiLtasOQv2QVI9h75drJ?=
 =?us-ascii?Q?0kq9JQ2MulH4jBOe4ZHrztgmtEOPg8ZEX32e42mTRRAmteUlV7LIncDnTUf9?=
 =?us-ascii?Q?RTbb388KBdKak40rmgVaC1lCp+BmD0XWVfcGGPzZAf6cWFtQevNDD0FRWdTK?=
 =?us-ascii?Q?CduFH8COwpztSRgXHKfcrbKHM8H39MX4Ibt6Hau8jKDYwlQu5cqbSNNne8ho?=
 =?us-ascii?Q?7gvD9JPBbJpwXNGrLb1PhiuqLt7HNgjvkGIlrXzJ+5pPYLwF/dgkF6IlZlKO?=
 =?us-ascii?Q?h+bqKSuSGd+E5rl3tPrf7JzYxcXo8dp/rMAUvt49axmQ2rR53j6UluuPF7/w?=
 =?us-ascii?Q?lwZ90Rm+/QplSve+MQQLYKZe2U+anso=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ccc0b59-d686-4e28-022b-08def68c7ece
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 03:07:21.7593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yh8SuxzXeBzn0Wo9Rp6BcDQPkv4E9kdUMtI+KHw/d08C30ntuEmtH8tjLBSXi5f2rojF7fqHP3rWjrR0RJJiGYmYwoJEHFM4e7QKhFgwz04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1178

Add OpenCores PTC PWM driver which is used in StarFive
JH7100/JH7110/JHB100 SoC.

I will maintain this pwm module in place of William.

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
v21: https://lore.kernel.org/all/20260701074442.7714-1-hal.feng@starfivetech.com/
v20: https://lore.kernel.org/all/20260629063601.63917-1-hal.feng@starfivetech.com/
v19: https://lore.kernel.org/all/20260615155759.129210-1-hal.feng@starfivetech.com/
v18: https://lore.kernel.org/all/20260515054723.25024-1-hal.feng@starfivetech.com/
v17: https://lore.kernel.org/all/20250106103540.10079-1-william.qiu@starfivetech.com/

Hal Feng (3):
  dt-bindings: pwm: opencores: Update compatibles, examples and
    maintainers
  riscv: dts: starfive: Correct pwm nodes
  pwm: Add OpenCores PTC PWM driver

 .../bindings/pwm/opencores,pwm.yaml           |   6 +-
 MAINTAINERS                                   |   6 +
 .../boot/dts/starfive/jh7100-common.dtsi      |  28 +-
 arch/riscv/boot/dts/starfive/jh7100.dtsi      |  67 +++-
 .../boot/dts/starfive/jh7110-common.dtsi      |  27 +-
 .../boot/dts/starfive/jh7110-milkv-mars.dts   |   6 +-
 .../dts/starfive/jh7110-milkv-marscm.dtsi     |   6 +-
 .../dts/starfive/jh7110-pine64-star64.dts     |   6 +-
 .../jh7110-starfive-visionfive-2-lite.dtsi    |   6 +-
 .../jh7110-starfive-visionfive-2.dtsi         |   6 +-
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  67 +++-
 drivers/pwm/Kconfig                           |  12 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-ocores.c                      | 298 ++++++++++++++++++
 14 files changed, 518 insertions(+), 24 deletions(-)
 create mode 100644 drivers/pwm/pwm-ocores.c


base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
-- 
2.43.2

