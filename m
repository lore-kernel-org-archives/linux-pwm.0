From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 4/5] pwm: tegra: Add DT node compatible for Tegra186
Date: Wed, 22 Jun 2016 14:46:14 +0200
Message-ID: <20160622124614.GG26943@ulmo.ba.sec>
References: <1466596043-27262-1-git-send-email-ldewangan@nvidia.com>
 <1466596043-27262-5-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ulDeV4rPMk/y39in"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33126 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbcFVMrA (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 22 Jun 2016 08:47:00 -0400
Content-Disposition: inline
In-Reply-To: <1466596043-27262-5-git-send-email-ldewangan@nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, swarren@wwwdotorg.org, gnurou@gmail.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org


--ulDeV4rPMk/y39in
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 22, 2016 at 05:17:22PM +0530, Laxman Dewangan wrote:
> Tegra186 has 8 different PWM controller and each controller has only
> one output. Earlier generation SoCs have the 4 PWM output per controller.
>=20
> Add DT node compatible for Tegra186.
>=20
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
>  Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt | 10 ++++++=
----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt=
 b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> index c52f03b..2851b2d 100644
> --- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> @@ -1,10 +1,12 @@
>  Tegra SoC PWFM controller
> =20
>  Required properties:
> -- compatible: For Tegra20, must contain "nvidia,tegra20-pwm".  For Tegra=
30,
> -  must contain "nvidia,tegra30-pwm".  Otherwise, must contain
> -  "nvidia,<chip>-pwm", plus one of the above, where <chip> is tegra114,
> -  tegra124, tegra132, or tegra210.
> +- compatible: For Tegra20, must contain "nvidia,tegra20-pwm".
> +	      For Tegra30, must contain "nvidia,tegra30-pwm".
> +	      For Tegra114, Tegra124, Tegra132, Tegra210 must contain
> +	      "nvidia,<chip>-pwm", plus one of the above, where <chip> is
> +	      tegra114, tegra124, tegra132, or tegra210.
> +	      For Tegra186, must contain "nvidia,tegra186-pwm".

Rob, I recall discussing this with you a couple of weeks ago, but fail
to remember the outcome and can't find a link to the discussion either.
Wasn't there a new standard way of documenting this kind of compatible
string list?

Or did you say it didn't matter much until we moved to a YAML-based
description?

Thierry

--ulDeV4rPMk/y39in
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXaoiVAAoJEN0jrNd/PrOhBcIP/3OgHrcpV580PDw9Um1h4ZV/
aRTWHRhDjdKZ/TTKrhUeIuh8jNzQV69eIkUBaR2pK38c3wziA5k+oBpFGt0uC0WG
rujfoXYccl3eiJXZCSTPCmM6RDFeSdfblkT8YpWQwF3jEsDJPFMwXSpWBWMEMHpU
td0qxcbuQGSTKmiESckOD6ck8GpjoFwtK74HRpz03VmJgOwr7betfCkoKaoBTOJZ
cXnPWUsG0TOnIVT3f8xo4Zf3p2WWQuBPs1nVx4kFoTzgO90a+cWW0Ak4dQobPUDB
eqhbdfdZWR6kjm/uJsG3TBa5yQv2XIeSo58JTbkZJ8CX8YpDfqyP48I9phmM2zL8
X6ipgzsbS4+/4cYKp9dAMoQITuFTpu9ODdvGvzuJNKVQU6nLShgBTDKFtnNTcFSE
SNazWBZCfAMwUyJNk79x8eHFz7ZYNFCYEAAlwIxRJCKVPKnttdVSkd6eqWNh66bO
qaI1MfOUOYayEZWh+Fy24XQu0OMoxpnJLRgSRcY/+g9LQXOUXoRerunIyj/15dpB
2HEDHb/M0K7q/MxOnpckbJbqpOuIXS7vYfRcEoLHVnn8SimgMT2DEsnZpGvScJyp
4blMUeJ0bgZfNKGIdrJCYLlrizMo28ULgoNB56TbmA9GGH3Yy9ZWfJuOh7/WuD9p
eLDxYpBHXFKrxaMY4jSP
=c/7R
-----END PGP SIGNATURE-----

--ulDeV4rPMk/y39in--
