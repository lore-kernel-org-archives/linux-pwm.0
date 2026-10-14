Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2098.outbound.protection.partner.outlook.cn [139.219.17.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8E64F4D1A;
	Wed, 14 Oct 2026 11:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791975903; cv=fail; b=Ol/fkIs/L8AnoMdKClU3T0CewnY1P2gy4uRVPNkQ19sogDQJbY75nDQD95E6De2UvBqMSierIxe3vBWoRwHPDvLjygET2Y/VtviDDnHhIU6fTiLB3kh9qlo8Scfsmgb4LcWhMIptRTRqUjqlYJk9aISzAwWR4GFdLtF2VOXfXwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791975903; c=relaxed/simple;
	bh=LpvsZTTaJeFiiP+goxdNfgK/CRt/efwWqyJhUTsZ63k=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dyd7Vncq8h+6jCFnZXSFQpcELetwPI8qBBHuMD9FcXfA+uGBfoFk+GmEjAN7gFE58Ye4Jqmz4YrbRHyiUq9P7ZSOhbcJzGI5Bfy2zlK+VtBrnpPhZPlm+mPywwtWtHjMY7fFtN9Lm6RKIPcaXER0rJu2sQtMV1+dqQrprEC1PHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJqxnAsK+i7AS4sSztRTkE02nwYl/++uBSPjYDP/s0mXU95TOX4oWRbO/f02qhhJDiijdmpBRNg825dJvKXyjdZFiRZu3j7L5puCDvJWiPrYGUAjR6ng8OS90dl6CFirfGUReQSX3Z1UmGkI2kVg/Mx6HgwYhRq/jB66LoVu5sRhSCkSWFAs5hjLPZTu52JOfeMM+PRZx0ulKG5IPeO1ipRxjHHAxlnzBVYSu5NYC52xwbMksStUHTIMBB+7hgG+S+H6PYIBQxdTJML2pw5nXFCdlgL6nNpjOl+R8EgNjXK4aQoJDRnYuIRXJTeqf3GzND/dmZogvsjfojQ/nYv//w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmnlrMrx8U/VqLEO1eGI3ZxDZKIp0J4cViH1Cps2EKw=;
 b=Xomq4d1h94QSGhLqCcg/hiHD33u4LFSmPoF5CwoUYNOvyo8vsIV5vWfYRYdMZBCzXC/uFKZD3Klo98A7hYvtnZmjBWy23BHAWSdwf+Pe58j74UXvoINTvSI/H+GI97IwCbIxE9zVh3/T44fFK/fZmv1/IP8axxwLNNI/7ktBQvSP2ajdEFKA1/+E1KcSEB+vp6evoZbcA+Amq7FLYTSjvN2Dp8CgXvWuaWAMZalWWTTR1rbCqA27zHmi1vj1BsSP4Rl7v7uKMGuOKY6DGBOrsASb3+EJhv86hIbEG3SLXrC0FUswrx5G7hTqusIMdXNQblgtX7fDXQxHSCgnXQTTmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:7::10) by NT0PR01MB1069.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 11:04:36 +0000
Received: from NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
 ([fe80::be4a:d29e:5188:b37e]) by
 NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn ([fe80::be4a:d29e:5188:b37e%3])
 with mapi id 15.21.0522.012; Wed, 14 Oct 2026 11:04:36 +0000
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
Subject: [PATCH v23 0/2] Add OpenCores PTC PWM support
Date: Wed, 14 Oct 2026 19:04:27 +0800
Message-ID: <20261014110429.52762-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0020.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::16) To NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:7::10)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1102:EE_|NT0PR01MB1069:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fbf237e-e26c-44e4-bc66-08df29e2ef3d
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|52116014|23010399003|38350700014|56012099006|261009223027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qaNAQgrI4dDnpCpZSxl7YxcF6T8nWz7iPk19nkJnWrX8htFAmrwItoCQmp6jAHDvo/tfPCXi4t0ibsJC1BMaQSEBKol4H+frSON2kGRtvNRb0fBNoNaBT9OS2KiBwCmTvrjENIPaBf8Fgri8u+ponmtm7YaBXCLEkNKrPhh6KeXdqAvozBL1RtPjOUWxwQtoAnw3W1GJDVnJ0SXxbvZ47MNAoJx564jNd6V41Z65cfLZrjPSI662ppAq5RbDt/Yo4ED4Yh4xsl3isq97VLZlxBfPk/uXWSJWa8/+pKVnJwk5IJDv4Uv1ljuFdKuN511rtx7mYWUFatquKesYQb1lu27xZz6kqBRkpPiHYDYnix1CsMtzpwQrPT7/4zHfOofjSKXMo/1tvkG9HfpEpfNxijV+ZnQw8hyR/RV0nDeENQ2gI5LOrmdEHCrgb4QHbovmPX/yxP7K9OxKzXhr6I4VH5uXAMsK1Zwl2Cqnk37Q1l3MkYrKxyRvMYzgTYNmNfgzaFd87VcKElDY9lbpCgXVFC9i53XiO1Brlb+sFamJCDhLUzu+hBwSq3coJ+1TuxAX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(52116014)(23010399003)(38350700014)(56012099006)(261009223027099003)(10067099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2srpBQzTOajDzZVzBPIvBBmsg4CI5NMHPck7oGWXuLIjcUUkTBWsqeFwBf5e?=
 =?us-ascii?Q?cnTmf6MYUYrSkbIKqU64it+X6nmFPz2lLRnyhmt+q8/9letGywPT9t07+gz1?=
 =?us-ascii?Q?drxtDYN3s2gsBME+vkiK2FpeTYV7BwpuVSTdUK8WG+fQ1k2dZjbzWy3Htel0?=
 =?us-ascii?Q?WsV6DHnkiVJYcWgj8VvISLiJjRNLiBn4VH0bv78xytNTeqxz5huRaAuV7EmZ?=
 =?us-ascii?Q?oMDxESH1n7a4WhiO8u5tsNOfC7C6aj//ZBZEjc7mtZudgmlJoNffkntTa8xg?=
 =?us-ascii?Q?fwrRZApUQStoIQU8hD7iFeeh8uKvKB3f4xbj6H+QcxTptnttlhJi0NwCld92?=
 =?us-ascii?Q?p6DDk4tHHB1T83/sBzh3pSIFPONWniZZGsG99StVApRc84zlhzotJq1pYB/1?=
 =?us-ascii?Q?JJn2yazpUKJqtCFP+vK0jmzWcggLH3GAzBk/Z9tnH3YDnC65d0ZDT1Gt8fcy?=
 =?us-ascii?Q?fzRP+2hxWLluidulvjyzxF+7ft/X3Gn6hH3FFAhFjOgCNFV+nYvycCHJqxqO?=
 =?us-ascii?Q?fJ3SI6qnyoN2umx2j929Ajx/6rBhU4XthKPT/F+nJi5UUmpvqY+pn0pgRway?=
 =?us-ascii?Q?eAI99BH+swzj552W+tZVjI0CLXPeBuVvB3FjJSU/rh1zGl2nHJNcanqxZUUF?=
 =?us-ascii?Q?o90hPQPs+tRX3hzD6ZI/9itOYnG8bPH6lduaYzB9WckFxiE1mLs3rYMVGMRm?=
 =?us-ascii?Q?6CeMEpWkq9EVjvL2ik5VaT0l5acA/o5FDMasNjfPDTzRxGjkQIeSNCvBFQLR?=
 =?us-ascii?Q?y+KodvBwamA+EqevQbJb/FBhr70QD27vJ7fMuwY/oUjpO/3JGe5vcOXc+vdP?=
 =?us-ascii?Q?GN+V/6SNhq/YZmSN1xCY6xOEgSYdpCDGcIV4CgEd4OeeYtWiYMbVplFBgW6J?=
 =?us-ascii?Q?MsRfqOZkNw7XazrW41XrSsnbAn0oqmKH3EECRIiX5yjn827MUo9M864TbZ7s?=
 =?us-ascii?Q?oDbh8nLZksFTizhnxM5iquPKFpGQrRHLXlIb9V/7EvJLiTQbdlNdeuJrWEcT?=
 =?us-ascii?Q?rUKluNmeWfn08Ieqgrna2zHkUB1dOE3KNOIBB5X5i5jKBIwJvG5FhQya5Rjf?=
 =?us-ascii?Q?mThLsDc5pnS3jBqjY/QRWn7wBLN5LvwT59P1Wj5FT7U4k2Ir/597fcTxFx1H?=
 =?us-ascii?Q?AxwYNBNAlmThjPxkZqx3w1iv6ko1rj+KKkrXdHU+kjZ68aEwN3nByYRYlM9R?=
 =?us-ascii?Q?UpeOuHSLLXD4u9sh6EMyy/XpMVXLr9E8z8WjHw4D4t3is1kBkngkLXAdHtK6?=
 =?us-ascii?Q?jJn8U+n8fePV/8x3fjn6FnTEQVIU8HRffQmpw1V/DiMjYjCUCIX1QF9zDtGb?=
 =?us-ascii?Q?vd2WWDV086mBQsaHTop0O5752MkXmGJhy5ntaZbM0vdiLZiOC6htdn5ZMsbA?=
 =?us-ascii?Q?B4vFDGC+oRPg7iZ9wKAMkx3yJfuqg01Q6eJGSvCXwjHQCy8M1WNqQyY0acUn?=
 =?us-ascii?Q?d1EY1YqRbgy1Zr+FWlYjrs4SoPeQGUDJAwSn0cdVy8kOlCSbHUlACautPDRo?=
 =?us-ascii?Q?H/BsnBkItFN7+7kZY8lyCcrpBx9odDIn7rAXQ3A5utuKqARgOMlBPEmWQfr3?=
 =?us-ascii?Q?Jlyw+/EGeUD0IDiEQOPgFCtS5rlzUnLe/DfV6UR3VR03o5hWttaswq0fgGuc?=
 =?us-ascii?Q?Fq002mXQtBcVW11qL24+CJzlNk2rfvC/f9j1S7SFHmOVPDV+B8YnYoGJa6jz?=
 =?us-ascii?Q?QxhIaqaYFz8F/ZAjjCod/e6GuQ6OFcLn4fZn4joHYIPWxkW50PDO19hA8GrO?=
 =?us-ascii?Q?60CbCvEJmoFBk/KFuFGi+PCv5O9uLuo=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fbf237e-e26c-44e4-bc66-08df29e2ef3d
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 11:04:36.5063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AVfaUjwLKsuGZS77rIcFaJCOJBKCpPyUgCoZk4biUlcZpyUE746aSko5n73xmNYQYavV9jCjUebaqFqDeIJr0aGln0UVAkVc05ZFM59OoFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1069

Add OpenCores PTC PWM driver which is used in StarFive
JH7100/JH7110/JHB100 SoC.

I will maintain this pwm module in place of William.

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


base-commit: 1fffefb00cc0b0da1f2ae24e3d33364530ea6515
-- 
2.43.2

