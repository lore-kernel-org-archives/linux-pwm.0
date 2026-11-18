Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.118
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795005741;
	b=Ag1kyaXWWsnmsCXT95L2Iz6Aj6YZZ3hZRX5O9bqx8OjH+SV8PspdBUzwc6YFl7YT5bSV
	 USEEnHb/8koC4Ab1ONaMdQ5BBFHMvCfLjj0wjeNKA4L6L9sf9xdZez+P6l36MUudDJnLJ
	 ZOXyYCGTNXRvjIb4nJtrouVt58g+qa5QJGp8tCZ0/xfSCPTatmB731n6n2UGrIVt8BJXA
	 ZJTfxoavMwLg/2Kl8MOwqWb3PAAYqinFFg0xAstnbpnaU8fegKPx0hS+lhlqI1BMut1mP
	 3mWdm6ojcRf0yZcZkG2aKD8dfwscG4976vBvXhnKAFXvB5241TlTqarZKxNSkOdNneA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005741;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=iiXMeRDHdEhjrsUb+sUXASzmIyO6B8bCojB6Jhar+0w=;
	b=MF2mQLlLISOd7FlxyU3SGWhFh0Yhi7Yaytud+nYegbT5iBSxznsuDO0QSS7OSRvAjvHy
	 r2z0JSRfsOvEooHvBxOvWb/sJ0nLOznlCPpPm8FvTK+LRbw1qfYbMYaxmq0nYLno6Q82y
	 KNfZ7Zcsl+H8IQNYKgpTrKxyhaWs65fHuyG0QvwTBLthMQ0MSlGo6+CkE7ZWMeRlUFMhd
	 C2dzPwF4p0km1dwvoM5Gr+jsdqgRjeTVK7WAsXUlRcTIhpYU+pi223KzD/emeaIEWkLax
	 o9s2CTzldzhPeMFKSJqnoR7wChZ5pmY2HaLjGVt44l1rLQdua4Z7KogIguNfBAq+8xg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=axiado.com;
	spf=pass smtp.mailfrom=axiado.com;
	dkim=pass header.d=axiado.com header.i=@axiado.com header.a=rsa-sha256 header.s=selector1 header.b=Mm06Ay9v;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.118
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023118.outbound.protection.outlook.com [40.93.201.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A7D60A2612;
	Wed, 18 Nov 2026 12:42:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7A7D60A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=axiado.com header.i=@axiado.com header.a=rsa-sha256 header.s=selector1 header.b=Mm06Ay9v
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FbJezm7V2o86N1ojg2LEXJM1w+tafzxwO2Nhp9oCSqMK3fZ57xcqXnkjrXL/RZl/7ouW1uYfcFVBUf6R0Iy9TgPL6aDOqpv7oGE5G68HSdqwuf84uysaKcPADdhWmMobZyIwAN1xzQhcjiwz7voaWbBOpP+2xtiW4x+0SL9wF7YUYVMvMLs1s5eKtdYkj18DSV047M3cwXrv5aIFVBEATaQLm5QSf/DQIBWAGHGehcwxdDxC2Xs67cvXqEX/vAxfGlX5yLGgH8yvY9KVYhTWqaRH+khOwpNxE3USZJszH7ZYhZFE2r3LWsyLCzr3amdittTGgPpxQ7OewMKf/pivlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iiXMeRDHdEhjrsUb+sUXASzmIyO6B8bCojB6Jhar+0w=;
 b=kZB92RQ+hmB5U6bHa9zLswQL3tvxqvzwOhQsIHMIcE0ATN/zcvGcYuoYUG6pfibgVfroMk3yfIl5bOdqvhhkKj+QOlzwJFu/r1o0g8238t0e3z2R16ZdrsP7OpLZnHSIBZ3VbjM0wgUM4eRliQVfuUiVxGBoRaAzWpLdwSpsIuzcm3ViRq5/ZO/C1PDZc3/vOGPe/Q8P23ClLtn/xGcw5IT/fm71A1kawQiYt8Ts+WKhnwdPuiELGg57koknEx3qSc15vcRzoYN0FdH89q8b/pnzrotHt6HhfZB30QOWvPfYP/joINAvPN9zdqvlqnq0lvqoouZQmiIW7zx4oqTHzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiXMeRDHdEhjrsUb+sUXASzmIyO6B8bCojB6Jhar+0w=;
 b=Mm06Ay9vJ6SmgyiWvnkuhqFlkAdaKDwzSGQe6Wxur6YhzYrG0/X/MB8hVTLuTxRH2Uag1wIwHzYdGkwShhUVbPTwZgELkOp5/UUcgnB9V50qA0fVKgMJfyOjBx8IKfffEZ4a6hUPSfuzTIu6s9jZqFWdVGYlhP8nP0xQgNWabaOunKknMSZmuGgVYmDxv8GXFjTlgyz/FOnvylQQtm7Dl9zVME7RrY49cSNT6+QJp97JUREkys7X2oDM4nx/rtlLIFATrTFkxadVAkeckFdJITIZDkPr7tfzsK1491X8RhaBr+V3K9x656P/QzXB/E8W0PqMPVBVCsYzSojAsNQcFw==
Received: from SJ0PR03CA0187.namprd03.prod.outlook.com (2603:10b6:a03:2ef::12)
 by CH0PR18MB4290.namprd18.prod.outlook.com (2603:10b6:610:ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 12:42:16 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::88) by SJ0PR03CA0187.outlook.office365.com
 (2603:10b6:a03:2ef::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.9 via Frontend Transport; Wed, 18
 Nov 2026 12:42:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 64.62.143.114) smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 18 Nov 2026 12:42:15 +0000
Received: from axz-uw1-build-vm02.corp.axiado.com (unknown [10.14.1.22])
	by smtp.corp.axiado.com (Postfix) with ESMTP id 8F53E4186B53;
	Wed, 18 Nov 2026 04:42:15 -0800 (PST)
From: Petar Stepanovic <pstepanovic@axiado.com>
Subject: [PATCH v7 0/2] pwm: add Axiado AX3000 PWM support
Date: Wed, 18 Nov 2026 04:42:13 -0800
Message-Id: <20261118-axiado-ax3000-pwm-v7-0-bbd21a8cf861@axiado.com>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACWd/WoC/23QzW7DIAwH8FepOI/JNoSPnfYe1Q7UwMqhTZVMW
 asq7z7SSsumcEJ/hH+2uYsxDSWN4m13F0Oaylj6cw32ZSf4GM6fSZZYsyAgAx06Ga4lxL4eCgD
 k5fskOVpW2jjtM4padxlSLteHuf+o+VjGr364PVpMuNw+NdPUJpQg2VtvgwevUb8/37xyfxILN
 9FKWFItgipBBEAZDuQwbgi1Eg6xRahKGE6BOTokzhtCr4SH5iK6EugDKGORY3fYEN0fgppTdMs
 iQCFEcgnJbwjzSyBA1yJMJWxOiSOAs+n/d87z/AP6nV5zAgIAAA==
X-Change-ID: 20260518-axiado-ax3000-pwm-cd7c346849f1
To: Akhila Kavi <akavi@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>, 
 Tzu-Hao Wei <twei@axiado.com>, Karthikeyan Mitran <kmitran@axiado.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 openbmc@lists.ozlabs.org, Petar Stepanovic <pstepanovic@axiado.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795005735; l=5348;
 i=pstepanovic@axiado.com; s=20250916; h=from:subject:message-id;
 bh=4mWpEEovcG8tFcn2/rN2Ja8Pd17vwC72xZOgEe234q4=;
 b=NNEbjWOGgRk6Nf3y70vVxDpsGsvbM0LXKwifsCYspAjxi8QMRLamNLIuefbLytgLDKnzNVqko
 H6smGdXV0u3A5cJRKptLYj1S614n3vj/pOAfJt26nPMt2hW7+m2R+C/
X-Developer-Key: i=pstepanovic@axiado.com; a=ed25519;
 pk=70f1UJOGT9U11ZK6o+ENXtv0I5wBE3e+Y9YWODzRsdI=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|CH0PR18MB4290:EE_
X-MS-Office365-Filtering-Correlation-Id: 18190fbc-036e-4c97-9e31-08df4571603b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|82310400026|36860700016|10067099003|261022075727099003|56012099006|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261026121527099003|261102123227099003|261009223027099003|18002099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info:
	2UXQoh9ctW8s2rJ6usXnrArm/TwpwISF4mZbDYCl4OFIVKNhooGT6C+FjfIrUbsiC3fe6JW6LYCdhbrdqe3X0vUdh85GJmFPC8xm4qm6nQs2SSX5NPa6JGczQm2IehQjGtRU+HfHMYkrI3qQK/vRgWCL1X1vtlIEdQD6UCtbRs3HcqRdPAWCdPUcDwot4BWnECOgOaBMBZWXb36ccU2XNmPQeBMQItzOSQK5A2ZvAUCPS35qL0GxxDKHnH+EyPuuX2yLt9lTVdeC6Cn+R+zMEzwoeL9VvznA59cdD8WY54j2oO1A3ZKSHarFHsUGOfc4XEWYe7oN4NxoFinif0tQgL99F683y8OuqoDT6QQEcyWySLZ8Q5q9dJ5morVNbja7ZA9G8N0m59S3aNygRdvjRhlJGXrByiNJJV+OMZSKrJCgC1ivMcqXjMSKvvh0+oCENDiDu9/rujY/fQyNVUCEuXB/+JRjxHtN8DzuqeLUPgh3gSA2KHZEqM+jSOBXsNuCbEtaAb77rMuoceljvKGO/lNlqz9k1DX7gC3VCi6W4OYG4mgyZHDkmBVCrXJZQVeTvt2k8GMYMfm/Z3Utm5tHrwJUei4oTg5F5N34yJzKZGwF92rYYa7pkUAIiUGktH8xiepOJbN54geXjQMvmWku2w==
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(261022075727099003)(56012099006)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261026121527099003)(261102123227099003)(261009223027099003)(18002099003)(6133799003)(13003099007)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HhtVQ9TSlZnZs1EopBNkWNBnrynIgJLH8VSgrw0mylE/KlOeOCMsQy/QH7zjdvTQiKXmYn+b5ttWYyI0AHzHZGyteQvNfPbQz0JzA6tsplQ2J2q8kuLVFd3zezp2eX7sXRVdDuW4wWWxV3wBiuVtk06I9pNe6QVZKIB2xLKdVE0b4QCJwRsEt33hdZy+DDCdshUtGES2tjr+DCThqkUMuFBy7KZfVsY01vFICA/8Erd3gHp6I8SF4LuL2fpXdGelFHQeArGiEcrENX+ilxDMeGvUynkEaj2LBXs1+qzsZOT1NUQpbkPcfWCxM7s5JqKZhmiS9wOi2MNeepQJG4jKdS+5fg0oHTASbBSvm+h5IgmjFlOHOXwLO0aDdX076DIKDUCo+nXm/L725af7ixds1vjry3NCnVPua/Nm9sLRdiNbbPJazKjcKhc0JHwo4lSv
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 12:42:15.7420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18190fbc-036e-4c97-9e31-08df4571603b
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB4290

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
Changes in v7:
- Rebased onto Linux v7.4 and resolved a conflict in MAINTAINERS.
- Link to v6: https://patch.msgid.link/20261005-axiado-ax3000-pwm-v6-0-7feecd0087e4@axiado.com

Changes in v6:
- Use 3 PWM cells and add the flags cell to PWM consumers.
- Fix readback of the constant-high hardware state when the high-time
  register is zero.
- Link to v5: https://patch.msgid.link/20260921-axiado-ax3000-pwm-v5-0-202aad28e129@axiado.com

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
To: Tzu-Hao Wei <twei@axiado.com>
To: Karthikeyan Mitran <kmitran@axiado.com>
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
 drivers/pwm/pwm-axiado.c                           | 282 +++++++++++++++++++++
 5 files changed, 356 insertions(+)
---
base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
change-id: 20260518-axiado-ax3000-pwm-cd7c346849f1

Best regards,
--  
Petar Stepanovic <pstepanovic@axiado.com>

