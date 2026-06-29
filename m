Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB363783AE;
	Mon, 29 Jun 2026 14:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782745169; cv=none; b=B943z6Gs6tiOFr44tnuFIzS4Gnb+9T9Yl+BMAUsMPKUcU3w0B4FHbRFEpqAF2L/OYCY3SfOGwBK5COqar6JBFM0DUpDMrTjrie4e8IjgMZKbZ/9A1wVfcy6CFLy44mHgUb++TcUXofYwwWY1RiVIrQoKBdliufeGsI3p/G1nbp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782745169; c=relaxed/simple;
	bh=lZnRTYts2J9Bba6ns0s3r9f2oW7X1LmUA+jtYt8C0+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNKqiVkGAyGxoiGNjfzuzycCeX+DIxyS73aUFpQVu5xMZ6GpquT96F35MkP/MpsouP+45DDnKIm1w9blfmFJ3gab1slQbCiXedapwbRPTGFUoZEQWl2Z+N9V0uxfd3VJsqcVXKgPDdyjVZTH1Ptkf5O9EK5o6lax8njbNEtiqDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvT5xnUV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvT5xnUV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED811F000E9;
	Mon, 29 Jun 2026 14:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782745168;
	bh=lZnRTYts2J9Bba6ns0s3r9f2oW7X1LmUA+jtYt8C0+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hvT5xnUVC8bZLE3Zmz7pRO4kEbi3tLaejlgAEpQ2oXCdIYZwfbswbDBUyh+2/LdAX
	 HYmw/aipz5u8hiFF3A5dVvb1KSncFS2RReCzUE0SMHR9jtRNsVWu+jUCVg3kyqGO27
	 vG+SKTiPldpQEsfFupPbEPzErBsviWalzWLwANVeS2O1GTHiXK7oAHpYbohtwYnE+M
	 iPBjRTIqtPuesvupvse68sl4RndoZecY5g+suN6NsJbfFvzn/ayp/1EBeN9JNhUJPX
	 6jh32sXF89Ogms27RzfYvJK0dbEN9snh4zRKtCKMPCOPLG1ncwKkjbRx00/7828din
	 fV0slsVb5CpFA==
Date: Mon, 29 Jun 2026 15:59:23 +0100
From: Conor Dooley <conor@kernel.org>
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v20 1/3] dt-bindings: pwm: opencores: Update compatibles,
 examples and maintainers
Message-ID: <20260629-untaken-slather-b3b87558ba7c@spud>
References: <20260629063601.63917-1-hal.feng@starfivetech.com>
 <20260629063601.63917-2-hal.feng@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="spaqmsLa1o2j5Paq"
Content-Disposition: inline
In-Reply-To: <20260629063601.63917-2-hal.feng@starfivetech.com>

--spaqmsLa1o2j5Paq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--spaqmsLa1o2j5Paq
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakKISwAKCRB4tDGHoIJi
0iH0AQCbq/Pc7UCPWAO7czELCLDiZrYU85kYekwP4Su2of8cAAD/Q7X3XSSS+8sz
DkfWwc16PsO+pU+HsQErDbABnR+lwAo=
=rCeT
-----END PGP SIGNATURE-----

--spaqmsLa1o2j5Paq--
