Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795005779;
	b=gV4LbnSn4+4J1tY3ZkHg/CUJJtdckb/GK6asSNl634ctI2/CtmOk1W0nNizxCreb8fPL
	 LzzQ1STMmUAQKdj0d6nWpPL0L1DcoCsHXoPeYHKpNuCN0obAT2ykntnts5GTzicLrpq/4
	 h2a4eYtU6D3ZO9iShJNSAE098mZ6errQkYI/OBznjCrQpXjD8l0OghVH9nX3nVEYWLOFu
	 jyEmpfeXaDKCaOCoceuSsPJJ3f99YBsvipg7HpAPjcLzVs6GXpKjtrR2FzoTn/yxDVyTn
	 LlYCd2+wTJ/lqGl4Hcz4XLd6YBKKqSaZ1P027Fjy5cphmD9pvq65abRIlcr0QD7ytrw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005779;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
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
	bh=HZMOm20gFH4toRjNeRgUEuNleU7M2bR+o6n1w6S2un0=;
	b=eE8AxC9jYOsMOKaXR1xcC6KD66BaoXla0rEVw0mfVPo/Mf0DwNtTvuLMdzKcSw34uyWt
	 1sruI/GdQa20AaQmM4FChxUPEDPVTqoqhYol51sR4UdqI9NuDDcaCe9exFjEuK66kn5kE
	 zNHycxlJyITx0MJ5/xOMjvDCQwiI1rhXDmcmt2hblGjAllNrM5Juxd5mzA+4LnZyTnlTs
	 t++imqyq162wbkCiwx53WPv4leJGsOTZai8Y0E/heNxYp9XRiTieFGUa6YBRNERry4mCI
	 K7CPYRnnt9L4jiJY77gZP8ieDwX2bsFjLJ7TLVJFUxDaLC65sTFsct5SSCjaPE6JCwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=axiado.com;
	spf=pass smtp.mailfrom=axiado.com;
	dkim=pass header.d=axiado.com header.i=@axiado.com header.a=rsa-sha256 header.s=selector1 header.b="B/P5acUu";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.77
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020077.outbound.protection.outlook.com [52.101.61.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CDE60A2617;
	Wed, 18 Nov 2026 12:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42CDE60A2617
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=axiado.com header.i=@axiado.com header.a=rsa-sha256 header.s=selector1 header.b=B/P5acUu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xd9LDBrniPiapeHzOvtAyJqoXl1cg54AmyB2ZCKjZjrFlIusb0vgs0SYC4nu3ManV3OxCPHz1gRCZLfV3BulvZvmo4nEnm7FfH4JlHfBopZ9F2fjKinvdEY8r6Ox4eIJMlurzH49BLMO5lC3a3ARIo+rHhzu3FbrkL40bTDsRG5mbXv7Kw57DeROB3CCHo6lqIsDsuRIzqAibgCC9kDPc/ke/1UmVh/j/e4JFYLgOOxMHNfMlC2VOfocbx2z2USTiq0/G85pmUpeRur15d5ztJElpOdqW+H2sD2tpEDL+dfwIu7dl7s8/f3IkdzGzCMDaYPTIUG8eOwNZCfzkFK88Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZMOm20gFH4toRjNeRgUEuNleU7M2bR+o6n1w6S2un0=;
 b=Fy+lqLocsxNUcndq81saepnwK0uCMgmROc7aXevDoDk6tSwWJek0xD5YCGF/b5r76D9vZLkpoFdl+kGw63pdpyX/eOJUp+TyAih/AmMGHI/xndnOPcB+0v7p8tNpTrB4QQz8WWnhlr9xwiURlNylRigo2e7DljKTL2PYDSYJnXIK/2ECsidr1Dtrg2O4qtrVS1jWUus6R7E4j3ITdZIQziLKGvCYDbFJlE1uLS0FY+00MwD6VbSsRTL90PQXds7hyJXkgRx33HgJGa+GV9J/EJ6isphhLCQP6ASwbEpgkKzGLoMLBCe9IhvxnfIg8g8N012gapT2VqEknO64epypUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZMOm20gFH4toRjNeRgUEuNleU7M2bR+o6n1w6S2un0=;
 b=B/P5acUuO/uQCkcGrjA/dtQl7JpuaLitzm3U4yRLrkcQ+i4jDVQ6rM9XqdvJHmsfLKKrLsm3D+ZBAvVIYL5t0+znZV5u4h0ZbpEEx27v5IcDa3SBoeuDYOzqbX2zM6AyvOT61JWHSjP46VgwqTQrS09ygSc7lm3jYoZnlSwBM9ic5gVRLyyqQgWOm4mO6z52gZ8k/gmfH1NjKYdu8H9H9oIjZvm3vJE6MC1eVCHLjToY9ejj1eqdgqYzVizfpLEN6pMkgvkIdnhO4POkBhyHGzYFWoSMHijN3fCsZA1Vg5fGjybABuzA6YypVXAfpU5+RNgRHNoLK8p5UIrCNSECCw==
Received: from CH0PR03CA0280.namprd03.prod.outlook.com (2603:10b6:610:e6::15)
 by PH7PR18MB5130.namprd18.prod.outlook.com (2603:10b6:510:159::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 12:42:17 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:610:e6:cafe::1b) by CH0PR03CA0280.outlook.office365.com
 (2603:10b6:610:e6::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 12:42:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 64.62.143.114) smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.0
 via Frontend Transport; Wed, 18 Nov 2026 12:42:16 +0000
Received: from axz-uw1-build-vm02.corp.axiado.com (unknown [10.14.1.22])
	by smtp.corp.axiado.com (Postfix) with ESMTP id B75604186B59;
	Wed, 18 Nov 2026 04:42:15 -0800 (PST)
From: Petar Stepanovic <pstepanovic@axiado.com>
Date: Wed, 18 Nov 2026 04:42:15 -0800
Subject: [PATCH v7 2/2] pwm: add Axiado AX3000 PWM driver
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-axiado-ax3000-pwm-v7-2-bbd21a8cf861@axiado.com>
References: <20261118-axiado-ax3000-pwm-v7-0-bbd21a8cf861@axiado.com>
In-Reply-To: <20261118-axiado-ax3000-pwm-v7-0-bbd21a8cf861@axiado.com>
To: Akhila Kavi <akavi@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>, 
 Tzu-Hao Wei <twei@axiado.com>, Karthikeyan Mitran <kmitran@axiado.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 openbmc@lists.ozlabs.org, Petar Stepanovic <pstepanovic@axiado.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795005735; l=10793;
 i=pstepanovic@axiado.com; s=20250916; h=from:subject:message-id;
 bh=pTsazFuEWX/eyhXAPbu9xJQ5lD2CMQPNNZ74sJc1A6g=;
 b=W12NBH9+dwc+9S5d/2TH+IFJlm/s0B+cH+okjhknCwRbsy5zF4mj0O0jSrUbGenrskjd0AGey
 uRc6qJ94TS1DDUOb8Gf9A7ybcdHvwaFRBjtZXKA79gMZhAoo6RWdfgK
X-Developer-Key: i=pstepanovic@axiado.com; a=ed25519;
 pk=70f1UJOGT9U11ZK6o+ENXtv0I5wBE3e+Y9YWODzRsdI=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|PH7PR18MB5130:EE_
X-MS-Office365-Filtering-Correlation-Id: 0355b3de-5420-4a12-2dcc-08df457160b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|261102123227099003|56012099006|261026140227099003|261026121527099003|10067099003|261022113327099003|261022105027099003|261021123027099003|261022075727099003|261028144727099003|261021121427099003|261009223027099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	OU5C/AnuTOZYlK4pjjnYHay0f6YaPt7mqlMsWkAbrnZkifjuM8QX1aUlSh1PJlaTxD1bdyI2pzPZMSKvAGCfDIizLBsvtUyhdf5o7DIPuG6FeN1+Q10xLfj0vQ+BAj7H5QzBtyhyzkd1b7zVfSKf21eWcWdjM546jS6/PhwOyW1OPoaKroY8YlGFCCiGsbvewVwGVc4fcS+cFLwSneTjSOfe6XoguvNdPPe9XAXdRHpauXx8GdUjUHzl7YsCGUnAwCHpFFKrpSUawHcGQobujkDDST8hoszshBAuLXOsG9sHJlwL0APhhh7ctbc3Egu3ybO6iT7jWZ68YNsS6qGIvUy6OKNdyizXJCAIyFJoBuMMBSRwIgTYwLN98o3nVJcgzfv1by4mIYEepY6lhqbc9FqHswn50wXty0EMtbmJVvCXJS5rF8n9HgXnbwIoPS8khNQ/IZQRl+arX4eii23O71Ne69A2FWf1IA9HH4f6WY35nc0I/m1qDKeBwSuyVhy673BzU8nnjadL4Ntys2WNxEHVLxCRXNfQLR71EWiGuAX14KgdTdFk6nHnlWu4N3vYtIkGbftO/uOB82vUfLBzxO9Z1jRh7eV8WeRQU9Du8v1CVUp/s07jaE9a3tpt0umJneiZ+C8npE1lZIH+PlKFiY7GVIeEHEK39l4UdrVcjj/fQUWQQyMgaJoAN8aBjZ1J5HXAqovbCvAL5nS4cqLi3Q==
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(261102123227099003)(56012099006)(261026140227099003)(261026121527099003)(10067099003)(261022113327099003)(261022105027099003)(261021123027099003)(261022075727099003)(261028144727099003)(261021121427099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5959gUQwItvz4xoNbaZSg36yHDvrHgGHmxEdwxyVTTb9UW03fyR5G9r95HI72doi+dWXGDDBBqokObgccbZYFz0m2LalnOwx2nXAuPqDWV3UDlFSq+jouRJe+DXspxMO7C7d5+tQ9IqTOBBhYRL7YFEXp/e1l75Lsj1v/s2bLm5NJ6BqX2QBcgw11xHZ0MeFYDfIQmEKERBB5CXxn9kQmbVYz0QzsU0V32OBsjrXLDJQhUwui7/8c23WXCKKu2R648rySVqRlQ/bdMi8ml8vv8TNXMoNKyZlV5ZbJ7kBsTczq6najiZ8aM5dteoXrIDP9r5zyMsZeFgsXdULF8jlDP705znQuSKgZyO4US2hmtyjnpBgDY40WMCNrV6dTXNfd2nPBz/O3q98Qu0rEOHWiEYiYHKSXoWBnr8gXaDCkzLATO9CpRk7iznXRz9y6ChK
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 12:42:16.4106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0355b3de-5420-4a12-2dcc-08df457160b3
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5130

The Axiado AX3000 and AX3005 SoCs include a single-channel PWM
controller.

Add a driver supporting period, duty-cycle, and enable-state
configuration through the Linux PWM framework.

Disabling the hardware controller drives its output high. A 0% duty
cycle is implemented using the controller's constant-low encoding,
because a zero high time is interpreted by the hardware as a
constant-high output. The constant-low state is reported as a 0% duty
cycle with a one-clock-cycle period on readback.

AX3005 uses the same programming model as AX3000 and is supported
through the axiado,ax3000-pwm fallback compatible.

Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>
---
 MAINTAINERS              |   1 +
 drivers/pwm/Kconfig      |  11 ++
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-axiado.c | 282 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 295 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe85aaa5a7eb..c148c9099045 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4562,6 +4562,7 @@ M:	Prasad Bolisetty <pbolisetty@axiado.com>
 L:	linux-pwm@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/pwm/axiado,ax3000-pwm.yaml
+F:	drivers/pwm/pwm-axiado.c
 
 AXIADO SARADC DRIVER
 M:	Petar Stepanovic <pstepanovic@axiado.com>
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 729776086879..3ea749d83272 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -129,6 +129,17 @@ config PWM_ATMEL_TCB
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-atmel-tcb.
 
+config PWM_AXIADO
+	tristate "Axiado PWM support"
+	depends on ARCH_AXIADO || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  PWM framework driver for the PWM controller found on Axiado
+	  AX3000 and AX3005 SoCs.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-axiado.
+
 config PWM_AXI_PWMGEN
 	tristate "Analog Devices AXI PWM generator"
 	depends on MICROBLAZE || NIOS2 || ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTEL_SOCFPGA || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 5630a521a7cf..434d913cfc79 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_PWM_ARGON_FAN_HAT)	+= pwm-argon-fan-hat.o
 obj-$(CONFIG_PWM_ATMEL)		+= pwm-atmel.o
 obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+= pwm-atmel-hlcdc.o
 obj-$(CONFIG_PWM_ATMEL_TCB)	+= pwm-atmel-tcb.o
+obj-$(CONFIG_PWM_AXIADO)	+= pwm-axiado.o
 obj-$(CONFIG_PWM_AXI_PWMGEN)	+= pwm-axi-pwmgen.o
 obj-$(CONFIG_PWM_BCM2835)	+= pwm-bcm2835.o
 obj-$(CONFIG_PWM_BCM_IPROC)	+= pwm-bcm-iproc.o
diff --git a/drivers/pwm/pwm-axiado.c b/drivers/pwm/pwm-axiado.c
new file mode 100644
index 000000000000..08ae3d8ed4bb
--- /dev/null
+++ b/drivers/pwm/pwm-axiado.c
@@ -0,0 +1,282 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * SPDX-FileCopyrightText: 2021-2026 Axiado Corporation.
+ */
+
+/*
+ * Limitations:
+ * - Only normal polarity is supported.
+ * - The hardware has no shadow registers, so configuration changes take
+ *   effect immediately without waiting for the current period to complete.
+ * - The output is driven high while the hardware is disabled.
+ * - Supported period range: 2 through 0xfffffffe PWM input clock cycles;
+ *   0xffffffff is reserved by the hardware for a constant low output.
+ *   Longer periods are clamped to the maximum.
+ * - A 0% duty cycle is emitted using the constant low encoding because the
+ *   hardware interprets a zero high time as a constant high output. The
+ *   requested period is lost in that case and is reported as a single clock
+ *   cycle.
+ * - A 100% duty cycle is supported and emits a constant high output.
+ */
+
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+
+/* Register offsets */
+#define AXIADO_PWM_CTRL_REG	0x0000
+#define AXIADO_PWM_PERIOD_REG	0x0004
+#define AXIADO_PWM_HIGH_REG	0x0008
+
+/* Period and duty cycle limits */
+#define AXIADO_PWM_PERIOD_MIN	2
+#define AXIADO_PWM_PERIOD_MAX	0xfffffffe
+#define AXIADO_PWM_PERIOD_CONST_LOW	0xffffffff
+#define AXIADO_PWM_DUTY_MIN	1
+
+/* Control register bits */
+#define AXIADO_PWM_CTRL_ENABLE	BIT(0)
+
+struct axiado_pwm_chip {
+	void __iomem *base;
+	unsigned long rate;
+};
+
+struct axiado_pwm_waveform {
+	u32 period;
+	u32 duty;
+	bool enabled;
+};
+
+static int
+axiado_pwm_round_waveform_tohw(struct pwm_chip *chip,
+			       struct pwm_device *pwm,
+			       const struct pwm_waveform *wf,
+			       void *_wfhw)
+{
+	struct axiado_pwm_chip *axpwm = pwmchip_get_drvdata(chip);
+	struct axiado_pwm_waveform *wfhw = _wfhw;
+	u64 period;
+	u64 duty;
+	int ret = 0;
+
+	/* Encode a disabled request as a zeroed hardware waveform. */
+	if (!wf->period_length_ns) {
+		*wfhw = (struct axiado_pwm_waveform) { };
+
+		return 0;
+	}
+
+	period = mul_u64_u64_div_u64(wf->period_length_ns, axpwm->rate,
+				     NSEC_PER_SEC);
+	duty = mul_u64_u64_div_u64(wf->duty_length_ns, axpwm->rate,
+				   NSEC_PER_SEC);
+
+	if (!duty) {
+		/*
+		 * A zero high time makes the hardware emit a constant high
+		 * output, so use the constant low period encoding for a 0%
+		 * duty cycle. The high time must stay non-zero because it
+		 * takes precedence over that encoding. The requested period
+		 * is lost, .round_waveform_fromhw() reports a single clock
+		 * cycle instead.
+		 */
+		*wfhw = (struct axiado_pwm_waveform) {
+			.period = AXIADO_PWM_PERIOD_CONST_LOW,
+			.duty = AXIADO_PWM_DUTY_MIN,
+			.enabled = true,
+		};
+
+		/* That single cycle is longer than a sub-cycle request. */
+		return period ? 0 : 1;
+	}
+
+	if (period < AXIADO_PWM_PERIOD_MIN) {
+		period = AXIADO_PWM_PERIOD_MIN;
+		ret = 1;
+	} else if (period > AXIADO_PWM_PERIOD_MAX) {
+		period = AXIADO_PWM_PERIOD_MAX;
+	}
+
+	/*
+	 * Period clamping can leave the converted duty greater than the
+	 * final hardware period. In that case, clamp it to 100% duty.
+	 */
+	if (duty > period)
+		duty = period;
+
+	*wfhw = (struct axiado_pwm_waveform) {
+		.period = period,
+		.duty = duty,
+		.enabled = true,
+	};
+
+	return ret;
+}
+
+static int
+axiado_pwm_round_waveform_fromhw(struct pwm_chip *chip,
+				 struct pwm_device *pwm,
+				 const void *_wfhw,
+				 struct pwm_waveform *wf)
+{
+	struct axiado_pwm_chip *axpwm = pwmchip_get_drvdata(chip);
+	const struct axiado_pwm_waveform *wfhw = _wfhw;
+	u32 period = wfhw->period;
+	u32 duty = wfhw->duty;
+
+	if (!wfhw->enabled) {
+		*wf = (struct pwm_waveform) {
+			.period_length_ns = 0,
+		};
+
+		return 0;
+	}
+
+	/*
+	 * The constant low encoding doesn't hold a period. Report the
+	 * shortest one, the output is low for all of it either way.
+	 */
+	if (!duty) {
+		if (period == AXIADO_PWM_PERIOD_CONST_LOW)
+			period = AXIADO_PWM_PERIOD_MAX;
+
+		duty = period;
+	} else if (period == AXIADO_PWM_PERIOD_CONST_LOW) {
+		period = 1;
+		duty = 0;
+	} else if (duty > period) {
+		duty = period;
+	}
+
+	*wf = (struct pwm_waveform) {
+		.period_length_ns =
+			mul_u64_u64_div_u64_roundup(period, NSEC_PER_SEC,
+						    axpwm->rate),
+		.duty_length_ns =
+			mul_u64_u64_div_u64_roundup(duty, NSEC_PER_SEC,
+						    axpwm->rate),
+		.duty_offset_ns = 0,
+	};
+
+	return 0;
+}
+
+static int axiado_pwm_read_waveform(struct pwm_chip *chip,
+				    struct pwm_device *pwm,
+				    void *_wfhw)
+{
+	struct axiado_pwm_chip *axpwm = pwmchip_get_drvdata(chip);
+	struct axiado_pwm_waveform *wfhw = _wfhw;
+	u32 ctrl;
+
+	ctrl = readl(axpwm->base + AXIADO_PWM_CTRL_REG);
+
+	*wfhw = (struct axiado_pwm_waveform) {
+		.period = readl(axpwm->base + AXIADO_PWM_PERIOD_REG),
+		.duty = readl(axpwm->base + AXIADO_PWM_HIGH_REG),
+		.enabled = !!(ctrl & AXIADO_PWM_CTRL_ENABLE),
+	};
+
+	return 0;
+}
+
+static int axiado_pwm_write_waveform(struct pwm_chip *chip,
+				     struct pwm_device *pwm,
+				     const void *_wfhw)
+{
+	struct axiado_pwm_chip *axpwm = pwmchip_get_drvdata(chip);
+	const struct axiado_pwm_waveform *wfhw = _wfhw;
+
+	if (!wfhw->enabled) {
+		writel(0, axpwm->base + AXIADO_PWM_CTRL_REG);
+
+		return 0;
+	}
+
+	/*
+	 * The hardware has no shadow registers. These writes may alter the
+	 * active waveform before the current period has completed.
+	 */
+	writel(wfhw->period, axpwm->base + AXIADO_PWM_PERIOD_REG);
+	writel(wfhw->duty, axpwm->base + AXIADO_PWM_HIGH_REG);
+	writel(AXIADO_PWM_CTRL_ENABLE, axpwm->base + AXIADO_PWM_CTRL_REG);
+
+	return 0;
+}
+
+static const struct pwm_ops axiado_pwm_ops = {
+	.sizeof_wfhw = sizeof(struct axiado_pwm_waveform),
+	.round_waveform_tohw = axiado_pwm_round_waveform_tohw,
+	.round_waveform_fromhw = axiado_pwm_round_waveform_fromhw,
+	.read_waveform = axiado_pwm_read_waveform,
+	.write_waveform = axiado_pwm_write_waveform,
+};
+
+static int axiado_pwm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct axiado_pwm_chip *axpwm;
+	struct pwm_chip *chip;
+	struct clk *clk;
+	int ret;
+
+	chip = devm_pwmchip_alloc(dev, 1, sizeof(*axpwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	axpwm = pwmchip_get_drvdata(chip);
+
+	axpwm->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(axpwm->base))
+		return dev_err_probe(dev, PTR_ERR(axpwm->base),
+				     "Failed to map registers\n");
+
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk),
+				     "Failed to get/enable clock\n");
+
+	ret = devm_clk_rate_exclusive_get(dev, clk);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to lock clock rate\n");
+
+	axpwm->rate = clk_get_rate(clk);
+	if (!axpwm->rate)
+		return dev_err_probe(dev, -EINVAL,
+				     "Failed to get clock rate\n");
+
+	chip->ops = &axiado_pwm_ops;
+	chip->atomic = true;
+
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add PWM chip\n");
+
+	return 0;
+}
+
+static const struct of_device_id axiado_pwm_match[] = {
+	{ .compatible = "axiado,ax3000-pwm" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, axiado_pwm_match);
+
+static struct platform_driver axiado_pwm_driver = {
+	.driver = {
+		.name = "axiado-pwm",
+		.of_match_table = axiado_pwm_match,
+	},
+	.probe = axiado_pwm_probe,
+};
+module_platform_driver(axiado_pwm_driver);
+
+MODULE_AUTHOR("Axiado Corporation");
+MODULE_DESCRIPTION("Axiado PWM driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1

