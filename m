From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v5 0/4] gpio: mvebu: Add PWM fan support
Date: Wed, 12 Apr 2017 19:16:56 +0200
Message-ID: <20170412171656.GC11964@ulmo.ba.sec>
References: <20170409180931.4884-1-ralph.sennhauser@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uh9ZiVrAOUUm9fzH"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33405 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752205AbdDLRRA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Apr 2017 13:17:00 -0400
Content-Disposition: inline
In-Reply-To: <20170409180931.4884-1-ralph.sennhauser@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Russell King <linux@armlinux.org.uk>, linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--uh9ZiVrAOUUm9fzH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 09, 2017 at 08:09:26PM +0200, Ralph Sennhauser wrote:
> Hi Therry,
>=20
> Resending this as v5 with some minor changes since v4. What is missing is
> an ACK from you so Linus can merge the driver and Gregory the dts
> changes. For this driver to make it into 4.12 it would be nice to have
> it in next soon. I hope you can make some room in your schedule to have
> another look at this series.
>=20
> Thanks
> Ralph
>=20
> ---
>=20
> Notes:
>=20
>   About npwm =3D 1:
>     The only way I can think of to achieve that requires reading the
>     GPIO line from the device tree. This would prevent a user to
>     dynamically choose a line. Which is fine for the fan found on Mamba
>     but let's take some development board with freely accessible GPIOs
>     and suddenly we limit the use of this driver. Given the above, npwm
>     =3D ngpio with only one usable at a time is a more accurate

I think "accurate" is perhaps not the word I'd choose. "npwm" is defined
as "number of PWMs controlled by this chip", and that's effectively just
the one. It's implied that all PWMs exposed by a chip can be used
concurrently.

Anyway, I can see how npwm =3D ngpio might be more convenient, and if that
is what you want to do, I don't feel strongly enough to object.

>     description of the situation. The only downside is some "wasted"
>     space.
>=20
>   About the new compatible string:
>     Orion was chosen for the SoC variant for the same reason as in
>     commit 5f79c651e81e ("arm: mvebu: use global interrupts for GPIOs on
>     Armada XP").
>     The "pwm" property remains optional for the new compatible string so
>     the compatiple string "marvell,armada-370-xp-gpio" can be used by
>     all and not just the first two GPIO chips. A property to select "Set
>     A" / "Set B" registers could be invented though.
>=20
> ---
>=20
> Pending:
>   * Needs ACK from Thierry Reding to be merged via linux-gpio tree by Lin=
us
>     Walleij. (fine with the general approach, requested changes which
>     should have been taken care of now)

As I said elsewhere, I haven't seen an Acked-by on the binding changes,
so that would be another pending item here.

Thierry

--uh9ZiVrAOUUm9fzH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAljuYQgACgkQ3SOs138+
s6F++w//ZQQVWItP/+jQOkxZTHX5ot0U2tFzFfWDCsTrPuGcK5qvkHuC8bXW0RK0
lWuoRE8F+Q8gQ/T/mdYnrTlKg3j5xlb8JA00tfvdYqN2PjShAU+XZrp6zPdXaNOp
ah6YgzNW1EZl+kLu6kRnWDgnVw2tU2jAX7YRhl+PupsRscDrkOkIBowK/NatIIxG
6/Yd7COEVtXXcj9ebkJRe35tdyJUmxEvan6u+0owDNRKb/O/e81BgH3DQjYyfh3s
tN5/i4lAaizxl/uJsvWvf0bm2QBkpwuOxr8IWBfRy7Pr1z52r5Y3SNE+sWMYePqG
WI6gHBTv6rf1qiPXkkZG7KCyswuGC/2dTaFMzt3UzYqVhovjPzwJZOy0xF15xEt7
Zhloqs+K1ol5YLUyx/KWT8TFcGVv65B9fRV1a9T8ZycdNw2QY8AjFfhdq0LrbyfB
4tUBOVJFWPL6vvM5SoNPvkhHcnVHGZCCYJzqWlM8LbhM9mMLeeGma0uYToY/f3hC
2KQeNBp+P6XtcRA745Te9spP2A2iH3/VNqjQzTLkqxxPB2zJ/KlPs5hL0058UZzN
ICogEy+ycOiSNazYdDnN4LXPHEiquq8loP6tc0b1wN7NtlE3ZcA0dDDZszXku4pr
j6NVh91oG38tHYCHZcgLO4VFzh6vlZNMWiIJPiqXKyo3F2OTWdU=
=o1SP
-----END PGP SIGNATURE-----

--uh9ZiVrAOUUm9fzH--
