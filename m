From: Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH v7 0/8] Add support for H6 PWM
Date: Thu, 21 Nov 2019 08:24:08 +0100
Message-ID: <20191121072408.GE4345@gilmour.lan>
References: <20191119175319.16561-1-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cnZewGtz8xdCmwBG"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191119175319.16561-1-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Philipp Zabel <pza@pengutronix.de>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
List-Id: linux-pwm@vger.kernel.org


--cnZewGtz8xdCmwBG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2019 at 06:53:11PM +0100, Cl=E9ment P=E9ron wrote:
> Hi,
>
> This is a rework of Jernej's previous work[1] taking account all the
> previous remarks.
>
> Bindings is still strict but probe in the driver are now optionnals.
>
> If someone could confirm that the PWM is not broken, as my board
> doesn't output it.
>
> I didn't add the acked-tags as there are big changes.

Applied 1 and 7 for 5.6, thanks!
Maxime

--cnZewGtz8xdCmwBG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXdY7mAAKCRDj7w1vZxhR
xTFOAQDiMAy9dHGZ7PpP701iv2RrsZe3P6MNSle9BJ2doLno4AEAtUYireLcQZ83
bb4k15ybFyplkNifvIeEgxnolldKeAE=
=atTd
-----END PGP SIGNATURE-----

--cnZewGtz8xdCmwBG--
