From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v5 1/2] pwm: sifive: Add DT documentation for SiFive PWM
 Controller
Date: Wed, 6 Feb 2019 13:40:55 +0100
Message-ID: <20190206124055.GF21676@ulmo>
References: <1548762199-7065-1-git-send-email-yash.shah@sifive.com>
 <1548762199-7065-2-git-send-email-yash.shah@sifive.com>
 <20190130081411.5rva7cpwoy2l5qjd@pengutronix.de>
 <CAJ2_jOHiJ3X5VYZMCNk2bpvUdDOsrqHJna3HPvtdNQpJB9fxjg@mail.gmail.com>
 <20190206110730.ogqxncrnblyazgjw@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eDB11BtaWSyaBkpc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190206110730.ogqxncrnblyazgjw@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Yash Shah <yash.shah@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sachin Ghadi <sachin.ghadi@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>
List-Id: linux-pwm@vger.kernel.org


--eDB11BtaWSyaBkpc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2019 at 12:07:30PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Wed, Feb 06, 2019 at 04:18:47PM +0530, Yash Shah wrote:
> > On Wed, Jan 30, 2019 at 1:44 PM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > >
> > > On Tue, Jan 29, 2019 at 05:13:18PM +0530, Yash Shah wrote:
> > > > DT documentation for PWM controller added.
> > > >
> > > > Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> > > > [Atish: Compatible string update]
> > > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > > > ---
> > > >  .../devicetree/bindings/pwm/pwm-sifive.txt         | 33 ++++++++++=
++++++++++++
> > > >  1 file changed, 33 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifiv=
e.txt
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b=
/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> > > > new file mode 100644
> > > > index 0000000..8dcb40d
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> > > > @@ -0,0 +1,33 @@
> > > > +SiFive PWM controller
> > > > +
> > > > +Unlike most other PWM controllers, the SiFive PWM controller curre=
ntly only
> > > > +supports one period for all channels in the PWM. This is set globa=
lly in DTS.
> > >
> > > You can simply drop this if the first user can set this using the usu=
al
> > > interface. Don't you like this suggestion that I already made a few
> > > times now?
> > >
> > > Did you consider to make the driver support only a single output with=
 a
> > > more flexible period setting?
> >=20
> > We cannot consider supporting only single output since we have boards t=
hat
> > use the additional PWM channels to control individual LED brightness
> > of a tri-color LED.
> > If we go down to one channel, then we can't control the brightness of
> > the individual LEDs.
> > It will break the use case.
>=20
> OK.
>=20
> > I am considering the below approach, let me know if it's fine by you.
> >=20
> > - Drop the global period property and allow the only first user to chan=
ge period
> > using the usual interface.
> > - A note in the binding that all PWMs need to run at the same
> > period. If the driver already refuses to apply incompatible periods,
> > the users are going to notice that they've got the DT wrong.
> > - In driver code, count the users using the .request and .free callback=
s.
> > Based on this, allow changes to period iff the user count is one.
>=20
> Not sure you need to point this limitation in the binding doc. Other
> than that this is fine.

I think it's useful to point this out in the binding documentation since
it's something that device tree writers will want to know.

Thierry

--eDB11BtaWSyaBkpc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxa1dcACgkQ3SOs138+
s6FwnxAAnOiWlI5IXor27eIlWOEiHliIvBCTzMGSSDQ44AM/j+38k8KSzvq+n1qW
s207o9cjcOdJ3RCDh3fc26RLUVDJktckltr3KErgeaWuHZOktAlCznk6dlr8KNgo
eNTM31TqOtDKo5w6bWLvJ1hL+VUgqOCQDvHmyKzPIN8mfde3E+qegEq67QLicCzx
f9TPgGt6rBW5T7dGYgFmXcScanUrsJJsNSZchz3Jr8rhwQH6yzngWiaKVQJAZFfi
/elDBQecb/RGrFWae136qGSkcc1iXs613WCotxx9VwS1LeboMOXNSbsZOaBNK4JK
4948roLoBNZePVPaUfDFZjc6JiVOZO7cjJWystXdniw2DjYjjT8jeAX6Ib2uSOcw
/nZg7dd7t5XATDLe6X8WHvcgmrBZJ9pzEtFfcZfYy9yS3qD6f1fGxn3x+s9lbbzp
MA89TJdvZw1frVRbYq4dn5fMwqSm8Xkk/0f+aP8JyYYPgbDDnHl3vxja1wop6X2P
XjomhsxSXcUZ8ingcWpVZdrFQXKzg7iZKxRLI0UUl/6mwfflq7vOZ1DsuRYkBLvw
sXel5NH8sm2LHdnGl2ygss++aOhS5ycN9jwMHhxA+PqUz+geiXNWMD36ufKuq32O
IZZoeldKTLKTKcuouWqYIuc9unhQRvbNQTATCoLe4FRJw3bmBWE=
=l1j6
-----END PGP SIGNATURE-----

--eDB11BtaWSyaBkpc--
