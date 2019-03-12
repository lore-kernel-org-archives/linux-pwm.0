Return-path: <kernel-bounces@pengutronix.de>
Date: Tue, 12 Mar 2019 12:39:44 +0100
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20190312113944.GI31026@ulmo>
References: <20190312094249.27806-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pe+tqlI1iYzVj1X/"
Content-Disposition: inline
In-Reply-To: <20190312094249.27806-1-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] pwm: poke users of legacy drivers with a warning
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


--pe+tqlI1iYzVj1X/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2019 at 10:42:49AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> As it is hard to convert a given driver from the legacy functions
> (.enable, .disable, .config) to the atomic stuff (.apply) without
> testing make users aware that there is something to do with a warning to
> eventually get rid of the legacy drivers.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/core.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

I don't think that's a good idea. What are regular users supposed to do
when they see this warning?

Thierry

--pe+tqlI1iYzVj1X/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyHmoAACgkQ3SOs138+
s6E6QA//eTsMWVbXmEz6iLfi49fT2d0Hl/2ui6HujS3aAlZQIqnipPNsOOsA2PSa
ylIXNBNI25iQeecskBW/6SGsHZnk+se+EoSNjNJPmZLAwXv9Y+8AFXlQeYKT69Z2
FPNGWPwuBN8t5dbGWMkSixpH1vkIeX5ZDrSsSnuXNK46CrngylqTxuFfp2jWUD1b
R4/Y/EaG6Ivw1ZwvdVKvq5LIDxGNkEPTRAs1aexJrNfE8cy8OznE5PanQToBv9lh
1/KVjFFTMOeVokYki0yT9GZun/k5XiMqduVlIp6MKrPqdnRXWJiNRw1rz0Hqeku/
W/boUlxqwxzCQHFkw7XRCmnMRFNeSr4FAhCVogXLR5wHvqIXdTfXvvYkwwC4pmtD
jInReOT1jZ4gAJuept1kmX9HLdpaEPsGa/6ResD9WnIJDVMwiKVOw2CKf90J2f/Z
LACyJAYm5P4NkbdGbJJELHpsi5B9Vf6+NOVrfBkmWdjnuBAvSaUTE1/O3+7nt3Y1
rhTK0W272eUD9o80SbsBthE8/C/fR4lRmCDQLnaJjSHsZ2MfOZb1L9ew5jgmlUlf
OXAFJMrKSFkjlhsesCeJzVUrTD442b8k475YDAY2x40EPVKtNbcAF/yCWUshnbdk
Ojx3L3F7Suqgf2jBo19uVIdPD3LKZLYkJ+V2isSSIYxnTZmfQNI=
=JMVD
-----END PGP SIGNATURE-----

--pe+tqlI1iYzVj1X/--
