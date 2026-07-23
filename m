Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132603A4F2F;
	Thu, 23 Jul 2026 06:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784786730; cv=none; b=hviZyQldqhFo6IdYabSWgET2d9GZr9grS3apaDED2tFPkR9DUG2BZLVJwNAG/0/AGHjf5E7yhPZsOHvAuGyhIFEq/EU7UW9g65ysuvb22L5AcOUET8rhSv8oFVI05ARhNRwdOA5EahKmkDoDkVBVr3IukyH6sMrOsKe5mAbbpcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784786730; c=relaxed/simple;
	bh=UrwnRF2+Xl/uAvdxijfUZ4/LKWODbJLPfYscRBTs/iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Py0uEZFQKtjFgAr4HWGwEWuZlifoYe/R7z5wboHobF264aaf3bZRgD0mw7gA42Rrw8EZwdvwialrX7B0BEW5ptk7d2ktezvZ7RKcZAcp8ifihMCYpAbnAPuvw406MG1DUyIZc8F7116JIjvB/CWFryERcfYkA61EsigbR4sTdOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbERONB6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbERONB6"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D3D671F000E9;
	Thu, 23 Jul 2026 06:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784786727;
	bh=UrwnRF2+Xl/uAvdxijfUZ4/LKWODbJLPfYscRBTs/iM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZbERONB6JYz/ABX4SImHlzDkN+VXaQmE7uumsjswMJtK8fTdOoY6Fi19G88N0EXg8
	 Ob5+s6MUNmrl3DQzHevgEO51Fp3midErum46nabFA4ymYbnxLyESwpYIxFmAsPvPV0
	 Fpn8QXbemLy6Asgk17RD7CJQdWFyVdMOUb5/I0uIGf1KtmVbxtLcvE862GEfrnIzSq
	 KqeIbfGbpbFbshhVWGp1cb+KdS1wRXuGkp7mfFLZw9JQc8FMNXum6t4nfRBeR8hyc6
	 AqRXlBwysNEpt1RbIFb6J6u5cx/4JQjJ9Z2ZyIqQuXg5j6S8lbUBbqG9SqjPZ1oQc/
	 84rgkSuRl09Pw==
Date: Thu, 23 Jul 2026 08:05:24 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chris Packham <chris.packham@alliedtelesis.co.nz>, Andrew Morton <akpm@linux-foundation.org>, 
	"Darrick J. Wong" <djwong@us.ibm.com>, linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: hwmon: add binding for adi,adt7470
Message-ID: <amGu_z_AfhBKo6zi@monoceros>
References: <20260717-adt7470_thermalzone-v2-0-a55147958fad@gmail.com>
 <20260717-adt7470_thermalzone-v2-1-a55147958fad@gmail.com>
 <al3yFHvlzQuIywEj@monoceros>
 <CAJq09z7z13hO33xpfQNYc=eHec3yN3H2yVy=oqXhuvhRZhvX3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5p2z5vjgxof4kl2h"
Content-Disposition: inline
In-Reply-To: <CAJq09z7z13hO33xpfQNYc=eHec3yN3H2yVy=oqXhuvhRZhvX3g@mail.gmail.com>


--5p2z5vjgxof4kl2h
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/6] dt-bindings: hwmon: add binding for adi,adt7470
MIME-Version: 1.0

Hello,

On Wed, Jul 22, 2026 at 11:48:19PM -0300, Luiz Angelo Daros de Luca wrote:
> So, for the next version, I'm declaring #pwm-cells and
> #thermal-sensor-cells directly in the binding instead of pulling in
> pwm.yaml via $ref, and pointing to pwm.yaml only in the description
> for context:
>=20
> "#pwm-cells":
> const: 3
> description:
> See Documentation/devicetree/bindings/pwm/pwm.yaml for the
> generic PWM binding description.
>=20
> Let me know if you'd rather see this handled differently (e.g. keeping
> the $ref and accepting the pwm@ node name), but I think keeping the
> node name aligned with the device's primary function is the more
> correct approach.

Sounds sensible. Thanks for looking into that.

Best regards
Uwe

--5p2z5vjgxof4kl2h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmphryIACgkQj4D7WH0S
/k6gWwf/WG8fdvb+TZqNbtvaAx472geug81LG7tvpOpJxyDzMhc1GiJFkZEjo7xF
Ox9+FsS0IieUFCw5XO01PGQymBC6wFLwQb/vidQ5EzfbHGR6kCWTJzCRA8SDVwDd
81rr76Xz5tOwp4/p445euBJba1UDgM5oYHFf+wl6dPvxB6CrM/8VlkrBR00apTUY
VwZ2dFvNaeHqvy6eHSijyww+fRljgFVw4vGKTleX3FQMNaT9mOGmvvoGgB4C1pSp
/oibYQZlqUGNdiDubhwhJRM0m+HIwSqL1POV3G29ikRrEEuExEg3AfGThZ2kbqiF
1muORCj3A/k9Cs7KtDV00XuNaw0e4g==
=EE1B
-----END PGP SIGNATURE-----

--5p2z5vjgxof4kl2h--
