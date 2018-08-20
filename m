From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: stm32-lp: Remove useless loop in
 stm32_pwm_lp_remove()
Date: Mon, 20 Aug 2018 11:31:06 +0200
Message-ID: <20180820093106.GB8242@ulmo>
References: <1532070992-16831-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1532070992-16831-1-git-send-email-fabrice.gasnier@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: alexandre.torgue@st.com, mcoquelin.stm32@gmail.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 20, 2018 at 09:16:32AM +0200, Fabrice Gasnier wrote:
> LPTimer has only one pwm channel (npwm =3D 1). Remove useless for loop
> in remove routine.
>=20
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  drivers/pwm/pwm-stm32-lp.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied, thanks.

Thierry

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlt6iloACgkQ3SOs138+
s6GaqQ//aqTgISn0zsi04ptSNxWztxp5lpMjQYEt1wmsK/uSTWDFT0XWB5wLk6Mw
uAsXVkboX8mqMqsLZNYWpnPlAVjLL2Yg3T7rTHwlIS6EdFkWmNEODX4ueh+oE8SE
c2ks5BXgEdOiuwihF+Wj0LpLcaerexZ7TjXgfC2C+a7JMOHwdRoh4VcxD9ecJYqr
0QdzZTWn+WOkQpEYyX16X/lC7iT/wFJ9VrA8sf8JT3VWGyQSGv1k3il50iWOlxX+
NU6TlLR6vm15Hu3KtWEvZaDZ0wJgQaLJN2pm2yaB2xAzF/f6wedrX9F/wBvXm6mp
4Q2JK/4Mb5whm4Dd/hiNJc6l0zZ3BwJGUN3zuWk/77QcZXUerQmow8daHw3DHZs4
hK/OTXQXAQqfkk3nuZCnwcUCBxoq1e5QGX3HYOrsYu311maH8WYygoWbSSR1GrsP
QE0j1GoBBx07S+BEvQ437MtJVsAQlnWpw4BtRDVqBzeZrnaVN+Lo+8pBRZrMjGeH
gOkiPhDQlG1+hy4C9Zhu258cR6bQtou/PGIhnk1tkB+uldfzdkl8cMFBHt6CjSK5
lzc6YgmLXOkqGilbLebzKdhCC2x0DDmo/odKZeOr9raY2Jw+vSzN5RzGRyiTAI6T
eugMAbwH2t1LKPDSbG5l9SQs5CIt4YBumvEPN4kmh6GDdBakqXM=
=uyVX
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
