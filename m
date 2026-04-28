Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C945B47279F;
	Tue, 28 Apr 2026 18:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777399984; cv=none; b=Q0fsh4fGBGlSlNfILqYS55zzNtukA36iUs9UIh7boqO6iaKk3g+vePiD2d1gnuWOxppfj9q95ZkN8HQ78OcMCzUoO/vUJSRM0gRcqjTd/tUpXwqMtjqWGXcaZCDK3jbk3qYTqf82QJEzZMj79DdoWjmrUtRa0ZvSfA+wGvZhwrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777399984; c=relaxed/simple;
	bh=adKxGlnFh2v7arFvCaA/DguA8JQxujgHW5DfTnIH2J4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0JlBMCI4aWUvGo1lkelcLd75j+gge/3VSvc4JEVXJkrPs2vyYQMWy5UXzVmkcYVzRPXIzcTVCWlwYL3Hi7oTQ0orJ3/pR53x84l3BxYiQnYNaE1JdQM9Nw6r6jLMdRTgq3rOVPR2aBnFU9qq4jbnQ1PEVkXxhFawnoPk3dTOZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvXobuaI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvXobuaI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A84AC2BCAF;
	Tue, 28 Apr 2026 18:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777399984;
	bh=adKxGlnFh2v7arFvCaA/DguA8JQxujgHW5DfTnIH2J4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AvXobuaISYzinZhJRSeIkCZzTjMI4MAbx+KCxmIVkw/nChIU2xDLsKnIbFVVcKiHi
	 6/jqaGsY+BInAZEWc0ij2gzmuEZKlhnmkd2+8ghnLtcb+ErmIaj5ZVTwrpMobTI/fM
	 gZ4hmZVdW7etub9+XioSiYGS6GAh4LnoH04v4OPYsE536zaXMSDafmPLcJsTsgSBYz
	 bEwWQWfD5TShe3oEjYrIqeTHQ7EbCS5bdAVAFEUO1O+MXBKnQ6wl7S8iHzohp8CMyL
	 nw5oV5wZOp4RVQH0imqGnsYVLVspGihuMcmZsXYWK9mEjBVXb7WkYKkDQezhYET4bI
	 rnWzPAdfpDIqA==
Date: Tue, 28 Apr 2026 19:12:59 +0100
From: Conor Dooley <conor@kernel.org>
To: Yixun Lan <dlan@kernel.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: marvell,pxa-pwm: Add SpacemiT
 K3 PWM support
Message-ID: <20260428-operate-satin-367dd5a42ff5@spud>
References: <20260428-03-k3-pwm-drv-v2-0-a532bbe45556@kernel.org>
 <20260428-03-k3-pwm-drv-v2-1-a532bbe45556@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hbZz409LMBfc1SqO"
Content-Disposition: inline
In-Reply-To: <20260428-03-k3-pwm-drv-v2-1-a532bbe45556@kernel.org>


--hbZz409LMBfc1SqO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 10:46:50AM +0000, Yixun Lan wrote:
> The PWM controller in SpacemiT K3 SoC reuse the same IP as previous K1
> generation, while the difference is that one additional bus clock is
> added.
>=20
> Signed-off-by: Yixun Lan <dlan@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--hbZz409LMBfc1SqO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCafD4qwAKCRB4tDGHoIJi
0mGaAQDq6P9TZl3HphQpeRKzTA/sPmsbvxle6zYX9nGyqTyAAQD/b2AVulWdGL2k
O2A8UPpyX7n62Inet7X+4JjZD9TyBA0=
=bCnk
-----END PGP SIGNATURE-----

--hbZz409LMBfc1SqO--
