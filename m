Return-path: <kernel-bounces@pengutronix.de>
Date: Thu, 9 May 2019 17:21:22 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20190509152122.GE8907@ulmo>
References: <20190325094934.10221-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="684cmtc/Pyvt2LSS"
Content-Disposition: inline
In-Reply-To: <20190325094934.10221-1-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/2] pwm: clear chip_data in pwm_put
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
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>


--684cmtc/Pyvt2LSS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2019 at 10:49:33AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> After a PWM is disposed by its user the per chip data becomes invalid.
> Clear the data in common code instead of the device drivers to get
> consistent behaviour. Before this patch only three of nine drivers cleaned
> up here.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/core.c        | 1 +
>  drivers/pwm/pwm-berlin.c  | 1 -
>  drivers/pwm/pwm-pca9685.c | 1 -
>  drivers/pwm/pwm-samsung.c | 1 -
>  4 files changed, 1 insertion(+), 3 deletions(-)

Applied, thanks.

Thierry

--684cmtc/Pyvt2LSS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzURXAACgkQ3SOs138+
s6FeXg//dKvz4PGcniJXYV9iyqHiu7X2qROj/XhXXbai1jZ9B0/z2RnJHThhTkxo
Uq+Lg6i1KuqwSeQrxpPXffncOVUtIrJ+48kOSIaPumlhL7gYcZOJ5mkrVGhBsNa4
LZ6RLSXK9MWOX+n/lPB4bYEW3vOe5kw/Vsr1c4gMtmj4XNUmNQ2539ohw/1iD0OM
JbuqzoQWogP3Op7Sy4dh0o5T3RvoOc5ZPo3vJ5D/sgzjwoaIU6CFRj2Xb6LVB0N0
dpvGsdjBLMqaNK2qfrs6aJ7qMnOuZokRPUM0yXchNr5eMSBNc2Wh5l6FAyPC12H8
J/SZgkVwVk+BUiWEg9Rlj/Ar8pSQPgcJ7g820WECzxlNQ+7gdjKQj/tp0WH8wKIJ
IFY9sZUNGnpvVtSLSFh8uC3EyedYki+NYrezeuyOiMJ3cp4fQ0x6LMKwa9xD+gcM
CeWTaH8imp9ZHlW2BTk2FpRH63mdg6J8mMT6U6D0fPpvrECo30hH2YRY07rqenjR
ydMxCZyrkU3pyN3qR+ShuQLk+67MtAooMFcwLVyxr7ROQTxUICrAvaHRZ1eB6VyW
JdmS9fZ8iGHoyY1fDLDVyKLBXq36UNwKX6Ksi7nWCIWZj4ZGN8oJypbL6KsRAl+5
BA/e6rnxc1E2t4Esx8RXsgBwnQEpvoC+ysm7ASivj4kJ6yfV2ME=
=g6Eo
-----END PGP SIGNATURE-----

--684cmtc/Pyvt2LSS--
