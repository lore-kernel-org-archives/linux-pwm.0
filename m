Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792562213;
	b=ihvWf1gtw/R2wNEPl9fdjDz7xaoFGXr/Oh1SUFXk3CoMglI9pVlTElVwuz4ydkwP2fkd
	 jBl1+EKovq02xYIEFchmxP2Ip95uIwK8+1v07mehRpVucWA42RbzG8Cel8FmDMQadePMt
	 wdahXpMiKifXf5npmxE1ULm4BOnfThaYSiNYMAliKQnIGzBbABq8AiO/v2UG0QXBGpPQs
	 ARPpmfKsdfOtwSSt1LsrfkQueBftoAA4R06qoRLLbctOKHsaM6Jb0uLjmGR+pBqX/Hndg
	 JVCyEocHRn67w5drt4vguoxeoofm33GM4R4CqLGkawQ79nCf/viMq9oDKbh5U7KTRHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792562213;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=MTbIxTNS0QjE67ZaDxgS9Re+qV8N/0eZ/bqAXOZ7dY0=;
	b=XUhNwiD4vvild07orN3gtLZhARoSX2JNCqLdmEze0H2v1TMy/cqfGI8R26C+//+dbzEz
	 VGyYADJLlRt8owEVLZ4qiPPduB/Y6PeFqQ1svizwuQ4BujwQpWxkwLL1kli6Hg8H3lyEX
	 0RL8JhR8x5SSnkvjQNE0ANOCe1T4ZdOEMHwXnAg7qbtGvI4XIcFSibN+fk1gjUnIGfFaW
	 HGl9d9GpWykxL4aMKRkuRtrQ+3pytBaUvxLN9xv5Tn8tYwMRuJXq0RIDKrKLM7LucMJ7U
	 I7Hjumgz3NqKFTpn27b6pN6EyhtJ14uHPm9NrQa9I8iU4cYyl3jVw1JbBvZnt4HiqAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UOe4QjfT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 94A76606A319;
	Wed, 21 Oct 2026 05:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UOe4QjfT
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9196F1F000C9;
	Wed, 21 Oct 2026 05:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792562213;
	bh=MTbIxTNS0QjE67ZaDxgS9Re+qV8N/0eZ/bqAXOZ7dY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UOe4QjfTU4OOEa+CAU1yKrhxQbg0isE2+JARHhCnMhd5bZMgm58z41Bqfqea+d603
	 BcN+UtdSCNIdiY2RLDJLA+bhYNMNn27w8SYoYV41ykwZyI/30kqeJtxwBQxYZkjf8Y
	 dkgV5yAuMm1tOLMIkhutZFa0HCZpuFKkeKz8nt94/XnvgmB+wcUFbuXRaZLLqvcCvK
	 WSoEICeTFecmyixM+MogX10mZNto20xtpoCmO7Gm4sx1pKTpzWAQtJioyLtd8IQl/8
	 29a5F0tfQ44v2FIyzwIc4sWs8G1kR7nFYORqFTTTE/CPFfN3NK8YZoEYbHp7WEjbi6
	 cGOiEKrVzhGoQ==
Date: Wed, 21 Oct 2026 07:56:50 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Jeremy Clifton <deaner92@yahoo.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: pwm: Convert NXP PCA9685 PWM controller
 to DT schema
Message-ID: <athTVpsanlK9_mVJ@monoceros>
References: <20261012140346.3065-1-deaner92.ref@yahoo.com>
 <20261012140346.3065-1-deaner92@yahoo.com>
 <atH835VJLqo_mdjY@monoceros>
 <8365f405-2686-4ea3-b216-7928b826f6a1@yahoo.com>
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
	protocol="application/pgp-signature"; boundary="jkh4uyc73dal4si7"
Content-Disposition: inline
In-Reply-To: <8365f405-2686-4ea3-b216-7928b826f6a1@yahoo.com>


--jkh4uyc73dal4si7
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] dt-bindings: pwm: Convert NXP PCA9685 PWM controller
 to DT schema
MIME-Version: 1.0

Hello,

On Tue, Oct 20, 2026 at 09:13:26AM -0600, Jeremy Clifton wrote:
> On 10/16/26 4:33 AM, Uwe Kleine-K=F6nig wrote:
> > On Mon, Oct 12, 2026 at 02:03:46PM +0000, Jeremy Dean Clifton wrote:
> > > +maintainers:
> > > +  - Jeremy Dean Clifton <deaner92@yahoo.com>
> >=20
> > What kind of commitment do you plan for this maintainer role? Do you
> > have the hardware?
>=20
> I don't have the hardware, but I'm willing to get it and test on
> it if it comes to that. I'm glad to answer questions about the binding
> and to review future changes to it, also.
>=20
> If you'd rather have someone closer to the driver listed as maintainer
> instead, that's fine with me too. I'm happy with either possibility.

I want that role combinded with the driver maintenance, so for now let's
put me. If you want to take a responsibility here, please start working
on it. With a track record you can take maintainership at a later point
in time.

Best regards
Uwe


--jkh4uyc73dal4si7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrYVB8ACgkQj4D7WH0S
/k7pEAf8C5DkbXD/rKIzHbriFFgtFCNfsfB8Cj7qYxhfo/EfOQ9BipWA7HRcbeJb
DmB9/WG/ICDjOKESpzRvDn7VL28ePR/FZXU6GGTv1UczfRAMcJsGQlkKODqfr5d2
2PkFoGoXmfclGnVChtzTv4PMBkvu5vqEw8oBNlKbz2ubojbStFMhoY8fkE4Cici6
heUm/gUmq+g+KysxLAy4E0O73ovlVsTqwv+Yrfc4CTy18+tna9u4eslG97ufoc/C
AZaF5Mmm8kUDhul/PMcJIx4tvc6wExxsQraGq18JQRmXfYwS/A85Am9AzXu5prPn
EC6cm0BoObjs2E3xi1EkyQiaOWGX3Q==
=syrI
-----END PGP SIGNATURE-----

--jkh4uyc73dal4si7--
