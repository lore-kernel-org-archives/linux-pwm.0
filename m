Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021080.outbound.protection.outlook.com [40.107.208.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE31E26056C;
	Mon,  5 Oct 2026 07:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791186446; cv=fail; b=W4oRBYM9On3HWI3GNG83PuwgRiHU9pNHvji22FOZ9N8ITF1xxfch4TjNO4WZrR4bJy/F6lkNFZdAwCknZiWmjEaKx3NNSjPlZA+bk8L6WC0l6919c1V4LrTqN4P8+12P/+QbUbcBTfEnT1k+owcIB74+giVykszJWN5wb3qFlFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791186446; c=relaxed/simple;
	bh=H2Kq8h0douifAkjifRdGOJ4gqcoHSD4Tn7DkxwchLdA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tWy0USirtrL3g9p3gJ8MwH672oKfF6KJzkZ2UjUOCIG+UtWna1EADO1683f70EkCE/+vXvTg33P4129cC20Lv0AVX8ZJr8bX8qx8B/9sC6QeRWk2bY3WMdeSdpH9nAMH8ZqRwmUmhgnIsQJVhsOYcEnc5EXV8uF6vRoy7W4/nfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=pD0pgoV7; arc=fail smtp.client-ip=40.107.208.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="pD0pgoV7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZpXvADExrBRfnlzNhSs8xX9fmHOl26HC1qjrZ/mQKs/CFBqYIREqYqd/dFUXURpOfiXPSqEYeSmxmhfB2FNrhen+2szxJH4xu14qodWimssPkkcb1lENq9X8dCN++ebXf8x+Aj5RLlUqDBILagQp2QuoyHQCXApsRbiPn5qwn1JR97meEBK1NsL6BDu32GYHiYR7M8QzxrtdKOuPf4b/o0Kd4IoHPnkkjbvPjvAZXfDNtQ3jb0Y3OFKQfiKW34dEGmNyNKdqYtL5jTxPwE1sEUUzgzjnBwHApjWc/yiVKDBky5pFhb9oEIlaBDJKbyk8q35JrpFdiinV+lDhilXxOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VUTwUapXdabxZrqNdG8SXu9Zt7kRrzMOOBkOR0Y/Bs=;
 b=TmL6vONsOYjYnknI0R5e/EZLLX0IbuxfZatGWBQuetMpVIvKAk3iRc5FZP3KDS+czNOMCVm3gxL1+6jXIR9lk8Pqwwaw28k5BeGnTB9tyftdsbESjolYggn19+66tGHLFa/VmnUh3JUuwvMLOFlhrFgZ3KNwHsFoAPNtjrH04iIlxkFaXZKIBrKtT1DoMqz8HdW/hGubsSl/GFWivLktZKIFmGLrm5jneDnm2UdJcETkj5jIuwb0XYgclmD2H+lLy1/RUL0sp0BGrF7r5Vg1Chnx5unR1Cj4aDf4jK/mzFoSnRFeJHcaLq4hEGImOC7mIJJU1vZzvv0gJ7ION49+Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VUTwUapXdabxZrqNdG8SXu9Zt7kRrzMOOBkOR0Y/Bs=;
 b=pD0pgoV7w+YvqAwPuv7aIXCMSFIchYD0tvxBVJk7F4ZEnKKsIcSAWcKHmLGwsEZA9QmsmPhCK7/inOO7Mgn9cbXGErfgXGXne0GYOE+dS1Vb31tK9UuXJ4Mn25/F8z8doM6Ttn2ujxm9OVYw9GH1PcMG2i8wnvFW1SvQ6PE78NIXwsf2PevPYcyOGEe9jpGMn7ZhdNLpRabtAuZjHynfrOBe3qUpQK7eI2rKz/lzet1C0okbBhzvMyS6klpCaPACQIWMwJp8/q3SGaNyF5ZGBrGb21Qf1AZ3yw/o7+bkZ/WAtYvZwsPgRdSVhdcV/+Er4mUMF92F5nOxhi9uz7sJiQ==
Received: from BN9PR03CA0512.namprd03.prod.outlook.com (2603:10b6:408:131::7)
 by SA6PR18MB6371.namprd18.prod.outlook.com (2603:10b6:806:407::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 07:47:20 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:131:cafe::a) by BN9PR03CA0512.outlook.office365.com
 (2603:10b6:408:131::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 07:47:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 64.62.143.114) smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Mon, 5 Oct 2026 07:47:19 +0000
Received: from axz-uw1-build-vm02.corp.axiado.com (unknown [10.14.1.22])
	by smtp.corp.axiado.com (Postfix) with ESMTP id 226334186B53;
	Mon,  5 Oct 2026 00:47:19 -0700 (PDT)
From: Petar Stepanovic <pstepanovic@axiado.com>
Subject: [PATCH v6 0/2] pwm: add Axiado AX3000 PWM support
Date: Mon, 05 Oct 2026 00:46:08 -0700
Message-Id: <20261005-axiado-ax3000-pwm-v6-0-7feecd0087e4@axiado.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMBVw2oC/23PS47CMAwG4KugrCfIdtI8WM09EIvgpEMWUNSOC
 gj17qSw6IyalfVbyWf7KYbU5zSI3eYp+jTmIXeXEszXRvApXH6SzLFkQUAGGnQy3HOIXSkKAOT
 1dpYcLSttnPYtivLv2qc239/m/lDyKQ+/Xf94jxhx7n40U9VGlCDZW2+DB69Rf3/ebLk7i5kba
 SEsqRpBhSACoBaO5DCuCLUQDrFGqEIYToE5OiRuV4ReCA/VQ3Qh0AdQxiLH5rgimj8EVbdo5kO
 AQojkEpL/R0zT9AIS4s+DvwEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791186439; l=5087;
 i=pstepanovic@axiado.com; s=20250916; h=from:subject:message-id;
 bh=H2Kq8h0douifAkjifRdGOJ4gqcoHSD4Tn7DkxwchLdA=;
 b=wX8xBYBfB9gE/tgo+jFTQ0IPfTyKyy1oiPwZTZ7DeEKHAwQfZZuKcLLMxxZd4ayC86IdPdxHD
 f8noHGm/JZMCsTPyOE1YuzmkeKotcwu0wHPxXZGibDVAfQFPTnYfwtd
X-Developer-Key: i=pstepanovic@axiado.com; a=ed25519;
 pk=70f1UJOGT9U11ZK6o+ENXtv0I5wBE3e+Y9YWODzRsdI=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|SA6PR18MB6371:EE_
X-MS-Office365-Filtering-Correlation-Id: 51862200-1747-4684-cfa5-08df22b4e29a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|7416014|376014|13003099007|6133799003|10067099003|260925022911599003|260925021911599003|260925021311599003|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	B9aaUQITywit6bSevbMsz7JI5OmfkaOyze+JLb7p+yp2uP7Kh+mI8eJvbpU4F5L2VGNExDnxzkwAl8yQrhjpiFv8Z7GmFD/MMtt19aNC3bqYgh2f2dgLqbxvslaeA1XZHUOyUkL05uTIDsOy9wdEOY89do1aeKX+2sf0dQGg+ZyZG0Kh+BZXi3sv8LTqU3V4SnpO8H/9VcDjNpuofl+kauC7JsfKIZAJ9hQlb6UXnWy1HoWYc2Y89ilyYQ//49MgTukz5VWgdqQYtSyO+Hr4eQkwF0SulwQSdYKaA2+m/WTJDwBSgNsm4bG1Af8Fh9emEUf3VxWf7enzBvTQT80/OU+VCHWpdOH64o4ZynlozOWF3tgIodiNN398y26SRw5IiLjwcxeBj5YQm60MJi8gzB44DL6uqVbUfjOgUa3GU3vtGECI8bj9hNFAVwRlwZez3SJA8aUysBcWrJUy9lBEoYgrFyr0AZSdryKIfl2c1qggaHJ59N1LRnh0zl5M4o8Qzi4lbilr0VSyy5z0IQWD/+u6S4x4NTF2RrFxt1ktPjLD5pNuwPXg9YDx8yCTvhXtv9zCtWsjHIRQAKF+QvHD3X6yKPWZO+2BdQ43L7ATUBtRQKdxD50BrWhOK4ULJOjeIHnhpBnh1oaGvu/1GDx8oUZ94TEvJrumW9FefcIixp8=
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(7416014)(376014)(13003099007)(6133799003)(10067099003)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rB84MfzUwZyOW1sjZhHbXvymoevLJ64qOZHW/n1Ce4oPTrx/mRtj9xWqY3wvTu6BmGDZbdgRan1DClqykhAZGBAy1F8vHLu88x2JCM33tpFChjS3UQsgC6bzrkn0LjYIeKgpnOyw3k4j2x3ew0SaZmi5clbdEwv5ED8Dli4nvrJSJZsZknUI4H1iMAVulyZf/BouMznLT3v42m1HuWoB8hP9kCZsVz0T68QBmjxDj6ZY3eqWhlu/wV4fbJcf1Y5T3nIXp7OnTZcYEH4WLhMfP6eHDvkFXfkvxaAWqYGXO0m2TnKKf/t7XjK6bFwjlxYR6takpGbtFfv4JsAcLzgpzuUIF6KlW+OELgXcNkqIj7aEioua862noMXS566XtVXioSZvDf88GeAvtxzMdXEnyXusAuoYNMxw4lORPMZAmi5KPMI4KSaIl1IOaf4dKnKW
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 07:47:19.9483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51862200-1747-4684-cfa5-08df22b4e29a
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR18MB6371

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
base-commit: 368d34807e6d04bb2089918383b58abf40e720a0
change-id: 20260518-axiado-ax3000-pwm-cd7c346849f1

Best regards,
--  
Petar Stepanovic <pstepanovic@axiado.com>

