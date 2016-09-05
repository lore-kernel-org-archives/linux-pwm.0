From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] pwm: Create device class for pwm channels
Date: Mon, 5 Sep 2016 17:15:02 +0200
Message-ID: <20160905151502.GS31424@ulmo.ba.sec>
References: <1468880090-46076-1-git-send-email-davidhsu@google.com>
 <20160905144139.GQ31424@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XCAZszJJXrQJLz3d"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35915 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752756AbcIEPPG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Sep 2016 11:15:06 -0400
Content-Disposition: inline
In-Reply-To: <20160905144139.GQ31424@ulmo.ba.sec>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: David Hsu <davidhsu@google.com>
Cc: gregkh@linuxfoundation.org, sspatil@google.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org


--XCAZszJJXrQJLz3d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 05, 2016 at 04:41:39PM +0200, Thierry Reding wrote:
> On Mon, Jul 18, 2016 at 03:14:50PM -0700, David Hsu wrote:
[...]
> > diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
[...]
> > @@ -248,9 +254,11 @@ static int pwm_export_child(struct device *parent,=
 struct pwm_device *pwm)
> > =20
> >  	export->child.release =3D pwm_export_release;
> >  	export->child.parent =3D parent;
> > +	export->child.type =3D &pwm_channel_type;
> >  	export->child.devt =3D MKDEV(0, 0);
> > +	export->child.class =3D &pwm_class;
>=20
> This particular change isn't going to work, unfortunately. Children of a
> PWM chip, i.e. PWM devices (or channels) are not the same as chips. The
> above, however, will cause the attributes associated with a PWM chip to
> be associated with each PWM device as well. For example it will cause a
> PWM device to expose an "export" attribute in userspace. Writing to that
> file will give you a nice oops, along these lines:
>=20
> 	[   89.631855] Unable to handle kernel NULL pointer dereference at virtu=
al address 00000014
> 	[   89.640146] pgd =3D c2b16700
> 	[   89.642879] [00000014] *pgd=3D82b74003, *pmd=3Df4dd8003
> 	[   89.647830] Internal error: Oops: 207 [#1] PREEMPT SMP ARM
> 	[   89.653330] Modules linked in: nouveau tegra_drm ttm drm_kms_helper c=
fbfillrect syscopyarea cfbimgblt sysfillrect sysimgblt fb_sys_fops cfbcopya=
rea drm
> 	[   89.667194] CPU: 3 PID: 284 Comm: sh Not tainted 4.8.0-rc3-next-20160=
825-00026-g7065511b7003-dirty #82
> 	[   89.676507] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
> 	[   89.682787] task: c2b39500 task.stack: c3034000
> 	[   89.687327] PC is at export_store+0x34/0x170
> 	[   89.691598] LR is at _kstrtoull+0x2c/0x70
> 	[   89.695607] pc : [<c04b1cb0>]    lr : [<c048a0e4>]    psr: 60000013
> 	[   89.695607] sp : c3035ea0  ip : c04b1c7c  fp : bec8eb0c
> 	[   89.707068] r10: ee1e9b8c  r9 : c3035f80  r8 : 00000002
> 	[   89.712287] r7 : c2b70800  r6 : 00000000  r5 : ee1e9b80  r4 : 00000000
> 	[   89.718806] r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : 00000000
> 	[   89.725327] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segm=
ent user
> 	[   89.732453] Control: 30c5387d  Table: 82b16700  DAC: 55555555
> 	[   89.738193] Process sh (pid: 284, stack limit =3D 0xc3034210)
> 	[   89.743758] Stack: (0xc3035ea0 to 0xc3036000)
> 	[   89.748116] 5ea0: ee1e9b8c 00000000 0014e408 00000002 ee1e9b80 000000=
00 00000000 ee19f180
> 	[   89.756286] 5ec0: c3035f80 c035fc98 00000000 00000000 c3070180 c035fb=
d8 0014e408 c3035f80
> 	[   89.764456] 5ee0: 00000000 00000002 00000000 c030167c 032cf000 c109bf=
44 c109bf44 c02f88b0
> 	[   89.772625] 5f00: ee8270c0 c02fac24 00000001 c3035f10 ef05c9e0 c0300f=
d8 c0327c08 c2b7b000
> 	[   89.780794] 5f20: 0000000a c2b7e000 c3184ec0 0000000a 00000400 c2b7e0=
40 00000000 c3070180
> 	[   89.788964] 5f40: 00000002 0014e408 c3035f80 00000000 00000002 c03024=
64 00000001 0000000a
> 	[   89.797132] 5f60: c2d076c0 c3070180 c3070180 00000000 00000000 0014e4=
08 00000002 c03031b0
> 	[   89.805302] 5f80: 00000000 00000000 00000014 00000002 0014e408 b6e74d=
50 00000004 c02075e4
> 	[   89.813470] 5fa0: c3034000 c0207440 00000002 0014e408 00000001 0014e4=
08 00000002 00000000
> 	[   89.821638] 5fc0: 00000002 0014e408 b6e74d50 00000004 00000002 000000=
04 b6f0e000 bec8eb0c
> 	[   89.829808] 5fe0: 00000000 bec8ea64 b6d9ffa4 b6df970c 60000010 000000=
01 0b0a0908 0f0e0d0c
> 	[   89.837996] [<c04b1cb0>] (export_store) from [<c035fc98>] (kernfs_fop=
_write+0xc0/0x1cc)
> 	[   89.846005] [<c035fc98>] (kernfs_fop_write) from [<c030167c>] (__vfs_=
write+0x1c/0x114)
> 	[   89.853940] [<c030167c>] (__vfs_write) from [<c0302464>] (vfs_write+0=
xa4/0x168)
> 	[   89.861252] [<c0302464>] (vfs_write) from [<c03031b0>] (SyS_write+0x3=
c/0x90)
> 	[   89.868304] [<c03031b0>] (SyS_write) from [<c0207440>] (ret_fast_sysc=
all+0x0/0x34)
> 	[   89.875883] Code: ebff6164 e2506000 ba000039 e59d1004 (e5943014)=20
> 	[   89.882225] ---[ end trace 716eda7e65a4136a ]---
>=20
> Given that we need a class associated with a device in order for it to
> generate uevents (why is that so, by the way?), I think we'd need to add
> a separate class implementation for PWM devices. That has the downside
> of adding yet another subdirectory to /sys/class, but I can't really
> think of another way of achieving what you need here.
>=20
> Greg, any ideas?

*sigh*, nevermind. I realized too late that I hadn't fully applied your
patch and the change to use device_create_with_groups() actually gets
rid of this.

Unfortunately....

> > index 01695d4..cb2b376 100644
> > --- a/drivers/pwm/sysfs.c
> > +++ b/drivers/pwm/sysfs.c
> > @@ -23,6 +23,8 @@
> >  #include <linux/kdev_t.h>
> >  #include <linux/pwm.h>
> > =20
> > +static struct class pwm_class;
> > +
> >  struct pwm_export {
> >  	struct device child;
> >  	struct pwm_device *pwm;
> > @@ -222,6 +224,10 @@ static struct attribute *pwm_attrs[] =3D {
> >  };
> >  ATTRIBUTE_GROUPS(pwm);
> > =20
> > +static const struct device_type pwm_channel_type =3D {
> > +	.name		=3D "pwm_channel",
> > +};
>=20
> In order to do some tracing, I ended up implementing the ->uevent()
> callback of struct device_type. What I noticed when exporting a PWM is
> that that ->uevent() gets called recursively and the operation never
> finishes. I have no idea why that happens, though.

=2E.. that's still there. However the output is now somewhat cleaner and
the ->uevent() callback doesn't seem to be called recursively but rather
repeatedly (until I unexport the PWM again).

Let me investigate a little more where this is coming from. For
reference, I have the below on top of your patch.

Thierry

--- >8 ---
diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 2ab5ed61d496..45e56a04f091 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -241,8 +241,17 @@ static struct attribute *pwm_attrs[] =3D {
 };
 ATTRIBUTE_GROUPS(pwm);
=20
+static int pwm_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	int err =3D 0;
+	dev_info(dev, "> %s(dev=3D%p, env=3D%p)\n", __func__, dev, env);
+	dev_info(dev, "< %s() =3D %d\n", __func__, err);
+	return err;
+}
+
 static const struct device_type pwm_channel_type =3D {
-	.name		=3D "pwm_channel",
+	.name =3D "pwm_channel",
+	.uevent =3D pwm_uevent,
 };
=20
 static void pwm_export_release(struct device *child)

--XCAZszJJXrQJLz3d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJXzYv0AAoJEN0jrNd/PrOhViwP/RLml926nFQUu9ej+pBAuvb1
pcIsMRLPa25+Ue8oPyKL1d/HJgsD92TLzQzpeMRFsNg8Z8PKwQY34kksoY4lJMwV
CwbYIuH+RDnO9HhY14yTx+r7+Bsm3KUUpuQ7ALTw/CliYq58s9hPHk+avmH2bGSI
ZJ35h1s3EeO9YEbV6rKtB3ATgQ907zkAtB4mXZwNyPtu7meMayNxo1NTDgle/Ec6
Y1/7DzaSUySwgNgXdwz+sJjQEHvD+CgyrumX22KH9u4XUcDNK9pyefuq9d2VcAS5
CMd/DLByY0gll7aSnkGeFlxJML58y37cVBiQjd9Y5Osf+t9TLEorQyqfxFs1aMc5
SWaqSK8CAnX0RrNUtFXBpJTXgsZUWTRgi8Yz+18WJDR+q2J/cmbA+ufdLgz9KAJ2
mFnCpJ4mnNNf6syvAxe5/NKlJrbkN7SWluBonho+etL1M2Uz/mXb6Z7KYTXJlf2u
8EULJjrwrnE9I8VWJ9iSlHzTQDn/Wnp8GWB8mZ0ykaOltLnFnPecpCWTGyc9+o0z
OVsK5Wjlw5U+Mt2ymkZQUxmpa+eurjv8MEji6Q0On+vDboXjBksdN5k/oYT37Oso
PybQHxoJXYXcw4lc9QaAMyB1xBHCDC5E3/+jwHpLwWBfnFLq2QN4eJfcJMpHvWcO
2ipZHV+TSFxtKSBrJHpj
=9Ulp
-----END PGP SIGNATURE-----

--XCAZszJJXrQJLz3d--
