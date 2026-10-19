Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2112.outbound.protection.partner.outlook.cn [139.219.17.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680DE4F390F;
	Mon, 19 Oct 2026 12:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792413730; cv=fail; b=DMqA3egaTjJFLcQOKwiHXdZ1k7O58YKA96SJbWF2cBj7ZW6ZEKQfqkd/Kej9h6zZs/a7g9nQT19eYcQ8tEwpOvv/fHGAZhWhJIoPlLoYbZLB5KphU2PVaNdHLHsClrAxCzf36H28iqbPd/F3i3RiY6MSR3YX4GImVz3I1wiQ/B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792413730; c=relaxed/simple;
	bh=MVX/TSw2U2QcbySr/kLLnqwY3nZSjhOxr0r8mH5q4h8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BOTxR0HzVRlAvWA9Ooh9aRFoggUwYpCrW4kLFscHPT3lZmX/X+Y7YzvF3L5/+93Qx6kMjQ1P7gPOig/5xQsJKdy8Dr1qaXs1r/VkXb2B9vbWdYbgBK0NpajzyUNrj6Qqe+v8AWM2tn1gGAJpGkh0KYlsvOkFq8ix3Q+wYdlCIOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvzoAg+pcipgJyINRYdy1wjYdk+5zQ5wBG1RIhFAQXxtyBWlJsQ4x1DVs7mqQbXr5PUmlpgaXWrxXTcXAJpmduyfn82g2gKycu4NpDCmUoc9IYhChxTAOfhbCM6T2gTZ+4uhrCmwNmQrVmUu5sGbBdKJpU//wWOTdyr3wZkkYwTjdOpAWK8agGJIjcjSeNNM2ypKCkOM7DzbkzHgtTFTq11B9xdPIOfFUT21wOrZoYiLVTK8c5sOZIsMWwauShf6oephl9f8ONbzqojRS/FvNaoNKjk8CZWKZc19J2ad1YHmgUiGO9ManA8I1orUp4m1ncSG6PdGt6jyLkioOcNSZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znnFOEkvFcLyw0ElRY4QIaNNyonGzE2LhYD/kl2rc9c=;
 b=D3cvlR+UX2db4NDh5kNADnm8eNeWvet1wEc2eBOzSKIANZH3NSHthk+5HlxLlN2yfxQbzQnB8JDI70qLqT5Xh7ksinZI4FO6naowyHU2CgF2bRD8z9Z8+03imx2+4Bfb8zRaNM9nUb6p8i9fUSz7u/Uu2DJ3hZ170YLrbVCHruMVxjzCjBjwD+4yCgYz/rEvF7e3gvnnXvFOgi7jADS1QQNmnjLnKYqA6fayBf2fehjUtfH7ffkISEE5VAHuFAOJ1e+9iEXWwidM004Tu46TR/okBaPaC5qL/+ylD0hhH868ZtWReRD2EqrUWYZQY1RIiuW1Sf3vBPYP2wyhGTs3UQ==
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
 with mapi id 15.21.0522.017; Mon, 19 Oct 2026 11:09:06 +0000
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
Subject: [PATCH v1 0/2] Add PWM support for JHB100 SoC
Date: Mon, 19 Oct 2026 04:08:53 -0700
Message-Id: <20261019110855.52420-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-Office365-Filtering-Correlation-Id: af3fac11-f91b-45b3-1b6a-08df2dd1647e
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|52116014|18002099003|10067099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	QSzRWNyEHJ5vLqxF0Q6atOYKnTUl7cqZaj8UWWoZAbhMouNXSayp5sSGpC+e9jDT7fdM+dgkXXKLQkq0gYRBJMfgBz05CCpcFfd11V+ukco4srGCPdbX6OpgjBV6E4eaSR4GDVh8oHZfVXENXqo/YTJRalWXS8B3QhtGLgvZEodEiq74QIZ2QChfr5v2K6pLTVboDxfmFn1TjBCdAL0tbEZ8+ueGBQlTdQ7LpELGW5Iyfv1xdAdp/NVnW9f3jOdjVt8uHYajZ4NsRiM4MpFGvOgSxos0wF4hAfnk8SIsE0sesJ30F9S3bq70sN0QqL/sfQFHWNogJpl2z5w2jjWegxo622+TXOh7zipWUsMV5284hH1b22JzmjIewbKWaDHqzqvIQnB2TBzgho58NRnQsbmrveltW6hzbZanDgp+tZfyk9duYx1BLDAaqF6sdSJKLFlFoiPpHea9HBGa0Jj2478Go5NB/QPNaj0xuzu6uii9JAT5btHHxsQlUTU/3iv0O0tOTJHvkipzmoTkQ3wdwA8cIVV+GZIzUh4YV4D32cdRUf/6fJYH4p56U0OTdwtO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(52116014)(18002099003)(10067099003)(56012099006)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mGtkwyxncHRiv0tBswPnDB8+c9TKcsvYHhrqmnJyiRx/MKyrPtNvK5ii8mVW?=
 =?us-ascii?Q?4e8a5JHw/lNABrA05P0Sf/zMvLBwEbLhkCV9d2xFz23lDD1mugN9/Yy3Jg5F?=
 =?us-ascii?Q?wRPc+OruZyUobmK8KBmu1tIUxaIGqoUa3trhHkJplnY7lVYchXQRvgkXnVOh?=
 =?us-ascii?Q?EMX460l4GvwFrwEz4tumWhj2Jh1gnuJ+32x7k2RXK12xM29ZNOKRxMUdurzp?=
 =?us-ascii?Q?/ps1cMyh1VkfmHKdtApdToZlAxOE0RjT2pDy+hV3sIO652OamV/080isXUGG?=
 =?us-ascii?Q?D42v6kWsjYwpN9yiXBv0uJuJi3liKKVZ7J2yXoGb5tzLaoVtwtxQe8K1Zctj?=
 =?us-ascii?Q?4DieyNW4yLFxKx7npybcsoVtSXCK95OTrF0wCeymkZkBs6vo2bqENihcaIV/?=
 =?us-ascii?Q?3+T4tjhXZkEe9+Puxj4r78V2i3mYzJmq3h/wLqotPwDwODqrMkp/57wRrLBD?=
 =?us-ascii?Q?jvNPpTc1Evo4SLoIy1101a3Ibu99eaGaek8y1mOyONXKWx/QWBTJdwyP9EAZ?=
 =?us-ascii?Q?lREMVyAXCHYVsNCAQUXuHP4fm7rG7sXswR3grmuxmL2e9iLJNXqRMUjeZ82f?=
 =?us-ascii?Q?OfwMCKf1PKsajGtzdJj9AEePZBf3vkAppsi6UKd5PkGD6ZI4Ow2oLqbTvGOP?=
 =?us-ascii?Q?pWCxQZZGHSJ5/n+RT3vwGTZUN0gCKIDrIR4SafFcPjmzaqqhRS9PpqLsgO0W?=
 =?us-ascii?Q?7eb4Z8eFFW0/s5CWXgINL0Qlms1AtZjcJARzQ0+mDrLG3q87mtVe2nUJDN+f?=
 =?us-ascii?Q?AgOX8AXNGqJf2MD8lmLHkB8/7ndQ2BJM466wGd0HzdBE5LO3vMfURNlgwBcB?=
 =?us-ascii?Q?8sNYwkmjqOE/tTvYaBtjh/8PakdsHlt6jLlbaLQWvQw8keUfzVd0hZjdq0+u?=
 =?us-ascii?Q?QuHqIeh2eloj9r3ctm2VfzSIiG2xAtfzYWcP8b/jfJJOOP250O1WSfCS/694?=
 =?us-ascii?Q?goNuwtAbJWAMNAnyVwGWM/6UVhNIaS5DAmOlKFpT7GYo2tpQXSF5FEdJxgdg?=
 =?us-ascii?Q?RTvvs2Dn8Hcj1LFzwXOB+e2At/2tVHrBBlUKagYTniILRDPUNYuk0NDLSzQu?=
 =?us-ascii?Q?eqPQZGLS3pZsPVE9pHG4rUGmgwtkMpbtmysmikFxj3TvkAHAAuYcpsO8glWV?=
 =?us-ascii?Q?lpEpDsG07pitjiDXPlU7eguxBpbwHh5scq8MIQLf1QywMVh15Em7izVB9Yyf?=
 =?us-ascii?Q?qKlGseyiajSxDAIIKME4lMGdOQ3K89AaIFXD+TCYhSuoeg+kc5Ikgfa6C2yt?=
 =?us-ascii?Q?WRNz9amd84Y9tVMFh1p3oVRLirIS/y7GZkZbOZgQ0wJfcHXt21A+WoPG23wb?=
 =?us-ascii?Q?r05MLK3XLghuWXZKgE9xuhnHktSSt/WEErdOEYWKH0bBkWcEOeP4sj8Djw9G?=
 =?us-ascii?Q?Uic82emzRKMJOvaxwnOM+zjgvi9E8E425KenMHp0uQERwbGADq96zeGz9Ohx?=
 =?us-ascii?Q?fzT3thGaXQnEm78fdImyInKGHmAG182ugHSX6ExMKZCQWc6gcn7N6nW87yy7?=
 =?us-ascii?Q?ArJVC8Lh8jKECjy6wTg0MLDWrgGRQgg0YKD1hlzkmr2xU+SJyz0uS3i5yrZf?=
 =?us-ascii?Q?exw41hDv8jLFjCgW2XHsHdoeogliF5MRGawisTbY/BhLrbUbF4Vfug2Bp0wj?=
 =?us-ascii?Q?pCUbUMdePSqrNoImfacqh3AWT2Ggnm8/P7u6PxlmG3jeSrTay92ZvSy24gpr?=
 =?us-ascii?Q?UnqeCOLl14RChJBUAKtCzW70XuFS6ZX8crlo4A415SUttwsb3Es+z4bgkKXy?=
 =?us-ascii?Q?1BDTNR8Q8f8We85JKfn5Q3iYwkEfnbO4lDT/2As05J6h04GmSfvv?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af3fac11-f91b-45b3-1b6a-08df2dd1647e
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 11:09:06.9242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7aQr8qFuKB/D4lo6IxmRZTMy5jnvOWZ8Ncj+prkE6h16uHbrXEcSW0oqGA8JGRzZm27XdEg71vQnU5eMcVf/upIo1GA4SM5EVyXbN2gP2xU7RQJ47VYXoslYMU7Mfkwg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1331

The StarFive JHB100 PWM is based on the OpenCores PWM v1 controller
but with a modification: the polarity has been changed from inverted
to normal.

This series has been tested on the JHB100 EVB1 board.

This series depends on series:
https://lore.kernel.org/all/20261014110429.52762-1-hal.feng@starfivetech.com/

Changhuang Liang (2):
  dt-bindings: pwm: opencores: Add starfive,jhb100-pwm
  pwm: ocores: Add support for StarFive JHB100 PWM polarity

 .../bindings/pwm/opencores,pwm.yaml           | 12 ++++++----
 drivers/pwm/pwm-ocores.c                      | 24 ++++++++++++++++---
 2 files changed, 28 insertions(+), 8 deletions(-)

--
2.25.1
