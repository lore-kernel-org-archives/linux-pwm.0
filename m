Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C593F12CB;
	Wed, 30 Sep 2026 09:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790761885; cv=none; b=CELD+g24AcQJ/dgo49YJXzWsCpqrflQBRJPYsLFQfJvckaoHd6R9JCAVeC+zWOzSODK0lRctYoHLqRFYQSp8NbK2kF6RZA3E2F9ZncL6enjO0AHVI7w4kTgICTXwVGlS1xgc8O1pPdqhiziPKn6I+UIl8aZDfyo0n1tWcDbAHJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790761885; c=relaxed/simple;
	bh=EBE1m0kLqI43cnWWZqc23nY6pdyyu6vUCPedrdGH1vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYDQgujyW4E0FTBqJ/cvJ6XcDM9ntunrNWskEPBnUs4wrmJhGalqeD9ly2b5JnnLsa6pu+WKdfLIjk5l2YgXILeNNs83wg3geHCZR48uqAWvVcqlXKuQOnyG9CKQaNTPJYiq9wNfsHBwMjBZrUFmlR9QuHyyIvudibVRBtL+FWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gj8iCeJ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gj8iCeJ2"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D48851F00893;
	Wed, 30 Sep 2026 09:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790761882;
	bh=EBE1m0kLqI43cnWWZqc23nY6pdyyu6vUCPedrdGH1vo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gj8iCeJ2BZP5krW/RoJ+kxjg5a1FQKjfWO5Lvsw3mrQ8zE6llJxH53Ga3YkbD6F/Q
	 dd/qcy7VR6khU7Zjs+32lYVujWDj4qWYpYhrCt/w9opE+AYpHiiYowUXdcTsfhT2fI
	 amPjRMjE0oCE2UIBkcxBZ0rHmN2UiJMtNfxa8TiEbNR6eNLO1eWomSzO4J/U14Ve8W
	 dTwXxa4jnv9meuGfOgONA1jzFZeuk/heKIOu28GxDe1jM7ysUJtJ5yrTVjIGICYvBF
	 btQADkeKJ6XhoQ+Qkf+pAHUmeFJ1sNL2gN14/ECc9uluEI2zH8cmojWd3WLlGuMJ+W
	 kyXcC0zBvGI+A==
Date: Wed, 30 Sep 2026 11:51:19 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Chaosheng Qu <quchaosheng000406@163.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, mfd@lists.linux.dev, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: mfd: convert lp3943 to DT schema
Message-ID: <arzbUdicbTs1fMgt@monoceros>
References: <20260930023923.49917-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vc2iopraffurj6bw"
Content-Disposition: inline
In-Reply-To: <20260930023923.49917-1-quchaosheng000406@163.com>


--vc2iopraffurj6bw
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] dt-bindings: mfd: convert lp3943 to DT schema
MIME-Version: 1.0

Hello Lee,

On Wed, Sep 30, 2026 at 10:39:23AM +0800, Chaosheng Qu wrote:
> Convert the LP3943 MFD binding from free-form text to DT schema.
>=20
> The LP3943 is an I2C LED driver with two sub-devices, lp3943-gpio and
> lp3943-pwm. The GPIO sub-device is covered by trivial-gpio.yaml, so only
> the PWM sub-device gets a schema of its own.
>=20
> The PWM schema documents ti,pwm0 and ti,pwm1, which select the output pins
> of the two internal PWM channels and are read by pwm-lp3943.c with
> of_property_read_u32_array().
>=20
> Assisted-by: LLM
> Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

The patch looks fine to me. Fine for me if you take it via your tree.

Acked-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>

Best regards
Uwe

--vc2iopraffurj6bw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmq825UACgkQj4D7WH0S
/k5GEggAk1gW8WIFUM9qdG7Tt59/KS+51ItNoBAwYvzId4gfqtt3Yeps13yAh4iO
5No39BJGjd/cEY72SE7LwelHY7fGcG8PHHsiFHVQHWTDtCwj7ox+a/xwmcReOCDj
Fk9DyPVtxnXuPmi5tJZ7axK7R17qYERU3M5G9VXf5o8sgtBxJCtO9c9qv5/QdOEp
38f/CCKIu+y2SeEahEUAw2XhQDPTu7gZ5s7lkHFmEfROCzWbPQcC/eMzCNwghS9+
Z4EdftkCMLtMZ0P7wlNMd3lcuc8Rnx9fcKWND9x2e7d+ghNvybl2Xf8izlqRUUiv
jhYzjxySYD3USNw9vciPbVaY553Gbg==
=PAGq
-----END PGP SIGNATURE-----

--vc2iopraffurj6bw--
