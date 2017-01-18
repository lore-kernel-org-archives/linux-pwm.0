From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: pca9685: Fix misuse of regmap_update_bits
Date: Wed, 18 Jan 2017 11:55:10 +0100
Message-ID: <20170118105510.GK18989@ulmo.ba.sec>
References: <1480438970-15317-1-git-send-email-florian.vaussard@heig-vd.ch>
 <20161205163402.GA14964@archie.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6K2R/cS9K4qvcBNq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161205163402.GA14964@archie.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: linux-pwm@vger.kernel.org, Florian Vaussard <florian.vaussard@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--6K2R/cS9K4qvcBNq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2016 at 05:34:02PM +0100, Clemens Gruber wrote:
> On Tue, Nov 29, 2016 at 06:02:50PM +0100, Florian Vaussard wrote:
> > Using regmap_update_bits(..., mask, 1) with 'mask' following (1 << k)
> > and k greater than 0 is wrong. Indeed, _regmap_update_bits will perform
> > (mask & 1), which results in 0 if LSB of mask is 0. Thus the call
> > regmap_update_bits(..., mask, 1) is in reality equivalent to
> > regmap_update_bits(..., mask, 0).
> >=20
> > In such a case, the correct use is regmap_update_bits(..., mask, mask).
> >=20
> > This driver is performing such a mistake with the MODE1_RESTART mask,
> > which equals (1 << 6). Fix the driver to make it consistent with the
> > API. Please note that this change is untested, as I do not have this
> > piece of hardware. Testers are welcome!
> >=20
> > Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
> > ---
> >  drivers/pwm/pwm-pca9685.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> > index 117fccf..6b9ff6c 100644
> > --- a/drivers/pwm/pwm-pca9685.c
> > +++ b/drivers/pwm/pwm-pca9685.c
> > @@ -124,7 +124,8 @@ static int pca9685_pwm_config(struct pwm_chip *chip=
, struct pwm_device *pwm,
> >  			 */
> >  			if (duty_ns =3D=3D pca->duty_ns) {
> >  				regmap_update_bits(pca->regmap, PCA9685_MODE1,
> > -						   MODE1_RESTART, 0x1);
> > +						   MODE1_RESTART,
> > +						   MODE1_RESTART);
> >  				return 0;
> >  			}
> >  		} else {
> > --=20
> > 2.5.5
>=20
> Good catch!
> During testing your change however, I noticed that this whole
> conditional for duty_ns =3D=3D pca->duty_ns (which I added) is bogus:
> Restarting the chip means using the same ON and OFF times as before, so
> the duty cycle "ratio" stays the same, relative to the period.
> Here we are checking for an equal duty cycle in nanoseconds though..
>=20
> Instead we would have to check if the ratio changed and only if it did
> not, set the RESTART bit.
>=20
> Or we could just remove that conditional. This is only an optimization
> for the special case of changing both period_ns and duty_ns at the same
> time but with the same ratio as before.

So what's the status on this?

Thierry

--6K2R/cS9K4qvcBNq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlh/SY4ACgkQ3SOs138+
s6H3oBAAo6A1b8p+hLLfRYR8gY6qIn1tRkblGGc9Zs0wAPE1xNEqfZ7mD05sArZI
/8NqTW2WfdjE7H2LcQnJ/u97FUH/xOFmlDSTxg0ApPh1oa8rroNAq0cHpU6Ka98Z
OUaA5W+KpQTDVkpp2sAr1DcG7wc92bbm57NAYVmyeqSkLn9CE5IuXKXSgk9Sew6f
ZGLtPmgtzrO0uLqYs/YIRSyM5c+8i+nFuFQwHGV+xz9MD2SD8mBPaiEiiWNUDDDM
bOkKalaBPtVTCpEDODlwcuPyQtLgyTZRibgZcDJHiHbBds4hJY01YVxp1g0JvIQg
bYxlhcCCDKch5BlZ+TEvfupulTlHwQMokle3JnuoYEJWt4zRgBNEbVBrs3xKHHRX
za9tseU1FgS014TBvzZKXj9BvN2J/yP3aTbsRQVLO5MavtXjIdK7BSPeQrpb/pSf
Ye6fgmLf6O6iKJ80cHsdQFcw387OrBgvewJ2H38emewWKtHB50GA2NzTLZAEAQSa
Xph4qy8gQs2dWoQEGctuQakn3clh9g2uGJ0J+j6dNS+qKfCMju9iR74aqLrb7Qv0
U793ZYI6cDVwdMja0QAfnbbTIgtbnZ+JgomtOi1Yq+xtPL9nOCB09uXf/PCCeGbA
779u1Fk6yEjdF4XOwi7mnnseGtg904MGO2x+vhMNWGVU5GXXAdU=
=gve/
-----END PGP SIGNATURE-----

--6K2R/cS9K4qvcBNq--
