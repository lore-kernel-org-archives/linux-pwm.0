Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.97
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795403689;
	b=eU9COIp6w/mqMuMn3zPeq0q6xB1DCo98SoYIPv3ot3txoBPyqlAmdC5pNrjjhPBhJHe3
	 FumuWxf1lOLmK3oI53dQNYhruqcOG3odRoZkNJZcpCXNngOvb3gZVkkDNLTAkZMnww/s9
	 lrW+nG4kUmS5Yk4Jw2m9PEKC9OIUQ1ZUSP+AT7ElfAy0k17r3y46gwgS3dRpC2xg2Gr8U
	 jH1CxyACXBgax8HkkUHkmm/F2Y3AHoLX58r6Cc8GCseLjpAFVKWFUGXuewGdDW289JtvJ
	 TFfadMxjh8DS1e70AXpllQ5YS+8DCSLYqJa/qHKLl3NFUrM0KywnZZxbc/cLMxoyU3Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795403689;
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
	bh=LbVDFVdfoZw0yv/mdmyIg+RS94OUUsv+WkS8iC0pIQo=;
	b=4m2ZonrbEGh4ulUO8lzDi1n/RkUujIgMQxoMwDlfg/A3vyOcp6dKHyuduHcyMoq/M9HJ
	 BF6YOlvRu98tz5+ZPNzfKZ9IDVFdkmrGbhs4LpMZeSISSxOn3rvlwVYuOlfFJUedscmKz
	 A09th+NeTuVJK1gBJO9SE87mWRXHUjrqMA/Q2qqoo+/sQh6daD95Lx2dSiT9ZoyuHcZ9Q
	 siMgwe2QNkTCFMtpJd+HuC5B1yAAzGi6E5G9pUT3xpxBxjyGpPwVZfrBfHHJEsx4SilQk
	 lzp/Ics66hmHDgIVCrX5NUXgSLDIiiN/mREXo6BI3qNXBFgEZlHMOz29FBE3TJ81KXQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=starfivetech.com;
	spf=pass smtp.mailfrom=starfivetech.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.97
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2097.outbound.protection.partner.outlook.cn [139.219.17.97])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC51606A320;
	Mon, 23 Nov 2026 03:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AC51606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLmTjprBq/QmLizQ5pLGVtqed5O1pjMLs60HuXlaTCtnbocwRH9/S4bkHuHVpwVuOUEyHWAgP/19PY3OnA1PGfnow+76pZm2FJdvKuii2q83mkVnNibuvUZZEZxGOv8M8Ojr2hIh2Jv+hDgEKCcTmuHncHfK1uFSCA86ItfHV6W92ix8GtXFEVohoTW4kpgXNC5+504483AYaDbfEJ439cO/LC2IImgfrjOMVYR0h2fo11FIlcFL+4bm8myayMGsheJoIepjQoslnPvyrcfy+AitcPfe/XFSKfrcK5sJ86q7uyRTuvPw6efwy0FwyDWffgFdsjXU1h0qRjwqMiMorg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbVDFVdfoZw0yv/mdmyIg+RS94OUUsv+WkS8iC0pIQo=;
 b=eC3Yg1w2yavmwNa1cOHzdzsG9ggm+mSnwOBTSD1Jisa+nRxfBpZZjyXtK65Bxv/TrV4iUdGT5LtkCUgX3/3xaZtmz5a1KY3nBuZlykKac5eIugzkEPInoWhf0FmrToCqer8lp9F1Sjtgx7PI82xE7DgFH7dZWf3U0+njKJ8ZXJ7aH1FOIVpKxF+kTL7INXhinj+n5f7vSNtVOnnhk1yRyB5m2/D2UdGrMGBjapfuxqFDr5CqBxLkt+ZNW9VtSCDjHk8VicLqvPN6Ia2KcVj35W4WafjgQCgavao7fSS42L/Yj++TRDvtgqcIi5nmvg60a+mrRVPK5qrhVruRk0BDjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:7::10) by NT0PR01MB1040.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.19; Mon, 23 Nov
 2026 03:14:35 +0000
Received: from NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
 ([fe80::be4a:d29e:5188:b37e]) by
 NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn ([fe80::be4a:d29e:5188:b37e%6])
 with mapi id 15.21.0615.017; Mon, 23 Nov 2026 03:14:35 +0000
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
Subject: [PATCH v25 0/2] Add OpenCores PTC PWM support
Date: Mon, 23 Nov 2026 11:14:26 +0800
Message-ID: <20261123031428.20536-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
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
X-MS-Office365-Filtering-Correlation-Id: d058dae8-60ce-4bed-af75-08df490fe6bb
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|52116014|18002099003|261009223027099003|56012099006|261102123227099003|261028144727099003|261021123027099003|261022105027099003|261026121527099003|261022075727099003|261021121427099003|261026140227099003|38350700014|10067099003;
X-Microsoft-Antispam-Message-Info:
	2fMY0IOeLzsbaEv68FeuOdT57w+LZa0U1ZN9sjfEKYYZh1+W8sZVfB2lwuz6j6By9uadMXsU3bjlNBCCzkXXXM8XF/EDu52br4BZ+W1h9nAnXucdwTELFcP3kByGrBzi0uuk1oeEfDthz77xeK0ZTen7KpB5Ga9qRfhRhYc6jVYIt78Ro6hgOzv8kECXbB7EztVAKbYdTjbc3dFVsuT9V3dce617UfvsAqJDWByVbaBMLtplUejvIN4dCGwOvTZHoaiS5qjDgdu10b5FV+3JQWFFxaG/qhBBoPa/AyLwSW31qFUEe5L1D0Tg4yvTRxr1dZLbJelICRTtE/bJ9yLACinyz/N+QqDmw4QT/IlIw07pwGUu/kJb2Qb2rml6GMGMkUvwNDfXIKYMzsHsz/x6CLC/1f33WeG9WkW4RPJwfqtLBTJr/PS2tfKWogViucoicXGlG15xg9oM8094ZxWPqpih1K1k+oCJYw7+Qe6r73FwcRpj24VLsLp/NCz9L2IRzk3XLG1txgVZrSFaxKdymzAh/lxtMCrf8mfUYeaRJNY4NPFTz6KglkpnyCLEFH8w
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(52116014)(18002099003)(261009223027099003)(56012099006)(261102123227099003)(261028144727099003)(261021123027099003)(261022105027099003)(261026121527099003)(261022075727099003)(261021121427099003)(261026140227099003)(38350700014)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WvuTYYu1TrNG18u0rsex/oHhaHTzqfZ4sV7yawQ5CK29hHctl1VUgVC1UPvD?=
 =?us-ascii?Q?udQiYAuHAwCwKMDFEwEmp6raKF2To0RPHsoDUyCBpZqYQjy41E9CbmysjtsV?=
 =?us-ascii?Q?UFRkXyEdTpzFiv4T7chHCyXb+YjLtqBRLhptuTVPj0kycn5vZaKJpcbt2HJO?=
 =?us-ascii?Q?AmmGdLFYpa9gTdiNTIddX6YQk8z7xg6bQt4jAlmULqlq0HnER/hZAxWcK3aT?=
 =?us-ascii?Q?ii2N14W1EYByi/I99doRRd0J0+HTeYo01RVZU7OY1Yw+H1ggl0WLmtCg7vQj?=
 =?us-ascii?Q?kGWlRLtkoebG6pMrtJRAJE6Ndt7uGjNVWvxb9dsPgEb7HLYHMNMzeMN1yWH7?=
 =?us-ascii?Q?bZqhbuYngRO+AyXWz4cEQLt0KEIampKkWbh/Eg4xAxxxrgFJwnTLYDEcdg4B?=
 =?us-ascii?Q?Y1KooJYavGBQtGVnzHnUEZuzhaRyk6vLqurMbuNqCoPi64FaBv3ts1q24EtW?=
 =?us-ascii?Q?YTBT9Qbzn3lfyHr+4kOZ8rMUokvrWnihurDIPW1QyIAHyBNKxAv3sTvnuD0r?=
 =?us-ascii?Q?1eS96k/xWbqcuIiUOLVQLXhXHMQQoKY9k+fHAsrw1yKswnwVEc/B8CcTWfzs?=
 =?us-ascii?Q?s1OXcFR1NLAWKSCgOHzqtQj1ECzI7pOU9ndmpBMz612uBTLwUQVraw07ebFk?=
 =?us-ascii?Q?OPndGaI49oA+VcniB1pKkovHnWG+0IiY4E9rkKYc43wkJLEvSd+NmGsLR0MX?=
 =?us-ascii?Q?cMavPQS9WoGKyIllBKMyaNoV0D71LcymAE20p3VB5mgo58SfbYQhYxZNlA1d?=
 =?us-ascii?Q?cnUhVdj8KS4QEz5F63D5K7s3i5QWGUidOiB8ywOTbZWEpL18ZdTA2Ks5ybt+?=
 =?us-ascii?Q?NQxj40xDet8leMG7MnbNgimN+/0eNYQFTblHDlBGYTs1Hfq9c6ZNYr/wrNru?=
 =?us-ascii?Q?T4uUFtKQxvYp/WakRp2BhCvEEI0qWzG34bLrJKsc8Mu7PtkShuxsuB/RZmyM?=
 =?us-ascii?Q?Rawd2HmiuRW3jpd4e4jU279Pp3z1mC+CqcedENp80exEX/Tt4XHbFBu75/8b?=
 =?us-ascii?Q?N7vgk5+BNG8JqwfzqnYHhZv4MaRJzha/+LeeWl4fhJ3n5QLhNLOIcOCoV7mr?=
 =?us-ascii?Q?zzf2kKWxOMB/C4pCRP6CV30VwuLuPpRpEXuMo6l+zrVLeIXjSMufr+1Jqu/l?=
 =?us-ascii?Q?QdUU9oqFnIwKpEhWYSDEo1wVv9SjFGartlJf11U/yryg5o27vhhybPJGeklU?=
 =?us-ascii?Q?oZ08vwWQgUI9FWyefUV7+wvPLjRTsMjJjG6hiZaKhH8AGRRMyLM8KlT6pYXE?=
 =?us-ascii?Q?HZoei0keGNP7jRWHq3JnTZgnEEK2NAS+iqvWX8QQF/nEYKIUE0l/G+DCSVCb?=
 =?us-ascii?Q?0zWd5kTTLSBurE6Zg7uD4PjGXZxLYiZvd7+SWz+0lBWN96s+DCzubK6tJ+Y0?=
 =?us-ascii?Q?eJSRkfch/ZgApXU80dNFnuryOIzJqgLBDFrIyHfZ3Cd5hZj2lgiFLb0hcHR9?=
 =?us-ascii?Q?WgNciqOB27c9QhLwvmdN4AmMNUscFYWHxoRmH6fWnOP+9KOMGF1f91p9XUgm?=
 =?us-ascii?Q?GdCUcOjNjjSHtHsDmVHiOG8dp8cxm1vlCu7nAcUn9rqna60IDM0ofNWy7UAU?=
 =?us-ascii?Q?Jqzl8AznlsIuRvAmHxwzq+zT791tiv+Xi8lhLXBTELHciLS7BH1Rj4CPtDbD?=
 =?us-ascii?Q?oop3SwiLlXQyBqnuxeVndTpxXxMTIytYeg/MYloUE8D4QCY8KgGbEyqZV4aS?=
 =?us-ascii?Q?EHzeg8UY8+ea/MFX0p3xslsuYOWvb4PCkfHUhISXhAjgQhCD2/OLtYM8kqjG?=
 =?us-ascii?Q?4dZRO8Z2HwKVlRDHMRpg/eDR8R9A3kQ=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d058dae8-60ce-4bed-af75-08df490fe6bb
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 03:14:35.6505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u0QdWBdS7gtRskS35tcR1zXUOj/BnY6Md3O4H1kUoAIOuE0WOyoXPiMFyWCDCUKMNjy3orhVKQzk/6FTHv5bOaicEu8ZETcKXoDYjD3D3xY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1040

Add OpenCores PTC PWM driver which is used in StarFive
JH7100/JH7110/JHB100 SoC.

I will maintain this pwm module in place of William.

Changes since v24:
- Acquire clock rate exclusivity with devm_clk_rate_exclusive_get() before
  caching the rate.
- Read and validate the clock rate after enabling the clock.

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
v24: https://lore.kernel.org/all/20261107031251.98972-1-hal.feng@starfivetech.com/
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
 drivers/pwm/pwm-ocores.c                      | 305 ++++++++++++++++++
 5 files changed, 326 insertions(+), 3 deletions(-)
 create mode 100644 drivers/pwm/pwm-ocores.c


base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
-- 
2.43.2

