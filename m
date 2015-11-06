From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3] pwm: lpss: Add support for runtime PM
Date: Fri, 6 Nov 2015 14:36:46 +0100
Message-ID: <20151106133646.GB31835@ulmo>
References: <1445857107-51808-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445857107-51808-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Huiquan Zhong <huiquan.zhong@intel.com>, Qipeng Zha <qipeng.zha@intel.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2015 at 12:58:27PM +0200, Mika Westerberg wrote:
> From: Qipeng Zha <qipeng.zha@intel.com>
>=20
> To be able to save some power when PWM is not in use, add support for
> runtime PM for this driver. This also allows the platform to transition to
> low power S0ix states when the system is idle.
>=20
> Signed-off-by: Huiquan Zhong <huiquan.zhong@intel.com>
> Signed-off-by: Qipeng Zha <qipeng.zha@intel.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
> The original patch from Qipeng is here:
>=20
> http://thread.gmane.org/gmane.linux.pwm/2803
>=20
> I modified it a bit so that it does runtime_pm_get_sync() on enable and
> runtime_pm_put() on disable. That allows us to get rid of the autosuspend
> thing in v2.
>=20
> This applies on top of my previous series here:
>=20
> http://thread.gmane.org/gmane.linux.pwm/2920
>=20
>  drivers/pwm/pwm-lpss-pci.c      | 32 ++++++++++++++++++++++++++++++++
>  drivers/pwm/pwm-lpss-platform.c |  6 ++++++
>  drivers/pwm/pwm-lpss.c          |  7 +++++++
>  3 files changed, 45 insertions(+)

Applied, thanks.

Thierry

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWPKzuAAoJEN0jrNd/PrOhvMEQAJBLic38g4Vxd7ln0mirW1vB
ctimXW9gseJHK/kxRFnsKiWQfRCfZdM0f8ObFdBj7T0DoleRg3kGMe4MAYSUBBjZ
TSmrO8c1Yw4h2lhQ6jvlOQsK9OUHo4BGq2Nxs5fcPceCBn2DIg8XuieX1laYx+ol
JA7bKi55N7yNkaX55dMUIdWSoEryInKZHQ7lMumUMnSfldUGH8gUIuipcm2BFGPO
pm/0QNEWOgMdykCUVibxhtWHeSOH2OTRx8mQ/Ii7gOH4v8+LjOCK8IpyyTctU2ot
2/C461paUkkXIZa0ryALvc8eR7yPbJu6JUQdFRZrp+C+OabDg7tpF4+kMCDwBgyD
2PvrZXSUnfUEH/XB7Vx6vNgjHZaZXlU6nls7ZMlJjTFy/IEbnUZdXTX/H1RfRemy
QLjXeh3DQ7AapayCaisry7BmFLU4C0ZgQdboQARiKk93zIrZ6XGSOPdEcSAzol88
x3M9zq+7VALAu5GW0rAWGzzfgWgAiUKVu+Sy5aNRrMvR/MXDggKwPN4X8UPxu3Bp
kswQ13vTJY16NDqw/WFWgNYAQyCWEsT+TsG9MNp6L0T4kV22Dhbsi86KlbBjx58w
2Wh1oWYBQM5PBGe5gl5F7xJzTOh3PGxaZFT3XWtqKE7udLHSWroPGJOsYwmPeHF5
MqwXX5m4H1ZERakZT6dJ
=LAaL
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
