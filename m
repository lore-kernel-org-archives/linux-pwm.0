From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: sun4i: fix a possible NULL dereference
Date: Thu, 12 Nov 2015 13:38:28 +0100
Message-ID: <20151112123828.GB31671@ulmo>
References: <1447314132-29458-1-git-send-email-clabbe.montjoie@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38839 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680AbbKLMib (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Nov 2015 07:38:31 -0500
Content-Disposition: inline
In-Reply-To: <1447314132-29458-1-git-send-email-clabbe.montjoie@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: LABBE Corentin <clabbe.montjoie@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, maxime.ripard@free-electrons.com, wens@csie.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2015 at 08:42:12AM +0100, LABBE Corentin wrote:
> of_match_device could return NULL, and so cause a NULL pointer
> dereference later.
>=20
> Reported-by: coverity (CID 1324139)
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> ---
>  drivers/pwm/pwm-sun4i.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index cd9dde5..3011fcc 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -291,6 +291,8 @@ static int sun4i_pwm_probe(struct platform_device *pd=
ev)
>  	const struct of_device_id *match;
> =20
>  	match =3D of_match_device(sun4i_pwm_dt_ids, &pdev->dev);
> +	if (!match)
> +		return -ENODEV;

I explained this in a reply to another similar patch, but that was a
different audience, so here goes again: the driver core will use the
same device ID table to match on the driver, so the case where NULL
would be returned is the same case in which sun4i_pwm_probe() would
never have been called in the first place.

Thierry

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWRIhEAAoJEN0jrNd/PrOhVE0QAKp699mR8PO35skAsoEcKUjh
ZywX5DYeW6BEG3mwzM7afd83iDHP5yXYKjwLGPMjsGMt63D8EK2hqxoboZSqrfLe
bzmdRjEgltMyGNjAC7C/M6aBFUFhd+vyukYCTR+icL+KOdeJv28bh2T8rGYpRNm1
dXFZjiuTQxzybhGsMaFjNWaNNBxFbshZiSUaDDKUsR0dQ9l6MzjfcXpmwJr4HtKO
GlGCWop8OShizDBNMTMqgsZBE3KJ1h8mfiqkv9ZbAefsKsT9RWXNI7GDgIukzTl/
gkxTfieenkXiztDndvwg4Gb6S1pAeLstGIIQKsR3VW+EPwSlGHR5kX9oL3sQtkQj
edv/v0HQWb7NiwZ907JOEqhizFI/cVMCsivqByvRNgoMrBsG/TWUwSL0DVU0Keg2
rQLTX6ddDJ8qeRUfk939XRy1lZvcuUJZw7VJe9+l6bLHEhmdUkIy2v5kO/UvCpUt
7TgSzXLGKyu8oZp6pd/TuFe4SdqnzmqLpF07OdsUrlybhB/xVPQ1a7KwocO0qXeq
GqS5Mbt4dvA+nSY+AjN1w8aQY7Cei7cYodx/er7hzpERwavpPhTmQBlHO6otBSij
75s0KmmiPQrmFggVptVOCr8VhADEiopcfGBIs9SQvoinQw4sHtTVSJE3LA9ju7Lq
L0lOYHYHXevec1qVFiNV
=KVT4
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
