From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/4] pwm: tegra: Add DT binding details to configure pin
 in suspends/resume
Date: Thu, 6 Apr 2017 15:03:15 +0200
Message-ID: <20170406130315.GB7784@ulmo.ba.sec>
References: <1491401626-31303-1-git-send-email-ldewangan@nvidia.com>
 <1491401626-31303-4-git-send-email-ldewangan@nvidia.com>
 <33445b27-ae0b-b28e-afca-e7b776b4b7c0@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <33445b27-ae0b-b28e-afca-e7b776b4b7c0-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 06, 2017 at 09:57:09AM +0100, Jon Hunter wrote:
>=20
> On 05/04/17 15:13, Laxman Dewangan wrote:
> > In some of NVIDIA Tegra's platform, PWM controller is used to
> > control the PWM controlled regulators. PWM signal is connected to
> > the VID pin of the regulator where duty cycle of PWM signal decide
> > the voltage level of the regulator output.
> >=20
> > The tristate (high impedance of PWM pin form Tegra) also define
> > one of the state of PWM regulator which needs to be configure in
> > suspend state of system.
> >=20
> > Add DT binding details to provide the pin configuration state
> > from PWM and pinctrl DT node in suspend and active state of
> > the system.
> >=20
> > Signed-off-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > ---
> >  .../devicetree/bindings/pwm/nvidia,tegra20-pwm.txt | 43 ++++++++++++++=
++++++++
> >  1 file changed, 43 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.t=
xt b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> > index b4e7377..145c323 100644
> > --- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> > +++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> > @@ -19,6 +19,19 @@ Required properties:
> >  - reset-names: Must include the following entries:
> >    - pwm
> > =20
> > +Optional properties:
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > +In some of the interface like PWM based regualator device, it is requi=
red
> > +to configure the pins diffrently in different states, specially in sus=
pend
>=20
> s/diffrently/differently
> s/specially/especially
>=20
> > +state of the system. The configuration of pin is provided via the pinc=
trl
> > +DT node as detailed in the pinctrl DT binding document
> > +	Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
> > +
> > +The PWM node will have following optional properties.
> > +pinctrl-names:	Pin state names. Must be "suspend" and "resume".
>=20
> Why not just use the pre-defined names here? There is a pre-defined name
> for "default", "idle" and "sleep" and then you can use the following
> APIs and avoid the lookup of the state ...
>=20
> pinctrl_pm_select_default_state()
> pinctrl_pm_select_idle_state()
> pinctrl_pm_select_sleep_state()
>=20
> Note for i2c [0][1], I used "default" as the active/on state (which I
> know is not that descriptive) and then used 'idle' as the suspended
> state. This way we don't need any custom names.

Agreed, I think that's how these states are meant to be used.

Thierry

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAljmPJMACgkQ3SOs138+
s6Hipw/8C7iXIxKTniDsRjJiW7L06O8kcYIoKk/Fg3uRE/rVxyyrrD5tslfl25Yw
Sv1o2vPDSqRnMMMIOD+/Ibe6DSWrYAT2KMT5vm7KBikXOqXhEDHyNvszFD4EELqe
2LN5RF/uX7oqHMaHU1bBULga9VQbYPAgI7U6AsFEk32nxWQnmuoFkR0ApnjE8UJd
nZjdMjLe92Hlnj8H1av5/SNTCi3ZMlrtuytjJHwnScfP8/Jls3xrqkdea9++GLMA
FJbcs8fShsJoufkwiYXT5BRh/5L7XjC+uhNUdnZdh8HMe/cIaRXBDXLF06jks2K1
qyghweTyI0QMURc5SWdmTfHUmdCphrT87bMwxW5lVU0+47og5FRx2YLZIOfdl09J
8Fvu+aUCrJh1TsUYt1h1K9sKH5SYrlPcpzBUjaoRfS4ixTjqnU0SGctyTpqQUQa8
9yfj3H3q2nF+n7maLaGea4sjzjWz2wsmUT4lA7PRAoWdKj72S+k+wHY5EU8RFt1M
rGvMAz/FmXkzElWCjgKX2A4qomcZj1ehJOhdTKC3rvcdm3/+rHWISOps98WnUWH6
fPg2wMRDa01k3U5Tx328EsYD1F3A8vSuYEnkBTnzN975vMtpC12HZCTzWVtCxIEX
p9ydPtmLMvujv2fCVXbNzK9WAkYco0UquBydwKTNu4oDwhjliV4=
=EN+R
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--
