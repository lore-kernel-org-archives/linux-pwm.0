Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7E226B777;
	Tue, 21 Apr 2026 10:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776765790; cv=none; b=K8rAOzdE0vvrv2QId8na28zkg83r8quHw/mIwIKg7aAtNbz09HlKEsbii5IMUZObTwL4i8qSiXL/WGYVoFNegflcloeXkT8Pmy0upJMbiQsYvySwcj87AQICowTQLUIqEzQEp5TqhKpzxdeFr2NhaJ5Z1GbMCPW9DBBrOFOyiEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776765790; c=relaxed/simple;
	bh=h8bBtL8wg0AUNi1WT9ANodeYN11xYl4pCaescAzyOEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1eGGtprEaj88Z6aom+MrZU8qty7HmK9fG1YQcppvsT6SBa5DAmFmIqY39bkX7MUFT0kPQKr2zwxtVz0x9jVX3PNqcfyocWB2wUpR6dhZaHdi4cWioMd0eJNCzqDYIo5aAwz/XIXXuMeOWyndPFG/guUM3IxnBWD5S09tOhh6aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQG0/tMw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQG0/tMw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 854D1C2BCB0;
	Tue, 21 Apr 2026 10:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776765789;
	bh=h8bBtL8wg0AUNi1WT9ANodeYN11xYl4pCaescAzyOEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qQG0/tMwatxMZrEvf71uCyQ9L9h2IqZeHaeTrpd+HtygTsWrxla4333AoVfaOObGd
	 un4aFiu0wX9Mwzaqy4WnSspCp3uqT7fqE5I4HoYgKozggWKp5J4hmSFhzDGl/6tsnD
	 08M/5ZfP6ixH07O0H81frcmMLCl54ITJ4g9aMonn6nhpqV4s7qA+ICuM1XmjCzmD2U
	 cuXDgrYMyAolVFf8H6JwB3UrMAEroIXckIKD/90rReraJ0O1lD2SLVsmKpYxZj1ldF
	 R02djVEpL0WpGjxoM7DliH2WoAZnfvufo5xg9ZJnPLmCwcybrqJU8XE7YewfE6Dush
	 qSCnpr+DwD6mw==
Date: Tue, 21 Apr 2026 12:03:07 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v1 1/1] pwm: jz4740: Drop unused include
Message-ID: <aedJDX0ONKhgTD1k@monoceros>
References: <20260320220755.3237369-1-andriy.shevchenko@linux.intel.com>
 <ab3GbpMDeH9RbVOm@ashevche-desk.local>
 <aeX3oUzDqWSOTTsN@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l46nedz5l4ekkshy"
Content-Disposition: inline
In-Reply-To: <aeX3oUzDqWSOTTsN@ashevche-desk.local>


--l46nedz5l4ekkshy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/1] pwm: jz4740: Drop unused include
MIME-Version: 1.0

Hello Andy,

On Mon, Apr 20, 2026 at 12:53:37PM +0300, Andy Shevchenko wrote:
> On Sat, Mar 21, 2026 at 12:13:06AM +0200, Andy Shevchenko wrote:
> > On Fri, Mar 20, 2026 at 11:07:55PM +0100, Andy Shevchenko wrote:
> > > This driver includes the legacy header <linux/gpio.h> but does
> > > not use any symbols from it. Drop the inclusion.
> >=20
> > Sorry, this is just a 1:1 copy of the previous message sent by a mistak=
e.
> > Use whatever you want, though, they are absolutely identical (body wise=
).
>=20
> Uwe, can this be applied?

No it cannot:

	$ git checkout pwm/for-next
	...

	$ b4 am ...

	$ git am ./20260320_andriy_shevchenko_pwm_jz4740_drop_unused_include.mbx
	Applying: pwm: jz4740: Drop unused include
	error: patch failed: drivers/pwm/pwm-jz4740.c:10
	error: drivers/pwm/pwm-jz4740.c: patch does not apply
	Patch failed at 0001 pwm: jz4740: Drop unused include
	hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
	hint: When you have resolved this problem, run "git am --continue".
	hint: If you prefer to skip this patch, run "git am --skip" instead.
	hint: To restore the original branch and stop patching, run "git am --abor=
t".
	hint: Disable this message with "git config advice.mergeConflict false"

That is because I applied the patch from the other thread :-D
It's commit 8ab1fc910415 ("pwm: jz4740: Drop unused include") and
already landed in Linus' tree.

Best regards
Uwe

--l46nedz5l4ekkshy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnnS1gACgkQj4D7WH0S
/k4hJAf+N+zheM8wJ6dzvp22BGjP36cLUg7IVoYnxQdevYY3h80O6LqbnciQDPdF
mfjZ4GziW+TjiMIoqrRBD5OUML4la7iSm3bZQeR3g80wczwUqNRs5vvwu9ltqA4b
iT22l6yxSELgC2u6UAGTWqdKpLq4Y85FT20WDUvTevgX7rItkTFksd/z4SKPcp0P
WfEE9+eh1uR5jIHXfNCamiVqTNR1z/pdmK376XfTKqLfQVgBQ3Mw2NQk2eBH/vKo
G/i76kuB2/tNgo1OMlN2zILHk0CLEOoSZe9kEuCRj+I0eP/XOd0F11LH4tbijwa2
EwSISKIMfNPAPJKY4Wx3qviN2aOutw==
=PkhM
-----END PGP SIGNATURE-----

--l46nedz5l4ekkshy--
