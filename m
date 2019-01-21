From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/2] pwm: sifive: Add DT documentation for SiFive PWM
 Controller
Date: Mon, 21 Jan 2019 12:20:27 +0100
Message-ID: <20190121112027.GH16756@ulmo>
References: <1547194964-16718-1-git-send-email-yash.shah@sifive.com>
 <1547194964-16718-2-git-send-email-yash.shah@sifive.com>
 <20190115201149.ghddnf27s5kqephc@pengutronix.de>
 <CAJ2_jOGPpwsn=+OU3QcHtGYJ3MFYh9azdALSeWz3-WPXL9vHnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CNfT9TXqV7nd4cfk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJ2_jOGPpwsn=+OU3QcHtGYJ3MFYh9azdALSeWz3-WPXL9vHnw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yash Shah <yash.shah@sifive.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sachin Ghadi <sachin.ghadi@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>
List-Id: linux-pwm@vger.kernel.org


--CNfT9TXqV7nd4cfk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 16, 2019 at 02:51:31PM +0530, Yash Shah wrote:
> On Wed, Jan 16, 2019 at 1:41 AM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > Hello,
> >
> > this is v3, right? It is helpful to point this out to ease reviewing.
>=20
> Yes, it is v3. Will take care of this in v4.
>=20
> >
> > On Fri, Jan 11, 2019 at 01:52:43PM +0530, Yash Shah wrote:
> > > DT documentation for PWM controller added with updated compatible
> > > string.
> >
> > Not sure what was updated here. But assuming this is compared to v2 this
> > is not a helpful info in the commit log.
>=20
> Ok, will remove the 'updated compatible string' part.
>=20
> >
> > > Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> > > [Atish: Compatible string update]
> > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > > ---
> > >  .../devicetree/bindings/pwm/pwm-sifive.txt         | 37 ++++++++++++=
++++++++++
> > >  1 file changed, 37 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.=
txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/D=
ocumentation/devicetree/bindings/pwm/pwm-sifive.txt
> > > new file mode 100644
> > > index 0000000..e0fc22a
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> > > @@ -0,0 +1,37 @@
> > > +SiFive PWM controller
> > > +
> > > +Unlike most other PWM controllers, the SiFive PWM controller current=
ly only
> > > +supports one period for all channels in the PWM. This is set globall=
y in DTS.
> > > +The period also has significant restrictions on the values it can ac=
hieve,
> > > +which the driver rounds to the nearest achievable frequency.
> > > +
> > > +Required properties:
> > > +- compatible: Please refer to sifive-blocks-ip-versioning.txt
> >
> > While the description was too verbose in v2, this is too short. You
> > should at least mention something like "sifive,pwmX" and
> > "sifive,$cpuname-pwm" (or how ever that scheme works).
>=20
> Will mention the above.
>=20
> >
> > > +- reg: physical base address and length of the controller's registers
> > > +- clocks: Should contain a clock identifier for the PWM's parent clo=
ck.
> > > +- #pwm-cells: Should be 2.
> > > +  The first cell is the PWM channel number
> > > +  The second cell is the PWM polarity
> >
> > I'd drop these two lines and refer to bindings/pwm/pwm.txt instead.
>=20
> Will be done.

I don't think you can do that. You're omitting the second cell
representing the period, so this is different from the standard binding
and therefore needs to be explicit.

That said, given the rest of the discussion in the other threads, maybe
it no longer makes sense to set the period on the whole block, but
rather just note in the binding that all PWMs need to run at the same
period. If the driver already refuses to apply incompatible periods,
your users are going to notice that they've got the DT wrong.

This would have the advantage that you can use the standard bindings.

Thierry

--CNfT9TXqV7nd4cfk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxFqvgACgkQ3SOs138+
s6HkDw/9G/+2aipEoQrz+7s6f9UOqF7LrWscQSYjZU3i8G/nYxfxiTDpwarQYIZt
Ceycjf6nt8x4bCAN76myAY8O/399OfKy/4s6EfFoIg77g5FVuhxWi0teEkn8cwo/
SvzQypcgPO40uwU7sD5gYzKv8BL2DbV/v8gHq1MZYsw6F5P6hnpk3y1dRn9udrUw
nL4qI1NR75zXBm6t+e5n3CBc6A/fBRo5juU1a4zJlxZIqbWz8Hw2MpeHZ/i22N7m
MaepSUgGGS/Bk4qa3Jy4Qg82sHjSf1GYMBQnPTlSdA+Araw7xtpxGtFRJA92q4xk
I8UEVbB7vfxqyKbcYcExzQIxnSNniRK64VQqiKq80NMVY3O/QA3gRa9aK/tQDSrG
eJvpydF29+oGW2lncgxLZPT2mwTdtW10QyvjLnXqqlA8jlzhbsKUs5e8gVF65i94
buG1R3zI9ngJ3LkkAUHFHiYZU9B0AxuZoz6X3IQlGcbInTC+lc3hB6jeNapMw5yL
4pl6vUvxKQCauM7h5XpGlOVyZfBMV/4R6wRW1dEGhRusog1zIQTbQahwix1J06Kp
N0ZbLtJ/4NJ+XSBNrFzLpM0JVKmJZdRBadJ2da6wbDmCRuULwC3rTS96rG9hEwQK
kEV573LtxIY4rXw/zsD4wTrT02eM+TOl9NtC4EQVYl7ImIn9JhI=
=ysK7
-----END PGP SIGNATURE-----

--CNfT9TXqV7nd4cfk--
