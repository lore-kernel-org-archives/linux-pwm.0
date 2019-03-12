Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46817 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfCLMKD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 12 Mar 2019 08:10:03 -0400
MIME-Version: 1.0
References: <1552360594-21547-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20190312115458.GL31026@ulmo>
In-Reply-To: <20190312115458.GL31026@ulmo>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 12 Mar 2019 13:09:49 +0100
Message-ID: <CAMuHMdWQr3g3-4hpRXW4XcSkveAAN0T6ckHyU_afkQmoHX7Pag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH] pwm: Avoid deadlock warning when removing PWM device
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Phong Hoang <phong.hoang.wz@renesas.com>

Hi Thierry,

On Tue, Mar 12, 2019 at 12:55 PM Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Tue, Mar 12, 2019 at 12:16:34PM +0900, Yoshihiro Shimoda wrote:
> > From: Phong Hoang <phong.hoang.wz@renesas.com>
> >
> > This patch fixes deadlock warning if removing PWM device
> > when CONFIG_PROVE_LOCKING is enabled.
> >
> > This issue can be reproceduced by the following steps on
> > the R-Car H3 Salvator-X board if the backlight is disabled:
> >
> >  # cd /sys/class/pwm/pwmchip0
> >  # echo 0 > export
> >  # ls
> >  device  export  npwm  power  pwm0  subsystem  uevent  unexport
> >  # cd device/driver
> >  # ls
> >  bind  e6e31000.pwm  uevent  unbind
> >  # echo e6e31000.pwm > unbind
> >
> > [   87.659974] ======================================================
> > [   87.666149] WARNING: possible circular locking dependency detected
> > [   87.672327] 5.0.0 #7 Not tainted
> > [   87.675549] ------------------------------------------------------
> > [   87.681723] bash/2986 is trying to acquire lock:
> > [   87.686337] 000000005ea0e178 (kn->count#58){++++}, at: kernfs_remove_by_name_ns+0x50/0xa0
> > [   87.694528]
> > [   87.694528] but task is already holding lock:
> > [   87.700353] 000000006313b17c (pwm_lock){+.+.}, at: pwmchip_remove+0x28/0x13c
> > [   87.707405]
> > [   87.707405] which lock already depends on the new lock.
> > [   87.707405]
> > [   87.715574]
> > [   87.715574] the existing dependency chain (in reverse order) is:
> > [   87.723048]
> > [   87.723048] -> #1 (pwm_lock){+.+.}:
> > [   87.728017]        __mutex_lock+0x70/0x7e4
> > [   87.732108]        mutex_lock_nested+0x1c/0x24
> > [   87.736547]        pwm_request_from_chip.part.6+0x34/0x74
> > [   87.741940]        pwm_request_from_chip+0x20/0x40
> > [   87.746725]        export_store+0x6c/0x1f4
> > [   87.750820]        dev_attr_store+0x18/0x28
> > [   87.754998]        sysfs_kf_write+0x54/0x64
> > [   87.759175]        kernfs_fop_write+0xe4/0x1e8
> > [   87.763615]        __vfs_write+0x40/0x184
> > [   87.767619]        vfs_write+0xa8/0x19c
> > [   87.771448]        ksys_write+0x58/0xbc
> > [   87.775278]        __arm64_sys_write+0x18/0x20
> > [   87.779721]        el0_svc_common+0xd0/0x124
> > [   87.783986]        el0_svc_compat_handler+0x1c/0x24
> > [   87.788858]        el0_svc_compat+0x8/0x18
> > [   87.792947]
> > [   87.792947] -> #0 (kn->count#58){++++}:
> > [   87.798260]        lock_acquire+0xc4/0x22c
> > [   87.802353]        __kernfs_remove+0x258/0x2c4
> > [   87.806790]        kernfs_remove_by_name_ns+0x50/0xa0
> > [   87.811836]        remove_files.isra.1+0x38/0x78
> > [   87.816447]        sysfs_remove_group+0x48/0x98
> > [   87.820971]        sysfs_remove_groups+0x34/0x4c
> > [   87.825583]        device_remove_attrs+0x6c/0x7c
> > [   87.830197]        device_del+0x11c/0x33c
> > [   87.834201]        device_unregister+0x14/0x2c
> > [   87.838638]        pwmchip_sysfs_unexport+0x40/0x4c
> > [   87.843509]        pwmchip_remove+0xf4/0x13c
> > [   87.847773]        rcar_pwm_remove+0x28/0x34
> > [   87.852039]        platform_drv_remove+0x24/0x64
> > [   87.856651]        device_release_driver_internal+0x18c/0x21c
> > [   87.862391]        device_release_driver+0x14/0x1c
> > [   87.867175]        unbind_store+0xe0/0x124
> > [   87.871265]        drv_attr_store+0x20/0x30
> > [   87.875442]        sysfs_kf_write+0x54/0x64
> > [   87.879618]        kernfs_fop_write+0xe4/0x1e8
> > [   87.884055]        __vfs_write+0x40/0x184
> > [   87.888057]        vfs_write+0xa8/0x19c
> > [   87.891887]        ksys_write+0x58/0xbc
> > [   87.895716]        __arm64_sys_write+0x18/0x20
> > [   87.900154]        el0_svc_common+0xd0/0x124
> > [   87.904417]        el0_svc_compat_handler+0x1c/0x24
> > [   87.909289]        el0_svc_compat+0x8/0x18
>
> I'm not sure I understand this correctly. The above looks like pwm_lock
> is held as part of the syscall writing 0 to the export attribute and the
> second callchain looks like it's originating from the write to the
> unbind attribute for the driver. But pwm_request_from_chip() should have
> already released the lock before it returned, so how can the above
> situation even happen?

Note that it says "_possible_ circular locking dependency detected".
AFAIU, this does not mean that the above two callchains actually did
happen at the same time.

Lockdep keeps tracks of the order in which locks are taken.  If it
notices that one chain takes locks in one order, and a second chain
takes those locks in a different order, it prints a warning, as this
could cause a deadlock if/when the two callchains would ever happen
at the same time.

Note that there may be other reasons, outside the view of lockdep, which
guarantee this cannot actually happen...

So far my understanding...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
