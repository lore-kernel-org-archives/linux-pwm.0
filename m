From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 0/2] pwm: tiehrpwm: Enable EHRPWM for AM654 SoCs
Date: Wed, 20 Mar 2019 12:33:30 +0100
Message-ID: <20190320113330.GD23838@ulmo>
References: <20190312091629.31701-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0723807597936591331=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190312091629.31701-1-vigneshr@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-pwm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--===============0723807597936591331==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XvKFcGCOAo53UbWW"
Content-Disposition: inline


--XvKFcGCOAo53UbWW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2019 at 02:46:27PM +0530, Vignesh Raghavendra wrote:
> This series adds support for EHRPWM IP on TI AM654 SoC
>=20
> Vignesh Raghavendra (2):
>   dt-bindings: pwm: tiehrpwm: Add TI AM654 SoC specific compatible
>   pwm: Kconfig: Enable ehrpwm driver to be compiled for ARCH_K3
>=20
>  Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt | 1 +
>  drivers/pwm/Kconfig                                    | 5 ++---
>  2 files changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

Thierry

--XvKFcGCOAo53UbWW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlySJQoACgkQ3SOs138+
s6EXAw//cWZX1D6eDRV5bMkyKhYVvcHLOEPwvz27xHnAHwzaq7xMEWmRT4me3Aoa
MVyuxneuigA4JJO2c8JFlv/8UpgxU+tLtW1BtjB5iEu7yrIlzu7c/fGOaIawkroY
oPkJefoZrLFHHhIjRtpofKHrQ+5zYPV687IhMzU0fapIdId0Di08yCiFl4BIQxmD
VrYxYACjqUXMRwW7H/aUunySqSjU2g39TGhD5Ei33kG/HlUZQl9jqKXkWU/Xsvyd
lEaNfhIgl109oDygVb55T/q7VO3Kt2+B9OLzqPGxAf2z6I+Almylicx+SH+L0nJl
LqRznCMUyIM/JdJYJHsi/WH3ZNe9olF9yHwIqSX33Tu/HVkdS9coqLfRsFX9AxAG
oXIE/twkjD+zmet+KQrAWJBgZv704iOQAS5agk2bd637qSrWf900+rDWXtI0GiFR
rO3x7CZ8obd/Rwr9raKVqZQvJhtUwBiUi+vdyzsDu81NW5+j6tCoGIKL65u8WjiL
cC3tUfnJFWV+dwyGUI94rA1v3KM4ttLgBJ1WyUCAYVrgzs4TejCZ1c0MAEiD2ufO
E7RE7dLUTSKAddQsUCY1MXvTG0wGn7VD2X8uGB1Xfr6E5AcKyL0px8XiGdUYYgmx
QvlOHtFF2JEPhOibrkMKwoxeBHa0aYzr3XZxJR7UP/ulQVtZSGg=
=D2ki
-----END PGP SIGNATURE-----

--XvKFcGCOAo53UbWW--


--===============0723807597936591331==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0723807597936591331==--
