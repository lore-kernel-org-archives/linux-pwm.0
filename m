Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99853932F6;
	Sun, 24 May 2026 11:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779621694; cv=none; b=a/bd+h8mFgkNaznHWyuPmW7shHtyRiABrYDP7N8vkoWMTl3x3PqWZmbsKCnmj+9654ZcNPE1aaJdpwk1mojrTBAQdvG1C7u+hyDE+Re6brZ+vunODskGlMWiicfFTB9As/3lMwEg/T8P1nPugHvOQ6f+N5alFDvasuSivO8MQ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779621694; c=relaxed/simple;
	bh=oLiSri69Now47RImuq7She4lhkBga74FFWNykITHvrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDpvPa1mZpaJ3nGhUPU320ZCUakdXP0M2h9DsgBMRAMvTn/sqd6fiSvzBKTplm4LKHJ4NvEGGCXmUV1HQlqBSqdYrvzqDr9FP6J1SF9q3Jq6c7j5tBdXZCx9+WsrhXkaCTNJDJ8o1g9bTjlhAwq698JX4ofcDwUn6LeHs6sUGWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ivt+XsYs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ivt+XsYs"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 874481F000E9;
	Sun, 24 May 2026 11:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779621692;
	bh=oLiSri69Now47RImuq7She4lhkBga74FFWNykITHvrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ivt+XsYsfCEwwRlyrk81FgW8qmN3XGVrUO4QIE49s7hLG85UWNqNJFaSnj2oNI2Ba
	 i1HR34jswIcsOXNFB3K/MjAqwzGQ79pneyvAfKAIvQfzwvTX6+dMpKQirtRaCRntgj
	 X8gg/k38ukFxyZBKSukaVZ8pP4IHopZFKAMnlQWlkvZYGl3gzaIJ9/kpC+abZ54y64
	 wAnUhPcRqaCOF6Gt5OxzSvpXai5cXSrsDJnmFwWSg4NHRMjofNGihVHDuwCwXk7txi
	 MJ+YuW8qYiRyo/oGNqnAziNoro3Kf1WmvoCaolWRJK3C0GpMPMuEOJYge820VPRPJz
	 ej0Ch+HZiwFGQ==
Date: Sun, 24 May 2026 13:21:29 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Manish Baing <manishbaing2789@gmail.com>
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	linusw@kernel.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 2/2] dt-bindings: pwm: stmpe: drop legacy binding
Message-ID: <ahLemdy7Ie9n-Ltx@monoceros>
References: <20260523173251.72540-1-manishbaing2789@gmail.com>
 <20260523173251.72540-3-manishbaing2789@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="apdghv2sfx72heyb"
Content-Disposition: inline
In-Reply-To: <20260523173251.72540-3-manishbaing2789@gmail.com>


--apdghv2sfx72heyb
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 2/2] dt-bindings: pwm: stmpe: drop legacy binding
MIME-Version: 1.0

On Sat, May 23, 2026 at 05:32:51PM +0000, Manish Baing wrote:
> The st,stmpe-pwm binding is already covered by the MFD schema
> Documentation/devicetree/bindings/mfd/st,stmpe.yaml. Remove the
> obsolete and redundant text binding file.
>=20
> Signed-off-by: Manish Baing <manishbaing2789@gmail.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
with Rob's ack from v2.

Best regards
Uwe

--apdghv2sfx72heyb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoS3zYACgkQj4D7WH0S
/k7CnQf+LrJy/swVkHwrkqPTyAvOZxezQIxQ6APF6k7/l2fout14sLJ0g7dQtpaW
nUc8cmeCXmoQkDQ/uhzxhfQBxEGXIX+p92kbur2eXOUWsErUzdPFqEQ1bxZhGb5p
clieA/lMQE/uZBoFhSlF73S9yBKoQks6s5rqTsEq6vyArWYXm74eHvrcsW+UNL17
Qsr7my0ZvgUpvRVE6F++d2SpNdtgrrjUAhq3dMqn/HnlQFoNoOxPAh7FKyg5MTyF
IduJDMP/25MrUL1hRm7XDoiP8xkbHfoHpZif0h0z1xrm8URPA4N5BvTO0hlPmgCd
pDpNs+9W5CK4XIhyssis+HaaiShrMQ==
=1Xa4
-----END PGP SIGNATURE-----

--apdghv2sfx72heyb--
