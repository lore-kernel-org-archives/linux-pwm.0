Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011033.outbound.protection.outlook.com [40.93.194.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447C7490BF8;
	Wed,  7 Oct 2026 09:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791364157; cv=fail; b=TMfXL1+7WVr0P+5DmCJK1li8uwa3eXlRD4SO+p0wOVRbhyCt9QoQt+E78nRAxDLqXaGeCOXyYCrEnzFdkzQEb1+yAWrlw41WHzNOSMfok19CS+EA09XnfHIL5h3NLhpRTfhCU8RPQSRHC/CllEoqYHP2BNLprE4fwHwD+nUmNU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791364157; c=relaxed/simple;
	bh=hmu3mK7SSMlA0w/a5ZhPaM26C3x5lsKr2PNUM5TE8po=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=bHuR3x92p0Ejh1+9oQJ4C1tgqv7W6OU1e7MaPt7TylnLRQ3sq0jzTu0D3MuCP8VnLuHeYvyGOFGCKiHvfhOAzUzmjotcWSkRoNrGTicxmmso8zABlpjBflMagfCB7zMf2YQsnA3bGaQXwm0npIQJRzEpU+bnomQi3siRQEzraBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HWG+OnJs; arc=fail smtp.client-ip=40.93.194.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HWG+OnJs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=th7OpOWVz9IETd3jwAU6CLjwmvZU7Y4XbyVnPxswuBSkJ6ZELA93CViaPkOmc4HRgqRq1sr28yejw0PQtnX0zwVtU+TkGPI7r1rlSz17F9jS1DlJsO7ndnncZwVYMJUjuqVmygxIXfYaRnXzjfdiKLMCSyb285SYnzLf/17641Khl/Ho0PEkhMzGu12WJEzUmwnIcyOXtbj2XXVPb8DcdxrD8pdzuYukHQ1rGS8vXjyyaBQuloCpch6WO08LIFxVUjYkC/0FBIXRME32nrqk95riBBcDNwrH9L5W7NDevRT3ZwF25j4J7xcsqC1cyP4U+XxgqosCFrLi+UoHK5ARWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daDVPTsH7M4n+yPTbx/psOnzEB+dfilfpe+II8Ci/ho=;
 b=Ph6YXfRhSm1Xey66FXntKaXyMKsqgP9tUqdj/REghi6+hgKFA+CCTlau21hcPu1r10no/+VbdUcCiirQrCjNLtbkZGK3U6EJZYuYYAxgWdCgXohLyLvcQJdUUXL2WwgVbSxOROErNhGT5BPNicY3vkjEPOn8dxZblQtcpSpva1LtRAVwk/hWkdIDFu2Grj5p09oukvzIwKZQa0jbSTTS+sk4nBpJ1a8dZMJWdw63kKd1IR84W8m4Pg3gnPDjWnM7ZZSkLQlA1gzFzDUsAbHKxn40jVb0gRpUKvs33JYALGwqCcj5knz91Az3cFzv6/5RVATVjwIek+yNjE57P7moaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daDVPTsH7M4n+yPTbx/psOnzEB+dfilfpe+II8Ci/ho=;
 b=HWG+OnJsjdjbAaffaMBVoxTvY9Gbyai93f1/Q8jiykPbSlTHg8j0zkb5EFO4kHHynwwZlylTkYhJL39wxfxBHHvY+LxxWO2H2jdYYZZ5vB5G26VoGHdZZK9kk2FYSzAKfF+2OKs/PPjjdIz4rrcGXLkwPM70mmIoDzhP7L7GaA8=
Received: from BY3PR10CA0005.namprd10.prod.outlook.com (2603:10b6:a03:255::10)
 by IA0PR12MB8423.namprd12.prod.outlook.com (2603:10b6:208:3dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 7 Oct
 2026 09:07:43 +0000
Received: from SJ1PEPF000037BA.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::1) by BY3PR10CA0005.outlook.office365.com
 (2603:10b6:a03:255::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 7
 Oct 2026 09:07:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037BA.mail.protection.outlook.com (10.167.244.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 09:07:43 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 04:07:40 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 04:07:39 -0500
Received: from xhdtunimkar40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 7 Oct 2026 04:07:36 -0500
From: Meher Thanmaiee <meherthanmaiee.vanukuri@amd.com>
Date: Wed, 7 Oct 2026 14:37:03 +0530
Subject: [PATCH 5/5] clocksource: timer-cadence-ttc: Add PWM
 auxiliary-device support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261007-cadence-ttc-pwm-v1-5-52a95a8d98b1@amd.com>
References: <20261007-cadence-ttc-pwm-v1-0-52a95a8d98b1@amd.com>
In-Reply-To: <20261007-cadence-ttc-pwm-v1-0-52a95a8d98b1@amd.com>
To: <michal.simek@amd.com>, <tglx@kernel.org>, <ukleinek@kernel.org>,
	<daniel.lezcano@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, <meherthanmaiee.vanukuri@amd.com>, <linux-pwm@vger.kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791364043; l=6099;
 i=meherthanmaiee.vanukuri@amd.com; s=20261007; h=from:subject:message-id;
 bh=hmu3mK7SSMlA0w/a5ZhPaM26C3x5lsKr2PNUM5TE8po=;
 b=nexFwL44RV8WvOPbKnnghILPAu/U1DSNAZ34nmQHI9l0l8dmusPptIBRbBsCcS5s0GAM9eB0B
 P18Hi0/4KdfCh6TT8ENiA9L7ZoQF5syE09nh3pTjm0TSUn2QtutZhYM
X-Developer-Key: i=meherthanmaiee.vanukuri@amd.com; a=ed25519;
 pk=m/+ON8/+ewj5VLb55p7J9gAopkLKj2mp7iobBZdhi0Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037BA:EE_|IA0PR12MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: bc61a1d6-b79f-4bb9-0313-08df24527287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sS1T+Nu8yEYEO3hKGbHCFou/QaozTvFrnQpqJzQMGKODYx/9SpmQ7zCsuJ9683uLKTSEo4kSc4KLcJQzXHY3Y1PgbtQYSyktwhA/IXo5brPlzP7RRsfMAuY/Nxh0jFkWFwEfnpSfiVXzbR+mXry2H51o42P/vV3wNled/yRlKvyfawmSYkM3KvGp4vVi+tn3vQpFbPgnE5TOpcBYJ5GTOh1rnIyMy/gpdgJL5CSHvZ5t0iZAGFASISCq5nC6LNBjv1FAEKXxd+H5kh8rfiw/WHEO4Orhb+fBCuRI2MeeJigcF5HXJyxbEmTBtimNhfBBNCfKEior1uK1/EXZMDaLtrSg1li3BtDnDz4nQfglad1s4BCYWofNUfraKPs5uweIxndCuzXC4cGzsOvSziB+4vcxMMZJ7u+I+H3jXt3GGrVTNublzA75/HlgeODwWvf5i+4oZauibtTXov3Mgi6hNJRdlaz2p9qBXPY3s6TQ7NmamcPE4DmEqbDtM+mKBKaRst/+KrD6JrSHIB+5E+SOSEZSCHSCGiFh6JG++ipd62SSADOpYB9jDPpJFBQ2hb4y+gF8YBY8zl2Ry1nc+UUeSEX3Bo35VOE8uFvygotvFB02Z8z3GdKTGSmbdwbUOhYs13sUJvuLlkiRK7y9E9wHQePlrt0o6LwBV4rhuWC/vOCe5epdGp3R4iwbDz1ewOKkNeVwOZsrOxgA+pL/LE+maw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	k5ep6GTaDCNWqE9vCde1jGYnTbZRFINa4InHY2dcF5QtCEhPCMBGtLUgDT4WTgtYQHeGqH4NRUnqLKtkPqCpftTN4Ife9ZRhk6FEBLKIJzQ7RdtiE4SlL5XSGNEnwAmmLqNlieH4VIsJEZ8CkwJ6wzp39J7D+VNg/hco6bZ78JAoZEn4f0ViKnSr+CObwJLbStDc8FGrIlQXP1ng3pg+ly0b4Jy3GHVOyHkqJnylNNp44ci/4ZqxlfOtW4zzwiitQd4G8eoYATc7/YFoVTCaUoofB7st/3mfLqna0NfLV2wh4DKCaGXwD7b85IeKWSr70ufHkPC+wwSLWpNi+wKbM1AjGvsC5Mu5nzZmQgtDc6os8bdl+ooO8Ee2xEudE9xpWlefByps5I1L4bfnzJCA3+V/ywUeWhN7zlavNgQbCphaoKTserFzsq7RyV7pPcMB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 09:07:43.6584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc61a1d6-b79f-4bb9-0313-08df24527287
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037BA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8423

When a TTC device tree node contains #pwm-cells, create an
auxiliary-bus child device so the Cadence TTC PWM driver can bind to
that instance instead of using it as a clocksource and clockevent
device.

Propagate the parent device tree node to the auxiliary device so PWM
consumers can be matched through the device tree, and pass the mapped
register base, input clock, clock rate, and timer width to the child
driver through shared TTC data.

PWM support is limited to TTC instances whose channels use the shared
internal/reference clock. Reject instances configured to use the
alternate external clock source, which would require per-channel clock
source selection and rate handling.

Select AUXILIARY_BUS in Kconfig for the auxiliary-bus device creation.

Signed-off-by: Meher Thanmaiee <meherthanmaiee.vanukuri@amd.com>
---
 drivers/clocksource/Kconfig             |   5 ++
 drivers/clocksource/timer-cadence-ttc.c | 124 ++++++++++++++++++++++++++++++++
 include/linux/timer-cadence-ttc.h       |   1 +
 3 files changed, 130 insertions(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index d9c76dd443f8..098cc40f68b0 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -201,9 +201,14 @@ config NPCM7XX_TIMER
 config CADENCE_TTC_TIMER
 	bool "Cadence TTC timer driver" if COMPILE_TEST
 	depends on COMMON_CLK
+	select AUXILIARY_BUS
 	help
 	  Enables support for the Cadence TTC driver.
 
+	  When a TTC device-tree node contains #pwm-cells, this
+	  driver creates an auxiliary-bus device that is bound by
+	  the Cadence TTC PWM driver.
+
 config ASM9260_TIMER
 	bool "ASM9260 timer driver" if COMPILE_TEST
 	select CLKSRC_MMIO
diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/timer-cadence-ttc.c
index 954a9b85a958..fded136b448e 100644
--- a/drivers/clocksource/timer-cadence-ttc.c
+++ b/drivers/clocksource/timer-cadence-ttc.c
@@ -7,6 +7,8 @@
  * based on arch/mips/kernel/time.c timer driver
  */
 
+#include <linux/atomic.h>
+#include <linux/auxiliary_bus.h>
 #include <linux/clk.h>
 #include <linux/clockchips.h>
 #include <linux/clocksource.h>
@@ -476,6 +478,121 @@ static int ttc_init_common(struct platform_device *pdev,
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_PWM_CADENCE)
+
+/* Auxiliary-bus device wrapper */
+struct ttc_auxdev {
+	struct auxiliary_device adev;
+	struct ttc_shared_data sd;
+};
+
+static void ttc_auxdev_release(struct device *dev)
+{
+	struct auxiliary_device *adev = to_auxiliary_dev(dev);
+	struct ttc_auxdev *ta = container_of(adev, struct ttc_auxdev, adev);
+
+	of_node_put(dev->of_node);
+	kfree(ta);
+}
+
+static atomic_t ttc_auxdev_id;
+
+static void ttc_auxdev_teardown(void *data)
+{
+	struct auxiliary_device *adev = data;
+
+	auxiliary_device_delete(adev);
+	auxiliary_device_uninit(adev);
+}
+
+static int ttc_create_aux(struct device *parent, const char *name,
+			  const struct ttc_shared_data *sd)
+{
+	struct ttc_auxdev *ta;
+	int ret;
+
+	ta = kzalloc_obj(*ta);
+	if (!ta)
+		return -ENOMEM;
+
+	ta->sd = *sd;
+	ta->adev.name = name;
+	ta->adev.id = atomic_fetch_inc(&ttc_auxdev_id);
+	ta->adev.dev.parent = parent;
+	ta->adev.dev.release = ttc_auxdev_release;
+	ta->adev.dev.platform_data = &ta->sd;
+	device_set_of_node_from_dev(&ta->adev.dev, parent);
+
+	ret = auxiliary_device_init(&ta->adev);
+	if (ret) {
+		of_node_put(ta->adev.dev.of_node);
+		kfree(ta);
+		return ret;
+	}
+
+	ret = auxiliary_device_add(&ta->adev);
+	if (ret) {
+		auxiliary_device_uninit(&ta->adev);
+		return ret;
+	}
+
+	return devm_add_action_or_reset(parent, ttc_auxdev_teardown,
+					&ta->adev);
+}
+
+static int ttc_probe_auxbus(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ttc_shared_data sd;
+	struct clk *clk;
+	int i, ret;
+	u32 val;
+
+	ret = ttc_init_common(pdev, &sd.base, &sd.timer_width);
+	if (ret)
+		return ret;
+
+	if (sd.timer_width == 0 || sd.timer_width > TTC_MAX_TIMER_WIDTH)
+		return dev_err_probe(dev, -EINVAL,
+				     "invalid timer-width value\n");
+
+	/*
+	 * PWM support is limited to the shared internal/reference clock on
+	 * all channels. Supporting the alternate external clock source
+	 * would require per-channel clock and rate handling.
+	 */
+	for (i = 0; i < TTC_NUM_CHANNELS; i++) {
+		val = ttc_ch_readl(&sd, i, TTC_CLK_CNTRL_OFFSET);
+		if (val & TTC_CLK_CNTRL_CSRC_MASK)
+			return dev_err_probe(dev, -EINVAL,
+					     "external clock source not supported for PWM\n");
+	}
+
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk),
+				     "failed to get timer input clock\n");
+
+	sd.clk = clk;
+	sd.rate = clk_get_rate(clk);
+	if (!sd.rate)
+		return dev_err_probe(dev, -EINVAL,
+				     "failed to get clock rate\n");
+
+	ret = ttc_create_aux(dev, "pwm", &sd);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to create PWM aux device\n");
+
+	return 0;
+}
+#else
+static inline int ttc_probe_auxbus(struct platform_device *pdev)
+{
+	return 0;
+}
+#endif
+
 static int ttc_timer_probe(struct platform_device *pdev)
 {
 	struct device_node *timer = pdev->dev.of_node;
@@ -486,6 +603,13 @@ static int ttc_timer_probe(struct platform_device *pdev)
 	u32 timer_width;
 	int clksel, ret;
 
+	/*
+	 * If #pwm-cells is present, this TTC is used for PWM.
+	 * Create an auxiliary-bus child device for the PWM driver.
+	 */
+	if (device_property_present(&pdev->dev, "#pwm-cells"))
+		return ttc_probe_auxbus(pdev);
+
 	if (initialized)
 		return 0;
 
diff --git a/include/linux/timer-cadence-ttc.h b/include/linux/timer-cadence-ttc.h
index 05b7edd88626..58cc7db72693 100644
--- a/include/linux/timer-cadence-ttc.h
+++ b/include/linux/timer-cadence-ttc.h
@@ -16,6 +16,7 @@
 struct clk;
 
 #define TTC_DEFAULT_TIMER_WIDTH		16
+#define TTC_MAX_TIMER_WIDTH		32
 
 /* Per-channel register offset stride */
 #define TTC_CH_OFFSET			0x04

-- 
2.34.1

