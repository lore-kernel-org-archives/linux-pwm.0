Date: Wed, 26 Jun 2013 23:33:12 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: pca9685: Fix wrong argument to set MODE1_SLEEP bit
Message-ID: <20130626213312.GA29479@manwe>
References: <1371662847.5355.2.camel@phoenix>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <1371662847.5355.2.camel@phoenix>
List-ID: <linux-pwm.vger.kernel.org>
To: Axel Lin <axel.lin@ingics.com>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>, linux-pwm@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2013 at 01:27:27AM +0800, Axel Lin wrote:
> Current code actually does not set MODE1_SLEEP bit because the new value =
for
> bitmask (0x1) is wrong. To set MODE1_SLEEP bit, we should pass MODE1_SLEEP
> as the new value for bitmask.
>=20
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> Hi Steffen,
> I don't have this hardware, can you test if this patch works?
> Thanks,
> Axel
>=20
>  drivers/pwm/pwm-pca9685.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRy14YAAoJEN0jrNd/PrOhHFsP/2sCzBTw5DUeNFjk+qS42K3F
HyDRflNr3hFB6wF8ThmF3xJjZUyxHXW/ae0r9jcJvPsHeI+IbViuoiphS85BZ0bB
Xhzh7DTvluKEkXpy3tkj7DN9zFaPhQhkmnEi+hh9m65mHo4/tXrvrC5DhSvJylNw
JQOSCS4Fex9L0LdGaK0bq47QJKL2h5j/2t/mG2SyQ+Zbt/DyOTrhuecxOG5PN+W/
UWbxbLu+jSGoRHJ39RBpqYvh5CdKRME5TTVI35cJCZL79XvsqAkqT66+Q0Ln3qZR
LgK0ylhWzAFWHVF0D+fsjxVNhE0b5NV3V0aGHzEmkn5fLhPwM2FmCJUV0fgOchft
iW9jCsbkzrbqWhTTtqPyYosRv0I/msD70INCP7Vn5M6z8h38y7YKGPdownbedb5z
4233n+JcIsL0K70xX/xHREOVAIzHg4q4jmGuE0K+JpuDvjTuhaSlRNSkhzSbxT5P
z8PM1kDCDPAay+hDp6UdXMhWtfVL4bNy6fE+y8kQ/w0Jep4rI+oPs4uMclMuq05/
JznufONOd1St4Bi6ezGxy+JACbc2S2umnAlGxdlvN5JfieTB3md6GwHuQ5Xg/Gfz
TI8gMMZtjaFaxIKUjC5QnKjN+z1SDRdL6pYKeNRLlOZHEwuI8f/45RT4FWXCn5y2
NEoPk/XsMNtvMrb/nb8V
=NvWq
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
