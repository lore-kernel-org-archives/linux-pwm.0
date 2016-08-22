From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 1/1] pwm: sun4i: fix a possible NULL dereference
Date: Mon, 22 Aug 2016 08:57:37 +0200
Message-ID: <20160822065737.GA7104@lukather>
References: <1471353486-11514-1-git-send-email-clabbe.montjoie@gmail.com>
 <1471353486-11514-2-git-send-email-clabbe.montjoie@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1471353486-11514-2-git-send-email-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LABBE Corentin <clabbe.montjoie@gmail.com>
Cc: thierry.reding@gmail.com, wens@csie.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 16, 2016 at 03:18:06PM +0200, LABBE Corentin wrote:
> of_match_device could return NULL, and so cause a NULL pointer
> dereference later.
>=20
> For fixing this problem, we use of_device_get_match_data(), this will
> simplify the code a little by using a standard function for
> getting the match data.
>=20
> Reported-by: coverity (CID 1324139)
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> ---
>  drivers/pwm/pwm-sun4i.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 03a99a5..72f0060 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -309,9 +309,6 @@ static int sun4i_pwm_probe(struct platform_device *pd=
ev)
>  	struct resource *res;
>  	u32 val;
>  	int i, ret;
> -	const struct of_device_id *match;
> -
> -	match =3D of_match_device(sun4i_pwm_dt_ids, &pdev->dev);
> =20
>  	pwm =3D devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
>  	if (!pwm)
> @@ -326,7 +323,7 @@ static int sun4i_pwm_probe(struct platform_device *pd=
ev)
>  	if (IS_ERR(pwm->clk))
>  		return PTR_ERR(pwm->clk);
> =20
> -	pwm->data =3D match->data;
> +	pwm->data =3D of_device_get_match_data(&pdev->dev);

How does that fix anything?

If of_match_data fails, it will return NULL, and the NULL pointer
dereference will occur in the exact same cases.

You should just check for match to be NULL, and return in this case.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXuqJhAAoJEBx+YmzsjxAgulQQAK81Ncorqc9fW6HE+/fdwnfk
SjCTTEaYUUVmXhFo+GsVlrPyh8tPIJowITaQaNEAcciHjOkx9bwL2yZlX7R6Kj4B
ttaqAGL7+pnFVRrlNMf7TLlffOe4fLD+rjbnVLd4vaxLMkKRuL33eFsbf/jSwdcR
ftEF4zkWT8YEkewZNBevnVd5EfyzyR4SMcXmeRulAuT92cOZM1jYV/Hfb/XkD1ZB
NiWTVaZXJKcvKW4uko27knUKR11y5Av0uDbXyLwYGuUccM1wQv+DFKQY1vAdu8bU
ScT8n9pUbZRc55IN91imbMScHvRpndnHNZEhWthlugkHMecy8wNKUn2obm5B6JTM
XDm5uNbW9nfYVlEDVvLEU82I3hTijy1FMUF10rwBwF7vuaS/tr9EfZRhWwYWPZLu
UG2AKfYBUrD1/t3JWsJi+R5nCGC+Q28TQszG/O9yF1QT2SLZzDe+V7vl5A3DiEDb
GRSZDmnYH5V5hS1k3WoQuXGjgunrEBEIXijjVpWyofj0vLoxfV2NP03M84w75Kx2
HWPygAU5upwTXT6qXl1GUAUp8BUxoOKrrfNVzG6Vt4GWrd13i59mJayaL2Sr5p8y
xB3fM3cQhsredc1/J694BpFMKrR2lraHQg+0v5TQPV94Z4bQHhYzv8PJw44tyNr2
6peUaKaZClaDb+hdbp5T
=e0MZ
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
