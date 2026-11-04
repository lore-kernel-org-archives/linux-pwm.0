Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807402;
	b=5jT4zAQHQshcZfoTXVswWu54wXO/ExLLsbTt9dzHAMzcP8o/xdNf5DvcHCagZAzCe5+e
	 h3pkL22PLCAcftnnab7oTuL3223u7juCIf0F1KtTws1rSRtRSiDE2VerFYHnPDJvd6Xa6
	 Lhp3Salh6p0IvGq0ypcw71P2/xYPIvfw9VkPFcSdLhP8sx1NXvNcUCnqTtR8tqf05YtMz
	 bbkrUMQ80dGaDegv9jOBpWvwQBVRMEN6WDvSkQQAayB03Rk3KyQ5nNOwK4jOieWiIho6X
	 r4pTmHIwr+WxJd/MhxNseAxb9HnUnJNSUb9MfXK+nl9iP7PDNZ+Sse8MMMTg38HJm7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807402;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0YCtVpjTTqGtYuJwt7+RiOCWhr4VkX1QLjCNxJ8HNmk=;
	b=XZv97tMdd6OaMhTFHA6FcpwusA3ArBDwARNnFlJAufEldqacluha34SI6u9fX4waKuvz
	 MqwMqykIMwMY8anzgZe2LYMzFZ1WJwFTD93nkjlIxLGBvxyXaliVUhOSmMtvquiSsFPhj
	 j9jg6iA3Ufgb+oYSMY1b0XipEyoai0poDdkf8xABc/EDLTmPlIV7+BRFi2mlbVTPZ3Hfr
	 xTOQa/dblRMWSg/UOARefumK9goQ7OcgcVAc5xyOnOr9Dyl+Ot/Yeeki/YF2M4hH4YGBs
	 vxElwOmreXRt/alXNnWFDxWevTRpkjzPQxpt2bbsmrqgT7nb8GUodJwSL3yfjn7rXvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h+r1kzSN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 95BF4606A31B;
	Wed,  4 Nov 2026 15:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h+r1kzSN
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A934E1F000C1;
	Wed,  4 Nov 2026 15:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793807402;
	bh=0YCtVpjTTqGtYuJwt7+RiOCWhr4VkX1QLjCNxJ8HNmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h+r1kzSNMIlPZ6OsPBPbk4UV9jh/t90TYcPNqUvaCUzuE7Eih2mHkdvEaXp1JmZHQ
	 ch0j8PmaMk5cQMACUWukghEzl0nchyYkj/zXC0TbNtvpbbjOuPvjmb/ZC+Ylm9le2R
	 s+mX7282FoJuKyvX/xBr9lNE74JmF7u4FyS7tayaGBiahdkATRthd4ctr1Y6EXl3/t
	 DbbG492l4X+kj9wq05t9l9pwCTY3Yf08EV+FuSf4lR0G6kqVx3C7OJsJxOMt83wFP9
	 l62aTPJJf9G3AtnWLuTQZbRwShEzIASb8WfDWCHDpcP4xaFOiMbD+wr6CxLSBKLDfH
	 dZwGGEooNNiRA==
Date: Wed, 4 Nov 2026 16:49:59 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: Remove orphan HiSilicon hibvt driver
Message-ID: <autT6wRKAtZCBmc0@monoceros>
References: <20261104145104.950566-1-robh@kernel.org>
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
	protocol="application/pgp-signature"; boundary="zj44cpe2csx5d6vl"
Content-Disposition: inline
In-Reply-To: <20261104145104.950566-1-robh@kernel.org>


--zj44cpe2csx5d6vl
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: Remove orphan HiSilicon hibvt driver
MIME-Version: 1.0

On Wed, Nov 04, 2026 at 08:51:02AM -0600, Rob Herring (Arm) wrote:
> Remove the HiSilicon hibvt PWM driver as none of the SoCs exist
> upstream. The hi3516cv300 only has pwm, clock and ethernet drivers.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Applied with Krzysztof's R-b tag to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

=2E

Thanks
Uwe

--zj44cpe2csx5d6vl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrrVCUACgkQj4D7WH0S
/k5gnAgAplBj28bWib1rtCPumDIweoJ1GwEAwcOAq/0V5a2HASMMtXPBgK/TpPCh
PwlHNiBfNJ+NvaAKY6BnyjMOxW+4WiMDEiqEAgODmZx/IqGRjNl8pWsvTE4wgb7q
ukm1Ur3zi/7zgC2Vq2B2tqMxVQWSy8Rkc8nCEzNeSnpu4oJ6vIRvnk4g8VnSdNQx
MiFHidpN5lWSopjHUjfeDPvSq+UNfiRDNzX+PbatbXMb8xxlfaxZzsMC1u0hb7l+
T7yrpCFw9jfgpTjnfQlXnk8r+Yqo+t30KKvhdCaJWLxuSywGyskTNIJEB4XixvRM
S63WnNmZr/ogI/Jd+e0XaDi5a1qkEQ==
=/trr
-----END PGP SIGNATURE-----

--zj44cpe2csx5d6vl--
