From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 2/7] dt-bindings: pwm: document the PWM polarity flag
Date: Tue, 17 Mar 2020 18:43:44 +0100
Message-ID: <20200317174344.GB1464607@ulmo>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-3-oleksandr.suvorov@toradex.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200317123231.2843297-3-oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oleksandr Suvorov <oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Barker <pbarker-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Marcel Ziswiler <marcel.ziswiler-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, Igor Opaniuk <igor.opaniuk-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, Philippe Schenker <philippe.schenker-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2020 at 02:32:26PM +0200, Oleksandr Suvorov wrote:
> Add the description of PWM_POLARITY_NORMAL flag.
>=20
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
> ---
>=20
>  Documentation/devicetree/bindings/pwm/pwm.txt | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Documentatio=
n/devicetree/bindings/pwm/pwm.txt
> index 084886bd721e..440c6b9a6a4e 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm.txt
> @@ -46,6 +46,7 @@ period in nanoseconds.
>  Optionally, the pwm-specifier can encode a number of flags (defined in
>  <dt-bindings/pwm/pwm.h>) in a third cell:
>  - PWM_POLARITY_INVERTED: invert the PWM signal polarity
> +- PWM_POLARITY_NORMAL: don't invert the PWM signal polarity

This doesn't make sense. PWM_POLARITY_NORMAL is not part of the DT ABI.
The third cell of the specifier is a bitmask of flags.

PWM_POLARITY_NORMAL is an enumeration value that evaluates to 0, so it
makes absolutely no sense as a flag. PWM signals are considered to be
"normal" by default, so no flag is necessary to specify that.

Thierry

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5xDFAACgkQ3SOs138+
s6Hc2BAAoZZlHyfYsr0Ak2f2q9OT3sqed38ZxCtTlrr7nV0EMRX9lArVOG/WYqZU
j6UFpsHK5VeEVd7g0+AmwlGNMuCSkh8Fago7cFqKwIWgrYlk0P4MAOdrt1CLf5ky
KO2B+YLCLiV3Jc9TYFridWcCAR1XCU9xkvVVBs2DM6j7FqSG3zLXe1OklBM1mnTL
ha6UdP8Nr46AodyfFh9H+1xEzNf+BGnycoN+c3k0AfI2QEvntJywgb+v+V6ELIUd
nf22MsydZCIRYbrl74154RESKQ8wPtDtz/XaXAiGxJAd76K5+PBFNIEY8TJHXdQm
uEQVC7g3OUNANYaTdDLtn8EmmK41UqZOK9T8Hc9zr14zh1asoPkALoPQv/6aY7At
19uamsnrxupfTmneh7K064G7InxbeecxPo9H20aS2QVYNegA5ZvCYLjcjASOfesj
AGxze1cMvK38uD0Ujq8n7hLerMBGZ4IBH4S9Kt68iCbClF5XwWZQy5yhVywqtEs+
1D2HpCWtcImoEnBywcAiA8eE8Bp6ByZkz0PscumS03TOiy1xI/IRbqCaUMnNkYC2
cKnkghSEsn+Ilg9rzXNS9gvNVj4v3e+2GBFaF7rHUBs8+TOzn1dcB5iubq+55RLW
Y8uyGklJGKA8NyVXF+0u4At8XhYGzCR1296yga0NPv3GzHEyqlo=
=+U+H
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
