Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020114.outbound.protection.outlook.com [40.93.198.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40507442FD4;
	Thu,  3 Sep 2026 08:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788424737; cv=fail; b=Fx+rYzyuKBTyUw0uXMGffGtiJf30CPMozNCEvc+2qwS1xA46AXKhOUAOM+dcx1h1lD/7+KNKNEabRQHEBzDOGJMqE1JNeRpw9FU1xhXjxXiMVvn38XPGQteOOmU2ZT24/f6NzTi2jAvVh/AhxVCt0bEyZ9i43LgDK1VI8x9pOPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788424737; c=relaxed/simple;
	bh=0biORINxenIWidbUx4xnKlZ9WpZ01AHkHaOslYvDE00=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=p7usenO4BAIAnIlwUicCvp3GtjcI+5ZTiRikM6rqGjsoe7TQ+pOogURzoFAtolRDR4UGoXH9uj68PUuqYt4d69Bc4iAL0WIC4C43Xjxfc+Z3FM6Wyyz9rcp5EWO1/sOHLJ4Ss+F6O2XTANZ+M6nKUExqcEpQTBgyO/3A9zp97N0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=BiedX/F6; arc=fail smtp.client-ip=40.93.198.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="BiedX/F6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMEAAFXNG8IY1NP9ylGwk6Xj370A3XY3gfUt8fzE0uhm0Tulp1PP1zbeRn+9piAwzgwm3nZlUQDoda0NOIWjQ1b2xI5gzevxuEKI/1E8ZrSfYdl/r21vQ2IdIk3SBl9d/XqDLPdHjNfswzDFUKtT78Tz0oVZAQqNK4riAx7SY4B7OGNbbbjwcfJ/S2vqZz9VNuNUiSl3EVeRpNZne7YENmNAPOgh5FJTJeZavqmxfFSuo9Bn/WIplA85cOqyCLJGi7RoqFLn7gGn+gbkhH1XeRYwBYKP45388xL3qMXsfDiUBtBg1UovfBn3vicNs9QqcikTi4xqWKt6k0aUd3pweQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9ezJFL4KMnUCUV31nLlX7gzBOJI4SelpaoBkq/V2/c=;
 b=uSTcNZqzLE9TeIi63UyYl+0GJM/MI7JfU3tYgdkAdHmPTmLqDHCsHPxr+uUGISyHnaTfygljkBS59CktfkOvqYaNtHFgY53c3yvCd5TrSTGZbz3X87dciKiSDVX4qC3dPb/70NjUYDoGglyPlXeCzH07dL446sgwbIIM2GdPoo+UeFOyGHpTi/d25c6fVf+2COLHSmFbP+H8fe3DAAlsDqQjIZd7bUvRGJ4FawyDw5GUj0AgUYDYsH54fjibJSrsRy0ugbnx8U77nyeBrMVC/aTNz+4Zi5xjplLN3fDAa6TzXy8eYvPnT0CAt+D6v5+chxyA7pd9hQC6uoM0TUp/QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9ezJFL4KMnUCUV31nLlX7gzBOJI4SelpaoBkq/V2/c=;
 b=BiedX/F60cRRK575QdUH/T/DpXALxIQqWNHsKzbOg2URgYoj/lxKysvQwnckFDA14s+rqA4E4oWVzx7Sjg58vO1MK7Rm7SeMuBl2FOraSIfffFGmfHZMVTmk2TANdpSNwhNWyciGdpn3vQm+34JIcjoI7aUNjb/b1cQRW1X8z6ReWkaNjVIwMWbEwXFuoprP7TUCZY+kNdDhbdaAk4AkrBaK4aj2n2C+YuG3dMBRVF/q5+BLK3yf22vDK3+5PbMtkjYV8dMVIkdp7DcFOUX8WKsgICwxK+IlfqaYcGPqyZVPzVB9wcTC+fl5cx5lHssGXRBg3X5BhdyDu0hRNJUW0g==
Received: from BN0PR04CA0074.namprd04.prod.outlook.com (2603:10b6:408:ea::19)
 by LV3PR18MB6349.namprd18.prod.outlook.com (2603:10b6:408:26a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 08:38:51 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:408:ea:cafe::29) by BN0PR04CA0074.outlook.office365.com
 (2603:10b6:408:ea::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Thu, 3
 Sep 2026 08:38:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 64.62.143.114) smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.0
 via Frontend Transport; Thu, 3 Sep 2026 08:38:49 +0000
Received: from axz-uw1-build-vm02.corp.axiado.com (unknown [10.14.1.22])
	by smtp.corp.axiado.com (Postfix) with ESMTP id ED0AF4186B51;
	Thu,  3 Sep 2026 01:38:47 -0700 (PDT)
From: Petar Stepanovic <pstepanovic@axiado.com>
Subject: [PATCH v2 0/2] hwmon: add Axiado AX3000 and AX3005 PWM fan support
Date: Thu, 03 Sep 2026 01:38:38 -0700
Message-Id: <20260903-axiado-ax3000-pwm-fan-v2-0-ef43df46163e@axiado.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAA4ymWoC/3WNQQ6CMBBFr0Jm7Zhp0Qm64h6GRaGtzAJKWoMYw
 t2tsHY1eT//v1khuSguwb1YIbpZkoQxgz4V0PVmfDoUmxk0aaarJjSLGBvyKYkIp/eA3oxYsql
 u1rFtWUHeTtF5WXbvo8ncS3qF+NnfzOqXHsaK+I9xVkjos/DSea2Y2/ronbswQLNt2xcLp8PBu
 wAAAA==
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
 openbmc@lists.ozlabs.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788424727; l=3416;
 i=pstepanovic@axiado.com; s=20250916; h=from:subject:message-id;
 bh=0biORINxenIWidbUx4xnKlZ9WpZ01AHkHaOslYvDE00=;
 b=SpVawK7uxO9lUp16MSINq6DksDjkjPbxWOh60c+LHVBL+enVzE5mm5QBxQCP1EmhKb5+RQlI/
 p+Ngl05LjgRAkWHuTRkMuuzThqTurjx3ytRFBIiiIiYESrqSyg1gVhR
X-Developer-Key: i=pstepanovic@axiado.com; a=ed25519;
 pk=70f1UJOGT9U11ZK6o+ENXtv0I5wBE3e+Y9YWODzRsdI=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|LV3PR18MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: 528a7a4c-3eb8-4274-fac8-08df0996c6b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|82310400026|36860700016|1800799024|921020|10067099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	JgRnQF4NWhzAQegmvhshQbxW3vCat/VRXbee4xm9XYmCYaEB38foaEKu838uyzvpqE+C37lneqkM2nstS7X23LAmjS9gCBZJc9wpOCp7SbRWjVw8v4Cj9CNRrI60CDls91/v3LfuHTuNZWjSoIaDVCeNQ+H6YoI8KHyGEoEa+BblNfrgRjagVmPf6fENnVCzvjDMuaxlaAA4BjkTPFFOGoxkI5oXUSJ8N2Ie4fFzwxQJ5ZZBNs7eje3uE/a3OPt5mC4+dgHsZGviOR7n0prO7PppUN5Hcih13+FSll7FaiqxHuh/zFkjIX1dzfbMJuxhQ49eGc848tPhTTHgvEJ/7+9+Q6AgFhv6xahsbHSwdtCl41oue/sm7gBfk3Mxt/1ACCiYIovPeor034S3nxN24WtpqvqJfIIWudSb07o0AuFvijRJ50p/CLjIJ9/QyPVNhs2y3rR9q3vgCPg4DzUTuL5IQHfal8exjOpwR5roMXvCGNbKx0+BrLceed/HXe+X9eoZ8N5TIOJtWJoFSK7PFrfbUAdoZqgmA/nW81ehHp8b9LpWOf/Fi5l0Lp6u/YALsDO1jXkPJMWdtRukXb+l0h7d5JVFmTeZVAWZX3olKy/6E95/z/DFKlAIEOY3GnKgXx7krstgLBGNiQhz2JMkqZJ4zoRRfQXqWBt8C02JFqgIabB/luU84Gmuh/cfhU2XY8udLjBOWGmTVFgRpj7hj/wIo3qHc/lfRZ6GYQhKH/VJmrF/iE8XMvW8oO4dX1fF
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(82310400026)(36860700016)(1800799024)(921020)(10067099003)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	y57G+u67mxxdSi7oMZdPpbV0zLYID3eMHDeaK2ess7UpyCxmILWXrhsrsjggDKySIN8Am01tPDfgOgqyMpCF5I06GZxIihgO5tpzjif5r4RDpUV9FHAnQO4KbX7APr8bVtbJLxt5+1xEKZdhxGj0PVzwWycZQ2JOQT83Hhtop+RKbWLaK0TvbH+gPZ8gQH3XKGiWKltouoXWn/50IbJ0EU/MMYzqCCaDvNfQk6ez2JaJWiQ5NzQYNsjTdcFFNMrJdt6q6qOu9u3sm7gfC1TClRhSvkfasMHTRIHTpmAU1RSm+MYfljpozyC1hGs/tBOvXL5+RWKm8PHs4ColSumndbrdwPrAxJPHsBzfegDP3lbSR8vy+OGvQp8hmivBekyVcHonCtoYfsRI55tsfecPTDeydGoWBegFstoTgTqLb/T7DOhQgbm0ex+Iq66ubymg
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 08:38:49.1598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 528a7a4c-3eb8-4274-fac8-08df0996c6b2
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB6349

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
 drivers/hwmon/axiado-pwm-fan.c                     | 412 +++++++++++++++++++++
 7 files changed, 546 insertions(+)
---
base-commit: 28807a684f870463e059fbc8cb22f5b780b94fe4
change-id: 20260520-axiado-ax3000-pwm-fan-36a89de6db61

Best regards,
--  
Petar Stepanovic <pstepanovic@axiado.com>

