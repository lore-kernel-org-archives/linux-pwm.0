Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794127417;
	b=PgG/2HAmQgtaoTSyT29E2SvVTAfnBLhvc23t6gDk4gzSSMpw8s4LB2tTZEDffrPUd4mV
	 LZKhLUrQdTOOTt7JBC39O+IijnSY1Cy9WS4ydHofoBX5QGIBrJg5PXYpiIYlRmGKQ3Ge9
	 Jk/W5KnrQDvaAdBF4lbUhjG6aXsYZ/qdtLDXMqUS/d+u3RhqrgrIhGvUNvaA8fRxLgY1f
	 2vjCw23eGC+CIRshq2eNc3e3zK4E2e/zBrG/76FI/frLAXCZYznIe6Iy6VfqV0DSfPh29
	 UOHDCuYDeELCKpS53o7/ZVwadkZsMV3ivaEOBiBbFhFnqaTsUEvPkAZFzexZ6aly7/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794127417;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=aGN87J+fR9ut5Wd+2z7+FR6O85gZ4NXRmC3f+7Jm8Vo=;
	b=DVbke9rutd8r2EjrI6ZgyibxkxkBPp2jnr3G2cIZgyJ4GdCyF68VPSEBhyt6tErkXhUW
	 pjyCUo2dxLNPNFOCSx3fMKWmK9nCwue77h+B+pJMbmuKEqdYRGFvUAC+bxIxfAr0gqCSh
	 LIdlUNYrWFfwFBn2B6309xLlMFHK0qgecXf82AjwlaW7ch2hH4L3AfZoAmGV/uU9Gf/Ka
	 Lp1IdeaRX1+Li2raimTvYlBz6Oz80WuULr+WL4JZP3bECwmkTedaPOg+NMVlvS8mIjuhI
	 VpC0q//YbxS+5M9/GuEMlKfyPWNwnkH1Q4S6n9dEdVLywgvbQhavL/avqk+vrgnHInQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J5lmvdLo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 61A72606A31C;
	Sun,  8 Nov 2026 08:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J5lmvdLo
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 573541F008A1;
	Sun,  8 Nov 2026 08:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794127417;
	bh=aGN87J+fR9ut5Wd+2z7+FR6O85gZ4NXRmC3f+7Jm8Vo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J5lmvdLofW+igzDbnj79eHM7FWRKXZPP7h2YGY4j6A0nVGlnEEvIoKs6+jUSpYOE7
	 uAZ3wdzOvPSyA65If4hPCyEQrjnOhaB/bmH2SXuG0rPkB+mZutvRm9p+bisx7nSyPq
	 /cH4sZhK0q2mweLfSvJ90gplPxELAI1QAAdA9BgE7FRHSBr3wTm1Y4LclrXC9zGnM6
	 JxXmqNwHjHzhlaGy7W6SIxTbXexrvC1hYF5EJZ7dxFkk/trMP5DDAhTnIuU9H02fjl
	 vvgyP80ncYhlIO7f8JYTyZGNei07mvRmUx/nrqJCLlAyCGE5szEqJfmGuWhcR+Y7Fs
	 MWoMIad2HGDoA==
Date: Sun, 8 Nov 2026 09:43:33 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
	Neal Gompa <neal@gompa.dev>, Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Hector Martin <marcan@marcan.st>, Sasha Finkelstein <k@chaosmail.tech>, 
	Linus Walleij <linusw@kernel.org>, Mark Kettenis <kettenis@openbsd.org>, 
	Andi Shyti <andi.shyti@kernel.org>, asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v3 5/9] dt-bindings: pwm: apple,s5l-fpwm: Add t8142
 compatible
Message-ID: <avA1rkMvbmTiJDPC@monoceros>
References: <20261106-apple-m5-initial-devicetrees-v3-0-cee55de54b2f@cyberchaos.dev>
 <20261106-apple-m5-initial-devicetrees-v3-5-cee55de54b2f@cyberchaos.dev>
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
	protocol="application/pgp-signature"; boundary="b3fg2hf65dsjedqn"
Content-Disposition: inline
In-Reply-To: <20261106-apple-m5-initial-devicetrees-v3-5-cee55de54b2f@cyberchaos.dev>


--b3fg2hf65dsjedqn
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 5/9] dt-bindings: pwm: apple,s5l-fpwm: Add t8142
 compatible
MIME-Version: 1.0

On Fri, Nov 06, 2026 at 10:24:54PM +0100, Yureka Lilian wrote:
> The PWM controller on the Apple silicon t8142 (M5) SoC is compatible
> with t8103. Add "apple,t8142-fpwm" as SoC specific compatible under
> "apple,s5l-fpwm".
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>

Fine for me to let this go through apple-soc.

Acked-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>

(I already wrote this in reply to v2 on the same day v3 was sent. So
just forwarding the tag for v3.)

Best regards
Uwe

--b3fg2hf65dsjedqn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrwNjIACgkQj4D7WH0S
/k4g3AgAidRfhY4rKgEUhlf2mTx8vkNnUzoHqzB4dpQ+eTv6dAZ8nwRMnCl/9Rjk
5U87j+aDvbDDT/u1hMpORGXfuDyHH2MWkSp+cjAHupUipA3gwhJdJVq3EC+UfXQ6
TGrH7CSYlD1Kdyyjvg33m07H2QSgS1PjBHN2MqWHIMwfRdOQtl3NUYheaAK6mhfP
E6bDg2PVKXLZ2Gb+ONSmFcZnNY7XMpRVLoCJU+QOwBFV5o32XqXK6jCLS8rG3Jbu
LeYpsRLdPlZ87JVSQDlwsh/NEYrvmBRFaSgN1Lknzp8mI6O/FXJg5nz+Ivl5D20Q
0ymfj4uU8+HsKvwrRb8uEE/Yq6Pk1g==
=HKpk
-----END PGP SIGNATURE-----

--b3fg2hf65dsjedqn--
