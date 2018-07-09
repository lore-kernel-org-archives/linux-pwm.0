From: Shenwei Wang <shenwei.wang@nxp.com>
Subject: RE: [PATCH v2 1/4] pwm: fsl-ftm: Added a dedicated IP interface clock
Date: Mon, 9 Jul 2018 19:00:34 +0000
Message-ID: <HE1PR04MB32897C3E284B8E4B1A5530CB89440@HE1PR04MB3289.eurprd04.prod.outlook.com>
References: <20180608192237.11063-1-shenwei.wang@nxp.com>
 <20180709170926.GF26651@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180709170926.GF26651@ulmo>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

Thank you, Thierry.=20
Have you also reviewed and accepted the other 3 patches in this serial?

Regards,
Shenwei

-----Original Message-----
From: Thierry Reding [mailto:thierry.reding@gmail.com]=20
Sent: Monday, July 9, 2018 12:09 PM
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: linux-pwm@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>; linux-kern=
el@vger.kernel.org
Subject: Re: [PATCH v2 1/4] pwm: fsl-ftm: Added a dedicated IP interface cl=
ock

On Fri, Jun 08, 2018 at 02:22:34PM -0500, shenwei.wang@nxp.com wrote:
> The current driver assumes that the ftm_sys clock works as one of the=20
> clock sources for the IP block as well as the IP interface clock. This=20
> assumption does not apply any more on the latest i.MX8x SoC family. On=20
> i.MX8x SoCs, a dedicated IP interface clock is introduced and it must=20
> be enabled before accessing any FTM registers. Moreover, the clock can=20
> not be used as the source clock for the FTM IP block. This patch=20
> introduces the ipg_clk as the dedicated IP interface clock and by=20
> default it is the same as the ftm_sys clock if not specified.
>=20
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> ---
>  drivers/pwm/pwm-fsl-ftm.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)

Applied, thanks.

Thierry
