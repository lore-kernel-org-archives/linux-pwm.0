From: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH] pwm: Avoid double mutex lock on pwm_enable
Date: Fri, 20 Nov 2015 16:59:00 +0000
Message-ID: <1448038740-2811-1-git-send-email-linux.amoon@gmail.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Thierry Reding <thierry.reding@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Anand Moon <linux.amoon@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Commit d1cd21427747f15920cd726f5f67a07880e7dee4
(pwm: Set enable state properly on failed call to enable)
introduce double lock of mutex on pwm_enable

Changes fix the following debug lock warning.

[    2.701720] WARNING: CPU: 3 PID: 0 at kernel/locking/mutex.c:526 __mutex_lock_slowpath+0x3bc/0x404()
[    2.701731] DEBUG_LOCKS_WARN_ON(in_interrupt())
[    2.701737] Modules linked in:
[    2.701748] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 4.4.0-rc1-xu4f #24
[    2.701753] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[    2.701787] [<c0015f48>] (unwind_backtrace) from [<c0012d04>] (show_stack+0x10/0x14)
[    2.701808] [<c0012d04>] (show_stack) from [<c01f83fc>] (dump_stack+0x84/0xc4)
[    2.701824] [<c01f83fc>] (dump_stack) from [<c0023494>] (warn_slowpath_common+0x80/0xb0)
[    2.701836] [<c0023494>] (warn_slowpath_common) from [<c00234f4>] (warn_slowpath_fmt+0x30/0x40)
[    2.701849] [<c00234f4>] (warn_slowpath_fmt) from [<c056e6b8>] (__mutex_lock_slowpath+0x3bc/0x404)
[    2.701864] [<c056e6b8>] (__mutex_lock_slowpath) from [<c056e70c>] (mutex_lock+0xc/0x24)
[    2.701884] [<c056e70c>] (mutex_lock) from [<c0228984>] (pwm_enable+0x20/0x7c)
[    2.701903] [<c0228984>] (pwm_enable) from [<c03f0000>] (led_heartbeat_function+0x74/0x144)
[    2.701919] [<c03f0000>] (led_heartbeat_function) from [<c0074368>] (call_timer_fn+0x24/0x98)
[    2.701932] [<c0074368>] (call_timer_fn) from [<c007453c>] (run_timer_softirq+0x160/0x21c)
[    2.701946] [<c007453c>] (run_timer_softirq) from [<c0026e10>] (__do_softirq+0x110/0x228)
[    2.701959] [<c0026e10>] (__do_softirq) from [<c00271c8>] (irq_exit+0xc0/0xfc)
[    2.701976] [<c00271c8>] (irq_exit) from [<c0065180>] (__handle_domain_irq+0x80/0xec)
[    2.701990] [<c0065180>] (__handle_domain_irq) from [<c0009494>] (gic_handle_irq+0x54/0x94)
[    2.702001] [<c0009494>] (gic_handle_irq) from [<c0013794>] (__irq_svc+0x54/0x90)
[    2.702008] Exception stack(0xee8bdf88 to 0xee8bdfd0)
[    2.702019] df80:                   00000001 00000000 00000000 c001b720 ee8bc000 c0573354
[    2.702031] dfa0: 00000000 00000000 ee8bdfe0 c07f92e4 c08004b4 c08004bc f0806640 ee8bdfd8
[    2.702039] dfc0: c0010180 c0010184 60000013 ffffffff
[    2.702053] [<c0013794>] (__irq_svc) from [<c0010184>] (arch_cpu_idle+0x38/0x3c)
[    2.702073] [<c0010184>] (arch_cpu_idle) from [<c0058ed4>] (cpu_startup_entry+0x1ec/0x270)
[    2.702086] [<c0058ed4>] (cpu_startup_entry) from [<4000956c>] (0x4000956c)
[    2.702093] ---[ end trace 539af70491f4f1a9 ]---

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/pwm/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index d24ca5f..b8f035a 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -506,16 +506,12 @@ int pwm_enable(struct pwm_device *pwm)
 	if (!pwm)
 		return -EINVAL;
 
-	mutex_lock(&pwm->lock);
-
 	if (!test_and_set_bit(PWMF_ENABLED, &pwm->flags)) {
 		err = pwm->chip->ops->enable(pwm->chip, pwm);
 		if (err)
 			clear_bit(PWMF_ENABLED, &pwm->flags);
 	}
 
-	mutex_unlock(&pwm->lock);
-
 	return err;
 }
 EXPORT_SYMBOL_GPL(pwm_enable);
-- 
2.1.4
