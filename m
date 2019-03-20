Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38959 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfCTLWa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 20 Mar 2019 07:22:30 -0400
Date: Wed, 20 Mar 2019 12:22:24 +0100
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20190320112224.GA23838@ulmo>
References: <1552992008-20218-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <1552992008-20218-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH v3] pwm: Fix deadlock warning when removing PWM device
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Phong Hoang <phong.hoang.wz@renesas.com>


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2019 at 07:40:08PM +0900, Yoshihiro Shimoda wrote:
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
> [   87.913378]
> [   87.913378] other info that might help us debug this:
> [   87.913378]
> [   87.921374]  Possible unsafe locking scenario:
> [   87.921374]
> [   87.927286]        CPU0                    CPU1
> [   87.931808]        ----                    ----
> [   87.936331]   lock(pwm_lock);
> [   87.939293]                                lock(kn->count#58);
> [   87.945120]                                lock(pwm_lock);
> [   87.950599]   lock(kn->count#58);
> [   87.953908]
> [   87.953908]  *** DEADLOCK ***
> [   87.953908]
> [   87.959821] 4 locks held by bash/2986:
> [   87.963563]  #0: 00000000ace7bc30 (sb_writers#6){.+.+}, at: vfs_write+=
0x188/0x19c
> [   87.971044]  #1: 00000000287991b2 (&of->mutex){+.+.}, at: kernfs_fop_w=
rite+0xb4/0x1e8
> [   87.978872]  #2: 00000000f739d016 (&dev->mutex){....}, at: device_rele=
ase_driver_internal+0x40/0x21c
> [   87.988001]  #3: 000000006313b17c (pwm_lock){+.+.}, at: pwmchip_remove=
+0x28/0x13c
> [   87.995481]
> [   87.995481] stack backtrace:
> [   87.999836] CPU: 0 PID: 2986 Comm: bash Not tainted 5.0.0 #7
> [   88.005489] Hardware name: Renesas Salvator-X board based on r8a7795 E=
S1.x (DT)
> [   88.012791] Call trace:
> [   88.015235]  dump_backtrace+0x0/0x190
> [   88.018891]  show_stack+0x14/0x1c
> [   88.022204]  dump_stack+0xb0/0xec
> [   88.025514]  print_circular_bug.isra.32+0x1d0/0x2e0
> [   88.030385]  __lock_acquire+0x1318/0x1864
> [   88.034388]  lock_acquire+0xc4/0x22c
> [   88.037958]  __kernfs_remove+0x258/0x2c4
> [   88.041874]  kernfs_remove_by_name_ns+0x50/0xa0
> [   88.046398]  remove_files.isra.1+0x38/0x78
> [   88.050487]  sysfs_remove_group+0x48/0x98
> [   88.054490]  sysfs_remove_groups+0x34/0x4c
> [   88.058580]  device_remove_attrs+0x6c/0x7c
> [   88.062671]  device_del+0x11c/0x33c
> [   88.066154]  device_unregister+0x14/0x2c
> [   88.070070]  pwmchip_sysfs_unexport+0x40/0x4c
> [   88.074421]  pwmchip_remove+0xf4/0x13c
> [   88.078163]  rcar_pwm_remove+0x28/0x34
> [   88.081906]  platform_drv_remove+0x24/0x64
> [   88.085996]  device_release_driver_internal+0x18c/0x21c
> [   88.091215]  device_release_driver+0x14/0x1c
> [   88.095478]  unbind_store+0xe0/0x124
> [   88.099048]  drv_attr_store+0x20/0x30
> [   88.102704]  sysfs_kf_write+0x54/0x64
> [   88.106359]  kernfs_fop_write+0xe4/0x1e8
> [   88.110275]  __vfs_write+0x40/0x184
> [   88.113757]  vfs_write+0xa8/0x19c
> [   88.117065]  ksys_write+0x58/0xbc
> [   88.120374]  __arm64_sys_write+0x18/0x20
> [   88.124291]  el0_svc_common+0xd0/0x124
> [   88.128034]  el0_svc_compat_handler+0x1c/0x24
> [   88.132384]  el0_svc_compat+0x8/0x18
>=20
> The sysfs unexport in pwmchip_remove() is completely asymmetric
> to what we do in pwmchip_add_with_polarity() and commit 0733424c9ba9
> ("pwm: Unexport children before chip removal") is a strong indication
> that this was wrong to begin with. We should just move
> pwmchip_sysfs_unexport() where it belongs, which is right after
> pwmchip_sysfs_unexport_children(). In that case, we do not need
> separate functions anymore either.
>=20
> We also really want to remove sysfs irrespective of whether or not
> the chip will be removed as a result of pwmchip_remove(). We can only
> assume that the driver will be gone after that, so we shouldn't leave
> any dangling sysfs files around.
>=20
> This warning disappears if we move pwmchip_sysfs_unexport() to
> the top of pwmchip_remove(), pwmchip_sysfs_unexport_children().
> That way it is also outside of the pwm_lock section, which indeed
> doesn't seem to be needed.
>=20
> Moving the pwmchip_sysfs_export() call outside of that section also
> seems fine and it'd be perfectly symmetric with pwmchip_remove() again.
>=20
> So, this patch fixes them.
>=20
> Signed-off-by: Phong Hoang <phong.hoang.wz@renesas.com>
> [shimoda: revise the commit log and code]
> Fixes: 76abbdde2d95 ("pwm: Add sysfs interface")
> Fixes: 0733424c9ba9 ("pwm: Unexport children before chip removal")
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Tested-by: Hoan Nguyen An <na-hoan@jinso.co.jp>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Changes from v2 (https://patchwork.kernel.org/patch/10850711/)
>  - Revise the commit log.
>  - Reduce code diff lines by using if (!parent) condition.
>  - Add Reviewed-by Geert's tag.
>=20
>  Changes from v1 (https://patchwork.kernel.org/patch/10848567/):
>  - Change the subject from "Avoid" to "Fix".
>  - Merge pwmchip_sysfs_unexport_children()'s code into
>    pwmchip_sysfs_unexport() and move pwmchip_sysfs_unexport() to
>    the top of pwmchip_remove().
>  - Revise the commit log that is reffered from Therry's comments [1]
>    because it seems very clear to me.
>  - Add Fixes tag about the commit 0733424c9ba9.=20
>  - I got Geert's Reviewed-by on v1 patch, but I'm not sure
>    I can add the Reviewed-by because v2 patch changes a bit.
>    So, I didn't add the Reviewed-by tag.
>=20
> [1]
> https://www.mail-archive.com/linux-renesas-soc@vger.kernel.org/msg39167.h=
tml
>=20
>=20
>=20
>  drivers/pwm/core.c  | 10 +++++-----
>  drivers/pwm/sysfs.c | 14 +-------------
>  include/linux/pwm.h |  5 -----
>  3 files changed, 6 insertions(+), 23 deletions(-)

Applied, thanks!

Thierry

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlySImsACgkQ3SOs138+
s6HALg//S7tVUBJpYvnCC6WwYgtZLair7MH4ODiTIANkpHjh9jftQdGcJeUdfUP7
wGaF0E3UUs7Or5XCrRnXY2DTEHOSyp745QwBeyjyy6XHPjUM5NBKXqGUVy1emTbj
tZJ7mgxdOqmPT5KGTxV9nobCqgfcgEV5LKhgs5UDCx0zZRg2V48nBv52Qz3rOjrH
27LC8X65RGQGy/wVxSxqsMUGH9PpNVBRF+51KZz3/yjV5IIKm44OVZjBh6vMEgJe
qo8uC5FPynSZEHfYNn0IPjDuw/EFK2jxV3h89aGRg4mo4UcS/neZckWPsyMMHpuZ
LR57Bgl9xbbf5NBcoEvEmOhR5xNja4Gs4xZGIJTwl3EnGCumlOnUdxQ7sFag1iwA
mj2+arhzpd5MOy9iY17Mba0xsFozBc5MXdBOspQEvu/b/Jtanuv0sUnNnI1F7D3q
7I3omc9xbPQHerEwwXOOWuGqtk6zFz2ULnbG3PqwsX41YIaD+RBULBRf9lnkGlic
i082DZjmEzrAOwt4jqXS0olKwX/p7cUsx6s6B+T6oJIg3QBRrVDIqkF8psC0AB8E
sHBgoa9rUbBqu/nA4fVYwul3rWXJGfRLoUI/ER61Y9G8MeCkdn28bSN2Sx4K060k
gA9gzyvaErwfzy3CjO82br9A9NPatLEkf2ia53GjHb+lPXzVy2c=
=xgfb
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
