Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38F23D6CA3;
	Mon,  6 Jul 2026 08:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783324988; cv=none; b=gtqzzOWvSB8ELQjQacbGAm18xtRXF9x56o87jU/xCsprUQHwKJ/F4BhH83tLu1HI3hf+sfq/tsiSV0UIy7rBddSNPAlFsZpvKixYFLdLohSIKzACbt0XEJh5xp1EN+yn31XYQGERW+mI8nsx8wvCTSu0TnfyWOdD+eNwuKx7Sqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783324988; c=relaxed/simple;
	bh=e9Dm59CDTA6yf/bcHxclRwyYc4sWmfXsgmQgZ95zxnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ie+uZg6tn1o5MKwaTE+imBZqpjr2MD0SxeU7K8JUqdsf6Id2+CQNiRDJ+tTiuioM13xnshyfvrhKzXNapKnicpwhngZ+6Dj8QVpdjkddfAw3TC5DM+sbspiHiRhmODlWWu3aw0mZtacm5+gVpFujIwC9l7DpMFsEbbEQI6zbR8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJdsrFQu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJdsrFQu"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id BB3131F00A3A;
	Mon,  6 Jul 2026 08:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783324983;
	bh=e9Dm59CDTA6yf/bcHxclRwyYc4sWmfXsgmQgZ95zxnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZJdsrFQu9Q8KbeksaE9BPtjKNu57dhgLgYupko35SFhXlZJFQS4vnzSq2PR9deplB
	 grrCLZ0dPCZGueDY+8sck1Yt4f8vCke3rgTSbBG6Csug9mBwjhU84HVVXjsQcLbHmt
	 t5Yzvpo6Y7sdjhweeuEpfHpb8mulQ01OTtc5Eb5PUecSmOV+TWev+34F63SGwFmZir
	 0tSVxXkPCLEHXqzFa5KbwWxx3YqvbcHmMx73YpNOG+aKCnJDxLwFCBOLlDYaTPlDCr
	 TPV2UC3cAamavOKV6RjG3mJLaIWmLSF5/yZSDo7mcqM691pWg7kuB3dVV0Ez4YYX8+
	 HP3ubw4dfQKNQ==
Date: Mon, 6 Jul 2026 10:03:01 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: keguang.zhang@gmail.com
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pwm: loongson: Reload PWM configuration through
 counter reset
Message-ID: <aktgrGb4CAO3_qFU@monoceros>
References: <20260626-pwm-loongson-fix-v2-0-5492db953879@gmail.com>
 <20260626-pwm-loongson-fix-v2-2-5492db953879@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4i5najdrrdj775kd"
Content-Disposition: inline
In-Reply-To: <20260626-pwm-loongson-fix-v2-2-5492db953879@gmail.com>


--4i5najdrrdj775kd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/2] pwm: loongson: Reload PWM configuration through
 counter reset
MIME-Version: 1.0

On Fri, Jun 26, 2026 at 08:24:23PM +0800, Keguang Zhang via B4 Relay wrote:
> From: Keguang Zhang <keguang.zhang@gmail.com>
>=20
> The Loongson PWM controller latches the LOW and PERIOD registers only at
> the start of each PWM period. After disabling and re-enabling the PWM,
> the controller resumes from the previous counter value and completes the
> current period before re-latching the updated LOW and PERIOD values.
>=20
> Reset the PWM counter when disabling the PWM and release it when
> enabling the PWM so that the updated LOW and PERIOD values are latched
> before the PWM starts running again.
>=20
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>

This also needs a Fixes: line, referencing 2b62c89448dd ("pwm: Add
Loongson PWM controller support"), too, right?

Best regards
Uwe

--4i5najdrrdj775kd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpLYTIACgkQj4D7WH0S
/k7RUwf9HbfEvpZHJvIcHytJJPia8pv9vN5kx+QzLjSthWmsV2lvMW9+7NlzLMHz
ur9HssFYrXRpuV+4Cyz8288ZqIyyUNiJWTIkplDXgDpN33/mpjou2vz69dZZskaS
8HVZi5pSgjBHHYcWt3IFXtDlkA7VsvFarF0oPPq1DflGrnR2dIbedk10E3EudtTv
5bPSRYyHJQ9wrcriFdDQXT1DUdWrUBrEAQZaXhXyjWBFb6gVJDwrxxwMJFZZH0zr
l+vDDJuyMh6e6zfaDXrj1PegQ6dZe3COin7B29nAbIchKUZHKv3vfw+hlJy8HrKh
rhlheCF7n7hFiVRywMEuOoQW/1zxUw==
=eqYU
-----END PGP SIGNATURE-----

--4i5najdrrdj775kd--
