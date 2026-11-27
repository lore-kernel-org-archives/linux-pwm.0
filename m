Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795779154;
	b=Y7EnVGrVvGYPgGwdwMJaDez96+RQJKH5QvP/Y24kLMvmchUxCYbLHl1dt6v7CgWp33ww
	 rSBBmVwZ18+VHMUNns6R1PHGxWr/PajSqeFdWUflmkP7VHIpGwHq2hBjzCr9FzJSf7aoj
	 xE+id8CUQB6RdfXJnyM3UW3RRjgQkN7g6gpHX0QGDXheto5XQBL4/hnyAVbQsM5bJhyKI
	 wErQBwAX+nHvKlZbFJSdVes6++R9IGPnhDP7Sx15BDlcdQYopROlk1y2MuG8+0x/4cEtq
	 hI8b+xCZ0ZB5ZBewk7MhBWLS58Fq1bxVXrpJ18YZVdWagh/vZQgjTManWj3ZAg0RUyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779154;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wX/FVCUzVIh9tUuN5iJYqAoQF6PWVCKZHLN6FXdcM2w=;
	b=okzVzppbnDQypmNHO829uYRwCVmEZhxGpivScN4S4QbZZ5llOaDc+Vk63+V3m+mMbsL1
	 UlfIpv2AHJfDvQy7zFwJ4i7jraGW5w6nUWWJ4nZCrYrbTAjqSBich0/Q7bzi08/+UVe6o
	 TdIJ373Uwn9f7aDRY7dd8f95ZnpOcn+6CVR2XFUEpw2xq+1jbPzGeB8/ITtTyoIgz5HQ2
	 6UbeQ1INprk8hqE2L8FwcWcJXSxJTjoPzHJHHVZhOE06ZjQ3etdzOwivgwQzRXlV7k0Ag
	 NZhG8gPnfkynKGwHnaK18z7KSsJWx0FlPhmhwChPrHVbwjrfcTsMjZozthUwtwv45tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZRRuUfkx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 55933606A31F;
	Fri, 27 Nov 2026 11:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZRRuUfkx
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5EB971F0089C;
	Fri, 27 Nov 2026 11:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795779153;
	bh=wX/FVCUzVIh9tUuN5iJYqAoQF6PWVCKZHLN6FXdcM2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZRRuUfkxfTyVqsxa0619jUylpIgFMfJ6lDjCL2nbNS67VXHa0Ni0C8STG8WMMK9IT
	 wqt6CU1IIZtnDihdrxClId1wOj/rKt0r6pz2oFLFcNT8Usf+nBJOEPUvi1ElFdnF2f
	 IuoE2S1YRWHElrKmo3EAH4QlHcHn2NN27SlY2R1s5k247F6kp3EyVspJ0moVEMu61n
	 pxD3i+rzlWAZ24RWov3SGRXuE+1rmLX82xOEbHYkLhpky0rA9iLP+mwTDYTAR8+mgZ
	 olRu4xDnZzP6TGWx/KuZsG51w2x6qzqnesaRMGyPq9omvDtPMQYpl40Tfhkx9aR6hF
	 an5mI4H/C50mA==
Date: Fri, 27 Nov 2026 12:32:31 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Vladislav Leonov <vlad@zlab.su>
Cc: linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, Simon Glass <sjg@chromium.org>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 24/25] dt-bindings: pwm: rockchip: Add RV1106 compatible
Message-ID: <awlpwN73zsCPPpdF@monoceros>
References: <20260810121121.210040-1-vlad@zlab.su>
 <20260810121121.210040-25-vlad@zlab.su>
 <anq1YM2KzkycOzNm@monoceros>
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
	protocol="application/pgp-signature"; boundary="4yohrfi6hcwzkpgi"
Content-Disposition: inline
In-Reply-To: <anq1YM2KzkycOzNm@monoceros>


--4yohrfi6hcwzkpgi
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 24/25] dt-bindings: pwm: rockchip: Add RV1106 compatible
MIME-Version: 1.0

On Tue, Aug 11, 2026 at 07:39:37AM +0200, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> On Mon, Aug 10, 2026 at 03:11:15PM +0300, Vladislav Leonov wrote:
> > +  interrupts:
> > +    minItems: 1
> > +    maxItems: 2
> > +    description:
> > +      Some PWM channels (e.g. on rockchip,rv1106-pwm) additionally
> > +      support capture mode and use a second interrupt for that.
>=20
> Is it clear what the first irq is about? Maybe spend a word on that,
> too?
>=20
> Otherwise looks fine for me.

I marked this patch as changes-requested in patchwork now and discard it
=66rom my inbox. Please send an update mentioning the purpose of the first
irq if/when you care about it.

Best regards
Uwe

--4yohrfi6hcwzkpgi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsJakoACgkQj4D7WH0S
/k7RyQf9GwSgCvWfCEuntvedN0BuWWwDO37M+L0I+K+oTL94nW/JVSeKxnCG0gTT
s/M8cJ9Vr2DmJ79LzcaXq6+FQJ6qr+ONq6amEq8jt5M36qBMVmVjIphE/VegAfCv
pL/GO5t7X30eVr5Dmhe9G3lZ9Ud94PdiC9PCaHDPU8nmQz/PnH42FQTnm6BICnkC
867tlVXHSIHENDN+P3rjSLsgzVH4uYwJOtrQURHpzaE7PQi5GomAcS46c50/asni
zYOeeLd2cRO/QF2mQUZ496dfaHg2h5t602Kwx81Wc8dAeUwCx01dAslF53OW0mI6
ya9O1cZmBYu8gzwG+YB7vaTkboHUcw==
=p8HE
-----END PGP SIGNATURE-----

--4yohrfi6hcwzkpgi--
