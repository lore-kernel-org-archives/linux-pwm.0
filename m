Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023128.outbound.protection.outlook.com [40.93.201.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497281D5CFE;
	Mon, 21 Sep 2026 07:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789975451; cv=fail; b=DIyrqi36WdEJJ3a9f4ThkHj64W0z+HX3ivOJyhGzuNHfBcRIXbuKRN9B/ObcRiMzvuFHvc3ty8HIyjRV+7xn94l1QQIrRhZ4rjjWiIxvnrKKJqGCLnnrSqoOJBIuY70sV+qkCyI55F72b6R0RjfPfPdvho0OpHlBLBS1SQEahs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789975451; c=relaxed/simple;
	bh=hO9niCdebu11zVYv8Bw+L6duzPdwLiAq1wsKMNDFxq0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HPfMusHS5+nvwrNEKbe9QDkhbNVVsoohfZd+wX8BVqown9F/br57n7R93bXZFPKIO1eRlJeOQh6sphKeJ4eKnprOdrgDEmz3BD6+SXs1rSD8mudfqDLfJ+Ut/UF9D97o8lCP7nXSoYu8TV1h9UQKU3Chg/mSCo5YUODW15p/n2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=F0qQofxv; arc=fail smtp.client-ip=40.93.201.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="F0qQofxv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvaZmwzmCUDIBMSuUohSDcP0GH53ZQ/asfTfR2CNNHnq/fdODP2Ou7ZOSI6vYAdPk+mv1U0Gex8e0Fpeb2vAosHj0lyNnaVlj2rR/gOOgqZ1IIdly/h9FB9lAcrRkin3ELYHZRgC2vR6us4yuXIsywsVf1Pi9EoB3N9z8XVIyymUyVXg8E0IUMcseiY6eUoNm9ZJ8CxUShI88CgZmlfSwfatPLY4eZY15Ww0rL+sTv140XMJ++oSTxSrmuEYVZmHqHl/rXpYDAmwKQ5b5EGxfZWLpnVEIMJS7ymetodL5NwoZqkA2C/KTDGQ2trmo8YDEFu5c6f4UCyMa9Rx6Ab6Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eR4cOjKmJNHrTajAO1hO6yeFScc484GMA0Gy6dXzDXc=;
 b=XiQeyABf3F/zE80OipwFwGa3s+ZiXx3XOFVkjVvKdPKXmVMAAZ7EnmJ7eUq2fBcEnFprM5K9hwUupTgFG9CKrEj1oAXP9u587/fpZUTMx/NH8sdMPWpcXPEk1a1c11DCk3ee9nLjMmRyQ4prtYVcvuFNjbXpAkn11IXO2IJBMmyVbYXbVku1qA7Pa6W1f0zUh935pfMhqnxpxP8P8NbAP7GYfJx5xWRw42nT2SghnyNRt1a+YfZ6DYsMikpfjrzvWCxjWiG0XEkhqtMxo2bIH0yqDy9hCBmrxGXd+Qh3i9W4yQDPEF3VrdTpnhS7qKs1dozzCcUJEZThHlvcW3PuEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eR4cOjKmJNHrTajAO1hO6yeFScc484GMA0Gy6dXzDXc=;
 b=F0qQofxvcft0RQ7Uuvlu/k8urEwvf9pm1Zt+E/iOruS9NDJoGxWSIKWhZ5Ie/HjODFFezixNBbkd+PWIyGEun7QvEw1/IH6hUSC8+nWYv4gmwMkVPA8S5PG/wM/AmEEq2MCi0uXXx6Fidhj0vLzjiSOJhqRhgz0KuZhBHiaw3YKcfqE23he/BSqPsLCoR0XWDrm1QK8CllP8kQA/L3KY+rg0Fege7JQJ5AaHEj47HpxjotIyUvKkPdbWqJVXZWpe9IFfz9zrMRpY1XLWg23gnHbnrUsi/OVtUlgobwCFpFv4HvNbDD2DgrO1T2QcNAYO5MLb7NYlsUVhtEO+m1iKKQ==
Received: from BN9PR03CA0798.namprd03.prod.outlook.com (2603:10b6:408:13f::23)
 by SA3PR18MB5601.namprd18.prod.outlook.com (2603:10b6:806:3a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Mon, 21 Sep
 2026 07:24:00 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:13f:cafe::99) by BN9PR03CA0798.outlook.office365.com
 (2603:10b6:408:13f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 07:24:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Mon, 21 Sep 2026 07:23:59 +0000
Received: from axz-uw1-build-vm02.corp.axiado.com (unknown [10.14.1.22])
	by smtp.corp.axiado.com (Postfix) with ESMTP id 403A04186B51;
	Mon, 21 Sep 2026 00:23:59 -0700 (PDT)
From: Petar Stepanovic <pstepanovic@axiado.com>
Subject: [PATCH v3 0/2] hwmon: add Axiado AX3000 and AX3005 PWM fan support
Date: Mon, 21 Sep 2026 00:23:54 -0700
Message-Id: <20260921-axiado-ax3000-pwm-fan-v3-0-3def8b6ffec9@axiado.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIvbsGoC/3XNwQ6CMAwG4FchOzvTbdiAJ9/DeBiskx1gZDMTQ
 3h3BxyMB07N3/z9OrNIwVFk12JmgZKLzg85qFPB2k4PT+LO5MwkSISLBK4np43PQwEAH989t3r
 gCnVVG0LToGD5dgxk3bS590fOnYsvHz7bmyTW7S5WgAdiEhy4zWDZWikQm9veO7e+ZyuZ5I+pQ
 R0xMjNkS2VsiQIV/THLsnwBx8sKKAIBAAA=
X-Change-ID: 20260520-axiado-ax3000-pwm-fan-36a89de6db61
To: Petar Stepanovic <pstepanovic@axiado.com>, 
 Akhila Kavi <akavi@axiado.com>, Prasad Bolisetty <pbolisetty@axiado.com>, 
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Tzu-Hao Wei <twei@axiado.com>, Karthikeyan Mitran <kmitran@axiado.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org, 
 openbmc@lists.ozlabs.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789975439; l=3765;
 i=pstepanovic@axiado.com; s=20250916; h=from:subject:message-id;
 bh=hO9niCdebu11zVYv8Bw+L6duzPdwLiAq1wsKMNDFxq0=;
 b=r5W3mfrpb0ImL3IN9fBmbj1hCwQHqB1CUz4MzF0qkSEaLgZ7SkS9KbXBQjt9uQnzKD7cpW+bR
 3EATpwTg+EODi4ZFi7P4NohCeVNt8mF40crQgOP1gmp4My0/iBXqOmv
X-Developer-Key: i=pstepanovic@axiado.com; a=ed25519;
 pk=70f1UJOGT9U11ZK6o+ENXtv0I5wBE3e+Y9YWODzRsdI=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|SA3PR18MB5601:EE_
X-MS-Office365-Filtering-Correlation-Id: a5916df2-5713-48ca-1acd-08df17b14e60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|7416014|376014|1800799024|56012099006|3023799007|10067099003|921020|13003099007|18002099003;
X-Microsoft-Antispam-Message-Info:
	mCkFPTzh/iTqY2hHWKwlXLn5Y2s6baVKXhAsPbyOz3s4xJShjh8CYrxTzDl51Iec88zAarqMFgJ26bKo0CppvHbtEjYeobtwnOWoYHQ6lCXpa8w68/GOuhj+KzFZXcEpf2/mg66jjDaRzMuFXGSwKRVfuaHY2n672pceM8HEJi6rS1f+k5qdIUj+dCdx8xvD1x7MtMtrl3BsF4cy2wtVw4c8bIK1qSrqzueGqmsKeASU2tdUprl+0LcS7sykdrsEXUXtUzxn/4GGPO6PwmQFuY1Zp24QIi4isEjak4qbdZQSMp6ZKGdBkHi7i4k2igPcRCwrmhMiFTIKvdmm2g/r8tTe0DlrEYegB95RH0wlUmCsO2KFGmnDX5aGNVgR2sID+13CpQWpm2aii1w77cKzoXOilfy/S2DVfxdvQskFnt2l2GdtSyqkBrdpJpWKGwxGRiaJTI8YVBZTxnaMu1KbzzdyzeYOq4sI9kzbUmUOhwTy2wDNCl03jSA92Rvwco35Jt/bw3fZTjr4KrThDeupLaFjcC3hjOCwRgXm0xFIWO5Hk2B50lkSvCZfO5YXY8uH9t5eYTNxMkxRPAN0ccS8TcT3rdFn0SNkpORGiZLf32HrZ3XDQo9QTuCdds1aJrx337dIxCmJyLuABDuWWjWAdXP/jawICLwre9S7n1/BRSRgOG+sY+NlCk9qqW1ArO0Lhghlku66SuyriBY8Da+p+A==
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(7416014)(376014)(1800799024)(56012099006)(3023799007)(10067099003)(921020)(13003099007)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Vf3wMXZgNeutLSB2DnxuNRdUc7TmKO1H7A8BbWl2IHXXBce2R/e1sFrmOmzhXYfL3k1a5cPa54RmUwFEMEBF81iiZGTbjrvOCF2chlbdnboMKQYq7jSr42g74sYf1sq9wHaiHvvbqBpkiSA0T4jwQFuw6A0cSsDl+gSR2Bq+9XtMrengwzpuV7kk+L9ckNLW00UHogKXNkmRJ/VEcOr1jZVvzpfCER7hjVOHppuLIujZRHSuwh09neshwda36DOEKemd6XqnTnKIEKNSFFT07waNbONmb/cDV0uWNFEFpc8wYvN1xyGAkyGPKGqOyUn3bBzOcOSYgnDjPo1W2vAbQ5R55cY+MAvesqlL0RKES5LrWHdmlUEJBBWca2HIx9PcFd2fXATr0tnMS2DERLEJCwHnA/kKcedkkR1Ccd3y/0dysMlQBe7xaUilnQmpgMhG
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 07:23:59.9798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5916df2-5713-48ca-1acd-08df17b14e60
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR18MB5601

This series adds support for the fan controller found on the Axiado
AX3000 and AX3005 SoCs.

The controller provides a hardware tachometer block for measuring the
rotational speed of one fan. Fan speed is controlled through a PWM
signal supplied by an external PWM controller.

The tachometer counts fan pulses in hardware and reports the accumulated
count through an MMIO register when the measurement interval expires.
The generic pwm-fan driver counts tachometer interrupts in software and
therefore cannot directly operate this hardware counter block.

The driver registers with the hwmon subsystem and provides the
following standard sysfs attributes:

  - fan1_input for the measured fan speed in RPM
  - pwm1 for fan-speed control in the range 0 to 255

The number of tachometer pulses generated per fan revolution can be
configured using the pulses-per-revolution devicetree property. If the
property is not specified, the driver uses two pulses per revolution.

The series includes:

  - Devicetree binding documentation
  - Axiado PWM fan hwmon driver
  - hwmon driver documentation
  - MAINTAINERS entry

The driver was tested on AX3000 and AX3005 platforms.

Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>
---
Changes in v3:
- Check AX_TACH_INT_PENDING before claiming the tachometer interrupt.
- Keep the PWM enabled at 0% duty cycle so the PWM-FAN output remains
  low.
- Use the actual PWM enable state when checking whether the PWM is
  disabled.
- Link to v2: https://patch.msgid.link/20260903-axiado-ax3000-pwm-fan-v2-0-ef43df46163e@axiado.com

Changes in v2:
- Represent the physical fan as a child node of the tachometer 
  controller and reference fan-common.yaml. 
- Move pwms and pulses-per-revolution to the fan child node. 
- Update the driver to obtain the PWM and pulses-per-revolution 
  property from the fan child node.  
- Rename PWM_MAX to AX_TACH_PWM_VAL_MAX. 
- Remove unnecessary locking when reading the cached PWM value. 
- Remove the trailing comma from the OF match-table terminator. 
- Fix minor formatting issues.
- Link to v1: https://lore.kernel.org/r/20260806-axiado-ax3000-pwm-fan-v1-0-f6db4cf2166b@axiado.com

To: Petar Stepanovic <pstepanovic@axiado.com>
To: Akhila Kavi <akavi@axiado.com>
To: Prasad Bolisetty <pbolisetty@axiado.com>
To: Guenter Roeck <linux@roeck-us.net>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Tzu-Hao Wei <twei@axiado.com>
To: Karthikeyan Mitran <kmitran@axiado.com>
To: Jonathan Corbet <corbet@lwn.net>
To: Shuah Khan <skhan@linuxfoundation.org>
To: Uwe Kleine-König <ukleinek@kernel.org>
Cc: linux-hwmon@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-pwm@vger.kernel.org

---
Petar Stepanovic (2):
      dt-bindings: hwmon: add Axiado AX3000 and AX3005 PWM fan controller
      hwmon: add Axiado AX3000 and AX3005 PWM fan controller driver

 .../bindings/hwmon/axiado,ax3000-pwm-fan.yaml      |  72 ++++
 Documentation/hwmon/axiado-pwm-fan.rst             |  38 ++
 Documentation/hwmon/index.rst                      |   1 +
 MAINTAINERS                                        |  10 +
 drivers/hwmon/Kconfig                              |  12 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/axiado-pwm-fan.c                     | 416 +++++++++++++++++++++
 7 files changed, 550 insertions(+)
---
base-commit: 28807a684f870463e059fbc8cb22f5b780b94fe4
change-id: 20260520-axiado-ax3000-pwm-fan-36a89de6db61

Best regards,
--  
Petar Stepanovic <pstepanovic@axiado.com>

