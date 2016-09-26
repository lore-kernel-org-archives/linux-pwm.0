From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH stable 4.4] pwm: Mark all devices as "might sleep"
Date: Mon, 26 Sep 2016 21:28:08 +0200
Message-ID: <1474918088-14184-1-git-send-email-krzk@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
List-Id: linux-pwm@vger.kernel.org

From: Thierry Reding <thierry.reding@gmail.com>

commit ff01c944cfa939f3474c28d88223213494aedf0b upstream.

Commit d1cd21427747 ("pwm: Set enable state properly on failed call to
enable") introduced a mutex that is needed to protect internal state of
PWM devices. Since that mutex is acquired in pwm_set_polarity() and in
pwm_enable() and might potentially block, all PWM devices effectively
become "might sleep".

It's rather pointless to keep the .can_sleep field around, but given
that there are external users let's postpone the removal for the next
release cycle.

[k.kozlowski]
This fixes warnings with DEBUG_ATOMIC_SLEEP enabled on Odroid XU3 board:
  BUG: sleeping function called from invalid context at ../kernel/locking/mutex.c:620
  in_atomic(): 1, irqs_disabled(): 0, pid: 0, name: swapper/1
  INFO: lockdep is turned off.
  Preemption disabled at:[<  (null)>]   (null)

  CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W       4.4.23-rc1-00043-g43ce821 #1461
  Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
  [<c00167c8>] (unwind_backtrace) from [<c001357c>] (show_stack+0x10/0x14)
  [<c001357c>] (show_stack) from [<c0237ee4>] (dump_stack+0x88/0x9c)
  [<c0237ee4>] (dump_stack) from [<c05d47f4>] (mutex_lock_nested+0x28/0x454)
  [<c05d47f4>] (mutex_lock_nested) from [<c026a7b0>] (pwm_enable+0x24/0x80)
  [<c026a7b0>] (pwm_enable) from [<c0439e94>] (led_heartbeat_function+0xe8/0x13c)
  [<c0439e94>] (led_heartbeat_function) from [<c007f0a0>] (call_timer_fn+0x6c/0xf4)
  [<c007f0a0>] (call_timer_fn) from [<c007f2c0>] (run_timer_softirq+0x198/0x21c)
  [<c007f2c0>] (run_timer_softirq) from [<c0027ed8>] (__do_softirq+0x110/0x228)
  [<c0027ed8>] (__do_softirq) from [<c00282cc>] (irq_exit+0xc0/0xfc)
  [<c00282cc>] (irq_exit) from [<c006f510>] (__handle_domain_irq+0x80/0xec)
  [<c006f510>] (__handle_domain_irq) from [<c00094ec>] (gic_handle_irq+0x54/0x98)
  [<c00094ec>] (gic_handle_irq) from [<c0014014>] (__irq_svc+0x54/0x90)
  Exception stack(0xee8bbf88 to 0xee8bbfd0)
  bf80:                   00000001 00000000 00000000 c001c080 ee8ba000 c05dc368
  bfa0: 00000000 00000000 ee8bbfe0 c0896364 c089e4b4 c089e4bc 00000001 ee8bbfd8
  bfc0: c0010280 c0010284 60080013 ffffffff
  [<c0014014>] (__irq_svc) from [<c0010284>] (arch_cpu_idle+0x38/0x3c)
  [<c0010284>] (arch_cpu_idle) from [<c005ef94>] (cpu_startup_entry+0x1ec/0x270)
  [<c005ef94>] (cpu_startup_entry) from [<400095cc>] (0x400095cc)

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Fixes: Fixes: d1cd21427747 ("pwm: Set enable state properly on failed call to enable")
Cc: <stable@vger.kernel.org> # v4.4
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/pwm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index d24ca5f281b4..7831bc6b51dd 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -889,7 +889,7 @@ EXPORT_SYMBOL_GPL(devm_pwm_put);
   */
 bool pwm_can_sleep(struct pwm_device *pwm)
 {
-	return pwm->chip->can_sleep;
+	return true;
 }
 EXPORT_SYMBOL_GPL(pwm_can_sleep);
 
-- 
2.7.4
