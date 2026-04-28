Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E504344CAC6
	for <linux-pwm@vger.kernel.org>; Tue, 28 Apr 2026 13:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777383409; cv=none; b=YuRdrqxEOD+PLB5ryyTVWhCAKpSnf57FM30x3xwc08BS4cWg7HDwtfprYKFOYw93ZFi1oeF6ViSvLOEcjyrkZr1OArBpIdLhMEUOF+37vRgu+GZwLNZnbtcY1zdpjzTPknJNTIMvh9kr/5WlpbBShw341KPBOernFFBssJ0Kxgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777383409; c=relaxed/simple;
	bh=ziXcM10zIG3jgeIzQDi/aoC4CSPrJiUQ1hz8PWZfxDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4DBPSw1uvR1zFVfFIx2SVF4/r7kkfoXY3uzZY2eB8yGklPsJDSExzSqE5sHFzZjWs50HrXLH6FyX7vwpODUTuuB8K/Xk0FdN5O5qGIvU8FSraXwI5chPUTggjab48qaK2WpxjNsPhTpM9pIHQmx4X/cUa4b44E1XeXSL1rVtZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+2tE/4P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+2tE/4P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6256C2BCAF;
	Tue, 28 Apr 2026 13:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777383408;
	bh=ziXcM10zIG3jgeIzQDi/aoC4CSPrJiUQ1hz8PWZfxDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A+2tE/4PY3seuiUYy2ndBlmL24FhAj0R31Bb7DgQNK/xjSU0nCfDhwCiAGZ3IUsFj
	 Id+lTqy2y2RhbpZAVIXI5KUC0eI5hALNs9pDw5O2t+Zx5VPCR7l28qDWgPwTPaMhnF
	 iLMhSDLbIPKJwG0mAPVkwSIAlQ5JAAM3SgOt795KxJUc6qMPVvp0wAGuBvMdT37a4C
	 C06v5cclpreUPEd/NmVyeksC/b8eqZkEkGDyoL74BFSmk0USGydXdO55JYbC9Smxxf
	 ZCroQkzMipfZaPxPYticHmBoAm4G9AsN+CEiNcd5LXzSY1tUAVNFVMXFecUOBcyc2L
	 UFtt8LrWkSmPw==
Date: Tue, 28 Apr 2026 15:36:45 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pwm: atmel-tcb: Remove unneeded semicolon
Message-ID: <afC3PwD0LfzYSoMP@monoceros>
References: <20260428075329.1234735-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uycgzbx2kydfhzfb"
Content-Disposition: inline
In-Reply-To: <20260428075329.1234735-1-nichen@iscas.ac.cn>


--uycgzbx2kydfhzfb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] pwm: atmel-tcb: Remove unneeded semicolon
MIME-Version: 1.0

Hello,

On Tue, Apr 28, 2026 at 03:53:29PM +0800, Chen Ni wrote:
> -		goto err_disable_clk;;
> +		goto err_disable_clk;

Oh, that is my fault. If you're ok I'd add

	This was introduced in commit 68637b68afcc ("pwm: atmel-tcb:
	Cache clock rates and mark chip as atomic") in Uwe's adaption of
	Sangyun's original patch.

to the commit log. I'll apply it then to my fixes branch but not send it
to Linus. But if something more urgent pops up I'll send it along.

Thanks,
Uwe

--uycgzbx2kydfhzfb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnwt+sACgkQj4D7WH0S
/k5DHwf+JcivqTxj4XNBlJerk5DHvcsfFFRGNSpfK9inKNRDrAKH4uFaZIiU3QDM
jMJDJrQGBclkSFKoDqLZxCaE+buIW57ityE9SykOpcxcUGWcETaTz2qUONXnhIVa
z5QPl4J/RyZcRzqjxYHqBm20qe96Mwh3VIxt0mnfpjGnJPLxuw41SneSCCMLQx+j
fny+xyC4pkXZh8Jtmu6LmXL6VbvSeBWy3oc7rQX/N1+r2B7K2P9bksIT5KgWz/Q0
/qNXyCMSzmnFEmEjQcgjKoiRhWOxw2rSwSB80YurZl2nulR0RhWVZb6q8eAvt9su
oaovWejszMh/THelUrKKPNv/C2dpiQ==
=+imA
-----END PGP SIGNATURE-----

--uycgzbx2kydfhzfb--
