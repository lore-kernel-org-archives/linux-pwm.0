Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD76581244;
	Tue,  8 Sep 2026 17:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890217; cv=none; b=Mr9mHznhTlHh0WHR4d/Gj3bDdpHlRvRxQO/jQget/Soe0EyxjhC+r2B9fukG4JrS2UXB+xqCLBAGYoCFNhbcKc16TAr0j7VebV2k+PHDe2hhuDLTpL/mDz6619417EGP151ZouzflHiTlNfqpLHPv8lORFT5u8rR5K4wwA5+TGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890217; c=relaxed/simple;
	bh=k3jSdgnbL5LvBC8GXl/H4R9qhk5svWd3V6MyFuObhUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcUkFOztXBdde/R6n2QjbuS9nr8dDjzhm9bkV8GhigGyVRm4E12D2HQO+qGfGu9agWsRd0dDrQwtFNkNRHyGAxLZ8JzFU5i169pvrdGM4uL+7cpkcsJKpP5uUcoYuoEO3cUD5IKJBaoGHPEJ4npUpFKeR/Yra8Pr9Nnj432udPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCR5T3ug; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCR5T3ug"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D961F00A3A;
	Tue,  8 Sep 2026 17:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788890215;
	bh=k3jSdgnbL5LvBC8GXl/H4R9qhk5svWd3V6MyFuObhUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MCR5T3ug3ogPL0IrNrVo72MWGWIY1CA9c5kINyRxx0jaUzvEgFt/fv7Z9i5VJzOa0
	 j4aGiYDceRUzHWPvg/QxXjOHvU10uyJRc1AYOUlU6X61WgVrSBhv68zt6yi5yo5GY8
	 owJ1C5NmpGfZr8awAGK/5TJYXcfBcsGLQFdBGEJ18paDYS43f9oQVQoRQAjzTYh4BC
	 y0pNJGoN2yYjSZ5VbvN+xdqmPCIyV1XAkxj2QGQRtOUWZT5SFhiy8hVY2jOShketuP
	 Xye8BM6H3XWky726vCFJSqIt1/68eFsj+0cl3RazMPIlfJwZLr7ldm8TQHCdeLeNeG
	 /kto8pO0QYXeQ==
Date: Tue, 8 Sep 2026 18:56:51 +0100
From: Conor Dooley <conor@kernel.org>
To: Petar Stepanovic <pstepanovic@axiado.com>
Cc: Akhila Kavi <akavi@axiado.com>,
	Prasad Bolisetty <pbolisetty@axiado.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org
Subject: Re: [PATCH v4 1/2] dt-bindings: pwm: add Axiado AX3000 PWM
Message-ID: <20260908-pesticide-creative-6185ca4971e9@spud>
References: <20260908-axiado-ax3000-pwm-v4-0-19a03671cd5b@axiado.com>
 <20260908-axiado-ax3000-pwm-v4-1-19a03671cd5b@axiado.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kFlJqgktNAXA6FxP"
Content-Disposition: inline
In-Reply-To: <20260908-axiado-ax3000-pwm-v4-1-19a03671cd5b@axiado.com>

--kFlJqgktNAXA6FxP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--kFlJqgktNAXA6FxP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaqBMYwAKCRB4tDGHoIJi
0mf7AP9iW5keEM1nmOylKZgW02slNGlrttLScQ5pyEVZQL9NxwEA7+4S6lfDL6fB
sJf9uC3qpk4vYAvdb0oCNDo4HdaxOg4=
=VFZT
-----END PGP SIGNATURE-----

--kFlJqgktNAXA6FxP--
