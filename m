From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: constify pwm_ops structures
Date: Wed, 18 Jan 2017 11:49:36 +0100
Message-ID: <20170118104936.GJ18989@ulmo.ba.sec>
References: <1484071926-21582-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7855040322075939098=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1484071926-21582-1-git-send-email-bhumirks@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: linux@prisktech.co.nz, julia.lawall@lip6.fr, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--===============7855040322075939098==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rwgQ89ZNnFUwFHTC"
Content-Disposition: inline


--rwgQ89ZNnFUwFHTC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 10, 2017 at 11:42:06PM +0530, Bhumika Goyal wrote:
> Declare pwm_ops structures as const as they are only stored in the ops
> field of a pwm_chip structure. This field is of type const struct pwm_ops
> *, so pwm_ops structures having this property can be declared as const.
> Done using Coccinelle:
>=20
> @r1 disable optional_qualifier@
> identifier i;
> position p;
> @@
> static struct pwm_ops i@p=3D{...};
>=20
> @ok1@
> identifier r1.i;
> position p;
> struct pxa_pwm_chip pwm;
> struct bfin_pwm_chip bwm;
> struct vt8500_chip vp;
> struct imx_chip icp;
> @@
> (
> pwm.chip.ops=3D&i@p
> |
> bwm.chip.ops=3D&i@p
> |
> vp.chip.ops=3D&i@p
> |
> icp.chip.ops=3D&i@p
> )
>=20
> @bad@
> position p!=3D{r1.p,ok1.p};
> identifier r1.i;
> @@
> i@p
>=20
> @depends on !bad disable optional_qualifier@
> identifier r1.i;
> @@
> +const
> struct pwm_ops i;
>=20
> File size details:
>=20
>    text	   data	    bss	    dec	    hex	filename
>    1646	    328	      0	   1974	    7b6	drivers/pwm/pwm-imx.o
>    1742	    224	      0	   1966	    7ae	drivers/pwm/pwm-imx.o
>=20
>    1941	    296	      0	   2237	    8bd	drivers/pwm/pwm-pxa.o
>    2037	    192	      0	   2229	    8b5	drivers/pwm/pwm-pxa.o
>=20
>    1946	    296	      0	   2242	    8c2	drivers/pwm/pwm-vt8500.o
>    2050	    192	      0	   2242	    8c2	drivers/pwm/pwm-vt8500.o
>=20
> The drivers/pwm/pwm-bfin.o file did not compile.
>=20
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
> File: drivers/pwm/pwm-bfin.c is not tested
>=20
>  drivers/pwm/pwm-bfin.c   | 2 +-
>  drivers/pwm/pwm-imx.c    | 2 +-
>  drivers/pwm/pwm-pxa.c    | 2 +-
>  drivers/pwm/pwm-vt8500.c | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

Thierry

--rwgQ89ZNnFUwFHTC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlh/SEAACgkQ3SOs138+
s6EVmBAAg9oolXDX7TbnYKdo9leL7v0LJQ4Nd2Wg4M6n7bLnM76uMwVXfPhNCAhO
euUP0njFBt9uaY7gVFjyXS2M4QEp3GrnoLU5afpXnCbg/KhJqhkmFEFuRQkoCmu3
TyytVn7WMuuwWrKcW/Qg/3XScjf1VUJ3vOz+377lwo05FIgi/5dmTsJR/jmQ5oBs
wg3CpCa7ZVsLPFEgly4pvsTdt5zP5ISuoW0MeKPLrF1DuHbCPtuK462aixiLDU8Y
fpKVdfHuVNX0ZhJFk4fxYyMgUoXtETWtiW6FtROYNiPZsNoCs5cGosCUI+nD7JWr
8I43QQ4RCCnuNx4m4Foa9GXlvGRDh1joxn81ZcZ8Hag+LacFxJHNSnq/4lwPv5gf
QBTyXmyIjQOv7FG8AkzBOsbsdqh91m6sC4VjSuDvhJ8RaAunmmoEl1hRy8Wd0067
9u26JWkBGTv/yGoT/bZrd8l0UZDTm5Oz7f+sOiYq2lO0E6iT/RmbOR7elMAZXQT2
pHWQ/8j52qfHOwrNztooV4fj9lIxMv2dnEyT0BCVWMmn8QhpHEJpBFB8ruL0/IFL
KtYyW1Di2lrvOYVb8t7cE0+PXlbmayUbipqnYSrU3vJOJN6mFeJ+5qDxRcQjBHJn
VKwUPrLMRYqHROm4QGTQnBeBE72IRdlXH3Y8jONer+DrlmFc5VA=
=5MBc
-----END PGP SIGNATURE-----

--rwgQ89ZNnFUwFHTC--


--===============7855040322075939098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7855040322075939098==--
