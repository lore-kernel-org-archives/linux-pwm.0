Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012026.outbound.protection.outlook.com [52.101.53.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6004A5C3C;
	Wed,  7 Oct 2026 09:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791364136; cv=fail; b=d23dmCAQcfMiHv2xl8n5mZZuEZeWbbt6JXEEU3KUzOTDkH5ggLIvwTl3W/fRf/9KB26aZFbit/Q+5vBQ6gvsjf4oeG4/m2M9BTt4UOv981jWGbCDHiRJDeC1fVgwdaHk1rejpGxbrlEC4R7kXjmfsI186GCEhPqO7HSa+ny/VTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791364136; c=relaxed/simple;
	bh=rW6LgnjZdH3rnRnnAhyT9ZLFo+mU3rOsIzWy9rRYfa4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=PrnJJVTMl4xusJ/t4Q/tKxUKaih1iyKdGn4uFUfw/ZqBh1LTEhVvbfmDASIJN3W6WRgCu4RkjQJV1B/ol/rSIr9eE685wCmoLdhF8NhPhcm4+4l5mB7PvAAgMae2kwaWUUDfFhSkB1qBUkTazIcMNA31sq7ILYIRVdfv2/lfmiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cJ34zqNF; arc=fail smtp.client-ip=52.101.53.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cJ34zqNF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=se1OrsPYP1ewc35nrqsVf0XkzvrAav1blN1ixLQwEH2VuoFi1HpHvAAdW5GK1lqDfyCVHKkZcNlXXszXqnT3CiyGmI7WBQuFdCoPMPYYGXPuON5cnm+0dJJ5ZTZDeebEAgjc/UxUHfdbEGSJuKjhER974Rmv69m2UgsCwwYM4L9vvZ8COPzPHQrJGjpw+zJzIy6J+n0rm636V6bL0iigU4jUtORAiKgnOhwWtjir3A6ByNN/yeII8bourjeoABQYsLoGdoiKANEI/tHePzIs1ieHyU0zcFJ812Adbub6BOA3fFQbxgW/0m0icsTfIjxPttEgxnNI4ytjMz//7N/v8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKLpBVInE+oMVjCjXbwZVVGxTYTEaXBrUQZNoy7Mq9I=;
 b=CPmmJScIBrTRCSTMBH2jZzG3enYy+6i98MPLo95w1nEPiSxfoEoJ0p1gu1yS3vFDT92ooOylHBashXMkFIFoYB8Sn52zbTDPdThzq7upIDFsaoMJ9hiLPxxH39ZAPmisC9ifMGuJz8KZBsVS8OUhUpKwUOgeGbV+fHxHkpCyCgBXLvh7YQkBBSqXnr6CwJ00cKaVy+RRZRMy/zuzImN36Ro71TwUNHLyeLAiIyHD95WvZMd55fH48fyKt1QzJRDsaewJJYsqO7lua72S+qRY1S05RWCDDKRNu54XMlZL9+ABXDFFApi5WlmXN38jSblOraY+EpgsSq1HU9u8pvErhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKLpBVInE+oMVjCjXbwZVVGxTYTEaXBrUQZNoy7Mq9I=;
 b=cJ34zqNFO1Mw3HqT+9+gH1HHW2+0HE9aRsK0k0huhCW5A8gQ+yDgv5DbR62L+4mMM1ejwmcJrEiVl8HMkL18oNhpRYD5v66/cCOtP7ui+Cs7owF7YR0aSQRiUXXEpcomKAhwTTL0K9KY/MVWSdnqydLnrspXOJZnvKVjl3NKi8U=
Received: from SJ0PR13CA0070.namprd13.prod.outlook.com (2603:10b6:a03:2c4::15)
 by SA1PR12MB7367.namprd12.prod.outlook.com (2603:10b6:806:2b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Wed, 7 Oct
 2026 09:07:33 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::82) by SJ0PR13CA0070.outlook.office365.com
 (2603:10b6:a03:2c4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 7
 Oct 2026 09:07:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 09:07:33 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 04:07:31 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 04:07:30 -0500
Received: from xhdtunimkar40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 7 Oct 2026 04:07:28 -0500
From: Meher Thanmaiee <meherthanmaiee.vanukuri@amd.com>
Date: Wed, 7 Oct 2026 14:37:00 +0530
Subject: [PATCH 2/5] clocksource: timer-cadence-ttc: Allow deferred probing
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261007-cadence-ttc-pwm-v1-2-52a95a8d98b1@amd.com>
References: <20261007-cadence-ttc-pwm-v1-0-52a95a8d98b1@amd.com>
In-Reply-To: <20261007-cadence-ttc-pwm-v1-0-52a95a8d98b1@amd.com>
To: <michal.simek@amd.com>, <tglx@kernel.org>, <ukleinek@kernel.org>,
	<daniel.lezcano@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, <meherthanmaiee.vanukuri@amd.com>, <linux-pwm@vger.kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791364043; l=3114;
 i=meherthanmaiee.vanukuri@amd.com; s=20261007; h=from:subject:message-id;
 bh=rW6LgnjZdH3rnRnnAhyT9ZLFo+mU3rOsIzWy9rRYfa4=;
 b=SeI47opbGaAypV5PSIV/toYQwF/vRh3XISqhAa3D8Y276Oyn0umjiRmmoc1IiuDIimHPix14n
 SoiIJE4jsZzAh2Yot6tr5RtVBj21vl9l1KufVDzFqrHJ/a+r7rSGK7V
X-Developer-Key: i=meherthanmaiee.vanukuri@amd.com; a=ed25519;
 pk=m/+ON8/+ewj5VLb55p7J9gAopkLKj2mp7iobBZdhi0Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|SA1PR12MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bc3365b-a605-4c3a-9bdd-08df24526c3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	M0WQciQWG4ttLZ9dIzBLN1/MOLeubrSMFDiU5NLmsz/LzqS2wV6xSl5dVW+ufj/YHYzYAEnFX6/ExjmrIojgxl4rKJvbbELBeDv0qAOkEYoknXBZ8BtPguuKeU7L3gnqCm/igU0alcKVyKpTPMA/gPvNYj7cp/O4okIKkJhZq3k052DZ1CWHBUBLN7JFbCwmAeRIKBLXmKFl7t43lhZoJAx2h9vqN/bQfMmG2CJC3DAX4dkYxz29EXIlNLiqC//mrPlKYxPiYzzhMlCLY/2cynzPcUTWcYaWgSK81ojt1htGlppbJLlXJnY6Ue4udM79D80DQVeLn4m9g3glZcEBwvtTiN5V4ZdI0fXAbxro9P4VG/YmZyfx7raRixqzM3z8mj40wmRSmfYSPzxGAfXFcgQtYS63AAN4RXsIKjz5W+u2fqRiBPkPmbKYumH/1ghHm0IBPEjFF9juvlNJ7O/TiD0H//GXKRseqNjjvwIBbSXaS97T756c6COrJEFYeoKo9+XKMn2zIDNOPya5wW50/pMuGMmURiuZDYuMNYQRmyRh/n9UcJgVnOzDP35c1qEDmBpgeV8dcq+JLuppFlMdAG2EUiBg90kHSNto71i0PcErkbKXMGlLsThpejoZl4i35alAu7tSB/hiYkWlHYhXRvm/dCCo2FtTGUwFevhqEjPOjgvFuzProScpmIA4tEX3TDygPLFQmK5uJHPHQvlDFg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wcE+Ck57ofsGZbgLh71Fr+a6LEmkP/Y3DOQTU0KFsBvtMSi7Iwhij8dNpI3IKNC6DgIjFLc2MAoSSTOjQqv3V+31RXjGRSL2k23/9obp3rXV+hMvDWiZ8Ca/hgSjS8QVltbUPh/qFsZMyTeCAowuiKho8CGDZSRFjov3bcNo/D6MRJrB7VURgTKwW+W9+ev5oDuY60tx72ctJNU+sL9zaOA4lO3pKpEK+Fk8vrIDRsnZ6D3mZ+fYib9jdkoisyogE5efybMceonRtUUnhO4XRr1DLPHgBjRDlHYQ5POFmdeANgzuQfFTJNfDqm0Pqfl0rODUM8kc5QcfIXHsVzYUHd9ZSLsu2NOlrWH/4itFnCYs+tm7lOYo046P0GXN1Q9Hpql1jPmLTzsDWkpKHaNUwi/grkPggAGsv4XT5g4NgGNEbVzI4xnVv4dPPx15pWB9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 09:07:33.0921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc3365b-a605-4c3a-9bdd-08df24526c3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7367

Switch from builtin_platform_driver_probe() to builtin_platform_driver()
to support deferred probing. The existing timer probe path calls
of_clk_get(), which can return -EPROBE_DEFER when the clock provider is
not yet available. builtin_platform_driver_probe() discards the probe
callback after init and cannot retry probing, so switch to
builtin_platform_driver(), which keeps it available. This requires
removing the __init annotations from ttc_timer_probe(),
ttc_setup_clocksource(), and ttc_setup_clockevent().

Move the initialized flag assignment to after clocksource and
clockevent registration succeeds so that a retried probe does not see
initialized = true and return early before the timer is configured.

Signed-off-by: Meher Thanmaiee <meherthanmaiee.vanukuri@amd.com>
---
 drivers/clocksource/timer-cadence-ttc.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/timer-cadence-ttc.c
index 8be13d344007..75bc0af1fa9e 100644
--- a/drivers/clocksource/timer-cadence-ttc.c
+++ b/drivers/clocksource/timer-cadence-ttc.c
@@ -312,8 +312,8 @@ static int ttc_rate_change_clocksource_cb(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
-static int __init ttc_setup_clocksource(struct clk *clk, void __iomem *base,
-					 u32 timer_width)
+static int ttc_setup_clocksource(struct clk *clk, void __iomem *base,
+				 u32 timer_width)
 {
 	struct ttc_timer_clocksource *ttccs;
 	int err;
@@ -395,8 +395,8 @@ static int ttc_rate_change_clockevent_cb(struct notifier_block *nb,
 	}
 }
 
-static int __init ttc_setup_clockevent(struct clk *clk,
-				       void __iomem *base, u32 irq)
+static int ttc_setup_clockevent(struct clk *clk,
+				void __iomem *base, u32 irq)
 {
 	struct ttc_timer_clockevent *ttcce;
 	int err;
@@ -463,7 +463,7 @@ static int __init ttc_setup_clockevent(struct clk *clk,
 	return err;
 }
 
-static int __init ttc_timer_probe(struct platform_device *pdev)
+static int ttc_timer_probe(struct platform_device *pdev)
 {
 	unsigned int irq;
 	void __iomem *timer_baseaddr;
@@ -476,8 +476,6 @@ static int __init ttc_timer_probe(struct platform_device *pdev)
 	if (initialized)
 		return 0;
 
-	initialized = 1;
-
 	/*
 	 * Get the 1st Triple Timer Counter (TTC) block from the device tree
 	 * and use it. Note that the event timer uses the interrupt and it's the
@@ -522,6 +520,8 @@ static int __init ttc_timer_probe(struct platform_device *pdev)
 	if (ret)
 		goto put_clk_ce;
 
+	initialized = 1;
+
 	pr_info("%pOFn #0 at %p, irq=%d\n", timer, timer_baseaddr, irq);
 
 	return 0;
@@ -541,9 +541,10 @@ static const struct of_device_id ttc_timer_of_match[] = {
 MODULE_DEVICE_TABLE(of, ttc_timer_of_match);
 
 static struct platform_driver ttc_timer_driver = {
+	.probe = ttc_timer_probe,
 	.driver = {
 		.name	= "cdns_ttc_timer",
 		.of_match_table = ttc_timer_of_match,
 	},
 };
-builtin_platform_driver_probe(ttc_timer_driver, ttc_timer_probe);
+builtin_platform_driver(ttc_timer_driver);

-- 
2.34.1

