Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2DE4446EA;
	Sat,  5 Sep 2026 08:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788596106; cv=none; b=Dugkf4dGezVgL+KCc8HT06vhSbhUS90UP+vDfQtOaeZs0JZ/MFcio9fUG8qv+ZmAYoMZuzJp047lxLpnoPAlfL4jgge3XtTdzdq+UgL05B61FKGPPSFxnsQXZLy+kTsv4xtu7Hocb+hRDdUfWtbNyM3KcW4D6zlMx4yj87WIjDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788596106; c=relaxed/simple;
	bh=Sbp//umF0jYA7r01d+Fdv0tF13lDdEn3OAOtm18gcxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lofAkc3i5pGfVGt9da5SBypYfQIgjPdmZLGkrdFj6j/igwu5aoxGHbgRJTeN9XwqSDI6fbMmhm8BAjy4n7WKmdcBl24oTzKm4u7VjzxeTScO1mPjo5K53tXdE4JHK4E9wt+YV3rL9Rzwj/05rm6taClgY1rFtzjNFiMuzQVZ1tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/prL8Rw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/prL8Rw"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id CB3E81F00A3D;
	Sat,  5 Sep 2026 08:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788596095;
	bh=Sbp//umF0jYA7r01d+Fdv0tF13lDdEn3OAOtm18gcxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M/prL8RwlI/X0+WEVxEymvLqqcKTF76EumiGYhS75o8xHRciNuELw0pS4xsaWQn+b
	 c9FpZxq0nLskeA6DdCizn4Fzivu3edP35ZPQ2LFvL7oqcF6RI7Jb7esASNkiUtTN1v
	 5L3yPiJDgTc5iPYOggWK2zthdRAUezL78SLYtAvn3CsndWBxuwZ9gn2Q4MR4Pfqd71
	 pGQqPTgxytvVX3Lfd93Mult/2EUT6ks1vsV6dIWuwkWHfGVTl0CgEMUwz9k23OzVrk
	 3qp6PISTOhbfCX485Mgp6jnwfjcWB1CH+Zb3EuTmLY2nn7dBLzkzIHT9Z2ZW69oTao
	 YVoq8YKxzh+/A==
Date: Sat, 5 Sep 2026 10:14:52 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, linux-pwm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: pwm: Fix bracket and punctuation
Message-ID: <apvPIEQoWnbZh0MP@monoceros>
References: <20260904122005.760299-2-manuelebnerli@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gafrhpx2n6quo5eh"
Content-Disposition: inline
In-Reply-To: <20260904122005.760299-2-manuelebnerli@mailbox.org>


--gafrhpx2n6quo5eh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] docs: pwm: Fix bracket and punctuation
MIME-Version: 1.0

Hello,

On Fri, Sep 04, 2026 at 02:20:04PM +0200, Manuel Ebner wrote:
> Remove needless '(' and fix comma splice.
>=20
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
> CC: Randy Dunlap <rdunlap@infradead.org>

applied with Randy's Ack to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
as 7.4-rc1 material.

Best regards
Uwe

--gafrhpx2n6quo5eh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqbz3oACgkQj4D7WH0S
/k4nZgf/Yg87XlUIwOX3uG6LLmdc1/4xbSwjbnc8YmT3kxsOh5uzuI8CDF2gwmWz
XlrHZiXKT6pPjtfM/F0INrEg/Yp1cUxVd9t9YO0AHdQPwX/RehWquoSLIbCUIYSp
ckvOq+3SSJPbtQZpXPXz/Y5XFzto61tdyETKV7u8OZC581x3SjAMQmLTrtgcL3dV
vpfwAWxFIkTFpV+ekoxHEmYfsyfnSQzRNSSz3SmKNNVO/+oHZJ7Od9SFRWsB42OU
l2I+j3MQEFe5XfzyLoP1iHlBzmIimIOwOY6RrcIHB6Z38G/f/Doyq4xBlgEHoBuL
MFr7495Afq+7hPi4Fcke8eMstIvQrQ==
=Qhni
-----END PGP SIGNATURE-----

--gafrhpx2n6quo5eh--
