Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB75B43F083;
	Thu, 16 Jul 2026 07:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784187960; cv=none; b=K2gjBlqtweVi2LIk2goKczJjqsY7QeNFIpkOIK+chsyuNsTpgJ6ZYvf1ugSc0m0wPi1PwGzvV6Y6i738+FT3HTkzHlPmFtvR3/mcRi1QA1qtCP2ElQKK1LHZLd9qRnrH7mw2T81rxOKCrFCVTd/0wgUdNELA+2HJ45cl1GVmkK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784187960; c=relaxed/simple;
	bh=/AqOgNXNza8/XmAmZZAWo1E+dk6FfEye0NlEPCg0GpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGqJaVp0ZLJaUFjl1t8IwuWmjjcmrMHs+Nig9J+ep5KM/sMZ+zGEYC93rpYughFB0LkTHxixchGTX4e4SaDcHSnQnIJ9c0QnZPZIfxYHuK6iXoEOT2UIYfMj4RJymPnQCwUNd7hjTV0JFt2nH6aTETG5L8gYdpM/b9sH2RU1eWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bb70/WIv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bb70/WIv"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2BF151F000E9;
	Thu, 16 Jul 2026 07:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784187959;
	bh=v5I9vyHgDl9lu88KkLOptS5YYWx8iQBQzUDlM1kZ8gM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bb70/WIvnIVqOeCbx8t7DdvU0sIQKc6bEBrF7/fZSj7XGAV7uvt/2/xFVEEBXE/P7
	 n66etQFY4lAdtsg+lBrlJNinMLp5+h2VYc9YWxz/ss0K5OM6mBhrrspY+8nnwhytGT
	 r+sCMYaEqxCum7qFKpD/T6bpmvqAqBiHwn6xBoM2Ef1C7Kz4QOAbPL76Zmm2XUyZCf
	 ip4w0rSYST/I/SvYjYJ0aB0HHgVfsm/z3wUQftdzvcVOfn++3RorswMW6e/vgVFLg1
	 zlEvVb/5MpQXj8b4ZAmM5rTGRUi45xShI22SJukEYNB5oRXcpzJFtln0T1UIV9u0we
	 rEaHGg3qHU1Zw==
Date: Thu, 16 Jul 2026 09:45:57 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-pwm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 0/2] pwm: More efficient data output in pwm_dbg_show()
Message-ID: <aliLpfmKkkwlZhzF@monoceros>
References: <3e9f9238-a0e4-4a29-8a5b-27e4a5a0e1e2@web.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xvhehlg3kc7idy5u"
Content-Disposition: inline
In-Reply-To: <3e9f9238-a0e4-4a29-8a5b-27e4a5a0e1e2@web.de>


--xvhehlg3kc7idy5u
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/2] pwm: More efficient data output in pwm_dbg_show()
MIME-Version: 1.0

Hello,

On Fri, Jun 05, 2026 at 04:22:39PM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 5 Jun 2026 16:18:19 +0200
>=20
> A few update suggestions were taken into account
> from static source code analysis.
>=20
> Markus Elfring (2):
>   Simplify data output
>   Use seq_putc() calls

I applied the 2nd patch. I don't consider the first an improvement as
the output isn't on a fast path and having the end-of-line separated
=66rom the next is logically sound.

Best regards
Uwe

--xvhehlg3kc7idy5u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpYjDEACgkQj4D7WH0S
/k4ohwgAqthCEmsDIQJJAExDDhA7dfycWH+z4APfUgmjsEVthcbFTg7UDSffFFa+
rgElAb+XeA9jrHZENJ6fiRUj3TewV/4OYbCcLLRf04GNLDel+fLUXzonocvKRvnR
0A7UxdXdG9TJai8tuvKeQArKXxJ3q0vm6LQfhAp4YlnhDnvhrqYOM3La9RJuBp0O
tUUU/iNPtqZXx7BooG2/dmSSxN9EapKabUmRTtLQ/qKu6GFbUssfgNuVGDaikVi0
PUKXOObblPtB80cfNarM4qqrUmpsf0RR3BDBxI22qEFvaErqBubIiB80MMQ+jzms
coDp9adZonUSmgeSCZnG0Mx7diznkA==
=7An9
-----END PGP SIGNATURE-----

--xvhehlg3kc7idy5u--
