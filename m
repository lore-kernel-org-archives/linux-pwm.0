From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] pwm: Create device class for pwm channels
Date: Mon, 5 Sep 2016 17:42:09 +0200
Message-ID: <20160905154209.GU31424@ulmo.ba.sec>
References: <1468880090-46076-1-git-send-email-davidhsu@google.com>
 <20160905144139.GQ31424@ulmo.ba.sec>
 <20160905151502.GS31424@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/Rh48Y0bnrojh5Wm"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160905151502.GS31424@ulmo.ba.sec>
Sender: linux-kernel-owner@vger.kernel.org
To: David Hsu <davidhsu@google.com>
Cc: gregkh@linuxfoundation.org, sspatil@google.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--/Rh48Y0bnrojh5Wm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 05, 2016 at 05:15:02PM +0200, Thierry Reding wrote:
> On Mon, Sep 05, 2016 at 04:41:39PM +0200, Thierry Reding wrote:
> > On Mon, Jul 18, 2016 at 03:14:50PM -0700, David Hsu wrote:
> [...]
> > > diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
> [...]
> > > @@ -248,9 +254,11 @@ static int pwm_export_child(struct device *paren=
t, struct pwm_device *pwm)
> > > =20
> > >  	export->child.release =3D pwm_export_release;
> > >  	export->child.parent =3D parent;
> > > +	export->child.type =3D &pwm_channel_type;
> > >  	export->child.devt =3D MKDEV(0, 0);
> > > +	export->child.class =3D &pwm_class;
> >=20
> > This particular change isn't going to work, unfortunately. Children of a
> > PWM chip, i.e. PWM devices (or channels) are not the same as chips. The
> > above, however, will cause the attributes associated with a PWM chip to
> > be associated with each PWM device as well. For example it will cause a
> > PWM device to expose an "export" attribute in userspace. Writing to that
> > file will give you a nice oops, along these lines:
> >=20
> > 	[   89.631855] Unable to handle kernel NULL pointer dereference at vir=
tual address 00000014
> > 	[   89.640146] pgd =3D c2b16700
> > 	[   89.642879] [00000014] *pgd=3D82b74003, *pmd=3Df4dd8003
> > 	[   89.647830] Internal error: Oops: 207 [#1] PREEMPT SMP ARM
> > 	[   89.653330] Modules linked in: nouveau tegra_drm ttm drm_kms_helper=
 cfbfillrect syscopyarea cfbimgblt sysfillrect sysimgblt fb_sys_fops cfbcop=
yarea drm
> > 	[   89.667194] CPU: 3 PID: 284 Comm: sh Not tainted 4.8.0-rc3-next-201=
60825-00026-g7065511b7003-dirty #82
> > 	[   89.676507] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
> > 	[   89.682787] task: c2b39500 task.stack: c3034000
> > 	[   89.687327] PC is at export_store+0x34/0x170
> > 	[   89.691598] LR is at _kstrtoull+0x2c/0x70
> > 	[   89.695607] pc : [<c04b1cb0>]    lr : [<c048a0e4>]    psr: 60000013
> > 	[   89.695607] sp : c3035ea0  ip : c04b1c7c  fp : bec8eb0c
> > 	[   89.707068] r10: ee1e9b8c  r9 : c3035f80  r8 : 00000002
> > 	[   89.712287] r7 : c2b70800  r6 : 00000000  r5 : ee1e9b80  r4 : 00000=
000
> > 	[   89.718806] r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : 00000=
000
> > 	[   89.725327] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Se=
gment user
> > 	[   89.732453] Control: 30c5387d  Table: 82b16700  DAC: 55555555
> > 	[   89.738193] Process sh (pid: 284, stack limit =3D 0xc3034210)
> > 	[   89.743758] Stack: (0xc3035ea0 to 0xc3036000)
> > 	[   89.748116] 5ea0: ee1e9b8c 00000000 0014e408 00000002 ee1e9b80 0000=
0000 00000000 ee19f180
> > 	[   89.756286] 5ec0: c3035f80 c035fc98 00000000 00000000 c3070180 c035=
fbd8 0014e408 c3035f80
> > 	[   89.764456] 5ee0: 00000000 00000002 00000000 c030167c 032cf000 c109=
bf44 c109bf44 c02f88b0
> > 	[   89.772625] 5f00: ee8270c0 c02fac24 00000001 c3035f10 ef05c9e0 c030=
0fd8 c0327c08 c2b7b000
> > 	[   89.780794] 5f20: 0000000a c2b7e000 c3184ec0 0000000a 00000400 c2b7=
e040 00000000 c3070180
> > 	[   89.788964] 5f40: 00000002 0014e408 c3035f80 00000000 00000002 c030=
2464 00000001 0000000a
> > 	[   89.797132] 5f60: c2d076c0 c3070180 c3070180 00000000 00000000 0014=
e408 00000002 c03031b0
> > 	[   89.805302] 5f80: 00000000 00000000 00000014 00000002 0014e408 b6e7=
4d50 00000004 c02075e4
> > 	[   89.813470] 5fa0: c3034000 c0207440 00000002 0014e408 00000001 0014=
e408 00000002 00000000
> > 	[   89.821638] 5fc0: 00000002 0014e408 b6e74d50 00000004 00000002 0000=
0004 b6f0e000 bec8eb0c
> > 	[   89.829808] 5fe0: 00000000 bec8ea64 b6d9ffa4 b6df970c 60000010 0000=
0001 0b0a0908 0f0e0d0c
> > 	[   89.837996] [<c04b1cb0>] (export_store) from [<c035fc98>] (kernfs_f=
op_write+0xc0/0x1cc)
> > 	[   89.846005] [<c035fc98>] (kernfs_fop_write) from [<c030167c>] (__vf=
s_write+0x1c/0x114)
> > 	[   89.853940] [<c030167c>] (__vfs_write) from [<c0302464>] (vfs_write=
+0xa4/0x168)
> > 	[   89.861252] [<c0302464>] (vfs_write) from [<c03031b0>] (SyS_write+0=
x3c/0x90)
> > 	[   89.868304] [<c03031b0>] (SyS_write) from [<c0207440>] (ret_fast_sy=
scall+0x0/0x34)
> > 	[   89.875883] Code: ebff6164 e2506000 ba000039 e59d1004 (e5943014)=20
> > 	[   89.882225] ---[ end trace 716eda7e65a4136a ]---
> >=20
> > Given that we need a class associated with a device in order for it to
> > generate uevents (why is that so, by the way?), I think we'd need to add
> > a separate class implementation for PWM devices. That has the downside
> > of adding yet another subdirectory to /sys/class, but I can't really
> > think of another way of achieving what you need here.
> >=20
> > Greg, any ideas?
>=20
> *sigh*, nevermind. I realized too late that I hadn't fully applied your
> patch and the change to use device_create_with_groups() actually gets
> rid of this.
>=20
> Unfortunately....
>=20
> > > index 01695d4..cb2b376 100644
> > > --- a/drivers/pwm/sysfs.c
> > > +++ b/drivers/pwm/sysfs.c
> > > @@ -23,6 +23,8 @@
> > >  #include <linux/kdev_t.h>
> > >  #include <linux/pwm.h>
> > > =20
> > > +static struct class pwm_class;
> > > +
> > >  struct pwm_export {
> > >  	struct device child;
> > >  	struct pwm_device *pwm;
> > > @@ -222,6 +224,10 @@ static struct attribute *pwm_attrs[] =3D {
> > >  };
> > >  ATTRIBUTE_GROUPS(pwm);
> > > =20
> > > +static const struct device_type pwm_channel_type =3D {
> > > +	.name		=3D "pwm_channel",
> > > +};
> >=20
> > In order to do some tracing, I ended up implementing the ->uevent()
> > callback of struct device_type. What I noticed when exporting a PWM is
> > that that ->uevent() gets called recursively and the operation never
> > finishes. I have no idea why that happens, though.
>=20
> ... that's still there. However the output is now somewhat cleaner and
> the ->uevent() callback doesn't seem to be called recursively but rather
> repeatedly (until I unexport the PWM again).
>=20
> Let me investigate a little more where this is coming from. For
> reference, I have the below on top of your patch.

Calling dump_stack() in pwm_uevent() indicates that someone in userspace
keeps reading the file:

	[   65.685811] pwm pwmchip0:0: > pwm_uevent(dev=3Dc2ac1400, env=3Deeb2e000)
	[   65.692388] CPU: 0 PID: 282 Comm: sh Not tainted 4.8.0-rc3-next-2016082=
5-00027-gcd8380ab5fe3-dirty #90
	[   65.701706] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
	[   65.708076] [<c020f26c>] (unwind_backtrace) from [<c020a704>] (show_sta=
ck+0x10/0x14)
	[   65.715877] [<c020a704>] (show_stack) from [<c04721d8>] (dump_stack+0x8=
8/0x9c)
	[   65.723142] [<c04721d8>] (dump_stack) from [<c04b1cac>] (pwm_uevent+0x3=
0/0x54)
	[   65.730449] [<c04b1cac>] (pwm_uevent) from [<c0535970>] (dev_uevent+0xe=
4/0x1cc)
	[   65.737810] [<c0535970>] (dev_uevent) from [<c0475538>] (kobject_uevent=
_env+0x200/0x508)
	[   65.745938] [<c0475538>] (kobject_uevent_env) from [<c0535380>] (device=
_add+0x364/0x568)
	[   65.754056] [<c0535380>] (device_add) from [<c04b1ddc>] (export_store+0=
x10c/0x174)
	[   65.761666] [<c04b1ddc>] (export_store) from [<c035fc98>] (kernfs_fop_w=
rite+0xc0/0x1cc)
	[   65.769712] [<c035fc98>] (kernfs_fop_write) from [<c030167c>] (__vfs_wr=
ite+0x1c/0x114)
	[   65.777662] [<c030167c>] (__vfs_write) from [<c0302464>] (vfs_write+0xa=
4/0x168)
	[   65.785002] [<c0302464>] (vfs_write) from [<c03031b0>] (SyS_write+0x3c/=
0x90)
	[   65.792091] [<c03031b0>] (SyS_write) from [<c0207440>] (ret_fast_syscal=
l+0x0/0x34)
	[   65.799866] pwm pwmchip0:0: < pwm_uevent() =3D 0
	[   65.803675] pwm pwmchip0:0: > pwm_uevent(dev=3Dc2ac1400, env=3Deeaba000)
	[   65.803706] CPU: 2 PID: 191 Comm: systemd-journal Not tainted 4.8.0-rc3=
-next-20160825-00027-gcd8380ab5fe3-dirty #90
	[   65.803718] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
	[   65.803791] [<c020f26c>] (unwind_backtrace) from [<c020a704>] (show_sta=
ck+0x10/0x14)
	[   65.803838] [<c020a704>] (show_stack) from [<c04721d8>] (dump_stack+0x8=
8/0x9c)
	[   65.803880] [<c04721d8>] (dump_stack) from [<c04b1cac>] (pwm_uevent+0x3=
0/0x54)
	[   65.803917] [<c04b1cac>] (pwm_uevent) from [<c0535970>] (dev_uevent+0xe=
4/0x1cc)
	[   65.803949] [<c0535970>] (dev_uevent) from [<c0533c1c>] (uevent_show+0x=
b0/0x11c)
	[   65.803977] [<c0533c1c>] (uevent_show) from [<c05341c4>] (dev_attr_show=
+0x1c/0x48)
	[   65.804018] [<c05341c4>] (dev_attr_show) from [<c036067c>] (sysfs_kf_se=
q_show+0x88/0xf8)
	[   65.804059] [<c036067c>] (sysfs_kf_seq_show) from [<c03243a4>] (seq_rea=
d+0x1ec/0x49c)
	[   65.804093] [<c03243a4>] (seq_read) from [<c0301570>] (__vfs_read+0x1c/=
0x10c)
	[   65.804125] [<c0301570>] (__vfs_read) from [<c0302334>] (vfs_read+0x8c/=
0x118)
	[   65.804157] [<c0302334>] (vfs_read) from [<c0303120>] (SyS_read+0x3c/0x=
90)
	[   65.804194] [<c0303120>] (SyS_read) from [<c0207440>] (ret_fast_syscall=
+0x0/0x34)
	[   65.804220] pwm pwmchip0:0: < pwm_uevent() =3D 0
	[   65.815938] pwm pwmchip0:0: > pwm_uevent(dev=3Dc2ac1400, env=3Deeaba000)
	[   65.815969] CPU: 2 PID: 191 Comm: systemd-journal Not tainted 4.8.0-rc3=
-next-20160825-00027-gcd8380ab5fe3-dirty #90
	[   65.815981] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
	[   65.816056] [<c020f26c>] (unwind_backtrace) from [<c020a704>] (show_sta=
ck+0x10/0x14)
	[   65.816103] [<c020a704>] (show_stack) from [<c04721d8>] (dump_stack+0x8=
8/0x9c)
	[   65.816143] [<c04721d8>] (dump_stack) from [<c04b1cac>] (pwm_uevent+0x3=
0/0x54)
	[   65.816182] [<c04b1cac>] (pwm_uevent) from [<c0535970>] (dev_uevent+0xe=
4/0x1cc)
	[   65.816211] [<c0535970>] (dev_uevent) from [<c0533c1c>] (uevent_show+0x=
b0/0x11c)
	[   65.816238] [<c0533c1c>] (uevent_show) from [<c05341c4>] (dev_attr_show=
+0x1c/0x48)
	[   65.816280] [<c05341c4>] (dev_attr_show) from [<c036067c>] (sysfs_kf_se=
q_show+0x88/0xf8)
	[   65.816321] [<c036067c>] (sysfs_kf_seq_show) from [<c03243a4>] (seq_rea=
d+0x1ec/0x49c)
	[   65.816354] [<c03243a4>] (seq_read) from [<c0301570>] (__vfs_read+0x1c/=
0x10c)
	[   65.816386] [<c0301570>] (__vfs_read) from [<c0302334>] (vfs_read+0x8c/=
0x118)
	[   65.816418] [<c0302334>] (vfs_read) from [<c0303120>] (SyS_read+0x3c/0x=
90)
	[   65.816455] [<c0303120>] (SyS_read) from [<c0207440>] (ret_fast_syscall=
+0x0/0x34)
	[   65.816479] pwm pwmchip0:0: < pwm_uevent() =3D 0

Even adding content to the env object doesn't change this. Am I using
this incorrectly?

Thierry

--/Rh48Y0bnrojh5Wm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJXzZJOAAoJEN0jrNd/PrOhJF4QALGiKXOpP47ILMtc6A5hMM6s
6jOo/qk6tVDztJ1XsjnNB6bMq7rbPlCUU+Wd6GCdsbNHBsye6wuDFNQ5Uil2jRgE
UBx6suTPsiFFVY5V/tZZI40htB7Aa8eZMT14ny74XalyHa/lJGDjr0lXJIy97HoI
FLX+bfMCq++r52Phu0X7tJ0VJjIoUFXPFwiBFh8vFOte0SEBH7YVT9s13PgahPhu
6tWJfwAcyOn1QmXKyFSbXggUlkl9BfLFfxRkXc1+bboYOqp9f59NooDmvBfiqe3c
TLoVEHVKy1ZrzDxgK4qba3Pg/KneYs5FCkRLAZcsUO3lSaS9Ppa3pG4M0x9iIMPd
7Ia7C9DJwEgnfYkAiYZFyzdk8q79IfsSSLgy38Gn8KTEtK4nlkAvHxg0ZfW3OjOv
EIujtRbvMy3bF58QiK/l9R2I62KnpSmg1uUIaulDwaa+9iswfLPV6Lo1JGgt+ehA
sx910tnqabYgH8AHT9iEYiezjfmm8G99rp7wLLeKhw5kCepzUptbyskKIRzw5C/U
iuaWV3GAwXE5ayUwUScxiiRYDoZt5yrOFzW3gn8s3yRqCDb7jXeJ0XbkzHCkk/Vm
PYbcaDA0lHdabRBnJKv98aDOxobFn6JOHzl+UzjxHlyumFv9yf29UnoF7an3YX7W
6KrEUtsdAWizRH5ecrvz
=kgc2
-----END PGP SIGNATURE-----

--/Rh48Y0bnrojh5Wm--
