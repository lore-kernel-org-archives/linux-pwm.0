From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V5 1/5] dt-bindings: pwm: Add i.MX TPM PWM binding
Date: Mon, 18 Mar 2019 10:58:42 +0100
Message-ID: <20190318095842.GD17565@ulmo>
References: <1552894581-3391-1-git-send-email-Anson.Huang@nxp.com>
 <1552894581-3391-2-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NtwzykIc2mflq5ck"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1552894581-3391-2-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "otavio@ossystems.com.br" <otavio@ossystems.com.br>, "stefan@agner.ch" <stefan@agner.ch>, Leonard Crestez <leonard.crestez@nxp.com>, Robin Gong <yibin.gong@nxp.com>, "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--NtwzykIc2mflq5ck
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2019 at 07:41:32AM +0000, Anson Huang wrote:
> Add i.MX TPM(Low Power Timer/Pulse Width Modulation Module) PWM binding.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No changes.
> ---
>  Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt | 19 +++++++++++++=
++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt b/Docu=
mentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
> new file mode 100644
> index 0000000..d47b8fb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
> @@ -0,0 +1,19 @@
> +Freescale i.MX TPM PWM controller
> +
> +Required properties:
> +- compatible : Should be "fsl,imx-tpm-pwm".

Should this perhaps only be "fsl,imx-tpm"? Sounds to me like this is a
hardware block called "TPM" that can be used as a PWM. The compatible
string should describe the hardware block, not the mode in which it is
used.

> +- reg: Physical base address and length of the controller's registers.
> +- #pwm-cells: Should be 2. See pwm.txt in this directory for a descripti=
on of the cells format.
> +- clocks : The clock provided by the SoC to drive the PWM.
> +- interrupts: The interrupt for the pwm controller.

pwm -> PWM

Thierry

--NtwzykIc2mflq5ck
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyPa9IACgkQ3SOs138+
s6G4NRAAvqo10mJNrbqB5kWDGp6jFuuJvnec5Eg1ws7eV7p63bS5JPPdqhwuaFk7
W4jaMMzt+uQ02+GhfXSYN2tElcKqWhdw2jtmOwHhLpY/i3o5rSRH1lEnchDAxaNn
eqfgiKMAN4ApM8FLYWeF5gINO+yfJTeRyPJ3HmXKYIzWM5f0Leaax6bJv9PvUZTQ
gGp3+3SRbSogU7Qm6KATDAZOa53kQyjX3nsRfKHSY4tgJVH5n7zGUeX9O1Zkjblz
dDHS5GAxCUFZLN9DPa8ukfPIdLjTBYIMJZnQJgtrWjnTen41+xJBbQTeM6m8xyhs
K5+oyg+olqjNdooIi3lhMoIXIDJDU0lUHhuBg9lnakcsiccGipccC3MrKsWRWl+b
ZwbKYHMiZlksqRfpiiK7R8r20090nVzTHKHkHGQqYDJiDNZu9Jvmy3ExBMMtxMy4
WHjqu+F9iRbPAz0Ky2S6JOhrJflKDaMrmaOLbmGFovQcjFdSmwCnkcy5Qap2tKVv
Nc2vBTKrLdUPMaYr2W9GPUCemyCXbWBmHYKja3I7+vW+q6h9u9yMEJfaqd9RJEI3
rLcPkCHzURjiqXCPsT/d5smYav5MmiH3WAABFOtr8mFFUnggMKEuQuCLV6beKsCc
BgOmHHREkIbmpMy3sXd612OjuJAL20ZbvpmxLU7Ne3HwHHm4/dQ=
=oKfO
-----END PGP SIGNATURE-----

--NtwzykIc2mflq5ck--
