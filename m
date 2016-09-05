From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] pwm: Create device class for pwm channels
Date: Mon, 5 Sep 2016 16:41:39 +0200
Message-ID: <20160905144139.GQ31424@ulmo.ba.sec>
References: <1468880090-46076-1-git-send-email-davidhsu@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RCJLo13VlymhPcEi"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35059 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754755AbcIEOln (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Sep 2016 10:41:43 -0400
Content-Disposition: inline
In-Reply-To: <1468880090-46076-1-git-send-email-davidhsu@google.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: David Hsu <davidhsu@google.com>
Cc: gregkh@linuxfoundation.org, sspatil@google.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org


--RCJLo13VlymhPcEi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 18, 2016 at 03:14:50PM -0700, David Hsu wrote:
> Pwm channels don't send uevents when exported, this change adds the
> channels to a pwm class and set their device type to pwm_channel so
> uevents are sent.
>=20
> To do this properly, the device names need to change to uniquely
> identify a channel.  This change is from pwmN to pwmchipM:N
>=20
> Signed-off-by: David Hsu <davidhsu@google.com>
> ---
> v2: Use parent name instead of chip->base for channel naming.
>=20
>  Documentation/pwm.txt |  6 ++++--
>  drivers/pwm/sysfs.c   | 18 +++++++++++++-----
>  2 files changed, 17 insertions(+), 7 deletions(-)

Sorry for taking so long to look at this. I had applied this to my tree
and was doing some experiments when I noticed some oddities.

> diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
> index 01695d4..cb2b376 100644
> --- a/drivers/pwm/sysfs.c
> +++ b/drivers/pwm/sysfs.c
> @@ -23,6 +23,8 @@
>  #include <linux/kdev_t.h>
>  #include <linux/pwm.h>
> =20
> +static struct class pwm_class;
> +
>  struct pwm_export {
>  	struct device child;
>  	struct pwm_device *pwm;
> @@ -222,6 +224,10 @@ static struct attribute *pwm_attrs[] =3D {
>  };
>  ATTRIBUTE_GROUPS(pwm);
> =20
> +static const struct device_type pwm_channel_type =3D {
> +	.name		=3D "pwm_channel",
> +};

In order to do some tracing, I ended up implementing the ->uevent()
callback of struct device_type. What I noticed when exporting a PWM is
that that ->uevent() gets called recursively and the operation never
finishes. I have no idea why that happens, though.

> +
>  static void pwm_export_release(struct device *child)
>  {
>  	struct pwm_export *export =3D child_to_pwm_export(child);
> @@ -248,9 +254,11 @@ static int pwm_export_child(struct device *parent, s=
truct pwm_device *pwm)
> =20
>  	export->child.release =3D pwm_export_release;
>  	export->child.parent =3D parent;
> +	export->child.type =3D &pwm_channel_type;
>  	export->child.devt =3D MKDEV(0, 0);
> +	export->child.class =3D &pwm_class;

This particular change isn't going to work, unfortunately. Children of a
PWM chip, i.e. PWM devices (or channels) are not the same as chips. The
above, however, will cause the attributes associated with a PWM chip to
be associated with each PWM device as well. For example it will cause a
PWM device to expose an "export" attribute in userspace. Writing to that
file will give you a nice oops, along these lines:

	[   89.631855] Unable to handle kernel NULL pointer dereference at virtual=
 address 00000014
	[   89.640146] pgd =3D c2b16700
	[   89.642879] [00000014] *pgd=3D82b74003, *pmd=3Df4dd8003
	[   89.647830] Internal error: Oops: 207 [#1] PREEMPT SMP ARM
	[   89.653330] Modules linked in: nouveau tegra_drm ttm drm_kms_helper cfb=
fillrect syscopyarea cfbimgblt sysfillrect sysimgblt fb_sys_fops cfbcopyare=
a drm
	[   89.667194] CPU: 3 PID: 284 Comm: sh Not tainted 4.8.0-rc3-next-2016082=
5-00026-g7065511b7003-dirty #82
	[   89.676507] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
	[   89.682787] task: c2b39500 task.stack: c3034000
	[   89.687327] PC is at export_store+0x34/0x170
	[   89.691598] LR is at _kstrtoull+0x2c/0x70
	[   89.695607] pc : [<c04b1cb0>]    lr : [<c048a0e4>]    psr: 60000013
	[   89.695607] sp : c3035ea0  ip : c04b1c7c  fp : bec8eb0c
	[   89.707068] r10: ee1e9b8c  r9 : c3035f80  r8 : 00000002
	[   89.712287] r7 : c2b70800  r6 : 00000000  r5 : ee1e9b80  r4 : 00000000
	[   89.718806] r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : 00000000
	[   89.725327] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segmen=
t user
	[   89.732453] Control: 30c5387d  Table: 82b16700  DAC: 55555555
	[   89.738193] Process sh (pid: 284, stack limit =3D 0xc3034210)
	[   89.743758] Stack: (0xc3035ea0 to 0xc3036000)
	[   89.748116] 5ea0: ee1e9b8c 00000000 0014e408 00000002 ee1e9b80 00000000=
 00000000 ee19f180
	[   89.756286] 5ec0: c3035f80 c035fc98 00000000 00000000 c3070180 c035fbd8=
 0014e408 c3035f80
	[   89.764456] 5ee0: 00000000 00000002 00000000 c030167c 032cf000 c109bf44=
 c109bf44 c02f88b0
	[   89.772625] 5f00: ee8270c0 c02fac24 00000001 c3035f10 ef05c9e0 c0300fd8=
 c0327c08 c2b7b000
	[   89.780794] 5f20: 0000000a c2b7e000 c3184ec0 0000000a 00000400 c2b7e040=
 00000000 c3070180
	[   89.788964] 5f40: 00000002 0014e408 c3035f80 00000000 00000002 c0302464=
 00000001 0000000a
	[   89.797132] 5f60: c2d076c0 c3070180 c3070180 00000000 00000000 0014e408=
 00000002 c03031b0
	[   89.805302] 5f80: 00000000 00000000 00000014 00000002 0014e408 b6e74d50=
 00000004 c02075e4
	[   89.813470] 5fa0: c3034000 c0207440 00000002 0014e408 00000001 0014e408=
 00000002 00000000
	[   89.821638] 5fc0: 00000002 0014e408 b6e74d50 00000004 00000002 00000004=
 b6f0e000 bec8eb0c
	[   89.829808] 5fe0: 00000000 bec8ea64 b6d9ffa4 b6df970c 60000010 00000001=
 0b0a0908 0f0e0d0c
	[   89.837996] [<c04b1cb0>] (export_store) from [<c035fc98>] (kernfs_fop_w=
rite+0xc0/0x1cc)
	[   89.846005] [<c035fc98>] (kernfs_fop_write) from [<c030167c>] (__vfs_wr=
ite+0x1c/0x114)
	[   89.853940] [<c030167c>] (__vfs_write) from [<c0302464>] (vfs_write+0xa=
4/0x168)
	[   89.861252] [<c0302464>] (vfs_write) from [<c03031b0>] (SyS_write+0x3c/=
0x90)
	[   89.868304] [<c03031b0>] (SyS_write) from [<c0207440>] (ret_fast_syscal=
l+0x0/0x34)
	[   89.875883] Code: ebff6164 e2506000 ba000039 e59d1004 (e5943014)=20
	[   89.882225] ---[ end trace 716eda7e65a4136a ]---

Given that we need a class associated with a device in order for it to
generate uevents (why is that so, by the way?), I think we'd need to add
a separate class implementation for PWM devices. That has the downside
of adding yet another subdirectory to /sys/class, but I can't really
think of another way of achieving what you need here.

Greg, any ideas?

Thierry

--RCJLo13VlymhPcEi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJXzYQhAAoJEN0jrNd/PrOhIgQQALATNzPpGZS28haG7oHF09qy
vc0jdZ8un/vLo0qaVwV/fze4yemFUwQvqK4OZFAVJL4ahioVyHHc69N2WnDcEbVR
FRgEo1bTX0zrUti7+CaDldUH5gZDYQcZk5CMAY744ku3qJekvZkZOlKpHA/R4KiP
cjkgp263pQiEl1RmV331R0HoB8ozjgIL9mCI12uva7sIvmWFby1RtFj/mSdKHUuK
YHaqFlD5SMeF/uy9cs4796kgpGbUqbkL3PPnD//aMCbo7/4nSQ4eyFC/0ew3xJ+w
0qnl1XW2yGZy562gKEu6qbr5Pls0oYuLkFvTzvsOpjBZbX3iXJf+L8nQjxSgVVee
BjWOOgJajNl5SqKCTSW5Hg7jli0+fpATANMfhErP7SqagSExghkkUSOd6thG+f1o
3bsWgrVT0ay0kMGIAsHKzOvUwEnUlhYA2LV/Flhv9Rur7j5ec8ODx0JFVHstsb2z
ZPAfgWZPRukHd6ZrUPzH11J3iyKh5zlVnp8BJWNuHmy4ZAHvOoTiuRQEBavLeUyD
g9A98/lxLwY5lRLH+jgBepDvh6DhokstQqYyCylWDPl3ODjoTdIFggJnKz/4xCmN
FveF1PRcRr5t+DMkkAVSdy63DmLDBJvlYNSEkSVSESEPy5Wh13YsizjUSUKyRPh0
MHjqK/qzR5Vxpaq9sxiQ
=HxFp
-----END PGP SIGNATURE-----

--RCJLo13VlymhPcEi--
