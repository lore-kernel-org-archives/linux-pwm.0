From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: Delete an unnecessary check before the function
 call "of_node_put"
Date: Tue, 3 Feb 2015 12:57:58 +0100
Message-ID: <20150203115755.GA15068@ulmo.nvidia.com>
References: <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <54D0A9D5.6020603@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:57533 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933165AbbBCL6E (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 3 Feb 2015 06:58:04 -0500
Content-Disposition: inline
In-Reply-To: <54D0A9D5.6020603@users.sourceforge.net>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-pwm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 03, 2015 at 11:58:29AM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 3 Feb 2015 11:54:28 +0100
>=20
> The of_node_put() function tests whether its argument is NULL and then
> returns immediately. Thus the test around the call is not needed.
>=20
> This issue was detected by using the Coccinelle software.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/pwm/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 966497d..810aef3 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -192,7 +192,7 @@ static void of_pwmchip_add(struct pwm_chip *chip)
> =20
>  static void of_pwmchip_remove(struct pwm_chip *chip)
>  {
> -	if (chip->dev && chip->dev->of_node)
> +	if (chip->dev)
>  		of_node_put(chip->dev->of_node);
>  }
> =20

Applied, thanks.

Thierry

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJU0LfDAAoJEN0jrNd/PrOhBKUP/1zkoxJdp0qzKoRanEiShjt4
kinIiezyyi4EjFntWqB+6KuJ8T1s2k8l86+vslZhcWaGD4e2xuZXXJjerlSfS+H1
OMJAv6hvtA9KKT6OTf/psyMyvtyJwrSRjV2GpfW4ta9XqzMrCHGtI1wAD3wU6t2h
B7Bv340LSr3HGqbArdQKui+1mEkxZWpFtUqKUQlSG9MLiulbP5/7L6ubWXsr3Rm0
bdjL8aUa6myqcPlzvi+X2oOcpUPr30n3i96DNzw+3SiYKpfhylPZEfiEzGGbFzP/
h2UksA/7jeNRtCp5UsYWN+fTy/FXYyqYY1wRGlQ29mTqzvhSKqREtMRjeFzJeCO0
xvDZdo1/YjM27XqxKVlMc4T2fNPQfGmBMVKOqzE1OjqYnzyhnwbsQgPlBXmHrwQl
6hNCk8JYIk3qk9H91pqkmY7ZFRDyyxmocUZF6iDVWSseXXXQWNEfYN6z9noXwoLx
gu0S8tnQ9iwvdVCTT17r+w8PExM1TesWo9M1XIYn982EGCAd8JsEKRMPhK+9LLft
EaJAVug+aRxvLQgZMV1TXhgDAY6j3hZosjnabAxGA5Ek9/TY3qozJMIipBNofK4w
exJFsHCxRNmkBbQ/ez1wa30NAi0nbeNjoG3mZBmHx0KTJo7+bQF49kRVUjR+RDOl
nVmen/kljy7Q7flTNiil
=9Sqx
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
