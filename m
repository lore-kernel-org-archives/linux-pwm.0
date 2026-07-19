Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABB11DFFD;
	Sun, 19 Jul 2026 17:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784480670; cv=none; b=sFlfM3REYefdg+nYlmjOsX4pQ8/kTOwSdbLEf4Lco+2EyIMpVfzuY4uZbE+CvVrnZyGzcCeChWcVT8XeGhNH3zGKr0J1Hp9cpiHzlkkDtF8cUjM+7BTbbrilmXZH03vOpQ7wt1TE20NwlDlQkBnwWzIDa3vtzTonOf7WKtxpLm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784480670; c=relaxed/simple;
	bh=YaCRL089uz9t2i3yChLNmo/oPh2OomvmZnHIfPzR9MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8/lTUGYhXpc/D0WpGtQ51RUGOye3C3UQmSDur8jWrLUjp6nqoXBULKDYTMCAsDIACCGCeD3Q8vLixOEJt93JLURKzidDvbJKcsT6grzCMbz/gMheG3VjC9GAz/oRIk7v34aYKOg8YCz78j1467GLP0COMbDoyShieCsYqJFrDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nakDi/pm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nakDi/pm"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 209191F000E9;
	Sun, 19 Jul 2026 17:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784480668;
	bh=RD+msHtsBCsXtSwjfZWla4x43tb8RQrRYPOOqSaKFpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nakDi/pmxRiBaOcDQQg7V04Q8QC2Rcgh2a9V222lIsiqBACiI5Mcump2a5J7wnVwQ
	 6flbTkVA4GdV98uBMRULcbc3hCpJT4yFvidb4CP2D9pnoBL3RMga24VnK99vZOnLIt
	 Wzrz52+N4PBn0BniP6fiP2dzBcF52cEaDj1eR2bFCLN1ZC1WOcqyqYXimSyRiAuW6+
	 0YkwHQ5OqDUJMiCDIbsE/YzTNwGUay31I+sFjoyiOJ8sfj9JSD4Vqzd8MyZ9sM+XEK
	 8ZUhrOSux/5U9o+Tf9cFtDhZIMJB960t8QLb9RAXqP3jLpM8bo1lYQpxRcHGMs1CJD
	 J+4GrWHOqVZBQ==
Date: Sun, 19 Jul 2026 19:04:24 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chris Packham <chris.packham@alliedtelesis.co.nz>, Andrew Morton <akpm@linux-foundation.org>, 
	"Darrick J. Wong" <djwong@us.ibm.com>, linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 5/6] hwmon: (adt7470) Register as a PWM provider
Message-ID: <al0CHPmBmvCd5DW0@monoceros>
References: <20260717-adt7470_thermalzone-v2-0-a55147958fad@gmail.com>
 <20260717-adt7470_thermalzone-v2-5-a55147958fad@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tqiwalbc6rf3gtwx"
Content-Disposition: inline
In-Reply-To: <20260717-adt7470_thermalzone-v2-5-a55147958fad@gmail.com>


--tqiwalbc6rf3gtwx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 5/6] hwmon: (adt7470) Register as a PWM provider
MIME-Version: 1.0

Hello,

On Fri, Jul 17, 2026 at 05:59:18PM -0300, Luiz Angelo Daros de Luca wrote:
> @@ -864,6 +865,57 @@ static int adt7470_pwm_write(struct device *dev, u32=
 attr, int channel, long val
>  	return err;
>  }
> =20
> +static int adt7470_pwm_apply(struct pwm_chip *chip, struct pwm_device *p=
wm,
> +			     const struct pwm_state *state)
> +{
> +	struct adt7470_data *data =3D pwmchip_get_drvdata(chip);
> +	unsigned int pwm_auto_reg_mask;
> +	int err;
> +	u8 val;
> +
> +	if (pwm->hwpwm % 2)
> +		pwm_auto_reg_mask =3D ADT7470_PWM2_AUTO_MASK;
> +	else
> +		pwm_auto_reg_mask =3D ADT7470_PWM1_AUTO_MASK;
> +
> +	if (state->enabled && state->period > 0)
> +		val =3D DIV_ROUND_CLOSEST_ULL(state->duty_cycle * 255, state->period);

rounding a division using closest is wrong in the context of PWM.

Also state->duty_cycle * 255 might overflow and you have to use the
actual period in the calculation of val instead of the requested value.

> +	else
> +		val =3D 0;
> +
> +	mutex_lock(&data->lock);

If you use guard(), the control flow simplifies and using goto becomes
unnecessary.

> +	if (data->pwm[pwm->hwpwm] =3D=3D val &&
> +	    data->pwm_automatic[pwm->hwpwm] =3D=3D 0) {
> +		mutex_unlock(&data->lock);
> +		return 0;
> +	}
> +
> +	/* Put the PWM channel in manual mode before updating it. */
> +	err =3D regmap_update_bits(data->regmap,
> +				 ADT7470_REG_PWM_CFG(pwm->hwpwm),
> +				 pwm_auto_reg_mask, 0);
> +	if (err < 0)
> +		goto out;
> +
> +	data->pwm_automatic[pwm->hwpwm] =3D 0;
> +
> +	err =3D regmap_write(data->regmap,
> +			   ADT7470_REG_PWM(pwm->hwpwm), val);
> +	if (err < 0)
> +		goto out;
> +
> +	data->pwm[pwm->hwpwm] =3D val;
> +out:
> +	mutex_unlock(&data->lock);
> +
> +	return err;
> +}
> +
> +static const struct pwm_ops adt7470_pwm_ops =3D {
> +	.apply =3D adt7470_pwm_apply,

For new drivers please implement .round_waveform_tohw(),
=2Eround_waveform_fromhw(), .write_waveform() and ideally so
=2Eread_waveform().

> +};

Best regards
Uwe

--tqiwalbc6rf3gtwx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpdA5UACgkQj4D7WH0S
/k430Af+IAbgKHwB3wHiNuH68F/7F3iV8A3do+Oslwv7fyhg3Q2Lghx1h+cZafMr
N/kmHskCaZrYPOgBG43e/4mBG2ffDQF8m2vQXFnfVHoYBX0SOgqtyqm9xj5Kz6T5
DcUc+s5Jok+tgjvfbjRbiTY3qRqKCDYGIzF9cOJU3yHAsIPF33wPXmyUMqKFQ0nx
dWLbbvS/RN0qPfsFBBp1OOPUDisEo+Ix7RavTFLj1dfqeBEYP6jjdJtX42SkMI+L
ohOUO9t7r2vgGP3bv8flvlG7GTSDaE7A/NEzOHvsZbZlUcozX70l5zwt38vJjIg1
GMDeGjayOEkAfiRyf0/PlFtl7WPGwg==
=x6bT
-----END PGP SIGNATURE-----

--tqiwalbc6rf3gtwx--
