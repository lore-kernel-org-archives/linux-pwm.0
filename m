Return-Path: <linux.amoon@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJKOXPdejej2eo4M3fuV9jn7sMMwi7zADsvmvP0n60hW9ER_oQ@mail.gmail.com>
References: <1448038740-2811-1-git-send-email-linux.amoon@gmail.com>
 <564FF287.8000201@samsung.com> <CANAwSgSRT8KYr1gAYUvspzMaqT3-3W_c7taMq5YdMo4nB3oB2Q@mail.gmail.com>
 <CAJKOXPdejej2eo4M3fuV9jn7sMMwi7zADsvmvP0n60hW9ER_oQ@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 21 Nov 2015 16:09:12 +0530
Message-ID: <CANAwSgQcaST7VPnbDqZ3wr4QxiA72-j7R26i+_G5FaAthNhTeg@mail.gmail.com>
Subject: Re: [PATCH] pwm: Avoid double mutex lock on pwm_enable
Content-Type: multipart/alternative; boundary=001a114a08f478617205250a9be0
List-ID: <linux-pwm.vger.kernel.org>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Thierry Reding <thierry.reding@gmail.com>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-pwm@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Jonathan Richardson <jonathar@broadcom.com>

--001a114a08f478617205250a9be0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi krzysztof,

On 21 November 2015 at 15:22, Krzysztof Kozlowski <k.kozlowski@samsung.com>
wrote:

> 2015-11-21 18:40 GMT+09:00 Anand Moon <linux.amoon@gmail.com>:
> > hi Krzysztof,
> >
> > On 21 November 2015 at 09:56, Krzysztof Kozlowski <
> k.kozlowski@samsung.com>
> > wrote:
> >>
> >> W dniu 21.11.2015 o 01:59, Anand Moon pisze:
> >> > Commit d1cd21427747f15920cd726f5f67a07880e7dee4
> >> > (pwm: Set enable state properly on failed call to enable)
> >> > introduce double lock of mutex on pwm_enable
> >> >
> >> > Changes fix the following debug lock warning.
> >> >
> >> > [    2.701720] WARNING: CPU: 3 PID: 0 at kernel/locking/mutex.c:526
> >> > __mutex_lock_slowpath+0x3bc/0x404()
> >> > [    2.701731] DEBUG_LOCKS_WARN_ON(in_interrupt())
> >>
> >> Hi Anand!
> >>
> >> Yeah, I am hitting this as well. Annoying. However your description is
> >> inaccurate. Double lock of mutex does not cause warnings of sleeping o=
r
> >> locking in atomic context (if you build with debug sleep atomic you wi=
ll
> >> see different warning). More over you are partially reverting the comm=
it
> >> d1cd21427747 ("pwm: Set enable state properly on failed call to enable=
")
> >> without proper explanation:
> >> 1. why this locking is inappropriate;
> >> 2. why it is safe to remove the mutex_lock().
> >>
> >> Please find the real problem, fix the real problem and throughly expla=
in
> >> the real issue.
> >>
> >> I was suspecting some weird changes in timers. For !irqsafe timer I
> >> think it is safe to use mutexes... but apparently not. Maybe a work
> >> should be scheduled from function called by timer?
> >>
> >> Warning with debug atomic sleep:
> >> [   16.047517] BUG: sleeping function called from invalid context at
> >> ../kernel/locking/mutex.c:617
> >> [   16.054866] in_atomic(): 1, irqs_disabled(): 0, pid: 0, name:
> swapper/0
> >> [   16.061402] INFO: lockdep is turned off.
> >> [   16.065281] Preemption disabled at:[<  (null)>]   (null)
> >> [   16.070524]
> >> [   16.072002] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
> >> 4.4.0-rc1-00040-g28c429565d4f #290
> >> [   16.080150] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> >> [   16.086215] [<c0016780>] (unwind_backtrace) from [<c00132f0>]
> >> (show_stack+0x10/0x14)
> >> [   16.093938] [<c00132f0>] (show_stack) from [<c0223ba4>]
> >> (dump_stack+0x70/0xbc)
> >> [   16.101122] [<c0223ba4>] (dump_stack) from [<c05ed8e0>]
> >> (mutex_lock_nested+0x24/0x474)
> >> [   16.109009] [<c05ed8e0>] (mutex_lock_nested) from [<c0259154>]
> >> (pwm_enable+0x20/0x7c)
> >> [   16.116799] [<c0259154>] (pwm_enable) from [<c04400bc>]
> >> (led_heartbeat_function+0xdc/0x140)
> >> [   16.125119] [<c04400bc>] (led_heartbeat_function) from [<c00864c8>]
> >> (call_timer_fn+0x6c/0xf4)
> >> [   16.133606] [<c00864c8>] (call_timer_fn) from [<c00866f8>]
> >> (run_timer_softirq+0x1a8/0x230)
> >> [   16.141846] [<c00866f8>] (run_timer_softirq) from [<c0028e68>]
> >> (__do_softirq+0x134/0x2c0)
> >> [   16.149982] [<c0028e68>] (__do_softirq) from [<c0029334>]
> >> (irq_exit+0xd0/0x114)
> >> [   16.157255] [<c0029334>] (irq_exit) from [<c0076610>]
> >> (__handle_domain_irq+0x70/0xe4)
> >> [   16.165056] [<c0076610>] (__handle_domain_irq) from [<c00094e8>]
> >> (gic_handle_irq+0x4c/0x94)
> >> [   16.173376] [<c00094e8>] (gic_handle_irq) from [<c0013db8>]
> >> (__irq_svc+0x58/0x98)
> >> [   16.180817] Exception stack(0xc08cdf58 to 0xc08cdfa0)
> >> [   16.185823] df40:
> >>    c0010dcc 00000000
> >> [   16.193997] df60: c08cdfa8 00000000 c05f57c4 00000000 c08ca520
> >> c08ce4bc c08c7364 c08ce4b4
> >> [   16.202141] df80: c09121ca 00000000 00000001 c08cdfa8 c0010dcc
> >> c0010dd0 600f0013 ffffffff
> >> [   16.210291] [<c0013db8>] (__irq_svc) from [<c0010dd0>]
> >> (arch_cpu_idle+0x20/0x3c)
> >> [   16.217661] [<c0010dd0>] (arch_cpu_idle) from [<c0063174>]
> >> (cpu_startup_entry+0x17c/0x26c)
> >> [   16.225899] [<c0063174>] (cpu_startup_entry) from [<c0860c40>]
> >> (start_kernel+0x368/0x3d0)
> >>
> >> Best regards,
> >> Krzysztof
> >>
> >>
> >> > [    2.701737] Modules linked in:
> >> > [    2.701748] CPU: 3 PID: 0 Comm: swapper/3 Not tainted
> 4.4.0-rc1-xu4f
> >> > #24
> >> > [    2.701753] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> >> > [    2.701787] [<c0015f48>] (unwind_backtrace) from [<c0012d04>]
> >> > (show_stack+0x10/0x14)
> >> > [    2.701808] [<c0012d04>] (show_stack) from [<c01f83fc>]
> >> > (dump_stack+0x84/0xc4)
> >> > [    2.701824] [<c01f83fc>] (dump_stack) from [<c0023494>]
> >> > (warn_slowpath_common+0x80/0xb0)
> >> > [    2.701836] [<c0023494>] (warn_slowpath_common) from [<c00234f4>]
> >> > (warn_slowpath_fmt+0x30/0x40)
> >> > [    2.701849] [<c00234f4>] (warn_slowpath_fmt) from [<c056e6b8>]
> >> > (__mutex_lock_slowpath+0x3bc/0x404)
> >> > [    2.701864] [<c056e6b8>] (__mutex_lock_slowpath) from [<c056e70c>=
]
> >> > (mutex_lock+0xc/0x24)
> >> > [    2.701884] [<c056e70c>] (mutex_lock) from [<c0228984>]
> >> > (pwm_enable+0x20/0x7c)
> >> > [    2.701903] [<c0228984>] (pwm_enable) from [<c03f0000>]
> >> > (led_heartbeat_function+0x74/0x144)
> >> > [    2.701919] [<c03f0000>] (led_heartbeat_function) from [<c0074368=
>]
> >> > (call_timer_fn+0x24/0x98)
> >> > [    2.701932] [<c0074368>] (call_timer_fn) from [<c007453c>]
> >> > (run_timer_softirq+0x160/0x21c)
> >> > [    2.701946] [<c007453c>] (run_timer_softirq) from [<c0026e10>]
> >> > (__do_softirq+0x110/0x228)
> >> > [    2.701959] [<c0026e10>] (__do_softirq) from [<c00271c8>]
> >> > (irq_exit+0xc0/0xfc)
> >> > [    2.701976] [<c00271c8>] (irq_exit) from [<c0065180>]
> >> > (__handle_domain_irq+0x80/0xec)
> >> > [    2.701990] [<c0065180>] (__handle_domain_irq) from [<c0009494>]
> >> > (gic_handle_irq+0x54/0x94)
> >> > [    2.702001] [<c0009494>] (gic_handle_irq) from [<c0013794>]
> >> > (__irq_svc+0x54/0x90)
> >> > [    2.702008] Exception stack(0xee8bdf88 to 0xee8bdfd0)
> >> > [    2.702019] df80:                   00000001 00000000 00000000
> >> > c001b720 ee8bc000 c0573354
> >> > [    2.702031] dfa0: 00000000 00000000 ee8bdfe0 c07f92e4 c08004b4
> >> > c08004bc f0806640 ee8bdfd8
> >> > [    2.702039] dfc0: c0010180 c0010184 60000013 ffffffff
> >> > [    2.702053] [<c0013794>] (__irq_svc) from [<c0010184>]
> >> > (arch_cpu_idle+0x38/0x3c)
> >> > [    2.702073] [<c0010184>] (arch_cpu_idle) from [<c0058ed4>]
> >> > (cpu_startup_entry+0x1ec/0x270)
> >> > [    2.702086] [<c0058ed4>] (cpu_startup_entry) from [<4000956c>]
> >> > (0x4000956c)
> >> > [    2.702093] ---[ end trace 539af70491f4f1a9 ]---
> >> >
> >> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> >> > ---
> >> >  drivers/pwm/core.c | 4 ----
> >> >  1 file changed, 4 deletions(-)
> >> >
> >> > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> >> > index d24ca5f..b8f035a 100644
> >> > --- a/drivers/pwm/core.c
> >> > +++ b/drivers/pwm/core.c
> >> > @@ -506,16 +506,12 @@ int pwm_enable(struct pwm_device *pwm)
> >> >       if (!pwm)
> >> >               return -EINVAL;
> >> >
> >> > -     mutex_lock(&pwm->lock);
> >> > -
> >> >       if (!test_and_set_bit(PWMF_ENABLED, &pwm->flags)) {
> >> >               err =3D pwm->chip->ops->enable(pwm->chip, pwm);
> >> >               if (err)
> >> >                       clear_bit(PWMF_ENABLED, &pwm->flags);
> >> >       }
> >> >
> >> > -     mutex_unlock(&pwm->lock);
> >> > -
> >> >       return err;
> >> >  }
> >> >  EXPORT_SYMBOL_GPL(pwm_enable);
> >> >
> >
> >
> > Adding Jonathan Richardson.
> >
> > Yes I am
> >
> > aware I am reverting some part of the d1cd21427747 ("pwm: Set enable
> state
> > properly on failed call to enable")
> >
> > Please take a look at this below commit.
> >
> >
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/dr=
ivers/pwm/core.c?id=3Dd1cd21427747f15920cd726f5f67a07880e7dee4
> >
> > Actually reverting this change it work fine.
> >
> > This changes introduce the new mutex lock pwm->lock to protect enabled
> bit
> > by drivers while setting polarity.
> >
> > Well pwm_set_polarity already acquires the pwm->lock and calls
> > pwm_is_enabled function.
> > Again within pwm_is_enabled we are trying to acquire the same mutex loc=
k.
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
>

=E2=80=8BPlease take a look at the snip of the commit
d1cd21427747f15920cd726f5f67a07880e7dee4

@@ -494,10 +501,22 @@ EXPORT_SYMBOL_GPL(pwm_set_polarity);
*/
int pwm_enable(struct pwm_device *pwm)
{
- if (pwm && !test_and_set_bit(PWMF_ENABLED, &pwm->flags))
- return pwm->chip->ops->enable(pwm->chip, pwm);
+ int err =3D 0;
+
+ if (!pwm)
+ return -EINVAL;
+
+ mutex_lock(&pwm->lock);
+
+ if (!test_and_set_bit(PWMF_ENABLED, &pwm->flags)) {
+ err =3D pwm->chip->ops->enable(pwm->chip, pwm);
+ if (err)
+ clear_bit(PWMF_ENABLED, &pwm->flags);
+ }
+
+ mutex_unlock(&pwm->lock);
- return pwm ? 0 : -EINVAL;
+ return err;
}
EXPORT_SYMBOL_GPL(pwm_enable);

Yes it a lock down of mutex.

I don't know how the backtrace will get generate.
1 (BUG: sleeping function called from invalid context)
2 DEBUG_LOCKS_WARN_ON(in_interrupt())

-Anand Moon

--001a114a08f478617205250a9be0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:monospac=
e,monospace">Hi krzysztof,<br></div><div class=3D"gmail_extra"><br><div cla=
ss=3D"gmail_quote">On 21 November 2015 at 15:22, Krzysztof Kozlowski <span =
dir=3D"ltr">&lt;<a href=3D"mailto:k.kozlowski@samsung.com" target=3D"_blank=
">k.kozlowski@samsung.com</a>&gt;</span> wrote:<br><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">2015-11-21 18:40 GMT+09:00 Anand Moon &lt;<a href=
=3D"mailto:linux.amoon@gmail.com">linux.amoon@gmail.com</a>&gt;:<br>
&gt; hi Krzysztof,<br>
&gt;<br>
&gt; On 21 November 2015 at 09:56, Krzysztof Kozlowski &lt;<a href=3D"mailt=
o:k.kozlowski@samsung.com">k.kozlowski@samsung.com</a>&gt;<br>
&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; W dniu 21.11.2015 o 01:59, Anand Moon pisze:<br>
&gt;&gt; &gt; Commit d1cd21427747f15920cd726f5f67a07880e7dee4<br>
&gt;&gt; &gt; (pwm: Set enable state properly on failed call to enable)<br>
&gt;&gt; &gt; introduce double lock of mutex on pwm_enable<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Changes fix the following debug lock warning.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; [=C2=A0 =C2=A0 2.701720] WARNING: CPU: 3 PID: 0 at kernel/loc=
king/mutex.c:526<br>
&gt;&gt; &gt; __mutex_lock_slowpath+0x3bc/0x404()<br>
&gt;&gt; &gt; [=C2=A0 =C2=A0 2.701731] DEBUG_LOCKS_WARN_ON(in_interrupt())<=
br>
&gt;&gt;<br>
&gt;&gt; Hi Anand!<br>
&gt;&gt;<br>
&gt;&gt; Yeah, I am hitting this as well. Annoying. However your descriptio=
n is<br>
&gt;&gt; inaccurate. Double lock of mutex does not cause warnings of sleepi=
ng or<br>
&gt;&gt; locking in atomic context (if you build with debug sleep atomic yo=
u will<br>
&gt;&gt; see different warning). More over you are partially reverting the =
commit<br>
&gt;&gt; d1cd21427747 (&quot;pwm: Set enable state properly on failed call =
to enable&quot;)<br>
&gt;&gt; without proper explanation:<br>
&gt;&gt; 1. why this locking is inappropriate;<br>
&gt;&gt; 2. why it is safe to remove the mutex_lock().<br>
&gt;&gt;<br>
&gt;&gt; Please find the real problem, fix the real problem and throughly e=
xplain<br>
&gt;&gt; the real issue.<br>
&gt;&gt;<br>
&gt;&gt; I was suspecting some weird changes in timers. For !irqsafe timer =
I<br>
&gt;&gt; think it is safe to use mutexes... but apparently not. Maybe a wor=
k<br>
&gt;&gt; should be scheduled from function called by timer?<br>
&gt;&gt;<br>
&gt;&gt; Warning with debug atomic sleep:<br>
&gt;&gt; [=C2=A0 =C2=A016.047517] BUG: sleeping function called from invali=
d context at<br>
&gt;&gt; ../kernel/locking/mutex.c:617<br>
&gt;&gt; [=C2=A0 =C2=A016.054866] in_atomic(): 1, irqs_disabled(): 0, pid: =
0, name: swapper/0<br>
&gt;&gt; [=C2=A0 =C2=A016.061402] INFO: lockdep is turned off.<br>
&gt;&gt; [=C2=A0 =C2=A016.065281] Preemption disabled at:[&lt;=C2=A0 (null)=
&gt;]=C2=A0 =C2=A0(null)<br>
&gt;&gt; [=C2=A0 =C2=A016.070524]<br>
&gt;&gt; [=C2=A0 =C2=A016.072002] CPU: 0 PID: 0 Comm: swapper/0 Not tainted=
<br>
&gt;&gt; 4.4.0-rc1-00040-g28c429565d4f #290<br>
&gt;&gt; [=C2=A0 =C2=A016.080150] Hardware name: SAMSUNG EXYNOS (Flattened =
Device Tree)<br>
&gt;&gt; [=C2=A0 =C2=A016.086215] [&lt;c0016780&gt;] (unwind_backtrace) fro=
m [&lt;c00132f0&gt;]<br>
&gt;&gt; (show_stack+0x10/0x14)<br>
&gt;&gt; [=C2=A0 =C2=A016.093938] [&lt;c00132f0&gt;] (show_stack) from [&lt=
;c0223ba4&gt;]<br>
&gt;&gt; (dump_stack+0x70/0xbc)<br>
&gt;&gt; [=C2=A0 =C2=A016.101122] [&lt;c0223ba4&gt;] (dump_stack) from [&lt=
;c05ed8e0&gt;]<br>
&gt;&gt; (mutex_lock_nested+0x24/0x474)<br>
&gt;&gt; [=C2=A0 =C2=A016.109009] [&lt;c05ed8e0&gt;] (mutex_lock_nested) fr=
om [&lt;c0259154&gt;]<br>
&gt;&gt; (pwm_enable+0x20/0x7c)<br>
&gt;&gt; [=C2=A0 =C2=A016.116799] [&lt;c0259154&gt;] (pwm_enable) from [&lt=
;c04400bc&gt;]<br>
&gt;&gt; (led_heartbeat_function+0xdc/0x140)<br>
&gt;&gt; [=C2=A0 =C2=A016.125119] [&lt;c04400bc&gt;] (led_heartbeat_functio=
n) from [&lt;c00864c8&gt;]<br>
&gt;&gt; (call_timer_fn+0x6c/0xf4)<br>
&gt;&gt; [=C2=A0 =C2=A016.133606] [&lt;c00864c8&gt;] (call_timer_fn) from [=
&lt;c00866f8&gt;]<br>
&gt;&gt; (run_timer_softirq+0x1a8/0x230)<br>
&gt;&gt; [=C2=A0 =C2=A016.141846] [&lt;c00866f8&gt;] (run_timer_softirq) fr=
om [&lt;c0028e68&gt;]<br>
&gt;&gt; (__do_softirq+0x134/0x2c0)<br>
&gt;&gt; [=C2=A0 =C2=A016.149982] [&lt;c0028e68&gt;] (__do_softirq) from [&=
lt;c0029334&gt;]<br>
&gt;&gt; (irq_exit+0xd0/0x114)<br>
&gt;&gt; [=C2=A0 =C2=A016.157255] [&lt;c0029334&gt;] (irq_exit) from [&lt;c=
0076610&gt;]<br>
&gt;&gt; (__handle_domain_irq+0x70/0xe4)<br>
&gt;&gt; [=C2=A0 =C2=A016.165056] [&lt;c0076610&gt;] (__handle_domain_irq) =
from [&lt;c00094e8&gt;]<br>
&gt;&gt; (gic_handle_irq+0x4c/0x94)<br>
&gt;&gt; [=C2=A0 =C2=A016.173376] [&lt;c00094e8&gt;] (gic_handle_irq) from =
[&lt;c0013db8&gt;]<br>
&gt;&gt; (__irq_svc+0x58/0x98)<br>
&gt;&gt; [=C2=A0 =C2=A016.180817] Exception stack(0xc08cdf58 to 0xc08cdfa0)=
<br>
&gt;&gt; [=C2=A0 =C2=A016.185823] df40:<br>
&gt;&gt;=C2=A0 =C2=A0 c0010dcc 00000000<br>
&gt;&gt; [=C2=A0 =C2=A016.193997] df60: c08cdfa8 00000000 c05f57c4 00000000=
 c08ca520<br>
&gt;&gt; c08ce4bc c08c7364 c08ce4b4<br>
&gt;&gt; [=C2=A0 =C2=A016.202141] df80: c09121ca 00000000 00000001 c08cdfa8=
 c0010dcc<br>
&gt;&gt; c0010dd0 600f0013 ffffffff<br>
&gt;&gt; [=C2=A0 =C2=A016.210291] [&lt;c0013db8&gt;] (__irq_svc) from [&lt;=
c0010dd0&gt;]<br>
&gt;&gt; (arch_cpu_idle+0x20/0x3c)<br>
&gt;&gt; [=C2=A0 =C2=A016.217661] [&lt;c0010dd0&gt;] (arch_cpu_idle) from [=
&lt;c0063174&gt;]<br>
&gt;&gt; (cpu_startup_entry+0x17c/0x26c)<br>
&gt;&gt; [=C2=A0 =C2=A016.225899] [&lt;c0063174&gt;] (cpu_startup_entry) fr=
om [&lt;c0860c40&gt;]<br>
&gt;&gt; (start_kernel+0x368/0x3d0)<br>
&gt;&gt;<br>
&gt;&gt; Best regards,<br>
&gt;&gt; Krzysztof<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; &gt; [=C2=A0 =C2=A0 2.701737] Modules linked in:<br>
&gt;&gt; &gt; [=C2=A0 =C2=A0 2.701748] CPU: 3 PID: 0 Comm: swapper/3 Not ta=
inted 4.4.0-rc1-xu4f<br>
&gt;&gt; &gt; #24<br>
&gt;&gt; &gt; [=C2=A0 =C2=A0 2.701753] Hardware name: SAMSUNG EXYNOS (Flatt=
ened Device Tree)<br>
&gt;&gt; &gt; [=C2=A0 =C2=A0 2.701787] [&lt;c0015f48&gt;] (unwind_backtrace=
) from [&lt;c0012d04&gt;]<br>
&gt;&gt; &gt; (show_stack+0x10/0x14)<br>
&gt;&gt; &gt; [=C2=A0 =C2=A0 2.701808] [&lt;c0012d04&gt;] (show_stack) from=
 [&lt;c01f83fc&gt;]<br>
&gt;&gt; &gt; (dump_stack+0x84/0xc4)<br>
&gt;&gt; &gt; [=C2=A0 =C2=A0 2.701824] [&lt;c01f83fc&gt;] (dump_stack) from=
 [&lt;c0023494&gt;]<br>
&gt;&gt; &gt; (warn_slowpath_common+0x80/0xb0)<br>
&gt;&gt; &gt; [=C2=A0 =C2=A0 2.701836] [&lt;c0023494&gt;] (warn_slowpath_co=
mmon) from [&lt;c00234f4&gt;]<br>
&gt;&gt; &gt; (warn_slowpath_fmt+0x30/0x40)<br>
&gt;&gt; &gt; [=C2=A0 =C2=A0 2.701849] [&lt;c00234f4&gt;] (warn_slowpath_fm=
t) from [&lt;c056e6b8&gt;]<br>
&gt;&gt; &gt; (__mutex_lock_slowpath+0x3bc/0x404)<br>
&gt;&gt; &gt; [=C2=A0 =C2=A0 2.701864] [&lt;c056e6b8&gt;] (__mutex_lock_slo=
wpath) from [&lt;c056e70c&gt;]<br>
&gt;&gt; &gt; (mutex_lock+0xc/0x24)<br>
&gt;&gt; &gt; [=C2=A0 =C2=A0 2.701884] [&lt;c056e70c&gt;] (mutex_lock) from=
 [&lt;c0228984&gt;]<br>
&gt;&gt; &gt; (pwm_enable+0x20/0x7c)<br>
&gt;&gt; &gt; [=C2=A0 =C2=A0 2.701903] [&lt;c0228984&gt;] (pwm_enable) from=
 [&lt;c03f0000&gt;]<br>
&gt;&gt; &gt; (led_heartbeat_function+0x74/0x144)<br>
&gt;&gt; &gt; [=C2=A0 =C2=A0 2.701919] [&lt;c03f0000&gt;] (led_heartbeat_fu=
nction) from [&lt;c0074368&gt;]<br>
&gt;&gt; &gt; (call_timer_fn+0x24/0x98)<br>
&gt;&gt; &gt; [=C2=A0 =C2=A0 2.701932] [&lt;c0074368&gt;] (call_timer_fn) f=
rom [&lt;c007453c&gt;]<br>
&gt;&gt; &gt; (run_timer_softirq+0x160/0x21c)<br>
&gt;&gt; &gt; [=C2=A0 =C2=A0 2.701946] [&lt;c007453c&gt;] (run_timer_softir=
q) from [&lt;c0026e10&gt;]<br>
&gt;&gt; &gt; (__do_softirq+0x110/0x228)<br>
&gt;&gt; &gt; [=C2=A0 =C2=A0 2.701959] [&lt;c0026e10&gt;] (__do_softirq) fr=
om [&lt;c00271c8&gt;]<br>
&gt;&gt; &gt; (irq_exit+0xc0/0xfc)<br>
&gt;&gt; &gt; [=C2=A0 =C2=A0 2.701976] [&lt;c00271c8&gt;] (irq_exit) from [=
&lt;c0065180&gt;]<br>
&gt;&gt; &gt; (__handle_domain_irq+0x80/0xec)<br>
&gt;&gt; &gt; [=C2=A0 =C2=A0 2.701990] [&lt;c0065180&gt;] (__handle_domain_=
irq) from [&lt;c0009494&gt;]<br>
&gt;&gt; &gt; (gic_handle_irq+0x54/0x94)<br>
&gt;&gt; &gt; [=C2=A0 =C2=A0 2.702001] [&lt;c0009494&gt;] (gic_handle_irq) =
from [&lt;c0013794&gt;]<br>
&gt;&gt; &gt; (__irq_svc+0x54/0x90)<br>
&gt;&gt; &gt; [=C2=A0 =C2=A0 2.702008] Exception stack(0xee8bdf88 to 0xee8b=
dfd0)<br>
&gt;&gt; &gt; [=C2=A0 =C2=A0 2.702019] df80:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A000000001 00000000 00000000<br>
&gt;&gt; &gt; c001b720 ee8bc000 c0573354<br>
&gt;&gt; &gt; [=C2=A0 =C2=A0 2.702031] dfa0: 00000000 00000000 ee8bdfe0 c07=
f92e4 c08004b4<br>
&gt;&gt; &gt; c08004bc f0806640 ee8bdfd8<br>
&gt;&gt; &gt; [=C2=A0 =C2=A0 2.702039] dfc0: c0010180 c0010184 60000013 fff=
fffff<br>
&gt;&gt; &gt; [=C2=A0 =C2=A0 2.702053] [&lt;c0013794&gt;] (__irq_svc) from =
[&lt;c0010184&gt;]<br>
&gt;&gt; &gt; (arch_cpu_idle+0x38/0x3c)<br>
&gt;&gt; &gt; [=C2=A0 =C2=A0 2.702073] [&lt;c0010184&gt;] (arch_cpu_idle) f=
rom [&lt;c0058ed4&gt;]<br>
&gt;&gt; &gt; (cpu_startup_entry+0x1ec/0x270)<br>
&gt;&gt; &gt; [=C2=A0 =C2=A0 2.702086] [&lt;c0058ed4&gt;] (cpu_startup_entr=
y) from [&lt;4000956c&gt;]<br>
&gt;&gt; &gt; (0x4000956c)<br>
&gt;&gt; &gt; [=C2=A0 =C2=A0 2.702093] ---[ end trace 539af70491f4f1a9 ]---=
<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: Anand Moon &lt;<a href=3D"mailto:linux.amoon@g=
mail.com">linux.amoon@gmail.com</a>&gt;<br>
&gt;&gt; &gt; ---<br>
&gt;&gt; &gt;=C2=A0 drivers/pwm/core.c | 4 ----<br>
&gt;&gt; &gt;=C2=A0 1 file changed, 4 deletions(-)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c<br>
&gt;&gt; &gt; index d24ca5f..b8f035a 100644<br>
&gt;&gt; &gt; --- a/drivers/pwm/core.c<br>
&gt;&gt; &gt; +++ b/drivers/pwm/core.c<br>
&gt;&gt; &gt; @@ -506,16 +506,12 @@ int pwm_enable(struct pwm_device *pwm)<=
br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!pwm)<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return =
-EINVAL;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;pwm-&gt;lock);<br>
&gt;&gt; &gt; -<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!test_and_set_bit(PWMF_ENABLED,=
 &amp;pwm-&gt;flags)) {<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D=
 pwm-&gt;chip-&gt;ops-&gt;enable(pwm-&gt;chip, pwm);<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (err=
)<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0clear_bit(PWMF_ENABLED, &amp;pwm-&gt;flags);<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;pwm-&gt;lock);<br>
&gt;&gt; &gt; -<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
&gt;&gt; &gt;=C2=A0 }<br>
&gt;&gt; &gt;=C2=A0 EXPORT_SYMBOL_GPL(pwm_enable);<br>
&gt;&gt; &gt;<br>
&gt;<br>
&gt;<br>
&gt; Adding Jonathan Richardson.<br>
&gt;<br>
&gt; Yes I am<br>
&gt;<br>
&gt; aware I am reverting some part of the d1cd21427747 (&quot;pwm: Set ena=
ble state<br>
&gt; properly on failed call to enable&quot;)<br>
&gt;<br>
&gt; Please take a look at this below commit.<br>
&gt;<br>
&gt; <a href=3D"https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux=
.git/commit/drivers/pwm/core.c?id=3Dd1cd21427747f15920cd726f5f67a07880e7dee=
4" rel=3D"noreferrer" target=3D"_blank">https://git.kernel.org/cgit/linux/k=
ernel/git/torvalds/linux.git/commit/drivers/pwm/core.c?id=3Dd1cd21427747f15=
920cd726f5f67a07880e7dee4</a><br>
&gt;<br>
&gt; Actually reverting this change it work fine.<br>
&gt;<br>
&gt; This changes introduce the new mutex lock pwm-&gt;lock to protect enab=
led bit<br>
&gt; by drivers while setting polarity.<br>
&gt;<br>
&gt; Well pwm_set_polarity already acquires the pwm-&gt;lock and calls<br>
&gt; pwm_is_enabled function.<br>
&gt; Again within pwm_is_enabled we are trying to acquire the same mutex lo=
ck.<br>
<br>
You are describing a lockdown by trying to acquire the same mutex twice.<br=
>
<br>
However pwm_is_enabled() does not acquire mutex.<br>
<br>
Again, please look at generated warnings:<br>
1. BUG: sleeping function called from invalid context<br>
2. DEBUG_LOCKS_WARN_ON(in_interrupt())<br>
<br>
They are not related anyhow to what you described (acquiring already<br>
locked mutex).<br>
<br>
Best regards,<br>
Krzysztof<br></blockquote><div><br><div class=3D"gmail_default" style=3D"fo=
nt-family:monospace,monospace;display:inline">=E2=80=8BPlease take a look a=
t the snip of the commit d1cd21427747f15920cd726f5f67a07880e7dee4<br><br><d=
iv class=3D"">@@ -494,10 +501,22 @@ EXPORT_SYMBOL_GPL(pwm_set_polarity);</d=
iv><div class=3D"">  */</div><div class=3D""> int pwm_enable(struct pwm_dev=
ice *pwm)</div><div class=3D""> {</div><div class=3D"">-	if (pwm &amp;&amp;=
 !test_and_set_bit(PWMF_ENABLED, &amp;pwm-&gt;flags))</div><div class=3D"">=
-		return pwm-&gt;chip-&gt;ops-&gt;enable(pwm-&gt;chip, pwm);</div><div cla=
ss=3D"">+	int err =3D 0;</div><div class=3D"">+</div><div class=3D"">+	if (=
!pwm)</div><div class=3D"">+		return -EINVAL;</div><div class=3D"">+</div><=
div class=3D"">+	mutex_lock(&amp;pwm-&gt;lock);</div><div class=3D"">+</div=
><div class=3D"">+	if (!test_and_set_bit(PWMF_ENABLED, &amp;pwm-&gt;flags))=
 {</div><div class=3D"">+		err =3D pwm-&gt;chip-&gt;ops-&gt;enable(pwm-&gt;=
chip, pwm);</div><div class=3D"">+		if (err)</div><div class=3D"">+			clear=
_bit(PWMF_ENABLED, &amp;pwm-&gt;flags);</div><div class=3D"">+	}</div><div =
class=3D"">+</div><div class=3D"">+	mutex_unlock(&amp;pwm-&gt;lock);</div><=
div class=3D""> </div><div class=3D"">-	return pwm ? 0 : -EINVAL;</div><div=
 class=3D"">+	return err;</div><div class=3D""> }</div><div class=3D""> EXP=
ORT_SYMBOL_GPL(pwm_enable);</div><div class=3D""><br></div><div class=3D"">=
Yes it a lock down of mutex.<br><br>I don&#39;t know how the backtrace will=
 get generate.<br>1 (BUG: sleeping function called from invalid context)<br=
>2 DEBUG_LOCKS_WARN_ON(in_interrupt())<br><br></div><div class=3D""></div><=
div class=3D""></div><div class=3D"">-Anand Moon<br></div></div></div></div=
><br></div></div>

--001a114a08f478617205250a9be0--
