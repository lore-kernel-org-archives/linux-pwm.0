From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: pca9685: Fix misuse of regmap_update_bits
Date: Wed, 18 Jan 2017 12:00:32 +0100
Message-ID: <20170118110032.GN18989@ulmo.ba.sec>
References: <1480438970-15317-1-git-send-email-florian.vaussard@heig-vd.ch>
 <20161205163402.GA14964@archie.localdomain>
 <20170118105510.GK18989@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="O27Gs9jTTFWz3gAR"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170118105510.GK18989@ulmo.ba.sec>
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: linux-pwm@vger.kernel.org, Florian Vaussard <florian.vaussard@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--O27Gs9jTTFWz3gAR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 18, 2017 at 11:55:10AM +0100, Thierry Reding wrote:
> On Mon, Dec 05, 2016 at 05:34:02PM +0100, Clemens Gruber wrote:
> > On Tue, Nov 29, 2016 at 06:02:50PM +0100, Florian Vaussard wrote:
> > > Using regmap_update_bits(..., mask, 1) with 'mask' following (1 << k)
> > > and k greater than 0 is wrong. Indeed, _regmap_update_bits will perfo=
rm
> > > (mask & 1), which results in 0 if LSB of mask is 0. Thus the call
> > > regmap_update_bits(..., mask, 1) is in reality equivalent to
> > > regmap_update_bits(..., mask, 0).
> > >=20
> > > In such a case, the correct use is regmap_update_bits(..., mask, mask=
).
> > >=20
> > > This driver is performing such a mistake with the MODE1_RESTART mask,
> > > which equals (1 << 6). Fix the driver to make it consistent with the
> > > API. Please note that this change is untested, as I do not have this
> > > piece of hardware. Testers are welcome!
> > >=20
> > > Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
> > > ---
> > >  drivers/pwm/pwm-pca9685.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> > > index 117fccf..6b9ff6c 100644
> > > --- a/drivers/pwm/pwm-pca9685.c
> > > +++ b/drivers/pwm/pwm-pca9685.c
> > > @@ -124,7 +124,8 @@ static int pca9685_pwm_config(struct pwm_chip *ch=
ip, struct pwm_device *pwm,
> > >  			 */
> > >  			if (duty_ns =3D=3D pca->duty_ns) {
> > >  				regmap_update_bits(pca->regmap, PCA9685_MODE1,
> > > -						   MODE1_RESTART, 0x1);
> > > +						   MODE1_RESTART,
> > > +						   MODE1_RESTART);
> > >  				return 0;
> > >  			}
> > >  		} else {
> > > --=20
> > > 2.5.5
> >=20
> > Good catch!
> > During testing your change however, I noticed that this whole
> > conditional for duty_ns =3D=3D pca->duty_ns (which I added) is bogus:
> > Restarting the chip means using the same ON and OFF times as before, so
> > the duty cycle "ratio" stays the same, relative to the period.
> > Here we are checking for an equal duty cycle in nanoseconds though..
> >=20
> > Instead we would have to check if the ratio changed and only if it did
> > not, set the RESTART bit.
> >=20
> > Or we could just remove that conditional. This is only an optimization
> > for the special case of changing both period_ns and duty_ns at the same
> > time but with the same ratio as before.
>=20
> So what's the status on this?

Oh wait, that's what these:

	http://patchwork.ozlabs.org/patch/705438/
	http://patchwork.ozlabs.org/patch/705437/

are fixing, right?

Florian, I take it there's no reason to apply this patch anymore given
that Clemens' patch removes this hunk and replaces it with a proper fix
for this particular driver?

Thierry

--O27Gs9jTTFWz3gAR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlh/StAACgkQ3SOs138+
s6GkYA//dvED3+NEEb36CAUGk019x5DLC6xQ5XVRk6/Lu3PNNpDkGztzSrYOAiIO
7ygpDQ3ucfF6+QgaUIVNdT+PS2b/cduRiD/DgdWw3i+zFe5H13GO+I/tiHEbcnSp
+uIdGABDy90WfimJtU9JUL1rNe99eEPAM1fqKOtC3Y4/PnPtitM75XZZHI7ifp3/
1FH680/VQk5Ys0SO5R2drdj2vslgyhrsN2yJxfBpHe6vJXVVBpbpWZHf+tA943qf
Em9DTY3T82/igYzqZ5f8GeRnYS5G+x+M/BSIfJGNhGXJqLpOAHBgKKKq986H3M4y
S8/LW6Sh4vCEHDRClWxobj2CXLXf2HPNbOUZyRA5Zldjxe7hZE9HfoXM9VSVeNk4
/6hKAOr2g2ISZv3JSCow2XgKTO8Dy01qY9Yoc5OBsTll0QtjLFuG1eDboHvKPEZz
/6IA6qWn0LpoU5YD7ybAu3Y0oeTg8jgjIvoAvfwH3q5LaPBgbu5kDxWIRxBhoYIz
MrXBiYwR+3pq6O9ZkVpJf+LJPdoM/NQjYhyoiRH1pladBmw0ChIX9+wj7uD6s/RX
nYB5TdKhZNwnUcmsnPFN35ATu3t5UHcgl5rASTdjMjGJUH/rKbV7AvawBUta2Vxx
2lJu5XUJ9iHaC55X0Kfpu+0qQ9xkST6y0hW80DyxU/j4bGCJ2tM=
=6nH+
-----END PGP SIGNATURE-----

--O27Gs9jTTFWz3gAR--
