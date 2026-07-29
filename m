Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF9C35E1B6;
	Wed, 29 Jul 2026 21:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785360882; cv=none; b=FjzwUdBIrDrBgp9/03G1yAZn6oxZdEzUCbiIhM9wT708gnEsnpCDeIT8ds3PM2sO4phgBYE+SM0qIOEiq3JwHxcHBaXVUY+KOjZ84N8hXU184D5ZQwz5BYC+hfRh/f7TrRYBtH0uc1WtvKz1EqesFA46tmy9Uy8Qb+tpTQH/BLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785360882; c=relaxed/simple;
	bh=r3bdA5BvMKd5JQGbpJ5oaW2oU0qgoRETdDvuwnDLMLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3D3EM++8q6Ot3h99ipsmy6tj9wW9lXtOlHYImQF8AVE1qBwMUvtTUD8BjDXfjwTPppPmrd1cGstqYfh+xkKGqoKBVTXR54HA89ZeuMqfjYOIfP9PFPJfuFnLQ37LYSahP5LlrERXro6a3DK08f0gQtQayZd5RM+3ZeXTM4xwXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zl5s5JRr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zl5s5JRr"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5108A1F000E9;
	Wed, 29 Jul 2026 21:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785360881;
	bh=Ikp/9ST9+QsX0CUoLUw87gQaEWZe0PbigapP7ARPCjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zl5s5JRr/+ny76vTAq0Rqf553ikUZMxiqZGEpvdFiugQH+t9fLayOwwSCI5xiB05J
	 +cVZQb4ahP2iOodHPQXWI272FrAnn0mBef8o3FrXpAkAprJGvbXlr0NHz7/eT7KB1c
	 vCSMjsdCQoSBt9V7peQoz2FXj5asmSk2Ly1tnGuGZPSLdB3VJWGvqudqMDJiH/Kn0/
	 8EXjpR9bnp02JO6QsM5zGsBAxV0tuUgoxAg4FwgHwLO/62ZrW8xRJqkNVInsN0M0Ay
	 qSG1dLx2VZclQBstjwHzUMQIa3FziNBGSjzPYE0ukKUCXuHfsZ5+iqKoFqf0hkHEZC
	 ae1bRC31A4prA==
Date: Wed, 29 Jul 2026 23:34:37 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chris Packham <chris.packham@alliedtelesis.co.nz>, Andrew Morton <akpm@linux-foundation.org>, 
	"Darrick J. Wong" <djwong@us.ibm.com>, linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [hwmon-next PATCH v4 3/4] hwmon: (adt7470) Expose fan control
 via PWM framework
Message-ID: <ampxIhULPHehuh-W@monoceros>
References: <20260729-adt7470_thermalzone-v4-0-c14039dfa0e6@gmail.com>
 <20260729-adt7470_thermalzone-v4-3-c14039dfa0e6@gmail.com>
 <12dfeaae-f806-4adc-95f1-97fe10ef748e@roeck-us.net>
 <amnoV4Vlxmc5QgVC@monoceros>
 <e535a9c5-28a5-470c-be21-95e1812e5e01@roeck-us.net>
 <CAJq09z5diKf9HpJ0B_7tyo2-2wPfojyG4pRY1qhRQ3fzx0Gr4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4izvw3qpe3fpglq6"
Content-Disposition: inline
In-Reply-To: <CAJq09z5diKf9HpJ0B_7tyo2-2wPfojyG4pRY1qhRQ3fzx0Gr4A@mail.gmail.com>


--4izvw3qpe3fpglq6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [hwmon-next PATCH v4 3/4] hwmon: (adt7470) Expose fan control
 via PWM framework
MIME-Version: 1.0

Hello Luiz,

On Wed, Jul 29, 2026 at 04:05:56PM -0300, Luiz Angelo Daros de Luca wrote:
> > Here the right thing is (untested):
> >
> >         if (!wf->period_length_ns) {
> >                 wfhw->val =3D 0;
> >                 return 0;
> >         }
> >
> >         actual_period =3D NSEC_PER_SEC / data->pwm_freq;
> >
> >         if (wf->duty_length_ns >=3D actual_period)
> >                 val =3D ADT7470_PWM_MAX;
> >         else
> >                 val =3D mul_u64_u64_div_u64(wf->duty_length_ns, ADT7470=
_PWM_MAX, actual_period);
> >
> >         return (actual_period < wf->period_length_ns) ? 0 : 1;
>=20
> Uwe, thank you for the waveform callbacks snippet. It was much
> cleaner. I only had to make one small mathematical adjustment to the
> actual_period calculation in tohw() to satisfy CONFIG_PWM_DEBUG.
>=20
> When using a truncating division (NSEC_PER_SEC / data->pwm_freq), it
> triggered a "Wrong rounding" error during testing:
>=20
> pwm pwmchip0: Wrong rounding: requested 714285/714286 [+0], result
> 714286/714286 [+0]
>=20
> For example, at 1400 Hz, the truncating division gives an
> actual_period of 714285 ns. If the framework requests a duty cycle of
> 714285 ns and a period of 714286 ns, the evaluation (714285 * 255) /
> 714285 yields a register value of 255. When read back in fromhw()
> (which correctly rounds the period up to 714286 ns), the resulting
> duty cycle becomes 714286 ns. Since 714286 > 714285, CONFIG_PWM_DEBUG
> rightfully complains about the duty cycle inflation.
>=20
> To ensure the calculated register value is strictly rounded down, I
> changed the actual_period denominator in tohw() to use
> DIV_ROUND_UP_ULL(NSEC_PER_SEC, data->pwm_freq). Maximizing the
> denominator guarantees the resulting duty cycle fraction never
> inflates, effectively passing all strict debug checks.

right, for the calculation of actual_period an uprounding division must
be used.

Best regards
Uwe

--4izvw3qpe3fpglq6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpqcesACgkQj4D7WH0S
/k4M/Qf9FUh8r/Mos5Xlhds3O4AozIeptjPDjVQinaOBMDcTpvpIKWGiYJPR1ZOa
V+DtOcZXGmh+9tCqZBKMDXLqlpwp+6Ln6NQ5h8n8gs5mZQBKMn2N8VT0ZtRyl8+F
gl7BgU2Cj/roFgQwcMP9tfArvRRZecQgHGCVytDB1JyX8cN4fBIwosa70AuuXBHl
tLldpU77Xnj4LHkfo60iLWHrOwjhpervElLiG3H+6zlRrZBNBXMkJjHRo8JY0wJu
xbHZ/cbxMmvjF/7WHKJBoKQaeWfY9izCpJDi1wuVVTieHJL6F36ysWFsBPhDY2P3
JC1yu7ANKYAyqGrzM6k8diEbnTYRHA==
=sWH3
-----END PGP SIGNATURE-----

--4izvw3qpe3fpglq6--
