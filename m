Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010040.outbound.protection.outlook.com [52.101.46.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB1B4718F9;
	Wed,  7 Oct 2026 09:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791364125; cv=fail; b=ZjQRM62Db/3DJywBEp5PVEIJRMT29e076Q8nf34EcKt0KUffCeUVsLIgkS4dUxvpr/rlAizbRnZ68xAY0wKDGry4Dlv3sB6r6rkXo0JoFW/XPliMPcJ381TsOCiBeAElqy5VuezbpUT6jWQLbhgxEGe9YgGdJXMT1MeuUIJpkoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791364125; c=relaxed/simple;
	bh=rGz0hFZ+YZaMg2frX2Dy21gTIZBcxBh6XPqxSZIv9AI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=eEhe0kleUmfbscpL4AeYe+royQPe65aymqZ45MaBOtMCklsYqi9apoUuI5dTCbP6kYuWExTZJdIi8pz6SFwVHzLp1WOeHd3tNoRyHAloBXU9FtZx+joqbh+BUgq3q3Ex3VJQNK525/bmX65dhHAGv4pYMUtfoyEYiLRD+K2UF6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K4lTfmIp; arc=fail smtp.client-ip=52.101.46.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K4lTfmIp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oyKlUVLqYbnZYNJ/3WCnxVNTFie87Eic3dugMrdQ9yUMp1pEL6igKttTe0jNw/WGmjG+GtpCqQrdzJ0zcZaRWPicAeSRldqbUV0BhJanPBA6GWesG5kEFIImVN4fMeJ0kTd7i555emRbmIacZgCmm3e8yO8QgwZPIRnACU5WGHgFyHRps24PvZWT1zi+h+0sfTTofdq37bcV2XfOtRzz+0vTNoWHctbIMG1sS/qqkm36njVluMBDPgCxd434vbRBBm4LUsyduHCvOefxJ2s2Yxd8R2l2Vz4Zrt6jDj8A0usRapUySKEz4GVzhdQYp0oD0kWZJjonxv8uvhjgzFppeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AWAeAl5STl96JUdtyZrMoj3nuwBD0WNQoqVDvu4120=;
 b=eBz8rd0nGggs0E+QmBucHYv6cboFt5vZXyX6u2w6uDah3ff5gn7n6/4ABfI2uKrrFVQNEofANn4ldiO+WU5cil9hkFJ7At7K872JOKFddcy4cBxiWE2KxwUOnOhE5Kf8KOKg4UtpD2hWHggHeUyzwd45TAf2RxooebNPXhCDQlgW2pIWoDXXJ6mQPDxxo/GRa/EMSKIX7sAKXgLuXCbkS+t6Uhg3NGvfn9aHqwpAJ/i+MIaPYz0NRE+JFWdISofcTDoXnuWvco0DknoQf1t1dXJa0b7Qt79uATDPYO4Ew3IgC+L9op69PQnETEumkBBs8/JF2Z6+qNyARpOTaNdhxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AWAeAl5STl96JUdtyZrMoj3nuwBD0WNQoqVDvu4120=;
 b=K4lTfmIpuvYqRAczimFExl8Xpl/sSCd64+DDqg2Zcs7PI+01V0qGIorIUsmg9vympKQApTLiIPLQHmbLunz+ndIRg732feVzh2M9cGxX+Bb0b7NigGTlCHpKkXswimufmOltz5Jm2zPk5ApmwNY9p96qcAVzdI1HEJWkHAOoh0Y=
Received: from SJ0PR05CA0127.namprd05.prod.outlook.com (2603:10b6:a03:33d::12)
 by PH8PR12MB8431.namprd12.prod.outlook.com (2603:10b6:510:25a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.19; Wed, 7 Oct
 2026 09:07:35 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::36) by SJ0PR05CA0127.outlook.office365.com
 (2603:10b6:a03:33d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 7
 Oct 2026 09:07:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 09:07:35 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 04:07:34 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 04:07:33 -0500
Received: from xhdtunimkar40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 7 Oct 2026 04:07:31 -0500
From: Meher Thanmaiee <meherthanmaiee.vanukuri@amd.com>
Date: Wed, 7 Oct 2026 14:37:01 +0530
Subject: [PATCH 3/5] clocksource: timer-cadence-ttc: Refactor common TTC
 resource setup
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261007-cadence-ttc-pwm-v1-3-52a95a8d98b1@amd.com>
References: <20261007-cadence-ttc-pwm-v1-0-52a95a8d98b1@amd.com>
In-Reply-To: <20261007-cadence-ttc-pwm-v1-0-52a95a8d98b1@amd.com>
To: <michal.simek@amd.com>, <tglx@kernel.org>, <ukleinek@kernel.org>,
	<daniel.lezcano@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, <meherthanmaiee.vanukuri@amd.com>, <linux-pwm@vger.kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791364043; l=4708;
 i=meherthanmaiee.vanukuri@amd.com; s=20261007; h=from:subject:message-id;
 bh=rGz0hFZ+YZaMg2frX2Dy21gTIZBcxBh6XPqxSZIv9AI=;
 b=bBI7O0x3zrbd8rSqYfrFoeBvu9n5Qbwyku7qQtoej03DP0m16HXARe7ubz/ifbzByoSbNtdwQ
 qXP/oQmakqUAzS7Vj594mRpuyBzYwcAs/zBJ8HDKHia1vBkfQ/B0VA4
X-Developer-Key: i=meherthanmaiee.vanukuri@amd.com; a=ed25519;
 pk=m/+ON8/+ewj5VLb55p7J9gAopkLKj2mp7iobBZdhi0Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|PH8PR12MB8431:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d874c53-d4c0-44e2-892a-08df24526db0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	AWHafP9aEnZFmDqAN6c0z0Bk8B3pfU4wxy8bBZhf6lr2EZjqm+WRGCJJx+LQG6yGNcHCOFB4wmrhgYImOiADMxaMZGRBohl88HXqCq76Mm+hFCrRuf439bZ+Z+F0LL0wfpZuC6wUJF8vnrD4Yqqw+8/fBBAyXdNcWxGNEPM4/FhHL83kkSeZcI4ZBYilUXWxFwe3OBFTg6vDGp/XwmY10iA9gSf803Iz5KCMVUG4LHNkWOJxtot/IRoJ539oV9PZPsxFswpDPssgYtqo+jvjO0gVtVg3eWDnokr0hqfiKjXoFrJwEJwKe3/Oh6DbgWE5z47HMCTmtvKb31cSY8KfHTSjDfzC0yjHr6v3Sw1KeiC7ffSa5xqCwqrQiYFsAuMIqNNYXgnkwTa96Q+Nrow/7oCznSwr1WIiPp8m67faMZ7588Rl2CgZ6ZRMJRFchM0TbVVQVDihvUzTgvMRbeQ10CWKgIlYLLenEwOe6B2ODWwWgtrkjALO9D/hj6azF+rA+uH7krcWBNiaFtjNbBNWMRRxQW471NerLytU6pSNQ77aglKETbYfTlNdAcpQqnYUyjzoTKx0NpeNQcTS600QeZ8lLjB/n265Fo177ctTCPS88Yp9Xxq9/tTxmHq74EBoRIO8K0z1Vh8c5hbKAzzvwgw3PWurx1cwn9Pg9MKdtwYmHtFTCUC4E9xDZbGPsqItpe/oXoUQZciVBFkv33/YDg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eBFmT389oXGGOC0/QyphK3oac/I8QfrPiiE4qzjUQPb753lT9GkgTgeYufzA8FjlInAgEFhqvxkXJANXXHFFPlc01va0N44Qe93BJJigV3XDt5IiKBDLqCPyGEvumu9NixeaRrTGsmT+kAxd4d5WRyqrMtDx3+IF2B0GoUENEFA3SDocNoMHcIysSSzC4DlLFCU0pQjctlHQBl/iNS31h9qSXLONrIOpzsdLHb/12ilh9PNRIffOvHhOYsRCxdQ1TP4FOP8XlwkEwwpRrEZLtsXj96Pur5pZLd8l16nB2q3mx1GTk+DWMZYmQKM4jIdTY2Tso6xLdtep/Cwms0gcXIaWRRmfk1mkrM2xt42oFbMrFFUlpW30ItDPSdstQHmWtNRUbzWXte/BYkv2sQXHKCQkO+lWKAmafc1aj976KmDYSuwW0J5JaOSUq4dHkMck
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 09:07:35.5366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d874c53-d4c0-44e2-892a-08df24526db0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8431

Factor the TTC MMIO mapping and timer-width parsing in the timer probe
path into a helper.

As part of the refactor, switch the timer probe path from
devm_of_iomap() to devm_platform_ioremap_resource(). This is safe
because each Cadence TTC device tree node has a dedicated,
non-overlapping MMIO resource.

Also replace the hardcoded default timer width and channel stride with
TTC_DEFAULT_TIMER_WIDTH and TTC_CH_OFFSET, and switch to
device_property_read_u32() when reading timer-width.

This prepares the timer driver for later reuse of the common resource
setup by the PWM auxiliary-device path.

Signed-off-by: Meher Thanmaiee <meherthanmaiee.vanukuri@amd.com>
---
 drivers/clocksource/timer-cadence-ttc.c | 49 ++++++++++++++++++---------------
 include/linux/timer-cadence-ttc.h       |  5 ++++
 2 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/timer-cadence-ttc.c
index 75bc0af1fa9e..954a9b85a958 100644
--- a/drivers/clocksource/timer-cadence-ttc.c
+++ b/drivers/clocksource/timer-cadence-ttc.c
@@ -8,16 +8,16 @@
  */
 
 #include <linux/clk.h>
-#include <linux/interrupt.h>
 #include <linux/clockchips.h>
 #include <linux/clocksource.h>
-#include <linux/of_address.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
 #include <linux/of_irq.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
-#include <linux/slab.h>
+#include <linux/property.h>
 #include <linux/sched_clock.h>
-#include <linux/module.h>
-#include <linux/of_platform.h>
+#include <linux/slab.h>
 #include <linux/timer-cadence-ttc.h>
 
 /*
@@ -463,29 +463,36 @@ static int ttc_setup_clockevent(struct clk *clk,
 	return err;
 }
 
+static int ttc_init_common(struct platform_device *pdev,
+			   void __iomem **base, u32 *timer_width)
+{
+	*base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(*base))
+		return PTR_ERR(*base);
+
+	*timer_width = TTC_DEFAULT_TIMER_WIDTH;
+	device_property_read_u32(&pdev->dev, "timer-width", timer_width);
+
+	return 0;
+}
+
 static int ttc_timer_probe(struct platform_device *pdev)
 {
-	unsigned int irq;
+	struct device_node *timer = pdev->dev.of_node;
 	void __iomem *timer_baseaddr;
 	struct clk *clk_cs, *clk_ce;
 	static int initialized;
+	unsigned int irq;
+	u32 timer_width;
 	int clksel, ret;
-	u32 timer_width = 16;
-	struct device_node *timer = pdev->dev.of_node;
 
 	if (initialized)
 		return 0;
 
-	/*
-	 * Get the 1st Triple Timer Counter (TTC) block from the device tree
-	 * and use it. Note that the event timer uses the interrupt and it's the
-	 * 2nd TTC hence the irq_of_parse_and_map(,1)
-	 */
-	timer_baseaddr = devm_of_iomap(&pdev->dev, timer, 0, NULL);
-	if (IS_ERR(timer_baseaddr)) {
-		pr_err("ERROR: invalid timer base address\n");
-		return PTR_ERR(timer_baseaddr);
-	}
+	ret = ttc_init_common(pdev, &timer_baseaddr, &timer_width);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to map timer registers\n");
 
 	irq = irq_of_parse_and_map(timer, 1);
 	if (irq <= 0) {
@@ -493,8 +500,6 @@ static int ttc_timer_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	of_property_read_u32(timer, "timer-width", &timer_width);
-
 	clksel = readl_relaxed(timer_baseaddr + TTC_CLK_CNTRL_OFFSET);
 	clksel = !!(clksel & TTC_CLK_CNTRL_CSRC_MASK);
 	clk_cs = of_clk_get(timer, clksel);
@@ -503,7 +508,7 @@ static int ttc_timer_probe(struct platform_device *pdev)
 		return PTR_ERR(clk_cs);
 	}
 
-	clksel = readl_relaxed(timer_baseaddr + 4 + TTC_CLK_CNTRL_OFFSET);
+	clksel = readl_relaxed(timer_baseaddr + TTC_CH_OFFSET + TTC_CLK_CNTRL_OFFSET);
 	clksel = !!(clksel & TTC_CLK_CNTRL_CSRC_MASK);
 	clk_ce = of_clk_get(timer, clksel);
 	if (IS_ERR(clk_ce)) {
@@ -516,7 +521,7 @@ static int ttc_timer_probe(struct platform_device *pdev)
 	if (ret)
 		goto put_clk_ce;
 
-	ret = ttc_setup_clockevent(clk_ce, timer_baseaddr + 4, irq);
+	ret = ttc_setup_clockevent(clk_ce, timer_baseaddr + TTC_CH_OFFSET, irq);
 	if (ret)
 		goto put_clk_ce;
 
diff --git a/include/linux/timer-cadence-ttc.h b/include/linux/timer-cadence-ttc.h
index 4f2b85e0ff78..37ac775d6d50 100644
--- a/include/linux/timer-cadence-ttc.h
+++ b/include/linux/timer-cadence-ttc.h
@@ -11,6 +11,11 @@
 
 #include <linux/bits.h>
 
+#define TTC_DEFAULT_TIMER_WIDTH		16
+
+/* Per-channel register offset stride */
+#define TTC_CH_OFFSET			0x04
+
 /* Timer Register Offset Definitions of Timer 1 */
 #define TTC_CLK_CNTRL_OFFSET		0x00 /* Clock Control Reg, RW */
 #define TTC_CNT_CNTRL_OFFSET		0x0C /* Counter Control Reg, RW */

-- 
2.34.1

