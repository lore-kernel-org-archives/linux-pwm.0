From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V2] pwm: tegra: Set maximum pwm clock source per SoC
 tapeout
Date: Tue, 13 Jun 2017 14:32:42 +0200
Message-ID: <20170613123242.GA16758@ulmo.fritz.box>
References: <1493733937-15822-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36447 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752083AbdFMMcq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Jun 2017 08:32:46 -0400
Content-Disposition: inline
In-Reply-To: <1493733937-15822-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: jonathanh@nvidia.com, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 02, 2017 at 07:35:37PM +0530, Laxman Dewangan wrote:
> The PWM hardware IP is taped-out with different maximum frequency
> on different SoCs.
>=20
> From HW team:
> 	Before Tegra186, it is 38.4MHz.
> 	In Tegra186, it is 102MHz.
>=20
> Add support to limit the clock source frequency to the maximum IP
> supported frequency. Provide these values via SoC chipdata.
>=20
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
>=20
> ---
> Changes from V1:
> - Set the 48MHz maximum frequency for Tegra210 and earlier.
> - Set the maximum frequency unconditionally as per V1 review comment.
> ---
>  drivers/pwm/pwm-tegra.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)

Applied with a fixed up commit message and Jon's Acked-by.

Thanks,
Thierry

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlk/22cACgkQ3SOs138+
s6FUvg/9GWE7gr80lQjeU4gJffUU9GDWhFCHMpQVHRjTvcI2PbMDwvU8soprTlIG
bJpT8ZnGlRHkRuUmyyuHgLwZBxTO6FiSJpgnxb7+NKmNx4wIre7xvgM2I7G+4c7x
gLhz2Q51mzwfHEJtYfxYvhUy//8e2XJDp9VCKxdjq73d44E6/uTYu7MJw+iHr5Nx
AqwkFIXhVQEzwTVol1dppKTyIkDXPGd/EyWKCo7ZD9wtSt0OnYuxi/9Ai+OzLf+U
SO1G4oul6qqKStuAUyZFWpVOq2GjNDjKaFMkaa9n7cuQ0xNrK3TOy/6Rb5KGX7Gd
7HQE4FJkSi/gXd6avAZRbKMXGAXx8r7brCRunNrvNvn/Df9SJ4MTXvwvay3QXWIP
izEIV57FB5dZRbir40Gm9VduhLTw+rFiBY9s05S8rDLiXHnSCn3H/98PXttQvdrB
cVXLc/ywToW4dIx0uX6AUefQd1tzuRLoTCOgTkkVt+8sg2nl0okpWxzYXVr+VIPO
Jr74Y5RmlEpmIBaiWFE39qxmmYKiX4XYe3efOnwP2ar0cMeuqagwXcR0uO0CN6T8
a9GV6/OgEHQON45DevhO3iXpqVtptacjvfTA89veCiynNho7+ORyZgOPrRWo3hCZ
nJmMC0v/CKrFElJTGs772Mc9UzrN308NzJNRSkqYxo5lWlrZi4k=
=8zck
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
