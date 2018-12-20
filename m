From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: imx: add ipg clock operation
Date: Thu, 20 Dec 2018 18:28:24 +0100
Message-ID: <20181220172824.GC9408@ulmo>
References: <1545196822-31361-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WplhKdTI2c8ulnbP"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1545196822-31361-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-pwm@vger.kernel.org


--WplhKdTI2c8ulnbP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 19, 2018 at 05:24:58AM +0000, Anson Huang wrote:
> i.MX PWM module's ipg_clk_s is for PWM register access, on
> most of i.MX SoCs, this ipg_clk_s is from system ipg clock
> or perclk which is always enabled, but on i.MX7D, the ipg_clk_s
> is from PWM1_CLK_ROOT which is controlled by CCGR132, that means
> the CCGR132 MUST be enabled first before accessing PWM registers
> on i.MX7D. This patch adds ipg clock operation to make sure
> register access successfully on i.MX7D and it fixes Linux kernel
> boot up hang during PWM driver probe.
>=20
> Fixes: 4a23e6ee9f69 ("ARM: dts: imx7d-sdb: Restore pwm backlight support")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/pwm/pwm-imx.c | 53 +++++++++++++++++++++++++++++++++++++++++++++=
+-----
>  1 file changed, 48 insertions(+), 5 deletions(-)

Applied, thanks.

Thierry

--WplhKdTI2c8ulnbP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwb0TgACgkQ3SOs138+
s6H/Hg//S4FCYBXLRTVQxiESbgu5bCtnp85AyRfd5uuzFnMEi+svvTmXxZ107yGU
EDa5ldrdBFFq7a1Gq9iTIKL1Z4goaUVteV07Vz0YrOCfla6tntMZgMQCBCibkjPa
Cw8gWq9y+4RLQEwMBqSZj9IDIqTb3zEI3rAknZsCBhOZWGz+ipkk30b8+ECc/o0P
NfBTw4Ir8e9r3jNI6K0MXVYNt/x0/nNTAM6TMeV3MBRI3U0N8fPKkl6TTcIAmTip
SB0IKsbunpMsjy8eN1Ck8/ZOyDF4h0FXS6O0vhaPkP4tErF3bZW3wwTclX7koTWP
G7XDi+QotaArO7gVOe9ehrfUgD9dRTMLoHSnauBP7idxq4JKARZ2JoC6QKOlr6uO
jjJohnQNUoIJtPNLg33LxWQrtyAMWXd4LDE2oKaWy+rZA6jt7nN0DdV4zBGXy6Vd
j1hdAQG139lEcBYUmO+0svAWL38zhNZ+s/fhfpHITJrUsJqVdnNb5bn0m8tu3chF
8EReQxi7vQoQQEX5bqiHjXJIt6i+D/ubfW26CpHjv3UIQM8iexXyoMh/KrnGNmVe
z+5Vw08BwlPEKLTs8Zv8q5ETmV/zgIdz6n4RlTfRtaMq7bcIBekpG2jHp8zrRecc
v0YMfBVvnBjspWnwSVIyosiRzRMGaVthK+3NNLEpATfvgfmULYU=
=m8aT
-----END PGP SIGNATURE-----

--WplhKdTI2c8ulnbP--
