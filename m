Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E41E40E8C7;
	Tue,  9 Jun 2026 13:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781012565; cv=none; b=qqKGEKQJkswzwh1OxhZwSS2VZjwEbRfvaFyPc3IqofiM+UOD7CDru1HQN/obT/pGz7SnoCgPfa4i5+7Zqqr7U+rHoD6Q0XCQrKyYFIdLrF6yrKbBNsCO1SAujiQgJYdjlSj+zhz47MEo5GpnTKKIphej2TOwJ99IVTJucrILLYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781012565; c=relaxed/simple;
	bh=zGNMPlb3a/Tydzp3/Rr2Tf/J5wLi5iPR3DtAmkbGU5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2FR+eYwwn1pr4mGRblqeelVZpatr6HG4HbHoMSqb2O+6MuQwZuUWCa4qnMA4TrrkJUhOl9yEN9JdKn/SHWCVGRXGlB5Xum02UFC5ikrIDojkW0JXdeJmVjltMqSVLY+uPPSTNIeidYVIPtn+uY3yWEtFFCPSw4SWulGSoUM590=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+EpRCl9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+EpRCl9"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 845161F00893;
	Tue,  9 Jun 2026 13:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781012564;
	bh=zGNMPlb3a/Tydzp3/Rr2Tf/J5wLi5iPR3DtAmkbGU5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j+EpRCl9CnBBkSYW22+rXzNItf40DiMC3rXqRMP3LQH6e+08DqG4ZAP+sU7OUONwl
	 Pv5+Mzs3cGZ0s4UKZBAArZ+ElTYL9bQtPCvVHnb0rEzyWfYKMmIxu9tEYrpLT9VZyy
	 u7+DoWqsEs4ji/fRQAL92d/goRG+zQmt4f0AG4E0QI31XLNusxBZqQjKlqx7WtfDde
	 Njgz3PFjGEc0VoOs4v9VdArfAKLdk8dRgHDST8O8Hxjp5zz93AuSDEzIe5vvaeH733
	 eXFZkdEu7bD92u2+sAUd8uQ3aycmzCbHTzuwu1mu7UdXd2GP/ADCgd3jjNUriAIWBH
	 YkPoFEvywd7WQ==
Date: Tue, 9 Jun 2026 15:42:41 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Biju <biju.das.au@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	stable@kernel.org
Subject: Re: [PATCH v6 01/11] pwm: rzg2l-gpt: Fix period_ticks type from u32
 to u64
Message-ID: <aigX3L2ScRk9plDG@monoceros>
References: <20260604095647.108654-1-biju.das.jz@bp.renesas.com>
 <20260604095647.108654-2-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ke56f66di4ti26gc"
Content-Disposition: inline
In-Reply-To: <20260604095647.108654-2-biju.das.jz@bp.renesas.com>


--ke56f66di4ti26gc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 01/11] pwm: rzg2l-gpt: Fix period_ticks type from u32
 to u64
MIME-Version: 1.0

Hello,

On Thu, Jun 04, 2026 at 10:56:31AM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> period_ticks is used to store PWM period values that can exceed the 32-bit
> range, so change its type from u32 to u64 to prevent overflow.
>=20
> Cc: stable@kernel.org
> Fixes: 061f087f5d0b ("pwm: Add support for RZ/G2L GPT")
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

I applied this patch (only) to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

=2E I currently don't have the capacity to go through the remaining
patches of this series, but I have them still on my radar, so there is
no need to resend/rebase.

Best regards
Uwe

--ke56f66di4ti26gc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmooGE0ACgkQj4D7WH0S
/k43/ggAisGfmu1Pnp1+ZL8xZU7NmIOv5vs9lMLl+21louOsbRImZmPi42pfE1nF
nNusRy2Ffr8rVQODie7QNSZXJh6/+ONxiqLMFReviBisZ++a2XTPmVl3OkUnz9eR
7ZSIqS7k1sjrywc+jUt50pQn3TRMp6GYv1IfsJqEuk6dfS8Cube5U6kwi639O8XW
XP3RbDhqpsxgIubWPvhImIc8nutlqzfn9GK03GYI1di7+7DidY4+WrjyXBWeSk9X
yAnfXzXuy+pSq7isrLkFYP7dQgddJfZKG/vnvLSSEk+/UaIPlNQB93P9qB/Qmw+I
PmPzslkRHMLX3SrnMcL5S30aBzS5YQ==
=wTyj
-----END PGP SIGNATURE-----

--ke56f66di4ti26gc--
