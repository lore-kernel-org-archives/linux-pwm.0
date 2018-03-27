From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: rcar: fix a condition to prevent mismatch value
 setting to duty
Date: Wed, 28 Mar 2018 01:21:08 +0200
Message-ID: <20180327232107.GD4097@mithrandir>
References: <1520594661-6897-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="48TaNjbzBVislYPb"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1520594661-6897-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: stable-owner@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: ryo.kodama.vz@renesas.com, linux-pwm@vger.kernel.org, stable@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--48TaNjbzBVislYPb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 09, 2018 at 08:24:21PM +0900, Yoshihiro Shimoda wrote:
> From: Ryo Kodama <ryo.kodama.vz@renesas.com>
>=20
> This patch fixes an issue that is possible to set mismatch value
> to duty for R-Car PWM if we input the following commands:
>=20
>  # cd /sys/class/pwm/<pwmchip>/
>  # echo 0 > export
>  # cd pwm0
>  # echo 30 > period
>  # echo 30 > duty_cycle
>  # echo 0 > duty_cycle
>  # cat duty_cycle
>  0
>  # echo 1 > enable
>  --> Then, the actual duty_cycle is 30, not 0.
>=20
> So, this patch adds a condition into rcar_pwm_config() to fix
> this issue.
>=20
> Signed-off-by: Ryo Kodama <ryo.kodama.vz@renesas.com>
> [shimoda: revise the commit log and add Fixes and Cc tags]
> Fixes: ed6c1476bf7f ("pwm: Add support for R-Car PWM Timer")
> Cc: Cc: <stable@vger.kernel.org> # v4.4+
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pwm/pwm-rcar.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry

--48TaNjbzBVislYPb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlq60eMACgkQ3SOs138+
s6EoBw/8Ci1i8K/d4aBCM0kdtAgaG08yMGzH0j8+z/1s9C6Yhu1QOBOqBqrmUqlT
TqsHcTNlfBZZ463FLPNMWz7gEaJ0SRCoGJxsmWMGmE8ccEO/YinxDnuD3urG9MvD
Ty4PMILaYWkgTQbxU4BqDHMpJHOX7fgZSe9TJ12m8c5IpVOxsryMT9+3IhrVhm5n
XsgRG3+kCFTTGGy5ZwbVsy1vhC2rhHztVIkwIBgUbRosTnBCwQlBKyC0LpEvOqwg
T0CWsF3A5m80VYzNC1sB3YQujhBqqbWX+xerAV1Cnby8yfWBrQPDCw5fVdWMT9zF
yCSIMsCpOhbml7dFAQtxexUfUHdP9ZR2YVcrBjITDhEXNvy/kxFWPGEtA6canD5d
LcsCk4RVz3n4wujal6z1cWHKkHiE+zSyOZeMlOyOhW9Ma54FWSx4GLAKWvsNXaNG
2ck+KZcPreWkCoCNewxnxyRN6IpSfZ5KoWKqBtMdzvHpPL2mvD0tB+TZyNKeomvL
M3AACoFZxt22DplAD8Xhd7CNOycnA6M0dGLTgXKfEQdrmjIvsudKmMRHHzxw6iWh
ch0t5hOuWQHMQpjUohI66NRFt8ik47qCpzYWQsNM7ArrXb301OBCmdWEiFBh9ub+
O+WRpO3gR4ZRLJ2KlmalwNHzkDD+W4/Y7Iw9AfbkWslsqG8kJAo=
=Oeqe
-----END PGP SIGNATURE-----

--48TaNjbzBVislYPb--
