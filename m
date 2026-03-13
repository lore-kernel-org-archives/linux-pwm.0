Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E02034DCE3
	for <linux-pwm@vger.kernel.org>; Fri, 13 Mar 2026 10:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773399507; cv=none; b=i1kxy2zsZWQaMmWMBPugcbMyM043sCC1/GNbyd3GlYorvGPkDUrjIUV5QrLxZKLU8fpKUOFoqIHU5l8P3obw5DsZb/46tq/Y4ZZ4cykQl9sZnNUrFsmg5LOE9JMw642vqevSBXOdjukP4TOALWp59wK6FJMIZQ60pFouNv+8Zzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773399507; c=relaxed/simple;
	bh=34Lj9aEuWwASIusAF/p6A+RWo95PpijWJDVHObS9CJw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YX14n5Nv1g0Prp0WydPahQikXy07yH40wdCL7KvPov+lfoM7+Yuh4mIEmDyNz8gfl7SdlVIgsAWlSlKr7SPtiS70xuHIo8k8FGB+p4B6a6ksCw3jUIP9I6msdErX9KeCdPJUqFFxM9FmR/15sBJOnFWPf+PTEc0DAY7LylSJovc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTPVHhfw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTPVHhfw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0298C19421
	for <linux-pwm@vger.kernel.org>; Fri, 13 Mar 2026 10:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773399507;
	bh=34Lj9aEuWwASIusAF/p6A+RWo95PpijWJDVHObS9CJw=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=uTPVHhfwQN+WK6pQS83Luawb4NSKGKsCH3taJTufn1vuz4vzDRNAtIr1CoVIgIok2
	 cJs6WnViXxXLefqBi1PAusq6ouGRqz1OEO7njaFnrnZsJ4uxwnccqJwHLP1SbTvxdi
	 iVxb3MGqvSEuyZdKEuQg0RukWlMJ8niW51CihwngVHhhe9WLS7HxT8QUpgSC419Rw/
	 LxEYfOFE0DRYr0Vr6swzfxrz6f92HSpfxbIaE/ItSXF7SatZD7lKp8XtaOUSpteKmf
	 T5vXU/6VDMLeSLl8jZb/OysJKsdeB2VqlU3xDYGUxtLQivGGrX+C0yujsct0CME8D1
	 7nD2BVIl82Xwg==
Date: Fri, 13 Mar 2026 11:58:24 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: linux-pwm@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add #linux-pwm irc channel to pwm entry
Message-ID: <abPtr7Xcof9x145d@monoceros>
References: <20260309201954.1938136-2-ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3pmfpcjyoxudp7c3"
Content-Disposition: inline
In-Reply-To: <20260309201954.1938136-2-ukleinek@kernel.org>


--3pmfpcjyoxudp7c3
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] MAINTAINERS: Add #linux-pwm irc channel to pwm entry
MIME-Version: 1.0

Hello,

On Mon, Mar 09, 2026 at 09:19:55PM +0100, Uwe Kleine-K=F6nig wrote:
> The channel exists since quite a while, it's very low volume, so chances
> are good that I see you starting a conversation.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 55af015174a5..708c050ac397 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21337,6 +21337,7 @@ M:	Uwe Kleine-K=F6nig <ukleinek@kernel.org>
>  L:	linux-pwm@vger.kernel.org
>  S:	Maintained
>  Q:	https://patchwork.ozlabs.org/project/linux-pwm/list/
> +C:	irc://irc.libera.chat/linux-pwm
>  T:	git https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git
>  F:	Documentation/devicetree/bindings/pwm/
>  F:	Documentation/driver-api/pwm.rst

Applied to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

Best regards
Uwe

--3pmfpcjyoxudp7c3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmmz7c4ACgkQj4D7WH0S
/k7E4Af+NQQJYTzA4JP0Il8TqLUsfvgD8Jpmw6/HLZTaSUlac6Gxh+EFIC1h//1b
B2zNb98egWtBZY3ZLkUQiNjQYKKTqxxSf0nqE2qiwWUwB6HnQufFHFHlOkhQWBLu
vjjWsod8PV7akOQjriS8EoZBQ3D0264Bzl4/40D/hcscb/nxyVJ1Zo5fvW7mJgCj
zqezFMHhUME3LuQIb0waurbAqSlthAB1UdXKiLYTnHS5GOxfHnYe7l9B7e1YJ/Fy
xQx+1WfF8+FcERxneqbb2kUGZ4LO/Bu31O/zdjaYUi6B4ocNry9FO7XB1FdD3X6P
5x0nu80fMT6HdH+3U5Iyk2NJp0vkqg==
=dXsS
-----END PGP SIGNATURE-----

--3pmfpcjyoxudp7c3--
