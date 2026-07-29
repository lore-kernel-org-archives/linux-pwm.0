Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A792A478E5B;
	Wed, 29 Jul 2026 11:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785325650; cv=none; b=NNAcYzJvGPpFl2wgCR9n6zByhS5SxqSPzw4NGMmMpFeLftQdhrD51ALPyga7RjOqUXHAaDJwwVo31Nu3yNzKHDbArLfZW/7HxCwCNo2yC9cQCHye+xFllPeaPxBzZaATYqUs/4uFWnqH29o6P+wUpnlIBl5An3b9Rba33/DS7tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785325650; c=relaxed/simple;
	bh=46BZGSif7dQI2C28q3KXEfN1y5/ns/qyKIh6gfimRX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+hu2f3nT+q5yij/nsAvPRMz+tByOlF8GK0AYvBYhu7G83Tbby68D5DdT/1/qWsgAoDLV1qDTgNU2K4LLoV3n+Cs357TpWfYB1ul0kkSb341Val5k9aMsyNHXehVBpYEDmAGpGELais7Wvsk56wSiWTG8YGFEPex6x5FFK2LpBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUtGWzyz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUtGWzyz"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B4BC91F00A3D;
	Wed, 29 Jul 2026 11:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785325648;
	bh=kDCPiAuADEjabWGToQZToWTbQydLy4ospsAwDsIH/5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kUtGWzyzooCh6tsfMetC8hWrmwwXrQEnYQKrZHdKzZ0GI58VQavKFAvK0WVBCUyc4
	 Soa6zupdcFOBBOZhNDOHZ+DFIpkaTUSLm4ARNPdIAvFD4fvJJwX83RDtck5xhkNGQM
	 0rnuNNykX3c/K7XT1nhKCMtckEdiypWZh8LlgDKcchRE2Gvqaq8+wk4DdMbZ5OoeWz
	 QRm3GrcxSrF6MOMcyuRIm+7P24ATjYItipOYWFbZ0DOPH4eCGMbYYccDpdCEw8lvw+
	 MknVmgAwkQ9aLJxwsvYxdKVs5GKgRaTdEwLkZ1UWriEQ8BS7SMIzpqdCg3+kNIn3Xj
	 NPd1NMpPgbAnw==
Date: Wed, 29 Jul 2026 13:47:25 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chris Packham <chris.packham@alliedtelesis.co.nz>, Andrew Morton <akpm@linux-foundation.org>, 
	"Darrick J. Wong" <djwong@us.ibm.com>, linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [hwmon-next PATCH v4 3/4] hwmon: (adt7470) Expose fan control
 via PWM framework
Message-ID: <amnl5V8z8ttjWK_K@monoceros>
References: <20260729-adt7470_thermalzone-v4-0-c14039dfa0e6@gmail.com>
 <20260729-adt7470_thermalzone-v4-3-c14039dfa0e6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="upcemfm4i3e2we7x"
Content-Disposition: inline
In-Reply-To: <20260729-adt7470_thermalzone-v4-3-c14039dfa0e6@gmail.com>


--upcemfm4i3e2we7x
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [hwmon-next PATCH v4 3/4] hwmon: (adt7470) Expose fan control
 via PWM framework
MIME-Version: 1.0

Hello,

On Wed, Jul 29, 2026 at 01:46:11AM -0300, Luiz Angelo Daros de Luca wrote:
> The ADT7470 features four PWM outputs designed to control fans.
> Previously, these were only accessible through the legacy hwmon
> sysfs interface.
>=20
> Expose the ADT7470 fan control lines through the generic PWM framework.
> This allows generic PWM consumers described in Device Tree, such as
> "pwm-fan", to use the device through the "#pwm-cells" property.  This is
> particularly necessary for boards where the ADT7470 external temperature
> sensors are not populated and the chip is used strictly as a fan
> controller (e.g., Edgecore ECS-2100-52T switches). In such setups,
> delegating control to the generic PWM subsystem allows the kernel's
> thermal framework to manage the fans based on unrelated temperature
> zones, such as internal SoC sensors.
>=20
> When a PWM consumer applies a new PWM state, the driver automatically
> switches the corresponding PWM channel to manual mode so that the
> requested duty cycle takes effect. The duty cycle specified by the PWM
> framework is internally converted to the 0-255 scale expected by the
> hardware registers.
>=20
> The legacy sysfs interface remains unaffected and operates in parallel.
>=20
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> ---
>  drivers/hwmon/Kconfig   |   1 +
>  drivers/hwmon/adt7470.c | 137 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 138 insertions(+)
>=20
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 6b71e3304b4f..0d6bd117d14d 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -224,6 +224,7 @@ config SENSORS_ADT7462
>  config SENSORS_ADT7470
>  	tristate "Analog Devices ADT7470"
>  	depends on I2C
> +	depends on PWM || PWM=3Dn
>  	select REGMAP_I2C
>  	help
>  	  If you say yes here you get support for the Analog Devices
> diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
> index 87ddd7b8ddae..883838fdcd7d 100644
> --- a/drivers/hwmon/adt7470.c
> +++ b/drivers/hwmon/adt7470.c
> @@ -22,6 +22,9 @@
>  #include <linux/sched.h>
>  #include <linux/slab.h>
>  #include <linux/util_macros.h>
> +#include <linux/pwm.h>
> +#include <linux/cleanup.h>
> +#include <linux/math64.h>
> =20
>  /* Addresses to scan */
>  static const unsigned short normal_i2c[] =3D { 0x2C, 0x2E, 0x2F, I2C_CLI=
ENT_END };
> @@ -887,6 +890,125 @@ static int adt7470_pwm_write(struct device *dev, u3=
2 attr, int channel, long val
>  	return err;
>  }
> =20
> +struct adt7470_pwm_wfhw {
> +	u8 val;
> +};
> +
> +static int adt7470_pwm_round_waveform_tohw(struct pwm_chip *chip,
> +					   struct pwm_device *pwm,
> +					   const struct pwm_waveform *wf,
> +					   void *_wfhw)
> +{
> +	struct adt7470_data *data =3D pwmchip_get_drvdata(chip);
> +	struct adt7470_pwm_wfhw *wfhw =3D _wfhw;
> +	u64 period_ns;
> +
> +	if (wf->duty_length_ns =3D=3D 0) {
> +		wfhw->val =3D 0;
> +		return 0;
> +	}
> +
> +	/*
> +	 * The PWM frequency (period) is a single chip-wide setting shared by
> +	 * all 4 channels, so it cannot be changed on a per-pwm_device basis
> +	 * through this API. The duty cycle is rounded against the currently
> +	 * configured hardware period rather than the period requested in
> +	 * @wf; round_waveform_fromhw() reports the actual resulting
> +	 * waveform back so the core/consumer can detect a mismatch.
> +	 */
> +	period_ns =3D DIV_ROUND_CLOSEST(NSEC_PER_SEC, data->pwm_freq);
> +	wfhw->val =3D min_t(u64,
> +			  mul_u64_u64_div_u64(wf->duty_length_ns, ADT7470_PWM_MAX, period_ns),
> +			  ADT7470_PWM_MAX);

This is wrong. Please test your driver with PWM_DEBUG enabled, this
should emit warnings.

Here the right thing is (untested):

	if (!wf->period_length_ns) {
		wfhw->val =3D 0;
		return 0;
	}

	actual_period =3D NSEC_PER_SEC / data->pwm_freq;

	if (wf->duty_length_ns >=3D actual_period)
		val =3D ADT7470_PWM_MAX;
	else
		val =3D mul_u64_u64_div_u64(wf->duty_length_ns, ADT7470_PWM_MAX, actual_p=
eriod);

	return (actual_period < wf->period_length_ns) ? 0 : 1;


> +	return 0;
> +}
> +
> +static int adt7470_pwm_round_waveform_fromhw(struct pwm_chip *chip,
> +					     struct pwm_device *pwm,
> +					     const void *_wfhw,
> +					     struct pwm_waveform *wf)
> +{
> +	struct adt7470_data *data =3D pwmchip_get_drvdata(chip);
> +	const struct adt7470_pwm_wfhw *wfhw =3D _wfhw;
> +
> +	wf->period_length_ns =3D DIV_ROUND_CLOSEST(NSEC_PER_SEC, data->pwm_freq=
);

Round up here please to match the rounding down in the tohw callback.


> +	wf->duty_offset_ns =3D 0;
> +	wf->duty_length_ns =3D mul_u64_u64_div_u64(wfhw->val,
> +						 wf->period_length_ns,
> +						 ADT7470_PWM_MAX);

Also here.

> +
> +	return 0;
> +}

Best regards
Uwe

--upcemfm4i3e2we7x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpp6EsACgkQj4D7WH0S
/k6FTwf+Lq3ufAbhg7y3gEXM9N/l4qMBTUs9aFTrdrRDkMc3h5LWPP5Mymw1Ljly
twg6egYJ1ry5kIybjJuSTCSiJjxPJz4zp1WEQMNQYyc0fwEut4zDH1tisD9ih6RE
zPd3+UQsrrfp8YOD0a0CzmD4rWTkL28NuCnwxmhvTMTZJK2zBnV44fsqIX/MNYXq
E12efla6sQ69VU95JqYgwFWfNFaroFPmXWwdZRXo46Z97uYeiia2+oNijUeMIAFa
mooyyh9hTwdrmhQlXzUW3WO6WhTPBkspr/hSq2rcHLtLR2dKEOzbsyfvqsAOGyLE
cIpApTJjIVEAKXcCQ4tvoH+V+WzRBQ==
=2QTS
-----END PGP SIGNATURE-----

--upcemfm4i3e2we7x--
