Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D090F48423C;
	Mon, 21 Sep 2026 14:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790001342; cv=none; b=re/mLyC0NLblb0JxcrwhINtByRdSbwbOi/xkXGJDIRMaY1qmSuu6y+LJxlCZH5oAF3cuJqqRFoLn4dVX4Mhy1v/Wk8YEVuiewfhPGgGzOLnBBpkbgRuGW5TCfuldUihrvcvSvI6demUsX0G2y57zRw0OvooU1N+I8/UmzT+0pm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790001342; c=relaxed/simple;
	bh=TgQZ8zTvBUaNjX6D6k7Kmm8smLiNBC0eoqjH1NjNM/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcCo9/9JMeCCkHGBZojurb3RcKoXTfNBAlTy8jeUFR0uAMS96gRMWI56YKXnCLPx33GCPs9DbWciMKDbw++uvYFivjvO5jaxItIdpNMIhruNlLSm/6hDhujHZajWq4E7B+4JxqQeUZW1SQRDWq0WoEWGYv9xrGPCdfL6xw+RZJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odFG9EuL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odFG9EuL"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 17B901F000FF;
	Mon, 21 Sep 2026 14:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790001341;
	bh=FfNFnkRxeRIfSVC8rvgsN9btpGP8I/3Z780moERFccM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=odFG9EuLtyr9lu2Ecfa7snIZhoyKG7wH7smFOyUudLLIw6C+fzlUa1gH/uJe0Izxa
	 Z1jUzBBiPGYH7eBzTDep0wQ608CWB5qWs44NQFnzcz8GsXqvtGl++oByaaVbURR9hr
	 cpDZqhouYE2YfxpzAefXzuB+eXi3vySVgIDy4MNPv2WBNvkBEIdkUYNpOdHwj6UJuT
	 Q/ylaMJmxDFZD+gV8zvrR0osskSM++G7ju+7c0lsJkI/RCq6h4FZuJ+A4c0e5N3Bz7
	 XIxig9QZmqEf5aHKvZ36DLQL+XMiPNtWtddQpX6gMwY3sBcqUwAU85JEqmw1+Wxgim
	 U7WnRLZkt+SeA==
Date: Mon, 21 Sep 2026 16:35:38 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Petar Stepanovic <pstepanovic@axiado.com>
Cc: Akhila Kavi <akavi@axiado.com>, 
	Prasad Bolisetty <pbolisetty@axiado.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Harshit Shah <hshah@axiado.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, 
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: pwm: add Axiado AX3000 PWM
Message-ID: <arFAj7yU2x42-76G@monoceros>
References: <20260921-axiado-ax3000-pwm-v5-0-202aad28e129@axiado.com>
 <20260921-axiado-ax3000-pwm-v5-1-202aad28e129@axiado.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mkruqjy2cimrsduu"
Content-Disposition: inline
In-Reply-To: <20260921-axiado-ax3000-pwm-v5-1-202aad28e129@axiado.com>


--mkruqjy2cimrsduu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v5 1/2] dt-bindings: pwm: add Axiado AX3000 PWM
MIME-Version: 1.0

Hello Petar,

On Mon, Sep 21, 2026 at 12:21:30AM -0700, Petar Stepanovic wrote:
> +  "#pwm-cells":
> +    const: 2

Can you please make this 3?

Best regards
Uwe

--mkruqjy2cimrsduu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqxQLcACgkQj4D7WH0S
/k5kdQf+OXV22WZQ9pfauGcLp09q+oshtLYpLawSeyzm/h7HCjYisBtBbLTVFvR1
5KDGUP2CYL2HDVgdj3NypW+GEGLFsF9IN+wAIedUWQY6hWItGfdGJt42Zy5kYYRp
LpOFredIHH0OVVkxnit1XyTYC3htW1Q+DwqcqlwFHrx4zuv/etW6vWiW5Dk9za4t
JOJRoUA3sUeCXRabkWUWAST++NqKBvvgrRNJA3ys85ocQ7eBL1GQkCcn6YfJ7Af2
IuGZXl+Ys9bcp7rgQIFJ1JYj8B6JXRFXVOgUMWiGG/kcbVdUgkZWAiuQ1io0yUo2
We7S9r/5xHDPkvsTxkp68luZYviu4g==
=od5S
-----END PGP SIGNATURE-----

--mkruqjy2cimrsduu--
