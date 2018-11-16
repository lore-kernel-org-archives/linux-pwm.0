From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/4] pwm: Add new helper to initialize a pwm_state
 variable with defaults
Date: Fri, 16 Nov 2018 11:24:28 +0100
Message-ID: <20181116102428.GC14769@ulmo>
References: <20181026184157.16371-1-u.kleine-koenig@pengutronix.de>
 <20181114123236.GG2620@ulmo>
 <20181115091644.d5hdk5vao6x74zwp@pengutronix.de>
 <20181115162159.GD8611@ulmo>
 <20181115210535.mxmyjjbpzrjdufsr@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0228818933232894906=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181115210535.mxmyjjbpzrjdufsr@pengutronix.de>
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


--===============0228818933232894906==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kVXhAStRUZ/+rrGn"
Content-Disposition: inline


--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2018 at 10:05:35PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Thu, Nov 15, 2018 at 05:21:59PM +0100, Thierry Reding wrote:
> > On Thu, Nov 15, 2018 at 10:16:44AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > On Wed, Nov 14, 2018 at 01:32:36PM +0100, Thierry Reding wrote:
> > > > On Fri, Oct 26, 2018 at 08:41:55PM +0200, Uwe Kleine-K=C3=B6nig wro=
te:
> > > > > This helps to convert drivers from the legacy API to pwm_apply_st=
ate without
> > > > > having to make the aware of the configured polarity (and in some =
cases even
> > > > > period).
> > > > >=20
> > > > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix=
=2Ede>
> > > > > ---
> > > > >  include/linux/pwm.h | 13 ++++++++++---
> > > > >  1 file changed, 10 insertions(+), 3 deletions(-)
> > > >=20
> > > > So if I understand your intention correctly here you want consumers=
 to
> > > > be able to get at the default state, which would be the state as it=
 was
> > > > "configured" in DT or the PWM lookup table so that you can modify t=
hat
> > > > state (well, really just setting the duty-cycle) before you actually
> > > > send the state to the hardware.
> > > >=20
> > > > So the difference to pwm_apply_args() is that you don't want the dr=
iver
> > > > to specifically program a duty cycle of 0 before setting the actual=
 duty
> > > > cycle that you want to set.
> > > >=20
> > > > Is that about right?
> > >=20
> > > Yes, and a resulting advantage is that the apply callback is only cal=
led
> > > once.
> > > =20
> > > > Isn't that exactly what pwm_init_state() already does? pwm-backlight
> > > > uses it for exactly the same purpose that you seem to be using it in
> > > > RX1950 backlight control.
> > >=20
> > > I didn't use pwm_init_state because that doesn't give a helpful value
> > > for state->enabled. (I think it is: if the driver provides a get_state
> > > callback it is whatever that one set, otherwise it's off.)
> >=20
> > That's correct. It's pretty much the same thing that you have, except
> > you explicitly set enable =3D false. But that's not really important
> > because consumers are supposed to explicitly override that anyway.
>=20
> If we hardcode to enable=3Dfalse the call to pwm_get_state could be
> dropped, too. Then the two functions are really semantically identical.
> >=20
> > > Also the name pwm_init_state isn't that good IMHO. Just from the name
> > > I'd expect it to be something like
> > >=20
> > > 	memset(state, 0, sizeof(&state));
> > >=20
> > > instead of something more informed that depends on hardware state and=
/or
> > > data provided by a device tree.
> >=20
> > Be that as it may, the kerneldoc is pretty explicit about what it does
> > and so is the code. Not liking the name shouldn't be an excuse for
> > duplicating functionality.
>=20
> With your suggestion to move the initialisation of ->state into the
> core, maybe this function can go away from the public API such that the
> naming doesn't really matter (and can be adapted easily).

Yeah, I think it would be best to move it into core.c and make it static
in that case. There should be no need for anyone to create any special
state, they can just use pwm_get_state() instead.

Thierry

--kVXhAStRUZ/+rrGn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvumtsACgkQ3SOs138+
s6H/3RAAgGYreZQ0DRulJIPnUM6KqBcashdaA3+B98Fs/6KHqKEMZraRtBTOxo2B
/mI42bSrvi8iXBQnN49EuDE7aVeb0pUfSrOUFUocYpQ1Wx0tHmRMTraKyTaVIixr
CliJGaj9jdgJDCDuvRjTD3sE3x4F8/nrYEABmH9tk4DYim4FJvKqbG+Vtc81vVLV
I+qN5/7CEoGJHOLM8YlypmlEEcaq0H4jDGTLfyyzuBzRXovLBKMBVs3QL/lz54hQ
3FPcCHNkMA5Vr/+ah5nJerDaHPblC/6kkVrA8J2QO1RwKu4d7LCqDxHBczBDj38O
kVeX6q34XZEUZWMO6716Z2Ltm/Ah+1ZI9+LThOOQWkCwIoigVuoulWoulYQCR0tp
FENjzGCxrWnWNzb5Tm0khsMnGoPWVWR60+JPxOYve9DgeiEFCYy4QTeXC/9Y7l5L
5q6R6XR5a2zLgK6bc3iSrVvuMONKioaEK0UCZT2sv326l4H1ik7H1sz4v6xWtziQ
9Sarf0RkkqrfoE0O3f8kBaufDTwsIWyKsFWs6hB9Nr7tKQii64kFKEJpOc5V+9+A
mot07Q0xq1KJK2Ek7GV4xKJMNYCC5+ApJ0+yfxWvRXTMuWbhR6pfeBKiNVUjJQf+
SE+W45TVVgUXe+23wQBwSStC4uGzHg6RR0wBE37AoelTHP66dlI=
=DaJo
-----END PGP SIGNATURE-----

--kVXhAStRUZ/+rrGn--


--===============0228818933232894906==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0228818933232894906==--
