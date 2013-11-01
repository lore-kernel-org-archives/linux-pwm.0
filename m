Return-Path: <thierry.reding@gmail.com>
Date: Fri, 1 Nov 2013 11:20:06 +0100
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/1] pwm: samsung: Fix kernel warning while unexporting a
 channel
Message-ID: <20131101102005.GL27864@ulmo.nvidia.com>
References: <1383022663-22315-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qgd2S+2VS1hsWwXW"
Content-Disposition: inline
In-Reply-To: <1383022663-22315-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-pwm.vger.kernel.org>
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, tomasz.figa@gmail.com


--Qgd2S+2VS1hsWwXW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2013 at 10:27:43AM +0530, Sachin Kamat wrote:
> PWM channel data was set to NULL before freeing it. This caused the
> following kernel warning while unexporting the channel. Set the channel
> data to NULL after freeing it.
>=20
> [   70.495000] WARNING: CPU: 0 PID: 1 at drivers/base/devres.c:805 pwm_pu=
t+0x48/0x80()
> [   70.505000] Modules linked in:
> [   70.505000] CPU: 0 PID: 1 Comm: sh Not tainted 3.12.0-rc6-next-2013102=
4-00012-gd4aec04-dirty #58
> [   70.515000] [<c0014ddc>] (unwind_backtrace+0x0/0xf4) from [<c0011784>]=
 (show_stack+0x10/0x14)
> [   70.525000] [<c0011784>] (show_stack+0x10/0x14) from [<c03a3cbc>] (dum=
p_stack+0x7c/0xb0)
> [   70.530000] [<c03a3cbc>] (dump_stack+0x7c/0xb0) from [<c001de68>] (war=
n_slowpath_common+0x6c/0x88)
> [   70.540000] [<c001de68>] (warn_slowpath_common+0x6c/0x88) from [<c001d=
f20>] (warn_slowpath_null+0x1c/0x24)
> [   70.550000] [<c001df20>] (warn_slowpath_null+0x1c/0x24) from [<c01d1af=
8>] (pwm_put+0x48/0x80)
> [   70.560000] [<c01d1af8>] (pwm_put+0x48/0x80) from [<c01d21c8>] (pwm_un=
export_store+0x94/0xac)
> [   70.565000] [<c01d21c8>] (pwm_unexport_store+0x94/0xac) from [<c010991=
c>] (sysfs_write_file+0x148/0x1d8)
> [   70.575000] [<c010991c>] (sysfs_write_file+0x148/0x1d8) from [<c00b2a8=
0>] (vfs_write+0xb4/0x1a0)
> [   70.585000] [<c00b2a80>] (vfs_write+0xb4/0x1a0) from [<c00b3068>] (SyS=
_write+0x3c/0x78)
> [   70.595000] [<c00b3068>] (SyS_write+0x3c/0x78) from [<c000e2e0>] (ret_=
fast_syscall+0x0/0x30)
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/pwm/pwm-samsung.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry

--Qgd2S+2VS1hsWwXW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSc4BVAAoJEN0jrNd/PrOhKMsP/0rHw680zvX+2z/BL95HKOID
WBa0EEQhs+gJwwYiVk+3RFScMGPE8OLGOI0DjiM/GDgq9HwMVtaupZzaYzTzi8Zu
A/kO1nk7RyQNJkkRkI6Rek6RP686PUFZbgZcPFGdkXJAKlUyGEJaHFv0H0EDR4hW
w9kAM/csHFB80pQLAsnosU7FmPQ1mWh3UaWja38/htPROzkED3Jc7XgjC+eXjxRw
XkSM9mR6MARRfPXMJKlW5f5pinJirV2AV07Zg2oXvirAE9mpU03FCfimITRs/ofn
YXSOOgQI8RBfEQp+W3z63IHi2vWcOT0PJGrt0FhciFKedwqWox6GSY7+kCQnOn4y
2g6/TI7Pis0uGBKkvl150F+NT/8qc50ZBAgPT6r+WWDxuJYHvRut1sW3Hgqwo0sp
SjG/0RlMrHXMWfkgAgOXPpyRZG8MWRC1VuCZgrPzgZZh0riMksDlSg2Q2mQYPQN6
u7pHSvvV6eOyHDgUk2A1ZvYC+lI/cMz1HnDo3CKaEXZZ42DtyBDnfxvs/YFtcLNY
ZGP76uCDAG0rpsoGPf5C/RP97L+hVYIP5qiLo5EYubgJ2U3DaOxralKECL2hU5PE
f6O5fd/BJlQ4LoIJm+MJNscoM8p5w55FjZrveXRaW1eAI5nJVaCcgUWKqSs7+/aw
4rHBp8/zbJg623xaSNud
=i0DS
-----END PGP SIGNATURE-----

--Qgd2S+2VS1hsWwXW--
