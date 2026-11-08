Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794127684;
	b=SasfBdP4y6iEpdgGjmNkcbVn00iwA+WKz/cb6r8XY/xxqfBihHmMoe2YTSShDj2M1f+X
	 iqf5yBbmfOtj/8EU0SaBTRVZ4Yy/vwegsIhrdtXLM3xgVIInLHoiANi2JscofMzFEhxR7
	 9Gs10230P0ksHjfc+ImnxniGUBMq6Z5+hd7KYgPzu7Ui7aBvsqKFweVNKf3mJlCfVEyk8
	 CC0kh8g+9STQSLO7oewB7oaZ7hAdg+8neRXgLnZ/ddDGdr54pAYA1XFb7H98JPIMsVhbg
	 i0WJcIxXGpVBxtE9tOqwuPTxa2q7Fqxbl0w8JCnWfr+n8/ZuxHhQBceMZa4RWiqCKfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794127684;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=hYQT1iQSwsWlveP/FynCeMcR1777Wf6i9C77SMccBzs=;
	b=joBf+Hqk0uTeX9C4YJ9S07hTUlHN+OxGKGZDKMOaQGfijV7Mgzr3HViE6N+0DUtE6d9N
	 na6UaRxWXX+7X5ldMnev/lACy5bJ5dZ6ntlmeO1BHdzb2NJ9DhGZTrMfgZRLIPd6GDrYw
	 o3gxyPDAK2BlKANotuHOwfSZSd/n3TnqKFo8c4tyLtos7w36hEFZsWY8nXPb4pLiVfwVx
	 DfGj7zTbKmPytcZZ3+J52Uy3rNaSHGsgukZACzv4woAwn1HQeSiKSfWgsNyLq1q1fBNcl
	 FEGkmmYa/UeNso3djCJYINf6XFmc91iFgORBlkhUcV6ojlrhBoimKJw4RJmNvDMxipg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cdhHIcBU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id AF25E606A31C;
	Sun,  8 Nov 2026 08:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cdhHIcBU
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 954681F0089F;
	Sun,  8 Nov 2026 08:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794127683;
	bh=hYQT1iQSwsWlveP/FynCeMcR1777Wf6i9C77SMccBzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cdhHIcBUGL1DwEzHNq9EeqVORPfy/7Lwlnhw2LDIqiQUv8o3U8IyJtPXB0+duiRwy
	 xSucdJ2mmZKm0uHL9ddexlHHiUSqzcJXww/f0q3UD5n92prMlCooafMZY34x3gWk/a
	 sTXFr/6pFSgJv7TLwMJXKzfh8jvGq+cESUX6bIMHlpGbhcsDmQmRSe9vDQXHXcCkPh
	 5Cg26OuGBG5vlsOpNqPbqHS2758xD5bRXxG7HnOX4qwQdzEWsfqYi/9BQFN/v9gwbQ
	 8at/mRxwdOZkbBLVwYpJCYBjpIZT5dpBwTY2YTpDzuO2zLPO6513gDlIsEI/Vm4KHW
	 nPGYipMLqIu0g==
Date: Sun, 8 Nov 2026 09:48:00 +0100
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
Message-ID: <avA2hReZKJL8KFUB@monoceros>
References: <20261106-apple-m5-initial-devicetrees-v3-0-cee55de54b2f@cyberchaos.dev>
 <20261106-apple-m5-initial-devicetrees-v3-5-cee55de54b2f@cyberchaos.dev>
 <avA1rkMvbmTiJDPC@monoceros>
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
	protocol="application/pgp-signature"; boundary="4zgarb7k2vkd62n2"
Content-Disposition: inline
In-Reply-To: <avA1rkMvbmTiJDPC@monoceros>


--4zgarb7k2vkd62n2
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 5/9] dt-bindings: pwm: apple,s5l-fpwm: Add t8142
 compatible
MIME-Version: 1.0

Hello,

On Sun, Nov 08, 2026 at 09:43:37AM +0100, Uwe Kleine-K=F6nig wrote:
> On Fri, Nov 06, 2026 at 10:24:54PM +0100, Yureka Lilian wrote:
> > The PWM controller on the Apple silicon t8142 (M5) SoC is compatible
> > with t8103. Add "apple,t8142-fpwm" as SoC specific compatible under
> > "apple,s5l-fpwm".
> >=20
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> > Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
>=20
> Fine for me to let this go through apple-soc.
>=20
> Acked-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
>=20
> (I already wrote this in reply to v2 on the same day v3 was sent. So
> just forwarding the tag for v3.)

Oh, however I already acked the (implicit) v1 on Oct 27[1], please make
sure to pick up tags when sending out a new revision (or mention why you
didn't) to save maintainer time.

Thanks
Uwe

[1] https://lore.kernel.org/all/auBgZhx0qcbAgHnF@monoceros/

--4zgarb7k2vkd62n2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrwNz0ACgkQj4D7WH0S
/k5bbAf/VUi/eOyCBOz+RaTap74L+qL1XDuN4e956ywIcsS1NBkWSQaBWwNlV6H+
pjPo6dozWYBNJXR2FW4AutssKdTHbXaYzs1gNQ1yuLb+n41RWcuTlAmRmtLShWZs
Y9I/+os8WcXECFf5TGTVYX7UJUXlKazj9cFnpz0d8rqbszXWFo7vW5NUxmi4b+Cl
5nXgFGTJ+FZN+FzlfT96Dk9TaGSGCb4BjayHMZakKeC2VdWTi/EgtB9pMDOJ91k7
yOmmyv+p0ESkl0XEoTncCa3V78XpYZGz6IYS74flWYs9epw9l5qEvU8fEEFbKUIo
yaZSkXCtDUT1o93z4tLmyPXWu4H6Rw==
=LzhV
-----END PGP SIGNATURE-----

--4zgarb7k2vkd62n2--
