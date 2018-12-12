Return-path: <kernel-bounces@pengutronix.de>
Date: Wed, 12 Dec 2018 11:56:50 +0100
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20181212105650.GE17654@ulmo>
References: <20181015082152.5900-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Qz2CZ664xQdCRdPu"
Content-Disposition: inline
In-Reply-To: <20181015082152.5900-1-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] PWM: drop legacy wrapper for changing polarity
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, Gavin Schenk <g.schenk@eckelmann.de>, =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>


--Qz2CZ664xQdCRdPu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 15, 2018 at 10:21:52AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> The API to configure a PWM using pwm_enable(), pwm_disable(),
> pwm_config() and pwm_set_polarity() is superseeded by atomically setting
> the parameters using pwm_apply_state(). To get forward with deprecating
> the former set of functions use the opportunity that there is no current
> user of pwm_set_polarity() and remove it.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  include/linux/pwm.h | 42 ------------------------------------------
>  1 file changed, 42 deletions(-)

Applied, thanks. I did change the subject to start with "pwm: Drop" to
make it consistent with other commit messages.

Thierry

--Qz2CZ664xQdCRdPu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwQ6XIACgkQ3SOs138+
s6FoFw/+O6lzBOJKUtDWTSkn8aWirpPyQEc/PKhnkpkac1IvsXqcmv+zOJuxaZG7
CAG6vs/TK/KcwfaCP/00r9pv+5GEFGsvp94XEtZ3XlShg115xM0HYAFWWVSuumkO
aXfaZeMIADxHXbLkzFRF16iINCjY3lPEsPKtGzufPrM9JuzaxZW6qvC+1ZLIpbzL
K9z298UJ7m0nTDBH9PRjXl6wX3WslvC6tc2Y8aoFZWvhJut9kqQFl+SYTtyYzwBh
oVQ7FDmeCQxEsc3E8sBM0PJOZm0seVHLKZj1xifJN0VHrn6ZKwbXfM2Jv+bh4SFd
2YEMZg9fKU9+3FVv58Ol5fCdudeoe6cdk+4kKmcJDBZHyILxpozYO7QcEQ5fcYo7
kS5R7TRtp/pCoxKkdlIs6Xy2YTt/abh2WXz0VIhPkqv4CWzqll4u8u33mtpdzx18
d5hcJhEKn5USMpxsahMoIs3XVk/9Ts2VO3E16hvkgOh83JtljBfhYtXOL2giuSik
v6Nq+EQjh0jIk2douPfdjeocnTORAqp4UMK6oxOWp3dlOWHr3fEoIF/TjEIgbjle
dPqhITXiLYLLLD2bSWBEpRjU25QrpAXQwBnrM0WEsgmODkOcwttOgf/+YqQR+IwQ
VHhgILo/4frGc9Dftdf4OAfuNA6mpYIBmbdF0pTcEKUZENdDNmo=
=6cz7
-----END PGP SIGNATURE-----

--Qz2CZ664xQdCRdPu--
