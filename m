From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/4] pwm: Add new helper to initialize a pwm_state
 variable with defaults
Date: Thu, 15 Nov 2018 17:21:59 +0100
Message-ID: <20181115162159.GD8611@ulmo>
References: <20181026184157.16371-1-u.kleine-koenig@pengutronix.de>
 <20181114123236.GG2620@ulmo>
 <20181115091644.d5hdk5vao6x74zwp@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8908335071104386954=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181115091644.d5hdk5vao6x74zwp@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: kernel@pengutronix.de, linux-pwm@vger.kernel.org, Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>, Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org


--===============8908335071104386954==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6Nae48J/T25AfBN4"
Content-Disposition: inline


--6Nae48J/T25AfBN4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2018 at 10:16:44AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Wed, Nov 14, 2018 at 01:32:36PM +0100, Thierry Reding wrote:
> > On Fri, Oct 26, 2018 at 08:41:55PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > This helps to convert drivers from the legacy API to pwm_apply_state =
without
> > > having to make the aware of the configured polarity (and in some case=
s even
> > > period).
> > >=20
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > >  include/linux/pwm.h | 13 ++++++++++---
> > >  1 file changed, 10 insertions(+), 3 deletions(-)
> >=20
> > So if I understand your intention correctly here you want consumers to
> > be able to get at the default state, which would be the state as it was
> > "configured" in DT or the PWM lookup table so that you can modify that
> > state (well, really just setting the duty-cycle) before you actually
> > send the state to the hardware.
> >=20
> > So the difference to pwm_apply_args() is that you don't want the driver
> > to specifically program a duty cycle of 0 before setting the actual duty
> > cycle that you want to set.
> >=20
> > Is that about right?
>=20
> Yes, and a resulting advantage is that the apply callback is only called
> once.
> =20
> > Isn't that exactly what pwm_init_state() already does? pwm-backlight
> > uses it for exactly the same purpose that you seem to be using it in
> > RX1950 backlight control.
>=20
> I didn't use pwm_init_state because that doesn't give a helpful value
> for state->enabled. (I think it is: if the driver provides a get_state
> callback it is whatever that one set, otherwise it's off.)

That's correct. It's pretty much the same thing that you have, except
you explicitly set enable =3D false. But that's not really important
because consumers are supposed to explicitly override that anyway.

> Also the name pwm_init_state isn't that good IMHO. Just from the name
> I'd expect it to be something like
>=20
> 	memset(state, 0, sizeof(&state));
>=20
> instead of something more informed that depends on hardware state and/or
> data provided by a device tree.

Be that as it may, the kerneldoc is pretty explicit about what it does
and so is the code. Not liking the name shouldn't be an excuse for
duplicating functionality.

Thierry

--6Nae48J/T25AfBN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvtnScACgkQ3SOs138+
s6Eg/g//XCysWU179K5mdnAtsY3H6UjMDxKTZQjEt9kmhlMfwmiv11Q/krJ3jCAF
YdvvfemOKX/m8moEhk4EObMpw5L/YoKS0jApyaEqU/W4+xuTGoqWdE/3jjoDZ4uL
43APkmIw2u9aZKmAe0OwabBPkaIhGorw4Q9ECY1WszRIrU/JeOs88CncdvzsciwZ
lIu4z3ZQoYHtZ/1MpPpqN8UWQGIsbf5Oxatuur+g3NmeRgkmC7toqbcCPb7HsL9U
PcQ3WWtsiQ/lrgziFP26zzp+2M+D4PuVoxcpKTNoAOGoMnxheAbKwd7u01v1TlNi
p9qURx3Bxi2+UO4jFTpZYYB2gnORFID/pO36PcvV7Bo/ATrl1CHeOsXY0Lbbf+80
8a4DO9ddno37VZTNmT5ID7zyVI2instD1i2dUUEHPBez2qQwA6d7Z1NekCEZ1tr+
7/BQdAZUt52SA0ZHwjuSb8zuk8yDuybjIMktz2Et4y7wzaLnUEvWFd8AvUAYUdA/
zpAqQ9KP2vOhNVkxLqLTsW69hAvTeTDCMbhLt80eq6bBJ0uDASmQpUGA+chzoRML
q1KOVlkgm0iEqXTt6BR5YeAY25xW2eI3itGTJSlsbWCB+qBYmP+XkvDL0h3YsgLP
ft6NGsFY7kAhmFVzCfyPVXu0DA5O2UpzNX/TfkSCF9cx2IJ/F0g=
=0PO/
-----END PGP SIGNATURE-----

--6Nae48J/T25AfBN4--


--===============8908335071104386954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8908335071104386954==--
