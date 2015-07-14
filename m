From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 15/15] regulator: pwm: properly initialize the
 ->state field
Date: Tue, 14 Jul 2015 11:51:55 +0100
Message-ID: <20150714105155.GS11162@sirena.org.uk>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <1435738921-25027-16-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4dPuo10YNMwpRGtG"
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1435738921-25027-16-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-leds-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Doug Anderson <dianders@google.com>
List-Id: linux-pwm@vger.kernel.org


--4dPuo10YNMwpRGtG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 01, 2015 at 10:22:01AM +0200, Boris Brezillon wrote:
> The ->state field is currently initialized to 0, thus referencing the
> voltage selector at index 0, which might not reflect the current voltage
> value.

This looks like it'll need reworking on top of Lee's recent changes to
implement continuous voltage support for PWM regulators - we may be
calculating the values to set dynamically at runtime.

--4dPuo10YNMwpRGtG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVpOnLAAoJECTWi3JdVIfQagwH/iXHJjioAUY2XgiYn2QvKjb2
wyJciaJ+GkifoNXyeU0pbsC2eqlXoEr+v8e6yIlhSxRyzPWHtsPTgA8mLxyHh8mL
Oz4/iYvp+jYcLpL4ZRbcs2hspJyTQoi/UDK704Dl5ZXbgrPYZcTNVZtsxo5hEFQO
O/wXv62iK+pBbnNsHEE+WjM7Mznb5r1hUsibV+tRjFYaet0UYXS4ufD2kEoI19jG
MZZ4hgc7U0VMCQ3TXxIVL4E6jTViqVUOqmkbtAi21vP3cFFK9i/q9ELCHoAi+o3j
hgAugIY8luUzVVqXZTwCzsPA8t6PSHe7hZpi2M/yWKLzwj0JHgQPMhopnrTYRkc=
=JMo+
-----END PGP SIGNATURE-----

--4dPuo10YNMwpRGtG--
