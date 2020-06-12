From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] dt-bindings: Remove redundant 'maxItems'
Date: Fri, 12 Jun 2020 08:47:19 +0200
Message-ID: <20200612064719.GA2295929@ulmo>
References: <20200611194738.1480393-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200611194738.1480393-1-robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Boyd <sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2020 at 01:47:38PM -0600, Rob Herring wrote:
> There's no need to specify 'maxItems' with the same value as the number
> of entries in 'items'. A meta-schema update will catch future cases.
>=20
> Cc: Stephen Boyd <sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>
> Cc: linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/clock/imx6q-clock.yaml     | 1 -
>  Documentation/devicetree/bindings/clock/imx6sl-clock.yaml    | 1 -
>  Documentation/devicetree/bindings/clock/imx6sll-clock.yaml   | 1 -
>  Documentation/devicetree/bindings/clock/imx6sx-clock.yaml    | 1 -
>  Documentation/devicetree/bindings/clock/imx6ul-clock.yaml    | 1 -
>  Documentation/devicetree/bindings/pwm/imx-pwm.yaml           | 2 --
>  Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml | 2 --
>  7 files changed, 9 deletions(-)

Acked-by: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7jJPQACgkQ3SOs138+
s6HL2g//ZoscfSZkpDxD3dW2jxtxiLW+++f387MavWHS9QM8PYT+3MexQxkUWyjo
MAxhB4FCLFjHaMCl2sD1vH/FkkfIMPzdV8TEtEGlIm+YO/pDci2EYfHOUHsmZe/A
Dnn+e7XBzuJ2P9DwUaqszRXB1oO6zb32T9tklAN3qeF/W8Z44kNWE1C5AzlM7Ivw
q1AoGUYx47iq0Wcqwq/DYATIc1BxT8OGl+rEUGnXXWbLS+NYVT4wi7ML6heNqdBl
+2KbtWFzbdF3DyA1/b+3XVCGHGrGAnsLMjcNqJiLNnnbIS3v9I+HvzCGNGDDQiM1
Ld8CfrsPzbKqMWYXhAcFTDtf7oyHrjPt/t1FiTok6i7yQNZ2waHpPF1GKbQ5SXe2
ITA1XWnSaLJEIqXZMllgQ6cZtxIJmb9rjmbGtzq+YjjNTBWn2Us8K4hDGdx65ILl
vL8fZd6DPHTyJF3CwK+D7ObJBWqjaZjNf+ViQRGzXTIsRufnA9xR3hNDMeAETJKX
TGxOheAe1S9O0Rma6V0G1g0nbqX8V45/z1Tpd5L3rp9/ZRrg2RK+70+hBtbR2Jc4
vLdDpb/4lyskRTU+DKgNtReVD2DP9okNErL5eGTXO81URug5Kr1mZB5+RqKjelnI
mV/2sKfFnSX33cg3hbP/sDwDxMB+sjjGP+K1JXWxVj9Ez6osPPU=
=WSuJ
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
