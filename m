From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v7 1/2] pwm: Add device tree binding document for R-Car
 PWM Timer
Date: Mon, 5 Oct 2015 16:42:13 +0200
Message-ID: <20151005144213.GC27759@ulmo>
References: <1443602873-4316-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1443602873-4316-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XMCwj5IQnwKtuyBG"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1443602873-4316-2-git-send-email-yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--XMCwj5IQnwKtuyBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2015 at 05:47:52PM +0900, Yoshihiro Shimoda wrote:
> Add binding document for Renesas PWM Timer on R-Car SoCs.
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> Acked-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
> Reviewed-by: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
> ---
>  .../devicetree/bindings/pwm/renesas,pwm-rcar.txt   | 27 ++++++++++++++++=
++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/renesas,pwm-rca=
r.txt

Applied, thanks.

Thierry

--XMCwj5IQnwKtuyBG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWEoxCAAoJEN0jrNd/PrOhiFcQAIUV92snHh/05oXVCGap1Bn1
VgXgyyC+wIWXvgZTBMjG7pkkM67OLB7w0aME6S1CABptYXPx9FiNzeah3f/LVG6J
WOB2dCs+2uopZDZ9OCHPg8AdfP2/UKSodGvPkFa/3542PcKQf+N7bPkRoq23vc+V
146b2nsP9GDh5BxLw9h14LxRRAtBWfMYm2FUgX0wHO/EfTGO+BiEjWnOlgUB1Qmz
bUNOc5s/evRi3r9VsV1CmjLTOTA+s1ZB83ioZ7lUe7sZ3aWFTaBTGCTgN5gn8C/1
d6o+6u11/d4MBU7qrBeSvg1Si2ItmrodslXMwOsXhSncjIV01/B6X62dW0LIRU0J
XjhEvvyAJEvTHJuWJNfu3XU4vRcawqgKS2g3UJ47AlqJqZ0YJgRSx7a3lxcfCeu6
7Ymol3s+YxwqWsxgM4+ThuRRF6GDvE7/y8eFZPSzsUy/NwtQTBv4oFUFU13oo+6k
rUtP4BwvCk90w2rfBe39uRoMulqoPDvyLx9/JU5V27+Jo2iKbLs1HX3IBs6Wi3oG
wkjY3qDMayfigd69+BNIgY+JiEdwjPXHAXNGBQxWNJTq2cjHSlUOvgHwrRGVI+vx
9uqq4MhVXO61Yn3ScoUPZ/p3NwcCtob0VjWqso3SMOSr/k5QFJ/g5KolKn+M1dAU
XdGWepFDjOcszur7vBfb
=jMuN
-----END PGP SIGNATURE-----

--XMCwj5IQnwKtuyBG--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
