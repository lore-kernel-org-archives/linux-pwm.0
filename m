Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40161 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfCLLzC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 12 Mar 2019 07:55:02 -0400
Date: Tue, 12 Mar 2019 12:54:58 +0100
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20190312115458.GL31026@ulmo>
References: <1552360594-21547-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gwtGiOGliFx8mAnm"
Content-Disposition: inline
In-Reply-To: <1552360594-21547-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH] pwm: Avoid deadlock warning when removing PWM device
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Phong Hoang <phong.hoang.wz@renesas.com>


--gwtGiOGliFx8mAnm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2019 at 12:16:34PM +0900, Yoshihiro Shimoda wrote:
> From: Phong Hoang <phong.hoang.wz@renesas.com>
>=20
> This patch fixes deadlock warning if removing PWM device
> when CONFIG_PROVE_LOCKING is enabled.
>=20
> This issue can be reproceduced by the following steps on
> the R-Car H3 Salvator-X board if the backlight is disabled:
>=20
>  # cd /sys/class/pwm/pwmchip0
>  # echo 0 > export
>  # ls
>  device  export  npwm  power  pwm0  subsystem  uevent  unexport
>  # cd device/driver
>  # ls
>  bind  e6e31000.pwm  uevent  unbind
>  # echo e6e31000.pwm > unbind
>=20
> [   87.659974] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   87.666149] WARNING: possible circular locking dependency detected
> [   87.672327] 5.0.0 #7 Not tainted
> [   87.675549] ------------------------------------------------------
> [   87.681723] bash/2986 is trying to acquire lock:
> [   87.686337] 000000005ea0e178 (kn->count#58){++++}, at: kernfs_remove_b=
y_name_ns+0x50/0xa0
> [   87.694528]
> [   87.694528] but task is already holding lock:
> [   87.700353] 000000006313b17c (pwm_lock){+.+.}, at: pwmchip_remove+0x28=
/0x13c
> [   87.707405]
> [   87.707405] which lock already depends on the new lock.
> [   87.707405]
> [   87.715574]
> [   87.715574] the existing dependency chain (in reverse order) is:
> [   87.723048]
> [   87.723048] -> #1 (pwm_lock){+.+.}:
> [   87.728017]        __mutex_lock+0x70/0x7e4
> [   87.732108]        mutex_lock_nested+0x1c/0x24
> [   87.736547]        pwm_request_from_chip.part.6+0x34/0x74
> [   87.741940]        pwm_request_from_chip+0x20/0x40
> [   87.746725]        export_store+0x6c/0x1f4
> [   87.750820]        dev_attr_store+0x18/0x28
> [   87.754998]        sysfs_kf_write+0x54/0x64
> [   87.759175]        kernfs_fop_write+0xe4/0x1e8
> [   87.763615]        __vfs_write+0x40/0x184
> [   87.767619]        vfs_write+0xa8/0x19c
> [   87.771448]        ksys_write+0x58/0xbc
> [   87.775278]        __arm64_sys_write+0x18/0x20
> [   87.779721]        el0_svc_common+0xd0/0x124
> [   87.783986]        el0_svc_compat_handler+0x1c/0x24
> [   87.788858]        el0_svc_compat+0x8/0x18
> [   87.792947]
> [   87.792947] -> #0 (kn->count#58){++++}:
> [   87.798260]        lock_acquire+0xc4/0x22c
> [   87.802353]        __kernfs_remove+0x258/0x2c4
> [   87.806790]        kernfs_remove_by_name_ns+0x50/0xa0
> [   87.811836]        remove_files.isra.1+0x38/0x78
> [   87.816447]        sysfs_remove_group+0x48/0x98
> [   87.820971]        sysfs_remove_groups+0x34/0x4c
> [   87.825583]        device_remove_attrs+0x6c/0x7c
> [   87.830197]        device_del+0x11c/0x33c
> [   87.834201]        device_unregister+0x14/0x2c
> [   87.838638]        pwmchip_sysfs_unexport+0x40/0x4c
> [   87.843509]        pwmchip_remove+0xf4/0x13c
> [   87.847773]        rcar_pwm_remove+0x28/0x34
> [   87.852039]        platform_drv_remove+0x24/0x64
> [   87.856651]        device_release_driver_internal+0x18c/0x21c
> [   87.862391]        device_release_driver+0x14/0x1c
> [   87.867175]        unbind_store+0xe0/0x124
> [   87.871265]        drv_attr_store+0x20/0x30
> [   87.875442]        sysfs_kf_write+0x54/0x64
> [   87.879618]        kernfs_fop_write+0xe4/0x1e8
> [   87.884055]        __vfs_write+0x40/0x184
> [   87.888057]        vfs_write+0xa8/0x19c
> [   87.891887]        ksys_write+0x58/0xbc
> [   87.895716]        __arm64_sys_write+0x18/0x20
> [   87.900154]        el0_svc_common+0xd0/0x124
> [   87.904417]        el0_svc_compat_handler+0x1c/0x24
> [   87.909289]        el0_svc_compat+0x8/0x18

I'm not sure I understand this correctly. The above looks like pwm_lock
is held as part of the syscall writing 0 to the export attribute and the
second callchain looks like it's originating from the write to the
unbind attribute for the driver. But pwm_request_from_chip() should have
already released the lock before it returned, so how can the above
situation even happen?

Thierry

--gwtGiOGliFx8mAnm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyHnhIACgkQ3SOs138+
s6FuaxAAhMA7Q1tfZ+We9YdxiS3YTJ+2VbXOgf3Ni5t+Gd7CUFiGsWA87qzJvA0K
2ymScD3IURk+T/9FfxDEe812Q5H1xvsUuC95yeRoW9ngtzRCASs+QppVJ9W7Efwz
M0dAVBGtV4pKD7nAUWPTEEKcZOzkinUWa6rLcCsx86xO/+DVygFwkJrgq3RjuQZR
h5bY3p2tgwX4okZKYbn+N4Eqy1K1jy2Az+fzdtonhAAvG9+QyyR1MmTsvtYhvfZG
vcHMvaMw2cs587ZiYFHUkPxpJ5xo2Vv+WuMnIknfo1esScb51P85SfSZ8bN2EeRQ
Kf2mibDGxxFjfnyxPi8bz1ZvLzouf2cVmq5QtMcc9J8xFBl95RUlg8ZM24+cLVoI
/25RWfrBKiJNUNBGq04nptVJD/rMKNbDcG1UwuKFURap9wFJjQ/6aeKIakHiZQP3
WRG3H0i3/4FP25AS0Va3UQcRge+s1samdt+GzPtCSuq02vLZgO5MBUp47856qJjZ
sVJpaDxIyEZqDU/WBVcWMxvLbhMepII14Nw2REm+HLidKBy6AR2TGx+PgFrUOWk9
Xw9vrhtKQCG6+J7/AkteiSfw8RpUNh+pOo5T4wfxx8gh2vdaZgGYSl0vuxHfHFg7
uLBoWcNVmCXulzAA7DpY8mipmYPj/9OLrGh80LKvPxIvDBHnRO0=
=Ja5g
-----END PGP SIGNATURE-----

--gwtGiOGliFx8mAnm--
