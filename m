From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] drivers: pwm: pwm-bcm-kona: update macros to remove
 braces around numbers
Date: Mon, 4 Mar 2019 12:27:25 +0100
Message-ID: <20190304112725.GB7617@ulmo>
References: <1547667682-5095-1-git-send-email-sheetal.tigadoli@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1547667682-5095-1-git-send-email-sheetal.tigadoli@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 17, 2019 at 01:11:22AM +0530, Sheetal Tigadoli wrote:
> update macros to remove braces around numbers
>=20
> Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
> ---
>  drivers/pwm/pwm-bcm-kona.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Applied, thanks.

I dropped the "drivers: " prefix and shortened pwm-bcm-kona to bcm-kona
because PWM is already implied by the "pwm: " prefix. I've also replaced
the commit message with a real rationale rather than repeating the
subject.

Please keep this in mind for future patches.

Thierry

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlx9C50ACgkQ3SOs138+
s6EL9hAAhKtTMkUPAPy7awGRhP1g8u0EYPLDrMEyywa89xRkDOZDaxZjMnlOGFwU
oBNBaK1Ibq+dT3C8beWcXXcviRemaMdJiX9zgbwOPpiWMDtl0TfMyDYC5Q3wGYHi
/RVfQhGl26Z2D96irtXH3dmNzbHib+P1yE2kkEihd1YLwqOdNXvx3+eRMH0bHOpJ
VcGHlO0JH2OOBjOf6rvsn6W94mHd6wqQl4agnCHIHVq8IPnki0/QgO/rCrvOwDtl
n3BXqu5bUZs7Vn5jFsLyjO1zbDBw/Ms2SXrtySCJfOUiFiaVbsKElwgN7l5dVj9M
2m9lJiaJHvOqLATD2IjY9pCHZcvJLMtB7R7zPX6eYlmwpEUCNndR2Dtz5WTGyvQJ
O0PRWjNldCLJBcLNdGNvDOHXnWQeIvGKXhzr6rcNEB+1X2NLJWv5S7lBqRdaqAnK
E6QQRByImLIvjYefom3H/aH4dkeEkg0GeeNXoeRn424rEGaNVIL9dlUl56ht6IWX
n369nH8z+ysmAwEhcaOFx+R2DTfHeKvDb4TrJqHwypZCCyUaIadkTJw8QixkCWIM
djLSmkTuDsYNz1hh75lImUbcIFAWUlEQthxrAenaZa/PCC1+vnH9hEhgsfnQQBnx
kNJGuN/EuOUtlRkCuzUo7w7GXLA9ujB/2wwS4qgVCAJ2UI+Ipsk=
=P3qZ
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
