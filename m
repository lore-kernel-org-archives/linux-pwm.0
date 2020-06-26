From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] dt-bindings: Remove redundant 'maxItems'
Date: Fri, 26 Jun 2020 18:23:35 +0200
Message-ID: <20200626162335.ddfc23czvknblmqx@pengutronix.de>
References: <20200611194738.1480393-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gcokhkvcs44oti6s"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200611194738.1480393-1-robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Boyd <sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--gcokhkvcs44oti6s
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2020 at 01:47:38PM -0600, Rob Herring wrote:
> There's no need to specify 'maxItems' with the same value as the number
> of entries in 'items'. A meta-schema update will catch future cases.

Sounds reasonable,

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--gcokhkvcs44oti6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl72IQQACgkQwfwUeK3K
7AkkTAf+P/Ix8I1Qk1/xQYx03skU0vfyzMw0MExu5t68JfypxlbIJ5xAmxuc6iUC
85scAvE5q44rK35snt5WmCMjWf5F/afqu/ZOAY4XTp/M3Eb2S0vt9eMJ77myyRrQ
re3PzISpIlToIUpR1370R5KoQoSDcmKrUHE7vo8Op72CilADbLlitOOp0DVNl+kU
3q32VL9eUCLbSHTv528iAbzVr/OYNn1Hmq6jHVZBN3Y/kSY2ayep1jguHHtjv7Mi
WcnKEkNgtQMJTcNQuhIqmfXLjjlN3kBy8taEKkuGsobWq1E2yFQUiBboD1poMXXe
WlcAYJ4803KbT1JSUf/h1JAXT8Qbmw==
=laHj
-----END PGP SIGNATURE-----

--gcokhkvcs44oti6s--
