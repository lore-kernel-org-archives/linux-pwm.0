Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2C13093D8
	for <linux-pwm@vger.kernel.org>; Sun, 17 May 2026 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779036772; cv=none; b=qUvfjEWNtWMqpIGtmfPpdadDIP+bgHd4UYGHdpRuAMqc9knYlJVy+dF+F+dj17GN5Ph6g+lqTTe15eyn/i2iZgDB5AHBYl6Zj3FL89EFM+TrLxXTY7lelXz6jKzC+kVCk4YEUOcO2MT1nkztFAlpqRROhI7quGBPzeS39xkc9CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779036772; c=relaxed/simple;
	bh=5L9dAUBCKqTLNPQMmC8ulIPgXU0nUvsDamDbIBk8HOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6WPHDTTFboJ2azL/WveSMgDBAyzNF2i0re7Oc7MNkTYofkQTlGvZhOKihI2pqP0zbPnf/i9jdUeggnpW+YTsHPNb1bH56zJ9w0d8J1jHU1C0esxdZrYk5NMcSPHjxl0Wp9/UF5Mh2LZgRKQMbjaBEa04g28OzSOmQcApc2Ogno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iM+Xn0/s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iM+Xn0/s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABECC2BCB0;
	Sun, 17 May 2026 16:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779036771;
	bh=5L9dAUBCKqTLNPQMmC8ulIPgXU0nUvsDamDbIBk8HOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iM+Xn0/suCKUetsnBG+Z0ZW14LMadjHGD/1yeaz6PZttxm/gHHipqufcK6C2juFkG
	 Tf5uEp9qcIzk74Zzk1Q+Xv0wbSagmPdrUPCJ+qvtgQouUggurxhPpRsP/T1jKENe1r
	 BDzqVOJzYrObb8C0eTH0VJzsYtt4+OUyp6ZUqQL8ytPc3NNDgsT8hmeVuGZvZ301CJ
	 UZP1L8QU+YlyCol1E1BNnt8MtqEcI1gxIKQzHXEjAGPaNpj3Z5s8WU8NVMSpFX08SI
	 oi3jhxLWgz8+BnD65tLSyMP8Ay8jc/MLBPZHZQ37Io7hklrD4342qILvCHXI7TrFy0
	 KGoIrGVDSm10Q==
Date: Sun, 17 May 2026 18:52:48 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pwm: atmel-tcb: Remove unneeded semicolon
Message-ID: <agnyKRxQk5WXSTHe@monoceros>
References: <20260428075329.1234735-1-nichen@iscas.ac.cn>
 <afC3PwD0LfzYSoMP@monoceros>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6j6g6x7ouoc3jvdv"
Content-Disposition: inline
In-Reply-To: <afC3PwD0LfzYSoMP@monoceros>


--6j6g6x7ouoc3jvdv
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: atmel-tcb: Remove unneeded semicolon
MIME-Version: 1.0

Hello Chen,

On Tue, Apr 28, 2026 at 03:36:45PM +0200, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> On Tue, Apr 28, 2026 at 03:53:29PM +0800, Chen Ni wrote:
> > -		goto err_disable_clk;;
> > +		goto err_disable_clk;
>=20
> Oh, that is my fault. If you're ok I'd add
>=20
> 	This was introduced in commit 68637b68afcc ("pwm: atmel-tcb:
> 	Cache clock rates and mark chip as atomic") in Uwe's adaption of
> 	Sangyun's original patch.
>=20
> to the commit log. I'll apply it then to my fixes branch but not send it
> to Linus. But if something more urgent pops up I'll send it along.

I'd like to pick up this commit, but don't want to modify the commit log
without your consent. For now this is blocked because of that.

Best regards
Uwe

--6j6g6x7ouoc3jvdv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoJ8l0ACgkQj4D7WH0S
/k7CAwf/b87aKYE1W7nwP0lVg5qdA9c7/QmnosUwCcIbHsEe9HATaUfdvvJnbqQ5
O5NRwTPMkaLhMIfY8UbGTqXTpdd3gD6tLJFQTvTxDunJLEUu1HU6kRwn0OnZMfoP
p5z0QQH6P34Iu34FjpqG221hFZzED5aeusRjYF7F2bqzIfy1HyuO0BtH/GbFurZb
FVsjfZXg+jnIaW//rwTxL16CRDICYm8NLJ/3mRQrbEALyXPzoNJro+yZKmcmpeCG
hA/XsCznKPxIBNB6ltx5w221DFNSQVh3BPoU7MCjZGj7ePM2tI6gSgYhuF7Y5/u6
gg5A4m8KX3LfLQhMNMKpU29+XQe2GA==
=wYs6
-----END PGP SIGNATURE-----

--6j6g6x7ouoc3jvdv--
