From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [BUG] pwm: sysfs: It is not possible to export more than one
 channel
Date: Tue, 25 Sep 2018 12:21:53 +0200
Message-ID: <20180925102153.GI7097@ulmo>
References: <cd7b3cad-98bf-d976-2e30-0b018f51f90a@ysoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AptwxgnoZDC4KQWS"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cd7b3cad-98bf-d976-2e30-0b018f51f90a@ysoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>, Gottfried Haider <gottfried.haider@gmail.com>, linux-pwm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, H Hartley Sweeten <hsweeten@visionengravers.com>
List-Id: linux-pwm@vger.kernel.org


--AptwxgnoZDC4KQWS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 25, 2018 at 11:11:32AM +0200, Michal Vok=C3=A1=C4=8D wrote:
> Hi,
>=20
> Since commit 7e5d1fd75c3d ("pwm: Set class for exported channels in
> sysfs") it is not possible to export more than one PWM channel.
>=20
> This is because for each exported channel a directory named pwmN is
> created in /sys/class/pwm/. As channels for all PWM chips are numbered
> from 0 it is not possible to export pwmN channel from one chip and
> pwmN channel from another chip at the same time.
>=20
> In theory if your SoC has N PWM chips and each chip has N channels you
> should be able to export N channels. But only one channel from each chip.
>=20
> I found the issue on i.MX6dl SoC with two PWM chips where each PWM chip
> has just one channel.
>=20
> This is how it can be reproduced:
>=20
> root@hydraco:/sys/class/pwm# ls
> pwmchip0 -> ../../devices/soc0/soc/2000000.aips-bus/2080000.pwm/pwm/pwmch=
ip0
> pwmchip1 -> ../../devices/soc0/soc/2000000.aips-bus/208c000.pwm/pwm/pwmch=
ip1
>=20
> root@hydraco:/sys/class/pwm# cat pwmchip0/npwm
> 1
> root@hydraco:/sys/class/pwm# cat pwmchip1/npwm
> 1
>=20
> root@hydraco:/sys/class/pwm# echo 0 > pwmchip0/export
> root@hydraco:/sys/class/pwm# ls -l
> pwm0 -> ../../devices/soc0/soc/2000000.aips-bus/2080000.pwm/pwm/pwmchip0/=
pwm0
> pwmchip0 -> ../../devices/soc0/soc/2000000.aips-bus/2080000.pwm/pwm/pwmch=
ip0
> pwmchip1 -> ../../devices/soc0/soc/2000000.aips-bus/208c000.pwm/pwm/pwmch=
ip1
>=20
> root@hydraco:/sys/class/pwm# echo 0 > pwmchip1/export
> [  543.110824] sysfs: cannot create duplicate filename '/class/pwm/pwm0'
> [  543.117314] CPU: 1 PID: 351 Comm: sh Not tainted 4.19.0-rc5-00025-g249=
f3ed-dirty #8
> [  543.124990] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [  543.131587] [<80112d20>] (unwind_backtrace) from [<8010ddb4>] (show_st=
ack+0x20/0x24)
> [  543.139383] [<8010ddb4>] (show_stack) from [<80ba1044>] (dump_stack+0x=
80/0x94)
> [  543.146652] [<80ba1044>] (dump_stack) from [<8031e2b4>] (sysfs_warn_du=
p+0x6c/0x78)
> [  543.154257] [<8031e2b4>] (sysfs_warn_dup) from [<8031e61c>] (sysfs_do_=
create_link_sd+0xd8/0xdc)
> [  543.162988] [<8031e61c>] (sysfs_do_create_link_sd) from [<8031e678>] (=
sysfs_create_link+0x38/0x44)
> [  543.171986] [<8031e678>] (sysfs_create_link) from [<806026b0>] (device=
_add+0x2c8/0x630)
> [  543.180025] [<806026b0>] (device_add) from [<80602a3c>] (device_regist=
er+0x24/0x28)
> [  543.187724] [<80602a3c>] (device_register) from [<80501acc>] (export_s=
tore+0x118/0x190)
> [  543.195762] [<80501acc>] (export_store) from [<805ffc10>] (dev_attr_st=
ore+0x28/0x34)
> [  543.203539] [<805ffc10>] (dev_attr_store) from [<8031d7dc>] (sysfs_kf_=
write+0x48/0x54)
> [  543.211485] [<8031d7dc>] (sysfs_kf_write) from [<8031cde0>] (kernfs_fo=
p_write+0xf8/0x1e0)
> [  543.219696] [<8031cde0>] (kernfs_fop_write) from [<80294d78>] (__vfs_w=
rite+0x48/0x170)
> [  543.227645] [<80294d78>] (__vfs_write) from [<80295064>] (vfs_write+0x=
b4/0x1c0)
> [  543.234981] [<80295064>] (vfs_write) from [<802952e8>] (ksys_write+0x5=
c/0xbc)
> [  543.242144] [<802952e8>] (ksys_write) from [<80295360>] (sys_write+0x1=
8/0x1c)
> [  543.249313] [<80295360>] (sys_write) from [<80101000>] (ret_fast_sysca=
ll+0x0/0x54)
> [  543.256901] Exception stack(0xecfbffa8 to 0xecfbfff0)
> [  543.261980] ffa0:                   00000002 76fc8000 00000001 76fc800=
0 00000002 00000000
> [  543.270184] ffc0: 00000002 76fc8000 76f5cd60 00000004 00000002 000bd13=
4 00000001 000ba730
> [  543.278380] ffe0: 00000000 7ebff954 76e8b988 76ee3cd0
> -sh: echo: write error: File exists
>=20
> I am not sure what will be the right solution. The problem is that
> numbering of the PWM channels does not work the same way as in the GPIO
> subsystem where each GPIO has its unique number.
>=20
> Should we just revert the change? It was not documented in the PWM sysfs
> interface. What do you think?

Fabrice has reported the same thing. We've been discussing possible
solutions here:

	http://patchwork.ozlabs.org/patch/973224/

It looks to me like we'd need to at least revert the patch to restore
the sysfs ABI. At the same time I think we'll want to fix the issue that
the offending commit was trying to address.

Thierry

--AptwxgnoZDC4KQWS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluqDD4ACgkQ3SOs138+
s6GR0w/9E1Rmy75TdPZxrPH26950BBRF0eDAd5k2SebseMoOcgvByKfe+QiB82ip
sLw3QZAtXikOBZys5GNVZ/lY7+tkPSMk9R8nR5LkYfRf+GJloS2eQdA61fGRypVV
/H/F81gwpURxQVgYcdNBm3c2LryT9JJHQWjrQHDO24lQetjhKFwy6tbTQdwfvct5
7F+NuG2cYCsTx2U9quD2nJv4dXwiqsuTes8BxSrIZF2oGRdNM3ZJ4iPtUxxrbiei
0iV/Jo+Q5KgnZLUjJHrpFlYfwGbQXZvBhRYfzkgPPKTAG+XPOYR+W3LoN1brGUiu
C+BrYiIxjDpOmAeKKId8IXOCm3sydelFBdrx5B8vTlqT8qOSiEdWL3L9wMTYfJco
CcOFwwmlhFhsWGyivsw4Joy1Puiz/qi/8mE2OuDp+ErzT+OAyl26Me0k+qF2Rlyh
w1kubG4ooT8FcQTzu51VMW3RVyBujSuN2Gy3mvR8MEHS+j+2NmRLo6rDkEyfxtpF
A7irnNnLvHW02fRvkXGrAF9BvvuLoqPhLCUEvIkBkfsGOfcr3uKnTcs6yEe6TRtv
g/+K/W8M8ypS80KfJXCn0sOBd/h7dno8xIZ2/WB8G/dGpgzGyHsla+TkQxrjsESe
SXx29as0PUX2u0FenOBrNpe6jsLZa83WC0p8Rh1eCNLUgLhjtjg=
=PTiU
-----END PGP SIGNATURE-----

--AptwxgnoZDC4KQWS--
