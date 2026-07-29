Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1125E3CDBD3;
	Wed, 29 Jul 2026 11:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785325782; cv=none; b=hx73JQVJi/TZEYwh84hkCMQqQuhTUqDiJFWgysNzWUoPu8xeVIKc+eqvKx6QeY87NNetuOXErgE+Ygl/L61R/3BW6PSCsFgI7raywuJV1xZ/u0THM02ysVWeCtykvB/M5FQE8DfRBakxxJnkTFhpvWyDbCabrGzEH9QY1L/9nEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785325782; c=relaxed/simple;
	bh=2MBrK3F50F4UxMjSOKdDT2nUQbcbWV71uWM3EdHzuhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8QhD+10ljHMGAokuzjnWEeuCyYrxCyvBiKvbDF90Qi069lJVMlwqdVNoXLDguBeaZjOkZksuKsNABB66Ro8Z8mVVN6Ucr7ALiuMCH1s7OXQzX5jvcrtqT+GMgzvVyFYPM6VkXx3vqijFHCDpFN0DOIPIXTsxPJR6HXlFyaT5pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIPUTBGy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIPUTBGy"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 20C9F1F000E9;
	Wed, 29 Jul 2026 11:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785325780;
	bh=7gHFn8cwNQuvEQkgffF5WZlsvORDpQZPPnD06fCbmR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AIPUTBGybVDttfCtzt2VdBK6lg/A/1H8A+GqFJCAnqkXKqnxQH2QJZ6/xbjp4W65p
	 WIypuAkmTgbkZsk0S61F/toiuIQAdjoc8Ng6HItLvYj2kGE1CUO1zVbk01Q+kyRY6O
	 pqGIR88HP6shlLK8vrrRGx9zhwdSSjILSa9l+11viJbXHN6pDyMOvbVqhdK3phFaZH
	 WKMnRV9RL/lnC+Q5r5GGg5B8TnzotIZe2Ka85Ql76Zzo9FizdydKH0sQ7nBFmG8854
	 aNPEiJLTstSySEugOaOAxFsU1ul1y9LwHx1gQTphb1jYcgM+1KMpeMMmMUSo5DW5Ep
	 kskyIzRks1MmA==
Date: Wed, 29 Jul 2026 13:49:38 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chris Packham <chris.packham@alliedtelesis.co.nz>, 
	Andrew Morton <akpm@linux-foundation.org>, "Darrick J. Wong" <djwong@us.ibm.com>, 
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Subject: Re: [hwmon-next PATCH v4 3/4] hwmon: (adt7470) Expose fan control
 via PWM framework
Message-ID: <amnoV4Vlxmc5QgVC@monoceros>
References: <20260729-adt7470_thermalzone-v4-0-c14039dfa0e6@gmail.com>
 <20260729-adt7470_thermalzone-v4-3-c14039dfa0e6@gmail.com>
 <12dfeaae-f806-4adc-95f1-97fe10ef748e@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qe5nomgvxinbbc6s"
Content-Disposition: inline
In-Reply-To: <12dfeaae-f806-4adc-95f1-97fe10ef748e@roeck-us.net>


--qe5nomgvxinbbc6s
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [hwmon-next PATCH v4 3/4] hwmon: (adt7470) Expose fan control
 via PWM framework
MIME-Version: 1.0

On Tue, Jul 28, 2026 at 10:56:04PM -0700, Guenter Roeck wrote:
> On 7/28/26 21:46, Luiz Angelo Daros de Luca wrote:
> > The ADT7470 features four PWM outputs designed to control fans.
> > Previously, these were only accessible through the legacy hwmon
> > sysfs interface.
> >=20
> > Expose the ADT7470 fan control lines through the generic PWM framework.
> > This allows generic PWM consumers described in Device Tree, such as
> > "pwm-fan", to use the device through the "#pwm-cells" property.  This is
> > particularly necessary for boards where the ADT7470 external temperature
> > sensors are not populated and the chip is used strictly as a fan
> > controller (e.g., Edgecore ECS-2100-52T switches). In such setups,
> > delegating control to the generic PWM subsystem allows the kernel's
> > thermal framework to manage the fans based on unrelated temperature
> > zones, such as internal SoC sensors.
> >=20
> > When a PWM consumer applies a new PWM state, the driver automatically
> > switches the corresponding PWM channel to manual mode so that the
> > requested duty cycle takes effect. The duty cycle specified by the PWM
> > framework is internally converted to the 0-255 scale expected by the
> > hardware registers.
> >=20
> > The legacy sysfs interface remains unaffected and operates in parallel.
>=20
> No, I won't accept this. It has to be either or. A pwm channel modeled as=
 pwm
> subsystem channel must not be visible via hwmon attributes.

I didn't look in detail, but maybe my red line is a bit more lax. IMHO
it's not OK to be able to modify a setting that results from pushing
hwmon knobs using PWM operations or vice-versa. Switching between
exclusive use at runtime is IMHO ok.

Best regards
Uwe

--qe5nomgvxinbbc6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpp6M8ACgkQj4D7WH0S
/k4eAAgAiBKQ6g4Uhj592IsIQLbtyH5OhsoSPxTvSyycbLoJPj2h7zHbz+YD5nL6
2dUzXTnpI/WmHLqd9fPB3BqY+tqO9ce96Ez9TDLAqytgo2WLSzIi2SHG1GgoUWgn
qSpnKUSFXkHr0804cpcig69ALUWZpIPn7ZyHlvcI7jY+Xu63H5CFhcCD8ah9mBxq
QOUY18ulyCIefnTHfjwfE/6VRI3cuFE4NfhC1KAtcq2mTKecvtt9XnwKzsiZTmH/
s8wkxYvLeAw3gqZoglGfezM165OrRBdb/maex9q7zdgFk3yZEBW2xSEugMs3dKVJ
5sWsakj4YimC2XzVJ99fg6114MulNA==
=NM+Z
-----END PGP SIGNATURE-----

--qe5nomgvxinbbc6s--
