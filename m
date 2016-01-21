From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH] pwm: ftm: use flat regmap cache
Date: Wed, 20 Jan 2016 18:56:22 -0800
Message-ID: <1453344982-4529-1-git-send-email-stefan@agner.ch>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.kmu-office.ch ([178.209.48.109]:35036 "EHLO
	mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965297AbcAUC4e (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 20 Jan 2016 21:56:34 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com
Cc: Xiubo.Lee@gmail.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Stefan Agner <stefan@agner.ch>, Mark Brown <broonie@kernel.org>

Use flat regmap cache to avoid lockdep warning at probe:
[    0.697285] WARNING: CPU: 0 PID: 1 at kernel/locking/lockdep.c:2755 lockdep_trace_alloc+0x15c/0x160()
[    0.697449] DEBUG_LOCKS_WARN_ON(irqs_disabled_flags(flags))

The RB-tree regmap cache needs to allocate new space on first
writes. However, allocations in an atomic context (e.g. when a
spinlock is held) are not allowed. The function regmap_write
calls map->lock, which acquires a spinlock in the fast_io case.
Since the pwm-fsl-ftm driver uses MMIO, the regmap bus of type
regmap_mmio is being used which has fast_io set to true.

The MMIO space of the pwm-fsl-ftm driver is reasonable condense,
hence using the much faster flat regmap cache is anyway the better
choice.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Cc: Mark Brown <broonie@kernel.org>
---
 drivers/pwm/pwm-fsl-ftm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index f9dfc8b..ed39e8e 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -414,7 +414,7 @@ static const struct regmap_config fsl_pwm_regmap_config = {
 
 	.max_register = FTM_PWMLOAD,
 	.volatile_reg = fsl_pwm_volatile_reg,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_FLAT,
 };
 
 static int fsl_pwm_probe(struct platform_device *pdev)
-- 
2.7.0
