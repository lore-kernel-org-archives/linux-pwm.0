Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792655584;
	b=bUoYz6crIc4ZEnpV42DY2u50EObwlUdJFWS826IufxvjYeJ7V+bp0VoC+npUCBg5CI3f
	 00/2rmvr4GWfmdEjjwvdo1lHRDqmEXjReUn1XUnZve0FW58BILnDSI4MdBf/n1URBRm18
	 EF67VThZgBku5braKGtks2PYzEH6h63IndxZJzHvT5w9lS/Gr9sFYBHsCqXl4TeC3YiMj
	 RG9IvF52ez2kckaJv9cdzzd9XlAYom57FZCbNvEUfOjiupBPqFyg6PCDiHqlT6a5NBQZn
	 q2wfBygjibwKbgXKl1zg9VDwuK6OdIGZpSEK/LV5RmD6p30ie4uDXAs+ZzcAdjKf6yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792655584;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=peIS3XmmxGgb2VftyqIcwa5RMLKvJgxv8+DHxwLnM+E=;
	b=Pp6Lus3iCk7AS8LaVoEFQ/14gwbiBsVtd5zvS18tKIBAHtVxROn8WWKBEtIPKyL2X1H+
	 k0MDl07iubNCh/lp6O+O7fBgS/CSJcyTTh6bDrIirH3jXeTZ8pqA2I3T/0tq+IodBFD07
	 Uic8b0uBXbV7Gl1SKSOfhyOcjAZN/lr/UoGAjUCTIDDovFlF+42d+LhAm7/ZmSfoA9fAS
	 jq63N8t//sLtQQgKIUO7CkOui7xXFTLMidUU8ufkiORabgEtq3lYMCRzoCqFBmEOWdKAQ
	 POTgcuSOSCTNif8kJknyCNcfptVQwl2LOF+P3mBl85P7Lm38jpLMf4A46YmN7F5idLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ljDDfNRO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id AD343606A32E;
	Thu, 22 Oct 2026 07:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ljDDfNRO
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 07A0C1F000C4;
	Thu, 22 Oct 2026 07:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792655583;
	bh=peIS3XmmxGgb2VftyqIcwa5RMLKvJgxv8+DHxwLnM+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ljDDfNROZhbo8MD4r5QKIKpoDQu07l5UUDD7Teoc61YlMTG3yyg6l98wCcRgxFHi8
	 BoqaLZZoQHOkxk4NQfJMyZZINn3rDg5AE7MAvUCD9Ob8JbRaHFNOwhYICns4T3m8jO
	 g35oy8cRQqvl13gQMfkPhRI4Y54PY1cdaGtHa2BlkMqMvnXcsAy1xR/G4DS2XFDvPC
	 i4531NG6awNMdwKRY5b3pxtupgoMfnipGNA8AKry1eE5tQAyhnQwjRVf+DeQ46V7Qk
	 Am9akY3B70WOTrzNGJ8GwaqrXX4qFlQCmvKGlFOl5+t9YgcoykHf3JZ66TdTNp9xAB
	 yfZLvJsXFvDxQ==
Date: Thu, 22 Oct 2026 09:53:01 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Jeremy Dean Clifton <deaner92@yahoo.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: pwm: Convert NXP PCA9685 PWM controller
 to DT schema
Message-ID: <atnAaDo0fy7Az_eg@monoceros>
References: <20261022000029.125691-1-deaner92.ref@yahoo.com>
 <20261022000029.125691-1-deaner92@yahoo.com>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g43lc2iaky2qbag4"
Content-Disposition: inline
In-Reply-To: <20261022000029.125691-1-deaner92@yahoo.com>


--g43lc2iaky2qbag4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4] dt-bindings: pwm: Convert NXP PCA9685 PWM controller
 to DT schema
MIME-Version: 1.0

Hello Jeremy,

On Thu, Oct 22, 2026 at 12:00:28AM +0000, Jeremy Dean Clifton wrote:
> Convert the NXP PCA9685 PWM controller binding to DT schema format.
>=20
> Changes from the text binding:
>=20
> Document the 'reg' property and make it required. It was missing
> from the text binding, although the example used it and the device
> cannot work without the I2C address.
>=20
> Rename the example node to the generic 'pwm', as required by
> pwm.yaml.
>=20
> Describe both cells of the PWM specifier, and state that 'invert'
> and 'open-drain' apply to all outputs, as per the datasheet (INVRT
> and OUTDRV bits in MODE2).
>=20
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Jeremy Dean Clifton <deaner92@yahoo.com>

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
nexxt
as 7.5 material.

> +  "#pwm-cells":
> +    const: 2
> +    description:
> +      The first cell is the PWM channel index, from 0 to 15, or 16 for t=
he
> +      ALLCALL channel, which sets all PWM channels at the same time. The
> +      second cell is the PWM period in nanoseconds.

If you want to work on that binding, you can deprecate #pwm-cells =3D <2>
and make <3> the right value.=20

Best regards
Uwe

--g43lc2iaky2qbag4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrZwNoACgkQj4D7WH0S
/k6GCwgAl+ddqWnOwDugPpLaeoaVsF2mwRuGmkXN0oG/RyMPtyHwg31ghV/5PW2z
xfVfQRxckDF57wW6MThzOtnXMdTapjNy+Mco8IAgxC7e/7bnk3WUXjQ6EKwGqz5j
7FiwU/TB513tDXzVrHb7VuqA0GfBnBvhsFj1ddE6XMumsV+L1Y9hG1FtnmKsBQ9v
c7JmQUvOKdMhI7XmSjyqnaUGXXGvqZDKgsKb77Kulvv756LPpteQYYG+NwPvBc+8
WWqoWeewvOLwon17yT7KZup0NC2sb6ECeC+vuKMa76iARAPzRlWubdrSeVR2qYh/
9zQjAiK540d9fx6qtKDHhFZA1FomZA==
=C2fv
-----END PGP SIGNATURE-----

--g43lc2iaky2qbag4--
