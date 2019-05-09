From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V12 2/5] pwm: Add i.MX TPM PWM driver support
Date: Thu, 9 May 2019 17:02:57 +0200
Message-ID: <20190509150257.GD8907@ulmo>
References: <1557408252-21281-1-git-send-email-Anson.Huang@nxp.com>
 <1557408252-21281-3-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h13GW2gLSV2TxsNR"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1557408252-21281-3-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "otavio@ossystems.com.br" <otavio@ossystems.com.br>, Leonard Crestez <leonard.crestez@nxp.com>, Robin Gong <yibin.gong@nxp.com>, "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-arm-kernel@lists.infradead.o
List-Id: linux-pwm@vger.kernel.org


--h13GW2gLSV2TxsNR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2019 at 01:29:29PM +0000, Anson Huang wrote:
> i.MX7ULP has TPM(Low Power Timer/Pulse Width Modulation Module)
> inside, it can support multiple PWM channels, all the channels
> share same counter and period setting, but each channel can
> configure its duty and polarity independently.
>=20
> There are several TPM modules in i.MX7ULP, the number of channels
> in TPM modules are different, it can be read from each TPM module's
> PARAM register.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Changes since V11:
> 	- ONLY add function comment to pwm_imx_tpm_round_state(), no code change.
> ---
>  drivers/pwm/Kconfig       |  11 ++
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-imx-tpm.c | 448 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 460 insertions(+)
>  create mode 100644 drivers/pwm/pwm-imx-tpm.c

Applied, thanks.

Thierry

--h13GW2gLSV2TxsNR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzUQSEACgkQ3SOs138+
s6F/KA//UWmIXrWZOEJNfWpMu2ymqohHv39qDATl8P2EsfvZ2lFAEj+Q7KxyUghE
VEbkXJksm+A8u8HBj1MKNzbxrc1xodUIWaOVo3/Nj8BY3gt1+yIaiVaEhRvUPaod
18uhIWkFg2eZAw+3vHRumyHdL/DeYu1ejmvCD3qmeCbW7TPudKPy4DFzpD2zQmYG
qVKChU8J6SA+jUNsUrAVaKBdSoorWWeImvgZeXWUN6ltRZnua5goJvWU6NSDhe5B
PPvaJAOBJADlWJ3VmGieueuY4ds2k+XbFzXezgPQZNzFYrCgdMG+A6KCzbt5ZKS+
3Hh4iSlVKwpvbK6bxOqSqqAi1AkqbGSX3FRLy1/vpm9t+SXrZWpuk/YczuaXkmNi
PhKmIQGpeuBscTs9geeNY3bstqKouYoJr5KiPrk8AxeBdxxxv6QWJtoAOXr26OqM
uGkZqYemfYjsfb8fS6Yix4NsXNfDDGU5NpHuzaoBZgbzKHZsCXYB4YYWOzX2vOE/
7TzVOLSBy/sbjDxjclVrwMvbxz9JU+j//9wn4qU49fqI3IVOq8yOa+D2jZTHOrJN
v0X6H5YQzDGtOwsPSPQIeCAxXeqvwBCmUsN65AlfVd6NHld4x/yuiXvezOqrobjn
eVxK3nv9C88dJUO40pmTUBCe5P/rXFQk5NcSffby6hGUbz3UuCA=
=SEhD
-----END PGP SIGNATURE-----

--h13GW2gLSV2TxsNR--
