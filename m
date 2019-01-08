Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37148 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbfAHWQe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Jan 2019 17:16:34 -0500
Received: by mail-oi1-f193.google.com with SMTP id y23so4698562oia.4
        for <linux-pwm@vger.kernel.org>; Tue, 08 Jan 2019 14:16:33 -0800 (PST)
MIME-Version: 1.0
References: <CAFBinCA5Hx0ibOZBfWBHBT5dZZjDqXyvw02j_gDCkfGBX_8vTA@mail.gmail.com>
 <119b9610b6c63eec4b97ba3b9dd7b45c6ed6ed53.camel@baylibre.com>
In-Reply-To: <119b9610b6c63eec4b97ba3b9dd7b45c6ed6ed53.camel@baylibre.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 8 Jan 2019 23:16:22 +0100
Message-ID: <CAFBinCD60Cyoe=TvD93tkEJYHAkuDCPBd-Oyig9QCGFVw_fimQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: pwm-meson: fix "BUG: scheduling while atomic"
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, linux-pwm@vger.kernel.org, thierry.reding@gmail.com, linux-amlogic@lists.infradead.org

Hi Jerome,

On Wed, Jan 2, 2019 at 10:44 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> On Wed, 2019-01-02 at 00:03 +0100, Martin Blumenstingl wrote:
> > Hi Neil,
> >
> > while working on some unrelated drivers I checked the kernel log on my
> > Meson8b EC-100 and found this BUG:
> >     BUG: scheduling while atomic: kworker/1:1/104/0x00000002
> >     Modules linked in:
> >     Preemption disabled at:
> >     [<00000000>]   (null)
> >     CPU: 1 PID: 104 Comm: kworker/1:1 Not tainted
> > 4.20.0-10293-gfa81effbf874-dirty #3904
> >     Hardware name: Amlogic Meson platform
> >     Workqueue: events dbs_work_handler
> >     [<c0311c0c>] (unwind_backtrace) from [<c030cb88>] (show_stack+0x10/0x14)
> >     [<c030cb88>] (show_stack) from [<c0c77674>] (dump_stack+0x7c/0x90)
> >     [<c0c77674>] (dump_stack) from [<c034a348>] (__schedule_bug+0xb0/0xd0)
> >     [<c034a348>] (__schedule_bug) from [<c0c8ffb0>] (__schedule+0x4e0/0x7b4)
> >     [<c0c8ffb0>] (__schedule) from [<c0c902cc>] (schedule+0x48/0xa0)
> >     [<c0c902cc>] (schedule) from [<c0c90840>]
> > (schedule_preempt_disabled+0x14/0x20)
> >     [<c0c90840>] (schedule_preempt_disabled) from [<c0c91688>]
> > (__mutex_lock.constprop.5+0x220/0x5fc)
> >     [<c0c91688>] (__mutex_lock.constprop.5) from [<c0718398>]
> > (clk_prepare_lock+0x50/0xf8)
> >     [<c0718398>] (clk_prepare_lock) from [<c071a8c0>]
> > (clk_core_get_rate+0xc/0x60)
> >     [<c071a8c0>] (clk_core_get_rate) from [<c06d7a28>]
> > (meson_pwm_apply+0xe8/0x404)
> >     [<c06d7a28>] (meson_pwm_apply) from [<c06d6c94>]
> > (pwm_apply_state+0x6c/0x1b4)
> >     [<c06d6c94>] (pwm_apply_state) from [<c07435bc>]
> > (pwm_regulator_set_voltage+0x124/0x190)
> >     [<c07435bc>] (pwm_regulator_set_voltage) from [<c0734790>]
> > (_regulator_do_set_voltage+0x134/0x5a4)
> >     [<c0734790>] (_regulator_do_set_voltage) from [<c073502c>]
> > (regulator_balance_voltage+0x224/0x6b8)
> >     [<c073502c>] (regulator_balance_voltage) from [<c0734d90>]
> > (regulator_set_voltage_unlocked+0xbc/0x134)
> >     [<c0734d90>] (regulator_set_voltage_unlocked) from [<c0735504>]
> > (regulator_set_voltage+0x44/0x74)
> >     [<c0735504>] (regulator_set_voltage) from [<c0a1c618>]
> > (_set_opp_voltage.part.3+0x2c/0x94)
> >     [<c0a1c618>] (_set_opp_voltage.part.3) from [<c0a1cef4>]
> > (dev_pm_opp_set_rate+0x3bc/0x458)
> >     [<c0a1cef4>] (dev_pm_opp_set_rate) from [<c0a25fb4>]
> > (set_target+0x2c/0x54)
> >     [<c0a25fb4>] (set_target) from [<c0a2147c>]
> > (__cpufreq_driver_target+0x194/0x520)
> >     [<c0a2147c>] (__cpufreq_driver_target) from [<c0a24868>]
> > (od_dbs_update+0xb4/0x160)
> >     [<c0a24868>] (od_dbs_update) from [<c0a253a8>]
> > (dbs_work_handler+0x2c/0x54)
> >     [<c0a253a8>] (dbs_work_handler) from [<c033c63c>]
> > (process_one_work+0x204/0x568)
> >     [<c033c63c>] (process_one_work) from [<c033d4bc>]
> > (worker_thread+0x44/0x580)
> >     [<c033d4bc>] (worker_thread) from [<c03422d8>] (kthread+0x14c/0x154)
> >     [<c03422d8>] (kthread) from [<c03010e8>] (ret_from_fork+0x14/0x2c)
> >
> > The setup on EC-100 is:
> > - CPU frequency scaling will be enabled with v4.21
> > - the CPU voltage regulator (called VCCK) is a pwm-regulator
> >
> > I have not seen this error in the past, even though I've been working on
> > CPU frequency scaling for a while. So it seems to be a rare issue in real-
> > life.
> > However, it can happen again because clk_get_rate is using a mutex
> > (thus it's not supposed to be called from atomic context - but we're
> > still calling it with the spin lock held).
>
> Hi Martin,
>
> I've got the same issue my side with pwm-leds
good to know that I'm not alone...

> >
> > I tried to fix this myself but while doing so a few questions came up:
> > - PWM core does not hold any lock when applying the PWM settings
> > (unlike at "request" time where pwm_request_from_chip is holding the
> > "pwm_lock")
> > - first I tried to move the spin locks to meson_pwm_enable() and
> > meson_pwm_disable(), but then we're still modifying the data in struct
> > meson_pwm_channel without any locking
> > - should we use a mutex instead of a spinlock?
>
> Tried it, seems to work - see below.
thank you - I'll give it a go during the weekend

> > - should we get rid of the pre_div, lo, hi and state caching in struct
> > meson_pwm_channel so we don't have to modify it when applying new PWM
> > settings?
>
> Ideally, I would like to do/see a complete rework this pwm driver.
> There is this locking problem but also the clocks are specified withing the
> driver code and the parent fixed by DT. This is not great and we could do
> better, especially now that CCF handles duty cycle settings.
passing the inputs via device-tree is the right thing to do in my opinion

before converting the driver to use CCF to set the duty-cycle we
should check if this covers all features:
G12A for example has some kind of "double channel" functionality (it
seems that the PWM controllers in the EE domain now have two channels
for each output pin), but I don't know much about it.
I found this in Amlogic's buildroot tarball:
buildroot_openlinux_kernel_4.9_fbdev_20180706

> However, doing this rework would change the binding meaning. It would probably
> be best to have the old and new driver co-exist for a while, while all
> platforms migrate to the newer version.
>
> What do you think ?
we can fall back to the current, hardcoded "parent names" for old
.dtbs which don't specify the clock inputs
I think extending the current driver is easier than writing a new one
(which is then supposed to replace the old one)

or did you have more steps in mind (than getting the input clocks from
a .dtb and using CCF for the duty cycle logic)?


Regards
Martin
