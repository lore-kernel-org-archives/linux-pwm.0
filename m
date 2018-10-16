From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 0/2] pwm-tiecap: Add support for AM654 SoCs
Date: Tue, 16 Oct 2018 13:15:41 +0200
Message-ID: <20181016111541.GE8852@ulmo>
References: <20181016060402.18756-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ey/N+yb7u/X9mFhi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181016060402.18756-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, Andrew Davis <afd@ti.com>
List-Id: linux-pwm@vger.kernel.org


--ey/N+yb7u/X9mFhi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2018 at 11:34:00AM +0530, Vignesh R wrote:
> Couple of patches to enable pwm-tiecap driver to be used with TI's new
> AM654 platforms.
>=20
> Vignesh R (2):
>   dt-bindings: pwm: tiecap: Add TI AM654 SoC specific compatible
>   pwm: Kconfig: Enable TI ECAP driver for ARCH_K3
>=20
>  Documentation/devicetree/bindings/pwm/pwm-tiecap.txt | 1 +
>  drivers/pwm/Kconfig                                  | 5 ++---
>  2 files changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

Thierry

--ey/N+yb7u/X9mFhi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvFyF0ACgkQ3SOs138+
s6FGaw//csiUGEqfwZ8tliCNgbz5WYxINJb+RjG/Chxlb0md2/9EuQkgVzAC4pNe
mEMRD+h46h74M+21M4pb87zPjklMQPyBMkopY1h+S2mf4sGRtibFwBntK9/vX5Jq
0NN1gAFUrv8ckHYfCvR6uMJ6Gu72RpX9KkJjNVnZtJF18tCIR03+jvKLZCbHe7F5
aK/VTHy8zzLMx70po1iIcubTnxOxRi8MfVIVW52gsj6ffG7KHouTN19DJGUvkicy
7VDUR9OMNl/4BgtlkGxzcM9Jmc27iUUS9xUZEk5OCheGuFfQCnKnxKDapuseb1u/
hPoabCvx/3OPjo5Dmhy7rc0KPRHeybRFKbIavPvzQ+UNqK6E0suRgGEu5bB43/Wi
t3PyY5bbEI6toEt02ONgCDGT2apINvPvscN42CqyQzVXD+/lfB0ayLKex5v60ARC
q0wwonzglROvLjrVeaOfcz5zs2RsfI65nQSwgoz1yb1PeTEocZ2h4vrZnIwVAUn5
mKScjezE2uBtKhnnLNaFO332CeGMmaMpBhCa3Ak0QT3yqNIspQCYjlYFRWHV+Mz5
1CmdTFCbRxf0/egNDYWXjQxkD07/uRclZt7g37iuRx7N8+VZd5pi44Me7SGD7k95
8Nu0EKFApi8HgP5Rw+Y6FneH6ZeowlEuMaCJo3Bgrq5ozbrpSQg=
=vO/S
-----END PGP SIGNATURE-----

--ey/N+yb7u/X9mFhi--
