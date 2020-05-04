From: Sandipan Patra <spatra@nvidia.com>
Subject: RE: [PATCH 1/2] arm64: tegra: Add pwm-fan profile settings
Date: Mon, 4 May 2020 07:12:53 +0000
Message-ID: <BYAPR12MB3014C1C921052E96D30A92D5ADA60@BYAPR12MB3014.namprd12.prod.outlook.com>
References: <1587130362-6149-1-git-send-email-spatra@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from nat-hk.nvidia.com ([203.18.50.4]:24417 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbgEDHNC (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 4 May 2020 03:13:02 -0400
In-Reply-To: <1587130362-6149-1-git-send-email-spatra@nvidia.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <treding@nvidia.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: Bibek Basu <bbasu@nvidia.com>, Bitan Biswas <bbiswas@nvidia.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Gentle reminder.

> -----Original Message-----
> From: Sandipan Patra <spatra@nvidia.com>
> Sent: Friday, April 17, 2020 7:03 PM
> To: Thierry Reding <treding@nvidia.com>; robh+dt@kernel.org; u.kleine-
> koenig@pengutronix.de; Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Bibek Basu <bbasu@nvidia.com>; Bitan Biswas <bbiswas@nvidia.com>;
> linux-pwm@vger.kernel.org; devicetree@vger.kernel.org; linux-
> tegra@vger.kernel.org; linux-kernel@vger.kernel.org; Sandipan Patra
> <spatra@nvidia.com>
> Subject: [PATCH 1/2] arm64: tegra: Add pwm-fan profile settings
>=20
> Add support for profiles in device tree to allow different fan settings f=
or trip
> point temp/hyst/pwm.
>=20
> Signed-off-by: Sandipan Patra <spatra@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> index e15d1ea..ff2b980 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> @@ -219,10 +219,19 @@
>=20
>  	fan: fan {
>  		compatible =3D "pwm-fan";
> -		pwms =3D <&pwm4 0 45334>;
> -
> -		cooling-levels =3D <0 64 128 255>;
>  		#cooling-cells =3D <2>;
> +		pwms =3D <&pwm4 0 45334>;
> +		profiles {
> +			default =3D "quiet";
> +			quiet {
> +				state_cap =3D <4>;
> +				cooling-levels =3D <0 77 120 160 255 255 255 255
> 255 255>;
> +			};
> +			cool {
> +				state_cap =3D <4>;
> +				cooling-levels =3D <0 77 120 160 255 255 255 255
> 255 255>;
> +			};
> +		};
>  	};
>=20
>  	gpio-keys {
> --
> 2.7.4
