Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9FE44E04C;
	Mon,  7 Sep 2026 09:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788774717; cv=none; b=SaeKA2fBpZeU8btRX1Qun9z4LWhZPnYanY42QbfNBo4t5HulOFO1G8AnjJIXNCwBplhVsc9SlYWO4QVJKl6ZiTY1Z/+Fd9IiZQEvEwRNYwwQ1KdaYP7H85hh+dtnnx+IMVGqG+Bl40ugkHVMzAtwsWMPJMqs9wvzLyAZ77CWnHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788774717; c=relaxed/simple;
	bh=bZeekVQBE9YlZon9Vvliwy/DhKV52lBfPfuHpmmsV9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fnc9qy86sHodxmj46iSXlZkKQo1yQS3X+0v7z+MDpARBI+ZJyQ70KY6yP3e8gqZ1LFWWAECRzzmOEYC6DusV/nprSnGdYK/RW4xzlJOKcp3EsVuebJrk27X/aYvO2ziw1xiugHk4MOGKdZY5NKDXz62Is0uNfNc/77HJal+TncA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+ziwSJT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+ziwSJT"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 364591F00A3D;
	Mon,  7 Sep 2026 09:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788774707;
	bh=94xGjJvtgFiX7cwwvmP6G4Zq0Fc+D8FQSJH9UuIdtbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O+ziwSJTC22q3RCfQUXuzOvAYi9BrSdZU9yE743Z6QaY7LuFmqYPeEJA9kqdBJTjK
	 ZALBSsnyPMsB1uCcOs+1pQ8c7qK32A70+ScYTEIqYZhqaap63YHXeAeT5wWT41bluW
	 zPKIJ6PvbuWLd7aNQMkt2ZRQFFtuGq+vYwqf9NZoL++Lmhjo9C6uiVi3qHfp1snTQ3
	 I0mrm5zRFk5PUxnk2yh+2X9Pc+2C7jpJXR5KoH8JSyHiQ6s8tl5jAT4rP7UcSi83Qi
	 KkkqB+Jk8bcTxPBjpMLP1CA78dL+XJ7E9suMKYdFJa6XFMrvViG1E5zqwtSSLkzMEa
	 LZ8fctdnAr9DA==
Date: Mon, 7 Sep 2026 11:51:45 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: kr494167@gmail.com
Cc: george.moussalem@outlook.com, quic_devipriy@quicinc.com, 
	andersson@kernel.org, baruch.siach@siklu.com, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: ipq: prevent potential 32-bit integer overflow in
 hi_div calculation
Message-ID: <ap6IbbFqQsBvVSm9@monoceros>
References: <20260724044854.33274-1-kr494167@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j34pj56bwgqgob27"
Content-Disposition: inline
In-Reply-To: <20260724044854.33274-1-kr494167@gmail.com>


--j34pj56bwgqgob27
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: ipq: prevent potential 32-bit integer overflow in
 hi_div calculation
MIME-Version: 1.0

Hello,

On Fri, Jul 24, 2026 at 10:18:54AM +0530, kr494167@gmail.com wrote:
> From: Surendra Singh Chouhan <kr494167@gmail.com>
>=20
> In ipq_pwm_get_state(), hi_div was calculated as:
>   hi_div =3D hi_dur * (pre_div + 1);
>=20
> hi_dur and (pre_div + 1) are both unsigned int (32-bit) values.
> Evaluating their multiplication using 32-bit arithmetic before assigning =
to
> the 64-bit u64 hi_div variable can overflow 32-bit unsigned math.
>=20
> While effective_div explicitly uses (u64)(pwm_div + 1) * (pre_div + 1) to
> prevent overflow, hi_div was missing the (u64) cast.
>=20
> Fix this by casting hi_dur to (u64) before multiplication, matching the
> precision used for effective_div.
>=20
> Fixes: c436e3e9c265 ("pwm: Driver for qualcomm ipq6018 pwm block")
> Signed-off-by: Surendra Singh Chouhan <kr494167@gmail.com>

Applied to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

=2E Did you find this issue by code review or does it trigger easily? If
the latter you might be able to convince me to send this patch to Linus
before 7.3.

Best regards
Uwe

--j34pj56bwgqgob27
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqeiS8ACgkQj4D7WH0S
/k557Qf+LY2Zqe4bJfS7bMDsyBtj5qhf5TsUMLj5q7neeevDrzFob8ELrLHYkM6h
ljPkSGyyiV5hNS+/WYz6F9uFUlHWhl9sUSxWR6gA6sPz1rrBM2LuT/65TVFR7lrT
jiZSBZ106vynlPZBfspmMFCzRW79ceatjjCm0qsmDt8tMSsCRD66der4ac3kufvc
dIOFiJqtrd6/Zsxyi6Ns5mtCXwc7RPlv+/6n2pAr4z9HohJJp8QysvGjcy/FYcU6
0PtPtKsGKSsLve7vwzbY9SWGObgK6YS9arPYSh5Egh4i4uQmZzAGvV9xpXeblNBW
qScuR6aBzEXkvczMMCzN4pXU6TpELw==
=In8r
-----END PGP SIGNATURE-----

--j34pj56bwgqgob27--
