From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/2] pwm: pwm-mxs: Use 'dev' instead of dereferencing it
 repeatedly
Date: Tue, 24 Sep 2019 12:53:53 +0200
Message-ID: <20190924105353.GE14924@ulmo>
References: <1569318169-12327-1-git-send-email-Anson.Huang@nxp.com>
 <1569318169-12327-2-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="47eKBCiAZYFK5l32"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1569318169-12327-2-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <Anson.Huang@nxp.com>
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Linux-imx@nxp.com
List-Id: linux-pwm@vger.kernel.org


--47eKBCiAZYFK5l32
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2019 at 05:42:49PM +0800, Anson Huang wrote:
> Add helper variable dev =3D &pdev->dev to simply the code.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/pwm/pwm-mxs.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

Again, lots of churn, no gain.

Thierry

--47eKBCiAZYFK5l32
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2J9cEACgkQ3SOs138+
s6HR/A/9EUNTBnpBHITA0Kq/pZ+Bcn6+e4ivi2Lm7ml4+7UKBAFfUBkk8NR8ojWK
lg6nL1r2WlJBAzDa4uP+f5zrXZzoNIelQel6ORgDtziZbGEFeKGtb37ng+C+pKWD
AvSfhBnikiAYWHAZ4J8soZTeyQvN4obwpWDGpBYxI5OlO5oVep49N0r+4qF8DDeV
kbcFZ/5lL0KIOi//ykRD373y2f4N4mnhExY/0fKbDLe14fUGfGUf74XVn0kqwKKT
FlVLWYQU7J4pSyDMElfHZqeaEcHa7qva+gokf608yXhv7OREseYi8zXeZw7xq0Z7
35PDelZGh9tPepS2WJGjqQxZufouuBkkB6ULGaHFWEAl3C8HRC9phgw9Ws7zXGYQ
1HLKNAwNC53oovl5V942aunlWAYWLAvqCRugb2nGN4kCuiEEsyrc2w/hI836UdFt
XIHbpyR/nvVkZ/SVilLP4ZsWuuAnjhxQdPJixp+MPOl++MkjO/enrSglr90kClYv
shw78UZdLUnJ5eJ/q3kSwCmEn6pBSXLAxzbPyVu1nbB7jivmSO/vleoqNKu2eqOr
odUFJB0wcmg7jAsM8S7ZNFEiQEJr6gfO3oOcuIfIrBdZAnMxoQ7/cEeGsKWsxpFm
6tHrJvdNFw8r//AKR0l6lIY4tYFNCLP8a7sHdMUmDV0Pg1QEDgI=
=UomL
-----END PGP SIGNATURE-----

--47eKBCiAZYFK5l32--
