Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020112.outbound.protection.outlook.com [52.101.56.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA16426656D;
	Mon, 21 Sep 2026 07:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789975299; cv=fail; b=t3LaYTpw6sDShSYnRcpjXC5fReuoBfu1n53pA0U4gHFl+1iMloRQ3+jXjzBsN1eOCUOdgE26fe5lP59PyK9MD2M94fYTFRnQqvqkNwlo9p5yshcFZ0DzntYH24FDRWSU4BNomgcKM+k0mxzCp+0F+SoXD7WDJ/IyAGTHA0kcUbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789975299; c=relaxed/simple;
	bh=WUg6oYHr3hET6NfdVJs9RA/WkhiRxFavkzmIsbM1w+Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cgPoZS8WZ5YVVTh1mCYSjV8ajJv91vFbyg2VJSTOZV6DpmKtEQPMFs1LXKnhLCDdahKy0mb9Zx0DSlKu83Yhg+ZTdXMva6gUeL1lhQlVxpoXx7KiPdVAn25Ptju18XhG2Y5CrZ82JfkLNhn55pJkSI9aeIpnVw/U+D7hPA1Cr/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=DOU0q9EQ; arc=fail smtp.client-ip=52.101.56.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="DOU0q9EQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tDs1aDHBHAnx/QyoGdZy0vGbuy3+6UjvNi/4YfMOVb8vx0QZ9M3ArAdWehyRlBEfHW6ABmPYyX1xVGwsOC9FXjc/zG/djZBUqO00up1httjv2qQOsf6rmJ9NJyZ6IwiQaTT/UXXdrNgGZa/+HQItsGfIqPV+QAf18JupOw8MFB32D9jG0/13GX/oyyutOTM/aYPeGG++grJ8jhubWnovun9e3TheT/udTDbSmXI22B4QlLfGHhyb3lhrA/2a0FzeSSB4lDOoajpcxR3PIuS6jte1Uxq02HLg0CzPR5okRlGBshBQMwRhsY2q4+3VcUm3VlLB7/ymQ/E+HGFu81A0Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4px7OhNSTEaiV9y4UiP75eXQFskAwzYDkQTQeJ8U+5A=;
 b=NTOZ8dYfrjGuIIXs3B+WMTPcc89/LHRBiv644LfhEhaYuvZv8iC5dFpC/WnRINIIRFEPYpxns/X7CdaTYoJG5uqNLWIP4/52ogtaBpBfEgmyCIrUVLieFG3OUfv2CgQ3xazNkhBbXMtbGDuUuRvBo88YmAJt070qX5GjNrReJSlEWuVLmcGLp+ysQuUlF4IUClc7OiQdzl6EKnnQ8b4X7JZtIhvsnvQk6TtdvmlQ9BtoOI6sGTgSqObLe5C4+GB1j2j8ohqzp+WlIZodcSabO5kD6IlU/EtaYA2aQFhKxYI8nZQ7CQTZn9Uz4FQl2NqeMbn0WmpJaE/viXMcuQsBfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4px7OhNSTEaiV9y4UiP75eXQFskAwzYDkQTQeJ8U+5A=;
 b=DOU0q9EQAYRql3+Y0rGKOFERa0VbO4/YAkCaLU10eHS0wqtBQn5fuNdkbGdgKuwkQMyeDEJdhDRg4hOzqwWq/9YXeDv3/rBD15UrPPTPRtMqTo4MFW1BS80Z6ZB4xp5ywo0/i6iIhEhcHohDZMIWiUFMY+EFjcoMvOMNgnstKyDLJZuX4kJyX66CzNrFFTVAlL8UN9sv4lPaXjLh34Yyupki3z454Dt8l8F/UiqNz20IULeXHw1RvqnTtGDnxJj7OE9ZHtploHThvA+Bc/8+izOpUKSNy/yLtgxW1EQEZ7KrRSIAcgp92YzMzNkN+FUptEFlTBM0b2i38KLoP9F4LQ==
Received: from BN9PR03CA0491.namprd03.prod.outlook.com (2603:10b6:408:130::16)
 by MWHPR18MB997224.namprd18.prod.outlook.com (2603:10b6:303:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Mon, 21 Sep
 2026 07:21:33 +0000
Received: from BN6PEPF00000076.namprd03.prod.outlook.com
 (2603:10b6:408:130:cafe::a7) by BN9PR03CA0491.outlook.office365.com
 (2603:10b6:408:130::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 07:21:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN6PEPF00000076.mail.protection.outlook.com (10.167.248.203) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Mon, 21 Sep 2026 07:21:32 +0000
Received: from axz-uw1-build-vm02.corp.axiado.com (unknown [10.14.1.22])
	by smtp.corp.axiado.com (Postfix) with ESMTP id BD1644186B51;
	Mon, 21 Sep 2026 00:21:31 -0700 (PDT)
From: Petar Stepanovic <pstepanovic@axiado.com>
Subject: [PATCH v5 0/2] pwm: add Axiado AX3000 PWM support
Date: Mon, 21 Sep 2026 00:21:29 -0700
Message-Id: <20260921-axiado-ax3000-pwm-v5-0-202aad28e129@axiado.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPnasGoC/23POw7CMAwG4KugzATZTpoHE/dADKmTQgYoalEBV
 b07AYYK0cn6LfuzPIo+dTn1YrsaRZeG3Of2UkK1Xgk+hcsxyRxLFgRkoEInwyOH2JaiAEBe72f
 J0bLSxmnfoCh71y41+fEx94eST7m/td3zc2LAd/ermUVtQAmSvfU2ePAa9e47s+H2LN7cQDNhS
 S0RVAgiAGqgJofxj1Az4RCXCFUIwykwR4fEzR+hZ8LD4iO6EOgDKGORY1X/ENM0vQBh9ddbfAE
 AAA==
X-Change-ID: 20260518-axiado-ax3000-pwm-cd7c346849f1
To: Akhila Kavi <akavi@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 openbmc@lists.ozlabs.org, Petar Stepanovic <pstepanovic@axiado.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789975291; l=4821;
 i=pstepanovic@axiado.com; s=20250916; h=from:subject:message-id;
 bh=WUg6oYHr3hET6NfdVJs9RA/WkhiRxFavkzmIsbM1w+Y=;
 b=WIIX2fFiREPe7e2kcpsxn3awk5OsDAr4UkTRMYU1WI0nWYH0x+/E74dcPwwehJZ7twYdBLRev
 X42jcuVSKpDBtURiZYYEbXXqY26kt8caSjmfdGD2ElQ5aVrthIULxUC
X-Developer-Key: i=pstepanovic@axiado.com; a=ed25519;
 pk=70f1UJOGT9U11ZK6o+ENXtv0I5wBE3e+Y9YWODzRsdI=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PEPF00000076:EE_|MWHPR18MB997224:EE_
X-MS-Office365-Filtering-Correlation-Id: f3336154-4e03-4b5e-2a8b-08df17b0f680
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|7416014|56012099006|3023799007|6133799003|18002099003|10067099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	PSTUAArRTFmCoz3sr7zNh/2HZ+DZpCEKPGEH5jB1Yw1Tp8zicUf8ZllY/LHyPFN+gqQ9oSwLmOX7ty4akpSxv68+QPR23mVdYlsvzq8Kidbe4mIxdSoyJq6wD84Y0sVU0qFJBb4aj2QiiU2ddUjC4U/l7eFxejxh1FnqZX/rxpzTolht56wwtMXJ4FgVdJOuF3MSVkwoIs20hlRohjE8XkYy9kgreLe09rOdJDz1732mXMwt87poT6UpEHa8yiZpfIRnFtiOY1WOXaiPO+qfdfT7YZuaMCYYHirrWvPgh9IR5n6LtkL/281Vyt+GRhi6HFVwkOfxFaLI1mg+F5UB28OsiTGfHju4XgZ2kB02vjXYe7HggCQpp36IGwnHQ5x77UabgsKN+0BWrmkpl/8wxIrcqczbpWeV9UnqFn56wzCaVXYpO6w/8FJ3fGZRjufKrnr+zHF8K0JmzGCMop4qewg1HjzIlT9bCQAxZ5Hq5Z3AHrKp9N91lvzQ0N+WLuN3qWJBF1fDuHyqe4U9gWMH/xmzYRTKdNDWq6MC0EJhT78bWTYXrmSuoc2x2H0sOGMYQsV5aYP2LsgkRipim/XUYAkf3YaLxP+07MRYd1w2zT+L9sFcvFHYeZQ5niLO4iPnvCi98jqwjS3qQIlN3EJTwQ==
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(7416014)(56012099006)(3023799007)(6133799003)(18002099003)(10067099003)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4W4TmVYl8Pp/1A2t+CFXsxu8tP55N1uHzVb05l+Ek0Q1+Mrm0pugBJfdOT9VOI5wwy61chLOwYNF4jkSfzcpdzcHr0bK6ZDzx/w4pl3AFuRb00c5L7cWlgB0I+VUOWi5CSBa96cxBz+dxTQ2cn3/Qic81np0IWEsbM7+JbHXXK10HWM3N3A8KNaaYCRalRx++rjQTvPskxdbp7i4JKcgV+8ZlhzGLfLt+C7Kx6vQEvsQvqoiGK+MOpIJkxnGp05Kxfz20CZhItvwQyN5/9QdwAUOANL45SDlS207QOnYnC1Xce2nLpahBSYVmyQhc1JcQru5CAMmawgyCuiXG/XTmiuWR6l1oWABJGC+xYkvXvBlf20A1/feYk0ivVl9XYzWEgLXTIbBvwgapYs0RPTiAwaeAgx8NEdlpY0bZGMkZeur4/uDn8twVFFuZEuXY3AT
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 07:21:32.5501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3336154-4e03-4b5e-2a8b-08df17b0f680
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN6PEPF00000076.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR18MB997224

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
Changes in v5:
- Use the hardware disable state directly instead of emulating a
  disabled
  PWM with the constant-low representation.
- Remove driver-side cached period and logically-disabled state.
- Handle 0% duty cycle using the hardware constant-low representation
  during waveform rounding.
- Decode the constant-low representation as 0% duty with a
  one-clock-cycle
  period on readback.
- Simplify waveform read/write handling and remove redundant validation.
- Update the driver limitations documentation.
- Link to v4: https://patch.msgid.link/20260908-axiado-ax3000-pwm-v4-0-19a03671cd5b@axiado.com

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
 drivers/pwm/pwm-axiado.c                           | 277 +++++++++++++++++++++
 5 files changed, 351 insertions(+)
---
base-commit: 368d34807e6d04bb2089918383b58abf40e720a0
change-id: 20260518-axiado-ax3000-pwm-cd7c346849f1

Best regards,
--  
Petar Stepanovic <pstepanovic@axiado.com>

