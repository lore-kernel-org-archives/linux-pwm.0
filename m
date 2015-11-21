Return-Path: <linux.amoon@gmail.com>
MIME-Version: 1.0
In-Reply-To: <564FF287.8000201@samsung.com>
References: <1448038740-2811-1-git-send-email-linux.amoon@gmail.com> <564FF287.8000201@samsung.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 21 Nov 2015 15:10:41 +0530
Message-ID: <CANAwSgSRT8KYr1gAYUvspzMaqT3-3W_c7taMq5YdMo4nB3oB2Q@mail.gmail.com>
Subject: Re: [PATCH] pwm: Avoid double mutex lock on pwm_enable
Content-Type: multipart/alternative; boundary=001a114a08f437b5c6052509ca94
List-ID: <linux-pwm.vger.kernel.org>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Thierry Reding <thierry.reding@gmail.com>, Javier Martinez Canillas <javier@osg.samsung.com>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>, linux-pwm@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Jonathan Richardson <jonathar@broadcom.com>

--001a114a08f437b5c6052509ca94
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

hi =E2=80=8BKrzysztof,

On 21 November 2015 at 09:56, Krzysztof Kozlowski <k.kozlowski@samsung.com>
wrote:

> W dniu 21.11.2015 o 01:59, Anand Moon pisze:
> > Commit d1cd21427747f15920cd726f5f67a07880e7dee4
> > (pwm: Set enable state properly on failed call to enable)
> > introduce double lock of mutex on pwm_enable
> >
> > Changes fix the following debug lock warning.
> >
> > [    2.701720] WARNING: CPU: 3 PID: 0 at kernel/locking/mutex.c:526
> __mutex_lock_slowpath+0x3bc/0x404()
> > [    2.701731] DEBUG_LOCKS_WARN_ON(in_interrupt())
>
> Hi Anand!
>
> Yeah, I am hitting this as well. Annoying. However your description is
> inaccurate. Double lock of mutex does not cause warnings of sleeping or
> locking in atomic context (if you build with debug sleep atomic you will
> see different warning). More over you are partially reverting the commit
> d1cd21427747 ("pwm: Set enable state properly on failed call to enable")
> without proper explanation:
> 1. why this locking is inappropriate;
> 2. why it is safe to remove the mutex_lock().
>
> Please find the real problem, fix the real problem and throughly explain
> the real issue.
>
> I was suspecting some weird changes in timers. For !irqsafe timer I
> think it is safe to use mutexes... but apparently not. Maybe a work
> should be scheduled from function called by timer?
>
> Warning with debug atomic sleep:
> [   16.047517] BUG: sleeping function called from invalid context at
> ../kernel/locking/mutex.c:617
> [   16.054866] in_atomic(): 1, irqs_disabled(): 0, pid: 0, name: swapper/=
0
> [   16.061402] INFO: lockdep is turned off.
> [   16.065281] Preemption disabled at:[<  (null)>]   (null)
> [   16.070524]
> [   16.072002] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
> 4.4.0-rc1-00040-g28c429565d4f #290
> [   16.080150] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [   16.086215] [<c0016780>] (unwind_backtrace) from [<c00132f0>]
> (show_stack+0x10/0x14)
> [   16.093938] [<c00132f0>] (show_stack) from [<c0223ba4>]
> (dump_stack+0x70/0xbc)
> [   16.101122] [<c0223ba4>] (dump_stack) from [<c05ed8e0>]
> (mutex_lock_nested+0x24/0x474)
> [   16.109009] [<c05ed8e0>] (mutex_lock_nested) from [<c0259154>]
> (pwm_enable+0x20/0x7c)
> [   16.116799] [<c0259154>] (pwm_enable) from [<c04400bc>]
> (led_heartbeat_function+0xdc/0x140)
> [   16.125119] [<c04400bc>] (led_heartbeat_function) from [<c00864c8>]
> (call_timer_fn+0x6c/0xf4)
> [   16.133606] [<c00864c8>] (call_timer_fn) from [<c00866f8>]
> (run_timer_softirq+0x1a8/0x230)
> [   16.141846] [<c00866f8>] (run_timer_softirq) from [<c0028e68>]
> (__do_softirq+0x134/0x2c0)
> [   16.149982] [<c0028e68>] (__do_softirq) from [<c0029334>]
> (irq_exit+0xd0/0x114)
> [   16.157255] [<c0029334>] (irq_exit) from [<c0076610>]
> (__handle_domain_irq+0x70/0xe4)
> [   16.165056] [<c0076610>] (__handle_domain_irq) from [<c00094e8>]
> (gic_handle_irq+0x4c/0x94)
> [   16.173376] [<c00094e8>] (gic_handle_irq) from [<c0013db8>]
> (__irq_svc+0x58/0x98)
> [   16.180817] Exception stack(0xc08cdf58 to 0xc08cdfa0)
> [   16.185823] df40:
>    c0010dcc 00000000
> [   16.193997] df60: c08cdfa8 00000000 c05f57c4 00000000 c08ca520
> c08ce4bc c08c7364 c08ce4b4
> [   16.202141] df80: c09121ca 00000000 00000001 c08cdfa8 c0010dcc
> c0010dd0 600f0013 ffffffff
> [   16.210291] [<c0013db8>] (__irq_svc) from [<c0010dd0>]
> (arch_cpu_idle+0x20/0x3c)
> [   16.217661] [<c0010dd0>] (arch_cpu_idle) from [<c0063174>]
> (cpu_startup_entry+0x17c/0x26c)
> [   16.225899] [<c0063174>] (cpu_startup_entry) from [<c0860c40>]
> (start_kernel+0x368/0x3d0)
>
> Best regards,
> =E2=80=8B=E2=80=8B
> Krzysztof
>
>
> > [    2.701737] Modules linked in:
> > [    2.701748] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 4.4.0-rc1-xu4f
> #24
> > [    2.701753] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> > [    2.701787] [<c0015f48>] (unwind_backtrace) from [<c0012d04>]
> (show_stack+0x10/0x14)
> > [    2.701808] [<c0012d04>] (show_stack) from [<c01f83fc>]
> (dump_stack+0x84/0xc4)
> > [    2.701824] [<c01f83fc>] (dump_stack) from [<c0023494>]
> (warn_slowpath_common+0x80/0xb0)
> > [    2.701836] [<c0023494>] (warn_slowpath_common) from [<c00234f4>]
> (warn_slowpath_fmt+0x30/0x40)
> > [    2.701849] [<c00234f4>] (warn_slowpath_fmt) from [<c056e6b8>]
> (__mutex_lock_slowpath+0x3bc/0x404)
> > [    2.701864] [<c056e6b8>] (__mutex_lock_slowpath) from [<c056e70c>]
> (mutex_lock+0xc/0x24)
> > [    2.701884] [<c056e70c>] (mutex_lock) from [<c0228984>]
> (pwm_enable+0x20/0x7c)
> > [    2.701903] [<c0228984>] (pwm_enable) from [<c03f0000>]
> (led_heartbeat_function+0x74/0x144)
> > [    2.701919] [<c03f0000>] (led_heartbeat_function) from [<c0074368>]
> (call_timer_fn+0x24/0x98)
> > [    2.701932] [<c0074368>] (call_timer_fn) from [<c007453c>]
> (run_timer_softirq+0x160/0x21c)
> > [    2.701946] [<c007453c>] (run_timer_softirq) from [<c0026e10>]
> (__do_softirq+0x110/0x228)
> > [    2.701959] [<c0026e10>] (__do_softirq) from [<c00271c8>]
> (irq_exit+0xc0/0xfc)
> > [    2.701976] [<c00271c8>] (irq_exit) from [<c0065180>]
> (__handle_domain_irq+0x80/0xec)
> > [    2.701990] [<c0065180>] (__handle_domain_irq) from [<c0009494>]
> (gic_handle_irq+0x54/0x94)
> > [    2.702001] [<c0009494>] (gic_handle_irq) from [<c0013794>]
> (__irq_svc+0x54/0x90)
> > [    2.702008] Exception stack(0xee8bdf88 to 0xee8bdfd0)
> > [    2.702019] df80:                   00000001 00000000 00000000
> c001b720 ee8bc000 c0573354
> > [    2.702031] dfa0: 00000000 00000000 ee8bdfe0 c07f92e4 c08004b4
> c08004bc f0806640 ee8bdfd8
> > [    2.702039] dfc0: c0010180 c0010184 60000013 ffffffff
> > [    2.702053] [<c0013794>] (__irq_svc) from [<c0010184>]
> (arch_cpu_idle+0x38/0x3c)
> > [    2.702073] [<c0010184>] (arch_cpu_idle) from [<c0058ed4>]
> (cpu_startup_entry+0x1ec/0x270)
> > [    2.702086] [<c0058ed4>] (cpu_startup_entry) from [<4000956c>]
> (0x4000956c)
> > [    2.702093] ---[ end trace 539af70491f4f1a9 ]---
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  drivers/pwm/core.c | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > index d24ca5f..b8f035a 100644
> > --- a/drivers/pwm/core.c
> > +++ b/drivers/pwm/core.c
> > @@ -506,16 +506,12 @@ int pwm_enable(struct pwm_device *pwm)
> >       if (!pwm)
> >               return -EINVAL;
> >
> > -     mutex_lock(&pwm->lock);
> > -
> >       if (!test_and_set_bit(PWMF_ENABLED, &pwm->flags)) {
> >               err =3D pwm->chip->ops->enable(pwm->chip, pwm);
> >               if (err)
> >                       clear_bit(PWMF_ENABLED, &pwm->flags);
> >       }
> >
> > -     mutex_unlock(&pwm->lock);
> > -
> >       return err;
> >  }
> >  EXPORT_SYMBOL_GPL(pwm_enable);
> >
>

=E2=80=8BAdding Jonathan Richardson.=E2=80=8B

=E2=80=8BYes I am =E2=80=8B

aware I am reverting some part of the =E2=80=8Bd1cd21427747 ("pwm: Set enab=
le state
properly on failed call to enable")

Please take a look at this below commit.

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/driv=
ers/pwm/core.c?id=3Dd1cd21427747f15920cd726f5f67a07880e7dee4

Actually reverting this change it work fine.

This changes introduce the new mutex lock pwm->lock to protect enabled bit
by drivers while setting polarity.

Well pwm_set_polarity already acquires the pwm->lock and calls
pwm_is_enabled function.
Again within pwm_is_enabled we are trying to acquire the same mutex lock.
I am just trying to remove this double mutex locking of pwm->lock.

Well I have tested this changes with CONFIG_DEBUG_ATOMIC_SLEEP=3Dy
and I did not find any more above mutex WARM / timer opps.

I will update the commit message with the reason of the fix.
I will take close look if I can fix it differently.
Thanks for you inputs.

Please share your thoughts on this.

-Anand Moon

--001a114a08f437b5c6052509ca94
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:monospac=
e,monospace">hi =E2=80=8BKrzysztof,</div><div class=3D"gmail_extra"><br><di=
v class=3D"gmail_quote">On 21 November 2015 at 09:56, Krzysztof Kozlowski <=
span dir=3D"ltr">&lt;<a href=3D"mailto:k.kozlowski@samsung.com" target=3D"_=
blank">k.kozlowski@samsung.com</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">W dniu 21.11.2015 o 01:59, Anand Moon pisz=
e:<br>
&gt; Commit d1cd21427747f15920cd726f5f67a07880e7dee4<br>
&gt; (pwm: Set enable state properly on failed call to enable)<br>
&gt; introduce double lock of mutex on pwm_enable<br>
&gt;<br>
&gt; Changes fix the following debug lock warning.<br>
&gt;<br>
&gt; [=C2=A0 =C2=A0 2.701720] WARNING: CPU: 3 PID: 0 at kernel/locking/mute=
x.c:526 __mutex_lock_slowpath+0x3bc/0x404()<br>
&gt; [=C2=A0 =C2=A0 2.701731] DEBUG_LOCKS_WARN_ON(in_interrupt())<br>
<br>
Hi Anand!<br>
<br>
Yeah, I am hitting this as well. Annoying. However your description is<br>
inaccurate. Double lock of mutex does not cause warnings of sleeping or<br>
locking in atomic context (if you build with debug sleep atomic you will<br=
>
see different warning). More over you are partially reverting the commit<br=
>
d1cd21427747 (&quot;pwm: Set enable state properly on failed call to enable=
&quot;)<br>
without proper explanation:<br>
1. why this locking is inappropriate;<br>
2. why it is safe to remove the mutex_lock().<br>
<br>
Please find the real problem, fix the real problem and throughly explain<br=
>
the real issue.<br>
<br>
I was suspecting some weird changes in timers. For !irqsafe timer I<br>
think it is safe to use mutexes... but apparently not. Maybe a work<br>
should be scheduled from function called by timer?<br>
<br>
Warning with debug atomic sleep:<br>
[=C2=A0 =C2=A016.047517] BUG: sleeping function called from invalid context=
 at<br>
../kernel/locking/mutex.c:617<br>
[=C2=A0 =C2=A016.054866] in_atomic(): 1, irqs_disabled(): 0, pid: 0, name: =
swapper/0<br>
[=C2=A0 =C2=A016.061402] INFO: lockdep is turned off.<br>
[=C2=A0 =C2=A016.065281] Preemption disabled at:[&lt;=C2=A0 (null)&gt;]=C2=
=A0 =C2=A0(null)<br>
[=C2=A0 =C2=A016.070524]<br>
[=C2=A0 =C2=A016.072002] CPU: 0 PID: 0 Comm: swapper/0 Not tainted<br>
4.4.0-rc1-00040-g28c429565d4f #290<br>
[=C2=A0 =C2=A016.080150] Hardware name: SAMSUNG EXYNOS (Flattened Device Tr=
ee)<br>
[=C2=A0 =C2=A016.086215] [&lt;c0016780&gt;] (unwind_backtrace) from [&lt;c0=
0132f0&gt;]<br>
(show_stack+0x10/0x14)<br>
[=C2=A0 =C2=A016.093938] [&lt;c00132f0&gt;] (show_stack) from [&lt;c0223ba4=
&gt;]<br>
(dump_stack+0x70/0xbc)<br>
[=C2=A0 =C2=A016.101122] [&lt;c0223ba4&gt;] (dump_stack) from [&lt;c05ed8e0=
&gt;]<br>
(mutex_lock_nested+0x24/0x474)<br>
[=C2=A0 =C2=A016.109009] [&lt;c05ed8e0&gt;] (mutex_lock_nested) from [&lt;c=
0259154&gt;]<br>
(pwm_enable+0x20/0x7c)<br>
[=C2=A0 =C2=A016.116799] [&lt;c0259154&gt;] (pwm_enable) from [&lt;c04400bc=
&gt;]<br>
(led_heartbeat_function+0xdc/0x140)<br>
[=C2=A0 =C2=A016.125119] [&lt;c04400bc&gt;] (led_heartbeat_function) from [=
&lt;c00864c8&gt;]<br>
(call_timer_fn+0x6c/0xf4)<br>
[=C2=A0 =C2=A016.133606] [&lt;c00864c8&gt;] (call_timer_fn) from [&lt;c0086=
6f8&gt;]<br>
(run_timer_softirq+0x1a8/0x230)<br>
[=C2=A0 =C2=A016.141846] [&lt;c00866f8&gt;] (run_timer_softirq) from [&lt;c=
0028e68&gt;]<br>
(__do_softirq+0x134/0x2c0)<br>
[=C2=A0 =C2=A016.149982] [&lt;c0028e68&gt;] (__do_softirq) from [&lt;c00293=
34&gt;]<br>
(irq_exit+0xd0/0x114)<br>
[=C2=A0 =C2=A016.157255] [&lt;c0029334&gt;] (irq_exit) from [&lt;c0076610&g=
t;]<br>
(__handle_domain_irq+0x70/0xe4)<br>
[=C2=A0 =C2=A016.165056] [&lt;c0076610&gt;] (__handle_domain_irq) from [&lt=
;c00094e8&gt;]<br>
(gic_handle_irq+0x4c/0x94)<br>
[=C2=A0 =C2=A016.173376] [&lt;c00094e8&gt;] (gic_handle_irq) from [&lt;c001=
3db8&gt;]<br>
(__irq_svc+0x58/0x98)<br>
[=C2=A0 =C2=A016.180817] Exception stack(0xc08cdf58 to 0xc08cdfa0)<br>
[=C2=A0 =C2=A016.185823] df40:<br>
=C2=A0 =C2=A0c0010dcc 00000000<br>
[=C2=A0 =C2=A016.193997] df60: c08cdfa8 00000000 c05f57c4 00000000 c08ca520=
<br>
c08ce4bc c08c7364 c08ce4b4<br>
[=C2=A0 =C2=A016.202141] df80: c09121ca 00000000 00000001 c08cdfa8 c0010dcc=
<br>
c0010dd0 600f0013 ffffffff<br>
[=C2=A0 =C2=A016.210291] [&lt;c0013db8&gt;] (__irq_svc) from [&lt;c0010dd0&=
gt;]<br>
(arch_cpu_idle+0x20/0x3c)<br>
[=C2=A0 =C2=A016.217661] [&lt;c0010dd0&gt;] (arch_cpu_idle) from [&lt;c0063=
174&gt;]<br>
(cpu_startup_entry+0x17c/0x26c)<br>
[=C2=A0 =C2=A016.225899] [&lt;c0063174&gt;] (cpu_startup_entry) from [&lt;c=
0860c40&gt;]<br>
(start_kernel+0x368/0x3d0)<br>
<br>
Best regards,<br>
<div class=3D"gmail_default" style=3D"font-family:monospace,monospace;displ=
ay:inline">=E2=80=8B=E2=80=8B</div>Krzysztof<br>
<br>
<br>
&gt; [=C2=A0 =C2=A0 2.701737] Modules linked in:<br>
&gt; [=C2=A0 =C2=A0 2.701748] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 4.4=
.0-rc1-xu4f #24<br>
&gt; [=C2=A0 =C2=A0 2.701753] Hardware name: SAMSUNG EXYNOS (Flattened Devi=
ce Tree)<br>
&gt; [=C2=A0 =C2=A0 2.701787] [&lt;c0015f48&gt;] (unwind_backtrace) from [&=
lt;c0012d04&gt;] (show_stack+0x10/0x14)<br>
&gt; [=C2=A0 =C2=A0 2.701808] [&lt;c0012d04&gt;] (show_stack) from [&lt;c01=
f83fc&gt;] (dump_stack+0x84/0xc4)<br>
&gt; [=C2=A0 =C2=A0 2.701824] [&lt;c01f83fc&gt;] (dump_stack) from [&lt;c00=
23494&gt;] (warn_slowpath_common+0x80/0xb0)<br>
&gt; [=C2=A0 =C2=A0 2.701836] [&lt;c0023494&gt;] (warn_slowpath_common) fro=
m [&lt;c00234f4&gt;] (warn_slowpath_fmt+0x30/0x40)<br>
&gt; [=C2=A0 =C2=A0 2.701849] [&lt;c00234f4&gt;] (warn_slowpath_fmt) from [=
&lt;c056e6b8&gt;] (__mutex_lock_slowpath+0x3bc/0x404)<br>
&gt; [=C2=A0 =C2=A0 2.701864] [&lt;c056e6b8&gt;] (__mutex_lock_slowpath) fr=
om [&lt;c056e70c&gt;] (mutex_lock+0xc/0x24)<br>
&gt; [=C2=A0 =C2=A0 2.701884] [&lt;c056e70c&gt;] (mutex_lock) from [&lt;c02=
28984&gt;] (pwm_enable+0x20/0x7c)<br>
&gt; [=C2=A0 =C2=A0 2.701903] [&lt;c0228984&gt;] (pwm_enable) from [&lt;c03=
f0000&gt;] (led_heartbeat_function+0x74/0x144)<br>
&gt; [=C2=A0 =C2=A0 2.701919] [&lt;c03f0000&gt;] (led_heartbeat_function) f=
rom [&lt;c0074368&gt;] (call_timer_fn+0x24/0x98)<br>
&gt; [=C2=A0 =C2=A0 2.701932] [&lt;c0074368&gt;] (call_timer_fn) from [&lt;=
c007453c&gt;] (run_timer_softirq+0x160/0x21c)<br>
&gt; [=C2=A0 =C2=A0 2.701946] [&lt;c007453c&gt;] (run_timer_softirq) from [=
&lt;c0026e10&gt;] (__do_softirq+0x110/0x228)<br>
&gt; [=C2=A0 =C2=A0 2.701959] [&lt;c0026e10&gt;] (__do_softirq) from [&lt;c=
00271c8&gt;] (irq_exit+0xc0/0xfc)<br>
&gt; [=C2=A0 =C2=A0 2.701976] [&lt;c00271c8&gt;] (irq_exit) from [&lt;c0065=
180&gt;] (__handle_domain_irq+0x80/0xec)<br>
&gt; [=C2=A0 =C2=A0 2.701990] [&lt;c0065180&gt;] (__handle_domain_irq) from=
 [&lt;c0009494&gt;] (gic_handle_irq+0x54/0x94)<br>
&gt; [=C2=A0 =C2=A0 2.702001] [&lt;c0009494&gt;] (gic_handle_irq) from [&lt=
;c0013794&gt;] (__irq_svc+0x54/0x90)<br>
&gt; [=C2=A0 =C2=A0 2.702008] Exception stack(0xee8bdf88 to 0xee8bdfd0)<br>
&gt; [=C2=A0 =C2=A0 2.702019] df80:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A000000001 00000000 00000000 c001b720 ee8bc000=
 c0573354<br>
&gt; [=C2=A0 =C2=A0 2.702031] dfa0: 00000000 00000000 ee8bdfe0 c07f92e4 c08=
004b4 c08004bc f0806640 ee8bdfd8<br>
&gt; [=C2=A0 =C2=A0 2.702039] dfc0: c0010180 c0010184 60000013 ffffffff<br>
&gt; [=C2=A0 =C2=A0 2.702053] [&lt;c0013794&gt;] (__irq_svc) from [&lt;c001=
0184&gt;] (arch_cpu_idle+0x38/0x3c)<br>
&gt; [=C2=A0 =C2=A0 2.702073] [&lt;c0010184&gt;] (arch_cpu_idle) from [&lt;=
c0058ed4&gt;] (cpu_startup_entry+0x1ec/0x270)<br>
&gt; [=C2=A0 =C2=A0 2.702086] [&lt;c0058ed4&gt;] (cpu_startup_entry) from [=
&lt;4000956c&gt;] (0x4000956c)<br>
&gt; [=C2=A0 =C2=A0 2.702093] ---[ end trace 539af70491f4f1a9 ]---<br>
&gt;<br>
&gt; Signed-off-by: Anand Moon &lt;<a href=3D"mailto:linux.amoon@gmail.com"=
 target=3D"_blank">linux.amoon@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/pwm/core.c | 4 ----<br>
&gt;=C2=A0 1 file changed, 4 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c<br>
&gt; index d24ca5f..b8f035a 100644<br>
&gt; --- a/drivers/pwm/core.c<br>
&gt; +++ b/drivers/pwm/core.c<br>
&gt; @@ -506,16 +506,12 @@ int pwm_enable(struct pwm_device *pwm)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!pwm)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<=
br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;pwm-&gt;lock);<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!test_and_set_bit(PWMF_ENABLED, &amp;pwm=
-&gt;flags)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D pwm-&gt;=
chip-&gt;ops-&gt;enable(pwm-&gt;chip, pwm);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (err)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0clear_bit(PWMF_ENABLED, &amp;pwm-&gt;flags);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;pwm-&gt;lock);<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 EXPORT_SYMBOL_GPL(pwm_enable);<br>
&gt;<br></blockquote><div><br><div class=3D"gmail_default" style=3D"font-fa=
mily:monospace,monospace;display:inline">=E2=80=8BAdding Jonathan Richardso=
n.=E2=80=8B</div></div><div><br><div class=3D"gmail_default" style=3D"font-=
family:monospace,monospace;display:inline">=E2=80=8BYes I am =E2=80=8B</div=
>=C2=A0<div class=3D"gmail_default" style=3D"font-family:monospace,monospac=
e;display:inline">aware I am reverting some part of the =E2=80=8Bd1cd214277=
47 (&quot;pwm: Set enable state properly on failed call to enable&quot;)<br=
><br></div><div class=3D"gmail_default" style=3D"font-family:monospace,mono=
space;display:inline">Please take a look at this below commit.<br><br><a hr=
ef=3D"https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commi=
t/drivers/pwm/core.c?id=3Dd1cd21427747f15920cd726f5f67a07880e7dee4">https:/=
/git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/pwm=
/core.c?id=3Dd1cd21427747f15920cd726f5f67a07880e7dee4</a><br><br></div><div=
 class=3D"gmail_default" style=3D"font-family:monospace,monospace;display:i=
nline">Actually reverting this change it work fine.<br></div><div class=3D"=
gmail_default" style=3D"font-family:monospace,monospace;display:inline"><br=
></div><div class=3D"gmail_default" style=3D"font-family:monospace,monospac=
e;display:inline">This changes introduce the new mutex lock pwm-&gt;lock to=
 protect enabled bit by drivers while setting polarity.<br><br></div><div c=
lass=3D"gmail_default" style=3D"font-family:monospace,monospace;display:inl=
ine">Well pwm_set_polarity already acquires the pwm-&gt;lock and calls pwm_=
is_enabled function.<br></div><div class=3D"gmail_default" style=3D"font-fa=
mily:monospace,monospace;display:inline">Again within pwm_is_enabled we are=
 trying to acquire the same mutex lock.<br></div><div class=3D"gmail_defaul=
t" style=3D"font-family:monospace,monospace;display:inline">I am just tryin=
g to remove this double mutex locking of pwm-&gt;lock.<br><br></div><div cl=
ass=3D"gmail_default" style=3D"font-family:monospace,monospace;display:inli=
ne">Well I have tested this changes with CONFIG_DEBUG_ATOMIC_SLEEP=3Dy<br>a=
nd I did not find any more above mutex WARM / timer opps.<br><br>I will upd=
ate the commit message with the reason of the fix.<br></div><div class=3D"g=
mail_default" style=3D"font-family:monospace,monospace;display:inline">I wi=
ll take close look if I can fix it differently.<br>Thanks for you inputs.<b=
r></div><div class=3D"gmail_default" style=3D"font-family:monospace,monospa=
ce;display:inline"><br></div><div class=3D"gmail_default" style=3D"font-fam=
ily:monospace,monospace;display:inline">Please share your thoughts on this.=
<br><br></div><div class=3D"gmail_default" style=3D"font-family:monospace,m=
onospace;display:inline">-Anand Moon</div></div></div><br></div></div>

--001a114a08f437b5c6052509ca94--
