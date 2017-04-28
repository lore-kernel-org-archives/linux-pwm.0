From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH] pwm: sun4i: switch to atomic PWM
Date: Fri, 28 Apr 2017 11:06:38 +0200
Message-ID: <20170428090638.tkarvtkjh2pukjvo@lukather>
References: <20170427220002.20266-1-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5a6cm25flvcjnptb"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:55258 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162866AbdD1JGv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Apr 2017 05:06:51 -0400
Content-Disposition: inline
In-Reply-To: <20170427220002.20266-1-alexandre.belloni@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Olliver Schinagl <o.schinagl@ultimaker.com>, Chen-Yu Tsai <wens@csie.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org


--5a6cm25flvcjnptb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 28, 2017 at 12:00:02AM +0200, Alexandre Belloni wrote:
> Switch the driver to atomic PWM. This makes it easier to wait a proper
> amount of time when changing the duty cycle before disabling the channel
> (main use case is switching the duty cycle to 0 before disabling).
>=20
> Also, the hardware read out is now greatly improved as it was formerly on=
ly
> handling PWM polarity.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

You have a bunch of checkpatch warnings, please fix them.

Once done, you have my reviewed-by.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--5a6cm25flvcjnptb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJZAwYeAAoJEBx+YmzsjxAgdfUQAIHyuqmXjocJlIpmYaXnv3Ze
LE0GHczIBq4duimKkj8ewtfxKhiH7VluZi7+L5WlZ7x2Sm6kU6k21FmZywrZE8xp
ieqhrQn5BlG4kSxCNdsKNKkQS8wWFw3H9R6a+/TxwuvUk7tkfb32/1PO/0nMDcmj
oiasg7IBPih+RPj4xZ3aM55WH9cK0JlTGVTKF+uX6ID1pvJhN8s00xDrW/UfeQP0
bGEz4hE/M2uZbYMf9ljBiikM6aFLng3FDMkTNNBonzZxXXDj+Fjg0q3eukMClcvd
qVll0Z3G7JKqg35vjZUTm+rkSAUFj3MLtavNH2uqeDmjLVNm6NQk6VAcDQiO5mfo
NP0sli8vmS6OmWcNhJ0xuiyiJrz25Yo3qBiNySFvgZ+FfdfbwkXLf0amyjEt2nTo
oTSHRdvEFqMMxq55QlL13FBd9u+dYJpROlCaLxSS4YouUTcFC3RGLRruTV4/TxjV
76Vc5THw+R4jPJzTZhDYTOHvCxdBonT5Pg1p84xEuidelWXOmU8VVDNLajk8UnX0
DFKr5bgTuEJxNCexxF00s21fxlEhDwmw6bF54QP5RIBIdvQs+0bU1Bcg8coMfkD2
/uN5dYIE6qAM53qF5236yQTNbl0fuZXiT5q3Q1qUStIGnxbKxXQvG8qgN8xi1QGU
PtpkR2TMnVivDdsWAOw2
=a/XU
-----END PGP SIGNATURE-----

--5a6cm25flvcjnptb--
