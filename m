Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020084.outbound.protection.outlook.com [52.101.61.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950293C76A6;
	Tue,  8 Sep 2026 08:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788856132; cv=fail; b=CuwGOYr3C6FpJ9qnYO3+5FQUP081IJeY851M8aR7EjfMeApIl+3XlWva1CSm4w8A+CGEuDNa4/7qBe1kB7d/Xj9AM6GFYN1Pw9CTZbI5mLXFJihFtY5KmgkMb5BtlbDhWveDHIAdTnhgPSnfq9ALBV5TH4W8IFhSZfglgt9yepo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788856132; c=relaxed/simple;
	bh=1pekY7zsAw75UklgwmeaLwiYU17z1/ArA7rU+mywo5k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZJrXbEGszbFHbWH5D4ZchTMJpmLrDDPIEAL3/mxdcnqWJXbM2/Xq+HlTpLgWSdO16Z5S6CLwPk2XmaDbW/UZ3dJoQwq+9geYyT0PRjCxWUTx6oDVojmlSrTq5N6wODkyDs38dxT/qK/d+jsdqt7rSnC4I16hIjao/RcvPhJIxSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=KgAVqkhB; arc=fail smtp.client-ip=52.101.61.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="KgAVqkhB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HdG8GezuQ/qL3NhNVfJr9Gxu8oXkdLyilzNncf9tJu/tvFKtm9xxm7rLOUuaE2/w63GdyXYT4F1ua0CFUF5erIrvrE7zfYaxISPSWwa5SjAGQhQIQ1C+sKgldvYzc2G7Nhe8G/w+QfabSjQOAp/xMuVzLAqGuHhg1TcXnhtUA69OzR/PQbAf/Th/fja1DbIopKbdZwn8c+WRE8l7SUlnYohOxYE+p2wLQqTnpP6U7gKw0bSRo06UqBTxQ9oHXOBie4GX219/GM07pSc4CBqxPdn/MvlIdHv8LdimXEIk6HFdSizV12GnniaRtdXWPq3cyiREXqer9p1xmeLYy+dJSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHTPpG+5bSgQigRNoj5V6gZiWBiCbOZXEJaSNVdZkLk=;
 b=D7tEW1Ooubp1Al9F2na26DbcKeHp/ZN5wM4eCN4g30jLsrxXS1TMIz//ZDpzJRSTy2cYHi46aCjSQmeETnxWZAhh3HihYGPATZhkYmCS/Wi/+FKclS576xajG7JfGJkrITSgeMCdKfW+38fhLm6mLRvj7YYrO8r7PbGKuQ0NcTRENt0Uu1dBgIB8ZIINfw1b1VVy6lKNs1Gib17TTdfxPKbOB1yr7PBEc4CMP5yTmBgUX/VvSET5uVDJKQXcVs2Iy5W4ZTbjQtv2izi5iJ3pwQF8hry01mALy91Qr1WhipQhAsvrM8174uJt5XmP+O60lBEMHRp46wqhqtkvU4uydA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHTPpG+5bSgQigRNoj5V6gZiWBiCbOZXEJaSNVdZkLk=;
 b=KgAVqkhBYg+IknTUUTIkKCGk5ronBZiC3hYIIL1nYsZDVEf3BU4ptWAH+WgNDw17+T6ZTWmt6ewn/6T/jbOFxy8oLbHgcaY+kuBrFYrj4YqRZCGfjtAVoBwTkmn4ycv0khYBs9QbxbzhxnJ8Se+cEFePjyPpj+OG8PGSESQT5Tr0QB0k6xVHTmr6jR/0qYqfvK+cxeVxkw87eMgIzzTy/7Svu4C5i528UChIn39MLoT8IgTScAf7J9PL4hLPrF2xjEZ4KBVKmawoWOle20Hmw5srT+Jvx1FhkV/XBhUbyklANJrbgxQIFUPsZ+5B8bXDQ/RXdpfn43TB+I8sscu/dg==
Received: from BN8PR04CA0052.namprd04.prod.outlook.com (2603:10b6:408:d4::26)
 by CO6PR18MB3889.namprd18.prod.outlook.com (2603:10b6:5:342::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 08:28:45 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:d4:cafe::3c) by BN8PR04CA0052.outlook.office365.com
 (2603:10b6:408:d4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 08:28:45 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Tue, 8 Sep 2026 08:28:43 +0000
Received: from axz-uw1-build-vm02.corp.axiado.com (unknown [10.14.1.22])
	by smtp.corp.axiado.com (Postfix) with ESMTP id E9AA04186B51;
	Tue,  8 Sep 2026 01:28:42 -0700 (PDT)
From: Petar Stepanovic <pstepanovic@axiado.com>
Subject: [PATCH v4 0/2] pwm: add Axiado AX3000 PWM support
Date: Tue, 08 Sep 2026 01:28:33 -0700
Message-Id: <20260908-axiado-ax3000-pwm-v4-0-19a03671cd5b@axiado.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADHHn2oC/23NwQ6CMAwG4FchOzvTdhM2T76H8TC7ITsgBAxiC
 O/u0AMxcmr+5u/XSfShi6EXx2wSXRhiH5t7CnqXCa7c/RZk9CkLAsrhgEa6MTrfpKEAQLbPWrI
 vWOncaFuiSHdtF8o4fszzJeUq9o+me31eDLhsv1q+qQ0oQbItbOEsWI369O3suanFwg20EgWpL
 YISQQRAJVzJoP8j1EoYxC1CJSLn4Ji9QeLyh5jn+Q3OPN4BOQEAAA==
X-Change-ID: 20260518-axiado-ax3000-pwm-cd7c346849f1
To: Akhila Kavi <akavi@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 openbmc@lists.ozlabs.org, Petar Stepanovic <pstepanovic@axiado.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788856122; l=4194;
 i=pstepanovic@axiado.com; s=20250916; h=from:subject:message-id;
 bh=1pekY7zsAw75UklgwmeaLwiYU17z1/ArA7rU+mywo5k=;
 b=zzNPJyPPMIkTByuZZ8E6P66/U9wvi+6IRKMq4/k8VIFU8wo0DJwHwOynAT0EJI5mVdpwuCgi6
 oe2aV+rOVNvAjbxaP60dEmozVuVYlZjoj7F5Q3K0EC93+Psi0RWKn9z
X-Developer-Key: i=pstepanovic@axiado.com; a=ed25519;
 pk=70f1UJOGT9U11ZK6o+ENXtv0I5wBE3e+Y9YWODzRsdI=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|CO6PR18MB3889:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f4078d9-df2e-460f-c7a6-08df0d8331f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|10067099003|6133799003|3023799007|56012099006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	cOVdn17DDcZN/ge0p0medzaJK9Dk8ZdTOEOHC0HibJ2LgbyXIPeSaF9W5k3rPcsUrkx6CkC0Zuod5Ji8LizvMWY8PmMByXg4lZfXcoL9W4Nh/wlsG3dWInBnYCVsOrJDC7fv9XdXSOhAjX+MfBAZFKETQgwYwJsnyee3+i2ab21cWOtnqApcTrSh0VBLaoOx1JVNlTwTRym1KUymGs3uuOCgfEP/oH3/owc+nNlBKLmx3JzQbyR8Y9V6ggLocOUGsohtfN/kiQutJyCT++pz082Ov/I9DtsT3/5FKuyA07X/WfJrlZW1JAyVSSU00D3lm9v+ovC5LwPxh0WKApUt8mAaujUxu/aOj6qb21alf8Voo39ZhHqLjsfmCeUGohZjDqZ2il5e9PXJ5iNXZkEc6UvmbPR+MD9kW4Mz1wZwMzJYBPtuMvQvR4GxeyruBqjD5Kvoh4RGSsNAS7KuAQ2jI0boLfhhAUYy5BrPC4gCfhelow3Tfe2rFGQAORcYDf0+SGA1cXt2kOvXXddcl/TvJMpO98HhOG2ew+QFCcRnr5YafdUL7SK3V6Xltcxz4FugKbrSMxOcsmhApiLguTM3t77rOY0WNHVazdfpLi8wogecb9ZuKeR3xLJ03vp0yrP3fu0COQwtQg2g7982QatkkA==
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(10067099003)(6133799003)(3023799007)(56012099006)(18002099003)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xLF4Zdg5rjtsavesM+1Y0t/K4ajiQwUMd87cYptHWoT2/XT+Zadxr9yzyv4BvtN+E8VYhkiEgwj9aGI1unTqHPPN+SSQtCAKeAddS7Can2ymRIjxV6WGfKEHT1HUbZ9ksnjVXRY77NRGIR8xQ2m8Y2+XwNxUVKvPV4FmgzBIqNuZZ9YrC1bavcMRjdhfA+cGQGpF4g7+qq0BmMO0e0ogCzIv/9wEOGaUwFN+WjCdE5FyB5hmt2OGcSX4lUG5vIa0Hy5tCqxta1gHwUAAOnXAJISF9tQv43+RQZGsmYBxCOuRE12RHpoUjPtp7I6Wt7q5bT+LnWl0GPxgbsPP/nfg73ZguoTVLasXsKl7lzMVYUQbHbr9Qu2KyVYIQzvrgGluOEw/G4RhhKjeMSqxAO7V8BwwK1v2OvA1b5rPQlFs+CPKtBlR5A6UINJVJA5MU0+q
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 08:28:43.8149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f4078d9-df2e-460f-c7a6-08df0d8331f3
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB3889

This series adds support for the PWM controller found on Axiado
AX3000 and AX3005 SoCs.

A new driver is needed because this PWM controller is a SoC-specific
hardware block used on Axiado SoCs. It has its own register layout,
enable control, period configuration, duty-cycle configuration, and
does not match any existing upstream PWM driver.

The controller provides configurable PWM output signals. The driver
exposes the controller through the Linux PWM framework and supports
period and duty-cycle configuration.

The driver converts the requested period and duty cycle from nanoseconds
to hardware clock cycles based on the input clock rate.

The datasheet is not publicly available. Public high-level product
information is available at:

https://axiado.com/products/#AX3080

The register definitions and programming sequence used by this driver
are based on Axiado internal SoC documentation.

Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>
---
Changes in v4:
- Corrected the AX3005 compatible ordering to list
  axiado,ax3005-pwm before its axiado,ax3000-pwm fallback.
- Changed the disabled-state handling to program a constant-low
  waveform,
  because disabling the hardware controller drives the output high.
- Added software state tracking so readback reports this constant-low
  hardware representation as a logically disabled PWM.
- Link to v3: https://patch.msgid.link/20260811-axiado-ax3000-pwm-v3-0-6ceaccd812cf@axiado.com

Changes in v3:
- Express AX3005 compatibility with AX3000 using a fallback compatible.
- Update the Devicetree binding example accordingly.
- Add 0% duty-cycle support using the hardware constant-low encoding.
- Cache the rounded period for 0% duty-cycle waveform readback.
- Allow sub-cycle duty requests to round down to 0% instead of rounding
  up to one clock cycle.
- Normalize high-time values greater than the period to 100% duty.
- Drop the redundant AX3005 OF match entry and use the AX3000 fallback.
- Clarify comments and PWM hardware limitations.
- Link to v2: https://lore.kernel.org/r/20260723-axiado-ax3000-pwm-v2-0-22002f0b281d@axiado.com

Changes in v2:
- Migrated the driver from the legacy apply/get_state API to the new
  waveform ops API (round_waveform_tohw/fromhw, read/write_waveform).
- Cache the clock rate at probe and lock it with
  devm_clk_rate_exclusive_get() instead of reading it on every op.
- Improved rounding: clamp period/duty to hardware limits, reject
  non-zero duty offset, preserve exact 100% duty, round sub-cycle duty
  up to the minimum.
- Added a "Limitations" comment block documenting hardware constraints.
- Renamed macros from AX_PWM_* to AXIADO_PWM_* and dropped unused ones.
- DT binding: dropped clock-names, made #pwm-cells required, and
  updated the description and compatible list to cover both the AX3000
  and AX3005 SoCs.
- Added axiado,ax3005-pwm to the driver's OF device match table.
- Link to v1: https://lore.kernel.org/r/20260618-axiado-ax3000-pwm-v1-0-c9797a909414@axiado.com

To: Petar Stepanovic <pstepanovic@axiado.com>
To: Akhila Kavi <akavi@axiado.com>
To: Prasad Bolisetty <pbolisetty@axiado.com>
To: Uwe Kleine-König <ukleinek@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Harshit Shah <hshah@axiado.com>
Cc: linux-pwm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

---
Petar Stepanovic (2):
      dt-bindings: pwm: add Axiado AX3000 PWM
      pwm: add Axiado AX3000 PWM driver

 .../devicetree/bindings/pwm/axiado,ax3000-pwm.yaml |  53 ++++
 MAINTAINERS                                        |   9 +
 drivers/pwm/Kconfig                                |  11 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-axiado.c                           | 332 +++++++++++++++++++++
 5 files changed, 406 insertions(+)
---
base-commit: 368d34807e6d04bb2089918383b58abf40e720a0
change-id: 20260518-axiado-ax3000-pwm-cd7c346849f1

Best regards,
--  
Petar Stepanovic <pstepanovic@axiado.com>

