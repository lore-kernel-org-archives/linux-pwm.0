From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/4] gpio: mvebu: Add limited PWM support
Date: Mon, 20 Mar 2017 14:49:21 +0100
Message-ID: <20170320134921.GO22463@ulmo.ba.sec>
References: <20170316064218.9169-1-ralph.sennhauser@gmail.com>
 <20170316064218.9169-2-ralph.sennhauser@gmail.com>
 <CACRpkdZ=bor380ic_X36M7vVbopDCZe9Yb9TxkmOHyO75gdAnw@mail.gmail.com>
 <20170318153753.GA22088@lunn.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="S0GG+JvAI2G0KxBG"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170318153753.GA22088@lunn.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Linus Walleij <linus.walleij@linaro.org>, Ralph Sennhauser <ralph.sennhauser@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Imre Kaloz <kaloz@openwrt.org>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Mauro Carvalho Chehab <mchehab@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>, "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org


--S0GG+JvAI2G0KxBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 18, 2017 at 04:37:53PM +0100, Andrew Lunn wrote:
> > > +static void mvebu_pwm_free(struct pwm_chip *chip, struct pwm_device =
*pwmd)
> > > +{
> > > +       struct mvebu_pwm *pwm =3D to_mvebu_pwm(chip);
> > > +       struct gpio_desc *desc =3D gpio_to_desc(pwmd->pwm);
> > > +       unsigned long flags;
> > > +
> > > +       spin_lock_irqsave(&pwm->lock, flags);
> > > +       gpiod_free(desc);
> > > +       pwm->used =3D false;
> > > +       spin_unlock_irqrestore(&pwm->lock, flags);
> > > +}
> >=20
> > No need to set the output value to zero or something here?
> > And turn off blinking? Or is that done some other way?
>=20
> Hi Linus
>=20
> The disable op will turn of blinking. I've not checked, but i assume
> the PWM core will not allow you to free an enabled PWM?

Actually it will. It's probably a good idea to add a WARN_ON() to the
PWM core if that situation arises. I don't think going as far as
prohibiting it will do any good, though. It's not like drivers will
have much of a choice if pwm_put() fails. Typically they'd do that in
their ->remove() call, at which point failure is difficult to deal with.

> > I think both of these need to be tagged __maybe_unused to not give
> > noise in randconfig builds.
>=20
> I've not seen any 0-day patch emails giving warnings. So i suspect it
> is O.K.

Linus was probably referring to !PM configurations. I'm not sure how
often they'll get run, but as long as it doesn't make it into linux-next
the chances aren't very high (I don't think the 0-day builder executes
randconfig builds).

Thierry

--S0GG+JvAI2G0KxBG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAljP3eEACgkQ3SOs138+
s6FKUxAAhiWb2v/kY5uFn3M4lFcCOoIX1QdIOouOCRKQAzrTGBejMiFCvHSeQRAF
tATnrMIbvU+TZj7XKuXuVkR2lfHE0V7iz8T4KofmKaA1+21AdGYkBma6qz+DZ6Rq
S/7hIUD1aFqZBDZyO9jdw6sbEDCeiX0p2X6HH0eiEvg90Wj/zX+BYngsAryYL63r
/25PV9SZp5XRWPuPizb5COK+KcLUbx4loo+fIvxb4ISjIvlBB/E3VH0y1PdJ2Ss5
rCXXal7YF+XSKFhH5ze/oNu6DeTq+3mjGyasxpD1bJ6M+E3EgFI7rbMHltSmmJpQ
GH8ikOHUNLX6EoU+f/LGghUc/ci4PlAnOyygwLV334M07a72VcIs0bX72plowvOn
+TzAjDZzZB4YBMOnX9L0d4eUOX+YgKLoBPWPSNx1zF22IOGavxzOz+cHVAt8Zi4z
g5PNLoWkXjHOy/ZimDqW8t56811IrWbNYtEoC29dfeOwO02/Zc3fiz9LELcN6q5G
SHxh/tAJ2U7RPovzqRjDxLNj6Pvw22TXwd3WyhxFEL/E04pl4cp9VMKKSA8A7roL
ZU6NSHHWXff9VHHf346vjPv6Z7K1edfMuAsVeRMdTtRZIDxDP/k7M+dhwXqEiMnm
lAEvQX3mPPWiJoD8a7oTwCKJHPuaoD6nZUvquY4lZdFhA0QAmc0=
=DilI
-----END PGP SIGNATURE-----

--S0GG+JvAI2G0KxBG--
