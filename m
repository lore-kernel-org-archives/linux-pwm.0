From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v5 1/2] pwm: sifive: Add DT documentation for SiFive PWM
 Controller
Date: Wed, 6 Feb 2019 17:16:34 +0100
Message-ID: <20190206161634.GB23805@ulmo>
References: <1548762199-7065-1-git-send-email-yash.shah@sifive.com>
 <1548762199-7065-2-git-send-email-yash.shah@sifive.com>
 <20190130081411.5rva7cpwoy2l5qjd@pengutronix.de>
 <CAJ2_jOHiJ3X5VYZMCNk2bpvUdDOsrqHJna3HPvtdNQpJB9fxjg@mail.gmail.com>
 <20190206110730.ogqxncrnblyazgjw@pengutronix.de>
 <20190206124055.GF21676@ulmo>
 <20190206153854.52bqbwf2ty2j7rvj@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190206153854.52bqbwf2ty2j7rvj@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Yash Shah <yash.shah@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sachin Ghadi <sachin.ghadi@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>
List-Id: linux-pwm@vger.kernel.org


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2019 at 04:38:54PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Wed, Feb 06, 2019 at 01:40:55PM +0100, Thierry Reding wrote:
> > On Wed, Feb 06, 2019 at 12:07:30PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > On Wed, Feb 06, 2019 at 04:18:47PM +0530, Yash Shah wrote:
> > > > On Wed, Jan 30, 2019 at 1:44 PM Uwe Kleine-K=C3=B6nig
> > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > >
> > > > > On Tue, Jan 29, 2019 at 05:13:18PM +0530, Yash Shah wrote:
> > > > > > DT documentation for PWM controller added.
> > > > > >
> > > > > > Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> > > > > > [Atish: Compatible string update]
> > > > > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > > > > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > > > > > ---
> > > > > >  .../devicetree/bindings/pwm/pwm-sifive.txt         | 33 ++++++=
++++++++++++++++
> > > > > >  1 file changed, 33 insertions(+)
> > > > > >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-s=
ifive.txt
> > > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.t=
xt b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> > > > > > new file mode 100644
> > > > > > index 0000000..8dcb40d
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> > > > > > @@ -0,0 +1,33 @@
> > > > > > +SiFive PWM controller
> > > > > > +
> > > > > > +Unlike most other PWM controllers, the SiFive PWM controller c=
urrently only
> > > > > > +supports one period for all channels in the PWM. This is set g=
lobally in DTS.
> > > > >
> > > > > You can simply drop this if the first user can set this using the=
 usual
> > > > > interface. Don't you like this suggestion that I already made a f=
ew
> > > > > times now?
> > > > >
> > > > > Did you consider to make the driver support only a single output =
with a
> > > > > more flexible period setting?
> > > >=20
> > > > We cannot consider supporting only single output since we have boar=
ds that
> > > > use the additional PWM channels to control individual LED brightness
> > > > of a tri-color LED.
> > > > If we go down to one channel, then we can't control the brightness =
of
> > > > the individual LEDs.
> > > > It will break the use case.
> > >=20
> > > OK.
> > >=20
> > > > I am considering the below approach, let me know if it's fine by yo=
u.
> > > >=20
> > > > - Drop the global period property and allow the only first user to =
change period
> > > > using the usual interface.
> > > > - A note in the binding that all PWMs need to run at the same
> > > > period. If the driver already refuses to apply incompatible periods,
> > > > the users are going to notice that they've got the DT wrong.
> > > > - In driver code, count the users using the .request and .free call=
backs.
> > > > Based on this, allow changes to period iff the user count is one.
> > >=20
> > > Not sure you need to point this limitation in the binding doc. Other
> > > than that this is fine.
> >=20
> > I think it's useful to point this out in the binding documentation since
> > it's something that device tree writers will want to know.
>=20
> OK, we're talking about an FPGA implementation but I still think if the
> dt-author is the first to know about this limitation this is too late.
> The hardware designer must know about that, and they don't look into the
> bindind documentation. The binding documentation should IMHO only
> describe the binding and functional limitiations of the device are out
> of scope.
>=20
> The binding for the Freescale network interface doesn't describe that it
> only supports 480 MBit/s in its GHz mode, and that's good. The binding
> for i2c devices doesn't describe that a reboot in the middle of a
> transfer might block the bus.
>=20
> The target for the binding documentation is to document how a given
> device is described in a device tree. It's not there to duplicate
> information that belongs in the reference manual.

But the device tree bindings for PWM devices describe where and how to
describe the period for each PWM that you reference. That's entirely
different from the examples that you give above.

The generic PWM documentation implies that the period can be set per PWM
channel, so explicitly pointing out in the bindings for a specific
controller that this is *not* the case is a good thing.

And really, it's not like we're quoting pages and pages from technical
reference documentation. This is just a single sentence in a very short
document. Surely that's not going to hurt anyone.

Thierry

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxbCF8ACgkQ3SOs138+
s6EnRg/8DZPAgCNvPVS/a+jRlwqJhv9aVhz9u6XHyfVdbR/jHxlSqN6wOZMtA4H4
YRfV7z5sUgeHCLhE2/UJ8Tem5/Yl5z70+AaisEtl8jpdlKoyjFBd1CFI56rzV8KU
y41I72cvxyJaYJD3SsXKC08uSxJM6LI2k+69PR1grnl2p986E/jnl1SVtf3SdvqL
SZkUv6LeJso7xDQ0s3b2IR/EWBbf1gswgAMqF91Va3N4v3Zj6wdbEAEZ39BWeRG8
Ppsosf3ZT7MhJmNbH5HJVE25byLtQlSYmvZtWx8kgebtHeMXc+9y0KxvLJ2nXM9a
xohh9kQ7/oLpHWx5UeIaJjdDBTrhHqH+dhGqM4sLmc86uhn/QYu7PQfIJLhBRK7O
FsqLgLIG9lA1cx53ejwOHhJXRTpnknBGxBKSxcEXY/7o01SWql6ZmdjSV5rzR8UQ
eGCtKlxXzLu9IoIA/udKhB6PPaYZ2LFnQ+3Baxu4ClWqfbQifQbOfubs2+gxFcXw
pTVi67+UayYYDYPMd7opYBn0qrl8+PZnnacjEE1tvODxvrUBqma6UNlmes8AwO/b
n92XlnWNb5gcBBDUTO3Sgic9w1Z4B2rvVNvsjVy0AEe9IBecM2Xo/YI8nZdXoNPT
QZ0byEZtoIanOp3dQ7TuTxmp+w+HFtRjrlg496U5K4ZyQ3L5qFY=
=nSuJ
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--
