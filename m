From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 0/2] PWM: atmel: few fixes
Date: Tue, 18 Mar 2014 21:14:08 +0100
Message-ID: <20140318201403.GC5917@mithrandir>
References: <1394806749-29778-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m51xatjYGsM+13rf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1394806749-29778-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Bo Shen <voice.shen@atmel.com>, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--m51xatjYGsM+13rf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2014 at 03:19:07PM +0100, Alexandre Belloni wrote:
> Hi,
>=20
> Here are a few improvement for pwm-atmel. The first patch makes the driver
> actually respect the polarity.
>=20
> The second patch is solving an issue that I was trying to solve back in o=
ctober.
> When the channel was disabled, the output level got inversed. It actually=
 was
> that we had the polarity wrong from the beginning.
>=20
> Alexandre Belloni (2):
>   PWM: atmel-pwm: Fix polarity handling
>   PWM: atmel: correct CDTY calculation
>=20
>  drivers/pwm/pwm-atmel.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Both patches applied, thanks.

Thierry

--m51xatjYGsM+13rf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTKKkLAAoJEN0jrNd/PrOhBlgQAIqp9mOCN2/WfUn3kfQ43+5M
xF4qxEC8BokS8JQrKp0bF4HZrprJFcHuKgSskyN++5UA/89mGzv6v7ZH72dSK8SC
amJfJ6CqUXpo7lnMfuwj94AwOhWPbBn/7JTx5CLCUxIrkGRlZbesP7p6m8cXzm9n
ka4r4g4x7lryt//E47PWKmMNYVw0mtvl/9YLlzuQO4hgOngCKrZc1qRmBLvG04K+
d5PhnxtQ7o7m0usHVgILBQgaV+Ku933tR6glQnHYAwN/8UZdOjp+p9j0A0F0iAsF
6fzrh9z5nTY9vS+UzU+zgeCjkWUXmFsgVuc7LYv0wHgElMpq35jLcumxeLBMtOs4
enp2SKMYIftZ0V6ehLZnNSbGHEbcSTWz2hG9dIaKm0ZbRUTAQSZyZ7BSVlNQuMZn
lilVC9+e+TEa70VKEbkwzE18R4CREpGavllFDpJMeor4Imq32uCCMXKjBWffmz2Z
TwRTBz65nIyopddMRmFp7nRNXAKE56B2JP/CqwNWjyD3/jptFZOIVNFvYU2mGdtY
bo6zeCeC80f1TDTR17s0P2YvDQqCvvmawxbHemyE5B6CYkmYGaiaP2G84qzrn4+k
VdrcE8XwW6SqKMcW3+TyYp+0b6cRuYkoaP4647A+RRCdLgyzTJnKI3Fp9f1yk5rs
56U7TPBYSn3hJE5XOOwc
=bNMy
-----END PGP SIGNATURE-----

--m51xatjYGsM+13rf--
