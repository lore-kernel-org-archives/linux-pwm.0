From: Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH] pwm: Avoid double mutex lock on pwm_enable
Date: Sat, 21 Nov 2015 17:41:22 +0530
Message-ID: <CANAwSgQZnUxRR_2077Hmj=qLzAz_UNUqVWmaiy5MxSCNrk=nJg@mail.gmail.com>
References: <1448038740-2811-1-git-send-email-linux.amoon@gmail.com>
 <564FF287.8000201@samsung.com> <CANAwSgSRT8KYr1gAYUvspzMaqT3-3W_c7taMq5YdMo4nB3oB2Q@mail.gmail.com>
 <CAJKOXPdejej2eo4M3fuV9jn7sMMwi7zADsvmvP0n60hW9ER_oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37073 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbbKUMLo (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sat, 21 Nov 2015 07:11:44 -0500
In-Reply-To: <CAJKOXPdejej2eo4M3fuV9jn7sMMwi7zADsvmvP0n60hW9ER_oQ@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Thierry Reding <thierry.reding@gmail.com>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-pwm@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Jonathan Richardson <jonathar@broadcom.com>

hi Krzysztof,

On 21 November 2015 at 15:22, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> 2015-11-21 18:40 GMT+09:00 Anand Moon <linux.amoon@gmail.com>:
>> hi Krzysztof,
>>
>> On 21 November 2015 at 09:56, Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> wrote:
>>>
>>> W dniu 21.11.2015 o 01:59, Anand Moon pisze:
>>> > Commit d1cd21427747f15920cd726f5f67a07880e7dee4
>>> > (pwm: Set enable state properly on failed call to enable)
>>> > introduce double lock of mutex on pwm_enable
>>> >
>>> > Changes fix the following debug lock warning.
>>> >
>>> > [    2.701720] WARNING: CPU: 3 PID: 0 at kernel/locking/mutex.c:526
>>> > __mutex_lock_slowpath+0x3bc/0x404()
>>> > [    2.701731] DEBUG_LOCKS_WARN_ON(in_interrupt())
>>>
>>> Hi Anand!
>>>
>>> Yeah, I am hitting this as well. Annoying. However your description is
>>> inaccurate. Double lock of mutex does not cause warnings of sleeping or
>>> locking in atomic context (if you build with debug sleep atomic you will
>>> see different warning). More over you are partially reverting the commit
>>> d1cd21427747 ("pwm: Set enable state properly on failed call to enable")
>>> without proper explanation:
>>> 1. why this locking is inappropriate;
>>> 2. why it is safe to remove the mutex_lock().
>>>
>>> Please find the real problem, fix the real problem and throughly explain
>>> the real issue.
>>>
>>> I was suspecting some weird changes in timers. For !irqsafe timer I
>>> think it is safe to use mutexes... but apparently not. Maybe a work
>>> should be scheduled from function called by timer?
>>>
>>> Warning with debug atomic sleep:
>>> [   16.047517] BUG: sleeping function called from invalid context at
>>> ../kernel/locking/mutex.c:617
>>> [   16.054866] in_atomic(): 1, irqs_disabled(): 0, pid: 0, name: swapper/0
>>> [   16.061402] INFO: lockdep is turned off.
>>> [   16.065281] Preemption disabled at:[<  (null)>]   (null)
>>> [   16.070524]
>>> [   16.072002] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
>>> 4.4.0-rc1-00040-g28c429565d4f #290
>>> [   16.080150] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
>>> [   16.086215] [<c0016780>] (unwind_backtrace) from [<c00132f0>]
>>> (show_stack+0x10/0x14)
>>> [   16.093938] [<c00132f0>] (show_stack) from [<c0223ba4>]
>>> (dump_stack+0x70/0xbc)
>>> [   16.101122] [<c0223ba4>] (dump_stack) from [<c05ed8e0>]
>>> (mutex_lock_nested+0x24/0x474)
>>> [   16.109009] [<c05ed8e0>] (mutex_lock_nested) from [<c0259154>]
>>> (pwm_enable+0x20/0x7c)
>>> [   16.116799] [<c0259154>] (pwm_enable) from [<c04400bc>]
>>> (led_heartbeat_function+0xdc/0x140)
>>> [   16.125119] [<c04400bc>] (led_heartbeat_function) from [<c00864c8>]
>>> (call_timer_fn+0x6c/0xf4)
>>> [   16.133606] [<c00864c8>] (call_timer_fn) from [<c00866f8>]
>>> (run_timer_softirq+0x1a8/0x230)
>>> [   16.141846] [<c00866f8>] (run_timer_softirq) from [<c0028e68>]
>>> (__do_softirq+0x134/0x2c0)
>>> [   16.149982] [<c0028e68>] (__do_softirq) from [<c0029334>]
>>> (irq_exit+0xd0/0x114)
>>> [   16.157255] [<c0029334>] (irq_exit) from [<c0076610>]
>>> (__handle_domain_irq+0x70/0xe4)
>>> [   16.165056] [<c0076610>] (__handle_domain_irq) from [<c00094e8>]
>>> (gic_handle_irq+0x4c/0x94)
>>> [   16.173376] [<c00094e8>] (gic_handle_irq) from [<c0013db8>]
>>> (__irq_svc+0x58/0x98)
>>> [   16.180817] Exception stack(0xc08cdf58 to 0xc08cdfa0)
>>> [   16.185823] df40:
>>>    c0010dcc 00000000
>>> [   16.193997] df60: c08cdfa8 00000000 c05f57c4 00000000 c08ca520
>>> c08ce4bc c08c7364 c08ce4b4
>>> [   16.202141] df80: c09121ca 00000000 00000001 c08cdfa8 c0010dcc
>>> c0010dd0 600f0013 ffffffff
>>> [   16.210291] [<c0013db8>] (__irq_svc) from [<c0010dd0>]
>>> (arch_cpu_idle+0x20/0x3c)
>>> [   16.217661] [<c0010dd0>] (arch_cpu_idle) from [<c0063174>]
>>> (cpu_startup_entry+0x17c/0x26c)
>>> [   16.225899] [<c0063174>] (cpu_startup_entry) from [<c0860c40>]
>>> (start_kernel+0x368/0x3d0)
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>>
>>> > [    2.701737] Modules linked in:
>>> > [    2.701748] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 4.4.0-rc1-xu4f
>>> > #24
>>> > [    2.701753] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
>>> > [    2.701787] [<c0015f48>] (unwind_backtrace) from [<c0012d04>]
>>> > (show_stack+0x10/0x14)
>>> > [    2.701808] [<c0012d04>] (show_stack) from [<c01f83fc>]
>>> > (dump_stack+0x84/0xc4)
>>> > [    2.701824] [<c01f83fc>] (dump_stack) from [<c0023494>]
>>> > (warn_slowpath_common+0x80/0xb0)
>>> > [    2.701836] [<c0023494>] (warn_slowpath_common) from [<c00234f4>]
>>> > (warn_slowpath_fmt+0x30/0x40)
>>> > [    2.701849] [<c00234f4>] (warn_slowpath_fmt) from [<c056e6b8>]
>>> > (__mutex_lock_slowpath+0x3bc/0x404)
>>> > [    2.701864] [<c056e6b8>] (__mutex_lock_slowpath) from [<c056e70c>]
>>> > (mutex_lock+0xc/0x24)
>>> > [    2.701884] [<c056e70c>] (mutex_lock) from [<c0228984>]
>>> > (pwm_enable+0x20/0x7c)
>>> > [    2.701903] [<c0228984>] (pwm_enable) from [<c03f0000>]
>>> > (led_heartbeat_function+0x74/0x144)
>>> > [    2.701919] [<c03f0000>] (led_heartbeat_function) from [<c0074368>]
>>> > (call_timer_fn+0x24/0x98)
>>> > [    2.701932] [<c0074368>] (call_timer_fn) from [<c007453c>]
>>> > (run_timer_softirq+0x160/0x21c)
>>> > [    2.701946] [<c007453c>] (run_timer_softirq) from [<c0026e10>]
>>> > (__do_softirq+0x110/0x228)
>>> > [    2.701959] [<c0026e10>] (__do_softirq) from [<c00271c8>]
>>> > (irq_exit+0xc0/0xfc)
>>> > [    2.701976] [<c00271c8>] (irq_exit) from [<c0065180>]
>>> > (__handle_domain_irq+0x80/0xec)
>>> > [    2.701990] [<c0065180>] (__handle_domain_irq) from [<c0009494>]
>>> > (gic_handle_irq+0x54/0x94)
>>> > [    2.702001] [<c0009494>] (gic_handle_irq) from [<c0013794>]
>>> > (__irq_svc+0x54/0x90)
>>> > [    2.702008] Exception stack(0xee8bdf88 to 0xee8bdfd0)
>>> > [    2.702019] df80:                   00000001 00000000 00000000
>>> > c001b720 ee8bc000 c0573354
>>> > [    2.702031] dfa0: 00000000 00000000 ee8bdfe0 c07f92e4 c08004b4
>>> > c08004bc f0806640 ee8bdfd8
>>> > [    2.702039] dfc0: c0010180 c0010184 60000013 ffffffff
>>> > [    2.702053] [<c0013794>] (__irq_svc) from [<c0010184>]
>>> > (arch_cpu_idle+0x38/0x3c)
>>> > [    2.702073] [<c0010184>] (arch_cpu_idle) from [<c0058ed4>]
>>> > (cpu_startup_entry+0x1ec/0x270)
>>> > [    2.702086] [<c0058ed4>] (cpu_startup_entry) from [<4000956c>]
>>> > (0x4000956c)
>>> > [    2.702093] ---[ end trace 539af70491f4f1a9 ]---
>>> >
>>> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>> > ---
>>> >  drivers/pwm/core.c | 4 ----
>>> >  1 file changed, 4 deletions(-)
>>> >
>>> > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
>>> > index d24ca5f..b8f035a 100644
>>> > --- a/drivers/pwm/core.c
>>> > +++ b/drivers/pwm/core.c
>>> > @@ -506,16 +506,12 @@ int pwm_enable(struct pwm_device *pwm)
>>> >       if (!pwm)
>>> >               return -EINVAL;
>>> >
>>> > -     mutex_lock(&pwm->lock);
>>> > -
>>> >       if (!test_and_set_bit(PWMF_ENABLED, &pwm->flags)) {
>>> >               err = pwm->chip->ops->enable(pwm->chip, pwm);
>>> >               if (err)
>>> >                       clear_bit(PWMF_ENABLED, &pwm->flags);
>>> >       }
>>> >
>>> > -     mutex_unlock(&pwm->lock);
>>> > -
>>> >       return err;
>>> >  }
>>> >  EXPORT_SYMBOL_GPL(pwm_enable);
>>> >
>>
>>
>> Adding Jonathan Richardson.
>>
>> Yes I am
>>
>> aware I am reverting some part of the d1cd21427747 ("pwm: Set enable state
>> properly on failed call to enable")
>>
>> Please take a look at this below commit.
>>
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/pwm/core.c?id=d1cd21427747f15920cd726f5f67a07880e7dee4
>>
>> Actually reverting this change it work fine.
>>
>> This changes introduce the new mutex lock pwm->lock to protect enabled bit
>> by drivers while setting polarity.
>>
>> Well pwm_set_polarity already acquires the pwm->lock and calls
>> pwm_is_enabled function.
>> Again within pwm_is_enabled we are trying to acquire the same mutex lock.
>
> You are describing a lockdown by trying to acquire the same mutex twice.
>
> However pwm_is_enabled() does not acquire mutex.
>
> Again, please look at generated warnings:
> 1. BUG: sleeping function called from invalid context
> 2. DEBUG_LOCKS_WARN_ON(in_interrupt())
>
> They are not related anyhow to what you described (acquiring already
> locked mutex).
>
> Best regards,
> Krzysztof

My last reply mail went in HTML format so resend this.

First it was a typo on my part.
It not pwm_is_enabled function its pwm_enabled.

Please take a look at the snip of the commit
d1cd21427747f15920cd726f5f67a07880e7dee4

@@ -494,10 +501,22 @@ EXPORT_SYMBOL_GPL(pwm_set_polarity);
*/
int pwm_enable(struct pwm_device *pwm)
{
- if (pwm && !test_and_set_bit(PWMF_ENABLED, &pwm->flags))
- return pwm->chip->ops->enable(pwm->chip, pwm);
+ int err = 0;
+
+ if (!pwm)
+ return -EINVAL;
+
+ mutex_lock(&pwm->lock);
+
+ if (!test_and_set_bit(PWMF_ENABLED, &pwm->flags)) {
+ err = pwm->chip->ops->enable(pwm->chip, pwm);
+ if (err)
+ clear_bit(PWMF_ENABLED, &pwm->flags);
+ }
+
+ mutex_unlock(&pwm->lock);
- return pwm ? 0 : -EINVAL;
+ return err;
}
EXPORT_SYMBOL_GPL(pwm_enable);

Yes it a lockdown of mutex, trying to acquire same mutex

I don't know how the backtrace will get generate.
1 (BUG: sleeping function called from invalid context)
2 DEBUG_LOCKS_WARN_ON(in_interrupt())

-Anand Moon
