From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 0/3] pwm: sun4i: switch to atomic PWM
Date: Wed, 31 May 2017 08:13:35 +0200
Message-ID: <20170531061335.cgqwhtpr6mqyo4zg@flea.lan>
References: <20170530193209.19247-1-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="s3n53lo5yjey4amd"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:57453 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750902AbdEaGNh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 31 May 2017 02:13:37 -0400
Content-Disposition: inline
In-Reply-To: <20170530193209.19247-1-alexandre.belloni@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Olliver Schinagl <o.schinagl@ultimaker.com>, Chen-Yu Tsai <wens@csie.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Jonathan Liu <net147@gmail.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org


--s3n53lo5yjey4amd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 30, 2017 at 09:32:06PM +0200, Alexandre Belloni wrote:
> Switch to atomic PWM. The main goal is to properly wait for a period befo=
re
> disabling a channel to ensure the correct level is set on the output.
>=20
> Changes in v2:
>  - fixed remaining checkpatch warnings
>  - split the series to ease reviews
>  - changed the delay handling to ensure the proper amount of time has ela=
psed
>    before disabling a channel
>  - dropped RDY bit handling as it doesn't have any real effect.

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--s3n53lo5yjey4amd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZLl8PAAoJEBx+YmzsjxAgpyUP/A6lq0hv7UIs98nUunH+Ga5t
aFvQY0uXzSSwiRFkdcBaLZVpib9QPcb6OCVrIo/Txgw5+fsAWDtxzfU3HR5v7ZTE
IHi5fm8fSvkgG9ILk0BRFyi7BtrPAvaI2iMcXoNBMe6gAyLfvwwV1xUs9lTRVBNW
n96bOVDnvSNqjq429NKz2AcRxnnGNeqKB4cS176ahV3CQ3sFm1oJXMY8YgpnKcg2
eU5OQrlY6r+O9+YrZErLdz3uO6wQ5y9GKyHwldFfKGazf4hKALrZO4bpq2tQbXCf
Hd0VZDgh8BQ37CnjF7zkmkOyFb6nn0VBOlgppqBKiB5xdxAOTq41L5E4z75mQSwk
Yc+Xdjh7vzpdwgU6q3XFcQcgjPsoYg6L++YBqZlJujwT2PB9xQNGoP1diGlpRj5K
3FlLntO4buiwkhgayGHl1+RrxNoGu5NOuorfjYeuopk/IgMAQ60wJQN6WXDCSkAr
1xO6n512JyJMXspyKEEx/ijFuU0wWCpz6SJz15+UKW3/iF63CB25tS4vKhwyNzoP
OmwElF5X183neMcHjD37BM8UTv35agiIgNe+AQBZpogkCTJ8+TMIrIvNl1t7aGkD
PK/AgAhKfz+Tvz10RPk+5IH/HsJTuE+D/UaSHwFd5Md4WwcQ4SxGuVx6qae6bggR
Lpa6Gq7aF9ln3sJxORoc
=12k2
-----END PGP SIGNATURE-----

--s3n53lo5yjey4amd--
