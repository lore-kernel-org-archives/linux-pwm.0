From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: lp3943: Fix potential memory leak during request
Date: Fri, 24 Jan 2014 17:23:04 +0100
Message-ID: <20140124162302.GA28335@ulmo.nvidia.com>
References: <20140123223220.7d68b5f6@spike>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bk0-f41.google.com ([209.85.214.41]:60538 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479AbaAXQXM (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 24 Jan 2014 11:23:12 -0500
Received: by mail-bk0-f41.google.com with SMTP id na10so1287422bkb.28
        for <linux-pwm@vger.kernel.org>; Fri, 24 Jan 2014 08:23:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20140123223220.7d68b5f6@spike>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Christian Engelmayer <cengelma@gmx.at>, Milo Kim <milo.kim@ti.com>, linux-pwm@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2014 at 10:32:20PM +0100, Christian Engelmayer wrote:
> Fix a memory leak in the lp3943_pwm_request_map() error handling path.
> Make sure already allocated pwm map memory is freed correctly.
> Detected by Coverity: CID 1162829.
>=20
> Signed-off-by: Christian Engelmayer <cengelma@gmx.at>
> ---
>  drivers/pwm/pwm-lp3943.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-lp3943.c b/drivers/pwm/pwm-lp3943.c
> index 8a843a0..a40b9c3 100644
> --- a/drivers/pwm/pwm-lp3943.c
> +++ b/drivers/pwm/pwm-lp3943.c
> @@ -52,8 +52,10 @@ lp3943_pwm_request_map(struct lp3943_pwm *lp3943_pwm, =
int hwpwm)
>  		offset =3D pwm_map->output[i];
> =20
>  		/* Return an error if the pin is already assigned */
> -		if (test_and_set_bit(offset, &lp3943->pin_used))
> +		if (test_and_set_bit(offset, &lp3943->pin_used)) {
> +			kfree(pwm_map);
>  			return ERR_PTR(-EBUSY);
> +		}
>  	}
> =20
>  	return pwm_map;
> --=20
> 1.8.3.2

Lee, since you took this driver via the MFD tree, would you mind picking
up this fix as well?

In case you don't have it in your inbox somewhere, you should be able to
grab it from here:

	http://patchwork.ozlabs.org/patch/313741/

In that case:

Acked-by: Thierry Reding <thierry.reding@gmail.com>

Thierry

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS4pNmAAoJEN0jrNd/PrOhVgcP/i8zIbwJcEDfI2j15mhjBjeP
Pjo89hj96x3XWAYFUqsJVOo1IyBkXh1cZmhHLdGwGb8c3OFows6s0oHsgKP+hjQM
bwQe3yFlY2uxWQm3MJbzO85vjS/v5lRBFdAUTouqgSt8BXVS+ALr7N4a7fKStWcu
+LRfxv8GFwEGLUYEvhfIUR3hBv28oLW6rGxVhC7M5/3U/tNq7ZM98fVwGjOEkDla
BuLN465CyAx9Db/XugHI7BSU3zn3xrQNJ02R6M6cT4qFGas5LQzqNcU8NLuh+Ebv
3KePg0J2iW7NDDZ1L8hyw/KSAZKW7gs+MyaOIgv4uqWi0cEQprGfIvU2vwhSHXFZ
BmOPIotuGXouze6nmSsUoE9mR5cbLiIqhvd3NVuH6gw9ay5trPdOxAoaob6LOXnH
QOscbGwYC76y27kThg0nmulB4N2Jqt8ZvCRbCHG0NB1Ufgc3vAYJ012c0fIDem52
lbG9QSHHlntL1O8g2wdwzxyhiv4Sco9uBBoR0ZDD6MWXu87TDguafkerKtQ/nt3w
6UVCPlJB0KjgnBaYObLk3uZ8XbefQ7qkrOWgJ1l+uNmB3bNUZxXAQBGzeYHqYRgJ
y+ILqDjG1hdNJg5DfSIwNOLthM6CWDF9N5rL4QFXNqXv/u4E/CfCldWxCkcDAK4D
WlfcApl4fccviAuthlGo
=FY2Q
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
