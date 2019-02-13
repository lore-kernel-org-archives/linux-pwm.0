From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/2] pwm: hibvt: Add hi3559v100 support
Date: Wed, 13 Feb 2019 13:30:02 +0100
Message-ID: <20190213123002.GC647@ulmo>
References: <20190212094927.5900-1-m.othacehe@gmail.com>
 <20190212094927.5900-2-m.othacehe@gmail.com>
 <20190212142850.iwgi4n6v6oep4oin@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kVXhAStRUZ/+rrGn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190212142850.iwgi4n6v6oep4oin@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Mathieu Othacehe <m.othacehe@gmail.com>, robh+dt@kernel.org, mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 12, 2019 at 03:28:50PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Tue, Feb 12, 2019 at 10:49:27AM +0100, Mathieu Othacehe wrote:
> > Add support for hi3559v100-shub-pwm and hisilicon,hi3559v100-pwm
> > platforms. They require a special quirk: pwm has to be enabled again
> > to force duty_cycle refresh.
> >=20
> > Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
> > ---
> >  drivers/pwm/pwm-hibvt.c | 26 +++++++++++++++++++++++---
> >  1 file changed, 23 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/pwm/pwm-hibvt.c b/drivers/pwm/pwm-hibvt.c
> > index 27c107e78d59..bf33aa24433c 100644
> > --- a/drivers/pwm/pwm-hibvt.c
> > +++ b/drivers/pwm/pwm-hibvt.c
> > @@ -49,6 +49,7 @@ struct hibvt_pwm_chip {
> >  	struct clk *clk;
> >  	void __iomem *base;
> >  	struct reset_control *rstc;
> > +	bool quirk_force_enable;
> >  };
> > =20
> >  struct hibvt_pwm_soc {
> > @@ -56,6 +57,7 @@ struct hibvt_pwm_soc {
> >  };
> > =20
> >  static const struct hibvt_pwm_soc pwm_soc[2] =3D {
> > +	{ .num_pwms =3D 2 },
> >  	{ .num_pwms =3D 4 },
> >  	{ .num_pwms =3D 8 },
>=20
> The members of this struct are used as of-data (in struct
> of_device_id::data below). When looking at the usage:
>=20
> 	{ .compatible =3D "hisilicon,hi3516cv300-pwm", .data =3D &pwm_soc[1] },
> 	{ .compatible =3D "hisilicon,hi3519v100-pwm", .data =3D &pwm_soc[2] },
> 	{ .compatible =3D "hisilicon,hi3559v100-shub-pwm", .data =3D &pwm_soc[2]=
 },
> 	{ .compatible =3D "hisilicon,hi3559v100-pwm", .data =3D &pwm_soc[0] },
>=20
> this isn't exactly easy to understand. I would prefer to do it as
> follows:
>=20
> 	static const struct hibvt_pwm_soc hi3516cv300_soc_info =3D {
> 		.num_pwms =3D 2,
> 	};
> 	...
>=20
> 	static const struct of_device_id hibvt_pwm_of_match[] =3D {
> 		{ .compatible =3D "hisilicon,hi3516cv300-pwm", .data =3D &hi3516cv300_s=
oc_info },
> 		...
> 	};
>=20
> Then you could also add a member to hibvt_pwm_soc to signal if that
> force_enable quirk is necessary and would not need to use
> of_device_is_compatible() to determine this. The result is that you have
> a description of all relevant differences in a single place.
>=20
> @Thierry: Also this is yet another driver instance where a num-pwms
> property would simplify the driver because up to before this patch this
> was the only difference between the different variants.

We don't need the num-pwms in device tree if it can be derived from the
compatible string.

Thierry

--kVXhAStRUZ/+rrGn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxkDcgACgkQ3SOs138+
s6FumA//UXRbb4IpLIkxjoOLtrXebSP9Ky4IE3i9sgcBnKi9gOF5vYGNTzD+phlk
nqyuxFjBZjQ0hEF7FFJYnpk2TdWta7YgNBn94L/rYP9mPWUmAiO2cZjgKrUsqcU5
bMYYARdcP02FHPQdtyB/mM6cCcnrVCDx1UOI23U+C23dm3T/SwPEqlIFnKiayOeQ
0HzXG7Gkbj6sSPG+NL+4pZVkFAMdNiAhyVwWWgCFKm09vLkbuzD4w+YMHnA/LAea
SGUAlgkw2L79ytpDDiEVcqkfccBCrOQktqozG5v2EDjbyDb+aG7aAje0wfqaVKWu
HeJW+I3TaPeM3I+k8uJ7akUXQAXBRPrjpfYzfavIdIg8j1/YmhZrLGs3tsY6ZDCF
7SLqCrHa8QHQje+auoHJ1nN22WiHj2Nfrm6QEIIXuXz2FcwAXpvxecAAaheAUSDr
R/1kHB5Bcf/XmMPv5ixbInHCg5rmDw3l9s+gCRmLzO9oPkFlL7/BZFqYBw7j5Tk5
w/HVP8MUO2FjouJBbnCopozSyhKsmluI3t8lGxQIEDPU2x9poIB6wlwSuf3+nIUY
83W4KDT9M9weSSUBv4EZyq7Y4H7m0QtLcVt46a0w2jk7SFqiOT38eOaR6N6ihaaA
LUThRR9KasBfWMuoz6nvLrczNpkrFNiFh3j4b5TkKWuJYLEnST0=
=2fgf
-----END PGP SIGNATURE-----

--kVXhAStRUZ/+rrGn--
