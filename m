Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010016.outbound.protection.outlook.com [52.101.201.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5319492E37;
	Wed,  7 Oct 2026 09:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791364098; cv=fail; b=EN8uLvxsz+WDJM1mAeJXZ8u2fJurJdJDer7QAsZ9ATz0qgfhNrBhKyBlYuO9Nwq/uPQVTzVOl8Lu2+9w7mQ1W3suX4lBCwstNsa9Hx4LmrbtaI2FK6TecDOZ/NBP2Pr/joNbGsv//R+gmJzDsetT/BtJ0SEHjttLVSFNztym98Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791364098; c=relaxed/simple;
	bh=ELQML08KwY1xhEmLjIG6zMlOcrq6/pcu3ISZalL0C5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WGU250QCk/uOZ92weGBnFMnfO63hCRckvYOS6T4+m0fpI96eBhasyog62xfr1eCYutsWEXDk0/EkpsOEySx8v/b+tnbNy7EDD5BLrBtdD+93ZD21MKMDx21SASL/0/nizmDiEYTsGwQXqmDtMbqqJ0zxugCrUOE1d3m1fNv0fts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ENxLccG0; arc=fail smtp.client-ip=52.101.201.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ENxLccG0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kRwYIUfAhzAcjzQ8IVq+iHPX80o6euN19iYg+I3sCw0CR6jcFqt9PjqTZbLMv60gvp23cvYOl0aJkYI2fQcDFlyDIqnKAXvwsPrOYcpyqR+83ONywmKp9mvbASaN4Mg/IupczF2NAE1TkpE++aO3ehKRrXts0nh1Mc7nLFSH3TTvw4NqqB7k/xuC9A077wFi/E8iL2S0ZuZnxIj67LM/ddgL9e+r0d/c1HH3rNen8FDNKaWhHCwRpCVipOZ0U8FaGh7DA4d0ihu6UAWMf4rCwiCI9zflNdFReK/kYzw47fnPgYkHrR4o8jXsuL/E0KrbNSknJXMWPLKIsx7fo2wJFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjDUOyfCeG04VvRPAlBztosHf8PIbZwXPZwoOMRybWA=;
 b=J2rpbWNyJ/49jlP8l9phHWmxridc3agijaLNSAjcXVmMklQRYBNdo85w61c3UmYJmghr6rfPSkGJYHIgsGALQfw4hCAwJfr7ynw9PvB2kcnNcry/Qc/fvpyEnCPEh7Kg7lSomK7x/FEAb+NIB543o7NOoK0Qfuh1DfEg8lH2Tt/sIWOVTqEyDIGER8BeXV304STscUXwkdrlwmFXv7H6rnJseJitq1FkDV2xnR8Kqax2enNsKvOjyVoQJelvVaibdd8/ggrjQM5FRkyaDLc9+7m8760Jbox2iWbIFe5uhnLhfbBUr7gxbiEZ3GTJAvFfqzOr/4nXAn7BPgl8PaExug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjDUOyfCeG04VvRPAlBztosHf8PIbZwXPZwoOMRybWA=;
 b=ENxLccG0JvrSMxYbJ247JD76yTu1REWCKsx4jKRA8GXOmwkkOy9RMz+YESI4pMRenDGL4g9+23NS6r3ZF3ACJromK7wImQFS3v3uMfyTLiv2gnqu2OpKKYEMCMrcRflbFNHH2Na67l9JorPZtd/JfRlv3LY649z95H6SDKf/itk=
Received: from MN0P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::19)
 by CH2PR12MB9458.namprd12.prod.outlook.com (2603:10b6:610:280::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Wed, 7 Oct
 2026 09:07:38 +0000
Received: from MN1PEPF000793FE.namprd05.prod.outlook.com
 (2603:10b6:208:52b:cafe::57) by MN0P223CA0001.outlook.office365.com
 (2603:10b6:208:52b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 09:07:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF000793FE.mail.protection.outlook.com (10.167.249.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 09:07:38 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 04:07:28 -0500
Received: from xhdtunimkar40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 7 Oct 2026 04:07:25 -0500
From: Meher Thanmaiee <meherthanmaiee.vanukuri@amd.com>
Date: Wed, 7 Oct 2026 14:36:59 +0530
Subject: [PATCH 1/5] clocksource: timer-cadence-ttc: Move register
 definitions to shared header
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261007-cadence-ttc-pwm-v1-1-52a95a8d98b1@amd.com>
References: <20261007-cadence-ttc-pwm-v1-0-52a95a8d98b1@amd.com>
In-Reply-To: <20261007-cadence-ttc-pwm-v1-0-52a95a8d98b1@amd.com>
To: <michal.simek@amd.com>, <tglx@kernel.org>, <ukleinek@kernel.org>,
	<daniel.lezcano@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, <meherthanmaiee.vanukuri@amd.com>, <linux-pwm@vger.kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791364043; l=3663;
 i=meherthanmaiee.vanukuri@amd.com; s=20261007; h=from:subject:message-id;
 bh=ELQML08KwY1xhEmLjIG6zMlOcrq6/pcu3ISZalL0C5E=;
 b=hQ4O3G3yhmyqGAY2w772TXu38wb/KbqznoS/wYUD7ID4WpNDpw6n4fKRZ40xl3uZSkmA8Kf48
 FhU+vk8ZKlgApVup5e5umgdNGFhFIpUyxYJDg6/hBTdz8fQBWcarJLI
X-Developer-Key: i=meherthanmaiee.vanukuri@amd.com; a=ed25519;
 pk=m/+ON8/+ewj5VLb55p7J9gAopkLKj2mp7iobBZdhi0Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF000793FE:EE_|CH2PR12MB9458:EE_
X-MS-Office365-Filtering-Correlation-Id: c96294e9-aa5c-4419-4e88-08df24526f89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MAjZ0dDswkIU9iENt66wdaOPkR1bEZ0G8l2Psz3wLJAPaq1y5HUsU+tejmSbXVnWR3G2VbVwu3fket6QcDada51Qw5uzLwPllxbweaV9Gf4tKICyHAlvicNk9RgrZyBF06DLn6nnGrn+7f2RnzGacyr4GR8qw42mcfDBrP45R9eEu26CjuDncGTly6nguTu+7Ov5vqqIFG+3ODHs4Tfpq8qnYh88NNmQ1xa1D7mDeLjhGpeKEa9Ysl9bkfNXDFuTJBjBZv5VsWOLdQTPf/V15JMTShE7kYE8QHnvtP++fH6z1kIzoQ8dTpvZv2xMM9SOXZRWvMOLZB2D+KnHzkz66N6/w1dqOsXk7//DL8IevAg+x7orUcX2U9TyxqfsivYfhjJb658xj+nceOqPUtQAmlYtwx0z+NR/Jfv4Eq7HmEFIxt9fjkohnp1mxoIDYk1/t+uJLKO5sqDGoVbtz2TAZ+SEBqd3HsK0TV+/JMojlsFlSfoyIpsUP1B6d9vM1es2gxNyZN3jfnY0pP0308E/SpmOA/XPgZDEzBw4ybbzdi0yCgwDZ6UXVeWBtGmXGSrkYJ2kG3Xz1b845o5cqdL821AkyVxK70vQ6ZDXQw16jUm5HERg/pmkerOKUxJJroYCVFqXYIIJqJNtsfCY1paLVnl1KlE4UkXQsImLHJCcrVnEujf0z9ZqZyMyvwTwZ9gE2Ybh6csNJLZttW1x1sI/9g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5ypmPOsCD0RM9/Nb1/ZTbM+P2lHBfENtiS3bXzpkPkP6HB7V3li2ansj70V32kKqqCaExwPQQiSoynKraf2Gvf36xuBYuXBygEE34SReTgQOkps6FUBNJpNEDbWZDxsSw9OL4vZWvQ9v7SgLt6KZq8UGfBFuQGrRAs0WhLCJiy/0qV3inKppLjY119bkz2r/W0jt8gUe3CbJ0AZ3LTVV+3Rv2++PQbHL8WsDaS3CgSw1j8GQ5Vam2a/t5LTfijHYXr89KSKRawwMeeDiy1CdfZV7I5RCLBXIJmCMOa4HpCue3wltJ3dcoc3F8DbqIeNU1hgWKj+Jv/EwMV7Olv/g0hAydpv+Kv4Mgyj1VwcQOA2nar9dXopM6cGkZtCDxSYkkPV/B5i5sc1njIptQ5h1wRdlp34lE3exsg302NeiQKlDN+6AeN7SQqBWTWEWR3Wl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 09:07:38.6654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c96294e9-aa5c-4419-4e88-08df24526f89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF000793FE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9458

Move the Cadence TTC register offsets and existing bit-field definitions
from timer-cadence-ttc.c into a new include/linux/timer-cadence-ttc.h
header. While moving them, convert bit-mask definitions to use BIT()
and GENMASK() macros.

The shared header will be reused by subsequent patches adding PWM
support for Cadence TTC.

Signed-off-by: Meher Thanmaiee <meherthanmaiee.vanukuri@amd.com>
---
 MAINTAINERS                             |  1 +
 drivers/clocksource/timer-cadence-ttc.c | 18 +-----------------
 include/linux/timer-cadence-ttc.h       | 28 ++++++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 65e8a4b5c90b..b25ad0c18ffd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3922,6 +3922,7 @@ F:	drivers/edac/synopsys_edac.c
 F:	drivers/i2c/busses/i2c-cadence.c
 F:	drivers/i2c/busses/i2c-xiic.c
 F:	drivers/mmc/host/sdhci-of-arasan.c
+F:	include/linux/timer-cadence-ttc.h
 N:	zynq
 N:	xilinx
 
diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/timer-cadence-ttc.c
index 3c50d6892849..8be13d344007 100644
--- a/drivers/clocksource/timer-cadence-ttc.c
+++ b/drivers/clocksource/timer-cadence-ttc.c
@@ -18,6 +18,7 @@
 #include <linux/sched_clock.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
+#include <linux/timer-cadence-ttc.h>
 
 /*
  * This driver configures the 2 16/32-bit count-up timers as follows:
@@ -34,23 +35,6 @@
  * obtained from device tree. The pre-scaler of 32 is used.
  */
 
-/*
- * Timer Register Offset Definitions of Timer 1, Increment base address by 4
- * and use same offsets for Timer 2
- */
-#define TTC_CLK_CNTRL_OFFSET		0x00 /* Clock Control Reg, RW */
-#define TTC_CNT_CNTRL_OFFSET		0x0C /* Counter Control Reg, RW */
-#define TTC_COUNT_VAL_OFFSET		0x18 /* Counter Value Reg, RO */
-#define TTC_INTR_VAL_OFFSET		0x24 /* Interval Count Reg, RW */
-#define TTC_ISR_OFFSET		0x54 /* Interrupt Status Reg, RO */
-#define TTC_IER_OFFSET		0x60 /* Interrupt Enable Reg, RW */
-
-#define TTC_CNT_CNTRL_DISABLE_MASK	0x1
-
-#define TTC_CLK_CNTRL_CSRC_MASK		(1 << 5)	/* clock source */
-#define TTC_CLK_CNTRL_PSV_MASK		0x1e
-#define TTC_CLK_CNTRL_PSV_SHIFT		1
-
 /*
  * Setup the timers to use pre-scaling, using a fixed value for now that will
  * work across most input frequency, but it may need to be more dynamic
diff --git a/include/linux/timer-cadence-ttc.h b/include/linux/timer-cadence-ttc.h
new file mode 100644
index 000000000000..4f2b85e0ff78
--- /dev/null
+++ b/include/linux/timer-cadence-ttc.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Shared definitions for the Cadence Triple Timer Counter (TTC).
+ *
+ * Copyright (C) 2011 - 2013, Xilinx, Inc.
+ * Copyright (C) 2026, Advanced Micro Devices, Inc.
+ */
+
+#ifndef _LINUX_TIMER_CADENCE_TTC_H
+#define _LINUX_TIMER_CADENCE_TTC_H
+
+#include <linux/bits.h>
+
+/* Timer Register Offset Definitions of Timer 1 */
+#define TTC_CLK_CNTRL_OFFSET		0x00 /* Clock Control Reg, RW */
+#define TTC_CNT_CNTRL_OFFSET		0x0C /* Counter Control Reg, RW */
+#define TTC_COUNT_VAL_OFFSET		0x18 /* Counter Value Reg, RO */
+#define TTC_INTR_VAL_OFFSET		0x24 /* Interval Count Reg, RW */
+#define TTC_ISR_OFFSET			0x54 /* Interrupt Status Reg, RO */
+#define TTC_IER_OFFSET			0x60 /* Interrupt Enable Reg, RW */
+
+#define TTC_CNT_CNTRL_DISABLE_MASK	BIT(0)
+
+#define TTC_CLK_CNTRL_CSRC_MASK		BIT(5) /* clock source */
+#define TTC_CLK_CNTRL_PSV_MASK		GENMASK(4, 1)
+#define TTC_CLK_CNTRL_PSV_SHIFT		1
+
+#endif /* _LINUX_TIMER_CADENCE_TTC_H */

-- 
2.34.1

